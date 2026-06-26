if Config.PropSpawn ~= "state" then
    return
end

---<b>Key:</b> player source
---<br><b>Value:</b> tablet object
---@type { [number]: number }
local tabletObjects = {}

---@param source number
local function DeletePlayerTabletEntity(source)
    local entity = tabletObjects[source]

    if not entity then
        return
    end

    if DoesEntityExist(entity) then
        DeleteEntity(entity)
    end

    tabletObjects[source] = nil

    debugprint("Deleted tablet entity for source " .. source)
end

---@param source number
local function IsTabletOpen(source)
    local state = Player(source).state

    if not state.lbTabletOpen then
        return false
    end

    return true
end

---@param source number
---@param ped number
local function SpawnAndAttachTabletToPlayer(source, ped)
    if tabletObjects[source] then
        debugprint("Tablet entity already exists for source " .. source)
        return
    end

    local showTabletTimer = GetGameTimer() + 500
    local tabletModel = Config.TabletModel or `imp_prop_impexp_tablet`
    local coords = GetEntityCoords(ped)

    LoadModel(tabletModel)

    while showTabletTimer > GetGameTimer() do
        Wait(0)
    end

    if not IsTabletOpen(source) then
        debugprint("Player closed tablet before it was spawned")
        SetModelAsNoLongerNeeded(tabletModel)
        return
    end

    local tablet = CreateObject(tabletModel, coords.x, coords.y, coords.z, false, true, true)

    SetEntityCollision(tablet, false, false)
    SetModelAsNoLongerNeeded(tabletModel)
    AttachTablet(tablet, ped)

    tabletObjects[source] = tablet

    debugprint("Created tablet entity for source " .. source)
end

---@diagnostic disable-next-line: param-type-mismatch
AddStateBagChangeHandler("lbTabletOpen", nil, function(bagName, key, value, reserved, replicated)
    local source, ped = GetPlayerDataFromStateBag(bagName)

    if not source or source == GetPlayerServerId(PlayerId()) then
        return
    end

    if not ped then
        debugprint("Ped not found")
        return
    end

    if value then
        SpawnAndAttachTabletToPlayer(source, ped)
    else
        Wait(0) -- allow states to update

        if not IsTabletOpen(source) then
            DeletePlayerTabletEntity(source)
        end
    end
end)

RegisterNetEvent("onPlayerDropped", function(src)
    DeletePlayerTabletEntity(src)
end)
