-- bridge/stress.lua
-- This file is open-source and allows you to customize the stress effects of vaping.
-- You can write your own Lua code directly inside the functions below.

--- This function is triggered from the server when a player uses a vape.
--- @param source number The player's server ID.
function OnVapePuff(source)
    -- Server owners should add their stress logic here.
    -- The 'source' variable is the player's server ID.

    -- Example for QBCore:
    --[[
    local Player = exports['qb-core']:GetCoreObject().Functions.GetPlayer(source)
    if Player then
        local amount = 10
        Player.Functions.SetMetaData("stress", Player.PlayerData.metadata["stress"] - amount)
        TriggerClientEvent('hud:client:UpdateStress', source, Player.PlayerData.metadata["stress"])
        print(('[mic_vape] Stress for player %s reduced by %s.'):format(source, amount))
    end
    --]]

    -- Example for ESX:
    --[[
    local xPlayer = exports.es_extended:getSharedObject().GetPlayerFromId(source)
    if xPlayer then
        -- Note: esx_status events are often handled on the client.
        -- You might need to trigger a client event from here if direct server-side manipulation isn't available.
        TriggerClientEvent('esx_status:add', source, 'stress', -10000)
        print(('[mic_vape] Sent stress reduction event to player %s.'):format(source))
    end
    --]]

    print(('[mic_vape] OnVapePuff triggered for source %s. Add your custom logic to bridge/stress.lua'):format(source))
end
