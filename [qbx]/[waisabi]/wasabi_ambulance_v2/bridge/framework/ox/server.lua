if not GetResourceState("ox_core"):find('start') then return end

lib.print.debug("Ox Core framework detected, initializing bridge...")

local Ox = require '@ox_core.lib.init'

local config, inventory

local bridge = {}

local function normalizePlayerData(player)
    local firstName = player.get('firstName') or ''
    local lastName = player.get('lastName') or ''
    local gender = player.get('gender') or 'male'

    return {
        name = firstName .. ' ' .. lastName,
        groups = player.getGroups() or {},
        duty = player.getGroupByType('job') ~= nil,
        charId = player.charId,
        gender = gender == 'male' and 0 or 1
    }
end

bridge.framework = 'ox'

bridge.charTableInfo = { -- for foreign key constraints
    "characters",        -- table
    "charId",            -- id column
}

function bridge.init()
    config = Modules.require('config')
    inventory = Modules.get('inventory')
end

function bridge.getIdentifier(source)
    local player = Ox.GetPlayer(source)

    if not player then return nil end

    return player.charId
end

function bridge.hasGroup(source, filter)
    local player = Ox.GetPlayer(source)

    if not player then return false end

    local grade = player.getGroup(filter)

    return grade ~= nil
end

function bridge.getJob(source)
    local player = Ox.GetPlayer(source)
    if not player then return false end
    local activeGroup, activeGrade = player.getGroupByType('job')
    if not activeGroup then return false end
    return activeGroup, activeGrade
end

function bridge.getDuty(source)
    local player = Ox.GetPlayer(source)
    if not player then return false end
    local activeGroup = player.get('activeGroup')
    return activeGroup and config and lib.table.contains(config.ambulanceJobs, activeGroup)
end

function bridge.getAccountFunds(source, account)
    if account == 'cash' then account = 'money' end
    local player = Ox.GetPlayer(source)
    if not player then return false end
    return player.getMoney(account)
end

function bridge.removeAccountFunds(source, account, amount)
    if account == 'cash' then account = 'money' end
    local player = Ox.GetPlayer(source)
    if not player then return false end
    player.removeMoney(account, amount)
    return true
end

function bridge.addAccountFunds(source, account, amount)
    if account == 'cash' then account = 'money' end
    local player = Ox.GetPlayer(source)
    if not player then return false end
    player.addMoney(account, amount)
    return true
end

function bridge.addSocietyFunds(society, amount)
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
end

function bridge.getPlayer(source)
    local player = Ox.GetPlayer(source)

    if not player then return nil end

    return normalizePlayerData(player)
end

function bridge.resetPlayerNeeds(source)
    local player = Ox.GetPlayer(source)

    if not player then return end

    player.setStatus('hunger', 100)
    player.setStatus('thirst', 100)
    player.setStatus('stress', 0)
end

function bridge.toggleDuty(source, onDuty)
    local player = Ox.GetPlayer(source)

    if not player then return end

    if onDuty then
        player.setActiveGroup("ambulance")
    else
        player.setActiveGroup()
    end
end

function bridge.setPlayerDead(src, isDead)
    Player(src).state:set('isDead', isDead, true)
end

AddEventHandler('ox:playerLoaded', function(playerId, userId, charId)
    TriggerEvent('wasabi_ambulance:PlayerLoaded', playerId)
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
    dependencies = { 'config' },
    optionalDependencies = { 'inventory' }
})
