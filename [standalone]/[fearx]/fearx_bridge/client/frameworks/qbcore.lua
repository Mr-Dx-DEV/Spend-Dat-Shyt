if Bridge.Framework ~= 'qbcore' then return end

local QBCore = nil

CreateThread(function()
    while QBCore == nil do
        QBCore = exports['qb-core']:GetCoreObject()
        Wait(100)
    end
    Bridge.FrameworkObject = QBCore
end)

function Bridge.GetPlayerData()
    if QBCore then
        return QBCore.Functions.GetPlayerData()
    end
    return nil
end

function Bridge.GetPlayerName()
    if QBCore then
        local playerData = QBCore.Functions.GetPlayerData()
        if playerData and playerData.charinfo then
            return playerData.charinfo.firstname .. ' ' .. playerData.charinfo.lastname
        end
    end
    return GetPlayerName(PlayerId())
end

function Bridge.IsPlayerLoaded()
    if QBCore then
        local playerData = QBCore.Functions.GetPlayerData()
        return playerData and playerData.citizenid ~= nil
    end
    return false
end

function Bridge.GetPlayerJob()
    if QBCore then
        local playerData = QBCore.Functions.GetPlayerData()
        if playerData and playerData.job then
            return playerData.job.name, playerData.job.label, playerData.job.grade.level, playerData.job.grade.name
        end
    end
    return nil, nil, nil, nil
end

function Bridge.GetPlayerGang()
    if QBCore then
        local playerData = QBCore.Functions.GetPlayerData()
        if playerData and playerData.gang then
            return playerData.gang.name, playerData.gang.label, playerData.gang.grade.level, playerData.gang.grade.name
        end
    end
    return nil, nil, nil, nil
end

function Bridge.IsPlayerDead()
    local ped = PlayerPedId()
    if IsEntityDead(ped) then return true end
    local isDead = LocalPlayer.state.isDead
    local isLastStand = LocalPlayer.state.isLastStand
    return isDead or isLastStand or false
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    Bridge.FrameworkObject = QBCore
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
end)

RegisterNetEvent('QBCore:Client:OnGangUpdate')
AddEventHandler('QBCore:Client:OnGangUpdate', function(gang)
end)
