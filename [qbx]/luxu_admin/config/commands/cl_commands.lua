local commands = Config.commands

---@return vector3 | nil
local function findCoords(ped, x, y)
    local start = 950.0

    for i = start, 0, -25.0 do
        local z = i
        if (i % 2) ~= 0 then
            z = start - i
        end

        NewLoadSceneStart(x, y, z, x, y, z, 50.0, 0)
        local curTime = GetGameTimer()
        while IsNetworkLoadingScene() do
            if GetGameTimer() - curTime > 1000 then
                break
            end
            Wait(0)
        end
        NewLoadSceneStop()
        SetPedCoordsKeepVehicle(ped, x, y, z)

        while not HasCollisionLoadedAroundEntity(ped) do
            RequestCollisionAtCoord(x, y, z)
            if GetGameTimer() - curTime > 1000 then
                break
            end
            Wait(0)
        end

        -- Get ground coord. As mentioned in the natives, this only works if the client is in render distance.
        local found, groundZ = GetGroundZFor_3dCoord(x, y, z, false);
        if found then
            Wait(0)
            return vector3(x, y, groundZ)
        end
        Wait(0)
    end
    return nil
end

local function teleportToMarker()
    local GetEntityCoords = GetEntityCoords
    local GetGroundZFor_3dCoord = GetGroundZFor_3dCoord
    local GetFirstBlipInfoId = GetFirstBlipInfoId
    local DoesBlipExist = DoesBlipExist
    local DoScreenFadeOut = DoScreenFadeOut
    local GetBlipInfoIdCoord = GetBlipInfoIdCoord
    local GetVehiclePedIsIn = GetVehiclePedIsIn


    local blipMarker = GetFirstBlipInfoId(8)
    if not DoesBlipExist(blipMarker) then
        Luxu.notify(Locales.no_waypoint_set, Locales["error"], 2000)
        return 'marker'
    end

    -- Fade screen to hide how clients get teleported.
    DoScreenFadeOut(650)
    while not IsScreenFadedOut() do
        Wait(0)
    end

    local ped, coords = PlayerPedId(), GetBlipInfoIdCoord(blipMarker)
    local vehicle = GetVehiclePedIsIn(ped, false)
    local oldCoords = GetEntityCoords(ped)

    -- Unpack coords instead of having to unpack them while iterating.
    -- 825.0 seems to be the max a player can reach while 0.0 being the lowest.
    local x, y, groundZ, Z_START = coords['x'], coords['y'], 850.0, 950.0
    local found = false
    if vehicle > 0 then
        FreezeEntityPosition(vehicle, true)
    else
        FreezeEntityPosition(ped, true)
    end

    for i = Z_START, 0, -25.0 do
        local z = i
        if (i % 2) ~= 0 then
            z = Z_START - i
        end

        NewLoadSceneStart(x, y, z, x, y, z, 50.0, 0)
        local curTime = GetGameTimer()
        while IsNetworkLoadingScene() do
            if GetGameTimer() - curTime > 1000 then
                break
            end
            Wait(0)
        end
        NewLoadSceneStop()
        SetPedCoordsKeepVehicle(ped, x, y, z)

        while not HasCollisionLoadedAroundEntity(ped) do
            RequestCollisionAtCoord(x, y, z)
            if GetGameTimer() - curTime > 1000 then
                break
            end
            Wait(0)
        end

        -- Get ground coord. As mentioned in the natives, this only works if the client is in render distance.
        found, groundZ = GetGroundZFor_3dCoord(x, y, z, false)
        if found then
            Wait(0)
            SetPedCoordsKeepVehicle(ped, x, y, groundZ)
            break
        end
        Wait(0)
    end

    -- Remove black screen once the loop has ended.
    DoScreenFadeIn(650)
    if vehicle > 0 then
        FreezeEntityPosition(vehicle, false)
    else
        FreezeEntityPosition(ped, false)
    end

    if not found then
        -- If we can't find the coords, set the coords to the old ones.
        -- We don't unpack them before since they aren't in a loop and only called once.
        SetPedCoordsKeepVehicle(ped, oldCoords['x'], oldCoords['y'], oldCoords['z'] - 1.0)
    end

    -- If Z coord was found, set coords in found coords.
    SetPedCoordsKeepVehicle(ped, x, y, groundZ)
end

