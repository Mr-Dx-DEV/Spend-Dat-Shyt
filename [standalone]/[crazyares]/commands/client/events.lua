QBCore = exports['qb-core']:GetCoreObject()
Admin = QBCore.Functions.GetPlayerData()

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    Admin = QBCore.Functions.GetPlayerData()
end)

local blockedPeds = {
    "mp_m_freemode_01",
    "mp_f_freemode_01",
}

--- Functions
local function LoadPlayerModel(skin)
    RequestModel(skin)
    while not HasModelLoaded(skin) do
      Wait(0)
    end
end

local function isPedAllowedRandom(skin)
    local retval = false
    for _, v in pairs(blockedPeds) do
        if v ~= skin then
            retval = true
        end
    end
    return retval
end

RegisterNetEvent('qb-admin:client:SetModel', function(skin)
    local ped = PlayerPedId()
    local model = GetHashKey(skin)
    SetEntityInvincible(ped, true)

    if IsModelInCdimage(model) and IsModelValid(model) then
        LoadPlayerModel(model)
        SetPlayerModel(PlayerId(), model)

        if isPedAllowedRandom(skin) then
            SetPedRandomComponentVariation(ped, true)
        end

		SetModelAsNoLongerNeeded(model)
	end
	SetEntityInvincible(ped, false)
end)

RegisterNetEvent('qb-weapons:client:SetWeaponAmmoManual', function(ammo, reason)
    local ped = PlayerPedId()
    local weapon = GetSelectedPedWeapon(ped)
    local weaponItem = exports.ox_inventory:getCurrentWeapon()
    
    if weapon == `WEAPON_UNARMED` then
        QBCore.Functions.Notify("You currently have no weapon", 'error')
    else
        if weaponItem then
            SetPedAmmo(ped, weapon, ammo)
            QBCore.Functions.Notify("Your ammo was set", 'success')
        end
    end
end)

RegisterNetEvent("admin:commands:pullstash", function()
    local pullstash = exports["qb-input"]:ShowInput({
        header = "Stash Menu",
        submitText = "Open Stash",
        inputs = {
            {
                text = "Type",
                name = "stashtype",
                type = "select",
                options = {
                    { value = "stash", text = "Stash" }, 
                    { value = "trunk", text = "Trunk" }, 
                    { value = "glovebox", text = "Glovebox" }, 
                }
            },
            {
                text = "id",
                name = "name",
                type = "text",
                isRequired = true
            }
        }
    })
    if pullstash then
        if not pullstash.name or not pullstash.stashtype then
            return
        else
            local stashId = tostring(pullstash.name)
            local stashLabel = "Admin Opened " .. pullstash.stashtype:gsub("^%l", string.upper) .. " (" .. stashId .. ")"
            local playerName = QBCore.Functions.GetPlayerData().charinfo.firstname .. " " .. QBCore.Functions.GetPlayerData().charinfo.lastname
            TriggerServerEvent('admin:server:PullStash', stashId, stashLabel, pullstash.stashtype, playerName)
        end
    end
end)

RegisterNetEvent("admin:commands:inventory", function(targetPed)
    exports.ox_inventory:forceOpenInventory(GetPlayerServerId(PlayerId()), "player", targetPed)
end)

RegisterNetEvent("admin:commands:godcuff", function(player)
    TriggerEvent('police:client:GetCuffed', player, true)
end)

RegisterNetEvent('admin:commands:warpinvehicle', function(playerId)
    local vehicle = QBCore.Functions.GetClosestVehicle()
    TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
    -- exports.qbx_vehiclekeys:GiveKeys(PlayerPedId(), vehicle)
    exports.wasabi_carlock:GiveKey(vehicle)
    --plate: vehicle plate number. you can use GetVehicleNumberPlateText(vehicle)
    -- exports['ak47_qb_vehiclekeys']:GiveKey(vehicle)
    -- local plate = qbx.getVehiclePlate(vehicle)
    -- TriggerServerEvent("vehicles_keys:selfGiveVehicleKeys", plate)
end)

local performanceModIndices = { 11, 12, 13, 15, 16 }
function PerformanceUpgradeVehicle(vehicle, customWheels)
    customWheels = customWheels or false
    local max
    if DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) then
        SetVehicleModKit(vehicle, 0)
        for _, modType in ipairs(performanceModIndices) do
            max = GetNumVehicleMods(vehicle, tonumber(modType)) - 1
            SetVehicleMod(vehicle, modType, max, customWheels)
        end
        ToggleVehicleMod(vehicle, 18, true) -- Turbo
	SetVehicleFixed(vehicle)
    end
