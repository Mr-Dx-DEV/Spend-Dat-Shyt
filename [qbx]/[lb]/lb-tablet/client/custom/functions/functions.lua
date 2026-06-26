---@return boolean canOpen
function CanOpenTablet()
    if Config.LBPhone and exports["lb-phone"]:IsOpen() then
        debugprint("CanOpenTablet: lb-phone is open")
        return false
    elseif IsPauseMenuActive() then
        debugprint("CanOpenTablet: pause menu is active")
        return false
    elseif Config.Item.Require and not HasTabletItem() then
        debugprint("CanOpenTablet: no item")
        return false
    elseif IsNuiFocused() then
        debugprint("CanOpenTablet: NUI is focused")
        return false
    elseif IsPedDeadOrDying(PlayerPedId(), false) then
        debugprint("CanOpenTablet: player is dead or dying")
        return false
    end

    return true
end

function OnOpen()
    debugprint("OnOpen: Tablet opened")
end

function OnClose()
    debugprint("OnClose: Tablet closed")
end

---@class BlipProperties
---@field sprite? number
---@field color? number
---@field size? number
---@field shortRange? boolean
---@field label? string

---@param blip number
---@param properties BlipProperties
function ApplyBlipProperties(blip, properties)
    properties = properties or {}

    if not blip then
        return
    end

    if properties.sprite then
        SetBlipSprite(blip, properties.sprite)
    end

    if properties.color then
        SetBlipColour(blip, properties.color)
    end

    if properties.shortRange then
        SetBlipAsShortRange(blip, true)
    end

    if properties.size then
        SetBlipScale(blip, properties.size)
    end

    if properties.label then
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(properties.label)
        EndTextCommandSetBlipName(blip)
    end
end

---@param dict string
---@return string dict
function LoadDict(dict)
    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)

        while not HasAnimDictLoaded(dict) do
            Wait(0)
        end
    end

    return dict
end

---@param model string | number
---@return number | false modelHash
function LoadModel(model)
    assert(type(model) == "string" or type(model) == "number", "model must be a string or number")

    local modelHash = type(model) == "number" and model or joaat(model)

    if not modelHash then
        return false
    end

    if not HasModelLoaded(modelHash) then
        RequestModel(modelHash)

        while not HasModelLoaded(modelHash) do
            Wait(0)
        end
    end

    return modelHash
end

local hideHudInterval = Interval:new(function()
    HideHudAndRadarThisFrame()
    HideHelpTextThisFrame()
end, 0, false)

---@param hidden boolean
function ToggleHideHudComponents(hidden)
    hideHudInterval:toggle(hidden)
end

function IsHudHidden()
    return hideHudInterval.enabled
end

---Wait for network id & entity to exist
---@param netId number
---@return number? entity
function WaitForNetworkId(netId)
    local timer = GetGameTimer() + 5000

    while not NetworkDoesNetworkIdExist(netId) do
        Wait(0)

        if GetGameTimer() > timer then
            return
        end
    end

    timer = GetGameTimer() + 5000

    while not DoesEntityExist(NetworkGetEntityFromNetworkId(netId)) do
        Wait(0)

        if GetGameTimer() > timer then
            return
        end
    end

    return NetworkGetEntityFromNetworkId(netId)
end

---@param entity number
---@return boolean success
function TakeControlOfEntity(entity)
    if NetworkHasControlOfEntity(entity) then
        return true
    end

    local timer = GetGameTimer() + 5000

    while not NetworkHasControlOfEntity(entity) and timer > GetGameTimer() do
        NetworkRequestControlOfEntity(entity)
        Wait(0)
    end

    return NetworkHasControlOfEntity(entity)
end

local instructionalButtons = {
    b_194 = "arrow_up",
    b_195 = "arrow_down",
    b_196 = "arrow_left",
    b_197 = "arrow_right",
    b_1004 = "Backspace"
}

function GetInstructionalButtonName(button)
    local name = instructionalButtons[button]

    if name then
        return name
    end

    infoprint("warning", "Unknown button: " .. button .. "\nYou can add more buttons manually in lb-tablet/client/custom/functions/functions.lua, in the `instructionalButtons` table.")

    return "??"
end

---@param dispatch DispatchNotification
function RespondToDispatch(dispatch)
    SetNewWaypoint(dispatch.location.coords.x, dispatch.location.coords.y)
    TriggerServerEvent("tablet:dispatch:respond", dispatch.id)
end

