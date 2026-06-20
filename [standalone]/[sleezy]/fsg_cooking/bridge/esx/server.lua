if GetResourceState(Config.ResourceNames.ESX) ~= 'started' then return end

ESX = exports.es_extended:getSharedObject()

for k, v in pairs(Config.CookingProps) do
    if v.item then
        ESX.RegisterUsableItem(v.item, function(source)
            StartPropPlacement(source, v.item)
        end)
    end
end

for k, v in pairs(Config.DecorationProps) do
    if v.item then
        ESX.RegisterUsableItem(v.item, function(source)
            StartPropPlacement(source, v.item)
        end)
    end
end

function GetPlayer(source)
    local player = ESX.GetPlayerFromId(source) 
    if not player then 
        DebugPrint("Player invalid")
        return
    end
    return player
end

function GetCharacterIdentifier(source)
    local player = GetPlayer(source)
    if not player then 
        DebugPrint("Player invalid")
        return
    end
    return player.getIdentifier()
end

function HasRequiredItems(playerId, requiredItems)
    if not playerId or not requiredItems then return false end

    for _, item in ipairs(requiredItems) do
        if GetItemQuantity(playerId, item.item) < item.count then
            return false
        end
    end

    return true
end

function RemoveRequiredItems(playerId, requiredItems)
    if not playerId or not requiredItems then return end

    for _, item in ipairs(requiredItems) do
        RemoveItem(playerId, item.item, item.count)
    end
end

function AddResultItems(playerId, resultItems)
    if not playerId or not resultItems then return end

    for _, item in ipairs(resultItems) do
        AddItem(playerId, item.item, item.count)
    end
end

function CanCarryItem(source, item, quantity)
    local player = GetPlayer(source)
    if not player then return end

    return player.canCarryItem(item, quantity)
end

function AddItem(source, item, quantity)
    local player = GetPlayer(source)
    if not player then return end

    return player.addInventoryItem(item, quantity)
end

function RemoveItem(source, item, quantity)
    local player = GetPlayer(source)
    if not player then return end

    return player.removeInventoryItem(item, quantity)
end

function GetItemQuantity(source, itemName)
    local player = GetPlayer(source)
    if not player then return end

    return player.getInventoryItem(itemName).count
end

function GetPlayerBankBalance(source)
    local player = GetPlayer(source)
    return player and player.getAccount('bank').money or 0
end

function GetPlayerCashBalance(source)
    local player = GetPlayer(source)
    return player and player.getAccount('money').money or 0
end

function AddPlayerMoney(source, account, amount)
    local player = GetPlayer(source)
    if not player then
        DebugPrint("Player Invalid")
        return
    end
    player.addAccountMoney(account, amount)
end

function RemovePlayerMoney(source, account, amount)
    local player = GetPlayer(source)
    if not player then
        DebugPrint("Player Invalid")
        return
    end
    player.removeAccountMoney(account, amount)
end

RegisterNetEvent('esx:playerLoaded', function(playerId, xPlayer)
    local src = playerId or source
    SyncPropsToPlayer(src)
end)

function isPlayerAdmin(source)
    local player = GetPlayer(source)
    if not player then return end

    local isAdmin = false 
    local group = player.getGroup()
    for k,v in ipairs(Config.AdminGroups) do
        if v == group then
            isAdmin = true
        end
    end

    return isAdmin
end

lib.callback.register('fsg_cooking:getGroupStatus', function(source)
    return isPlayerAdmin(source)
end)