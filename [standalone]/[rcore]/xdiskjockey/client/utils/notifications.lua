--- Will display help notification
--- @param text string
function ShowNotification(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(0, 1)
end

--- Will display help notification
--- @param msg string
--- @param thisFrame boolean
--- @param beep boolean
--- @param duration int
function ShowHelpNotification(msg, thisFrame, beep, duration)
    AddTextEntry('xdj_help_msg', msg)

    if thisFrame then
        DisplayHelpTextThisFrame('xdj_help_msg', false)
    else
        if beep == nil then
            beep = false
        end
        BeginTextCommandDisplayHelp('xdj_help_msg')
        EndTextCommandDisplayHelp(0, false, beep, duration)
    end
end

function ShowFancyNotification(text, style)
    SendNUIMessage({
        type = "notify",
        msg = text,
        style = style,
    })
end

RegisterNetEvent("xdiskjockey:notify", ShowFancyNotification)