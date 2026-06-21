local QBCore = exports['qb-core']:GetCoreObject()
local Inventory = exports.ox_inventory
local playerPositions = {}

local function notify(source, type, description)
    TriggerClientEvent('ox_lib:notify', source, { type = type, description = description })
end

local function logAction(source, action, message)
    TriggerEvent('qb-log:server:CreateLog', 'adminactions', 'Admin Action: ' .. action, 'default', message, false)
end

local function isValidPlayer(target)
    return GetPlayerPed(target) ~= 0
end

lib.addCommand('cid', {
    help = 'Display your character ID',
    restricted = false
}, function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end

    local cid = Player.PlayerData.citizenid
    if cid then
        notify(source, 'inform', cid)
    else
        notify(source, 'error', 'CID not found!')
    end
end)

lib.addCommand('sendback', {
    help = 'Send a player back to their previous position',
    params = {
        { name = 'target', type = 'playerId', help = 'Target player\'s server ID' }
    },
    restricted = 'qbcore.mod'
}, function(source, args)
    local target = args.target
    if not isValidPlayer(target) then
        notify(source, 'error', 'Invalid player ID')
        return
    end

    if not playerPositions[target] then
        notify(source, 'error', 'No previous position found for player')
        return
    end

    local targetPed = GetPlayerPed(target)
    local coords = playerPositions[target]
    SetEntityCoords(targetPed, coords.x, coords.y, coords.z, false, false, false, true)
    playerPositions[target] = nil
    notify(source, 'success', ('Sent player %d back'):format(target))
    notify(target, 'inform', 'You were sent back to your previous position')
    logAction(source, 'moderator', ('sent player %d back'):format(target))
end)

-- /vec2
lib.addCommand('vec2', {
    help = 'Copy 2D vector of your position to clipboard',
}, function(source)
    local playerPed = GetPlayerPed(source)
    local coords = GetEntityCoords(playerPed)
    TriggerClientEvent('admin:copyVector', source, { x = coords.x, y = coords.y, type = 'vec2' })
    notify(source, 'success', 'Copied 2D vector to clipboard')
end)

-- /vec3
lib.addCommand('vec3', {
    help = 'Copy 3D vector of your position to clipboard',
}, function(source)
    local playerPed = GetPlayerPed(source)
    local coords = GetEntityCoords(playerPed)
    TriggerClientEvent('admin:copyVector', source, { x = coords.x, y = coords.y, z = coords.z, type = 'vec3' })
    notify(source, 'success', 'Copied 3D vector to clipboard')
end)

-- /vec4
lib.addCommand('vec4', {
    help = 'Copy 4D vector (position + heading) to clipboard',
}, function(source)
    local playerPed = GetPlayerPed(source)
    local coords = GetEntityCoords(playerPed)
    local heading = GetEntityHeading(playerPed)
    TriggerClientEvent('admin:copyVector', source, { x = coords.x, y = coords.y, z = coords.z, w = heading, type = 'vec4' })
    notify(source, 'success', 'Copied 4D vector to clipboard')
end)