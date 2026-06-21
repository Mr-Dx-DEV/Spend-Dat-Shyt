local isNeonRGBActive    = false
local isUIOpen           = false
local isDashboardActive  = false
local isAutoPilotActive  = false
local autoPilotTargetX   = 0.0
local autoPilotTargetY   = 0.0
local backCam            = nil
local frontCam           = nil
local isCameraActive     = false
local neonStates         = { false, false, false, false }
local curVolume          = nil
local autopilotMaxSpeed  = CodeStudio.AutoPilot.MaxSpeed
local autopilotDriveStyle= CodeStudio.AutoPilot.DriveStyle

-- ─── Helper: weather ─────────────────────────────────────────────────────────

function GetWeatherNameFromHash(weatherHash)
    local name = "CLEAR"
    for _, entry in ipairs(WEATHER_TYPES) do
        if entry.hash == weatherHash then
            name = entry
            break
        end
    end
    return name
end

-- ─── Helper: math ────────────────────────────────────────────────────────────

function RoundNumber(num, decimals)
    if decimals then
        local factor = 10 ^ decimals
        return math.floor(num * factor) / factor
    else
        if num >= 0 then
            return math.floor(num + 0.5)
        else
            return math.ceil(num - 0.5)
        end
    end
end

function GetDefaultVolume()
    return tonumber(RoundNumber(CodeStudio.Default_Music_Volume / 100, 1))
end

-- ─── Helper: HUD / location ──────────────────────────────────────────────────

function GetGameClock()
    local hours   = GetClockHours()
    local minutes = GetClockMinutes()
    if minutes <= 9 then minutes = "0" .. minutes end
    return hours .. ":" .. minutes
end

function GetStreetName(entity)
    local coords = GetEntityCoords(entity)
    local streetHash = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
    return GetStreetNameFromHashKey(streetHash)
end

function GetDistance(x1, y1, z1, x2, y2, z2)
    local dx, dy, dz = x1 - x2, y1 - y2, z1 - z2
    return math.sqrt(dx*dx + dy*dy + dz*dz)
end

function GetDistanceToMarker()
    local playerCoords = GetEntityCoords(cache.ped)
    local blip = GetFirstBlipInfoId(8)
    local dist = 0
    if blip and blip ~= 0 then
        local blipCoords = GetBlipInfoIdCoord(blip)
        local rawDist = GetDistance(playerCoords.x, playerCoords.y, playerCoords.z,
                                    blipCoords.x, blipCoords.y, blipCoords.z)
        if CodeStudio.MarkedLocation_Unit == "Mi" then
            dist = rawDist * 0.000621371
        else
            dist = rawDist * 0.001
        end
    end
    return dist .. " " .. CodeStudio.MarkedLocation_Unit
end

function HealthToPercent(value)
    local normalized = math.floor(((value - 0) / (1000 - 0)) * 100)
    return RoundNumber(math.max(1, math.min(100, normalized)))
end

-- ─── Helper: vehicle restriction check ───────────────────────────────────────

function IsVehicleAllowed()
    local method  = CodeStudio.RestrictionMethod
    local vehicle = cache.vehicle
    if method == "WL" then
        for _, modelHash in ipairs(CodeStudio.AddVehicle) do
            if GetEntityModel(vehicle) == modelHash then return true end
        end
        return false
    elseif method == "BL" then
        for _, modelHash in ipairs(CodeStudio.AddVehicle) do
            if GetEntityModel(vehicle) == modelHash then return false end
        end
        return true
    end
end

-- ─── Open CarPlay UI ─────────────────────────────────────────────────────────

RegisterNetEvent("cs:carplay:openUI", function()
    local isAllowed = lib.callback.await("cs:carplay:permsCheck", false)
    if not isAllowed then
        Notification(CodeStudio.Language.not_allowed)
        return
    end

    if not IsPedInAnyVehicle(cache.ped, false) then return end

    local vehicle = cache.vehicle
    local plate   = GetVehicleNumberPlateText(vehicle)

    if not GetIsVehicleEngineRunning(vehicle) then
        Notification(CodeStudio.Language.not_running)
        return
    end

    if CodeStudio.OnlyDriver then
        if GetPedInVehicleSeat(vehicle, -1) ~= cache.ped then
            Notification(CodeStudio.Language.only_driver)
            return
        end
    end

    if not IsVehicleAllowed() then
        Notification(CodeStudio.Language.restricted_veh)
        return
    end

    if CodeStudio.Main.RadioInstall.Enable then
        local isInstalled = lib.callback.await("cs:carplay:checkInstall", false, plate)
        if isInstalled then
            openUI()
        else
            Notification(CodeStudio.Language.not_installed)
        end
    else
        openUI()
    end
end)

