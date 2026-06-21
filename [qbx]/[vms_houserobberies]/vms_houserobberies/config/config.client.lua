if Config.Core == "ESX" then
    RegisterNetEvent(Config.PlayerSetJob)
    AddEventHandler(Config.PlayerSetJob, function(PLAYER_JOB)
        PlayerData.job = PLAYER_JOB
    end)
elseif Config.Core == "QB-Core" then
    RegisterNetEvent(Config.PlayerSetJob)
    AddEventHandler(Config.PlayerSetJob, function(PLAYER_JOB)
        PlayerData.job = PLAYER_JOB
    end)
end

function DrawText3D(coords, text, textScale) -- This is the function used when using Config.Use3DText
    local textScale = textScale or 0.45
    local camCoords = GetFinalRenderedCamCoord()
    local distance = #(coords.xyz - camCoords)
    local scale = (textScale / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    scale = scale * fov
    SetTextScale(0.0 * scale, 0.55 * scale)
    SetTextFont(4)
    SetTextDropShadow()
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(coords.x, coords.y, coords.z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

CL = {}

-- ███╗   ██╗ ██████╗ ████████╗██╗███████╗██╗ ██████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗███████╗
-- ████╗  ██║██╔═══██╗╚══██╔══╝██║██╔════╝██║██╔════╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
-- ██╔██╗ ██║██║   ██║   ██║   ██║█████╗  ██║██║     ███████║   ██║   ██║██║   ██║██╔██╗ ██║███████╗
-- ██║╚██╗██║██║   ██║   ██║   ██║██╔══╝  ██║██║     ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║╚════██║
-- ██║ ╚████║╚██████╔╝   ██║   ██║██║     ██║╚██████╗██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║███████║
-- ╚═╝  ╚═══╝ ╚═════╝    ╚═╝   ╚═╝╚═╝     ╚═╝ ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝
CL.Notification = function(message, time, type)
    if type == "success" then
        if GetResourceState("vms_notify") == 'started' then
            exports['vms_notify']:Notification("HOUSE ROBBERY", message, time, "#36f230", "fa-solid fa-mask")
        else
            TriggerEvent('esx:showNotification', message)
            TriggerEvent('QBCore:Notify', message, 'success', time)
        end
    elseif type == "error" then
        if GetResourceState("vms_notify") == 'started' then
            exports['vms_notify']:Notification("HOUSE ROBBERY", message, time, "#f23030", "fa-solid fa-mask")
        else
            TriggerEvent('esx:showNotification', message)
            TriggerEvent('QBCore:Notify', message, 'error', time)
        end
    elseif type == "info" then
        if GetResourceState("vms_notify") == 'started' then
            exports['vms_notify']:Notification("HOUSE ROBBERY", message, time, "#4287f5", "fa-solid fa-mask")
        else
            TriggerEvent('esx:showNotification', message)
            TriggerEvent('QBCore:Notify', message, 'primary', time)
        end
    elseif type == "police_notify" then
        if GetResourceState("vms_notify") == 'started' then
            exports['vms_notify']:Notification("ALERT", message, 15000, "#4287f5", "fa-solid fa-mask")
        else
            TriggerEvent('esx:showNotification', message)
            TriggerEvent('QBCore:Notify', message, 'primary', 10000)
        end
    end
end


-- ██╗  ██╗██╗   ██╗██████╗ 
-- ██║  ██║██║   ██║██╔══██╗
-- ███████║██║   ██║██║  ██║
-- ██╔══██║██║   ██║██║  ██║
-- ██║  ██║╚██████╔╝██████╔╝
-- ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ 
CL.Hud = {
    Enable = function()
        if GetResourceState('vms_hud') ~= 'missing' then
            exports['vms_hud']:Display(true)
        end
    end,
    Disable = function()
        if GetResourceState('vms_hud') ~= 'missing' then
            exports['vms_hud']:Display(false)
        end
    end
}


-- ████████╗███████╗██╗  ██╗████████╗██╗   ██╗██╗
-- ╚══██╔══╝██╔════╝╚██╗██╔╝╚══██╔══╝██║   ██║██║
--    ██║   █████╗   ╚███╔╝    ██║   ██║   ██║██║
--    ██║   ██╔══╝   ██╔██╗    ██║   ██║   ██║██║
--    ██║   ███████╗██╔╝ ██╗   ██║   ╚██████╔╝██║
--    ╚═╝   ╚══════╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝
CL.TextUI = {
    Enabled = false,
    Open = function(message)
        -- exports["interact"]:Open("E", message) -- Here you can use your TextUI or use my free one - https://github.com/vames-dev/interact
    end,
    Close = function()
        -- exports["interact"]:Close() -- Here you can use your TextUI or use my free one - https://github.com/vames-dev/interact
    end
}


-- ██████╗ ██████╗  ██████╗  ██████╗ ██████╗ ███████╗███████╗███████╗    ██████╗  █████╗ ██████╗ 
-- ██╔══██╗██╔══██╗██╔═══██╗██╔════╝ ██╔══██╗██╔════╝██╔════╝██╔════╝    ██╔══██╗██╔══██╗██╔══██╗
-- ██████╔╝██████╔╝██║   ██║██║  ███╗██████╔╝█████╗  ███████╗███████╗    ██████╔╝███████║██████╔╝
-- ██╔═══╝ ██╔══██╗██║   ██║██║   ██║██╔══██╗██╔══╝  ╚════██║╚════██║    ██╔══██╗██╔══██║██╔══██╗
-- ██║     ██║  ██║╚██████╔╝╚██████╔╝██║  ██║███████╗███████║███████║    ██████╔╝██║  ██║██║  ██║
-- ╚═╝     ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝    ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝
CL.ProgressBar = function(label, time)
    exports['progressbar']:Progress({
        name = 'vms_houserobberies',
        label = label,
        duration = time,
        canCancel = false,
        controlDisables = {
            disableMouse = false,
            disableMovement = true,
            disableCarMovement = true,
            disableCombat = true,
        }
    })
end


-- ███╗   ███╗██╗███╗   ██╗██╗ ██████╗  █████╗ ███╗   ███╗███████╗███████╗
-- ████╗ ████║██║████╗  ██║██║██╔════╝ ██╔══██╗████╗ ████║██╔════╝██╔════╝
-- ██╔████╔██║██║██╔██╗ ██║██║██║  ███╗███████║██╔████╔██║█████╗  ███████╗
-- ██║╚██╔╝██║██║██║╚██╗██║██║██║   ██║██╔══██║██║╚██╔╝██║██╔══╝  ╚════██║
-- ██║ ╚═╝ ██║██║██║ ╚████║██║╚██████╔╝██║  ██║██║ ╚═╝ ██║███████╗███████║
-- ╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═╝ ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝╚══════╝
CL.Minigame = function(type, cb)
    if type == 'normal' then
        if GetResourceState('lockpick') ~= 'started' then
            return warn('The ^1lockpick ^7 resource is not running!')
        end
        
        local result = exports['lockpick']:startLockpick()

        cb(result)
    elseif type == 'advanced' then
        if GetResourceState('t3_lockpick') ~= 'started' then
            return warn('The ^1t3_lockpick ^7 resource is not running!')
        end
        
        local result = exports["t3_lockpick"]:startLockpick('lockpick', 1, 5)
        cb(result)
    elseif type == 'safe' then
        if GetResourceState('pd-safe') ~= 'started' then
            return warn('The ^1pd-safe ^7 resource is not running!')
        end
        
        local result = exports["pd-safe"]:createSafe({math.random(0,99), math.random(0,99), math.random(0,99)})
        cb(result)
    elseif type == 'electricity' then
        TriggerEvent("datacrack:start", 5, function(result)
            cb(result)
        end)
    end
end


-- ████████╗ █████╗ ██████╗  ██████╗ ███████╗████████╗
-- ╚══██╔══╝██╔══██╗██╔══██╗██╔════╝ ██╔════╝╚══██╔══╝
--    ██║   ███████║██████╔╝██║  ███╗█████╗     ██║   
--    ██║   ██╔══██║██╔══██╗██║   ██║██╔══╝     ██║   
--    ██║   ██║  ██║██║  ██║╚██████╔╝███████╗   ██║   
--    ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝   
CL.Target = function(type, data, cb)
    if type == 'zone' then
        if Config.TargetResource == 'ox_target' then
            return exports['ox_target']:addBoxZone({
                coords = vec(data.coords.x, data.coords.y, data.coords.z),
                size = data.size and data.size.xyz or vec(1.2, 1.2, 2.0),
                debug = false,
                useZ = true,
                rotation = data.heading or 0.0,
                options = {
                    {
                        name = data.uniqueName,
                        icon = data.icon,
                        label = data.label,
                        onSelect = function()
                            cb()
                        end,
                        distance = 1.5,
                    }
                }
            })
        elseif Config.TargetResource == 'qb-target' then
            local uniqueName = 'vms_houserobberies-'..math.random(1000000, 9999999999)
            exports['qb-target']:AddBoxZone(uniqueName, vec(data.coords.x, data.coords.y, data.coords.z), data.size and data.size.x or 1.2, data.size and data.size.y or 1.2, {
                name = uniqueName,
                heading = data.heading and data.heading - 90.0 or 0.0,
                debugPoly = false,
                minZ = data.coords.z - (data.size and data.size.y or 1.2),
                maxZ = data.coords.z + (data.size and data.size.y or 1.2),
            }, {
                options = {
                    {
                        num = 1,
                        icon = data.icon,
                        label = data.label,
                        action = function()
                            cb()
                        end,
                    }
                },
                distance = 1.2,
            })
            return uniqueName
        else
            warn('You need to prepare CL.Target for the target system')
        end
    elseif type == 'remove-zone' then
        if Config.TargetResource == 'ox_target' then
            exports['ox_target']:removeZone(data)
        elseif Config.TargetResource == 'qb-target' then
            exports['qb-target']:RemoveZone(data)
        else
            warn('You need to prepare CL.Target for the target system')
        end
    elseif type == 'entity' then
        if Config.TargetResource == 'ox_target' then
            return exports['ox_target']:addLocalEntity(data.entity, {
                {
                    name = 'vms_houserobberies-'..data.uniqueName,
                    icon = 'fa-solid fa-hand',
                    label = data.label,
                    distance = 1.6,
                    onSelect = function()
                        cb()
                    end,
                }
            })
        elseif Config.TargetResource == 'qb-target' then
            return exports['qb-target']:AddTargetEntity(data.entity, {
                options = {
                    { 
                        num = 1,
                        icon = 'fa-solid fa-hand',
                        label = data.label,
                        distance = 1.6,
                        action = function(entity)
                            cb()
                        end,
                    }
                },
            })
        else
            warn('You need to prepare CL.Target for the target system')
        end
    elseif type == 'remove-entity' then
        if Config.TargetResource == 'ox_target' then
            exports['ox_target']:removeLocalEntity(data.entity, 'vms_houserobberies-'..data.entity)
        elseif Config.TargetResource == 'qb-target' then
            exports['qb-target']:RemoveTargetEntity(data.entity, data.label)
        else
            warn('You need to prepare CL.Target for the target system')
        end
    end
end

CL.Weather = function(isResume)
    if isResume then
        if GetResourceState('cd_easytime') ~= 'missing' then
            TriggerEvent('cd_easytime:PauseSync', false)
        elseif GetResourceState('qb-weathersync') ~= 'missing' then
            TriggerEvent('qb-weathersync:client:EnableSync')
        elseif GetResourceState('vSync') ~= 'missing' then
            TriggerEvent('vSync:toggle', true)
        end
    else
        if GetResourceState('cd_easytime') ~= 'missing' then
            TriggerEvent('cd_easytime:PauseSync', true)
        elseif GetResourceState('qb-weathersync') ~= 'missing' then
            TriggerEvent('qb-weathersync:client:DisableSync')
        elseif GetResourceState('vSync') ~= 'missing' then
            TriggerEvent('vSync:toggle', false)
        end
        Citizen.Wait(100)
        NetworkOverrideClockTime(1, 0, 0)
        ClearOverrideWeather()
        ClearWeatherTypePersist()
        SetWeatherTypePersist('OVERCAST')
        SetWeatherTypeNow('OVERCAST')
        SetWeatherTypeNowPersist('OVERCAST')
    end
end

CL.AddStress = function(type)
    if type == 'noise' then
        if GetResourceState('vms_hud') ~= 'missing' then
            local value = Config.Core == "ESX" and math.random(1000, 6000) or math.random(1, 5)
            TriggerServerEvent('vms_hud:addStress', value)
        end
    elseif type == 'alarm' then
        if GetResourceState('vms_hud') ~= 'missing' then
            local value = Config.Core == "ESX" and math.random(3000, 6000) or math.random(6, 12)
            TriggerServerEvent('vms_hud:addStress', value)
        end
    end
end

CL.Dispatch = function(type, data)
    local blipSprite = type == "failed_sale" and 480 or type == "failed_lockpick" and 730 or type == "thief_spotted" and 472
    local time = type == "failed_sale" and (30 * 1000) or type == "failed_lockpick" and (50 * 1000) or type == "thief_spotted" and (60 * 1000)
    
    if GetResourceState('qs-dispatch') ~= 'missing' then
        TriggerServerEvent('qs-dispatch:server:CreateDispatchCall', {
            job = {'police', 'sheriff'},
            callLocation = data.coords.xyz,
            callCode = {code = '??-??', snippet = '<CALL SNIPPED EX: 10-10>'},
            message = data.message,
            flashes = false, -- you can set to true if you need call flashing sirens...
            blip = {
                sprite = blipSprite, -- blip sprite
                scale = 1.3, -- blip scale
                colour = 1, -- blio colour
                flashes = true, -- blip flashes
                text = data.blipName, -- blip text
                time = time, --blip fadeout time (1 * 60000) = 1 minute
            },
            otherData = {
                {
                    text = 'Red Obscure', -- text of the other data item (can add more than one)
                    icon = 'fas fa-user-secret', -- icon font awesome https://fontawesome.com/icons/
                }
            }
        })
    elseif GetResourceState('core_dispatch') ~= 'missing' then
        TriggerServerEvent("core_dispatch:addCall",
            "00-00",
            "House Robbery",
            {{icon = "fa-venus-mars", info = "male"}},
            {data.coords.x, data.coords.y, data.coords.z},
            "police",
            5000,
            blipSprite,
            1
        )
    else
        TriggerServerEvent("vms_houserobberies:sv:policeNotify", {
            job = {'police', 'sheriff'},
            message = data.message,
            coords = data.coords.xyz,
            blip = {
                sprite = blipSprite,
                scale = 1.3,
                color = 1,
                text = data.blipName,
                time = time,
                radius = true,
            },
        })
    end
end

CL.IsPedCrouching = function(ped)
    return GetPedStealthMovement(ped)
end

CL.GetPlayerJob = function(type)
    if Config.Core == "ESX" then
        if type == "table" and PlayerData.job then
            return PlayerData.job
        end
        if type == "name" and PlayerData.job.name then
            return PlayerData.job.name
        end
        if type == "grade_name" and PlayerData.job.grade_name then
            return PlayerData.job.grade_name
        end
    elseif Config.Core == "QB-Core" then
        if type == "table" and PlayerData.job then
            return PlayerData.job
        end
        if type == "name" and PlayerData.job.name then
            return PlayerData.job.name
        end
        if type == "grade_name" and PlayerData.job.grade.name then
            return PlayerData.job.grade.name
        end
    end
    return nil
end

CL.IsPlayerOnDuty = function()
    if Config.Core == "ESX" then
        return true
    elseif Config.Core == "QB-Core" then
        return PlayerData.job.onduty
    end
end

CL.GetClosestPlayers = function()
    if Config.Core == "ESX" then
        local playerInArea = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 5.0)
        return playerInArea
    elseif Config.Core == "QB-Core" then
        local playerInArea = QBCore.Functions.GetPlayersFromCoords(GetEntityCoords(PlayerPedId()), 5.0)
        return playerInArea
    end
end