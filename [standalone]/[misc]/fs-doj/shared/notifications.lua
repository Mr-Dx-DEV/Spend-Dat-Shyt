-- MIT License
-- fs-doj Notifications Module
-- Multi-framework notification support

Notify = {}

if IsDuplicityVersion() then
    -- Server-side
    function Notify.Send(source, data)
        TriggerClientEvent('doj:notify', source, data)
    end

    function Notify.SendToJob(job, data)
        local players = FrameworkAdapter.GetPlayersWithJob(job)
        for _, playerId in ipairs(players) do
            Notify.Send(playerId, data)
        end
    end

    -- Exports
    exports('Notify', Notify.Send)
    exports('NotifyJob', Notify.SendToJob)
else
    -- Client-side
    function Notify.Send(data)
        -- Try ox_lib first
        if lib then
            lib.notify({
                title = data.title or 'DOJ',
                description = data.message or data.description,
                type = data.type or 'info',
                duration = data.duration or Config.NotificationSettings.duration,
                position = data.position or Config.NotificationSettings.position,
                icon = data.icon,
                iconColor = data.iconColor
            })
            return
        end

        -- Fallback to framework
        if FrameworkName == 'esx' then
            ESX.ShowNotification(data.message, data.type, data.duration)
        elseif FrameworkName == 'qb' or FrameworkName == 'qbox' then
            QBCore.Functions.Notify(data.message, data.type, data.duration)
        else
            -- Generic fallback
            print('[DOJ] ' .. (data.title or '') .. ': ' .. (data.message or ''))
        end
    end

    -- Client event listener
    RegisterNetEvent('doj:notify', function(data)
        Notify.Send(data)
    end)

    -- Exports
    exports('Notify', Notify.Send)
end

return Notify