function openUI()
    local netVehId, soundData, loginData = lib.callback.await("cs:carplay:getVeh", false)

    local songInfo = {}
    if soundData then
        if xSound:soundExists(netVehId) then
            local info = xSound:getInfo(netVehId)
            songInfo.musicPlaying  = info.playing
            songInfo.musicURL      = info.url
            songInfo.musicDuration = info.maxDuration
            songInfo.volume        = info.volume
            songInfo.loop          = info.loop
            songInfo.like          = soundData.like
            songInfo.MusicOn       = true
        end
    else
        songInfo.MusicOn = false
    end

    local vehicleData = {
        weatherType = GetWeatherNameFromHash(GetNextWeatherTypeHashName()),
        curTime     = GetGameClock(),
        curLoc      = GetStreetName(cache.ped),
        locDist     = GetDistanceToMarker(),
    }

    SendNUIMessage({
        action = "openUI",
        data   = {
            curVeh    = netVehId,
            vData     = vehicleData,
            songData  = songInfo,
            loginData = loginData,
            unit      = CodeStudio.MarkedLocation_Unit,
        }
    })
    isUIOpen = true
    SetNuiFocus(true, true)

    if CodeStudio.EnableControl then
        TriggerEvent("cs:carplay:useWhileDrive")
    end

    SendMusicTimeStamp(netVehId)
end

-- ─── Use-while-driving (disable conflicting controls) ────────────────────────

RegisterNetEvent("cs:carplay:useWhileDrive")
AddEventHandler("cs:carplay:useWhileDrive", function()
    SetNuiFocusKeepInput(true)
    while isUIOpen do
        Wait(3)
        DisableControls()
    end
end)

-- ─── NUI: fetch app config ────────────────────────────────────────────────────

RegisterNUICallback("fetchAppInfo", function(data, cb)
    cb({
        Language        = CodeStudio.Language,
        enableApps      = CodeStudio.Apps,
        DefaultPlaylist = CodeStudio.Default_Playlist,
    })
end)

-- ─── Close UI (server → client) ──────────────────────────────────────────────

RegisterNetEvent("cs:carplay:closeUI")
AddEventHandler("cs:carplay:closeUI", function()
    SendNUIMessage({ action = "closeUI" })
end)

-- ─── NUI: close UI ───────────────────────────────────────────────────────────

RegisterNUICallback("closeUI", function(data, cb)
    SetNuiFocusKeepInput(false)
    SetNuiFocus(false, false)
    TriggerServerEvent("cs:carplay:removePlyUI")
    Wait(250)
    isUIOpen = false
end)

-- ─── NUI: account login / logout ─────────────────────────────────────────────

RegisterNUICallback("loginAccount", function(data, cb)
    local result = lib.callback.await("cs:carplay:login", false, data)
    cb(result)
end)

RegisterNUICallback("logoutAccount", function(data, cb)
    TriggerServerEvent("cs:carplay:logoutAccount", data)
end)

-- ─── Sync music UI across passengers ─────────────────────────────────────────

RegisterNetEvent("cs:carplay:syncOpenUI")
AddEventHandler("cs:carplay:syncOpenUI", function(payload)
    local syncData = payload

    if payload.action == "resume" then
        syncData = true
        SendMusicTimeStamp(payload.musicID)
    elseif payload.action == "pause" or payload.action == "end" then
        syncData = false
    elseif payload.action == "musicEntry" then
        local info = xSound:getInfo(payload.musicID)
        syncData = {
            action        = "musicEntry",
            musicPlaying  = info.playing,
            musicURL      = info.url,
            musicDuration = info.maxDuration,
            volume        = info.volume,
            loop          = info.loop,
        }
        SendMusicTimeStamp(payload.musicID)
    end

    SendNUIMessage({
        action = "syncUI",
        data   = { action = payload.action, data = syncData }
    })
end)

-- ─── Vehicle ownership check helper ──────────────────────────────────────────

function IsPlayerInsideVehicle(vehicle)
    return cache.vehicle == vehicle
end

-- ─── NUI: play music ─────────────────────────────────────────────────────────

RegisterNUICallback("playMusic", function(data, cb)
    TriggerServerEvent("cs:carplay:musicAction", "play", {
        musicURL   = data.url,
        curVolume  = GetDefaultVolume(),
        liked      = data.liked,
    })
    cb(GetDefaultVolume())
end)

-- ─── Attach music to vehicle entity (server → client broadcast) ──────────────

RegisterNetEvent("cs:carplay:attachMusic")
AddEventHandler("cs:carplay:attachMusic", function(requestingServerId, netVehId, musicURL, volume)
    local isSelf = cache.serverId == requestingServerId
    AttachMusicToVehicle(isSelf, netVehId, musicURL, volume)
end)

