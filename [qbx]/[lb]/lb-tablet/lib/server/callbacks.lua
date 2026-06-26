local CALLBACK_TIMEOUT <const> = 15

---@type { [number]: { cb: fun(...), event: string } }
local waitingCallbacks = {}

---@type { [string]: EventHandler }
local registeredCallbacks = {}

---<b>Key:</b> Source<br><b>Value:</b> Lookup table of callbacks that have been triggered
---@type { [number]: { [string]: boolean } }
local triggeredCallbacks = {}

---<b>Key:</b> Resource name<br><b>Value:</b> Array of callbacks that have been registered by the resource
---@type { [string]: string[] }
local exportCallbacks = {}

---@param event string
---@param source number
local function TriggerSafeClientEvent(event, source, ...)
    local payload = msgpack.pack_args(...)
    local length = #payload

    if length > 64000 then
        debugprint("Using latent event for " .. event .. " due to payload size: " .. length)

        ---@diagnostic disable-next-line: param-type-mismatch
        TriggerLatentClientEventInternal(event, source, payload, length, 10^6)
    else
        ---@diagnostic disable-next-line: param-type-mismatch
        TriggerClientEventInternal(event, source, payload, length)
    end
end

---@param requestId number
---@param ... any
RegisterNetEvent("lb-tablet:cb:response", function(requestId, ...)
    local callback = waitingCallbacks[requestId]

    if callback then
        local success, errorMessage = pcall(callback.cb, ...)

        if not success then
            local stackTrace = Citizen.InvokeNative(`FORMAT_STACK_TRACE` & 0xFFFFFFFF, nil, 0, Citizen.ResultAsString())

            print(("^1SCRIPT ERROR: Callback response '%s' failed: %s^7\n%s"):format(callback.event, errorMessage or "", stackTrace or ""))
        end

        waitingCallbacks[requestId] = nil
    end
end)

local function GenerateRequestId()
    local requestId = math.random(999999999)

    while waitingCallbacks[requestId] do
        requestId = math.random(999999999)
    end

    return requestId
end

---@param event string
---@param source number
---@param cb fun(...)
function TriggerClientCallback(event, source, cb, ...)
    local requestId = GenerateRequestId()

    waitingCallbacks[requestId] = { cb = cb, event = event }

    SetTimeout(CALLBACK_TIMEOUT * 1000, function()
        if waitingCallbacks[requestId] then
            infoprint("error", ("Client callback ^1%s^7 timed out after %is. Triggered on %i"):format(event, CALLBACK_TIMEOUT, source))

            waitingCallbacks[requestId].cb()
            waitingCallbacks[requestId] = nil
        end
    end)

    TriggerSafeClientEvent("lb-tablet:cb:" .. event, source, requestId, ...)
end

exports("TriggerClientCallback", TriggerClientCallback)

---@param event string
---@param source number
---@param ... any
---@return ...
function AwaitClientCallback(event, source, ...)
    local responsePromise = promise.new()

    TriggerClientCallback(event, source, function(...)
        responsePromise:resolve({ ... })
    end, ...)

    local result = Citizen.Await(responsePromise)

    return table.unpack(result)
end

exports("AwaitClientCallback", AwaitClientCallback)

