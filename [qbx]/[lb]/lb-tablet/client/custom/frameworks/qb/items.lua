if Config.Framework ~= "qb" then
    return
end

while not QB do
    Wait(500)
    debugprint("Items: Waiting for QB to load")
end

---@return boolean
function HasItem()
    if GetResourceState("ox_inventory") == "started" then
        return (exports.ox_inventory:Search("count", Config.Item.Name) or 0) > 0
    end

    return QB.Functions.HasItem(Config.Item.Name)
end

RegisterNetEvent("QBCore:Player:SetPlayerData", function(newData)
    ItemCountChanged()
end)
