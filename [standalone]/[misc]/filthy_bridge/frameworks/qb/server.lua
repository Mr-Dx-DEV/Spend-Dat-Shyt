

local found = GetResourceState('qb-core')
if found ~= 'started' and found ~= 'starting' then return end

QBCore = exports['qb-core']:GetCoreObject()
FLBridge = FLBridge or {}
FLBridge.framework = 'qb'

local qbx = GetResourceState('qbx_core')
local qboxFound = qbx == 'started' or qbx == 'starting' or false

local oxInventory = GetResourceState('ox_inventory')
local oxFound = oxInventory == 'started' or oxInventory == 'starting' or false

function FLBridge.getCore()
    return QBCore
end

function FLBridge.getPlayer(source)
    if qboxFound then
        return exports.qbx_core:GetPlayer(source)
    end
    return QBCore.Functions.GetPlayer(source)
end

function FLBridge.getPlayerFromIdentifier(identifier)
    local player = qboxFound and exports.qbx_core:GetPlayerByCitizenId(identifier) or
        QBCore.Functions.GetPlayerByCitizenId(identifier)
    if not player then return false end
    return player
end

function FLBridge.getPlayerIdFromIdentifier(identifier)
    local player = qboxFound and exports.qbx_core:GetPlayerByCitizenId(identifier) or
        QBCore.Functions.GetPlayerByCitizenId(identifier)
    if not player then return false end
    return player.PlayerData.source
end

function FLBridge.getPlayers()
    if qboxFound then
        return exports.qbx_core:GetQBPlayers()
    end
    return QBCore.Functions.GetPlayers()
end

function FLBridge.getAllJobs()
    local jobs = qboxFound and exports.qbx_core:GetJobs() or QBCore and QBCore.Shared and QBCore.Shared.Jobs or nil
    local returnTb = {}
    if not next(jobs) then return end
    for k, v in pairs(jobs) do
        returnTb[k] = { label = v.label }
        if v.grades then
            for a, b in pairs(v.grades) do
                if not returnTb[k].grades then returnTb[k].grades = {} end
                local payment = 0
                if b then
                    if b.salary then payment = b.salary
                    elseif b.payment then payment = b.payment end
                end
                returnTb[k].grades[a] = {
                    payment = payment,
                    name = b.name,
                    label = (b and b.label) or b.name
                }
            end
        end
    end
    return returnTb
end

function FLBridge.kickPlayer(source, reason)
    if qboxFound then
        return exports.qbx_core:ExploitBan(source, reason)
    end
    QBCore.Functions.Kick(source, reason, true, true)
end

function FLBridge.hasPermission(source, group)
    if qboxFound then
        return exports.qbx_core:HasPermission(source, group) or false
    end
    return QBCore.Functions.HasPermission(source, group)
end

function FLBridge.hasGroup(source, filter)
    local player = FLBridge.getPlayer(source)
    if not player or not player.PlayerData then return end
    local groups = { 'job', 'gang' }
    local type = type(filter)

    if type == 'string' then
        for i = 1, #groups do
            local data = player.PlayerData[groups[i]]
            if data and data.name == filter then
                return data.name, data.grade.level
            end
        end
    elseif type == 'table' then
        local tabletype = table.type(filter)
        if tabletype == 'hash' then
            for i = 1, #groups do
                local data = player.PlayerData[groups[i]]
                if data then
                    local grade = filter[data.name]
                    if grade and grade <= data.grade.level then
                        return data.name, data.grade.level
                    end
                end
            end
        elseif tabletype == 'array' then
            for i = 1, #filter do
                local group = filter[i]
                for j = 1, #groups do
                    local data = player.PlayerData[groups[j]]
                    if data and data.name == group then
                        return data.name, data.grade.level
                    end
                end
            end
        end
    end
end

function FLBridge.setJob(source, job, grade)
    local player = FLBridge.getPlayer(source)
    if not player then return end
    player.Functions.SetJob(job, grade)
end

function FLBridge.getJobData(source)
    local player = FLBridge.getPlayer(source)
    if not player then return end
    return player.PlayerData.job
