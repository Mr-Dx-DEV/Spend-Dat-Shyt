local DisableControlAction = DisableControlAction

local player = PlayerId()

local disableControlsInterval = Interval:new(function()
    -- disable punching
    DisableControlAction(0, 24, true)
    DisableControlAction(0, 25, true)
    DisableControlAction(0, 68, true)
    DisableControlAction(0, 69, true)
    DisableControlAction(0, 70, true)
    DisableControlAction(0, 91, true)
    DisableControlAction(0, 92, true)
    DisableControlAction(0, 106, true)
    DisableControlAction(0, 114, true)
    DisableControlAction(0, 140, true)
    DisableControlAction(0, 141, true)
    DisableControlAction(0, 142, true)
    DisableControlAction(0, 257, true)
    DisableControlAction(0, 263, true)
    DisableControlAction(0, 264, true)
    DisableControlAction(0, 330, true)
    DisableControlAction(0, 331, true)
    DisablePlayerFiring(player, true)

    -- disable ESC
    DisableControlAction(0, 199, true)
    DisableControlAction(0, 200, true)
end, 0, false)

local disableControlsFocusedInterval = Interval:new(function()
    -- disable looking around
    DisableControlAction(0, 1, true)
    DisableControlAction(0, 2, true)

    -- disable chat
    DisableControlAction(0, 245, true)

    -- disable scrollwheel
    DisableControlAction(0, 14, true)
    DisableControlAction(0, 15, true)
    DisableControlAction(0, 16, true)
    DisableControlAction(0, 17, true)
    DisableControlAction(0, 37, true)
    DisableControlAction(0, 50, true)
    DisableControlAction(0, 99, true)
    DisableControlAction(0, 115, true)
    DisableControlAction(0, 180, true)
    DisableControlAction(0, 181, true)
    DisableControlAction(0, 198, true)
    DisableControlAction(0, 241, true)
    DisableControlAction(0, 242, true)
    DisableControlAction(0, 261, true)
    DisableControlAction(0, 262, true)

    -- disable radio (scrollwheel down is not enough)
    DisableControlAction(0, 85, true)
end, 0, false)

---@param disabled boolean
---@param focused? boolean
function ToggleDisableControls(disabled, focused)
    player = PlayerId()

    disableControlsInterval:toggle(disabled)
    disableControlsFocusedInterval:toggle(disabled and focused)
end
