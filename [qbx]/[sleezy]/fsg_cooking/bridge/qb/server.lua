if GetResourceState(Config.ResourceNames.QBCore) ~= 'started' then return end

QBCore = exports['qb-core']:GetCoreObject()

local Inventory = 'ox'
CreateThread(function()
    if GetResourceState('ox_inventory') == 'started' then
        Inventory = 'ox'
    elseif GetResourceState('qb-inventory') == 'started' then
        Inventory = 'qb'
    elseif GetResourceState('ps-inventory') == 'started' then
        Inventory = 'ps'
    end
    DebugPrint('Detected inventory system: ' .. Inventory)
end)

for k, v in pairs(Config.CookingProps) do
    if v.item then
        QBCore.Functions.CreateUseableItem(v.item, function(source, item)
            StartPropPlacement(source, v.item)
        end)
    end
end

for k, v in pairs(Config.DecorationProps) do
    if v.item then
        QBCore.Functions.CreateUseableItem(v.item, function(source, item)
            StartPropPlacement(source, v.item)
        end)
    end
end

-- Pending consume tokens: pendingConsumes[src] = { type, item, time }
-- Server tracks what it authorized so the client callback can't forge values.
local pendingConsumes = {}

-- Register all food items from Config.Consumables as useable
for itemName, _ in pairs(Config.Consumables.Food) do
    QBCore.Functions.CreateUseableItem(itemName, function(source, item)
        local Player = QBCore.Functions.GetPlayer(source)
        if not Player then return end
        if pendingConsumes[source] then return end -- already consuming
        if RemoveItem(source, itemName, 1) then
            pendingConsumes[source] = { type = 'food', item = itemName, time = os.time() }
            TriggerClientEvent('fsg_cooking:client:consume', source, 'food', itemName)
        end
    end)
end

-- Register all drink items from Config.Consumables as useable
for itemName, _ in pairs(Config.Consumables.Drinks) do
    QBCore.Functions.CreateUseableItem(itemName, function(source, item)
        local Player = QBCore.Functions.GetPlayer(source)
        if not Player then return end
        if pendingConsumes[source] then return end -- already consuming
        if RemoveItem(source, itemName, 1) then
            pendingConsumes[source] = { type = 'drink', item = itemName, time = os.time() }
            TriggerClientEvent('fsg_cooking:client:consume', source, 'drink', itemName)
        end
    end)
end

-- Client calls this callback after the eat/drink animation finishes.
-- No exploitable data comes from the client — the server looks up everything
-- from the pending token it created when the item was used.
lib.callback.register('fsg_cooking:server:finishConsume', function(source)
    local pending = pendingConsumes[source]
    if not pending then return false end

    -- Expire stale tokens (> 15 seconds = something went wrong)
    if os.time() - pending.time > 15 then
        pendingConsumes[source] = nil
        return false
    end

    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then
        pendingConsumes[source] = nil
        return false
    end

    if pending.type == 'food' then
        local amount = Config.Consumables.Food[pending.item] or Config.Consumables.DefaultFood
        local current = Player.Functions.GetMetaData('hunger') or 0
        local newValue = math.min(current + amount, 100)
        Player.Functions.SetMetaData('hunger', newValue)
        TriggerClientEvent('hud:client:UpdateNeeds', source, newValue, Player.Functions.GetMetaData('thirst') or 0)
    elseif pending.type == 'drink' then
        local amount = Config.Consumables.Drinks[pending.item] or Config.Consumables.DefaultDrink
        local current = Player.Functions.GetMetaData('thirst') or 0
        local newValue = math.min(current + amount, 100)
        Player.Functions.SetMetaData('thirst', newValue)
        TriggerClientEvent('hud:client:UpdateNeeds', source, Player.Functions.GetMetaData('hunger') or 0, newValue)
    end

    pendingConsumes[source] = nil
    return true
end)

-- Clean up pending tokens when a player drops
AddEventHandler('playerDropped', function()
    pendingConsumes[source] = nil
end)

