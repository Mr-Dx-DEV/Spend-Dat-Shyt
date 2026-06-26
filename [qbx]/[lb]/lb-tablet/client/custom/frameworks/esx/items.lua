if Config.Framework ~= "esx" then
    return
end

while not ESX do
    Wait(500)
    debugprint("Item: Waiting for ESX to load")
end

---@return boolean
function HasItem()
    if GetResourceState("ox_inventory") == "started" then
        return (exports.ox_inventory:Search("count", Config.Item.Name) or 0) > 0
    elseif GetResourceState("qs-inventory") == "started" then
        return (exports["qs-inventory"]:Search(Config.Item.Name) or 0) > 0
    end

    return (ESX.SearchInventory(Config.Item.Name, 1) or 0) > 0
end

RegisterNetEvent("esx:removeInventoryItem", function(item, count)
    if item ~= Config.Item.Name or count > 0 then
        return
    end

    ItemCountChanged()
end)

RegisterNetEvent("esx:addInventoryItem", function(item, count)
    if item ~= Config.Item.Name then
        return
    end

    ItemCountChanged()
end)