function AttachMusicToVehicle(isSelf, netVehId, musicURL, volume)
    local vehicle = NetworkGetEntityFromNetworkId(netVehId)
    if not vehicle or not DoesEntityExist(vehicle) then return end

    if xSound:soundExists(netVehId) then
        TriggerServerEvent("cs:carplay:musicAction", "destroy", { soundId = netVehId })
        Wait(1000)
    end

    local callbacks = {}
    if isSelf then
        callbacks.onPlayStart = function()
            TriggerServerEvent("cs:carplay:musicAction", "playSync", { soundId = netVehId })
        end
        callbacks.onPlayEnd = function()
            if xSound:soundExists(netVehId) and not xSound:isLooped(netVehId) then
                TriggerServerEvent("cs:carplay:musicAction", "end", { soundId = netVehId })
            end
        end
    end

    if CodeStudio.Music_Outside_Veh then
        local resolvedVolume = tonumber(volume) or GetDefaultVolume()
        local vehicleCoords  = GetEntityCoords(vehicle)
        xSound:PlayUrlPos(netVehId, musicURL, resolvedVolume, vehicleCoords, false, callbacks)
        xSound:Distance(netVehId, resolvedVolume * CodeStudio.Outside_Music_Distance)
        Wait(100)
        xSound:setSoundDynamic(netVehId, true)
    else
        local myNetId = NetworkGetNetworkIdFromEntity(cache.vehicle)
        if myNetId ~= netVehId then
            volume = 0.0
        else
            volume = GetDefaultVolume()
        end
        xSound:PlayUrl(netVehId, musicURL, volume, false, callbacks)
    end

    CreateThread(function()
        while true do
            if not xSound:soundExists(netVehId) then break end
            if not DoesEntityExist(vehicle) then
                TriggerServerEvent("cs:carplay:musicAction", "destroy", { soundId = netVehId })
                return
            end
            if xSound:isPlaying(netVehId) then
                if CodeStudio.Music_Outside_Veh then
                    local speed = GetEntitySpeed(vehicle) * 2.23694
                    local coords = GetEntityCoords(vehicle)
                    if speed > 15 then
                        if IsPlayerInsideVehicle(vehicle) and xSound:isDynamic(netVehId) then
                            xSound:setSoundDynamic(netVehId, false)
                        end
                    else
                        if xSound:isDynamic(netVehId) then
                            if not IsVehicleStopped(vehicle) then
                                TriggerServerEvent("cs:carplay:musicAction", "position", {
                                    soundId = netVehId,
                                    coords  = coords,
                                })
                            end
                        else
                            TriggerServerEvent("cs:carplay:musicAction", "position", {
                                soundId = netVehId,
                                coords  = coords,
                            })
                        end
                    end
                end
            end
            Wait(100)
        end
    end)
end

-- ─── Vehicle mount / dismount: manage sound state ────────────────────────────

lib.onCache("vehicle", function(newVehicle, oldVehicle)
    if oldVehicle and DoesEntityExist(oldVehicle) then
        local netId = NetworkGetNetworkIdFromEntity(oldVehicle)
        if xSound:soundExists(netId) then
            if CodeStudio.Music_Outside_Veh then
                if not xSound:isDynamic(netId) then
                    while not xSound:isDynamic(netId) do
                        xSound:setSoundDynamic(netId, true)
                        Wait(100)
                    end
                    TriggerServerEvent("cs:carplay:musicAction", "position", {
                        soundId = netId,
                        coords  = GetEntityCoords(oldVehicle),
                    })
                end
            else
                xSound:setVolume(netId, 0.0)
            end
        end
        SendNUIMessage({ action = "resetDisplay" })
    end

    if newVehicle and DoesEntityExist(newVehicle) then
        local netId = NetworkGetNetworkIdFromEntity(newVehicle)
        if not CodeStudio.Music_Outside_Veh and xSound:soundExists(netId) then
            local vol = curVolume or GetDefaultVolume()
            xSound:setVolume(netId, vol)
        end
    end
end)

-- ─── NUI: pause / resume toggle ──────────────────────────────────────────────

RegisterNUICallback("stopMusic", function(data, cb)
    if xSound:soundExists(data.vehID) then
        if xSound:isPaused(data.vehID) then
            TriggerServerEvent("cs:carplay:musicAction", "resume", { soundId = data.vehID })
        else
            TriggerServerEvent("cs:carplay:musicAction", "pause",  { soundId = data.vehID })
        end
    end
end)

-- ─── Get all server IDs of players in a vehicle ──────────────────────────────

function GetPlayersInVehicle(vehicle)
    local players = {}

    local driverPed = GetPedInVehicleSeat(vehicle, -1)
    if driverPed ~= 0 then
        table.insert(players, GetPlayerServerId(NetworkGetPlayerIndexFromPed(driverPed)))
    end

    local seats = GetVehicleModelNumberOfSeats(GetEntityModel(vehicle)) - 2
    for seat = 0, seats do
        local passengerPed = GetPedInVehicleSeat(vehicle, seat)
        if passengerPed ~= 0 then
            table.insert(players, GetPlayerServerId(NetworkGetPlayerIndexFromPed(passengerPed)))
        end
    end

    return players
end

-- ─── NUI: adjust volume ───────────────────────────────────────────────────────

RegisterNUICallback("adjustVolume", function(data, cb)
    if not CodeStudio.Music_Outside_Veh then
        local passengers = GetPlayersInVehicle(cache.vehicle)
        TriggerServerEvent("cs:carplay:musicAction", "volume", {
            soundId = data.vehID,
            volume  = data.vol,
            players = passengers,
        })
        return
    end
    TriggerServerEvent("cs:carplay:musicAction", "volume", {
        soundId = data.vehID,
        volume  = data.vol,
    })
end)

