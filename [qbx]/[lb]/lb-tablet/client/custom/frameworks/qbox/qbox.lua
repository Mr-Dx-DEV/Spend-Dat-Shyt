if Config.Framework ~= "qbox" then
    return
end

debugprint("Loading QBox")

Qbox = exports["qb-core"]:GetCoreObject()

while not LocalPlayer.state.isLoggedIn do
    Wait(500)
end

TriggerServerEvent("lb-tablet:frameworkLoaded")

local SharedVehicles = Qbox.Shared.Vehicles
local PlayerData = Qbox.Functions.GetPlayerData()

PlayerJob = PlayerData.job

debugprint("QBox loaded")

RegisterNetEvent("QBCore:Client:OnPlayerUnload", function()
    FrameworkLoaded = false

    PlayerData = {}
    PlayerJob = {}

    LogOut()
end)

RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
    PlayerData = Qbox.Functions.GetPlayerData()
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

    local metadata = PlayerData.metadata

    if metadata and (metadata.isdead or metadata.inlaststand) then
        Citizen.CreateThreadNow(HandleDead)
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

    if GetResourceState("ox_inventory") ~= "started" then
        infoprint("warning", "ox_inventory is not started. Please configure GetWeaponsList manually.")
        return weaponList
    end

    local items = exports.ox_inventory:Items()

    for name, item in pairs(items) do
        if item.weapon then
            weaponList[#weaponList + 1] = {
                model = name,
                label = item.label
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
