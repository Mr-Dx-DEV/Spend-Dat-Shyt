if Config.Framework ~= "standalone" then
    return
end

---@return boolean
function HasItem()
    if GetResourceState("ox_inventory") == "started" then
        return (exports.ox_inventory:Search("count", Config.Item.Name) or 0) > 0
    end

    return true
end

---@param itemName string
---@param count number
AddEventHandler("ox_inventory:itemCount", function(itemName, count)
    if itemName ~= Config.Item.Name then
        return
    end

    ItemCountChanged()
end)
