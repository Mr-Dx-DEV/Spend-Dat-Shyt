local found = GetResourceState('qb-inventory')
local qsFound = GetResourceState('qs-inventory')
if found ~= 'started' and found ~= 'starting' then return end
if qsFound == 'started' or qsFound == 'starting' then return end

FLBridge.inventory = FLBridge.inventory or {}
FLBridge.inventorySystem = 'qb-inventory'

local QBCore = exports['qb-core']:GetCoreObject()

OldInventory = GetResourceMetadata(FLBridge.inventorySystem, 'version', 0)
OldInventory = OldInventory:gsub('%.', '')
OldInventory = tonumber(OldInventory)
if not OldInventory or OldInventory >= 200 then OldInventory = false end

if not OldInventory then
    local registeredShops = {}
    RegisterNetEvent('filthy_bridge:registerShop', function(data)
        if source ~= '' or not GetInvokingResource() then return end

        exports['qb-inventory']:CreateShop({
            name = data.identifier,
            label = data.name,
            slots = #data.inventory,
            items = data.inventory,
            requiredJob = data.groups,
        })
        registeredShops[data.identifier] = true
    end)

    RegisterNetEvent('filthy_bridge:openShop', function(data)
        if not data or not data.identifier or not registeredShops[data.identifier] then return end

        if data.groups and not FLBridge.hasGroup(source, data.groups) then return end
        exports['qb-inventory']:OpenShop(source, data.identifier)
    end)

    RegisterNetEvent('filthy_bridge:openStash', function(data)
        local src = source
        exports['qb-inventory']:OpenInventory(src, data.name,
            { label = data.name, slots = data.slots, maxweight = data.maxWeight })
    end)

    RegisterNetEvent('filthy_bridge:openPlayerInventory', function(targetId)
        local src = source
        exports['qb-inventory']:OpenInventoryById(src, targetId)
    end)
else
    local registeredShops = {}
    AddEventHandler('filthy_bridge:registerShop', function(data)
        local invokingResource = GetInvokingResource()
        if not invokingResource then return end
        if invokingResource:sub(1, 5) ~= 'filthy' then return end
        registeredShops[data.identifier] = ConvertShopData(data)
    end)

    FLBridge.callbacks.registerServer('filthy_bridge:getShopDetails', function(_source, data)
        return registeredShops[data.identifier] or false
    end)
end

function ConvertShopData(shopData)
    local slotCounter = 0
    local convertedShop = {
        label = shopData.name,
        items = {}
    }
    
    for index, item in ipairs(shopData.inventory) do
        local itemIndex = #convertedShop.items + 1
        
        convertedShop.items[itemIndex] = {
            name = item.name,
            price = item.price,
            slot = slotCounter + 1,
            amount = 500,
            info = {}
        }
        
        slotCounter = slotCounter + 1
    end
    
    return convertedShop
end

function FLBridge.inventory.AddItem(source, item, amount, metadata)
    local success = exports['qb-inventory']:AddItem(source, item, amount, false, metadata)
    if success then
        local itemData = QBCore.Shared.Items[string.lower(item)]
        if itemData then
            TriggerClientEvent('qb-inventory:client:ItemBox', source, itemData, 'add', amount)
        end
    end
    return success
end

function FLBridge.inventory.RemoveItem(source, item, amount, slot)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return false end

    if slot then
        local success = exports['qb-inventory']:RemoveItem(source, item, amount, slot)
        if success then
            local itemData = QBCore.Shared.Items[string.lower(item)]
            if itemData then
                TriggerClientEvent('qb-inventory:client:ItemBox', source, itemData, 'remove', amount)
            end
        end
        return success
    end

    local items = Player.Functions.GetItemsByName(item)
    if not items then return false end
    if items.amount then items = { items } end

    local remaining = amount
    for _, i in pairs(items) do
        if remaining <= 0 then break end
        if type(i) == 'table' and i.amount and i.slot then
            local toRemove = math.min(remaining, tonumber(i.amount))
            if exports['qb-inventory']:RemoveItem(source, item, toRemove, i.slot) then
                remaining = remaining - toRemove
            end
        end
    end

    if remaining <= 0 then
        local itemData = QBCore.Shared.Items[string.lower(item)]
        if itemData then
            TriggerClientEvent('qb-inventory:client:ItemBox', source, itemData, 'remove', amount)
        end
        return true
    end
    return false
end

