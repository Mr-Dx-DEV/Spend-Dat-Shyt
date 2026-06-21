if Config.Framework ~= 'QBcore' then return end

QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    Wait(4000)
    for itemName, itemData in pairs(Config.AlcocholItems) do
        Wait(100)
        QBCore.Functions.CreateUseableItem(itemName, function(source)
            if not DrinkInProggres then
                DrinkInProggres = true
                local Player = QBCore.Functions.GetPlayer(source)
                local Thirst = Player.PlayerData.metadata.thirst or 0
                local Stress = Player.PlayerData.metadata.stress or 0
                
                if QBCore.Shared.Items[itemName] then
                    Player.Functions.RemoveItem(itemName, 1)
               else
                    print("❌ Item not found in QBCore.Shared.Items:", itemName)
                end
                if itemData.thirst then
                    if itemData.thirst[1] == "add" then
                        Thirst = Thirst + itemData.thirst[2]
                    elseif itemData.thirst[1] == "remove" then
                        Thirst = Thirst - itemData.thirst[2]
                    end
                end
                if itemData.stress then
                    if itemData.stress[1] == "add" then
                        Stress = Stress + itemData.stress[2]
                    elseif itemData.stress[1] == "remove" then
                        Stress = Stress - itemData.stress[2]
                    end
                end
                
                Player.Functions.SetMetaData("thirst", Thirst)
                Player.Functions.SetMetaData("stress", Stress)
                TriggerClientEvent('NRG_AlcoEffect:onDrink', source, itemData.drunk, itemData.prop, itemData.propoffset, itemData.notify)
                Wait(6000)
                DrinkInProggres = false
            end

        end)
    end

    QBCore.Functions.CreateUseableItem(Config.BreathalyzerItemName, function(source)

        TriggerClientEvent('NRG_AlcoEffect:UseAlcomat', source)

    end)
    print('Items ready to use')
end)

function IdToPlayerIdentifier(playerId)
    local Player = QBCore.Functions.GetPlayer(playerId)
    if Player then
        return Player.PlayerData.citizenid
    else
        return nil
    end

end

RegisterNetEvent('QBCore:Server:PlayerLoaded', function(player)
    if PlayerDataDrunk[player.PlayerData.citizenid] then
        local timenow = os.time()
        local timepass = timenow - PlayerDataDrunk[player.PlayerData.citizenid].time

        local x = timepass / Config.DropDrunkLevelTime
        x = math.floor(x)
        take = x * Config.DropDrunkLevelCount
        
        if take < PlayerDataDrunk[player.PlayerData.citizenid].drunk then
            Wait(10000)
            SqlDrunkLevel = PlayerDataDrunk[player.PlayerData.citizenid].drunk - take
            TriggerClientEvent('NRG_AlcoEffect:PlayerLoader', player.PlayerData.source, SqlDrunkLevel)
        end
    end
end)


