--[[
    PROGRESS BAR SYSTEM
    Customize the progress bar shown when the player is sweeping.

    This function MUST return true when completed, or false if cancelled.

    Default: ox_lib progress bar
    You can replace this with any progress bar system you use.

    Examples:
        -- ox_lib (default)
        return exports.ox_lib:progressBar({ duration = duration, label = label, ... })

        -- qb-core progressbar
        local finished = false
        local completed = false
        exports['progressbar']:Progress({
            name = 'comserv_sweep',
            duration = duration,
            label = label,
            useWhileDead = false,
            canCancel = false,
            disableMovement = true,
            disableCombat = true,
            disableCarMovement = true,
        }, function(cancelled)
            completed = not cancelled
            finished = true
        end)
        while not finished do Wait(100) end
        return completed

        -- rprogress
        exports['rprogress']:Custom({
            Duration = duration,
            Label = label,
            canCancel = false,
            DisableControls = { Move = true, Car = true, Combat = true },
        })
        return true

        -- No progress bar (just wait)
        Wait(duration)
        return true
]]

function CustomProgressBar(duration, label)
    if GetResourceState('ox_lib') == 'started' then
        return exports.ox_lib:progressBar({
            duration = duration,
            label = label,
            useWhileDead = false,
            canCancel = false,
            disable = { car = true, move = true, combat = true },
        })
    else
        Wait(duration)
        return true
    end
end
