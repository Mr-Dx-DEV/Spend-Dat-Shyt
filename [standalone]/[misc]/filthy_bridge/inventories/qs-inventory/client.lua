local found = GetResourceState('qs-inventory')
if found ~= 'started' and found ~= 'starting' then return end

FLBridge.inventorySystem = 'qs-inventory'
FLBridge.inventory = FLBridge.inventory or {}

function FLBridge.inventory.openPlayerInventory(targetId)
    exports['qs-inventory']:OpenPlayerInventory(targetId)
end

function FLBridge.inventory.openStash(data)
    exports['qs-inventory']:OpenStash(source, data.name, data.slots, data.weight)
end

function FLBridge.inventory.openShop(data)
    exports['qs-inventory']:OpenShop(data.identifier, data.name)
end
