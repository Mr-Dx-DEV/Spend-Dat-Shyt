local found = GetResourceState('origen_inventory')
if found ~= 'started' and found ~= 'starting' then return end

FLBridge.inventorySystem = 'origen_inventory'
FLBridge.inventory = FLBridge.inventory or {}

function FLBridge.inventory.openPlayerInventory(targetId)
    exports.origen_inventory:openPlayerInventory(targetId)
end

function FLBridge.inventory.openStash(data)
    exports.origen_inventory:openStash(data.name)
end

function FLBridge.inventory.openShop(data)
    exports.origen_inventory:openShop(data.identifier)
end
