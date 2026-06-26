if Config.Framework ~= "standalone" then
    return
end

debugprint("Using standalone/registration framework")

while not NetworkIsSessionStarted() do
    Wait(500)
end

TriggerServerEvent("lb-tablet:frameworkLoaded")

-- Event that is triggered when a player's character is loaded
RegisterNetEvent("framework:playerLoaded", function(playerData)
    TriggerServerEvent("lb-tablet:frameworkLoaded")
end)

-- Event that is triggered when a player's character is unloaded
RegisterNetEvent("framework:playerUnloaded", function()
    FrameworkLoaded = false

    LogOut()

    -- Wait for the player to select a new character, then fetch tablet data etc

    -- while not ESX.PlayerLoaded do
    --     Wait(500)
    -- end

    -- FrameworkLoaded = true

    -- FetchTabletData()
end)

function FormatVehicle(vehicle)
    if vehicle.name then
        vehicle.owner = {
            name = vehicle.name,
            identifier = vehicle.owner
        }

        vehicle.name = nil
    end

    vehicle.color = vehicle.color and {
        label = "",
        hex = vehicle.color
    }

    return vehicle
end

---@return boolean
function IsAdmin()
    ---@diagnostic disable-next-line: redundant-return-value
    return AwaitCallback("isAdmin")
end

---@return { label: string, model: string }[]
function GetWeaponsList()
    return Weapons
end

--#endregion

FrameworkLoaded = true
