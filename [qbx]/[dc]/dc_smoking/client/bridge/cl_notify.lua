Notify = {}

local notifySystem = Config.Notify or 'built-in'

local typeMap = {
    qb    = { info = 'primary' },
    qbox  = { info = 'inform' },
}

local function MapType(type, system)
    if typeMap[system] and typeMap[system][type] then
        return typeMap[system][type]
    end
    return type
end

function Notify.Send(msg, type)
    type = type or 'info'

    if notifySystem == 'built-in' then
        SendNUIMessage({ action = 'notify', message = msg, type = type })

    elseif notifySystem == 'ox' then
        exports.ox_lib:notify({ description = msg, type = type })

    elseif notifySystem == 'esx' then
        ESX.ShowNotification(msg, type, 5000)

    elseif notifySystem == 'qb' then
        local QBCore = exports['qb-core']:GetCoreObject()
        QBCore.Functions.Notify(msg, MapType(type, 'qb'), 5000)

    elseif notifySystem == 'qbox' then
        exports.qbx_core:Notify(msg, MapType(type, 'qbox'), 5000)

    elseif notifySystem == 'custom' then
        -- ============================================================
        -- CUSTOM NOTIFICATION SYSTEM
        -- Replace the line below with your own notification call.
        -- Parameters available:
        --   msg  (string) : The notification message text
        --   type (string) : 'error' | 'success' | 'info' | 'warning'
        -- ============================================================
        SendNUIMessage({ action = 'notify', message = msg, type = type })
    end
end
