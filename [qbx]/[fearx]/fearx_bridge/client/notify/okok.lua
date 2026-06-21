if GetResourceState('okokNotify') ~= 'started' then return end

Bridge.NotifyOkok = {}

function Bridge.NotifyOkok.SendNotify(title, message, type, duration)
    type = type or 'info'
    duration = duration or 5000
    exports['okokNotify']:Alert(title, message, duration, type)
end

function Bridge.NotifyOkok.ShowTextUI(text, position)
    if GetResourceState('okokTextUI') == 'started' then
        exports['okokTextUI']:Open(text, 'dark', position or 'right')
    else
        Bridge.textUIActive = true
        Bridge.textUIText = text
    end
end

function Bridge.NotifyOkok.HideTextUI()
    if GetResourceState('okokTextUI') == 'started' then
        exports['okokTextUI']:Close()
    else
        Bridge.textUIActive = false
    end
end

function Bridge.NotifyOkok.ProgressBar(label, duration, options)
    options = options or {}
    Wait(duration)
    return true
end

function Bridge.NotifyOkok.ProgressCircle(label, duration, options)
    options = options or {}
    Wait(duration)
    return true
end
