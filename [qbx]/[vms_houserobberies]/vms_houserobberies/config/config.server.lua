SV = {}

SV.Webhooks = {
    ['STARTED_HOUSE_ROBBERY'] = "",
    ['GENERATED_HOUSE'] = "",
    ['POLICE_ALERT'] = "",
    ['DISABLE_ELECTRICITY'] = "",
    ['STEALED_LOOT'] = "",
    ['SELL_ITEM'] = "",
    ['FAILED_SALE'] = "",
}

SV.WebhookText = {
    ['TITLE.STARTED_HOUSE_ROBBERY'] = "🏠 STARTED HOUSE ROBBERY",
    ['DESCRIPTION.STARTED_HOUSE_ROBBERY'] = [[
        Player %s [%s] started house robbery on %s %s (House ID: %s)
    ]],

    ['TITLE.GENERATED_HOUSE'] = "🚪 GENERATED HOUSE",
    ['DESCRIPTION.GENERATED_HOUSE'] = [[
        Player %s [%s] entered the house %s %s (House ID: %s) and generated loot along with %s tenants.
        
        ## Loot:
        %s
    ]],

    ['TITLE.POLICE_ALERT'] = "🚔 POLICE ALERT",
    ['DESCRIPTION.POLICE_ALERT:FAILED_LOCKPICK'] = [[
        Player %s [%s] failed to break into house %s %s (House ID: %s)
    ]],
    ['DESCRIPTION.POLICE_ALERT:TRIGGERED_TENANT'] = [[
        Player %s [%s] was spotted by a tenant in house %s %s (House ID: %s).
    ]],

    ['TITLE.DISABLE_ELECTRICITY'] = "⚡ DISABLED ELECTRICITY",
    ['DESCRIPTION.DISABLE_ELECTRICITY'] = [[
        Player %s [%s] turned off the electricity at house %s %s (House ID: %s)
    ]],

    ['TITLE.STEALED_LOOT'] = "STEALED LOOT",
    ['DESCRIPTION.STEALED_LOOT:MONEY'] = [[
        Player %s [%s] stealed %s %s$ from house %s %s (House ID: %s)
    ]],
    ['DESCRIPTION.STEALED_LOOT:ITEM'] = [[
        Player %s [%s] stealed %s (%s) %sx from house %s %s (House ID: %s)
    ]],
    
    ['TITLE.SELL_ITEM'] = "💲 SOLD LOOT",
    ['DESCRIPTION.SELL_ITEM'] = [[
        Player %s [%s] sold %s %sx at the %s and earned %s$.
    ]],
    
    ['TITLE.FAILED_SALE'] = "❌ FAILED LOOT SALE",
    ['DESCRIPTION.FAILED_SALE'] = [[
        Player %s [%s] tried to sell %s %sx at a pawn shop, failed.
    ]],
}

SV.Webhook = function(webhook_id, title, description, color, footer)
    local DiscordWebHook = SV.Webhooks[webhook_id]
    local embeds = {{
        ["title"] = title,
        ["type"] = "rich",
        ["description"] = description,
        ["color"] = color,
        ["footer"] = {
            ["text"] = footer..' - '..os.date(),
        },
    }}
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({embeds = embeds}), {['Content-Type'] = 'application/json'})
end

SV.getPlayer = function(src)
    if Config.Core == "ESX" then
        return Core.GetPlayerFromId(src)
    elseif Config.Core == "QB-Core" then
        return Core.Functions.GetPlayer(src)
    end
end

SV.getIdentifier = function(xPlayer)
    if Config.Core == "ESX" then
        return xPlayer.identifier
    elseif Config.Core == "QB-Core" then
        return xPlayer.PlayerData.citizenid
    end
    return nil
end

SV.getPlayerByIdentifier = function(identifier)
    if Config.Core == "ESX" then
        return Core.GetPlayerFromIdentifier(identifier)
    elseif Config.Core == "QB-Core" then
        return Core.Functions.GetPlayerByCitizenId(identifier)
    end
end

SV.checkBeforeStartRobbery = function(src, xPlayer, houseData)
    return true

    -- In this function, you can introduce for example a reputation check, if you have one on the server.
        
    -- if ... then
    --     return true
    -- else
    --     TriggerClientEvent('vms_houserobberies:notification', src, TRANSLATE('notify.you_dont_have_reputation'), 5500, 'error')
    --     return false
    -- end
end

SV.getJobsOnline = function(jobName)
    if Config.Core == "ESX" then
        if Core.GetNumPlayers then
            return Core.GetNumPlayers('job', jobName)
        else
            local xPlayers = Core.GetExtendedPlayers('job', jobName)
            local count = 0
            for _, xPlayer in pairs(xPlayers) do
                count = count + 1
            end
            return count
        end
    elseif Config.Core == "QB-Core" then
        local players, count = Core.Functions.GetPlayersOnDuty(jobName)
        return count
    end
end

SV.getPlayerJob = function(xPlayer)
    if Config.Core == "ESX" then
        return xPlayer.job.name
    elseif Config.Core == "QB-Core" then
        return xPlayer.PlayerData.job.name
    end
end

SV.getMoney = function(xPlayer, moneyType)
    if Config.Core == "ESX" then
        local type = moneyType == "cash" and 'money' or moneyType
        return xPlayer.getAccount(type).money
    elseif Config.Core == "QB-Core" then
        return xPlayer.Functions.GetMoney(moneyType)
    end
    return nil
end

SV.addMoney = function(xPlayer, moneyType, amount)
    if Config.Core == "ESX" then
        local type = moneyType == "cash" and 'money' or moneyType
        xPlayer.addAccountMoney(type, amount)
    elseif Config.Core == "QB-Core" then
        xPlayer.Functions.AddMoney(moneyType, amount)
    end
end

SV.removeMoney = function(xPlayer, moneyType, amount)
    if Config.Core == "ESX" then
        local type = moneyType == "cash" and 'money' or 'bank'
        xPlayer.removeAccountMoney(type, amount)
    elseif Config.Core == "QB-Core" then
        xPlayer.Functions.RemoveMoney(moneyType, amount)
    end
    return nil
end

SV.getItemCount = function(xPlayer, name)
    if Config.Core == "ESX" then
        return xPlayer.getInventoryItem(name).count
    elseif Config.Core == "QB-Core" then
        return xPlayer.Functions.GetItemByName(name) and xPlayer.Functions.GetItemByName(name).amount or 0
    end
end

SV.addItem = function(xPlayer, name, count)
    if Config.Core == "ESX" then
        xPlayer.addInventoryItem(name, count)
    elseif Config.Core == "QB-Core" then
        xPlayer.Functions.AddItem(name, count)
    end
end

SV.removeItem = function(xPlayer, name, count)
    if Config.Core == "ESX" then
        xPlayer.removeInventoryItem(name, count)
    elseif Config.Core == "QB-Core" then
        xPlayer.Functions.RemoveItem(name, count)
    end
end

SV.banPlayer = function(playerId, type, data)
    if type == 'sale_item' then
        print(('^1[CHEATER] ^7Player %s tried to sell %s %sx in %s point. (Item is not for sale at this point!)'):format(playerId, data.itemName, data.itemCount, data.sellPoint))
        DropPlayer(playerId, 'Do not try it again!')
    end
    
end