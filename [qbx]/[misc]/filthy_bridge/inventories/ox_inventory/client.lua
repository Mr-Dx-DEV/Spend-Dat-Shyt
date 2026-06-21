local found = GetResourceState('ox_inventory')
if found ~= 'started' and found ~= 'starting' then return end

FLBridge.inventorySystem = 'ox_inventory'
FLBridge.inventory = FLBridge.inventory or {}

function FLBridge.inventory.openPlayerInventory(targetId)
    exports.ox_inventory:openInventory('player', targetId)
end

function FLBridge.inventory.openStash(data)
    exports.ox_inventory:openInventory('stash', data.name)
end

function FLBridge.inventory.openShop(data)
    exports.ox_inventory:openInventory('shop', { type = data.identifier, id = 1 })
end

RegisterNetEvent('filthy_bridge:openStash', function(stashId)
    exports.ox_inventory:openInventory('stash', stashId)
end)
