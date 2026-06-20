

local found = GetResourceState('es_extended')
if found ~= 'started' and found ~= 'starting' then return end

ESX = exports["es_extended"]:getSharedObject()
FLBridge = FLBridge or {}
FLBridge.framework = 'esx'

local PlayerDutyStatus = {}

AddEventHandler('esx:playerLoaded', function(playerId)
    PlayerDutyStatus[playerId] = true
end)

AddEventHandler('esx:playerDropped', function(playerId)
    PlayerDutyStatus[playerId] = nil
end)

RegisterNetEvent('flb:setDutyStatus', function(status)
    local source = source
    if type(status) == "boolean" then
        PlayerDutyStatus[source] = status
    end
end)

function FLBridge.getCore()
    return ESX
end

function FLBridge.getPlayer(source)
    return ESX.GetPlayerFromId(source)
end

function FLBridge.getPlayerFromIdentifier(identifier)
    local players = ESX.GetPlayers()
    for _, playerId in ipairs(players) do
        local xPlayer = ESX.GetPlayerFromId(playerId)
        if xPlayer and xPlayer.identifier == identifier then
            return xPlayer
        end
    end
    return false
end

function FLBridge.getPlayerIdFromIdentifier(identifier)
    local xPlayer = FLBridge.getPlayerFromIdentifier(identifier)
    return xPlayer and xPlayer.source or false
end

function FLBridge.getPlayers()
    return ESX.GetPlayers()
end

function FLBridge.getAllJobs()
    return ESX.GetJobs()
end

function FLBridge.kickPlayer(source, reason)
    DropPlayer(source, reason)
end

function FLBridge.hasPermission(source, group)
    local xPlayer = FLBridge.getPlayer(source)
    if not xPlayer then return false end
    if type(xPlayer.hasGroup) == 'function' then
        return xPlayer.hasGroup(group)
    end
    return xPlayer.group == group
end

function FLBridge.hasGroup(source, filter)
    local xPlayer = FLBridge.getPlayer(source)
    if not xPlayer then return end
    local type = type(filter)
    
    if type == 'string' then
        if xPlayer.job.name == filter then
            return xPlayer.job.name, xPlayer.job.grade
        end
        if xPlayer.group and xPlayer.group == filter then
            return xPlayer.group, 0
        end
    elseif type == 'table' then
        local tabletype = table.type(filter)
        if tabletype == 'hash' then
            local grade = filter[xPlayer.job.name]
            if grade and grade <= xPlayer.job.grade then
                return xPlayer.job.name, xPlayer.job.grade
            end
        elseif tabletype == 'array' then
            for i = 1, #filter do
                local group = filter[i]
                if xPlayer.job.name == group then
                    return xPlayer.job.name, xPlayer.job.grade
                end
            end
        end
    end
end

function FLBridge.setJob(source, job, grade)
    local xPlayer = FLBridge.getPlayer(source)
    if not xPlayer then return end
    xPlayer.setJob(job, grade)
end

function FLBridge.getJobData(source)
    local xPlayer = FLBridge.getPlayer(source)
    if not xPlayer then return end
    local job = xPlayer.job
    
    job.onduty = PlayerDutyStatus[source] == nil and true or PlayerDutyStatus[source]
    return job
end

function FLBridge.getJobLabel(source)
    local xPlayer = FLBridge.getPlayer(source)
    if not xPlayer then return end
    return xPlayer.job.label
end

function FLBridge.toggleDuty(source)
    local xPlayer = FLBridge.getPlayer(source)
    if not xPlayer then return end
    
    local currentDuty = PlayerDutyStatus[source]
    if currentDuty == nil then currentDuty = true end
    
    local newOnDuty = not currentDuty
    PlayerDutyStatus[source] = newOnDuty
    
    local job = xPlayer.job
    job.onduty = newOnDuty
    
    TriggerClientEvent('flb:updateDuty', source, newOnDuty)
    return newOnDuty and 'on' or 'off'
end

function FLBridge.isOnDuty(source)
    if PlayerDutyStatus[source] == nil then
        return true
    end
    return PlayerDutyStatus[source]
end

function FLBridge.isPlayerBoss(source)
    local xPlayer = FLBridge.getPlayer(source)
    if not xPlayer then return end
    local job = xPlayer.job
    return job.grade_name == 'boss'
end

function FLBridge.getIdentifier(source)
    local xPlayer = FLBridge.getPlayer(source)
    if not xPlayer then return end
    return xPlayer.identifier
end

function FLBridge.getName(source)
    local xPlayer = FLBridge.getPlayer(source)
    if not xPlayer then return end
    return xPlayer.name
end

function FLBridge.getNameFromPlayerObj(xPlayer)
    if not xPlayer then return end
    return xPlayer.name
end

function FLBridge.registerUsableItem(item, cb)
    ESX.RegisterUsableItem(item, cb)
end

function FLBridge.getPlayerInventory(source)
    local xPlayer = FLBridge.getPlayer(source)
    if not xPlayer then return {} end
    return xPlayer.inventory
end

function FLBridge.hasItem(source, _item)
    local xPlayer = FLBridge.getPlayer(source)
    if not xPlayer then return 0 end
    local item = xPlayer.getInventoryItem(_item)
    return item and item.count or 0
end

function FLBridge.addItem(source, item, count, metadata)
    local xPlayer = FLBridge.getPlayer(source)
    if not xPlayer then return end
    xPlayer.addInventoryItem(item, count)
end

function FLBridge.addWeapon(source, weapon, ammo)
    local xPlayer = FLBridge.getPlayer(source)
    if not xPlayer then return end
    xPlayer.addWeapon(weapon, ammo or 0)
end

function FLBridge.removeItem(source, item, count)
    local xPlayer = FLBridge.getPlayer(source)
    if not xPlayer then return end
    xPlayer.removeInventoryItem(item, count)
end

function FLBridge.addMoney(source, type, amount)
    if type == 'black_money' or type == 'dirty' then
        FLBridge.addItem(source, 'black_money', amount)
        return
    end
    if type == 'cash' then type = 'money' end
    local xPlayer = FLBridge.getPlayer(source)
    if not xPlayer then return end
    xPlayer.addAccountMoney(type, amount)
end

function FLBridge.removeMoney(source, type, amount)
    if type == 'black_money' or type == 'dirty' then
        FLBridge.removeItem(source, 'black_money', amount)
        return
    end
    if type == 'cash' then type = 'money' end
    local xPlayer = FLBridge.getPlayer(source)
    if not xPlayer then return end
    xPlayer.removeAccountMoney(type, amount)
end

function FLBridge.getPlayerAccountFunds(source, type)
    if type == 'cash' then type = 'money' end
    local xPlayer = FLBridge.getPlayer(source)
    if not xPlayer then return end
    local account = xPlayer.getAccount(type)
    return account and account.money or 0
end
