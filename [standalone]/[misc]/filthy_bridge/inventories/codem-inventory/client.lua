local found = GetResourceState('codem-inventory')
if found ~= 'started' and found ~= 'starting' then return end

FLBridge.inventorySystem = 'codem-inventory'
FLBridge.inventory = FLBridge.inventory or {}

function FLBridge.inventory.openPlayerInventory(targetId)
    exports['codem-inventory']:OpenPlayerInventory(targetId)
end

function FLBridge.inventory.openStash(data)
    exports['codem-inventory']:OpenStash(data.name)
end

function FLBridge.inventory.openShop(data)
    exports['codem-inventory']:OpenShop(data.identifier)
end
