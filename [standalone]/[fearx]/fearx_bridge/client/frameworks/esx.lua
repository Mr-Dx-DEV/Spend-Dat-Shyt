local ESX = nil
local ESXReady = false

CreateThread(function()
    if GetResourceState('es_extended') ~= 'started' then return end

    while ESX == nil do
        ESX = exports['es_extended']:getSharedObject()
        Wait(100)
    end
    ESXReady = true
    Bridge.FrameworkObject = ESX
end)

local function GetESX()
    if not ESXReady or not ESX then return nil end
    return ESX
end

Bridge.GetPlayerData = function()
    local esx = GetESX()
    if not esx then return nil end
    return esx.GetPlayerData()
end

Bridge.GetPlayerName = function()
    local esx = GetESX()
    if not esx then return GetPlayerName(PlayerId()) end
    local playerData = esx.GetPlayerData()
    if playerData then
        if playerData.firstName and playerData.lastName then
            return playerData.firstName .. ' ' .. playerData.lastName
        elseif playerData.name then
            return playerData.name
        end
    end
    return GetPlayerName(PlayerId())
end

Bridge.IsPlayerLoaded = function()
    local esx = GetESX()
    if not esx then return false end
    local playerData = esx.GetPlayerData()
    return playerData and playerData.job ~= nil
end

Bridge.GetPlayerJob = function()
    local esx = GetESX()
    if not esx then return nil, nil, nil, nil end
    local playerData = esx.GetPlayerData()
    if playerData and playerData.job then
        return playerData.job.name, playerData.job.label, playerData.job.grade, playerData.job.grade_name
    end
    return nil, nil, nil, nil
end

Bridge.GetPlayerGang = function()
    return Bridge.GetPlayerJob()
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESXReady = true
    Bridge.FrameworkObject = ESX
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
end)
