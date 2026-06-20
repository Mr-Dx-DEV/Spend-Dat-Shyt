local config = require 'config.shared'

function DebugMode(...) -- dont touch
    if config.debug.enable then
        print(...)
    end
end

-- get framework
if config.framework == 'esx' then
    ESX = exports['es_extended']:getSharedObject()
    --[[
    ESX = nil
    CreateThread(function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Wait(1)
        end
    end)
    ]]
elseif config.framework == 'qb' then
    QBCore = exports['qb-core']:GetCoreObject()
else
    -- your custom framework here
    return
end

-- send server side notifications
function ServerNotify(source, message)
    TriggerClientEvent('SOS:showNotification', source, message)
end

-- get player from source
function GetPlayer(source)
    if config.framework == 'esx' then
        return ESX.GetPlayerFromId(source)
    elseif config.framework == 'qb' then
        return QBCore.Functions.GetPlayer(source)
    else
        -- your custom framework here
    end
end

-- get player source from source
function GetPlayerSource(source)
    if config.framework == 'esx' then
        return ESX.GetPlayerFromId(source).source
    elseif config.framework == 'qb' then
        return QBCore.Functions.GetPlayer(source).PlayerData.source
    else
        -- your custom framework here
    end
end

-- get identifier player from source
function GetIdentifierPlayer(source)
    if config.framework == 'esx' then
        --return ESX.GetPlayerFromId(source).identifier
        return ESX.GetPlayerFromId(source).getIdentifier()
    elseif config.framework == 'qb' then
        if not QBCore.Functions.GetPlayer(source) then return end
        return QBCore.Functions.GetPlayer(source).PlayerData.citizenid
    else
        -- your custom framework here
    end
end

-- get name player from source
function GetNamePlayer(source)
    if config.framework == 'esx' then
        return ESX.GetPlayerFromId(source).getName()
    elseif config.framework == 'qb' then
        return QBCore.Functions.GetPlayer(source).PlayerData.charinfo.firstname .. ' ' .. QBCore.Functions.GetPlayer(source).PlayerData.charinfo.lastname
    else
        -- your custom framework here
    end
end

-- count an item to inventory
function HasItem(source, item)
    if not source or not item then return 0 end
    local player = GetPlayer(source)
    if not player then return 0 end

    if config.inventory == 'ox_inventory' then
        return exports['ox_inventory']:Search(source, 'count', item) or 0
    elseif config.inventory == 'esx' then
        local itemData = player.getInventoryItem(item)
        if not itemData then return 0 end
        return itemData.count or itemData.amount or 0
    elseif config.inventory == 'qb' then
        local itemData = player.Functions.GetItemByName(item)
        if not itemData then return 0 end
        return itemData.amount or itemData.count or 0
    else
        -- your custom framework here
    end
    return 0
end

-- add an item to inventory
function AddItem(source, item, count, slot, metadata)
    local player = GetPlayer(source)
    if config.inventory == 'ox' then
        return exports.ox_inventory:AddItem(source, item, count, metadata, slot)
    elseif config.inventory == 'esx' then
        return player.addInventoryItem(item, count, metadata, slot)
    elseif config.inventory == 'qb' then
        player.Functions.AddItem(item, count, slot, metadata)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[item], 'add')
    else
        -- your custom framework here
    end
end

-- remove an item from inventory
function RemoveItem(source, item, count, slot, metadata)
    local player = GetPlayer(source)
    if config.inventory == 'ox' then
        return exports.ox_inventory:RemoveItem(source, item, count, metadata, slot)
    elseif config.inventory == 'esx' then
        return player.removeInventoryItem(item, count, metadata, slot)
    elseif config.inventory == 'qb' then
        player.Functions.RemoveItem(item, count, slot, metadata)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[item], 'remove')
    else
        -- your custom inventory here
    end
end

-- registerusableitem function
function RegisterUsableItem(itemName, cb)
    if config.framework == 'esx' then
        ESX.RegisterUsableItem(itemName, cb)
    elseif config.framework == 'qb' then
        QBCore.Functions.CreateUseableItem(itemName, cb)
    else
        -- your framework inventory here
    end
end