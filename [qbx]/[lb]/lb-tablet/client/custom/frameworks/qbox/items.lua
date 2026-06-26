if Config.Framework ~= "qbox" then
    return
end

while not Qbox do
    Wait(500)
    debugprint("Items: Waiting for Qbox to load")
end

---@return boolean
function HasItem()
    if GetResourceState("ox_inventory") == "started" then
        return (exports.ox_inventory:Search("count", Config.Item.Name) or 0) > 0
    end

    return Qbox.Functions.HasItem(Config.Item.Name)
end

RegisterNetEvent("QBCore:Player:SetPlayerData", function(newData)
    ItemCountChanged()
end)
