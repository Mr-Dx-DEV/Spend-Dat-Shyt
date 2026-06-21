local found = GetResourceState('tgiann-inventory')
if found ~= 'started' and found ~= 'starting' then return end

FLBridge.inventorySystem = 'tgiann-inventory'
FLBridge.inventory = FLBridge.inventory or {}

function FLBridge.inventory.openPlayerInventory(targetId)
    exports['tgiann-inventory']:OpenPlayerInventory(targetId)
end

function FLBridge.inventory.openStash(data)
    exports['tgiann-inventory']:OpenInventory(source, 'stash', data.name)
end

function FLBridge.inventory.openShop(data)
    exports['tgiann-inventory']:OpenShop(data.identifier)
end