function FLBridge.inventory.GetItemCount(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return 0 end
    local items = Player.Functions.GetItemsByName(item)
    if not items then return 0 end
    if items.amount then return tonumber(items.amount) or 0 end
    local total = 0
    for _, i in pairs(items) do
        if type(i) == 'table' and i.amount then
            total = total + (tonumber(i.amount) or 0)
        end
    end
    return total
end

function FLBridge.inventory.HasItem(source, item, amount)
    return FLBridge.inventory.GetItemCount(source, item) >= (amount or 1)
end

function FLBridge.inventory.CanCarryItem(source, item, amount)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return false end
    local totalWeight = 0
    local items = Player.PlayerData.items or {}
    for _, i in pairs(items) do
        if type(i) == 'table' and i.weight and i.amount then
            totalWeight = totalWeight + (i.weight * i.amount)
        end
    end
    local itemData = QBCore.Shared.Items[string.lower(item)]
    if not itemData then return true end
    local addedWeight = (itemData.weight or 0) * amount
    return (totalWeight + addedWeight) <= 120000
end

function FLBridge.inventory.GetInventory(source)
    local Player = QBCore.Functions.GetPlayer(source)
    return Player and Player.PlayerData.items or {}
end

function FLBridge.inventory.GetItemBySlot(source, slot)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return nil end
    local items = Player.PlayerData.items or {}
    return items[slot] or nil
end

function FLBridge.inventory.SetItemMetadata(source, slot, metadata)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return false end
    local item = Player.Functions.GetItemBySlot(slot)
    if not item then return false end
    item.info = metadata
    Player.PlayerData.items[slot] = item
    Player.Functions.SetPlayerData("items", Player.PlayerData.items)
    return true
end

function FLBridge.inventory.ClearInventory(source, keepItems)
    exports['qb-inventory']:ClearInventory(source, keepItems)
end

function FLBridge.inventory.OpenStash(source, stashId, stashData)
    stashData = stashData or { slots = 50, weight = 100000 }
    exports['qb-inventory']:OpenInventory(source, stashId, {
        maxweight = stashData.weight,
        slots = stashData.slots
    })
end

function FLBridge.inventory.RegisterStashes(stashes)
    
end

function FLBridge.inventory.RegisterStash(stashId, label, slots, weight)
   
end
 
function FLBridge.inventory.GetStashItemCount(stashId, item)
    local result = MySQL.scalar.await(
        'SELECT items FROM inventories WHERE identifier = ?',
        { stashId }
    )
    if not result then return 0 end
    local items = json.decode(result) or {}
    local total  = 0
    for _, slot in pairs(items) do
        if type(slot) == 'table' and slot.name == item then
            total = total + (tonumber(slot.amount) or 0)
        end
    end
    return total
end
 
function FLBridge.inventory.AddToStash(stashId, item, amount, metadata)
    local result = MySQL.scalar.await(
        'SELECT items FROM inventories WHERE identifier = ?',
        { stashId }
    )
    local items  = result and json.decode(result) or {}
    local placed = false
 
    for _, slot in pairs(items) do
        if type(slot) == 'table' and slot.name == item then
            slot.amount = (tonumber(slot.amount) or 0) + amount
            placed = true
            break
        end
    end
 
    if not placed then
        local nextSlot = 1
        while items[tostring(nextSlot)] or items[nextSlot] do
            nextSlot = nextSlot + 1
        end
        items[tostring(nextSlot)] = {
            name   = item,
            amount = amount,
            info   = metadata or {},
            slot   = nextSlot,
        }
    end
 
    MySQL.insert(
        'INSERT INTO inventories (identifier, items) VALUES (?, ?) ON DUPLICATE KEY UPDATE items = ?',
        { stashId, json.encode(items), json.encode(items) }
    )
    return true
end
 
function FLBridge.inventory.RemoveFromStash(stashId, item, amount)
    local result = MySQL.scalar.await(
        'SELECT items FROM inventories WHERE identifier = ?',
        { stashId }
    )
    if not result then return false end
 
    local items     = json.decode(result) or {}
    local remaining = amount
 
    for key, slot in pairs(items) do
        if remaining <= 0 then break end
        if type(slot) == 'table' and slot.name == item then
            local available = tonumber(slot.amount) or 0
            if available <= remaining then
                items[key]  = nil
                remaining   = remaining - available
            else
                slot.amount = available - remaining
                remaining   = 0
            end
        end
    end
 
    MySQL.insert(
        'INSERT INTO inventories (identifier, items) VALUES (?, ?) ON DUPLICATE KEY UPDATE items = ?',
        { stashId, json.encode(items), json.encode(items) }
    )
    return remaining <= 0
end
 