if not GetResourceState("ox_core"):find('start') then return end

local config, inventory

local Ox = require '@ox_core.lib.init'

local bridge = {}

bridge.framework = 'ox'

bridge.player = {
    name = '',
    groups = {},
    duty = false,
    charId = nil,
    loaded = false,
    statuses = {},
    limbs = {}
}

local function normalizePlayerData()
    local player = Ox.GetPlayer()

    if not player then return end

    local firstName = player.get('firstName') or ''
    local lastName = player.get('lastName') or ''
    bridge.player.name = firstName .. ' ' .. lastName
    bridge.player.groups = player.getGroups() or {}
    bridge.player.charId = player.charId

    -- ox_core uses "active group" concept, duty is typically determined by having an active group
    local activeGroup, activeGrade = player.getGroupByType('job')
    bridge.player.duty = activeGroup ~= nil
end

function bridge.init()
    config = Modules.require('config')
    inventory = Modules.get('inventory')
end

function bridge.hasGroup(filter)
    local player = Ox.GetPlayer()

    if not player then return false end

    local grade = player.getGroup(filter)

    return grade ~= nil
end

function bridge.getJob()
    local player = Ox.GetPlayer()
    if not player then return false end
    local activeGroup, activeGrade = player.getGroupByType('job')
    if not activeGroup then return false end
    return activeGroup, activeGrade
end

function bridge.getDuty()
    local player = Ox.GetPlayer()

    if not player then return false end

    -- In ox_core, duty is typically tied to having an active group of type 'job'
    local activeGroup = player.getGroupByType('job')

    return activeGroup ~= nil
end

function bridge.getAllJobOptions()
    local options = {}
    local groups = GlobalState.groups or {}

    for _, groupName in pairs(groups) do
        local groupData = GlobalState['group.' .. groupName]

        if groupData and groupData.type == 'job' then
            table.insert(options, {
                value = groupData.name,
                label = groupData.label
            })
        end
    end

    table.sort(options, function(a, b)
        return a.label < b.label
    end)

    return options
end

function bridge.openBossMenu()
    -- ox_core doesn't have a built-in boss menu like qbx_management
    -- This would need to be handled by a separate resource or custom implementation
    -- Attempting to trigger a generic event that could be handled by a management resource
    local player = Ox.GetPlayer()

    if not player then return end

    local groupName = player.getGroupByType('job')

    if groupName then
        TriggerEvent('ox:openBossMenu', groupName)
    end
end

function bridge.getMedicalItems()
    if inventory and inventory.getMedicalItems then
        return inventory.getMedicalItems()
    end

    local items = {}
    local player = Ox.GetPlayer()

    if not player then
        return items
    end

    local playerItems = exports.ox_inventory:GetPlayerItems()

    if not playerItems then
        return items
    end

    for _, item in pairs(playerItems) do
        if item and config and config.medicalItems and config.medicalItems[item.name] then
            local itemData = exports.ox_inventory:Items(item.name)
            items[#items + 1] = {
                slot = item.slot,
                name = item.name,
                count = item.count or 1,
                label = item.label,
                description = item.description or (item.metadata and item.metadata.description) or (itemData and itemData.description) or config.medicalItems[item.name].description,
                metadata = item.metadata or {},
            }
        end
    end

    return items
end

function bridge.setLocalDead(bool)
    LocalPlayer.state:set('isDead', bool, true)
    LocalPlayer.state:set('dead', bool, true) -- ox_inventory uses 'dead' instead of 'isDead', so set both to be safe
end

AddEventHandler('ox:playerLoaded', function(playerId, isNew)
    normalizePlayerData()
    bridge.player.loaded = true
    TriggerEvent('wasabi_ambulance:PlayerLoaded', bridge.player)
end)

RegisterNetEvent('ox:setGroup', function(groupName, grade)
    local player = Ox.GetPlayer()

    if not player then return end

    bridge.player.groups = player.getGroups() or {}

    -- Update duty status based on active group
    local activeGroup = player.getGroupByType('job')
    bridge.player.duty = activeGroup ~= nil
    TriggerServerEvent('wasabi_ambulance:setJob', bridge.player)
end)

lib.callback.register("wasabi_ambulance:GetJobOptions", function()
    return bridge.getAllJobOptions()
end)

CreateThread(function()
    if not Modules.awaitFullyReady(15000) then
        lib.print.warn('[bridge:ox] Timed out waiting for modules/entries to initialize')
    end

    local OxPlayer = Ox.GetPlayer()

    if OxPlayer?.charId then
        lib.print.debug('[bridge:ox] Player data found on resource start, normalizing and triggering PlayerLoaded event')
        normalizePlayerData()
        bridge.player.loaded = true
        TriggerEvent('wasabi_ambulance:PlayerLoaded', bridge.player)
    end
end)

Modules.register('bridge', bridge, {
    dependencies = { 'config' },
    optionalDependencies = { 'inventory' }
})

