-- ============================================================================
-- Inventory bridge — driven by Config.Inventory in configs/config.lua.
--
--   'auto'  — detect at boot (priority: ox > qb > qs > codem > esx)
--   'ox'    — ox_inventory
--   'qb'    — qb-inventory
--   'qs'    — qs-inventory
--   'codem' — codem-inventory
--   'esx'   — ESX legacy inventory
--
-- To add a custom inventory: add a new entry to the `bridges` table below with
-- GetItemCount / RemoveItem / AddItem functions, then set Config.Inventory to
-- the key you used.
-- ============================================================================

local bridges = {}

bridges.ox = {
    GetItemCount = function(source, itemName)
        return exports.ox_inventory:GetItemCount(source, itemName) or 0
    end,
    RemoveItem = function(source, itemName, count)
        return exports.ox_inventory:RemoveItem(source, itemName, count) and true or false
    end,
    AddItem = function(source, itemName, count)
        return exports.ox_inventory:AddItem(source, itemName, count) and true or false
    end,
}

bridges.qb = {
    GetItemCount = function(source, itemName)
        local QBCore = exports['qb-core']:GetCoreObject()
        local Player = QBCore.Functions.GetPlayer(source)
        if not Player then return 0 end
        local item = Player.Functions.GetItemByName(itemName)
        return item and item.amount or 0
    end,
    RemoveItem = function(source, itemName, count)
        local QBCore = exports['qb-core']:GetCoreObject()
        local Player = QBCore.Functions.GetPlayer(source)
        if not Player then return false end
        return Player.Functions.RemoveItem(itemName, count) and true or false
    end,
    AddItem = function(source, itemName, count)
        local QBCore = exports['qb-core']:GetCoreObject()
        local Player = QBCore.Functions.GetPlayer(source)
        if not Player then return false end
        return Player.Functions.AddItem(itemName, count) and true or false
    end,
}

bridges.qs = {
    GetItemCount = function(source, itemName)
        return exports['qs-inventory']:GetItemTotalAmount(source, itemName) or 0
    end,
    RemoveItem = function(source, itemName, count)
        return exports['qs-inventory']:RemoveItem(source, itemName, count) and true or false
    end,
    AddItem = function(source, itemName, count)
        return exports['qs-inventory']:AddItem(source, itemName, count) and true or false
    end,
}

bridges.codem = {
    GetItemCount = function(source, itemName)
        return exports['codem-inventory']:GetItemsTotalAmount(source, itemName) or 0
    end,
    RemoveItem = function(source, itemName, count)
        return exports['codem-inventory']:RemoveItem(source, itemName, count) and true or false
    end,
    AddItem = function(source, itemName, count)
        return exports['codem-inventory']:AddItem(source, itemName, count) and true or false
    end,
}

bridges.esx = {
    GetItemCount = function(source, itemName)
        local ESX = exports['es_extended']:getSharedObject()
        local xPlayer = ESX.GetPlayerFromId(source)
        if not xPlayer then return 0 end
        local item = xPlayer.getInventoryItem(itemName)
        return item and item.count or 0
    end,
    RemoveItem = function(source, itemName, count)
        local ESX = exports['es_extended']:getSharedObject()
        local xPlayer = ESX.GetPlayerFromId(source)
        if not xPlayer then return false end
        local item = xPlayer.getInventoryItem(itemName)
        if not item or item.count < count then return false end
        xPlayer.removeInventoryItem(itemName, count)
        return true
    end,
    AddItem = function(source, itemName, count)
        local ESX = exports['es_extended']:getSharedObject()
        local xPlayer = ESX.GetPlayerFromId(source)
        if not xPlayer then return false end
        local item = xPlayer.getInventoryItem(itemName)
        if not item then return false end
        if item.limit ~= -1 and (item.count + count) > item.limit then return false end
        xPlayer.addInventoryItem(itemName, count)
        return true
    end,
}

local function detectInventory()
    if GetResourceState('ox_inventory') == 'started' then return 'ox' end
    if GetResourceState('qb-inventory') == 'started' then return 'qb' end
    if GetResourceState('qs-inventory') == 'started' then return 'qs' end
    if GetResourceState('codem-inventory') == 'started' then return 'codem' end
    if GetResourceState('es_extended') == 'started' then return 'esx' end
    return 'ox'
end

local selection = (Config and Config.Inventory) or 'auto'
if selection == 'auto' or not bridges[selection] then
    selection = detectInventory()
end

Inventory = bridges[selection]
lib.print.info(('[fearx-moneywash] Inventory bridge: %s'):format(selection))
