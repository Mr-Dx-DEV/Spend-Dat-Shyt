if GetResourceState('ox_lib') ~= 'started' then return end

Bridge.NotifyOxLib = {}

function Bridge.NotifyOxLib.SendNotify(title, message, type, duration)
    type = type or 'info'
    duration = duration or 5000
    exports['ox_lib']:notify({
        title = title,
        description = message,
        type = type,
        duration = duration
    })
end

function Bridge.NotifyOxLib.ShowTextUI(text, position)
    position = position or 'right-center'
    exports['ox_lib']:showTextUI(text, {position = position})
end

function Bridge.NotifyOxLib.HideTextUI()
    exports['ox_lib']:hideTextUI()
end

function Bridge.NotifyOxLib.ProgressBar(label, duration, options)
    options = options or {}
    return exports['ox_lib']:progressBar({
        duration = duration,
        label = label,
        useWhileDead = options.useWhileDead or false,
        canCancel = options.canCancel or true,
        disable = options.disable or {car = true, move = true, combat = true},
        anim = options.anim or nil,
        prop = options.prop or nil
    })
end

function Bridge.NotifyOxLib.ProgressCircle(label, duration, options)
    options = options or {}
    return exports['ox_lib']:progressCircle({
        duration = duration,
        label = label,
        useWhileDead = options.useWhileDead or false,
        canCancel = options.canCancel or true,
        disable = options.disable or {car = true, move = true, combat = true},
        anim = options.anim or nil,
        prop = options.prop or nil
    })
end

function Bridge.NotifyOxLib.InputDialog(title, inputs)
    return exports['ox_lib']:inputDialog(title, inputs)
end

function Bridge.NotifyOxLib.AlertDialog(data)
    return exports['ox_lib']:alertDialog(data)
end

function Bridge.NotifyOxLib.ContextMenu(id, title, options)
    exports['ox_lib']:registerContext({
        id = id,
        title = title,
        options = options
    })
    exports['ox_lib']:showContext(id)
end

function Bridge.NotifyOxLib.HideContext()
    exports['ox_lib']:hideContext()
end
