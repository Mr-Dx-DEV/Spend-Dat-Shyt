-- shared/ui.lua (fixed)
local UI = {}

-- Track active text UIs to prevent conflicts
local activeTextUI = nil
local lastTextUpdate = 0

-- Show text UI with ID management
function UI:ShowTextUI(text, options)
    if not options then options = {} end
    options.id = options.id or 'default'
    
    -- Don't update too frequently (prevents flickering)
    local currentTime = GetGameTimer()
    if activeTextUI == options.id and (currentTime - lastTextUpdate) < 100 then
        return
    end
    
    activeTextUI = options.id
    lastTextUpdate = currentTime
    
    if Config.UISystem == 'ox_lib' then
        if not lib or not lib.showTextUI then
            print('ERROR: ox_lib not loaded or showTextUI not available')
            return
        end
        
        if activeTextUI ~= options.id and lib.hideTextUI then
            lib.hideTextUI()
            Wait(0)
        end
        
        lib.showTextUI(text, {
            position = options.position or "right-center",
            icon = options.icon,
            iconColor = options.iconColor
        })
        
    elseif Config.UISystem == 'qb-core' then
        if exports['qb-core'] and exports['qb-core'].DrawText then
            exports['qb-core']:DrawText(text, options.position or 'right')
        end
    elseif Config.UISystem == 'esx' then
        if ESX and ESX.ShowHelpNotification then
            ESX.ShowHelpNotification(text)
        end
    else
        if lib and lib.showTextUI then
            lib.showTextUI(text, {
                position = options.position or "right-center",
                icon = options.icon,
                iconColor = options.iconColor
            })
        end
    end
end

-- Hide specific text UI by ID
function UI:HideTextUI(id)
    if id and activeTextUI ~= id then
        return
    end
    
    activeTextUI = nil
    
    if Config.UISystem == 'ox_lib' then
        if lib and lib.hideTextUI then
            lib.hideTextUI()
        end
    elseif Config.UISystem == 'qb-core' then
        if exports['qb-core'] and exports['qb-core'].HideText then
            exports['qb-core']:HideText()
        end
    elseif Config.UISystem == 'esx' then
        if ESX and ESX.HideHelpNotification then
            ESX.HideHelpNotification()
        end
    else
        if lib and lib.hideTextUI then
            lib.hideTextUI()
        end
    end
end

-- Notify function
function UI:Notify(message, type, duration)
    duration = duration or 5000
    
    if Config.Notification == 'ox_lib' then
        if lib and lib.notify then
            lib.notify({
                title = 'OnlyPics',
                description = message,
                type = type,
                duration = duration,
                position = 'top'
            })
        else
            SetNotificationTextEntry('STRING')
            AddTextComponentString(message)
            DrawNotification(false, false)
        end
        
    elseif Config.Notification == 'qb-core' then
        if exports['qb-core'] and exports['qb-core'].Notify then
            local qbTypes = {
                ['success'] = 'success',
                ['error'] = 'error',
                ['info'] = 'primary',
                ['warning'] = 'warning'
            }
            exports['qb-core']:Notify(message, qbTypes[type] or 'primary', duration)
        end
        
    elseif Config.Notification == 'esx' then
        if ESX and ESX.ShowNotification then
            ESX.ShowNotification(message, type, duration)
        end
        
    elseif Config.Notification == 'custom' and Config.CustomNotify then
        Config.CustomNotify(message, type, duration)
        
    else
        SetNotificationTextEntry('STRING')
        AddTextComponentString(message)
        DrawNotification(false, false)
    end
end

-- Input dialog function
function UI:InputDialog(title, inputs)
    if Config.UISystem == 'ox_lib' and lib and lib.inputDialog then
        return lib.inputDialog(title, inputs)
    elseif Config.UISystem == 'qb-core' and exports['qb-core'] and exports['qb-core'].Functions then
        local qbInput = exports['qb-core']:GetInput(title, 'Enter text...')
        return qbInput and {qbInput}
    else
        AddTextEntry('FMMC_MPM_NA', title)
        DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 30)
        
        while UpdateOnscreenKeyboard() == 0 do
            DisableAllControlActions(0)
            Wait(0)
        end
        
        if GetOnscreenKeyboardResult() then
            local result = GetOnscreenKeyboardResult()
            return result ~= "" and {result} or nil
        end
        return nil
    end
end

-- Progress bar function
function UI:ProgressBar(options)
    if Config.UISystem == 'ox_lib' and lib and lib.progressBar then
        return lib.progressBar(options)
    elseif Config.UISystem == 'qb-core' and exports['qb-core'] and exports['qb-core'].Progressbar then
        exports['qb-core']:Progressbar('Selling', options.label, options.duration, options.disable or {}, true, true, {
            disableMovement = options.disable and options.disable.move or false,
            disableCarMovement = options.disable and options.disable.carMovement or false,
            disableMouse = false,
            disableCombat = options.disable and options.disable.combat or false,
        }, {}, {}, {}, function()
            return true
        end, function()
            return false
        end)
        Wait(options.duration)
        return true
    else
        Wait(options.duration)
        return true
    end
end

-- Request animation dictionary
function UI:RequestAnimDict(animDict)
    if not HasAnimDictLoaded(animDict) then
        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            Wait(10)
        end
    end
end

-- Callback function (FIXED)
function UI:Callback(event, ...)
    if lib and lib.callback and lib.callback.await then
        return lib.callback.await(event, false, ...)
    else
        print('ERROR: ox_lib callback not available')
        return false
    end
end

-- Cleanup all text UIs
function UI:CleanupTextUI()
    activeTextUI = nil
    self:HideTextUI()
end

return UI