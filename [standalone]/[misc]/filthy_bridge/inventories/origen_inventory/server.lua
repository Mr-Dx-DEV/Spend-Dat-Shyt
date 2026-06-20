local found = GetResourceState('origen_inventory')
if found ~= 'started' and found ~= 'starting' then return end

FLBridge.inventory = FLBridge.inventory or {}
FLBridge.inventorySystem = 'origen_inventory'

local origen = exports.origen_inventory

function FLBridge.inventory.AddItem(source, item, amount, metadata)
    return origen:addItem(source, item, amount, metadata)
end

function FLBridge.inventory.RemoveItem(source, item, amount, slot)
    return origen:removeItem(source, item, amount, false, slot)
end

function FLBridge.inventory.GetItemCount(source, item)
    return origen:getItemCount(source, item) or 0
end

function FLBridge.inventory.HasItem(source, item, amount)
    return FLBridge.inventory.GetItemCount(source, item) >= (amount or 1)
end

function FLBridge.inventory.CanCarryItem(source, item, amount)
    return origen:canCarryItem(source, item, amount)
end

function FLBridge.inventory.GetInventory(source)
    return origen:getInventory(source) or {}
end

function FLBridge.inventory.GetItemBySlot(source, slot)
    local inventory = origen:getInventory(source)
    return inventory and inventory[slot] or nil
end

function FLBridge.inventory.OpenStash(source, stashId, stashData)
    TriggerClientEvent('origen_inventory:client:openStash', source, stashId)
end

function FLBridge.inventory.RegisterStashes(stashes)
    -- origen_inventory registers on open
end


function FLBridge.inventory.RegisterStash(stashId, label, slots, weight)
    -- origen creates stashes on first open. No registration call needed.
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
