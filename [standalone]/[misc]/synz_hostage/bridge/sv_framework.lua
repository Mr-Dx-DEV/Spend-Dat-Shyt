if GetResourceState('qbx_core') ~= 'started' then
    print('^1[synz_hostage] ERROR: qbx_core is not started!^7')
    return
end

local QBX = exports.qbx_core

-- Create fake QBCore object for old QB resources like synz_hostage
QBCore = {}
QBCore.Functions = {}

-- Player functions
QBCore.Functions.GetPlayer = function(source)
    return QBX.GetPlayer(source)
end

QBCore.Functions.GetPlayerByCitizenId = function(citizenid)
    return QBX.GetPlayerByCitizenId(citizenid)
end

QBCore.Functions.GetPlayers = function()
    local players = {}
    local QBXPlayers = QBX.GetQBPlayers and QBX.GetQBPlayers() or QBX.GetPlayersData and QBX.GetPlayersData() or {}
    for _, player in pairs(QBXPlayers) do
        if player and player.PlayerData and player.PlayerData.source then
            table.insert(players, player.PlayerData.source)
        end
    end
    return players
end

QBCore.Functions.GetQBPlayers = function()
    return QBX.GetQBPlayers and QBX.GetQBPlayers() or QBX.GetPlayersData and QBX.GetPlayersData() or {}
end

-- Notify
QBCore.Functions.Notify = function(text, type, duration)
    QBX.Notify(text, type or 'primary', duration or 5000)
end

-- TriggerCallback - This is what line 44 is calling
QBCore.Functions.TriggerCallback = function(name, cb, ...)
    -- Use the proper QBX callback system via the qb-core bridge
    local QBCoreBridge = exports['qb-core']:GetCoreObject()
    if QBCoreBridge and QBCoreBridge.Functions and QBCoreBridge.Functions.TriggerCallback then
        QBCoreBridge.Functions.TriggerCallback(name, cb, ...)
    else
        -- Fallback using ox_lib if available
        if lib and lib.callback then
            lib.callback(name, false, cb, ...)
        else
            print('^3[synz_hostage] Warning: Could not trigger callback: ' .. tostring(name) .. '^7')
            cb(nil)
        end
    end
end

-- CreateCallback (in case the script registers any)
QBCore.Functions.CreateCallback = function(name, cb)
    local QBCoreBridge = exports['qb-core']:GetCoreObject()
    if QBCoreBridge and QBCoreBridge.Functions and QBCoreBridge.Functions.CreateCallback then
        QBCoreBridge.Functions.CreateCallback(name, cb)
    else
        print('^3[synz_hostage] Warning: Could not create callback: ' .. tostring(name) .. '^7')
    end
end

-- Permissions
QBCore.Functions.HasPermission = function(source, permission)
    return QBX.HasPermission and QBX.HasPermission(source, permission) or false
end

-- Shared data (Jobs / Gangs)
QBCore.Shared = QBCore.Shared or {}
QBCore.Shared.Jobs = QBX.GetJobs and QBX.GetJobs() or {}
QBCore.Shared.Gangs = QBX.GetGangs and QBX.GetGangs() or {}

print('^2[synz_hostage] QBX compatibility bridge loaded successfully (with TriggerCallback support)^7')