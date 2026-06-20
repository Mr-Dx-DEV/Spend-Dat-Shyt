Inventory = {}

Inventory.GiveItem = function(source, count, item, metadata)
    debbugPrint(json.encode({source = source, count = count, item = item, metadata = metadata}))
    if Settings.Inventory == "ox_inventory" then
        exports.ox_inventory:AddItem(source, item, count, metadata)
    elseif Settings.Inventory == "qb-inventory" then
        exports['qb-inventory']:AddItem(source, item, count, false, metadata)
    else
        print("[RENT] Settings | ensure inventory in shared/inventory.lua!!!")
    end
end

Inventory.GetSlot = function(source, slot)
    if Settings.Inventory == "ox_inventory" then
        return exports.ox_inventory:GetSlot(source, slot)
    end
end

Inventory.ShowInventoryMetadata = function()
    if GetResourceState("ox_inventory") == "started" then
        exports.ox_inventory:displayMetadata('RentPlate', Strings.Inventory.RentPlate)
    end
end