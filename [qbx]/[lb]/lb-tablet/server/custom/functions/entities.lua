---<b>Key:</b> player source
---<br><b>Value:</b> tablet object
---@type { [number]: number }
local tabletObjects = {}

---@param entity number
local function DeleteEntityIfExists(entity)
    if DoesEntityExist(entity) then
        DeleteEntity(entity)
    end
end

---@param netId? number
RegisterNetEvent("tablet:setTabletObject", function(netId)
    local src = source

    if not netId and tabletObjects[src] then
        local tablet = tabletObjects[src]

        if tablet then
            debugprint("Deleting tablet object for player " .. src)
            DeleteEntityIfExists(tablet)
        end

        tabletObjects[src] = nil

        return
    end

    if Config.PropSpawn == "server" then
        return
    end

    if netId then
        local entity = NetworkGetEntityFromNetworkId(netId)

        if DoesEntityExist(entity) then
            tabletObjects[src] = entity
        end
    end
end)

OnTabletDisconnect(function(tabletId, source)
    local src = source
    local tabletEntity = tabletObjects[src]

    if tabletEntity then
        DeleteEntityIfExists(tabletEntity)

        tabletObjects[src] = nil
    end
end)

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName ~= GetCurrentResourceName() then
        return
    end

    for _, tabletEntity in pairs(tabletObjects) do
        DeleteEntityIfExists(tabletEntity)
    end
end)

if Config.PropSpawn ~= "server" then
    return
end

local allowedModels = {
    [`imp_prop_impexp_tablet`] = true,
    [Config.TabletModel] = true,
}

---@param entity number
---@return boolean exists
function WaitForEntity(entity)
    local timer = GetGameTimer() + 5000

    while not DoesEntityExist(entity) and timer > GetGameTimer() do
        Wait(0)
    end

    return DoesEntityExist(entity)
end

---@param entity number
local function IgnoreControlFilter(entity)
    SetEntityIgnoreRequestControlFilter(entity, true)

    SetTimeout(10000, function()
        if DoesEntityExist(entity) then
            SetEntityIgnoreRequestControlFilter(entity, false)
        end
    end)
end

---@param source any
---@param model number
---@return number? tabletEntity
local function CreateTabletObject(source, model)
    if tabletObjects[source] then
        DeleteEntityIfExists(tabletObjects[source])

        tabletObjects[source] = nil
    end

    local playerPed = GetPlayerPed(source)
    local coords = GetEntityCoords(playerPed)
    local tablet = CreateObjectNoOffset(model, coords.x, coords.y, coords.z, true, true, false)

    if not WaitForEntity(tablet) then
        return
    end

    -- allow the player to take control of the tablet, so they can attach it
    IgnoreControlFilter(tablet)

    return tablet
end

---@param model number
RegisterCallback("createTabletObject", function(source, model)
    if not allowedModels[model] then
        infoprint("warning", ("%s | %i tried to create a tablet object with a model (%s) that's not allowed"):format(GetPlayerName(source), source, tostring(model)))
        return false
    end

    debugprint("Creating tablet object for", source)

    local tablet = CreateTabletObject(source, model)

    if tablet then
        tabletObjects[source] = tablet

        return NetworkGetNetworkIdFromEntity(tablet)
    else
        return false
    end
end)

RegisterNetEvent("tablet:failedControl", function()
    local src = source
    local entity = tabletObjects[src]

    if entity then
        DeleteEntityIfExists(entity)
        debugprint(src .. " failed to take control of tablet object, deleting it.")

        tabletObjects[src] = nil
    end
end)