---@param ped number
---@return string
function GetPedGender(ped)
    local model = GetEntityModel(ped)

    if model == `mp_m_freemode_01` then
        return L("MISC.GENDERS.MALE")
    elseif model == `mp_f_freemode_01` then
        return L("MISC.GENDERS.FEMALE")
    end

    local gender = IsPedMale(ped) and "MALE" or "FEMALE"

    return L("MISC.GENDERS." .. gender)
end

---@param job "Police" | "Ambulance"
function OldGetPermissions(job)
    local permissions = {}
    local playerJob = GetJob()
    local playerGrade = GetJobGrade()
    local jobPermissions = Config[job].Permissions[playerJob]
    local adminPermissions = Config[job].AdminPermissions

    if not playerJob or not jobPermissions then
        return false
    end

    for permissionName, permissionValues in pairs(jobPermissions) do
        permissions[permissionName] = {}

        for permissionType, permissionGrade in pairs(permissionValues) do
            permissions[permissionName][permissionType] = playerGrade >= permissionGrade
        end
    end

    if IsAdmin() and adminPermissions then
        for permissionName, permissionValues in pairs(adminPermissions) do
            permissions[permissionName] = permissions[permissionName] or {}

            for permissionType, hasPermission in pairs(permissionValues) do
                if hasPermission and not permissions[permissionName][permissionType] then
                    debugprint("has permission " .. permissionName .. "." .. permissionType .. " due to being admin")
                    permissions[permissionName][permissionType] = true
                end
            end
        end
    end

    return permissions
end

---@param coords vector3
function GetLocationName(coords)
    local streetHash = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
    local streetName = GetStreetNameFromHashKey(streetHash)
    local zone = GetNameOfZone(coords.x, coords.y, coords.z)
    local zoneName = GetLabelText(zone)

    return streetName .. ", " .. zoneName
end

---@param appIdentifier string
---@param jobName? string
---@param jobGrade? number
function HasAccessToApp(appIdentifier, jobName, jobGrade)
    if not GetJob then
        debugprint("GetJob is not defined in framework functions")
        return true
    end

    if not GetJobGrade then
        debugprint("GetJobGrade is not defined in framework functions")
        return true
    end

    if not Config.WhitelistApps and not Config.BlacklistApps then
        return true
    end

    jobName = jobName or GetJob()
    jobGrade = jobGrade or GetJobGrade()

    local blacklistedJobs = Config.BlacklistApps and Config.BlacklistApps[appIdentifier]

    if blacklistedJobs then
        if table.type(blacklistedJobs) == "array" then
            if table.contains(blacklistedJobs, jobName) then
                debugprint("Player's job is blacklisted from app", appIdentifier)
                return false
            end
        else
            if blacklistedJobs[jobName] and jobGrade >= blacklistedJobs[jobName] then
                debugprint("Player's job is blacklisted from app", appIdentifier)
                return false
            end
        end
    end

    local allowedJobs = Config.WhitelistApps and Config.WhitelistApps[appIdentifier]

    if allowedJobs then
        if table.type(allowedJobs) == "array" then
            if table.contains(allowedJobs, jobName) then
                return true
            end

            debugprint("Player is not whitelisted for app", appIdentifier)
            return false
        else
            if allowedJobs[jobName] and jobGrade >= allowedJobs[jobName] then
                return true
            end

            debugprint("Player is not whitelisted for app", appIdentifier)
            return false
        end
    end

    return true
end

---@param bagName string
---@return number? source
---@return number? ped
---@return number? playerIndex
function GetPlayerDataFromStateBag(bagName)
    local source = tonumber(bagName:match("player:(%d+)"))
    local playerId = PlayerId()

    if not source then
        return
    end

    if source == GetPlayerServerId(playerId) then
        return source, PlayerPedId(), playerId
    end

    local playerPed = PlayerPedId()
    local player = GetPlayerFromServerId(source)
    local ped = GetPlayerPed(player)
    local timeout = GetGameTimer() + 1000

    while player == playerId or ped == playerPed or ped == 0 do
        Wait(0)

        player = GetPlayerFromServerId(source)
        ped = GetPlayerPed(player)

        if GetGameTimer() > timeout then
            debugprint("Timed out waiting for ped to be valid")
            return
        end
    end

    return source, ped, player
end

-- ---@param uploadType "Video" | "Image" | "Audio"
-- ---@return UploadMethod?
-- function CustomGetUploadMethod(uploadType)
--     local methods = UploadMethods[Config.UploadMethod[uploadType]]

--     if not methods then
--         infoprint("error", "Upload methods not found for ", uploadType)
--         return
--     end

--     ---@type UploadMethod?
--     local method = methods[uploadType] or methods.Default

--     if not method then
--         infoprint("error", "Upload method not found for ", uploadType)
--         return
--     end

--     return method
-- end
