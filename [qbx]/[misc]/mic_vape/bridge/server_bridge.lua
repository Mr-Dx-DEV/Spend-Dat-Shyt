-- bridge/server_bridge.lua
-- This file is open-source and allows you to customize the server-side logic.

-- Framework detection
local Framework = nil
if GetResourceState('es_extended') == 'started' then
    Framework = exports["es_extended"]:getSharedObject()
elseif GetResourceState('qb-core') == 'started' then
    Framework = exports['qb-core']:GetCoreObject()
end

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

    print(('[mic_vape] OnVapePuff triggered for source %s. Add your custom logic to bridge/server_bridge.lua'):format(source))
end

-- Evento para recargar las armas del jugador
RegisterNetEvent('esx_vape:reloadWeapons')
AddEventHandler('esx_vape:reloadWeapons', function()
    local src = source
    if Framework then
        if GetResourceState('es_extended') == 'started' then
            local xPlayer = Framework.GetPlayerFromId(src)
            for k, v in ipairs(xPlayer.getLoadout()) do
                xPlayer.removeWeapon(v.name)
                xPlayer.addWeapon(v.name, v.ammo)
            end
        elseif GetResourceState('qb-core') == 'started' then
            local Player = Framework.Functions.GetPlayer(src)
            local loadout = Player.PlayerData.items
            for _, item in pairs(loadout) do
                if item.type == 'weapon' then
                    Player.Functions.RemoveItem(item.name, 1)
                    Player.Functions.AddItem(item.name, 1, false, { ammo = item.info.ammo })
                end
            end
        end
    end
end)

-- Evento para eliminar el item de vape cuando se alcanza el límite de caladas
RegisterNetEvent('esx_vape:removeVapeItem')
AddEventHandler('esx_vape:removeVapeItem', function(vapeName)
    local src = source
    if Framework then
        if GetResourceState('es_extended') == 'started' then
            local xPlayer = Framework.GetPlayerFromId(src)
            xPlayer.removeInventoryItem(vapeName, 1)
            TriggerClientEvent('esx_vape:forceRemoveVape', src, vapeName)
        elseif GetResourceState('qb-core') == 'started' then
            local Player = Framework.Functions.GetPlayer(src)
            Player.Functions.RemoveItem(vapeName, 1)
            TriggerClientEvent('esx_vape:forceRemoveVape', src, vapeName)
        end
    end
end)

-- Evento para verificar el inventario y forzar la eliminación del vape si no está en el inventario
RegisterNetEvent('esx_vape:checkInventory')
AddEventHandler('esx_vape:checkInventory', function(vapeName)
    local src = source
    if Framework then
        if GetResourceState('es_extended') == 'started' then
            local xPlayer = Framework.GetPlayerFromId(src)
            local item = xPlayer.getInventoryItem(vapeName)
            if not item or item.count == 0 then
                TriggerClientEvent('esx_vape:forceRemoveVape', src, vapeName)
            end
        elseif GetResourceState('qb-core') == 'started' then
            local Player = Framework.Functions.GetPlayer(src)
            local item = Player.Functions.GetItemByName(vapeName)
            if not item then
                TriggerClientEvent('esx_vape:forceRemoveVape', src, vapeName)
            end
        end
    end
end)
