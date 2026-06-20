local notify, config, bridge, compat

local dispatch = {}

function dispatch.init()
    notify = Modules.require('notify')
    config = Modules.require('config')
    bridge = Modules.require('bridge')
    compat = Modules.require('compat')

    if not config.dispatch or config.dispatch.type ~= 'internal' then
        return
    end
end

---@class DistressData
---@field serverId number
---@field name string
---@field coords vector3
---@field timestamp number
---@field streetName string

---@type table<number, DistressData>
local distressedPlayers = {}

---@return table
local function getAllowedJobs()
    return config.dispatch and config.dispatch.allowedJobs or config.ambulanceJobs
end

---@param source number
---@return string
local function getStreetName(source)
    local streetName = lib.callback.await("wasabi_ambulance:Dispatch:GetStreetName", source)
    return streetName or "Unknown"
end

---@param source number
---@return vector3|nil
local function getPlayerCoords(source)
    local ped = GetPlayerPed(source)
    if not ped or ped == 0 then return nil end
    return GetEntityCoords(ped)
end

---@param source number
function dispatch.addToDistress(source)
    local player = bridge.getPlayer(source)
    if not player then return end

    local coords = getPlayerCoords(source)
    if not coords then return end

    distressedPlayers[source] = {
        serverId = source,
        name = player.name,
        coords = coords,
        timestamp = os.time(),
        streetName = getStreetName(source)
    }

    for _, playerId in ipairs(GetPlayers()) do
        local id = tonumber(playerId)
        if id and id ~= source then
            if bridge.hasGroup(id, getAllowedJobs()) then
                local targetPlayer = bridge.getPlayer(id)
                if targetPlayer and targetPlayer.duty then
                    notify(id, {
                        title = locale("dispatch_title"),
                        description = locale("dispatch_new_distress"):format(player.name, distressedPlayers[source].streetName),
                        type = "info",
                        duration = 10000
                    })
                    TriggerClientEvent("wasabi_ambulance:Dispatch:NewDistress", id, distressedPlayers[source])
                end
            end
        end
    end
end

---@param source number
function dispatch.removeFromDistress(source)
    if distressedPlayers[source] then
        distressedPlayers[source] = nil

        for _, playerId in ipairs(GetPlayers()) do
            local id = tonumber(playerId)
            if id then
                TriggerClientEvent("wasabi_ambulance:Dispatch:RemoveDistress", id, source)
            end
        end
    end
end

---@param serverId number
---@return boolean
function dispatch.isPlayerInDistress(serverId)
    return distressedPlayers[serverId] ~= nil
end

---@return number
function dispatch.getDistressedCount()
    local count = 0
    for _ in pairs(distressedPlayers) do
        count = count + 1
    end
    return count
end

---@return table<number, DistressData>
function dispatch.getDistressedPlayers()
    return distressedPlayers
end

---@param serverId number
---@return DistressData|nil
function dispatch.getDistressData(serverId)
    return distressedPlayers[serverId]
end

---@param serverId number
---@return vector3|nil
function dispatch.updateAndGetPlayerCoords(serverId)
    if not distressedPlayers[serverId] then return nil end

    local coords = getPlayerCoords(serverId)
    if coords then
        distressedPlayers[serverId].coords = coords
        distressedPlayers[serverId].streetName = getStreetName(serverId)
    end

    return coords
end

lib.callback.register("wasabi_ambulance:Dispatch:GetDistressed", function(source)
    local player = bridge.getPlayer(source)
    if not player then return {} end

    if not bridge.hasGroup(source, getAllowedJobs()) then
        return {}
    end

    if not player.duty then
        notify(source, {
            title = locale("dispatch_title"),
            description = locale("dispatch_must_be_on_duty"),
            type = "error"
        })
        return {}
    end

    local updatedList = {}
    for serverId, data in pairs(distressedPlayers) do
        local coords = getPlayerCoords(serverId)
        if coords then
            data.coords = coords
            data.streetName = getStreetName(serverId)
            updatedList[serverId] = data
        end
    end

    return updatedList
end)

lib.callback.register("wasabi_ambulance:Dispatch:GetPlayerLocation", function(source, targetServerId)
    local player = bridge.getPlayer(source)
    if not player then return nil end

    if not bridge.hasGroup(source, getAllowedJobs()) then
        return nil
    end

    if not player.duty then
        return nil
    end

    if not distressedPlayers[targetServerId] then
        notify(source, {
            title = locale("dispatch_title"),
            description = locale("dispatch_no_longer_distress"),
            type = "info"
        })
        return nil
    end

    local coords = getPlayerCoords(targetServerId)
    if not coords then
        return nil
    end

    distressedPlayers[targetServerId].coords = coords
    distressedPlayers[targetServerId].streetName = getStreetName(targetServerId)

    return {
        coords = coords,
        name = distressedPlayers[targetServerId].name,
        streetName = distressedPlayers[targetServerId].streetName
    }
end)

lib.addCommand('dispatch', {
    help = locale("dispatch_command_help"),
}, function(source, args, raw)
    TriggerClientEvent("wasabi_ambulance:Dispatch:OpenMenu", source)
end)

local id = 999999
if config and config.debug then
    lib.addCommand('testdispatch', {
        help = 'Test receiving an EMS ping (debug only)',
    }, function(source)
        local ped = GetPlayerPed(source)
        local coords = ped and ped ~= 0 and GetEntityCoords(ped) or vector3(0, 0, 0)
        local fakeData = {
            serverId = id,
            name = 'Test Patient',
            coords = coords,
            timestamp = os.time(),
            streetName = 'Test Street',
        }
        distressedPlayers[id] = fakeData
        notify(source, {
            title = locale("dispatch_title"),
            description = locale("dispatch_new_distress"):format(fakeData.name, fakeData.streetName),
            type = "info",
            duration = 10000
        })
        TriggerClientEvent("wasabi_ambulance:Dispatch:NewDistress", source, fakeData)
    end)
end

AddStateBagChangeHandler('wasabi:deathState', nil, function(bagName, key, value, reserved, replicated)
    local playerId = GetPlayerFromStateBagName(bagName)
    if not playerId or playerId == 0 then return end

    if not value or value == 0 then
        dispatch.removeFromDistress(playerId)
    end
end)

AddEventHandler('playerDropped', function(reason)
    local src = source
    dispatch.removeFromDistress(src)
end)

exports('isPlayerInDistress', dispatch.isPlayerInDistress)
exports('removeFromDistress', dispatch.removeFromDistress)
exports('getDistressedCount', dispatch.getDistressedCount)
exports('addToDistress', dispatch.addToDistress)

CreateThread(function()
    while not compat do Wait(100) end
    compat.exportHandler("isPlayerInDistress", "wasabi_ambulance", dispatch.isPlayerInDistress)
    compat.exportHandler("removeFromDistress", "wasabi_ambulance", dispatch.removeFromDistress)
    compat.exportHandler("getDistressedCount", "wasabi_ambulance", dispatch.getDistressedCount)
    compat.exportHandler("addToDistress", "wasabi_ambulance", dispatch.addToDistress)
end)

Modules.register("dispatch", dispatch, {
    dependencies = { 'notify', 'config', 'bridge', 'compat' }
})
