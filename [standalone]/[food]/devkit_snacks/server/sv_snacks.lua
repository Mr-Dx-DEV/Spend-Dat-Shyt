local ESX, QBCore = nil, nil

-- Try to detect ESX
if GetResourceState(Config.ESXgetSharedObject) == "started" then
    ESX = exports[Config.ESXgetSharedObject]:getSharedObject()
-- Try to detect QBCore
elseif GetResourceState(Config.QBCoreGetCoreObject) == "started" then
    QBCore = exports[Config.QBCoreGetCoreObject]:GetCoreObject()
end

-- Register usable food items
for item, data in pairs(Config.Food) do
    if ESX then
        ESX.RegisterUsableItem(item, function(source)
            local xPlayer = ESX.GetPlayerFromId(source)
            local invItem = xPlayer.getInventoryItem(item)

            if invItem.count > 0 then
                xPlayer.removeInventoryItem(item, 1)
                TriggerClientEvent("devkit_snacks:onEat", source, item)
                TriggerClientEvent("esx_status:add", source, data.effect, data.amount * 10000)
            end
        end)

    elseif QBCore then
        QBCore.Functions.CreateUseableItem(item, function(source, _)
            local Player = QBCore.Functions.GetPlayer(source)
            local invItem = Player.Functions.GetItemByName(item)

            if invItem then
                Player.Functions.RemoveItem(item, 1)
                TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[item], "remove")
                TriggerClientEvent("devkit_snacks:onEat", source, item)

                local hunger = Player.PlayerData.metadata.hunger or 0
                local newHunger = math.min(100, hunger + data.amount)

                Player.Functions.SetMetaData("hunger", newHunger)
                TriggerClientEvent(Config.QBUpdateNeeds, source, newHunger, Player.PlayerData.metadata.hunger)
            end
        end)
    end
end

-- Register usable drink items
for item, data in pairs(Config.Drinks) do
    if ESX then
        ESX.RegisterUsableItem(item, function(source)
            local xPlayer = ESX.GetPlayerFromId(source)
            local invItem = xPlayer.getInventoryItem(item)

            if invItem.count > 0 then
                xPlayer.removeInventoryItem(item, 1)
                TriggerClientEvent("devkit_snacks:onDrink", source, item)
                TriggerClientEvent("esx_status:add", source, data.effect, data.amount * 10000)
            end
        end)

    elseif QBCore then
        QBCore.Functions.CreateUseableItem(item, function(source, _)
            local Player = QBCore.Functions.GetPlayer(source)
            local invItem = Player.Functions.GetItemByName(item)

            if invItem then
                Player.Functions.RemoveItem(item, 1)
                TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[item], "remove")
                TriggerClientEvent("devkit_snacks:onDrink", source, item)

                local thirst = Player.PlayerData.metadata.thirst or 0
                local newThirst = math.min(100, thirst + data.amount)

                Player.Functions.SetMetaData("thirst", newThirst)
                TriggerClientEvent(Config.QBUpdateNeeds, source, Player.PlayerData.metadata.thirst, newThirst)
            end
        end)
    end
end