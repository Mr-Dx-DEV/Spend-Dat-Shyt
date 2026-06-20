if not GetResourceState("qbx_core"):find('start') then return end

local QBX = exports.qbx_core

local config, inventory

local bridge = {}

bridge.framework = 'qbx'

bridge.player = {
    name = '',
    groups = {},
    duty = false,
    charId = nil,
    loaded = false,
    statuses = {},
    limbs = {}
}

function bridge.init()
    config = Modules.require('config')
    inventory = Modules.get('inventory')
end

local function normalizePlayerData(playerData)
    bridge.player.name = playerData.charinfo.firstname .. ' ' .. playerData.charinfo.lastname
    bridge.player.groups = { [playerData.job.name] = playerData.job.grade.level }
    bridge.player.duty = playerData.job.onduty or false
    bridge.player.charId = playerData.citizenid
end

function bridge.hasGroup(filter)
    local playerData = QBX:GetPlayerData()

    if not playerData or not playerData.job then return false end

    local jobName = playerData.job.name
    local jobGrade = playerData.job.grade.level

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

function bridge.getJob()
    local playerData = QBX:GetPlayerData()
    if not playerData or not playerData.job then return false end
    return playerData.job.name, playerData.job.grade.level
end

function bridge.getDuty()
    return bridge.player.duty
end

function bridge.getAllJobOptions()
    local options = {}
    local jobs = QBX:GetJobs()

    for jobName, jobData in pairs(jobs) do
        options[#options + 1] = {
            value = jobName,
            label = jobData.label
        }
    end

    table.sort(options, function(a, b)
        return a.label < b.label
    end)

    return options
end

function bridge.openBossMenu()
    exports.qbx_management:OpenBossMenu("job")
end

function bridge.getMedicalItems()
    if inventory then
        return inventory.getMedicalItems()
    end

    local items = {}
    local Player = QBX:GetPlayerData()

    if not Player or not Player.items then
        return items
    end

    for slot, item in pairs(Player.items) do
        if item and config and config.medicalItems and config.medicalItems[item.name] then
            local itemData = QBX.Shared and QBX.Shared.Items and QBX.Shared.Items[item.name]
            items[#items + 1] = {
                slot = item.slot or slot,
                name = item.name,
                count = item.amount or item.count or 1,
                label = item.label,
                description = item.description or (item.info and item.info.description) or (itemData and itemData.description) or config.medicalItems[item.name].description,
                metadata = item.info or {},
            }
        end
    end

    return items
end

function bridge.setLocalDead(bool)
    LocalPlayer.state:set('isDead', bool, true)
    LocalPlayer.state:set('dead', bool, true) -- ox_inventory uses 'dead' instead of 'isDead', so set both to be safe
end

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    local playerData = QBX:GetPlayerData()

    if playerData and playerData.charinfo then
        normalizePlayerData(playerData)
    end

    bridge.player.loaded = true

    TriggerEvent('wasabi_ambulance:PlayerLoaded', bridge.player)
end)

RegisterNetEvent('QBCore:Client:SetDuty', function(onDuty)
    bridge.player.duty = onDuty
end)

RegisterNetEvent('qbx_core:client:onGroupUpdate', function(groupName, groupGrade)
    bridge.player.groups[groupName] = groupGrade
    TriggerServerEvent('wasabi_ambulance:setJob', bridge.player)
end)

lib.callback.register("wasabi_ambulance:GetJobOptions", function()
    return bridge.getAllJobOptions()
end)

CreateThread(function()
    if not Modules.awaitFullyReady(15000) then
        lib.print.warn('[bridge:qbx] Timed out waiting for modules/entries to initialize')
    end

    local playerData = QBX:GetPlayerData() or nil

    if playerData?.charinfo then
        lib.print.debug('[bridge:qbx] Player data found on resource start, normalizing and triggering PlayerLoaded event')
        normalizePlayerData(playerData)
        bridge.player.loaded = true
        TriggerEvent('wasabi_ambulance:PlayerLoaded', bridge.player)
    end
end)

Modules.register('bridge', bridge, {
    dependencies = { 'config' },
    optionalDependencies = { 'inventory' }
})

