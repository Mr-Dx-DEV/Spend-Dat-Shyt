if not GetResourceState("es_extended"):find('start') then return end

lib.print.debug("ESX framework detected, initializing bridge...")

local ESX = exports['es_extended']:getSharedObject()

local bridge = {}

local inventory

local function normalizePlayerData(xPlayer) --- normalize player data to our shape
    local firstName = xPlayer.get('firstName') or ''
    local lastName = xPlayer.get('lastName') or ''
    local sex = xPlayer.get('sex') or xPlayer.getSex and xPlayer.getSex() or 0

    return {
        name = firstName .. ' ' .. lastName,
        groups = { [xPlayer.getJob().name] = xPlayer.getJob().grade },
        duty = xPlayer.getJob().onDuty or false,
        charId = xPlayer.getIdentifier(),
        gender = sex
    }
end

bridge.framework = 'esx'

bridge.charTableInfo = { -- for foreign key constraints
    "users",             -- table
    "identifier",        -- id column
}


function bridge.init()
    inventory = Modules.get('inventory')
end

function bridge.getIdentifier(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then return nil end

    return xPlayer.getIdentifier()
end

function bridge.hasGroup(source, filter)
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then return false end

    local job = xPlayer.getJob()
    local jobName = job.name
    local jobGrade = job.grade

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
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return false end
    return xPlayer.getJob().name, xPlayer.getJob().grade
end

function bridge.getDuty(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return false end
    return xPlayer.getJob().onDuty or false
end

function bridge.getAccountFunds(source, account)
    if account == 'cash' then account = 'money' end
    local player = ESX.GetPlayerFromId(source)
    if not player then return false end
    return player.getAccount(account).money or 0
end

function bridge.removeAccountFunds(source, account, amount)
    if account == 'cash' then account = 'money' end
    local player = ESX.GetPlayerFromId(source)
    if not player then return false end
    player.removeAccountMoney(account, amount)
    return true
end

function bridge.addAccountFunds(source, account, amount)
    if account == 'cash' then account = 'money' end
    local player = ESX.GetPlayerFromId(source)
    if not player then return false end
    player.addAccountMoney(account, amount)
    return true
end

function bridge.addSocietyFunds(society, amount)
    if type(society) ~= 'string' or society == '' or not amount or amount <= 0 then return false end
    if not society:find('society_', 1, true) then society = 'society_' .. society end

    local success = false
    TriggerEvent('esx_addonaccount:getSharedAccount', society, function(account)
        if not account then return end
        account.addMoney(amount)
        success = true
    end)

    return success
end

function bridge.hasItem(source, item, amount, metadata)
    if inventory then
        return inventory.hasItem(source, item, amount or 1, metadata or nil)
    end

    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return false end

    -- Default ESX inventory/Cheeza inventory support
    -- Uncomment  under this if you want to use the default ESX inventory/Cheeza inventory

    -- local itemName = string.upper(item)
    -- if itemName:sub(1, 7) == 'WEAPON_' then
    --     return xPlayer.hasWeapon(itemName) or false
    -- end

    -- Uncomment above this if you want to use the default ESX inventory/Cheeza inventory

    local itemData = xPlayer.getInventoryItem(item)

    return itemData and (itemData.count or itemData.amount or 0) or 0 > 0
end

function bridge.addItem(source, item, count, metadata)
    if inventory then
        return inventory.addItem(source, item, count or 1, metadata or nil)
    end

    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return false end
    xPlayer.addInventoryItem(item, count or 1, metadata or nil)
    return true
end

function bridge.removeItem(source, item, count, metadata, slot)
    if inventory then
        return inventory.removeItem(source, item, count or 1, metadata or nil, slot or nil)
    end
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return false end
    xPlayer.removeInventoryItem(item, count or 1, metadata or nil, slot or nil)
    return true
end

function bridge.registerUsableItem(itemName, afterUse, beforeUse)
    if inventory and type(inventory.registerUsableItem) == 'function' then
        return inventory.registerUsableItem(itemName, afterUse, beforeUse)
    end

    ESX.RegisterUsableItem(itemName, function(source)
        if beforeUse and type(beforeUse) == 'function' then
            local beforeUseResult = beforeUse(source, itemName)
            if beforeUseResult == false then
                return
            end
        end
        if afterUse and type(afterUse) == 'function' then
            afterUse(source, itemName)
        end
    end)
end

function bridge.getPlayer(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then return nil end

    return normalizePlayerData(xPlayer)
end

function bridge.resetPlayerNeeds(source)
    -- Reset player hunger/thirst/stress to reasonable values after revive/heal
    -- ESX uses esx_status for needs management
    TriggerClientEvent('esx_status:set', source, 'hunger', 1000000)
    TriggerClientEvent('esx_status:set', source, 'thirst', 1000000)
    TriggerClientEvent('esx_status:set', source, 'stress', 0)
end

function bridge.toggleDuty(source, onDuty)
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then return end

    xPlayer.setJob(xPlayer.getJob().name, xPlayer.getJob().grade, onDuty)
end

local registeredSocieties = {}
lib.callback.register("wasabi_ambulance:GetSociety", function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return false end
    local job = xPlayer.job
    if not job or not job.name then return false end
    if job.grade_name ~= 'boss' then return false end

    if not registeredSocieties[job.name] then
        TriggerEvent('esx_society:registerSociety', job.name, job.name, 'society_' .. job.name,
            'society_' .. job.name, 'society_' .. job.name, { type = 'public' })
        registeredSocieties[job.name] = true
    end

    return job.name
end)

function bridge.setPlayerDead(src, isDead)
    Player(src).state:set('isDead', isDead, true)
    if isDead then
        bridge.resetPlayerNeeds(src)
    end
end

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer, isNew)
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
    optionalDependencies = { 'inventory' }
})
