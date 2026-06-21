local notify, config, bridge, compat

-- Only load if dispatch type is 'internal'
local dispatch = {}

---@return table
local function getAllowedJobs()
    return config.dispatch and config.dispatch.allowedJobs or config.ambulanceJobs
end

function dispatch.init()
    notify = Modules.require('notify')
    config = Modules.require('config')
    bridge = Modules.require('bridge')
    compat = Modules.require('compat')

    if not config.dispatch or config.dispatch.type ~= 'internal' then
        return
    end

    lib.addKeybind({
        name = 'wasabi_dispatch_menu',
        description = 'Open Medical Dispatch Menu',
        defaultKey = config.dispatch and config.dispatch.keybind or 'F6',
        onPressed = function()
            if bridge.hasGroup(getAllowedJobs()) then
                dispatch.openMenu()
            end
        end
    })
end

---@type table<number, { serverId: number, name: string, coords: vector3, timestamp: number, streetName: string }>
local distressedPlayers = {}

---@param coords vector3
---@return number
local function getDistanceToPlayer(coords)
    local playerCoords = GetEntityCoords(cache.ped)
    return #(playerCoords - coords)
end

---@param distanceMeters number
---@return string
local function formatDistance(distanceMeters)
    if distanceMeters < 1000 then
        return ("%.0fm"):format(distanceMeters)
    else
        return ("%.1fkm"):format(distanceMeters / 1000)
    end
end

---@param timestamp number
---@return string
local function formatTimeSince(timestamp)
    local diff = lib.callback.await('wasabi_ambulance:GetOSTime', false) - timestamp
    if diff < 60 then
        return ("%ds ago"):format(diff)
    elseif diff < 3600 then
        return ("%dm ago"):format(math.floor(diff / 60))
    else
        return ("%dh ago"):format(math.floor(diff / 3600))
    end
end

function dispatch.openMenu()
    local player = bridge.player
    if not player.loaded then return end

    if not bridge.getDuty() then
        notify({
            title = locale("dispatch_title"),
            description = locale("dispatch_must_be_on_duty"),
            type = "error"
        })
        return
    end

    if not bridge.hasGroup(getAllowedJobs()) then
        notify({
            title = locale("dispatch_title"),
            description = locale("dispatch_no_access"),
            type = "error"
        })
        return
    end

    local serverDistressed = lib.callback.await("wasabi_ambulance:Dispatch:GetDistressed", false)

    if not serverDistressed or not next(serverDistressed) then
        notify({
            title = locale("dispatch_title"),
            description = locale("dispatch_no_active_calls"),
            type = "info"
        })
        return
    end

    distressedPlayers = serverDistressed

    local sortedPlayers = {}
    for serverId, data in pairs(distressedPlayers) do
        data.distance = getDistanceToPlayer(data.coords)
        table.insert(sortedPlayers, data)
    end

    table.sort(sortedPlayers, function(a, b)
        return a.distance < b.distance
    end)

    local options = {}

    for i, data in ipairs(sortedPlayers) do
        options[#options + 1] = {
            title = data.name,
            description = ("%s • %s • %s"):format(
                data.streetName or "Unknown Location",
                formatDistance(data.distance),
                formatTimeSince(data.timestamp)
            ),
            icon = "heart-pulse",
            iconColor = "#ff4444",
            onSelect = function()
                dispatch.respondToDistress(data.serverId)
            end,
            metadata = {
                { label = "Distance",  value = formatDistance(data.distance) },
                { label = "Location",  value = data.streetName or "Unknown" },
                { label = "Time",      value = formatTimeSince(data.timestamp) },
                { label = "Server ID", value = tostring(data.serverId) }
            }
        }
    end

    lib.registerContext({
        id = 'wasabi_dispatch_menu',
        title = locale("dispatch_active_count"):format(#sortedPlayers),
        options = options
    })

    lib.showContext('wasabi_dispatch_menu')
end

---@param targetServerId number
function dispatch.respondToDistress(targetServerId)
    local locationData = lib.callback.await("wasabi_ambulance:Dispatch:GetPlayerLocation", false, targetServerId)

    if not locationData then
        notify({
            title = locale("dispatch_title"),
            description = locale("dispatch_patient_not_found"),
            type = "error"
        })
        return
    end

    SetNewWaypoint(locationData.coords.x, locationData.coords.y)

    notify({
        title = locale("dispatch_title"),
        description = locale("dispatch_waypoint_set"):format(locationData.name, locationData.streetName),
        type = "success"
    })

    lib.hideContext()
end

---@return number
function dispatch.getLocalDistressedCount()
    local count = 0
    for _ in pairs(distressedPlayers) do
        count = count + 1
    end
    return count
end

---@return table
function dispatch.getDistressedPlayers()
    return distressedPlayers
end

RegisterNetEvent("wasabi_ambulance:Dispatch:NewDistress", function(data)
    if not data or not data.serverId then return end

    distressedPlayers[data.serverId] = data

    PlaySoundFrontend(-1, "Menu_Accept", "Phone_SoundSet_Default", true)
end)

RegisterNetEvent("wasabi_ambulance:Dispatch:RemoveDistress", function(serverId)
    if distressedPlayers[serverId] then
        distressedPlayers[serverId] = nil
    end
end)

RegisterNetEvent("wasabi_ambulance:Dispatch:OpenMenu", function()
    if not bridge.hasGroup(getAllowedJobs()) then
        return
    end

    dispatch.openMenu()
end)

lib.callback.register("wasabi_ambulance:Dispatch:GetStreetName", function()
    local coords = GetEntityCoords(cache.ped)
    local streetHash, crossingHash = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
    local streetName = GetStreetNameFromHashKey(streetHash) or "Unknown"
    local crossingName = GetStreetNameFromHashKey(crossingHash)
    if crossingName and crossingName ~= "" then
        return streetName .. " / " .. crossingName
    end
    return streetName
end)

exports('openDispatchMenu', dispatch.openMenu)
exports('getLocalDistressedCount', dispatch.getLocalDistressedCount)

CreateThread(function()
    while not compat do Wait(100) end
    compat.exportHandler("openDispatchMenu", "wasabi_ambulance", dispatch.openMenu)
    compat.exportHandler("getLocalDistressedCount", "wasabi_ambulance", dispatch.getLocalDistressedCount)
end)

Modules.register("dispatch", dispatch, {
    dependencies = { 'notify', 'config', 'bridge', 'compat' }
})