end

function FLBridge.getJobLabel(source)
    local player = FLBridge.getPlayer(source)
    if not player then return end
    return player.PlayerData.job.label
end

function FLBridge.toggleDuty(source)
    local player = FLBridge.getPlayer(source)
    if not player then return end
    if player.PlayerData.job.onduty then
        player.Functions.SetJobDuty(false)
        return 'off'
    else
        player.Functions.SetJobDuty(true)
        return 'on'
    end
end

function FLBridge.isPlayerBoss(source)
    local player = FLBridge.getPlayer(source)
    if not player then return end
    return player?.PlayerData?.job?.isboss == true
end

function FLBridge.getIdentifier(source)
    local player = FLBridge.getPlayer(source)
    if not player then return end
    return player.PlayerData.citizenid
end

function FLBridge.getName(source)
    local player = FLBridge.getPlayer(source)
    if not player then return end
    return player.PlayerData.charinfo.firstname .. ' ' .. player.PlayerData.charinfo.lastname
end

function FLBridge.getNameFromPlayerObj(player)
    if not player then return end
    return player.PlayerData.charinfo.firstname .. ' ' .. player.PlayerData.charinfo.lastname
end

function FLBridge.registerUsableItem(item, cb)
    if qboxFound then
        exports.qbx_core:CreateUseableItem(item, cb)
    else
        QBCore.Functions.CreateUseableItem(item, cb)
    end
end

function FLBridge.getPlayerInventory(source)
    local player = FLBridge.getPlayer(source)
    if not player then return end
    local cleanedItems, count = {}, 0
    for _, item in pairs(player.PlayerData.items) do
        if item then
            count = count + 1
            cleanedItems[count] = item
            cleanedItems[count].amount = cleanedItems[count].count or cleanedItems[count].amount
            cleanedItems[count].count = cleanedItems[count].count or cleanedItems[count].amount
        end
    end
    return cleanedItems or {}
end

function FLBridge.hasItem(source, _item)
    if qboxFound or oxFound then
        return exports.ox_inventory:GetItem(source, _item, nil, true) or 0
    end
    local player = FLBridge.getPlayer(source)
    if not player then return end
    local item = player.Functions.GetItemByName(_item)
    return item?.count or item?.amount or 0
end

function FLBridge.addItem(source, item, count, slot, metadata)
    if qboxFound or oxFound then
        return exports.ox_inventory:AddItem(source, item, count, metadata, slot)
    end

    local success = exports['qb-inventory']:AddItem(source, item, count, false, metadata)
    if success then
        local itemData = QBCore.Shared.Items[string.lower(item)]
        if itemData then
            TriggerClientEvent('qb-inventory:client:ItemBox', source, itemData, 'add', count)
        end
    end
    return success
end

function FLBridge.addWeapon(source, weapon, ammo)
    if qboxFound or oxFound then
        return exports.ox_inventory:AddItem(source, weapon, 1)
    end

    local success = exports['qb-inventory']:AddItem(source, weapon, 1, false, false)
    if success then
        local itemData = QBCore.Shared.Items[string.lower(weapon)]
        if itemData then
            TriggerClientEvent('qb-inventory:client:ItemBox', source, itemData, 'add', 1)
        end
    end
    return success
end

function FLBridge.removeItem(source, item, count, slot, metadata)
    if qboxFound or oxFound then
        return exports.ox_inventory:RemoveItem(source, item, count, metadata, slot)
    end

    local Player = FLBridge.getPlayer(source)
    if not Player then return false end

    if slot then
        local success = exports['qb-inventory']:RemoveItem(source, item, count, slot)
        if success then
            local itemData = QBCore.Shared.Items[string.lower(item)]
            if itemData then
                TriggerClientEvent('qb-inventory:client:ItemBox', source, itemData, 'remove', count)
            end
        end
        return success
    end

    local items = Player.Functions.GetItemsByName(item)
    if not items then return false end
    if items.amount then items = { items } end

    local remaining = count
    for _, i in pairs(items) do
        if remaining <= 0 then break end
        if type(i) == 'table' and i.amount and i.slot then
            local toRemove = math.min(remaining, tonumber(i.amount))
            if exports['qb-inventory']:RemoveItem(source, item, toRemove, i.slot) then
                remaining = remaining - toRemove
            end
        end
    end

    if remaining <= 0 then
        local itemData = QBCore.Shared.Items[string.lower(item)]
        if itemData then
            TriggerClientEvent('qb-inventory:client:ItemBox', source, itemData, 'remove', count)
        end
        return true
    end
    return false
