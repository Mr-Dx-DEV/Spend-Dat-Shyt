---@diagnostic disable: undefined-field
-----------------------------------x--Groot Development--x-----------------------------------------------
-- Notifications
local Notification = Config.SystemSettings.Notify
Notify = function(message, type, duration)
    if not type then
        type = "success"
    end
    if not duration then
        duration = 5000
    end

    if Notification == "esx" then
        ESX.ShowNotification(message)
    elseif Notification == "okok" then
        exports.okokNotify:Alert(type, message, duration, type, false)
    elseif Notification == "qbcore" then
        if type == "info" then
            type = "primary"
        end
        QBCore.Functions.Notify(message, type, duration)
    elseif Notification == "ox_lib" then
        exports["ox_lib"]:notify({
            title = "Notification",
            description = message,
            type = type,
            duration = duration,
            position = "top-right"
        })
    elseif Notification == "17mov" then
        exports["17mov_Hud"]:ShowNotification(message, type, "Notification", duration)
    elseif Notification == "standalone" then
        AddTextEntry("g_bridge", message)
        BeginTextCommandThefeedPost("g_bridge")
        EndTextCommandThefeedPostTicker(false, true)
    elseif Notification == "rtx_notify" or Notification == "rtx" then
        -- RTX Notify support
        -- Tries the most common RTX exports first, then falls back to events if your version uses them.
        local title = "Notification"
        local sent = false

        if GetResourceState("rtx_notify") == "started" then
            sent = pcall(function()
                exports["rtx_notify"]:Notify(title, message, duration, type)
            end)

            if not sent then
                sent = pcall(function()
                    exports["rtx_notify"]:Alert(title, message, duration, type)
                end)
            end

            if not sent then
                sent = pcall(function()
                    exports["rtx_notify"]:Notify({
                        title = title,
                        description = message,
                        text = message,
                        type = type,
                        duration = duration,
                        position = "top-right"
                    })
                end)
            end
        end

        if not sent then
            TriggerEvent("rtx_notify:Notify", message, type, duration)
        end
    elseif Notification == "g-notifications" then
        exports["g-notifications"]:Notify({
            title = "Notification",
            description = message,
            type = type,
            duration = duration,
            position = "top-right"
        })
    else
        print("Notification type not found")
    end
end

-- TextUI
local TextUi = Config.TextUI
function TextUiShow(message)
    if not message then
        return
    end
    if TextUi == "okok" then
        exports.okokTextUI:Open(message, "darkblue", "right")
    elseif TextUi == "ox_lib" then
        exports["ox_lib"]:showTextUI(message)
    elseif TextUi == "esx" then
        ---@diagnostic disable-next-line: missing-parameter
        ESX.ShowHelpNotification(message)
    elseif TextUi == "qbcore" then
        exports["qb-core"]:DrawText(message, "right")
    end
end

function TextUiNewHide()
    if TextUi == "okok" then
        exports.okokTextUI:Close()
    elseif TextUi == "qbcore" then
        exports["qb-core"]:HideText()
    elseif TextUi == "ox_lib" then
        exports["ox_lib"]:hideTextUI()
    end
end

RegisterNetEvent("justgroot:g-multijob:notify", function(message, type, duration)
    Notify(message, type, duration)
end)

local openType = Config.MultiJob.OpenType

if openType == "location" then

    local coordsList = Config.MultiJob.Location.coords
    local pedConfig = Config.MultiJob.Location.ped

    if pedConfig and pedConfig.enable then
        CreateThread(function()
            local pedModel = pedConfig.model
            local scenario = pedConfig.scenario

            local pedModelHash = RRequestModel(pedModel, 20000)
            if not pedModelHash then
                if Config.SystemSettings.Debug then
                    print(("^1[g-multijob]^7 Failed to load ped model '%s'"):format(tostring(pedModel)))
                end
                return
            end

            for i, coords in pairs(coordsList) do
                local ped = CreatePed(4, pedModelHash, coords.x, coords.y, coords.z - 1.0, coords.w, false, true)
                SetEntityAsMissionEntity(ped, true, true)
                SetPedFleeAttributes(ped, 0, false)
                SetPedCombatAttributes(ped, 46, true)
                SetBlockingOfNonTemporaryEvents(ped, true)
                FreezeEntityPosition(ped, true)
                SetEntityInvincible(ped, true)

                if scenario then
                    TaskStartScenarioInPlace(ped, scenario, 0, true)
                end
            end

            SetModelAsNoLongerNeeded(pedModelHash)

        end)

    end
elseif openType == 'custom' then
    --  custom
    -- OpenMultiJobMenu()
end

-- Do not touch if you don't know what you're doing.
CreateThread(function()
    if openType ~= "location" then
        return
    end
    print("OpenType: " .. tostring(openType))
    local locationCoords = Config.MultiJob.Location.coords

    if locationCoords then
        for i, coords in pairs(locationCoords) do
            if Config.SystemSettings.OpenMenuVia == "target" then
                Target.AddTargetBoxZone("multijob_" .. tostring(i), vector3(coords.x, coords.y, coords.z - 0.5), 1.0,
                    coords.w, {{
                        name = "multijob_" .. tostring(i),
                        icon = Config.Icons.multijobTargetIcon,
                        label = LAN("open_multijob"),
                        onSelect = function()
                            OpenMultiJobMenu()
                        end
                    }}, Config.SystemSettings.Debug)
            elseif Config.SystemSettings.OpenMenuVia == "textui" then
                SetupInteractionZone({coords.x, coords.y, coords.z}, LAN("open_multijob"),
                    "justgroot:g-multijob:open:menu:multijob", _, i)
            end
        end
    end
end)
