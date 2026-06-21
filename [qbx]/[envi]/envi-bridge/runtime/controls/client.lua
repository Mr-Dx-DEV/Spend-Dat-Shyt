local disableControls = {}
local disableAll = false
local disableFrontend = false
local DisableControlAction = DisableControlAction
local DisableAllControlActions = DisableAllControlActions
local threading = false

Controls = {}

Controls.Disable = function(control)
    local controlsType = type(control)
    if controlsType == 'number' then
        disableControls[#disableControls + 1] = control
    elseif controlsType == 'table' and table.type(control) == "array" then
        for i = 1, #control do
            disableControls[#disableControls + 1] = control[i]
        end
    end
    ControlThread()
end

Controls.DisableAll = function()
    disableAll = true
    ControlThread()
end

Controls.Enable = function(control)
    local controlsType = type(control)
    if controlsType == 'number' then
        for i = 1, #disableControls do
            if disableControls[i] == control then
                table.remove(disableControls, i)
                break
            end
        end
    elseif controlsType == 'table' and table.type(control) == "array" then
        for i = 1, #disableControls do
            for i2 = 1, #control do
                if disableControls[i] == control[i2] then
                    table.remove(disableControls, i)
                end
            end
        end
    end
    ControlThread()
end

Controls.EnableAll = function()
    disableAll = false
    ControlThread()
end

Controls.DisableFrontend = function()
    disableFrontend = true
    ControlThread()
end

Controls.EnableFrontend = function()
    disableFrontend = false
    ControlThread()
end

exports('Controls', function(functionName, control)
    return Controls[functionName](control)
end)

function ControlThread()
    if (#disableControls == 0 or not disableAll) and threading and not disableFrontend then
        threading = false
        return
    end

    if threading then return end

    threading = true

    CreateThread(function()
        while threading do
            for i = 1, #disableControls do
                DisableControlAction(2, disableControls[i], true)
            end
            if disableAll then
                DisableAllControlActions(0)
            end
            if disableFrontend then
                DisableFrontendThisFrame()
            end
            Wait(0)
        end
    end)
end
