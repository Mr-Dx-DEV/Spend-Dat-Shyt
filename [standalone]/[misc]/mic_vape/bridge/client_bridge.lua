-- bridge/client_bridge.lua
-- This file contains open-source logic that can be modified by the server owner.

-- Framework detection
local Framework = nil
if GetResourceState('es_extended') == 'started' then
    Framework = exports["es_extended"]:getSharedObject()
elseif GetResourceState('qb-core') == 'started' then
    Framework = exports['qb-core']:GetCoreObject()
end

-- Custom notification function
function ShowNotification(message)
    if Config.ShowNotifications then
        if GetResourceState('es_extended') == 'started' then
            Framework.ShowNotification(message)
        elseif GetResourceState('qb-core') == 'started' then
            Framework.Functions.Notify(message, 'success', 5000)
        else
            -- Fallback to default GTA notification
            BeginTextCommandThefeedPost('STRING')
            AddTextComponentSubstringPlayerName(message)
            EndTextCommandThefeedPostTicker(true, false)
        end
    end
end

-- Progress Bar Functions
function ShowProgressBar(duration, label)
    SendNUIMessage({
        action = "showProgress",
        duration = duration * 1000, -- Convertir a milisegundos
        label = label
    })
end

function HideProgressBar()
    SendNUIMessage({
        action = "hideProgress"
    })
end

-- Registrar evento para mostrar la barra
RegisterNetEvent('esx_vape:showProgress')
AddEventHandler('esx_vape:showProgress', function(duration, label)
    ShowProgressBar(duration, label)
end)

-- Registrar evento para ocultar la barra
RegisterNetEvent('esx_vape:hideProgress')
AddEventHandler('esx_vape:hideProgress', function()
    HideProgressBar()
end)

-- Effects Logic
local activeEffects = {}
local originalModel = nil
local effectsLoopRunning = false