-- ─── Music timestamp loop ─────────────────────────────────────────────────────

function SendMusicTimeStamp(soundId)
    CreateThread(function()
        while isUIOpen do
            if not xSound:soundExists(soundId) then break end
            if not xSound:isPlaying(soundId) then break end
            local timestamp = xSound:getTimeStamp(soundId)
            SendNUIMessage({ action = "updateMusicTime", timer = timestamp })
            Wait(1000)
        end
    end)
end

-- ─── NUI: seek / skip ────────────────────────────────────────────────────────

RegisterNUICallback("musicTimeStamp", function(data, cb)
    TriggerServerEvent("cs:carplay:musicAction", "skip", {
        soundId = data.vehID,
        time    = data.time,
    })
end)

-- ─── NUI: toggle loop ────────────────────────────────────────────────────────

RegisterNUICallback("loopMusic", function(data, cb)
    TriggerServerEvent("cs:carplay:musicAction", "loop", {
        soundId = data.vehID,
        loop    = data.loop,
    })
end)

RegisterNetEvent("cs:carplay:loopMusic")
AddEventHandler("cs:carplay:loopMusic", function(soundId, loopState)
    if soundId and xSound:soundExists(soundId) then
        xSound:setSoundLoop(soundId, loopState or false)
    end
end)

-- ─── NUI: save / like music ──────────────────────────────────────────────────

RegisterNUICallback("saveMusic", function(data, cb)
    local result = lib.callback.await("cs:carplay:saveMusic", false, data)
    if result then cb(result) end
end)

RegisterNUICallback("likeData", function(data, cb)
    TriggerServerEvent("cs:carplay:likeData", data)
end)

-- ─── NUI: playlist fetch / clear ─────────────────────────────────────────────

RegisterNUICallback("fetchPlaylist", function(data, cb)
    local result = lib.callback.await("cs:carplay:fetchPlaylist", false, data)
    if result then cb(result) end
end)

RegisterNUICallback("clearPlaylist", function(data, cb)
    TriggerServerEvent("cs:carplay:clearPlaylist", data)
end)

-- ─── AI Chat: Levenshtein distance ───────────────────────────────────────────

function LevenshteinDistance(s, t)
    local sLen, tLen = #s, #t
    local matrix = {}

    for i = 0, sLen do
        matrix[i] = { [0] = i }
    end
    for j = 0, tLen do
        matrix[0][j] = j
    end

    for i = 1, sLen do
        for j = 1, tLen do
            local cost = s:sub(i, i) == t:sub(j, j) and 0 or 1
            matrix[i][j] = math.min(
                matrix[i-1][j] + 1,
                matrix[i][j-1] + 1,
                matrix[i-1][j-1] + cost
            )
        end
    end
    return matrix[sLen][tLen]
end

-- ─── AI Chat: fuzzy match helpers ────────────────────────────────────────────

function FindFuzzyMatch(userInput)
    local threshold = 3
    for _, entry in ipairs(CodeStudio.AI_Chat) do
        if type(entry.Questions) == "table" then
            for _, question in ipairs(entry.Questions) do
                if type(question) == "string" and question ~= "" then
                    local dist = LevenshteinDistance(userInput:lower(), question:lower())
                    if dist <= threshold then
                        return entry.Answer
                    end
                end
            end
        end
    end
    return nil
end

function FindAIChatIndex(userInput)
    local threshold = 3
    for idx, entry in ipairs(CodeStudio.AI_Chat) do
        if type(entry.Questions) == "table" then
            for _, question in ipairs(entry.Questions) do
                if type(question) == "string" and question ~= "" then
                    local dist = LevenshteinDistance(userInput:lower(), question:lower())
                    if dist <= threshold then
                        return idx
                    end
                end
            end
        end
    end
    return nil
end

function ExtractTextBeforeURL(input)
    local startPos = string.find(input, "https://www%.youtube%.com")
    if startPos then
        return string.gsub(string.sub(input, 1, startPos - 1), "%s+$", "")
    end
    return input
end

-- ─── NUI: AI chat query ───────────────────────────────────────────────────────

RegisterNUICallback("chatGPT", function(data, cb)
    local cleanInput = ExtractTextBeforeURL(data)
    local chatIndex  = FindAIChatIndex(cleanInput)

    if chatIndex then
        cb({ response = CodeStudio.AI_Chat[chatIndex].Answer, data = chatIndex })
        return
    end

    local fuzzyAnswer = FindFuzzyMatch(cleanInput:lower())
    if fuzzyAnswer then
        cb({ response = fuzzyAnswer })
    else
        local serverResponse = lib.callback.await("cs:carplay:chatGPT", false, cleanInput)
        if serverResponse then
            cb({ response = serverResponse })
        end
    end
end)

-- ─── NUI: AI chat action execution ───────────────────────────────────────────

