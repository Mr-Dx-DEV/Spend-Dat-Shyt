Inventory = nil
if GetResourceState('qb-inventory') == 'started' then
    Inventory = 'qb-inventory'
elseif GetResourceState('ox_inventory') == 'started' then
    Inventory = 'ox_inventory'
elseif GetResourceState('qs-inventory') == 'started' then
    Inventory = 'qs-inventory'
end

function GetInventorySystem()
    return Inventory
end

exports('GetInventorySystem', GetInventorySystem)

