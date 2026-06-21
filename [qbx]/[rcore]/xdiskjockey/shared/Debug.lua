if Config.GeneralDebug then
    local AddEventHandler_ = AddEventHandler
    local RegisterNetEvent_ = RegisterNetEvent
    local CreateThread_ = CreateThread
    local RegisterCommand_ = RegisterCommand
    local RegisterNUICallback_ = RegisterNUICallback

    -- replacement for AddEventHandler
    function RegisterNUICallback(eventName, eventRoutine)
        RegisterNUICallback_(eventName, function(retEvent, retId, refId, a1, a2, a3, a4, a5, a6, a7, a8, a9)
            local status, err = xpcall(function()
                eventRoutine(retEvent, retId, refId, a1, a2, a3, a4, a5, a6, a7, a8, a9)
            end, debug.traceback)
            if not status then
                print(err, "^2RegisterNUICallback^0", "^1" .. eventName .. "^0")
            end
        end)
    end

    -- replacement for AddEventHandler
    function RegisterCommand(eventName, eventRoutine)
        RegisterCommand_(eventName, function(source, args, rawCommand)
            local status, err = xpcall(function()
                eventRoutine(source, args, rawCommand)
            end, debug.traceback)
            if not status then
                print(err, "^2RegisterCommand^0", "^1" .. eventName .. "^0")
            end
        end)
    end

    -- replacement for CreateThread
    function CreateThread(methodFunction, name)
        if not name then
            name = "non defined"
        end
        CreateThread_(function()
            local status, err = xpcall(methodFunction, debug.traceback)
            if not status then
                print(err, "^2CreateThread^0", "^1" .. name .. "^0")
            end
        end)
    end

    -- replacement for AddEventHandler
    function AddEventHandler(eventName, eventRoutine)
        AddEventHandler_(eventName, function(retEvent, retId, refId, a1, a2, a3, a4, a5, a6, a7, a8, a9)
            local status, err = xpcall(function()
                eventRoutine(retEvent, retId, refId, a1, a2, a3, a4, a5, a6, a7, a8, a9)
            end, debug.traceback)
            if not status then
                print(err, "^2AddEventHandler^0", "^1" .. eventName .. "^0")
            end
        end)
    end

    -- replacement for RegisterNetEvent
    function RegisterNetEvent(eventName, eventRoutine)
        if eventRoutine then
            RegisterNetEvent_(eventName, function(retEvent, retId, refId, a1, a2, a3, a4, a5, a6, a7, a8, a9)
                local status, err = xpcall(function()
                    eventRoutine(retEvent, retId, refId, a1, a2, a3, a4, a5, a6, a7, a8, a9)
                end, debug.traceback)
                if not status then
                    print(err, "^2RegisterNetEvent^0", "^1" .. eventName .. "^0")
                end
            end)
        else
            RegisterNetEvent_(eventName)
        end
    end
end