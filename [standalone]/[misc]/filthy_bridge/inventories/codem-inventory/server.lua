local found = GetResourceState('codem-inventory')
if found ~= 'started' and found ~= 'starting' then return end

FLBridge.inventory = FLBridge.inventory or {}
FLBridge.inventorySystem = 'codem-inventory'

local codem = exports['codem-inventory']

function FLBridge.inventory.AddItem(source, item, amount, metadata)
    return codem:AddItem(source, item, amount, nil, metadata)
end

function FLBridge.inventory.RemoveItem(source, item, amount, slot)
    if slot then return codem:RemoveItem(source, item, amount, slot) end
    return codem:RemoveItem(source, item, amount)
end

function FLBridge.inventory.GetItemCount(source, item)
    local items = codem:GetItemsByName(source, item)
    if not items then return 0 end
    local total = 0
    for _, i in pairs(items) do
        if type(i) == 'table' and i.amount then
            total = total + (tonumber(i.amount) or 0)
        end
    end
    return total
end

function FLBridge.inventory.HasItem(source, item, amount)
    return codem:HasItem(source, item, amount or 1)
end

function FLBridge.inventory.CanCarryItem(source, item, amount)
    return codem:CanCarryItem(source, item, amount)
end

function FLBridge.inventory.GetInventory(source)
    return codem:GetClientPlayerInventory(source) or {}
end

function FLBridge.inventory.GetItemBySlot(source, slot)
    local inventory = codem:GetClientPlayerInventory(source) or {}
    return inventory[slot] or nil
end

function FLBridge.inventory.OpenStash(source, stashId, stashData)
    TriggerClientEvent('codem-inventory:client:openStash', source, stashId)
end

function FLBridge.inventory.RegisterStashes(stashes)
    -- codem-inventory registers on open
end

 
function FLBridge.inventory.RegisterStash(stashId, label, slots, weight)
    -- codem-inventory creates stashes on first open, no registration needed.
end
 
function FLBridge.inventory.GetStashItemCount(stashId, item)
    local contents = exports['codem-inventory']:GetStashItems(stashId) or {}
    local total    = 0
    for _, slot in pairs(contents) do
        if type(slot) == 'table' and slot.name == item then
            total = total + (tonumber(slot.amount) or 0)
        end
    end
    return total
end
 
function FLBridge.inventory.AddToStash(stashId, item, amount, metadata)
    local items  = exports['codem-inventory']:GetStashItems(stashId) or {}
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
        while items[nextSlot] do nextSlot = nextSlot + 1 end
        items[nextSlot] = {
            name   = item,
            amount = amount,
            info   = metadata or {},
            slot   = nextSlot,
        }
    end
 
    exports['codem-inventory']:UpdateStash(stashId, items)
    return true
end
 
function FLBridge.inventory.RemoveFromStash(stashId, item, amount)
    local items     = exports['codem-inventory']:GetStashItems(stashId) or {}
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
 
    exports['codem-inventory']:UpdateStash(stashId, items)
    return remaining <= 0
end
