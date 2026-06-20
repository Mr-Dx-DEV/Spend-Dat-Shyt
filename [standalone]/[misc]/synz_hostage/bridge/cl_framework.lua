local QBCore, ESX = nil, nil

CreateThread(function()
    if Config.Framework == 'QBCORE' then
        if Bridge.IsStarted('qbx_core') then
            QBCore = exports['qbx_core']
        else
            local ok, obj = pcall(function() return exports['qb-core']:GetCoreObject() end)
            if ok then QBCore = obj end
        end
        if Config.Debug then print('[synz_hostage] Client: QBCORE loaded') end

    elseif Config.Framework == 'ESX' then
        if exports['es_extended'] and exports['es_extended'].getSharedObject then
            ESX = exports['es_extended']:getSharedObject()
        else
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        end
        if Config.Debug then print('[synz_hostage] Client: ESX loaded') end
    end
end)

Bridge.Client = Bridge.Client or {}

-- Safe wrapper: try to call a lib function, return false on failure
local function safeLib(fn, ...)
    if not Bridge.hasOxLib then return false end
    local args = {...}
    local ok, result = pcall(function()
        return fn(table.unpack(args))
    end)
    if not ok then
        if Config.Debug then print('[synz_hostage] ^3ox_lib call failed: ' .. tostring(result) .. '^0') end
        return false
    end
    return true, result
end

-- =====================
-- NOTIFICATIONS
-- =====================
function Bridge.Client.Notify(msg, type)
    type = type or 'info'

    -- ox_lib (explicit or auto)
    if Config.Notifications == 'ox_lib' or Config.Notifications == 'auto' then
        if Bridge.hasOxLib then
            local ok = safeLib(lib.notify, { title = 'Hostage', description = msg, type = type, position = 'top' })
            if ok then return end
        end
    end

    -- okokNotify (explicit or auto)
    if Config.Notifications == 'okokNotify' or Config.Notifications == 'auto' then
        if Bridge.IsStarted('okokNotify') then
            local ok = pcall(function()
                exports['okokNotify']:Alert('Hostage', msg, 5000, type, false)
            end)
            if ok then return end
        end
    end

    -- Framework fallback
    if Config.Framework == 'QBCORE' and QBCore then
        if QBCore.Functions and QBCore.Functions.Notify then
            QBCore.Functions.Notify(msg, type, 5000)
            return
        end
    end

    if Config.Framework == 'ESX' and ESX then
        if ESX.ShowNotification then
            ESX.ShowNotification(msg)
            return
        end
    end

    -- Native GTA fallback (always works)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandThefeedPostTicker(false, false)
end

-- =====================
-- PROGRESS BAR
-- =====================
function Bridge.Client.Progress(duration, label, opts)
    opts = opts or {}

    -- ox_lib progress
    if Bridge.hasOxLib then
        local ok, result = safeLib(lib.progressBar, {
            duration = duration,
            label = label,
            useWhileDead = false,
            canCancel = opts.canCancel or false,
            disable = { move = opts.disableMove or false, car = true, combat = true },
            anim = opts.anim or nil,
        })
        if ok then return result end
    end

    -- QBCore progressbar
    if Config.Framework == 'QBCORE' and QBCore then
        local finished = false
        local result = true
        local pOk = pcall(function()
            exports['progressbar']:Progress({
                name = 'synz_hostage_progress',
                duration = duration,
                label = label,
                useWhileDead = false,
                canCancel = opts.canCancel or false,
                controlDisables = { disableMovement = opts.disableMove or false, disableCombat = true },
                animation = opts.anim or nil,
            }, function(cancelled)
                result = not cancelled
                finished = true
            end)
        end)
        if pOk then
            while not finished do Wait(50) end
            return result
        end
    end

    -- Simple wait fallback
    Wait(duration)
    return true
end

-- =====================
-- SKILLCHECK (optional)
-- =====================
function Bridge.Client.Skillcheck(difficulty)
    if not Config.Skillcheck or not Config.Skillcheck.Enabled then return true end
    if not Bridge.hasOxLib then return true end

    difficulty = difficulty or Config.Skillcheck.Difficulty or {'easy'}
    local inputs = Config.Skillcheck.Inputs or {'w', 'a', 's', 'd'}

    local ok, result = safeLib(lib.skillCheck, difficulty, inputs)
    if ok then return result end
    return true -- fallback: pass if lib fails
end

-- =====================
-- TEXTUI
-- =====================
function Bridge.Client.ShowTextUI(msg, opts)
    opts = opts or {}
    if Bridge.hasOxLib then
        local ok = safeLib(lib.showTextUI, msg, { position = opts.position or 'right-center', icon = opts.icon })
        if ok then return end
    end

    if Config.Framework == 'QBCORE' and QBCore then
        pcall(function() exports['qb-core']:DrawText(msg, 'right') end)
        return
    end
end

function Bridge.Client.HideTextUI()
    if Bridge.hasOxLib then
        local ok = safeLib(lib.hideTextUI)
        if ok then return end
    end
    if Config.Framework == 'QBCORE' and QBCore then
        pcall(function() exports['qb-core']:HideText() end)
        return
    end
end

-- =====================
-- TARGET DETECTION
-- =====================
function Bridge.Client.HasOxTarget()
    return Bridge.IsStarted('ox_target')
end

function Bridge.Client.HasQbTarget()
    return Bridge.IsStarted('qb-target')
end

-- =====================
-- POLICE COUNT (CACHED)
-- =====================
local lastPoliceCheckAt = 0
local lastPoliceCount = 0

function Bridge.Client.GetPoliceCount(cb)
    local now = GetGameTimer()
    if (now - lastPoliceCheckAt) < 2000 then
        cb(lastPoliceCount)
        return
    end

    if Config.Framework == 'QBCORE' and QBCore then
        if QBCore.Functions and QBCore.Functions.TriggerCallback then
            QBCore.Functions.TriggerCallback('synz_hostage:getPoliceCount', function(c)
                lastPoliceCheckAt = now
                lastPoliceCount = tonumber(c) or 0
                cb(lastPoliceCount)
            end)
        elseif Bridge.hasOxLib then
            local ok, result = pcall(function()
                return lib.callback.await('synz_hostage:getPoliceCount', false)
            end)
            if ok then
                lastPoliceCheckAt = now
                lastPoliceCount = tonumber(result) or 0
                cb(lastPoliceCount)
            else
                cb(0)
            end
        else
            cb(0)
        end
    elseif Config.Framework == 'ESX' and ESX then
        if ESX.TriggerServerCallback then
            ESX.TriggerServerCallback('synz_hostage:getPoliceCount', function(c)
                lastPoliceCheckAt = now
                lastPoliceCount = tonumber(c) or 0
                cb(lastPoliceCount)
            end)
        else
            cb(0)
        end
    else
        cb(0)
    end
end

-- =====================
-- GET PLAYER JOB
-- =====================
function Bridge.Client.GetPlayerJob()
    if Config.Framework == 'QBCORE' and QBCore then
        local pd = QBCore.Functions and QBCore.Functions.GetPlayerData and QBCore.Functions.GetPlayerData()
        if pd and pd.job then
            return pd.job.name, pd.job.onduty
        end
    elseif Config.Framework == 'ESX' and ESX then
        local pd = ESX.GetPlayerData and ESX.GetPlayerData()
        if pd and pd.job then
            return pd.job.name, true
        end
    end
    return nil, false
end
