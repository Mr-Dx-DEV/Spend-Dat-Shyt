local DEFAULT_HUNGER = 100
local SAVE_KEY = 'grim_hungerfx:hunger'
local HUNGER_DECAY_INTERVAL_MS = 300000
local HUNGER_DECAY_AMOUNT = 1
local EXTERNAL_CONTROL_TIMEOUT_MS = 600000
local STATE_POLL_INTERVAL_MS = 5000

local hunger = DEFAULT_HUNGER
local effectLevel = 0
local externalControlledUntil = 0

local lastStarvingAlert = 0
local STARVING_ALERT_COOLDOWN_MS = 120000

local function notify(msg)
    BeginTextCommandThefeedPost('STRING')
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandThefeedPostTicker(false, false)
end

local function clampHunger(value)
    value = tonumber(value)
    if not value then return nil end

    if value > 100000 then
        value = value / 10000
    elseif value > 1000 then
        value = value / 100
    elseif value > 100 then
        value = value / 10
    elseif value >= 0 and value <= 1 then
        value = value * 100
    end

    return math.max(0, math.min(100, math.floor(value + 0.5)))
end

local function markExternalControl()
    externalControlledUntil = GetGameTimer() + EXTERNAL_CONTROL_TIMEOUT_MS
end

local function isExternallyControlled()
    return GetGameTimer() < externalControlledUntil
end

local function publishHunger()
    if LocalPlayer and LocalPlayer.state then
        LocalPlayer.state:set('grim_hunger', hunger, true)
    end

    TriggerEvent('grim_hungerfx:client:hungerChanged', hunger, isExternallyControlled())
end

local function persistHunger()
    SetResourceKvp(SAVE_KEY, tostring(hunger))
    publishHunger()
end

local function setHunger(value, fromExternal)
    local clamped = clampHunger(value)
    if clamped == nil then return false end

    if fromExternal then
        markExternalControl()
    end

    if clamped == hunger then
        publishHunger()
        return true
    end

    hunger = clamped
    persistHunger()
    return true
end

local function addHunger(value)
    value = tonumber(value)
    if not value then return false end
    return setHunger(hunger + value)
end

local function removeHunger(value)
    value = tonumber(value)
    if not value then return false end
    return setHunger(hunger - value)
end

local function extractStatusHunger(statuses)
    if type(statuses) ~= 'table' then return nil end

    for _, status in pairs(statuses) do
        if type(status) == 'table' and status.name == 'hunger' then
            return status.percent or status.val or status.value or status.status
        end
    end

    return nil
end

local function extractPlayerDataHunger(playerData)
    if type(playerData) ~= 'table' then return nil end

    local metadata = playerData.metadata
    if type(metadata) == 'table' then
        if metadata.hunger ~= nil then
            return metadata.hunger
        end

        if metadata.food ~= nil then
            return metadata.food
        end
    end

    if playerData.hunger ~= nil then
        return playerData.hunger
    end

    if playerData.food ~= nil then
        return playerData.food
    end

    return nil
end

local function applyExternalHunger(value)
    return setHunger(value, true)
end

local function syncFromStateBag()
    local playerState = LocalPlayer and LocalPlayer.state
    if not playerState then return false end

    if playerState.hunger ~= nil then
        return applyExternalHunger(playerState.hunger)
    end

    if playerState.food ~= nil then
        return applyExternalHunger(playerState.food)
    end

    return false
end

local function loadSavedHunger()
    local saved = GetResourceKvpString(SAVE_KEY)
    local clamped = clampHunger(saved)

    if clamped == nil then
        hunger = DEFAULT_HUNGER
        persistHunger()
        return
    end

    hunger = clamped
    publishHunger()
end

local function clearEffects(ped)
    ClearTimecycleModifier()
    StopGameplayCamShaking(true)
    SetPedMotionBlur(ped, false)
    ResetPedMovementClipset(ped, 1.0)
end

exports('SetHunger', function(value)
    setHunger(value)
end)

exports('AddHunger', function(value)
    addHunger(value)
end)

exports('RemoveHunger', function(value)
    removeHunger(value)
end)

exports('GetHunger', function()
    return hunger
end)

RegisterNetEvent('grim_hungerfx:client:setHunger', function(value)
    setHunger(value)
end)

RegisterNetEvent('grim_hungerfx:client:addHunger', function(value)
    addHunger(value)
end)

