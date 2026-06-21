local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('admin:commands:server:finishstashwipe', function(name, stashtype)
    local src = source
    if stashtype == "stash" then
        MySQL.query("DELETE FROM ox_inventory WHERE name = ?", { name })
    elseif stashtype == "trunk" then
        MySQL.query("DELETE FROM ox_inventory WHERE name = ?", { "trunk"..name })
    elseif stashtype == "glovebox" then
        MySQL.query("DELETE FROM ox_inventory WHERE name = ?", { "glove"..name })
    end
    TriggerClientEvent('QBCore:Notify', src, 'Stash wiped successfully: ' .. stashtype .. ' - ' .. name, 'success')
end)

RegisterNetEvent('admin:commands:server:deleteMyMoney', function(bankorcash, amountofmoney)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    local totalPrice = tonumber(amountofmoney)
    if player ~= nil then
        if bankorcash == "bank" then
            if player.PlayerData.money.bank >= totalPrice then
                player.Functions.RemoveMoney('bank', amountofmoney, 'burned-bank')
                TriggerEvent("qb-log:server:CreateLog", "burnedmoney", "Player Burned Bank", "green", "**".. GetPlayerName(src) .. "** (citizenid: *"..player.PlayerData.citizenid.."* | ID: *"..src..")* burned $"..amountofmoney.."")
            else
                QBCore.Functions.Notify("You don't have that much in your bank..", 'error')
            end
        elseif bankorcash == "cash" then
            if player.PlayerData.money.cash >= totalPrice then
                player.Functions.RemoveMoney('cash', amountofmoney, 'burned-cash')
                TriggerEvent("qb-log:server:CreateLog", "burnedmoney", "Player Burned Cash", "green", "**".. GetPlayerName(src) .. "** (citizenid: *"..player.PlayerData.citizenid.."* | ID: *"..src..")* burned $"..amountofmoney.."")
            else
                QBCore.Functions.Notify("You don't have that much in cash..", 'error')
            end
        end
    end
end)

RegisterServerEvent('admin:server:PullStash')
AddEventHandler('admin:server:PullStash', function(stashId, stashLabel, stashType, playerName)
    local src = source
    exports.ox_inventory:RegisterStash(stashId, stashLabel, 1000, 100000000)
    exports.ox_inventory:forceOpenInventory(src, stashType, stashId)
    TriggerEvent('qb-log:server:CreateLog', 'pullstash', 'Player Pulled Stash', 'purple', playerName.." pulled stash type: "..stashType.." Stash ID/Name: "..stashId)
end)