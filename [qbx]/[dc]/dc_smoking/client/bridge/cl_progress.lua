Progress = {}

local progressSystem = Config.ProgressBar or 'built-in'

function Progress.Start(duration, label, image)
    if progressSystem == 'built-in' then
        SendNUIMessage({ action = 'progress', duration = duration, label = label, image = image })
        local p = promise.new()
        SetTimeout(duration, function() p:resolve(true) end)
        return Citizen.Await(p)

    elseif progressSystem == 'ox' then
        local result = exports.ox_lib:progressCircle({
            duration = duration,
            label = label or 'Processing',
            position = 'bottom',
            canCancel = false,
        })
        return result ~= false

    elseif progressSystem == 'esx' then
        ESX.Progressbar(label or 'Processing', duration)
        return true

    elseif progressSystem == 'qb' then
        local QBCore = exports['qb-core']:GetCoreObject()
        local p = promise.new()
        QBCore.Functions.Progressbar('dc_smoking_progress', label or 'Processing', duration, false, false,
            { disableMovement = false, disableCarMovement = false, disableCombat = true, disableMouse = false },
            {}, {}, {},
            function() p:resolve(true) end,
            function() p:resolve(false) end
        )
        return Citizen.Await(p)

    elseif progressSystem == 'custom' then
        -- ============================================================
        -- CUSTOM PROGRESS BAR SYSTEM
        -- Replace the code below with your own progress bar call.
        -- Parameters available:
        --   duration (number) : Duration in milliseconds
        --   label    (string) : Text to display (e.g. "Rolling...")
        --   image    (string) : Item name for icon (only used by built-in)
        -- Must return true when completed, false if cancelled.
        -- ============================================================
        SendNUIMessage({ action = 'progress', duration = duration, label = label, image = image })
        local p = promise.new()
        SetTimeout(duration, function() p:resolve(true) end)
        return Citizen.Await(p)
    end

    return true
end