function GetPlayer(source)
    local player = QBCore.Functions.GetPlayer(source)
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
    return player.PlayerData.citizenid
end

function GetItemQuantity(source, itemName)
    if Inventory == 'ox' then
        return exports.ox_inventory:GetItem(source, itemName, nil, true) or 0
    elseif Inventory == 'qb' then
        local Player = QBCore.Functions.GetPlayer(source)
        if Player then
            local item = Player.Functions.GetItemByName(itemName)
            return item and item.amount or 0
        end
    elseif Inventory == 'ps' then
        local item = exports['ps-inventory']:GetItemByName(source, itemName)
        return item and item.amount or 0
    end
    return 0
end

function HasRequiredItems(playerId, requiredItems)
    if not playerId or not requiredItems then return false end

    for _, item in ipairs(requiredItems) do
        local count = GetItemQuantity(playerId, item.item)
        if count < item.count then
            return false
        end
    end

    return true
end

function RemoveItem(source, itemName, itemQuantity)
    if Inventory == 'ox' then
        return exports.ox_inventory:RemoveItem(source, itemName, itemQuantity)
    elseif Inventory == 'qb' then
        local Player = QBCore.Functions.GetPlayer(source)
        if Player then
            return Player.Functions.RemoveItem(itemName, itemQuantity)
        end
    elseif Inventory == 'ps' then
        return exports['ps-inventory']:RemoveItem(source, itemName, itemQuantity)
    end
    return false
end

function RemoveRequiredItems(playerId, requiredItems)
    if not playerId or not requiredItems then return end

    for _, item in ipairs(requiredItems) do
        RemoveItem(playerId, item.item, item.count)
    end
end

function AddItem(source, item, quantity)
    if Inventory == 'ox' then
        return exports.ox_inventory:AddItem(source, item, quantity)
    elseif Inventory == 'qb' then
        local Player = QBCore.Functions.GetPlayer(source)
        if Player then
            return Player.Functions.AddItem(item, quantity)
        end
    elseif Inventory == 'ps' then
        return exports['ps-inventory']:AddItem(source, item, quantity)
    end
    return false
end

function AddResultItems(playerId, resultItems)
    if not playerId or not resultItems then return end

    for _, item in ipairs(resultItems) do
        AddItem(playerId, item.item, item.count)
    end
end

function CanCarryItem(source, itemName, itemQuantity)
    if Inventory == 'ox' then
        return exports.ox_inventory:CanCarryItem(source, itemName, itemQuantity)
    else
        -- qb-inventory/ps-inventory: return true (weight check handled by inventory)
        return true
    end
end

function GetPlayerBankBalance(source)
    local Player = GetPlayer(source)
    return Player and Player.PlayerData.money.bank or 0
end

function GetPlayerCashBalance(source)
    local Player = GetPlayer(source)
    return Player and Player.PlayerData.money.cash or 0
end

function AddPlayerMoney(source, account, amount, reason)
    local player = GetPlayer(source)
    if not player then
        DebugPrint("Player Invalid")
        return
    end
    if account == 'money' then account = 'cash' end
    player.Functions.AddMoney(account, amount)
end

function RemovePlayerMoney(source, account, amount)
    local player = GetPlayer(source)
    if not player then
        DebugPrint("Player Invalid")
        return
    end
    if account == 'money' then account = 'cash' end
    player.Functions.RemoveMoney(account, amount)
end

RegisterNetEvent('QBCore:Server:PlayerLoaded', function(Player)
    local src = Player.PlayerData.source or source
    SyncPropsToPlayer(src)
end)

function isPlayerAdmin(source)
    local player = GetPlayer(source)
    if not player then return false end

    if Config.AdminGroups then
        for k, v in ipairs(Config.AdminGroups) do
            v = 'qbcore.'..v
            if IsPlayerAceAllowed(source, v) then
                return true
            end
        end
    end

    return false
end

lib.callback.register('fsg_cooking:getGroupStatus', function(source)
    return isPlayerAdmin(source)
end)