--- Teleports the player to the waypoint
Luxu.registerNetEvent("commands:tpm", function()
    if source ~= 65535 then return end
    local blip = GetFirstBlipInfoId(8)
    if DoesBlipExist(blip) then
        local ped = Luxu.cache.ped
        --[[ @diagnostic disable-next-line ]]
        local waypoint = GetBlipInfoIdCoord(blip)
        FreezeEntityPosition(Luxu.cache.ped, true)
        RequestAdditionalCollisionAtCoord(waypoint.x, waypoint.y, waypoint.z)
        DoScreenFadeOut(300)
        Wait(300)
        local coords = findCoords(ped, waypoint.x, waypoint.y)
        if not coords then
            DoScreenFadeIn(300)
            FreezeEntityPosition(Luxu.cache.ped, false)
            Luxu.print.error("Locales.error_finding_z_coord")
            return
        end
        SetPedCoordsKeepVehicle(ped, coords.x, coords.y, coords.z)
        FreezeEntityPosition(Luxu.cache.ped, false)
        DoScreenFadeIn(300)
    else
        Luxu.notify(Locales.error, Locales.no_waypoint_found, 3000, "error")
    end
end)

Luxu.registerNetEvent("commands:report", function()
    FetchNui("openReports")
    SetNuiFocus(true, true)
    SetNuiFocusKeepInput(false)
end)


Luxu.registerNetEventStrict("commands:staff", function(staffOnline)
    FetchNui("checkStaffOnline", staffOnline)
end)

Luxu.registerNetEvent("commands:showSentence", function(sentenceInfo)
    FetchNui("showSentence", sentenceInfo)
end)

lib.callback.register("luxu_admin:client:getVehicleMods", function()
    local vehicle = Luxu.cache.vehicle
    if not vehicle then return end
    local mods = Luxu.getVehicleMods(vehicle)
    local model = GetEntityModel(vehicle)
    local modelName = GetEntityArchetypeName(vehicle)
    return {
        mods  = mods,
        model = modelName,
        hash  = model
    }
end)

Keybinds = {}

for _, command in pairs(commands) do
    if command.defaultKey == "" then command.defaultKey = nil end
end

Keybinds.panel = Luxu.addKeybind({
    name = "luxu_admin:panel",
    description = "Open Admin Menu",
    defaultKey = commands.open_panel.defaultKey or nil,
    onPressed = function()
        if not HasPermission("self.panel", false, false) then return end
        OpenPanel()
    end
})

Keybinds.quickMenu = Luxu.addKeybind({
    name = "luxu_admin:quickmenu",
    description = "Open Quick Menu",
    defaultKey = commands.open_menu.defaultKey or nil,
    onPressed = function()
        if not HasPermission("self.quickmenu", false, true) then return end
        OpenMenu()
    end
})

Keybinds.reportMenu = Luxu.addKeybind({
    name = "luxu_admin:report",
    description = "Open Report Menu",
    defaultKey = commands.player_report.defaultKey or nil,
    onPressed = commands.player_report.keybind and function()
        FetchNui("openReports")
        SetNuiFocus(true, true)
        SetNuiFocusKeepInput(false)
    end or function() end
})

Keybinds.noclip = Luxu.addKeybind({
    name = "luxu_admin:toggleNoclip",
    description = "Toggle Noclip",
    onPressed = commands.noclip.keybind and function()
        if not HasPermission("self.noclip", false, true) then return end
        local freeFall = IsDisabledControlPressed(0, 36)

        Luxu.callbackAsync("actions:noclip", false, function() end, {
            target = Luxu.cache.serverId,
            freeFall = freeFall
        })
    end or function() end
})

Keybinds.back = Luxu.addKeybind({
    name = "luxu_admin:teleportBack",
    description = "Teleport to last position",
    onPressed = function()
        if not HasPermission("self.teleport") then return end
        ExecuteCommand("back")
    end
})

Keybinds.tp = Luxu.addKeybind({
    name = "luxu_admin:teleportCoords",
    description = "Teleport to coordinates",
    onPressed = function()
        --[[ shows coordinates dialog ]]
        if not HasPermission("self.teleport", false, true) then return end
        SetNuiFocus(true, true)
        FetchNui('showTeleportCoordsDialog')
    end
})

Keybinds.tpm = Luxu.addKeybind({
    name = "luxu_admin:teleportWaypoint",
    description = "Teleport to map marker",
    onPressed = function()
        if not HasPermission("self.teleport", false, true) then return end
        teleportToMarker()
    end
})

Keybinds.toggleNames = Luxu.addKeybind({
    name = "luxu_admin:toggleNames",
    description = "Toggle Player Names",
    onPressed = function()
        FetchNui("triggerToggle", { action = "player_names" })
    end
})
