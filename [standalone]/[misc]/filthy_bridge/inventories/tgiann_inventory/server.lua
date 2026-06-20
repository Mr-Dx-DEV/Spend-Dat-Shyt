local found = GetResourceState('tgiann-inventory')
if found ~= 'started' and found ~= 'starting' then return end

FLBridge.inventory = FLBridge.inventory or {}
FLBridge.inventorySystem = 'tgiann-inventory'

function FLBridge.inventory.AddItem(source, item, amount, metadata)
    return exports['tgiann-inventory']:AddItem(source, item, amount, metadata)
end

function FLBridge.inventory.RemoveItem(source, item, amount, slot)
    return exports['tgiann-inventory']:RemoveItem(source, item, amount, slot)
end

function FLBridge.inventory.GetItemCount(source, item)
    return exports['tgiann-inventory']:GetItemCount(source, item) or 0
end

function FLBridge.inventory.HasItem(source, item, amount)
    return FLBridge.inventory.GetItemCount(source, item) >= (amount or 1)
end

function FLBridge.inventory.CanCarryItem(source, item, amount)
    return exports['tgiann-inventory']:CanCarryItem(source, item, amount)
end

function FLBridge.inventory.GetInventory(source)
    return exports['tgiann-inventory']:GetInventory(source) or {}
end

function FLBridge.inventory.GetItemBySlot(source, slot)
    local inventory = exports['tgiann-inventory']:GetInventory(source) or {}
    return inventory[slot] or nil
end

function FLBridge.inventory.OpenStash(source, stashId, stashData)
    exports['tgiann-inventory']:OpenInventory(source, 'stash', stashId)
end

function FLBridge.inventory.RegisterStashes(stashes)
    for _, stash in ipairs(stashes) do
        exports['tgiann-inventory']:RegisterStash(stash.id, stash.label, stash.slots, stash.weight)
    end
end


function FLBridge.inventory.RegisterStash(stashId, label, slots, weight)
    exports['tgiann-inventory']:RegisterStash(stashId, label, slots, weight, nil)
end
 
function FLBridge.inventory.GetStashItemCount(stashId, item)
    local result = MySQL.scalar.await(
        'SELECT items FROM stashitems WHERE stash = ?',
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
    -- tgiann exposes StashAddItem directly
    exports['tgiann-inventory']:StashAddItem(stashId, item, amount)
    return true
end
 
function FLBridge.inventory.RemoveFromStash(stashId, item, amount)
    
    local result = MySQL.scalar.await(
        'SELECT items FROM stashitems WHERE stash = ?',
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
        'INSERT INTO stashitems (stash, items) VALUES (?, ?) ON DUPLICATE KEY UPDATE items = ?',
        { stashId, json.encode(items), json.encode(items) }
    )
    return remaining <= 0
end
