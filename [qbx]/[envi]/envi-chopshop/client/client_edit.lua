-- Notifications / Dispatch Functions
function Notify(message, type, time) -- Change this to your own notification system if you want
    lib.notify({                     -- [ox_lib by default]
        id = 'chopshop-notify'..math.random(1, 1000000),
        title = 'Chop Shop',
        description = message,
        position = 'top',
        style = {
            backgroundColor = '#141517',
            color = '#909296'
        },
        icon = 'car-burst',
        iconColor = '#C53030',
        duration = time
    })
end

function DispatchEvent(coords)
    exports['ps-dispatch']:SuspiciousActivity() -- - CHANGE THIS TO YOUR OWN DISPATCH TRIGGERS IF NOT USING PS-DISPATCH

    if Config.EnviAddictions then -- edit here if you are using Envi-Addictions and want to change the addiction amount etc.
        exports['envi-addictions']:AddAddiction('crime', 2)
    end
end

function ShowTextUI(message)
    lib.showTextUI(message)
end

function HideTextUI()
    lib.hideTextUI()
end

-- New for 3.0.7!! -- Blips/Notify for hardcore mode owner warnings

function ClearHardcoreOwnerWarnBlip()
    if HardcoreOwnerWarnBlip then
        RemoveBlip(HardcoreOwnerWarnBlip)
        HardcoreOwnerWarnBlip = nil
    end
end

RegisterNetEvent('envi-chopshop:hardcoreOwnerWarn', function(coords, plate)
    if not Config.HardcoreModeOwnerWarnings or not Config.HardcoreModeOwnerWarnings.Enabled then return end
    ClearHardcoreOwnerWarnBlip()
    if Config.HardcoreModeOwnerWarnings.Blip and Config.HardcoreModeOwnerWarnings.Blip.Enabled and coords then
        PlaySoundFrontend(-1, "OOB_Cancel", "GTAO_FM_Events_Soundset", true)
        HardcoreOwnerWarnBlip = AddBlipForCoord(coords.x, coords.y, coords.z)
        SetBlipSprite(HardcoreOwnerWarnBlip, Config.HardcoreModeOwnerWarnings.Blip.Sprite or 161)
        SetBlipColour(HardcoreOwnerWarnBlip, Config.HardcoreModeOwnerWarnings.Blip.Color or 2)
        SetBlipScale(HardcoreOwnerWarnBlip, 0.5)
        SetBlipAsShortRange(HardcoreOwnerWarnBlip, Config.HardcoreModeOwnerWarnings.Blip.ShortRange ~= false)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(Config.HardcoreModeOwnerWarnings.Blip.Name or '!! YOUR VEHICLE IS BEING CHOPPED !!')
        EndTextCommandSetBlipName(HardcoreOwnerWarnBlip)
    end
    local plate = plate or 'UNKNOWN'
    Notify(string.format(Config.Lang['your_vehicle_being_chopped'] or 'Your vehicle [%s] is being chopped! Check your GPS!', plate), 'error', 25000)
end)