RegisterNUICallback("chatGPTAction", function(data, cb)
    local isMusicAction = false
    local entry = CodeStudio.AI_Chat[data]
    if entry then
        if entry.action then entry.action() end
        if entry.CloseUI  then TriggerEvent("cs:carplay:closeUI") end
        if entry.MusicURL then isMusicAction = true end
    end
    cb(isMusicAction)
end)

-- ─── Notification relay (server → client) ────────────────────────────────────

RegisterNetEvent("cs:carplay:notify")
AddEventHandler("cs:carplay:notify", function(msg, extra)
    Notification(msg, extra)
end)

-- ─── Radio install / uninstall flow ──────────────────────────────────────────

RegisterNetEvent("cs:carplay:installRadio")
AddEventHandler("cs:carplay:installRadio", function()
    if not IsPedInAnyVehicle(cache.ped, false) then
        Notification(CodeStudio.Language.not_in_veh_install)
        return
    end

    local vehicle = cache.vehicle
    local plate   = GetVehicleNumberPlateText(vehicle)
    local hasRadio = lib.callback.await("cs:carplay:checkInstall", false, plate)

    if hasRadio then
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = "installRadio",
            data   = {
                install = false,
                plate   = plate,
                text    = CodeStudio.Language.uninstall_radio_txt,
            }
        })
    else
        local options = CodeStudio.Main.RadioInstall.Options
        if options.OnlyOwned and CodeStudio.ServerType ~= false then
            local isOwned = lib.callback.await("cs:carplay:checkOwnedVehicle", false, plate)
            if not isOwned then
                Notification(CodeStudio.Language.veh_not_owned)
                return
            end
        end
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = "installRadio",
            data   = {
                install = true,
                plate   = plate,
                text    = CodeStudio.Language.install_radio_txt,
            }
        })
    end
end)

RegisterNUICallback("installRadio", function(data, cb)
    SetNuiFocus(false, false)
    InstallRadio(data.plate, data.install)
end)

-- ─── Car dashboard speed / rpm loop ──────────────────────────────────────────

RegisterNUICallback("carDashboard", function(data, cb)
    isDashboardActive = data
    local vehicle = cache.vehicle
    local speedMultiplier = CodeStudio.MarkedLocation_Unit == "Mi" and 2.23694 or 3.6

    if not DoesEntityExist(vehicle) then return end

    while isDashboardActive do
        Wait(500)
        local speed = math.ceil(GetEntitySpeed(vehicle) * speedMultiplier)
        local gear  = GetVehicleCurrentGear(vehicle)
        SendNUIMessage({
            action = "updateSpeed",
            data   = { speed = RoundNumber(speed), rpm = gear }
        })
    end
end)

-- ─── Autopilot ───────────────────────────────────────────────────────────────

RegisterNUICallback("autoPilot", function(data, cb)
    local playerPed = cache.ped
    local vehicle   = cache.vehicle

    if GetPedInVehicleSeat(vehicle, -1) ~= cache.ped then
        cb("no_driver")
        isAutoPilotActive = false
        return
    end

    isAutoPilotActive = data

    if isAutoPilotActive then
        local blip = GetFirstBlipInfoId(8)
        if blip and blip ~= 0 then
            local blipCoords = GetBlipCoords(blip)
            autoPilotTargetX = blipCoords.x
            autoPilotTargetY = blipCoords.y

            ClearPedTasks(playerPed)
            SetDriverAbility(playerPed, 1.0)
            SetDriverAggressiveness(playerPed, 0.0)
            TaskVehicleDriveToCoord(playerPed, vehicle, blipCoords,
                tonumber(autopilotMaxSpeed), 0, vehicle, autopilotDriveStyle, 0, true)

            local streetHash = GetStreetNameAtCoord(blipCoords.x, blipCoords.y, blipCoords.z)
            local streetName = GetStreetNameFromHashKey(streetHash)
            cb({ "start", streetName, GetDistanceToMarker() })
        else
            cb("no_marker")
            isAutoPilotActive = false
            return
        end
    else
        ClearPedTasks(playerPed)
    end

    while isAutoPilotActive do
        Wait(200)
        local vehicleCoords = GetEntityCoords(vehicle)
        local distToTarget  = Vdist(vehicleCoords.x, vehicleCoords.y, vehicleCoords.z,
                                    autoPilotTargetX, autoPilotTargetY, vehicleCoords.z)
        if distToTarget <= 25 then
            SetVehicleForwardSpeed(vehicle, 18.0) Wait(200)
            SetVehicleForwardSpeed(vehicle, 14.0) Wait(200)
            SetVehicleForwardSpeed(vehicle, 11.0) Wait(200)
            SetVehicleForwardSpeed(vehicle, 5.0)  Wait(200)
            SetVehicleForwardSpeed(vehicle, 0.0)
            ClearPedTasks(playerPed)
            isAutoPilotActive = false
            SendNUIMessage({ action = "stopAutoDrive" })
        end
    end
end)

-- ─── Car camera (front / back / exit) ────────────────────────────────────────

