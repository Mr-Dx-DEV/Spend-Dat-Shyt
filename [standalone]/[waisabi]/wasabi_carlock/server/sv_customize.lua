-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
if not wsb then return print((Strings.no_wsb):format(GetCurrentResourceName())) end
if Config.metadataKeys and Config.metadataKeys.enabled and not wsb.inventory then
    Config.metadataKeys.enabled = false
end
-- Do not edit above this message --
if Config.notifyPolice and Config.notifyPolice.enabled then
    RegisterNetEvent('wasabi_carlock:server:policeNotification', function(data)
        -- Modify this to your liking
        -- data = {
        --    crime = 'hotwire' or 'lockpick' or 'robPed',
        --    coords = vector3(x, y, z)
        -- }
        local src = source
        local players = GetPlayers()
        for _, playerStr in ipairs(players) do
            local player = tonumber(playerStr)
            if player and wsb.hasGroup(player, Config.notifyPolice.policeJobs) then
                TriggerClientEvent('wasabi_carlock:client:policeNotification', player, data)
            end
        end

        TriggerClientEvent('wasabi_bridge:notify', src, Strings.notify_police_notified, Strings.notify_police_notified_desc, 'info')
    end)
end



---@diagnostic disable: undefined-global
-- How keys are awarded on server start up to ensure owned keys already granted
CreateThread(function()
    while not wsb or not wsb?.framework do Wait(750) end
    if wsb.framework == 'esx' then
        MySQL.ready(function()
            MySQL.Async.fetchAll('SELECT owner, plate FROM owned_vehicles', {}, function(result)
                if result then
                    for _, v in pairs(result) do
                        if not VehicleKeys[v.owner] then VehicleKeys[v.owner] = {} end
                        VehicleKeys[v.owner][v.plate] = true
                    end
                end
            end)
        end)
    elseif wsb.framework == 'qb' then
        MySQL.ready(function()
            MySQL.Async.fetchAll('SELECT citizenid, plate FROM player_vehicles', {}, function(result)
                if result then
                    for _, v in pairs(result) do
                        if v and v.citizenid and v.plate then
                            if not VehicleKeys[v.citizenid] then VehicleKeys[v.citizenid] = {} end
                            VehicleKeys[v.citizenid][v.plate] = true
                        end
                    end
                end
            end)
        end)
    end
end)
