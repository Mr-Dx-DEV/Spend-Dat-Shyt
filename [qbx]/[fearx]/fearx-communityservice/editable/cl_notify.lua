--[[
    NOTIFICATION SYSTEM
    Customize how notifications are displayed to the player.

    Default: ox_lib notifications
    You can replace the contents of this function with any notification system you use.

    Examples:
        -- ox_lib (default)
        lib.notify({ title = Config.Notifications.title, description = message, type = type or 'info' })

        -- ESX
        exports['es_extended']:getSharedObject().ShowNotification(message)

        -- QB-Core
        exports['qb-core']:GetCoreObject().Functions.Notify(message, type)

        -- okokNotify
        exports['okokNotify']:Alert('Community Service', message, 5000, type or 'info')

        -- mythic_notify
        exports['mythic_notify']:SendAlert('inform', message, 5000)

        -- pNotify
        exports['pNotify']:SendNotification({ text = message, type = type or 'info', timeout = 5000 })

        -- GTA native (no dependency)
        BeginTextCommandThefeedPost('STRING')
        AddTextComponentSubstringPlayerName(message)
        EndTextCommandThefeedPostTicker(false, false)
]]

function CustomNotify(message, type)
    if GetResourceState('ox_lib') == 'started' then
        lib.notify({
            title = Config.Notifications.title,
            description = message,
            type = type or 'info'
        })
    else
        BeginTextCommandThefeedPost('STRING')
        AddTextComponentSubstringPlayerName(message)
        EndTextCommandThefeedPostTicker(false, false)
    end
end