RegisterNUICallback("carCamera", function(data, cb)
    local vehicle    = cache.vehicle
    local modelHash  = GetEntityModel(vehicle)

    if backCam or frontCam then
        isCameraActive = false
        ClearTimecycleModifier()
        toggleControls(false)
        if frontCam then
            RenderScriptCams(false, true, 800, true, true)
            DestroyCam(frontCam, true)
            frontCam = nil
        end
        if backCam then
            RenderScriptCams(false, true, 800, true, true)
            DestroyCam(backCam, true)
            backCam = nil
        end
    end

    if data == "back" or data == "front" then
        local isBack     = data == "back"
        local boneName   = isBack and "platelight" or "bonnet"
        local boneIndex  = GetEntityBoneIndexByName(vehicle, boneName)

        local customOffset = nil
        local offsetConfig = CodeStudio.VehCamOffset[modelHash]
        if offsetConfig then
            customOffset = isBack and offsetConfig.back or offsetConfig.front
        end

        if boneIndex == -1 and not customOffset then
            if CodeStudio.DebugCamera then
                DebugCameraMode(vehicle, isBack)
                return
            else
                SendNUIMessage({ action = "closeUI" })
                Notification(isBack and CodeStudio.Language.no_camera_back or CodeStudio.Language.no_camera_front)
                return
            end
        end

        local defaultOffset = isBack and { 0.0, -2.0, 1.0 } or { 0.0, 2.0, 1.0 }
        local offset        = customOffset or defaultOffset
        local rotation      = isBack and 180.0 or 0.0

        local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 0, true, true)
        AttachCamToVehicleBone(cam, vehicle, boneIndex, true,
            0.0, 0.0, rotation, offset[1], offset[2], offset[3], true)

        if isBack then backCam = cam else frontCam = cam end

        SetCamFov(cam, 90.0)
        SetTimecycleModifier("scanline_cam_cheap")
        SetTimecycleModifierStrength(1.0)
        SetNuiFocusKeepInput(true)
        isCameraActive = true

    elseif data == "exit" then
        SendNUIMessage({ action = "closeUI" })
        isCameraActive = false
    end

    if CodeStudio.ParkingSensor.Enable then
        while isCameraActive do
            Wait(100)
            if not DoesEntityExist(vehicle) then break end
            local coords    = GetEntityCoords(vehicle)
            local sensorDist = CodeStudio.ParkingSensor.SensorDistance

            local frontProbe = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, sensorDist, 0.0)
            local frontRay   = StartExpensiveSynchronousShapeTestLosProbe(
                coords.x, coords.y, coords.z,
                frontProbe.x, frontProbe.y, frontProbe.z,
                4294967295, vehicle, 0)
            local _, frontHit = GetShapeTestResult(frontRay)

            local backProbe = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, -sensorDist, 0.0)
            local backRay   = StartExpensiveSynchronousShapeTestLosProbe(
                coords.x, coords.y, coords.z,
                backProbe.x, backProbe.y, backProbe.z,
                4294967295, vehicle, 0)
            local _, backHit = GetShapeTestResult(backRay)

            if frontHit == 1 or backHit == 1 then
                SendNUIMessage({ action = "parkAlarm" })
            end
        end
    end
end)

-- ─── Debug camera mode (offset finder) ───────────────────────────────────────

function DebugCameraMode(vehicle, isBack)
    isCameraActive = true
    SetNuiFocusKeepInput(true)

    local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 0, true, true)

    local chassisBone = GetEntityBoneIndexByName(vehicle, "chassis")
    AttachCamToVehicleBone(cam, vehicle, chassisBone, true,
        0.0, 0.0, 0.0, 0.0, 0.35, 0.79, true)

    if isBack then backCam = cam else frontCam = cam end

    Citizen.CreateThread(function()
        toggleControls(true)
        local offsetX, offsetY, offsetZ = 0.0, 0.35, 0.79
        local rotation = isBack and 180.0 or 0.0

        -- ⚠️ `form` is a mystery global (scaleform handle) expected to be set externally
        while isCameraActive do
            Citizen.Wait(0)
            DrawScaleformMovieFullscreen(form, 255, 255, 255, 255, 0)
            DisableAllControlActions(0)

            local step = IsDisabledControlPressed(0, 21) and 0.05 or 0.01

            if IsDisabledControlPressed(0, 35) then offsetX = offsetX + step end
            if IsDisabledControlPressed(0, 34) then offsetX = offsetX - step end
            if IsDisabledControlPressed(0, 44) then offsetY = offsetY + step end
            if IsDisabledControlPressed(0, 38) then offsetY = offsetY - step end
            if IsDisabledControlPressed(0, 32) then offsetZ = offsetZ + step end
            if IsDisabledControlPressed(0, 33) then offsetZ = offsetZ - step end

            if IsDisabledControlPressed(0, 22) then
                isCameraActive = false
                toggleControls(false)
                Notification("New Camera Offset Copied, Paste in Config")

                local modelHash  = GetEntityModel(vehicle)
                local modelName  = GetDisplayNameFromVehicleModel(modelHash):lower()
                local existingConfig = CodeStudio.VehCamOffset[modelHash]
                local existingFront  = existingConfig and existingConfig.front
                local existingBack   = existingConfig and existingConfig.back

                local newOffsetStr = string.format("{%f, %f, %f}", offsetX, offsetY, offsetZ)
                local outputStr    = string.format("[`%s`] = {", modelName)

                if not existingFront or isBack then
                    local frontStr = existingFront and string.format("{%f, %f, %f}", existingFront[1], existingFront[2], existingFront[3]) or newOffsetStr
                    outputStr = outputStr .. string.format(" front = %s,", frontStr)
                end

                if not existingBack or (not isBack) then
                    local backStr = existingBack and string.format("{%f, %f, %f}", existingBack[1], existingBack[2], existingBack[3]) or newOffsetStr
                    outputStr = outputStr .. string.format(" back = %s", backStr)
                end

                outputStr = outputStr .. " },"
                print(outputStr)
                SendNUIMessage({ action = "copyClipboard", data = outputStr })
                SendNUIMessage({ action = "closeUI" })
            end

            AttachCamToVehicleBone(cam, vehicle, chassisBone, true,
                0.0, 0.0, rotation, offsetX, offsetY, offsetZ, true)
        end
    end)
