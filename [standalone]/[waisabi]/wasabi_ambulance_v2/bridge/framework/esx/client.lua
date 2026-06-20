if not GetResourceState("es_extended"):find('start') then return end

local notify, config, inventory

local ESX = exports['es_extended']:getSharedObject()

local bridge = {}

bridge.framework = 'esx'

bridge.player = {
    name = '',
    groups = {},
    duty = false,
    charId = nil,
    loaded = false,
    statuses = {},
    limbs = {}
}

local function normalizePlayerData(playerData)
    local firstName = playerData.firstName or ''
    local lastName = playerData.lastName or ''
    bridge.player.name = firstName .. ' ' .. lastName
    bridge.player.groups = { [playerData.job.name] = playerData.job.grade }
    bridge.player.duty = playerData.job.onDuty or false
    bridge.player.charId = playerData.identifier
end

function bridge.init()
    notify = Modules.require('notify')
    config = Modules.require('config')
    inventory = Modules.get('inventory')
end

function bridge.hasGroup(filter)
    local playerData = ESX.GetPlayerData()

    if not playerData or not playerData.job then return false end

    local jobName = playerData.job.name
    local jobGrade = playerData.job.grade

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
    local playerData = ESX.GetPlayerData()
    if not playerData or not playerData.job then return false end
    return playerData.job.name, playerData.job.grade
end

function bridge.getDuty()
    local playerData = ESX.GetPlayerData()

    if not playerData or not playerData.job then return false end

    return playerData.job.onDuty or false
end

function bridge.getAllJobOptions()
    local options = {}
    local jobs = ESX.GetJobs()

    for jobName, jobData in pairs(jobs) do
        table.insert(options, {
            value = jobName,
            label = jobData.label
        })
    end

    table.sort(options, function(a, b)
        return a.label < b.label
    end)

    return options
end

function bridge.openBossMenu()
    local society = lib.callback.await('wasabi_ambulance:GetSociety', false, 'job')
    if not society then
        notify({
            title = locale('boss_menu_title'),
            description = locale('boss_menu_no_society_access'),
            type = 'error'
        })
        return
    end
    TriggerEvent('esx_society:openBossMenu', society, function(menu)
    end, { wash = false })
end

function bridge.getMedicalItems()
    if inventory and inventory.getMedicalItems then
        return inventory.getMedicalItems()
    end

    local items = {}

    local playerData = ESX.GetPlayerData()

    if not playerData or not playerData.inventory then
        return items
    end

    for _, item in pairs(playerData.inventory) do
        if item and config and config.medicalItems and config.medicalItems[item.name] then
            table.insert(items, {
                slot = item.slot,
                name = item.name,
                count = item.amount or item.count,
                label = item.label,
                description = item.description or (item.metadata and item.metadata.description) or (item.info and item.info.description) or config.medicalItems[item.name].description,
                metadata = item.metadata or item.info or {},
            })
        end
    end

    return items
end

function bridge.setLocalDead(bool)
    LocalPlayer.state:set('isDead', bool, true)
    LocalPlayer.state:set('dead', bool, true) -- ox_inventory uses 'dead' instead of 'isDead', so set both to be safe
    if not bool then
        TriggerEvent('esx:onPlayerSpawn')
        TriggerServerEvent('esx:onPlayerSpawn')
    end
end

RegisterNetEvent('esx:playerLoaded', function(xPlayer)
    if xPlayer then
        normalizePlayerData(xPlayer)
    end

    bridge.player.loaded = true

    TriggerEvent('wasabi_ambulance:PlayerLoaded', bridge.player)
end)

RegisterNetEvent('esx:setJob', function(job, lastJob)
    local playerData = ESX.GetPlayerData()

    if playerData then
        bridge.player.groups = { [job.name] = job.grade }
        bridge.player.duty = job.onDuty or false
    end
    TriggerServerEvent('wasabi_ambulance:setJob', bridge.player)
end)

lib.callback.register("wasabi_ambulance:GetJobOptions", function()
    return bridge.getAllJobOptions()
end)

CreateThread(function()
    if not Modules.awaitFullyReady(15000) then
        lib.print.warn('[bridge:esx] Timed out waiting for modules/entries to initialize')
    end

    if ESX.IsPlayerLoaded() then
        lib.print.debug('[bridge:esx] Player data found on resource start, normalizing and triggering PlayerLoaded event')
        normalizePlayerData(ESX.GetPlayerData())
        bridge.player.loaded = true
        TriggerEvent('wasabi_ambulance:PlayerLoaded', bridge.player)
    end
end)

Modules.register('bridge', bridge, {
    dependencies = { 'config', 'notify' },
    optionalDependencies = { 'inventory' }
})