RegisterNetEvent('grim_hungerfx:client:removeHunger', function(value)
    removeHunger(value)
end)

RegisterNetEvent('grim_hungerfx:client:syncHunger', function(value)
    applyExternalHunger(value)
end)

RegisterNetEvent('hud:client:UpdateNeeds', function(newHunger)
    applyExternalHunger(newHunger)
end)

RegisterNetEvent('QBCore:Player:SetPlayerData', function(playerData)
    applyExternalHunger(extractPlayerDataHunger(playerData))
end)

RegisterNetEvent('QBXCore:Player:SetPlayerData', function(playerData)
    applyExternalHunger(extractPlayerDataHunger(playerData))
end)

RegisterNetEvent('esx_status:onTick', function(statuses)
    applyExternalHunger(extractStatusHunger(statuses))
end)

RegisterNetEvent('esx_status:onUpdate', function(statuses)
    applyExternalHunger(extractStatusHunger(statuses))
end)

RegisterCommand('sethunger', function(_, args)
    if setHunger(args[1]) then
        notify('Hunger set to ' .. hunger)
    else
        notify('Usage: /sethunger [0-100]')
    end
end)

RegisterCommand('addhunger', function(_, args)
    if addHunger(args[1]) then
        notify('Hunger increased to ' .. hunger)
    else
        notify('Usage: /addhunger [amount]')
    end
end)

RegisterCommand('removehunger', function(_, args)
    if removeHunger(args[1]) then
        notify('Hunger reduced to ' .. hunger)
    else
        notify('Usage: /removehunger [amount]')
    end
end)

RegisterCommand('gethunger', function()
    local mode = isExternallyControlled() and 'external' or 'standalone'
    notify(('Hunger: %s (%s mode)'):format(hunger, mode))
end)

CreateThread(function()
    loadSavedHunger()
    Wait(1500)
    syncFromStateBag()
end)

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        Wait(500)
        loadSavedHunger()
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        local ped = PlayerPedId()
        if ped and ped ~= 0 then
            clearEffects(ped)
        end
    end
end)

CreateThread(function()
    while true do
        Wait(STATE_POLL_INTERVAL_MS)
        syncFromStateBag()
    end
end)

CreateThread(function()
    while true do
        Wait(HUNGER_DECAY_INTERVAL_MS)

        if not isExternallyControlled() then
            removeHunger(HUNGER_DECAY_AMOUNT)
        end
    end
end)

CreateThread(function()
    while true do
        Wait(math.random(45000, 90000))

        if hunger <= 25 then
            SendNUIMessage({ action = 'playRumble' })
            notify('MUTHAFUCKA U BETTER EAT')
        end

        if hunger <= 10 and GetGameTimer() > lastStarvingAlert then
            lastStarvingAlert = GetGameTimer() + STARVING_ALERT_COOLDOWN_MS
            notify('YOU STARVING! EAT SOMETHING NOW!')
        end
    end
end)

CreateThread(function()
    while true do
        Wait(3000)

        local ped = PlayerPedId()
        if not ped or ped == 0 then
            goto continue
        end

        if hunger <= 5 then
            effectLevel = 2
            ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.4)
            SetPedMotionBlur(ped, true)
            SetTimecycleModifier('BarryFadeOut')
            SetTimecycleModifierStrength(0.6)

            if math.random(1, 3) == 1 then
                SetPedToRagdoll(ped, 2000, 2000, 0, false, false, false)
            end

            ApplyDamageToPed(ped, 3, false)

        elseif hunger <= 15 then
            if effectLevel == 0 then
                notify('You feel dizzy...')
            end

            effectLevel = 1
            ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.2)
            SetPedMotionBlur(ped, true)
            SetTimecycleModifier('spectator5')
            SetTimecycleModifierStrength(0.35)

            if math.random(1, 4) == 1 then
                RequestAnimSet('move_m@drunk@slightlydrunk')
                while not HasAnimSetLoaded('move_m@drunk@slightlydrunk') do
                    Wait(0)
                end

                SetPedMovementClipset(ped, 'move_m@drunk@slightlydrunk', 1.0)
                Wait(4000)
                ResetPedMovementClipset(ped, 1.0)
            end

        else
            if effectLevel ~= 0 then
                clearEffects(ped)
                effectLevel = 0
            end
        end

        ::continue::
    end
end)