end

-- ─── NUI: car info ────────────────────────────────────────────────────────────

RegisterNUICallback("carInfo", function(data, cb)
    local vehicle = cache.vehicle
    cb({
        vName   = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)),
        vEngine = HealthToPercent(GetVehicleEngineHealth(vehicle)) .. "%",
        vBody   = HealthToPercent(GetVehicleBodyHealth(vehicle)) .. "%",
        vFuel   = RoundNumber(GetVehicleFuel(vehicle)) .. "%",
        vTemp   = RoundNumber(GetVehicleEngineTemperature(vehicle), 2),
    })
end)

-- ─── Get all seat indices for a vehicle ──────────────────────────────────────

function GetAllVehicleSeats(vehicle)
    local seats = {}
    local maxSeat = GetVehicleModelNumberOfSeats(GetEntityModel(vehicle)) - 2
    for seat = -1, maxSeat do
        table.insert(seats, seat)
    end
    return seats
end

-- ─── NUI: car control state ───────────────────────────────────────────────────

RegisterNUICallback("carControl", function(data, cb)
    local vehicle     = cache.vehicle
    local indicators  = GetVehicleIndicatorLights(vehicle)
    local _, lights   = GetVehicleLightsState(vehicle)
    local anyDoorOpen = false

    for door = 0, 7 do
        if GetVehicleDoorAngleRatio(vehicle, door) > 0.1 and not IsVehicleDoorDamaged(vehicle, door) then
            anyDoorOpen = true
            break
        end
    end

    cb({
        vLight    = lights,
        vEngine   = GetIsVehicleEngineRunning(vehicle),
        vHazard   = indicators == 3,
        vDoors    = anyDoorOpen,
        vMusicRGB = isNeonRGBActive,
        vSeats    = GetAllVehicleSeats(vehicle),
    })
end)

-- ─── Neon RGB helpers ─────────────────────────────────────────────────────────

function ToggleNeonLights(vehicle)
    for neonIndex = 0, 3 do
        SetVehicleNeonLightEnabled(vehicle, neonIndex, neonStates[neonIndex + 1])
    end
end

function ChangeNeonColor(vehicle)
    SetVehicleNeonLightsColour(vehicle, math.random(0, 255), math.random(0, 255), math.random(0, 255))
end

function NeonBlinkingThread(vehicle)
    Citizen.CreateThread(function()
        while isNeonRGBActive do
            Wait(250)
            if not IsPauseMenuActive() then
                for i = 1, 4 do
                    neonStates[i] = math.random() < 0.5
                end
                ToggleNeonLights(vehicle)
                ChangeNeonColor(vehicle)
            end
        end
        for i = 1, 4 do neonStates[i] = false end
        ToggleNeonLights(vehicle)
    end)
end

-- ─── NUI: car action dispatcher ──────────────────────────────────────────────

