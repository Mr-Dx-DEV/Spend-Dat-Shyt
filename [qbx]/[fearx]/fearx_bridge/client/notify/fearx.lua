Bridge.NotifyFearx = {}

CreateThread(function()
    Wait(500)
    if BridgeConfig.TextUIPosition then
        SendNUIMessage({
            action = 'setPosition',
            position = BridgeConfig.TextUIPosition
        })
    end
end)

function Bridge.NotifyFearx.SendNotify(title, message, type, duration)
    SendNUIMessage({
        action = 'notify',
        title = title or 'Notification',
        message = message or '',
        type = type or 'info',
        duration = duration or 5000
    })
end

function Bridge.NotifyFearx.ShowTextUI(text, key)
    SendNUIMessage({
        action = 'showTextUI',
        text = text or 'Interact',
        key = key or 'E'
    })
end

function Bridge.NotifyFearx.HideTextUI()
    SendNUIMessage({
        action = 'hideTextUI'
    })
end

function Bridge.NotifyFearx.ProgressBar(label, duration, options)
    Wait(duration)
    return true
end

function Bridge.NotifyFearx.ProgressCircle(label, duration, options)
    Wait(duration)
    return true
end