-- Función para obtener un efecto aleatorio
function getRandomEffect()
    local effects = {}
    for vapeName, _ in pairs(Config.Vapes) do
        if vapeName ~= "random_vape" and vapeName ~= "vape" then
            table.insert(effects, vapeName)
        end
    end
    return effects[math.random(#effects)]
end

local function ClearEffect(effectName, playerPed, playerId)
    if effectName == "invisibility_vape" then
        SetEntityVisible(playerPed, true, false)
    elseif effectName == "speed_vape" then
        SetRunSprintMultiplierForPlayer(playerId, 1.0)
        if Config.SpeedVapeInfiniteStamina then
            ResetPlayerStamina(playerId)
        end
    elseif effectName == "superjump_vape" then
        SetSuperJumpThisFrame(playerId, false)
    elseif effectName == "invincibility_vape" then
        SetPlayerInvincible(playerId, false)
    elseif effectName == "transform_vape" then
        if originalModel then
            RequestModel(originalModel)
            while not HasModelLoaded(originalModel) do Citizen.Wait(100) end
            SetPlayerModel(playerId, originalModel)
            SetModelAsNoLongerNeeded(originalModel)
            TriggerEvent('esfer_rskin:rskin')
        end
    elseif effectName == "gravity_vape" then
        SetPedGravity(playerPed, true)
        ResetPedMovementClipset(playerPed, 0.0)
        ResetPedStrafeClipset(playerPed)
        SetPedMoveRateOverride(playerPed, 1.0)
    elseif effectName == "freeze_vape" then
        FreezeEntityPosition(playerPed, false)
    elseif effectName == "carspeed_vape" then
        if IsPedInAnyVehicle(playerPed, false) then
            local vehicle = GetVehiclePedIsIn(playerPed, false)
            SetVehicleEnginePowerMultiplier(vehicle, 1.0)
        end
    end
end

-- Evento para aplicar efectos
RegisterNetEvent('esx_vape:applyEffect')
AddEventHandler('esx_vape:applyEffect', function(vapeName)
    local playerPed = PlayerPedId()
    local playerId = PlayerId()

    -- Guardar modelo original si no está guardado
    if not originalModel then
        originalModel = GetEntityModel(playerPed)
    end

    -- Limpiar efectos anteriores
    for effect, _ in pairs(activeEffects) do
        ClearEffect(effect, playerPed, playerId)
    end
    activeEffects = {}
    TriggerEvent('esx_vape:hideProgress')

    -- Si es el vape normal, no aplicar efecto
    if vapeName == "vape" then
        return
    end

    -- Aplicar nuevo efecto
    if vapeName == "random_vape" then
        vapeName = getRandomEffect()
    end

    local vapeConfig = Config.Vapes[vapeName]
    local effectsToApply = {}
    
    if vapeConfig.power then
        for k, v in pairs(vapeConfig.power) do
            effectsToApply[k] = v
        end
    else
        -- Para vapes normales, usamos el vapeName como efecto y su EffectDuration
        effectsToApply[vapeName] = vapeConfig.EffectDuration
    end

    local maxDuration = vapeConfig.EffectDuration or 0
    if maxDuration == 0 then
        for k, v in pairs(effectsToApply) do
            if type(v) == "number" and v > maxDuration and k ~= "health" and k ~= "armor" and k ~= "health_vape" and k ~= "armor_vape" then
                maxDuration = v
            end
        end
    end

    if vapeConfig.ShowProgress and maxDuration > 0 then
        TriggerEvent('esx_vape:showProgress', maxDuration, vapeConfig.Label)
    end

    for effectName, effectValue in pairs(effectsToApply) do
        local duration = type(effectValue) == "number" and effectValue or vapeConfig.EffectDuration or 0
        local amount = type(effectValue) == "number" and effectValue or 0
        
        activeEffects[effectName] = true

        if effectName == "invisibility_vape" then
            SetEntityVisible(playerPed, false, false)
            ShowNotification(_('invisible'), 'error')
        elseif effectName == "speed_vape" then
            local speedMult = vapeConfig.SpeedMultiplier or 1.49
            SetRunSprintMultiplierForPlayer(playerId, speedMult)
            ShowNotification(_('speed'), 'error')
        elseif effectName == "superjump_vape" then
            ShowNotification(_('superjump'), 'error')
        elseif effectName == "teleport_vape" then
            ShowNotification(_('tp_activated'), 'error')
            Citizen.CreateThread(function()
                Citizen.Wait(duration * 1000)
                if activeEffects["teleport_vape"] then
                    local waypoint = GetFirstBlipInfoId(8) -- Waypoint blip
                    if DoesBlipExist(waypoint) then
                        local coords = GetBlipInfoIdCoord(waypoint)
                        local x, y, z = coords.x, coords.y, coords.z
                        local groundZ
                        for i = 0, 1000, 10 do
                            SetEntityCoordsNoOffset(playerPed, x, y, i, false, false, false)
                            Citizen.Wait(0)
                            local foundGround, zPos = GetGroundZFor_3dCoord(x, y, i, false)
                            if foundGround then
                                groundZ = zPos
                                break
                            end
                        end
                        if groundZ then
                            SetEntityCoords(playerPed, x, y, groundZ, false, false, false, true)
                        else
                            SetEntityCoords(playerPed, x, y, z, false, false, false, true)
                        end
                        ShowNotification(_('tp_done'), 'error')
                    else
                        ShowNotification(_('no_waypoint'), 'error')
                    end
                    TriggerEvent('esx_vape:hideProgress')
                    activeEffects["teleport_vape"] = nil
                end
            end)
        elseif effectName == "invincibility_vape" then
            SetPlayerInvincible(playerId, true)
            ShowNotification(_('invincibility'), 'error')
        elseif effectName == "transform_vape" then
            local model = Config.TransformAnimals[math.random(#Config.TransformAnimals)]
            RequestModel(GetHashKey(model))
            while not HasModelLoaded(GetHashKey(model)) do Citizen.Wait(100) end
            SetPlayerModel(playerId, GetHashKey(model))
            SetModelAsNoLongerNeeded(GetHashKey(model))
            ShowNotification('Transformed into a ' .. model .. '!')
        elseif effectName == "freeze_vape" then
            FreezeEntityPosition(playerPed, true)
            ShowNotification('You are frozen!')
        elseif effectName == "gravity_vape" then
            SetPedGravity(playerPed, false)
            SetPedMoveRateOverride(playerPed, 0.5)
            ShowNotification('Low gravity activated!')
        elseif effectName == "health_vape" or effectName == "health" then
            local currentHealth = GetEntityHealth(playerPed)
            local healthAmount = amount > 0 and amount or Config.Health
            if Config.StaticHealth then
                local targetHealth = math.max(100, math.min(200, healthAmount))
                if currentHealth < targetHealth then
                    SetEntityHealth(playerPed, targetHealth)
                    ShowNotification(_('health'), 'error')
                end
            else
                local newHealth = math.max(100, math.min(200, currentHealth + healthAmount))
                SetEntityHealth(playerPed, newHealth)
                ShowNotification(_('health'), 'error')
            end
            activeEffects[effectName] = nil -- one-off
        elseif effectName == "armor_vape" or effectName == "armor" then
            local currentArmor = GetPedArmour(playerPed)
            local armorAmount = amount > 0 and amount or Config.Armor
            if Config.StaticArmor then
                local targetArmor = math.min(100, armorAmount)
                if currentArmor < targetArmor then
                    SetPedArmour(playerPed, targetArmor)
                    ShowNotification(_('armor'), 'error')
                end
            else
                local newArmor = math.min(100, currentArmor + armorAmount)
                SetPedArmour(playerPed, newArmor)
                ShowNotification(_('armor'), 'error')
            end
            activeEffects[effectName] = nil -- one-off
        elseif effectName == "carspeed_vape" then
            if IsPedInAnyVehicle(playerPed, false) then
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                local speedMult = vapeConfig.SpeedMultiplier or 2.0
                SetVehicleEnginePowerMultiplier(vehicle, speedMult * 100.0)
                ShowNotification(_('car_speed'), 'error')
            else
                ShowNotification(_('no_car'), 'error')
                activeEffects[effectName] = nil
            end
        end

        -- Temporizador para efectos con duración (excluye uno de uso instantáneo y teleport que tiene su propio thread)
        if activeEffects[effectName] and effectName ~= "teleport_vape" then
            Citizen.CreateThread(function()
                Citizen.Wait(duration * 1000)
                if activeEffects[effectName] then
                    ClearEffect(effectName, playerPed, playerId)
                    activeEffects[effectName] = nil
                    
                    -- Check if any effects are left to show worn off notification
                    local hasEffects = false
                    for _, _ in pairs(activeEffects) do hasEffects = true break end
                    if not hasEffects then
                        TriggerEvent('esx_vape:hideProgress')
                        ShowNotification(_('effect_worn'), 'error')
                    end
                end
            end)
        end
    end

    -- Single consolidated effects loop
    if not effectsLoopRunning then
        local function checkActive()
            for _, _ in pairs(activeEffects) do return true end
            return false
        end

        if checkActive() then
            effectsLoopRunning = true
            Citizen.CreateThread(function()
                while checkActive() do
                    local playerPed = PlayerPedId()
                    local playerId = PlayerId()
                    local sleep = 100

                    if activeEffects["speed_vape"] then
                        if Config.SpeedVapeInfiniteStamina then
                            RestorePlayerStamina(playerId, 1.0)
                            sleep = 0
                        end
                    end
                    if activeEffects["superjump_vape"] then
                        SetSuperJumpThisFrame(playerId, true)
                        sleep = 0
                    end
                    if activeEffects["gravity_vape"] then
                        ApplyForceToEntity(playerPed, 3, 0.0, 0.0, 0.1, 0.0, 0.0, 0.0, 0, false, true, true, false, true)
                        sleep = 0
                    end
                    if activeEffects["carspeed_vape"] then
                        if IsPedInAnyVehicle(playerPed, false) then
                            local vehicle = GetVehiclePedIsIn(playerPed, false)
                            local speedMult = vapeConfig.SpeedMultiplier or 2.0
                            SetVehicleEnginePowerMultiplier(vehicle, speedMult * 100.0)
                            sleep = 0
                        end
                    end

                    Citizen.Wait(sleep)
                end
                effectsLoopRunning = false
            end)
        end
    end
end)
