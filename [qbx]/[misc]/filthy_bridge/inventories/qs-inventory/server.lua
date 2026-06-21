local found = GetResourceState('qs-inventory')
if found ~= 'started' and found ~= 'starting' then return end

FLBridge.inventory = FLBridge.inventory or {}
FLBridge.inventorySystem = 'qs-inventory'

function FLBridge.inventory.AddItem(source, item, amount, metadata)
    if exports['qs-inventory']:CanCarryItem(source, item, amount) then
        exports['qs-inventory']:AddItem(source, item, amount, nil, metadata)
        return true
    end
    return false
end

function FLBridge.inventory.RemoveItem(source, item, amount, slot)
    local count = exports['qs-inventory']:GetItemTotalAmount(source, item)
    if count >= amount then
        exports['qs-inventory']:RemoveItem(source, item, amount, slot)
        return true
    end
    return false
end

function FLBridge.inventory.GetItemCount(source, item)
    return exports['qs-inventory']:GetItemTotalAmount(source, item) or 0
end

function FLBridge.inventory.HasItem(source, item, amount)
    return FLBridge.inventory.GetItemCount(source, item) >= (amount or 1)
end

function FLBridge.inventory.CanCarryItem(source, item, amount)
    return exports['qs-inventory']:CanCarryItem(source, item, amount)
end

function FLBridge.inventory.GetInventory(source)
    return exports['qs-inventory']:GetInventory(source)
end

function FLBridge.inventory.GetItemBySlot(source, slot)
    local inventory = exports['qs-inventory']:GetInventory(source)
    return inventory and inventory[slot] or nil
end

function FLBridge.inventory.OpenStash(source, stashId, stashData)
    stashData = stashData or { slots = 50, weight = 100000 }
    exports['qs-inventory']:RegisterStash(source, stashId, stashData.slots, stashData.weight)
end

function FLBridge.inventory.RegisterStashes(stashes)
end

function FLBridge.inventory.RegisterStash(stashId, label, slots, weight)
    -- source = 0 means shared stash (not player-owned)
    exports['qs-inventory']:RegisterStash(0, stashId, slots or 50, weight or 500000)
end
 
function FLBridge.inventory.GetStashItemCount(stashId, item)
    local contents = exports['qs-inventory']:GetStashItems(stashId) or {}
    local total    = 0
    for _, slot in pairs(contents) do
        if slot and slot.name == item then
            total = total + (slot.amount or 0)
        end
    end
    return total
end
 
function FLBridge.inventory.AddToStash(stashId, item, amount, metadata)
    return exports['qs-inventory']:AddItemIntoStash(stashId, item, amount, nil, metadata, 50, 500000)
end
 
function FLBridge.inventory.RemoveFromStash(stashId, item, amount)
    return exports['qs-inventory']:RemoveItemIntoStash(stashId, item, amount, nil, nil, 50, 500000)
end
 