---@param event string
---@param handler fun(source: number, ...) : any
---@param antiSpam? boolean
---@param defaultReturn? any
function RegisterCallback(event, handler, antiSpam, defaultReturn)
    assert(type(event) == "string", "callback must be a string")
    assert(registeredCallbacks[event] == nil, ("callback '%s' is already registered"):format(event))

    registeredCallbacks[event] = RegisterNetEvent("lb-tablet:cb:" .. event, function(requestId, ...)
        local src = source

        if antiSpam then
            if not triggeredCallbacks[src] then
                triggeredCallbacks[src] = {}
            end

            if triggeredCallbacks[src][event] then
                debugprint(src, "has already triggered callback", event)
                TriggerClientEvent("lb-tablet:cb:response", src, requestId, defaultReturn)

                return
            end

            triggeredCallbacks[src][event] = true
        end

        local params = { ... }
        local startTime = os.nanotime()

        local success, errorMessage = pcall(function()
            TriggerSafeClientEvent("lb-tablet:cb:response", src, requestId, handler(src, table.unpack(params)))

            local finishTime = os.nanotime()

            debugprint(("Callback ^5%s^7 took %s"):format(event, FormatNanoSeconds(finishTime - startTime)))
        end)

        if not success then
            local stackTrace = Citizen.InvokeNative(`FORMAT_STACK_TRACE` & 0xFFFFFFFF, nil, 0, Citizen.ResultAsString())

            print(("^1SCRIPT ERROR: Callback '%s' failed: %s^7\n%s"):format(event, errorMessage or "", stackTrace or ""))
            TriggerClientEvent("lb-tablet:cb:response", src, requestId, defaultReturn)
        end

        if antiSpam and triggeredCallbacks[src] then
            triggeredCallbacks[src][event] = nil
        end
    end) --[[@as EventHandler]]
end

---@param event string
---@param handler fun(source: number, tabletId: string, ...) : any
---@param defaultReturn any
---@param antiSpam? boolean
function BaseCallback(event, handler, defaultReturn, antiSpam)
    RegisterCallback(event, function(source, ...)
        local tabletId = GetEquippedTablet(source)

        if not tabletId then
            debugprint(("^1%s^7: no tablet found for %s | %s"):format(event, GetPlayerName(source), source))
            return defaultReturn
        end

        return handler(source, tabletId, ...)
    end, antiSpam, defaultReturn)
end

---@class MDTCallbackOptions
---@field antiSpam? boolean
---@field permissions? { [string]: string | string[] }
---@field defaultReturn? any

---@param event string
---@param callback fun(source: number, tabletId: string, mdt: string, permissions: { [string]: { [string]: boolean } }, ...) : any
---@param options? MDTCallbackOptions
function RegisterMDTCallback(event, callback, options)
    local antiSpam = false

    options = options or {}

    if options.antiSpam then
        antiSpam = true
    end

    BaseCallback("mdt:" .. event, function(source, tabletId, mdt, ...)
        local permissions = GetMDTPermissions(mdt, source)

        if not permissions then
            debugprint(source, "does not have access to MDT", mdt)
            return
        end

        if options.permissions then
            for tabId, permissionKey in pairs(options.permissions) do
                if type(permissionKey) == "table" then
                    for i = 1, #permissionKey do
                        if not permissions[tabId] or not permissions[tabId][permissionKey][i] then
                            debugprint(source, "lacks permission", permissions[tabId][permissionKey][i], "for tab", tabId, "on MDT", mdt, permissions)
                            return
                        end
                    end
                else
                    if not permissions[tabId] or not permissions[tabId][permissionKey] then
                        debugprint(source, "lacks permission", permissionKey, "for tab", tabId, "on MDT", mdt, permissions)
                        return
                    end
                end
            end
        end

        return callback(source, tabletId, mdt, permissions, ...)
    end, options.defaultReturn, antiSpam)
end

---@param resource string
---@param event string
---@return boolean
local function CanResourceRegisterCallback(resource, event)
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

    return true
end

---@param event string
---@param handler fun(source: number, ...) : any
---@param defaultReturn any
---@param antiSpam? boolean
exports("RegisterCallback", function(event, handler, antiSpam, defaultReturn)
    local resource = GetInvokingResource()

    if CanResourceRegisterCallback(resource, event) then
        RegisterCallback(event, handler, antiSpam, defaultReturn)
    end
end)

---@param event string
---@param handler fun(source: number, tabletId: string, ...) : any
---@param defaultReturn any
---@param antiSpam? boolean
exports("BaseCallback", function(event, handler, defaultReturn, antiSpam)
    local resource = GetInvokingResource()

    if CanResourceRegisterCallback(resource, event) then
        BaseCallback(event, handler, defaultReturn, antiSpam)
    end
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
