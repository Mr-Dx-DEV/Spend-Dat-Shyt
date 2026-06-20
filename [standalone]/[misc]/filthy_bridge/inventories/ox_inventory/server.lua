local found = GetResourceState('ox_inventory')
if found ~= 'started' and found ~= 'starting' then return end

FLBridge.inventory = FLBridge.inventory or {}
FLBridge.inventorySystem = 'ox_inventory'

function FLBridge.inventory.AddItem(source, item, amount, metadata)
    return exports.ox_inventory:AddItem(source, item, amount, metadata)
end

function FLBridge.inventory.RemoveItem(source, item, amount, slot)
    return exports.ox_inventory:RemoveItem(source, item, amount, nil, slot)
end

function FLBridge.inventory.GetItemCount(source, item)
    return exports.ox_inventory:GetItemCount(source, item) or 0
end

function FLBridge.inventory.HasItem(source, item, amount)
    return FLBridge.inventory.GetItemCount(source, item) >= (amount or 1)
end

function FLBridge.inventory.CanCarryItem(source, item, amount)
    return exports.ox_inventory:CanCarryItem(source, item, amount)
end

function FLBridge.inventory.GetInventory(source)
    return exports.ox_inventory:GetInventory(source, false)
end

function FLBridge.inventory.GetItemBySlot(source, slot)
    local inventory = exports.ox_inventory:GetInventory(source, false)
    return inventory and inventory.items and inventory.items[slot] or nil
end

function FLBridge.inventory.SetItemMetadata(source, slot, metadata)
    if not slot then return false end
    local item = exports.ox_inventory:GetSlot(source, slot)
    if not item then return false end
    exports.ox_inventory:SetItemMetadata(source, slot, metadata)
    return true
end

function FLBridge.inventory.ClearInventory(source)
    exports.ox_inventory:ClearInventory(source)
end

function FLBridge.inventory.OpenStash(source, stashId, stashData)
    local slots = stashData and stashData.slots or 80
    local weight = stashData and stashData.weight or 250000
    exports.ox_inventory:RegisterStash(stashId, stashId, slots, weight)
    TriggerClientEvent('filthy_bridge:openStash', source, stashId)
end



function FLBridge.inventory.RegisterStashes(stashes)
    for _, stash in ipairs(stashes) do
        exports.ox_inventory:RegisterStash(stash.id, stash.label, stash.slots, stash.weight)
    end
end

function FLBridge.inventory.RegisterStash(stashId, label, slots, weight)
    exports.ox_inventory:RegisterStash(stashId, label, slots, weight)
end
 
function FLBridge.inventory.GetStashItemCount(stashId, item)
    
    return exports.ox_inventory:GetItemCount(stashId, item) or 0
end
 
function FLBridge.inventory.AddToStash(stashId, item, amount, metadata)
    
    exports.ox_inventory:GetInventory(stashId, false)
    return exports.ox_inventory:AddItem(stashId, item, amount, metadata)
end
 
function FLBridge.inventory.RemoveFromStash(stashId, item, amount)
    exports.ox_inventory:GetInventory(stashId, false)
    return exports.ox_inventory:RemoveItem(stashId, item, amount)
end

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName ~= 'ox_inventory' and resourceName ~= GetCurrentResourceName() then return end
    TriggerEvent('filthy_bridge:reregisterStashes')
end)
