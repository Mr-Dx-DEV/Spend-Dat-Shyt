if GetResourceState('qb-core') ~= 'started' and GetResourceState('qbx_core') ~= 'started' then return end

Bridge.NotifyQb = {}

local QBCore = nil

CreateThread(function()
    while QBCore == nil do
        if GetResourceState('qb-core') == 'started' then
            QBCore = exports['qb-core']:GetCoreObject()
        elseif GetResourceState('qbx_core') == 'started' then
            QBCore = exports['qbx_core']:GetCoreObject()
        end
        Wait(100)
    end
end)

function Bridge.NotifyQb.SendNotify(title, message, type, duration)
    type = type or 'primary'
    duration = duration or 5000
    if QBCore then
        QBCore.Functions.Notify(message, type, duration)
    else
        TriggerEvent('QBCore:Notify', message, type, duration)
    end
end

function Bridge.NotifyQb.ShowTextUI(text, position)
    position = position or 'right-center'
    if GetResourceState('qb-core') == 'started' then
        exports['qb-core']:DrawText(text, position)
    elseif GetResourceState('qbx_core') == 'started' then
        exports['qbx_core']:DrawText(text, position)
    else
        Bridge.textUIActive = true
        Bridge.textUIText = text
    end
end

function Bridge.NotifyQb.HideTextUI()
    if GetResourceState('qb-core') == 'started' then
        exports['qb-core']:HideText()
    elseif GetResourceState('qbx_core') == 'started' then
        exports['qbx_core']:HideText()
    else
        Bridge.textUIActive = false
    end
end

function Bridge.NotifyQb.ProgressBar(label, duration, options)
    options = options or {}
    if GetResourceState('progressbar') == 'started' and QBCore then
        local finished = false
        QBCore.Functions.Progressbar('bridge_progress', label, duration, false, options.canCancel or true, {
            disableMovement = options.disableMovement or true,
            disableCarMovement = options.disableCarMovement or true,
            disableMouse = false,
            disableCombat = options.disableCombat or true
        }, options.anim or {}, {}, {}, function()
            finished = true
        end, function()
            finished = false
        end)
        while finished == false do
            Wait(100)
        end
        return finished
    else
        Wait(duration)
        return true
    end
end

function Bridge.NotifyQb.ProgressCircle(label, duration, options)
    return Bridge.NotifyQb.ProgressBar(label, duration, options)
end
