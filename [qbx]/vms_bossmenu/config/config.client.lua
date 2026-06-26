CL = {}

CL.DrawText3D = function(coords, text, textScale) -- This is the function used when using Config.UseText3D
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


-- ███╗   ██╗ ██████╗ ████████╗██╗███████╗██╗ ██████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗███████╗
-- ████╗  ██║██╔═══██╗╚══██╔══╝██║██╔════╝██║██╔════╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
-- ██╔██╗ ██║██║   ██║   ██║   ██║█████╗  ██║██║     ███████║   ██║   ██║██║   ██║██╔██╗ ██║███████╗
-- ██║╚██╗██║██║   ██║   ██║   ██║██╔══╝  ██║██║     ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║╚════██║
-- ██║ ╚████║╚██████╔╝   ██║   ██║██║     ██║╚██████╗██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║███████║
-- ╚═╝  ╚═══╝ ╚═════╝    ╚═╝   ╚═╝╚═╝     ╚═╝ ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝
CL.Notification = function(message, time, type)
    if type == "success" then
        if GetResourceState("vms_notify") == 'started' then
            exports['vms_notify']:Notification("BOSS MENU", message, time, "#36f230", "fa-solid fa-square-parking")
        else
            TriggerEvent('esx:showNotification', message)
            TriggerEvent('QBCore:Notify', message, 'success', time)
        end
    elseif type == "error" then
        if GetResourceState("vms_notify") == 'started' then
            exports['vms_notify']:Notification("BOSS MENU", message, time, "#f23030", "fa-solid fa-square-parking")
        else
            TriggerEvent('esx:showNotification', message)
            TriggerEvent('QBCore:Notify', message, 'error', time)
        end
    elseif type == "info" then
        if GetResourceState("vms_notify") == 'started' then
            exports['vms_notify']:Notification("BOSS MENU", message, time, "#4287f5", "fa-solid fa-square-parking")
        else
            TriggerEvent('esx:showNotification', message)
            TriggerEvent('QBCore:Notify', message, 'primary', time)
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
            -- exports['vms_hud']:Display(true)
        end
    end,
    Disable = function()
        if GetResourceState('vms_hud') ~= 'missing' then
            -- exports['vms_hud']:Display(false)
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
        exports["interact"]:Open("E", message) -- Here you can use your TextUI or use my free one - https://github.com/vames-dev/interact
    end,
    Close = function()
        exports["interact"]:Close() -- Here you can use your TextUI or use my free one - https://github.com/vames-dev/interact
    end
}


-- ████████╗ █████╗ ██████╗  ██████╗ ███████╗████████╗
-- ╚══██╔══╝██╔══██╗██╔══██╗██╔════╝ ██╔════╝╚══██╔══╝
--    ██║   ███████║██████╔╝██║  ███╗█████╗     ██║   
--    ██║   ██╔══██║██╔══██╗██║   ██║██╔══╝     ██║   
--    ██║   ██║  ██║██║  ██║╚██████╔╝███████╗   ██║   
--    ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝   
CL.Target = function(type, data)
    if type == 'zone' then
        if Config.TargetResource == 'ox_target' then
            return exports['ox_target']:addBoxZone({
                coords = vec(data.coords.x, data.coords.y, data.coords.z-0.5),
                size = data.size and data.size.xyz or vec(1.2, 1.2, 1.8),
                debug = false,
                useZ = true,
                rotation = data.rotation or 0.0,
                options = {
                    {
                        name = data.option.name,
                        icon = data.option.icon,
                        label = data.option.label,
                        onSelect = data.option.action,
                        distance = 1.2,
                        -- groups = data.option.jobs,
                        canInteract = data.option.canInteract
                    }
                }
            })
        elseif Config.TargetResource == 'qb-target' then
            local uniqueName = 'vms_bossmenu-'..math.random(1000000, 9999999999)
            local options = {}

            exports['qb-target']:AddBoxZone(uniqueName, vec(data.coords.x, data.coords.y, data.coords.z), data.size and data.size.x or 1.2, data.size and data.size.y or 1.2, {
                name = uniqueName,
                heading = data.rotation and data.rotation - 90.0 or 0.0,
                debugPoly = false,
                minZ = data.coords.z - (data.size and data.size.y or 1.2),
                maxZ = data.coords.z + (data.size and data.size.y or 1.2),
            }, {
                options = {
                    {
                        num = 1,
                        icon = data.option.icon,
                        label = data.option.label,
                        action = data.option.action,
                        -- job = data.option.jobs,
                        canInteract = data.option.canInteract
                    }
                },
                distance = 1.2,
            })
            return uniqueName
        else
            warn('You need to prepare CL.Target for the target system')
        end
    end
end


-- ███████╗████████╗ █████╗ ███████╗██╗  ██╗
-- ██╔════╝╚══██╔══╝██╔══██╗██╔════╝██║  ██║
-- ███████╗   ██║   ███████║███████╗███████║
-- ╚════██║   ██║   ██╔══██║╚════██║██╔══██║
-- ███████║   ██║   ██║  ██║███████║██║  ██║
-- ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
CL.OpenStash = function(jobName, stashSettings)
    if Config.Inventory == "ox_inventory" then
        exports.ox_inventory:openInventory('stash', {id = stashSettings.id})

    end
end


-- ███████╗██████╗  █████╗ ███╗   ███╗███████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗
-- ██╔════╝██╔══██╗██╔══██╗████╗ ████║██╔════╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝
-- █████╗  ██████╔╝███████║██╔████╔██║█████╗  ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ 
-- ██╔══╝  ██╔══██╗██╔══██║██║╚██╔╝██║██╔══╝  ██║███╗██║██║   ██║██╔══██╗██╔═██╗ 
-- ██║     ██║  ██║██║  ██║██║ ╚═╝ ██║███████╗╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗
-- ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝ ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝
CL.GetPlayerData = function(type)
    if Config.Core == "ESX" then
        return ESX.GetPlayerData()
    elseif Config.Core == "QB-Core" then
        return QBCore.Functions.GetPlayerData()
    end
end

CL.GetPlayerJob = function(type)
    if PlayerData.job then
        if type == "name" then
            return PlayerData.job.name
        end
        if type == "label" then
            return PlayerData.job.label
        end
        if type == "grade" then
            return Config.Core == "ESX" and PlayerData.job.grade or Config.Core == "QB-Core" and PlayerData.job.grade.level
        end
    end

    return nil
end

CL.GetPlayerGang = function(type)
    if Config.Core == "ESX" then
        if PlayerData.job2 then
            if type == "name" then
                return PlayerData.job2.name
            end
            if type == "label" then
                return PlayerData.job2.label
            end
            if type == "grade" then
                return PlayerData.job2.grade
            end
        end
        
    elseif Config.Core == "QB-Core" then
        if PlayerData.gang then
            if type == "name" then
                return PlayerData.gang.name
            end
            if type == "label" then
                return PlayerData.gang.label
            end
            if type == "grade" then
                return PlayerData.gang.grade.level
            end
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