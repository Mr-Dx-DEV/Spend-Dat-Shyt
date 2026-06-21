Bridge.NotifyNative = {}

function Bridge.NotifyNative.SendNotify(title, message, type, duration)
    BeginTextCommandThefeedPost('STRING')
    AddTextComponentSubstringPlayerName(title .. ': ' .. message)
    EndTextCommandThefeedPostTicker(false, true)
end

function Bridge.NotifyNative.ShowTextUI(text, position)
    Bridge.textUIActive = true
    Bridge.textUIText = text
end

function Bridge.NotifyNative.HideTextUI()
    Bridge.textUIActive = false
end

function Bridge.NotifyNative.ProgressBar(label, duration, options)
    Wait(duration)
    return true
end

function Bridge.NotifyNative.ProgressCircle(label, duration, options)
    Wait(duration)
    return true
end

CreateThread(function()
    while true do
        Wait(0)
        if Bridge.textUIActive and Bridge.textUIText then
            SetTextFont(4)
            SetTextScale(0.4, 0.4)
            SetTextColour(255, 255, 255, 255)
            SetTextDropshadow(0, 0, 0, 0, 255)
            SetTextEdge(2, 0, 0, 0, 150)
            SetTextDropShadow()
            SetTextOutline()
            SetTextEntry('STRING')
            AddTextComponentString(Bridge.textUIText)
            DrawText(0.85, 0.5)
        else
            Wait(500)
        end
    end
end)
