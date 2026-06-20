if not GetResourceState("qbx_core"):find('start') then return end

lib.print.debug("QBX framework detected, initializing bridge...")

local QBX = exports.qbx_core

local bridge = {}

local inventory = nil

local function normalizePlayerData(playerData)
    return {
        name = playerData.charinfo.firstname .. ' ' .. playerData.charinfo.lastname,
        groups = { [playerData.job.name] = playerData.job.grade.level },
        duty = playerData.job.onduty or false,
        charId = playerData.citizenid,
        gender = playerData.charinfo.gender
    }
end

bridge.framework = 'qbx'

bridge.charTableInfo = { -- for foreign key constraints
    "players",           -- table
    "citizenid",         -- id column
}

function bridge.init()
    inventory = Modules.get('inventory')
end

function bridge.getIdentifier(source)
    local Player = QBX:GetPlayer(source)
    if not Player then return nil end

    return Player.PlayerData.citizenid
end

function bridge.hasGroup(source, filter)
    local Player = QBX:GetPlayer(source)
    if not Player then return false end

    return QBX:HasGroup(source, filter)
end

function bridge.getJob(source)
    local Player = QBX:GetPlayer(source)
    if not Player then return false end
    return Player.PlayerData.job.name, Player.PlayerData.job.grade.level
end

function bridge.getDuty(source)
    local Player = QBX:GetPlayer(source)
    if not Player then return false end
    return Player.PlayerData.job.onduty or false
end

function bridge.getAccountFunds(source, account)
    if account == 'money' then account = 'cash' end
    local player = QBX:GetPlayer(source)
    if not player then return false end
    return player.PlayerData.money[account]
end

function bridge.removeAccountFunds(source, account, amount)
    if account == 'money' then account = 'cash' end
    local player = QBX:GetPlayer(source)
    if not player then return false end
    player.Functions.RemoveMoney(account, amount)
    return true
end

function bridge.addAccountFunds(source, account, amount)
    if account == 'money' then account = 'cash' end
    local player = QBX:GetPlayer(source)
    if not player then return false end
    player.Functions.AddMoney(account, amount)
    return true
end

function bridge.addSocietyFunds(society, amount)
    if type(society) ~= 'string' or society == '' or not amount or amount <= 0 then return false end

    if GetResourceState('qbx_management'):find('start') then
        local success = pcall(function()
            exports.qbx_management:AddMoney(society, amount)
        end)
        if success then return true end
    end

    return false
end

function bridge.hasItem(source, item, count, metadata)
    if inventory then
        return inventory.hasItem(source, item, count or 1, metadata or nil)
    end
end

function bridge.addItem(source, item, count, metadata)
    if inventory then
        return inventory.addItem(source, item, count or 1, metadata or nil)
    end
end

function bridge.removeItem(source, item, count, metadata, slot)
    if inventory then
        return inventory.removeItem(source, item, count or 1, metadata or nil, slot or nil)
    end
end

function bridge.registerUsableItem(itemName, afterUse, beforeUse)
    if inventory and type(inventory.registerUsableItem) == 'function' then
        return inventory.registerUsableItem(itemName, afterUse, beforeUse)
    end
    exports.qbx_core:CreateUseableItem(itemName, function(source, item)
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
    local Player = QBX:GetPlayer(source)

    if not Player then return nil end

    return normalizePlayerData(Player.PlayerData)
end

function bridge.resetPlayerNeeds(source)
    local Player = QBX:GetPlayer(source)

    if not Player then return end

    exports.qbx_core:SetMetadata(source, 'hunger', 100)
    exports.qbx_core:SetMetadata(source, 'thirst', 100)
    exports.qbx_core:SetMetadata(source, 'stress', 0)
end

function bridge.toggleDuty(source, onDuty)
    local Player = QBX:GetPlayer(source)

    if not Player then return end

    exports.qbx_core:SetJobDuty(source, onDuty)
end

function bridge.setPlayerDead(src, isDead)
    local _Player = QBX:GetPlayer(src)
    if _Player then
        _Player.Functions.SetMetaData('isdead', isDead)
        Player(src).state:set('isDead', isDead, true)

        if _Player.PlayerData.metadata.laststand then
            _Player.Functions.SetMetaData('inlaststand', false)
        end
    end
end

RegisterNetEvent('QBCore:Server:OnPlayerLoaded', function()
    TriggerEvent('wasabi_ambulance:PlayerLoaded', source)
end)

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
