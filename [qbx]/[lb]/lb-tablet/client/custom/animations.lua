local tabletModel = Config.TabletModel or `imp_prop_impexp_tablet`

local dict = "amb@code_human_in_bus_passenger_idles@female@tablet@base"
local anim = "base"
local animFlag = 1 | 8 | 16 | 32 | 1048576

local playerPed = 0
local tabletEntityHidden = false
local animationsEnabled = true
local tabletEntity

---@param tablet number
---@param ped number
function AttachTablet(tablet, ped)
    local tabletOffset = Config.TabletOffset or vector3(0.05, -0.005, -0.04)
    local tabletRotation = Config.TabletRotation or vector3(0.0, 0.0, 0.0)

    AttachEntityToEntity(
        tablet, ped,
        GetPedBoneIndex(ped, 28422),
        tabletOffset.x, tabletOffset.y, tabletOffset.z,
        tabletRotation.x, tabletRotation.y, tabletRotation.z,
        false, false, false, false, 2, true
    )
end

function GetTabletObject()
    return tabletEntity
end

local function DeleteTabletObject()
    if not tabletEntity then
        return
    end

    debugprint("Deleting tablet object")
    DeleteEntity(tabletEntity)

    if Config.PropSpawn ~= "state" then
        TriggerServerEvent("tablet:setTabletObject", nil)
    end

    tabletEntity = nil
end

local handleAnimationsInterval = Interval:new(function(self)
    if not TabletOpen or not animationsEnabled then
        if not self.enabled then
            return
        end

        DeleteTabletObject()
        ClearPedTasks(playerPed)
        RemoveAnimDict(dict)
        SetModelAsNoLongerNeeded(tabletModel)

        self:toggle(false)

        return
    end

    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)
        return
    end

    local playingAnim = IsEntityPlayingAnim(playerPed, dict, anim, 1)
    local inAnyVehicle = IsPedInAnyVehicle(playerPed, true)

    if inAnyVehicle and not tabletEntityHidden then
        tabletEntityHidden = true
        SetEntityVisible(tabletEntity, false, false)
    elseif not inAnyVehicle and tabletEntityHidden then
        tabletEntityHidden = false
        SetEntityVisible(tabletEntity, true, false)
    end

    if inAnyVehicle and playingAnim then
        StopAnimTask(playerPed, dict, anim, -1000.0)
    elseif not inAnyVehicle and not playingAnim and not IsPedRagdoll(playerPed) then
        TaskPlayAnim(playerPed, dict, anim, 8.0, -4.0, -1, animFlag, 0, false, false, false)
    end
end, 500, false)

local function CreateTabletObject()
    debugprint("Creating tablet object")

    if tabletEntity then
        return debugprint("Tablet object already exists")
    elseif not LoadModel(tabletModel) then
        return infoprint("warning", "Failed to load the tablet model")
    end

    local visibleTimer = GetGameTimer() + 650

    DeleteTabletObject()

    if Config.PropSpawn == "server" then
        if not IsModelValid(tabletModel) then
            debugprint("tabletModel is not valid")
            return
        end

        local netId = AwaitCallback("createTabletObject", tabletModel)

        if not netId then
            debugprint("Failed to create tablet object (no net id)")
            return
        end

        tabletEntity = WaitForNetworkId(netId)

        if not tabletEntity or not TakeControlOfEntity(tabletEntity) then
            debugprint("Failed to get/take control of tablet object (timed out)")
            TriggerServerEvent("tablet:failedControl")

            tabletEntity = nil
            return
        end
    else
        local networked = Config.PropSpawn ~= "state"
        local spawnCoords = GetEntityCoords(playerPed) - vector3(0.0, 0.0, 5.0)

        tabletEntity = CreateObject(tabletModel, spawnCoords.x, spawnCoords.y, spawnCoords.z, networked, true, false)
    end

    debugprint(#(GetEntityCoords(playerPed) - GetEntityCoords(tabletEntity)), GetEntityCoords(tabletEntity))

    if Config.PropSpawn ~= "state" then
        TriggerServerEvent("tablet:setTabletObject", NetworkGetNetworkIdFromEntity(tabletEntity))
    end

    debugprint(#(GetEntityCoords(playerPed) - GetEntityCoords(tabletEntity)), GetEntityCoords(tabletEntity))

    SetEntityVisible(tabletEntity, false, false)
    AttachTablet(tabletEntity, playerPed)

    debugprint(#(GetEntityCoords(playerPed) - GetEntityCoords(tabletEntity)), GetEntityCoords(tabletEntity))

    while visibleTimer > GetGameTimer() do
        Wait(0)
    end

    debugprint(#(GetEntityCoords(playerPed) - GetEntityCoords(tabletEntity)), GetEntityCoords(tabletEntity))

    debugprint("Making tablet visible")
    SetEntityVisible(tabletEntity, true, false)

    if not TabletOpen then
        DeleteTabletObject()
    end
end

function UpdateAnimations()
    if not TabletOpen or not animationsEnabled or handleAnimationsInterval.enabled then
        return
    end

    playerPed = PlayerPedId()
    tabletEntityHidden = false
    handleAnimationsInterval:toggle(true)

    Citizen.CreateThreadNow(CreateTabletObject)
end

---@param enabled boolean
function ToggleAnimations(enabled)
    animationsEnabled = enabled == true

    UpdateAnimations()
end

AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() and tabletEntity then
        DeleteObject(tabletEntity)
        ClearPedTasks(PlayerPedId())
    end
end)
