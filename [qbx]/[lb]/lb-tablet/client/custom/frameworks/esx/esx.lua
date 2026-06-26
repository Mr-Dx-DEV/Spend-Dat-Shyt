if Config.Framework ~= "esx" then
    return
end

debugprint("Loading ESX")

local export, obj = pcall(function()
    return exports.es_extended:getSharedObject()
end)

if export then
    ESX = obj
else
    while not ESX do
        TriggerEvent("esx:getSharedObject", function(obj)
            ESX = obj
        end)

        Wait(500)
    end
end

RegisterNetEvent("esx:playerLoaded", function(playerData)
    ESX.PlayerData = playerData
    ESX.PlayerLoaded = true

    TriggerServerEvent("lb-tablet:frameworkLoaded")
end)

RegisterNetEvent("esx:onPlayerLogout", function()
    FrameworkLoaded = false
    ESX.PlayerLoaded = false

    LogOut()

    while not ESX.PlayerLoaded do
        Wait(500)
    end

    FrameworkLoaded = true

    FetchTabletData()
end)

while not ESX.PlayerLoaded do
    Wait(500)
end

TriggerServerEvent("lb-tablet:frameworkLoaded")

function FormatVehicle(vehicle)
    vehicle.vehicle = json.decode(vehicle.vehicle)

    if vehicle.vehicle then
        vehicle.color = GetVehicleColor(vehicle.vehicle.color1)
        vehicle.model = GetVehicleLabel(vehicle.vehicle.model)
        vehicle.vehicle = nil
    end

    if vehicle.name then
        vehicle.owner = {
            name = vehicle.name,
            identifier = vehicle.owner
        }

        vehicle.name = nil
    end

    return vehicle
end

---@return boolean
function IsAdmin()
    ---@diagnostic disable-next-line: redundant-return-value
    return AwaitCallback("isAdmin")
end

local weaponList

function GetWeaponsList()
    if weaponList then
        return weaponList
    end

    weaponList = {}

    local weapons = ESX.GetWeaponList()

    for i = 1, #weapons do
        local weapon = weapons[i]
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

debugprint("ESX loaded")

FrameworkLoaded = true
