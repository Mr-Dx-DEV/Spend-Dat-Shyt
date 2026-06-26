if Config.Framework ~= "qb" then
    return
end

debugprint("Loading QB")

QB = exports["qb-core"]:GetCoreObject()

while not LocalPlayer.state.isLoggedIn do
    Wait(500)
end

TriggerServerEvent("lb-tablet:frameworkLoaded")

local SharedVehicles = QB.Shared.Vehicles
local PlayerData = QB.Functions.GetPlayerData()

PlayerJob = PlayerData.job

debugprint("QB loaded")

RegisterNetEvent("QBCore:Client:OnPlayerUnload", function()
    FrameworkLoaded = false

    PlayerData = {}
    PlayerJob = {}

    LogOut()
end)

RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function(...)
    PlayerData = QB.Functions.GetPlayerData()
    PlayerJob = PlayerData.job

    FrameworkLoaded = true

    TriggerServerEvent("lb-tablet:frameworkLoaded")
    FetchTabletData()
end)

---@return boolean
function IsAdmin()
    ---@diagnostic disable-next-line: redundant-return-value
    return AwaitCallback("isAdmin")
end

RegisterNetEvent("QBCore:Player:SetPlayerData", function(newData)
    PlayerData = newData

    local metadata = PlayerData.metadata or {}

    if (metadata.ishandcuffed or metadata.isdead or metadata.inlaststand) then
        ToggleOpen(false)
    end
end)

function FormatVehicle(vehicle)
    debugprint("Formatting vehicle", vehicle)

    local mods = json.decode(vehicle.mods)

    if mods then
        vehicle.color = GetVehicleColor(mods.color1)
        vehicle.model = SharedVehicles[vehicle.vehicle]?.name or GetVehicleLabel(mods.model)
    end

    vehicle.mods = nil

    if vehicle.name then
        vehicle.owner = {
            name = vehicle.name,
            identifier = vehicle.owner
        }

        vehicle.name = nil
    end

    return vehicle
end

local weaponList

function GetWeaponsList()
    if weaponList then
        return weaponList
    end

    weaponList = {}

    local weapons = QB.Shared.Weapons

    for hash, weapon in pairs(weapons) do
        local label = weapon.label
        local model = weapon.name

        if label and model then
            weaponList[#weaponList + 1] = {
                model = model,
                label = label
            }
        end
    end

    table.sort(weaponList, function(a, b)
        return a.label < b.label
    end)

    return weaponList
end

AddCheck("openTablet", function()
    local metadata = PlayerData.metadata or {}

    if metadata.ishandcuffed or metadata.isdead or metadata.inlaststand then
        return false
    end

    return true
end)

FrameworkLoaded = true
