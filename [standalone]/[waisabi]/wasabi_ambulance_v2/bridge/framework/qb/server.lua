if not GetResourceState("qb-core"):find('start') or GetResourceState("qbx_core"):find('start') then return end

lib.print.debug("QBCore framework detected, initializing bridge...")

local QBCore = exports['qb-core']:GetCoreObject()

local bridge = {}

local inventory

local function normalizePlayerData(playerData) --- normalize player data to our shape
    return {
        name = playerData.charinfo.firstname .. ' ' .. playerData.charinfo.lastname,
        groups = { [playerData.job.name] = playerData.job.grade.level },
        duty = playerData.job.onduty or false,
        charId = playerData.citizenid,
        gender = playerData.charinfo.gender
    }
end

bridge.framework = 'qb'

bridge.charTableInfo = { -- for foreign key constraints
    "players",           -- table
    "citizenid",         -- id column
}

function bridge.init()
    inventory = Modules.get('inventory')
end

function bridge.getIdentifier(source)
    local Player = QBCore.Functions.GetPlayer(source)

    if not Player then return nil end

    return Player.PlayerData.citizenid
end

function bridge.hasGroup(source, filter)
    local Player = QBCore.Functions.GetPlayer(source)

    if not Player then return false end

    local jobName = Player.PlayerData.job.name
    local jobGrade = Player.PlayerData.job.grade.level

    if type(filter) == 'string' then
        return jobName == filter
    elseif type(filter) == 'table' then
        local tableType = table.type(filter)

        if tableType == 'hash' then
            for name, minGrade in pairs(filter) do
                if jobName == name and jobGrade >= minGrade then
                    return true
                end
            end
        elseif tableType == 'array' then
            for i = 1, #filter do
                if jobName == filter[i] then
                    return true
                end
            end
        end
    end

    return false
end

function bridge.getJob(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return false end
    return Player.PlayerData.job.name, Player.PlayerData.job.grade.level
end

function bridge.getDuty(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return false end
    return Player.PlayerData.job.onduty or false
end

function bridge.getAccountFunds(source, account)
    if account == 'money' then account = 'cash' end
    local player = QBCore.Functions.GetPlayer(source)
    if not player then return false end
    return player.PlayerData.money[account]
end

function bridge.removeAccountFunds(source, account, amount)
    if account == 'money' then account = 'cash' end
    local player = QBCore.Functions.GetPlayer(source)
    if not player then return false end
    player.Functions.RemoveMoney(account, amount)
    return true
end

function bridge.addAccountFunds(source, account, amount)
    if account == 'money' then account = 'cash' end
    local player = QBCore.Functions.GetPlayer(source)
    if not player then return false end
    player.Functions.AddMoney(account, amount)
    return true
end

function bridge.addSocietyFunds(society, amount)
    if type(society) ~= 'string' or society == '' or not amount or amount <= 0 then return false end

    if GetResourceState('qb-management'):find('start') then
        local success = pcall(function()
            exports['qb-management']:AddMoney(society, amount)
        end)
        if success then return true end
    end

    if GetResourceState('qb-banking'):find('start') then
        local success = pcall(function()
            exports['qb-banking']:AddMoney(society, amount)
        end)
        if success then return true end
    end

    return false
end

function bridge.hasItem(source, item, count, metadata)
    if inventory then
        return inventory.hasItem(source, item, count or 1, metadata or nil)
    end

    local player = QBCore.Functions.GetPlayer(source)
    if not player then return false end
    local itemData = player.Functions.GetItemByName(item)
    return itemData and (itemData.count or itemData.amount or 0) or 0 > 0
end

function bridge.addItem(source, item, count, metadata)
    if inventory then
        return inventory.addItem(source, item, count or 1, metadata or nil)
    end

    local player = QBCore.Functions.GetPlayer(source)
    if not player then return false end
    player.Functions.AddItem(item, count)
    local itemData = player.Functions.GetItemByName(item)
    if itemData and itemData.count then itemData.count = count elseif itemData and itemData.amount then itemData.amount = count end
    TriggerClientEvent('inventory:client:ItemBox', source, itemData, 'add')
    return true
end

function bridge.removeItem(source, item, count, metadata, slot)
    if inventory then
        return inventory.removeItem(source, item, count or 1, metadata or nil, slot or nil)
    end

    local player = QBCore.Functions.GetPlayer(source)
    if not player then return false end
    player.Functions.RemoveItem(item, count, slot, metadata)
    return true
end

function bridge.registerUsableItem(itemName, afterUse, beforeUse)
    if inventory and type(inventory.registerUsableItem) == 'function' then
        return inventory.registerUsableItem(itemName, afterUse, beforeUse)
    end

    QBCore.Functions.CreateUseableItem(itemName, function(source, item)
        if beforeUse and type(beforeUse) == 'function' then
            local beforeUseResult = beforeUse(source, item)
            if beforeUseResult == false then
                return
            end
        end
        if afterUse and type(afterUse) == 'function' then
            afterUse(source, item)
        end
    end)
end

function bridge.getPlayer(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return nil end

    return normalizePlayerData(Player.PlayerData)
end

function bridge.resetPlayerNeeds(source)
    local Player = QBCore.Functions.GetPlayer(source)

    if not Player then return end

    Player.Functions.SetMetaData('hunger', 100)
    Player.Functions.SetMetaData('thirst', 100)
    Player.Functions.SetMetaData('stress', 0)
    TriggerClientEvent('hud:client:UpdateNeeds', source, 100, 100)
end

function bridge.toggleDuty(source, onDuty)
    local Player = QBCore.Functions.GetPlayer(source)

    if not Player then return end

    Player.Functions.SetJobDuty(onDuty)
end

RegisterNetEvent('QBCore:Server:OnPlayerLoaded', function()
    TriggerEvent('wasabi_ambulance:PlayerLoaded', source)
end)

function bridge.setPlayerDead(src, isDead)
    local _Player = QBCore.Functions.GetPlayer(src)
    if _Player then
        _Player.Functions.SetMetaData('isdead', isDead)
        Player(src).state:set('isDead', isDead, true)

        if _Player.PlayerData.metadata.laststand then
            _Player.Functions.SetMetaData('inlaststand', false)
        end
    end
end

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end

    while not Modules.isAllInitialized() do
        Wait(100)
    end

    for _, playerId in pairs(GetPlayers()) do
        TriggerEvent('wasabi_ambulance:PlayerLoaded', tonumber(playerId))
    end
end)

Modules.register('bridge', bridge, {
    optionalDependencies = { 'inventory' }
})
