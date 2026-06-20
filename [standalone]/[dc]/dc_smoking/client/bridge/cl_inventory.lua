Inventory = {}
local BlockInventory = Config.BlockInventory
local invType = Config.Inventory
local QBCore

if invType == 'qb' or invType == 'ps' then
    QBCore = exports['qb-core']:GetCoreObject()
end

function Inventory.GetItemCount(itemName)
    if invType == 'ox' then
        return exports.ox_inventory:Search('count', itemName) or 0
    elseif invType == 'jaksam' then
        return exports['jaksam_inventory']:getTotalItemAmount(itemName) or 0
    elseif invType == 'ak47' then
        return exports.ox_inventory:Search('count', itemName) or 0
    elseif invType == 'tgiann' then
        return exports["tgiann-inventory"]:GetItemCount(itemName) or 0
    elseif invType == 'core' then
        return exports['core_inventory']:getItemCount(itemName)
    elseif invType == 'qs' then
        local inv = exports['qs-inventory']:getUserInventory()
        local total = 0
        if inv then
            for _, item in pairs(inv) do
                if item and item.name == itemName then
                    total = total + (item.amount or item.count)
                end
            end
        end
        return total
    elseif invType == 'codem' then
        local inv = exports['codem-inventory']:GetClientPlayerInventory()
        local total = 0
        if inv then
            for _, item in pairs(inv) do
                if item and item.name == itemName then
                    total = total + (item.amount or item.count)
                end
            end
        end
        return total
    elseif invType == 'qb' or invType == 'ps' then
        local items = QBCore.Functions.GetPlayerData().items or {}
        local total = 0
        for _, item in pairs(items) do
            if item and item.name == itemName then
                total = total + (item.amount or item.count)
            end
        end
        return total
    end
    return 0
end

local function NormalizeMetadata(item)
    local meta
    if invType == 'ak47' or invType == 'tgiann' then
        meta = item.info
        if type(meta) ~= 'table' then meta = item.metadata end
    else
        meta = item.metadata
        if not meta or (type(meta) == 'table' and next(meta) == nil) then
            meta = item.info
        end
    end
    if type(meta) ~= 'table' then meta = nil end
    return meta or {}
end

local function SearchInventorySlots(inv, itemName)
    local results = {}
    if not inv then return results end
    for _, item in pairs(inv) do
        if item and item.name == itemName then
            results[#results+1] = {
                slot = tonumber(item.slot),
                name = item.name,
                count = item.amount or item.count or 1,
                metadata = NormalizeMetadata(item),
            }
        end
    end
    return results
end

function Inventory.GetItemSlots(itemName)
    if invType == 'ox' then
        return exports.ox_inventory:Search('slots', itemName) or {}
    elseif invType == 'ak47' then
        local raw = exports.ox_inventory:Search('slots', itemName) or {}
        local results = {}
        for i, item in ipairs(raw) do
            results[i] = {
                slot = tonumber(item.slot),
                name = item.name,
                count = item.amount or item.count or 1,
                metadata = NormalizeMetadata(item),
            }
        end
        return results
    elseif invType == 'tgiann' then
        return SearchInventorySlots(exports["tgiann-inventory"]:GetPlayerItems(), itemName)
    elseif invType == 'jaksam' then
        local slots = exports['jaksam_inventory']:getItemsByName(itemName)
        return SearchInventorySlots(slots, itemName)
    elseif invType == 'core' then
        return SearchInventorySlots(exports['core_inventory']:getInventory(), itemName)
    elseif invType == 'qs' then
        return SearchInventorySlots(exports['qs-inventory']:getUserInventory(), itemName)
    elseif invType == 'codem' then
        return SearchInventorySlots(exports['codem-inventory']:GetClientPlayerInventory(), itemName)
    elseif invType == 'qb' or invType == 'ps' then
        return SearchInventorySlots(QBCore.Functions.GetPlayerData().items or {}, itemName)
    end
    return {}
end

function Inventory.InvBusy(toggle)
    if BlockInventory then
        if invType == 'ox' then
            if toggle == true then
                LocalPlayer.state.invBusy = true
            elseif toggle == false then
                LocalPlayer.state.invBusy = false
            end
        elseif invType == 'tgiann' then
            LocalPlayer.state.invBusy = toggle
        elseif invType == 'jaksam' then
            if toggle == true then
                exports['jaksam_inventory']:setInventoryDisabled(true)
            elseif toggle == false then
                exports['jaksam_inventory']:setInventoryDisabled(false)
            end
        elseif invType == 'ak47' then
            if toggle == true then
                LocalPlayer.state.invBusy = true
            elseif toggle == false then
                LocalPlayer.state.invBusy = false
            end
        elseif invType == 'core' then
            if toggle == true then
                exports['core_inventory']:lockInventory()
            elseif toggle == false then
                exports['core_inventory']:unlockInventory()
            end
        elseif invType == 'qs' then
            if toggle == true then
                exports['qs-inventory']:setInventoryDisabled(true)
            elseif toggle == false then
                exports['qs-inventory']:setInventoryDisabled(false)
            end
        elseif invType == 'codem' then
            if Config.Debug then
                print('InvBusy is not supported for codem-inventory')
            end
        elseif invType == 'qb' or invType == 'ps' then
            if toggle == true then
                LocalPlayer.state:set('inv_busy', true, true)
            elseif toggle == false then
                LocalPlayer.state:set('inv_busy', false, true)
            end
        end
    end
end

function Inventory.GetImagePath()
    return Config.InventoryImagePath
end

function Inventory.GetImageFormat()
    if invType == 'tgiann' then
        return 'webp'
    else
        return 'png'
    end
end

function Inventory.RegisterItemUseHandler(callback)
    if invType == 'ox' then
        AddEventHandler('ox_inventory:usedItem', callback)
    end
end