RegisterNUICallback("carAction", function(data, cb)
    local vehicle = cache.vehicle
    if not vehicle then return end

    local entityState = Entity(vehicle).state
    local actionType  = data.type

    if actionType == "engine" then
        local isRunning = GetIsVehicleEngineRunning(vehicle)
        entityState:set("engineState", not isRunning, true)
        cb(isRunning and "OFF" or "ON")

    elseif actionType == "allDoor" then
        local anyOpen = false
        for door = 0, 7 do
            if not IsVehicleDoorDamaged(vehicle, door) and GetVehicleDoorAngleRatio(vehicle, door) > 0.1 then
                anyOpen = true
                break
            end
        end
        entityState:set("allDoorsOpen", not anyOpen, true)
        cb(anyOpen and "CLOSE" or "OPEN")

    elseif actionType == "headlight" then
        local _, lightsOn = GetVehicleLightsState(vehicle)
        local isOn = lightsOn ~= 0
        entityState:set("headlightState", not isOn, true)
        cb(isOn and "OFF" or "ON")

    elseif actionType == "hazard" then
        local indicators = GetVehicleIndicatorLights(vehicle)
        local isOn       = indicators == 3
        entityState:set("hazardState", not isOn, true)
        cb(isOn and "OFF" or "ON")

    elseif actionType == "window" then
        local windowIndex  = tonumber(data.window)
        local isIntact     = IsVehicleWindowIntact(vehicle, windowIndex)
        entityState:set("openWindow" .. windowIndex, isIntact, true)
        cb(isIntact and "OPEN" or "CLOSE")

    elseif actionType == "door" then
        local doorIndex = tonumber(data.door)
        local isOpen    = GetVehicleDoorAngleRatio(vehicle, doorIndex) > 0.1
        entityState:set("doorState" .. doorIndex, not isOpen, true)

    elseif actionType == "seat" then
        local seatIndex = tonumber(data.seat)
        SetPedIntoVehicle(cache.ped, vehicle, seatIndex)

    elseif actionType == "rgb" then
        isNeonRGBActive = not isNeonRGBActive
        if isNeonRGBActive then NeonBlinkingThread(vehicle) end
        cb(isNeonRGBActive and "ON" or "OFF")
    end
end)

-- ─── State bag: engine ────────────────────────────────────────────────────────

AddStateBagChangeHandler("engineState", nil, function(bagName, key, value)
    local vehicle = GetEntityFromStateBagName(bagName)
    if DoesEntityExist(vehicle) then
        SetVehicleEngineOn(vehicle, value, false, true)
    end
end)

-- ─── State bag: headlights ────────────────────────────────────────────────────

AddStateBagChangeHandler("headlightState", nil, function(bagName, key, value)
    local vehicle = GetEntityFromStateBagName(bagName)
    if DoesEntityExist(vehicle) then
        SetVehicleLights(vehicle, value and 0 or 1)
    end
end)

-- ─── State bag: hazard lights ─────────────────────────────────────────────────

AddStateBagChangeHandler("hazardState", nil, function(bagName, key, value)
    local vehicle = GetEntityFromStateBagName(bagName)
    if DoesEntityExist(vehicle) then
        local state = value and 1 or 0
        SetVehicleIndicatorLights(vehicle, 0, state)
        SetVehicleIndicatorLights(vehicle, 1, state)
    end
end)

-- ─── State bag: all doors ─────────────────────────────────────────────────────

AddStateBagChangeHandler("allDoorsOpen", nil, function(bagName, key, value)
    local vehicle = GetEntityFromStateBagName(bagName)
    if not DoesEntityExist(vehicle) then return end
    for door = 0, 7 do
        if not IsVehicleDoorDamaged(vehicle, door) then
            if value then
                SetVehicleDoorOpen(vehicle, door, false, false)
            else
                SetVehicleDoorShut(vehicle, door, false)
            end
        end
    end
end)

-- ─── State bag: individual doors (0–7) ───────────────────────────────────────

for doorIndex = 0, 7 do
    AddStateBagChangeHandler("doorState" .. doorIndex, nil, function(bagName, key, value)
        local vehicle = GetEntityFromStateBagName(bagName)
        if DoesEntityExist(vehicle) and not IsVehicleDoorDamaged(vehicle, doorIndex) then
            if value then
                SetVehicleDoorOpen(vehicle, doorIndex, false, false)
            else
                SetVehicleDoorShut(vehicle, doorIndex, false)
            end
        end
    end)
end

-- ─── State bag: individual windows (0–7) ─────────────────────────────────────

for windowIndex = 0, 7 do
    AddStateBagChangeHandler("openWindow" .. windowIndex, nil, function(bagName, key, value)
        local vehicle = GetEntityFromStateBagName(bagName)
        if DoesEntityExist(vehicle) then
            if value then
                RollDownWindow(vehicle, windowIndex)
            else
                RollUpWindow(vehicle, windowIndex)
            end
        end
    end)
end

-- ─── Debug camera controls overlay ───────────────────────────────────────────

local showControls = false

function toggleControls(enabled)
    showControls = enabled
    Citizen.CreateThread(function()
        while showControls do
            drawControls()
            Wait(0)
        end
    end)
end

function drawText(x, y, text, scale)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextScale(scale, scale)
    SetTextColour(255, 255, 255, 255)
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

function drawControls()
    local x, y = 0.85, 0.05
    drawText(x, y - 0.01, "~y~Camera Position~s~", 0.45)
    drawText(x, y + 0.03, "SPACE - Copy Offset",   0.35)
    drawText(x, y + 0.06, "W - Move Up",            0.35)
    drawText(x, y + 0.09, "S - Move Down",          0.35)
    drawText(x, y + 0.12, "A - Move Left",          0.35)
    drawText(x, y + 0.15, "D - Move Right",         0.35)
    drawText(x, y + 0.18, "Q - Move Forward",       0.35)
    drawText(x, y + 0.21, "E - Move Backward",      0.35)
end
