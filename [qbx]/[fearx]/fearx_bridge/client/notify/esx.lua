if GetResourceState('es_extended') ~= 'started' then return end

Bridge.NotifyEsx = {}

local ESX = nil

CreateThread(function()
    while ESX == nil do
        ESX = exports['es_extended']:getSharedObject()
        Wait(100)
    end
end)

function Bridge.NotifyEsx.SendNotify(title, message, type, duration)
    type = type or 'info'
    duration = duration or 5000
    if GetResourceState('esx_notify') == 'started' then
        exports['esx_notify']:Notify(type, duration, message)
    elseif ESX then
        ESX.ShowNotification(message)
    else
        BeginTextCommandThefeedPost('STRING')
        AddTextComponentSubstringPlayerName(message)
        EndTextCommandThefeedPostTicker(false, true)
    end
end

function Bridge.NotifyEsx.ShowTextUI(text, position)
    if GetResourceState('esx_textui') == 'started' then
        exports['esx_textui']:TextUI(text)
    else
        Bridge.textUIActive = true
        Bridge.textUIText = text
    end
end

function Bridge.NotifyEsx.HideTextUI()
    if GetResourceState('esx_textui') == 'started' then
        exports['esx_textui']:HideUI()
    else
        Bridge.textUIActive = false
    end
end

function Bridge.NotifyEsx.ProgressBar(label, duration, options)
    options = options or {}
    if GetResourceState('esx_progressbar') == 'started' then
        exports['esx_progressbar']:Progressbar(label, duration, {
            FreezePlayer = options.disableMovement or true,
            animation = options.anim or nil,
            onFinish = function() end,
            onCancel = function() end
        })
        Wait(duration)
        return true
    else
        Wait(duration)
        return true
    end
end

function Bridge.NotifyEsx.ProgressCircle(label, duration, options)
    return Bridge.NotifyEsx.ProgressBar(label, duration, options)
end