end

RegisterNetEvent('admin:commands:maxmodVehicle', function()
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    PerformanceUpgradeVehicle(vehicle)
end)

RegisterNetEvent("admin:commands:wipestash", function()
    local pullstash = exports["qb-input"]:ShowInput({
        header = "Stash Menu",
        submitText = "Wipe Stash",
        inputs = {
            {
                text = "Type",
                name = "stashtype",
                type = "select",
                options = {
                    { value = "stash", text = "Stash" }, 
                    { value = "trunk", text = "Trunk" }, 
                    { value = "glovebox", text = "Glovebox" }, 
                }
            },
            {
                text = "id",
                name = "name",
                type = "text",
                isRequired = true
            }
        }
    })
    if pullstash then
        if not pullstash.name or not pullstash.stashtype then
            return
        else
            TriggerServerEvent("admin:commands:server:finishstashwipe", pullstash.name, pullstash.stashtype)
        end
    end
end)

local function getVehicleFromVehList(hash)
	for _, v in pairs(QBCore.Shared.Vehicles) do
		if hash == v.hash then
			return v.model
		end
	end
end

RegisterNetEvent("okokChat:client:muteplayersVoice", function(player)
	local player = PlayerPedId()
	exports['pma-voice']:overrideProximityCheck(function(player)
		return false
	end)
end)

RegisterNetEvent("okokChat:client:unmuteplayersVoice", function(player)
    exports['pma-voice']:resetProximityCheck()
end)

RegisterNetEvent("admin:commands:deleteMyMoney", function()
    local pullstash = exports["qb-input"]:ShowInput({
        header = "Burn Money",
        submitText = "Confirm?",
        inputs = {
            {
                text = "Bank/Cash?",
                name = "bankorcash",
                type = "select",
                options = {
                    { value = "bank", text = "Bank" }, 
                    { value = "cash", text = "Cash" }, 
                }
            },
            {
                text = "Amount Of Money?",
                name = "amountofmoney",
                type = "text",
                isRequired = true
            }
        }
    })
    if pullstash then
        if not pullstash.bankorcash or not pullstash.amountofmoney then
            return
        else
            TriggerServerEvent("admin:commands:server:deleteMyMoney", pullstash.bankorcash, pullstash.amountofmoney)
        end
    end
end)

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
      local iter, id = initFunc()
      if not id or id == 0 then
            disposeFunc(iter)
            return
        end
      
        local enum = {handle = iter, destructor = disposeFunc}
        setmetatable(enum, entityEnumerator)
      
        local next = true
        repeat
            coroutine.yield(id)
            next, id = moveFunc(iter)
        until not next
      
        enum.destructor, enum.handle = nil, nil
        disposeFunc(iter)
    end)
end
  
function EnumerateObjects()
    return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end
  
function EnumeratePeds()
    return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end
  
function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end
  
function EnumeratePickups()
    return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end

RegisterNetEvent("wclear:client:wclearprop", function()
    QBCore.Functions.TriggerCallback('commands:server:getPlayersAdminRank', function(rank)
        if rank then
            for object in EnumerateObjects() do
                if (IsEntityAnObject(object)) then 
                    SetEntityAsMissionEntity(object, false, false) 
                    DeleteEntity(object)
                    if (DoesEntityExist(object)) then 
                        DeleteEntity(object) 
                    end
                end
            end
        end
    end)
end)

RegisterNetEvent("wclear:client:wclearpeds", function()
    QBCore.Functions.TriggerCallback('commands:server:getPlayersAdminRank', function(rank)
        if rank then
            for ped in EnumeratePeds() do
                if (not IsPedAPlayer(ped)) then 
                    SetEntityAsMissionEntity(ped, false, false) 
                    DeleteEntity(ped)
                    if (DoesEntityExist(ped)) then 
                        DeleteEntity(ped) 
                    end
                end
            end
        end
    end)
end)

RegisterNetEvent("wclear:client:wclearcars", function()
    QBCore.Functions.TriggerCallback('commands:server:getPlayersAdminRank', function(rank)
        if rank then
            for vehicle in EnumerateVehicles() do
                if (not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1))) then 
                    SetVehicleHasBeenOwnedByPlayer(vehicle, false) 
                    SetEntityAsMissionEntity(vehicle, false, false) 
                    DeleteVehicle(vehicle)
                    if (DoesEntityExist(vehicle)) then 
                        DeleteVehicle(vehicle) 
                    end
                end
            end
        end
    end)
end)