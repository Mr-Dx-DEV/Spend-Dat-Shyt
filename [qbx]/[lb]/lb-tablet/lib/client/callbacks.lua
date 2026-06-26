local CALLBACK_TIMEOUT <const> = 120

---@type { [string]: EventHandler }
local registeredCallbacks = {}

---<b>Key:</b> Resource name<br><b>Value:</b> Array of callbacks that have been registered by the resource
---@type { [string]: string[] }
local exportCallbacks = {}

---@type { [number]: { cb: fun(...), event: string } }
local waitingCallbacks = {}

local function GenerateRequestId()
    local requestId = math.random(999999999)

    while waitingCallbacks[requestId] do
        requestId = math.random(999999999)
    end

    return requestId
end

---@param event string
local function TriggerSafeServerEvent(event, ...)
    local payload = msgpack.pack_args(...)
    local length = #payload

    if length > 64000 then
        debugprint("Using latent event for " .. event .. " due to payload size: " .. length)

        ---@diagnostic disable-next-line: param-type-mismatch
        TriggerLatentServerEventInternal(event, payload, length, 10^6)
    else
        ---@diagnostic disable-next-line: param-type-mismatch
        TriggerServerEventInternal(event, payload, length)
    end
end

---@param event string
---@param cb fun(...): any
---@param ... any
function TriggerCallback(event, cb, ...)
    local requestId = GenerateRequestId()

    waitingCallbacks[requestId] = { cb = cb, event = event }

    SetTimeout(CALLBACK_TIMEOUT * 1000, function()
        if waitingCallbacks[requestId] then
            infoprint("error", ("Callback ^1%s^7 timed out after %is"):format(event, CALLBACK_TIMEOUT))
            waitingCallbacks[requestId].cb(nil)
            waitingCallbacks[requestId] = nil
        end
    end)

    TriggerSafeServerEvent("lb-tablet:cb:" .. event, requestId, ...)
end

exports("TriggerCallback", TriggerCallback)

---@param event string
---@param ... any
---@return ...
function AwaitCallback(event, ...)
    local responsePromise = promise.new()

    TriggerCallback(event, function(...)
        responsePromise:resolve({ ... })
    end, ...)

    local result = Citizen.Await(responsePromise)

    return table.unpack(result)
end

exports("AwaitCallback", AwaitCallback)

---@param requestId number
RegisterNetEvent("lb-tablet:cb:response", function(requestId, ...)
    local callback = waitingCallbacks[requestId]

    if callback then
        local success, errorMessage = pcall(callback.cb, ...)

        if not success then
            local stackTrace = Citizen.InvokeNative(`FORMAT_STACK_TRACE` & 0xFFFFFFFF, nil, 0, Citizen.ResultAsString())

            print(("^1SCRIPT ERROR: Callback '%s' failed: %s^7\n%s"):format(callback.event, errorMessage or "", stackTrace or ""))
        end

        waitingCallbacks[requestId] = nil
    end
end)

---@param event string
---@param handler fun(...) : ...any
function RegisterClientCallback(event, handler)
    assert(type(event) == "string", "event must be a string")
    assert(registeredCallbacks[event] == nil, ("event '%s' is already registered"):format(event))

    registeredCallbacks[event] = RegisterNetEvent("lb-tablet:cb:" .. event, function(requestId, ...)
        local params = { ... }
        local startTime = GetGameTimer()

        local success, errorMessage = pcall(function()
            TriggerSafeServerEvent("lb-tablet:cb:response", requestId, handler(table.unpack(params)))

            local ms = GetGameTimer() - startTime

            debugprint(("Callback ^5%s^7 took %ims"):format(event, ms))
        end)

        if not success then
            local stackTrace = Citizen.InvokeNative(`FORMAT_STACK_TRACE` & 0xFFFFFFFF, nil, 0, Citizen.ResultAsString())

            print(("^1SCRIPT ERROR: Client callback '%s' failed: %s^7\n%s"):format(event, errorMessage or "", stackTrace or ""))
        end
    end) --[[@as EventHandler]]
end

---@param event string
---@param handler fun(...) : ...any
exports("RegisterClientCallback", function(event, handler)
    local resource = GetInvokingResource()

    if registeredCallbacks[event] then
        infoprint("error", ("Callback '%s' is already registered"):format(event))

        return false
    end

    if not exportCallbacks[resource] then
        exportCallbacks[resource] = {}
    end

    if table.contains(exportCallbacks[resource], event) then
        infoprint("error", ("Callback '%s' is already registered by resource '%s'"):format(event, resource))

        return false
    end

    table.insert(exportCallbacks[resource], event)

    RegisterClientCallback(event, handler)
end)

---@param resource string
AddEventHandler("onResourceStop", function(resource)
    local callbacks = exportCallbacks[resource]

    if not callbacks then
        return
    end

    for i = 1, #callbacks do
        local event = callbacks[i]
        local eventHandler = registeredCallbacks[event]

        if eventHandler then
            RemoveEventHandler(eventHandler)
        end

        registeredCallbacks[event] = nil
    end

    exportCallbacks[resource] = nil
end)