end

function FLBridge.addMoney(source, type, amount)
    if type == 'black_money' then
        FLBridge.addItem(source, 'black_money', amount)
        return true
    end
    if type == 'money' then type = 'cash' end
    local player = FLBridge.getPlayer(source)
    if not player then return false end
    if not player.PlayerData.money[type] then return false end
    player.Functions.AddMoney(type, amount)
    return true
end

function FLBridge.removeMoney(source, type, amount)
    if type == 'black_money' then
        FLBridge.removeItem(source, 'black_money', amount)
        return true
    end
    if type == 'money' then type = 'cash' end
    local player = FLBridge.getPlayer(source)
    if not player then return false end
    if not player.PlayerData.money[type] then return false end
    local success = player.Functions.RemoveMoney(type, amount)
    return success == true
end

function FLBridge.hasLicense(source, license)
    local player = FLBridge.getPlayer(source)
    if not player then return end
    local licenses = player.PlayerData.metadata['licences']
    if licenses and licenses[license] then return true end
    return false
end

function FLBridge.grantLicense(source, license)
    local player = FLBridge.getPlayer(source)
    if not player then return false end
    local licenses = player.PlayerData.metadata['licences']
    if licenses and licenses[license] then return false end
    if not licenses then licenses = {} end
    licenses[license] = true
    player.Functions.SetMetaData('licences', licenses)
    return true
end

function FLBridge.revokeLicense(source, license)
    local targetPlayer = FLBridge.getPlayer(source)
    if not targetPlayer then return end
    local Oldlicenses = targetPlayer.PlayerData.metadata['licences']
    if not Oldlicenses[license] then return end
    local licenses = {}
    for k, v in pairs(Oldlicenses) do
        if k ~= license then
            licenses[k] = v
        end
    end
    targetPlayer.Functions.SetMetaData('licences', licenses)
end

function FLBridge.getPlayerAccountFunds(source, type)
    if type == 'money' then type = 'cash' end
    local player = FLBridge.getPlayer(source)
    if not player then return 0 end
    return player.PlayerData.money[type] or 0
end

FLBridge.getPlayerIdentity = function(source)
    local player = FLBridge.getPlayer(source)
    if not player then return end
    local data = {
        name = player.PlayerData.charinfo.firstname .. ' ' .. player.PlayerData.charinfo.lastname,
        job = player.PlayerData.job.label,
        position = player.PlayerData.job.grade.name,
        dob = player.PlayerData.charinfo.birthdate,
        licenses = {}
    }
    if player.PlayerData.charinfo.gender == 1 then
        data.sex = 'female'
    else
        data.sex = 'male'
    end
    if player.PlayerData.metadata['licences'] then
        for k, v in pairs(player.PlayerData.metadata['licences']) do
            if v then
                data.licenses[#data.licenses + 1] = { type = k }
            end
        end
    end
    return data
end

function FLBridge.getVehicleOwner(plate)
    local owner
    MySQL.Async.fetchAll('SELECT citizenid FROM player_vehicles WHERE plate = @plate', { ['@plate'] = plate }, function(result)
        if result[1] then
            local identifier = result[1].citizenid
            MySQL.Async.fetchAll('SELECT charinfo FROM players WHERE citizenid = @identifier', { ['@identifier'] = identifier }, function(result2)
                if result2[1] then
                    local charData = json.decode(result2[1].charinfo)
                    owner = charData.firstname .. ' ' .. charData.lastname
                else
                    owner = false
                end
            end)
        else
            owner = false
        end
    end)
    while owner == nil do Wait(0) end
    return owner
end
