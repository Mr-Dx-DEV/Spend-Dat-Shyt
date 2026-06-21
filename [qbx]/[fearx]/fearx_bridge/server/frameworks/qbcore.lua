if Bridge.Framework ~= 'qbcore' then return end

local QBCore = nil

CreateThread(function()
    while QBCore == nil do
        QBCore = exports['qb-core']:GetCoreObject()
        Wait(100)
    end
    Bridge.FrameworkObject = QBCore
end)

function Bridge.GetPlayer(source)
    if QBCore then
        return QBCore.Functions.GetPlayer(source)
    end
    return nil
end

function Bridge.GetPlayerName(source)
    if QBCore then
        local Player = QBCore.Functions.GetPlayer(source)
        if Player and Player.PlayerData and Player.PlayerData.charinfo then
            return Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
        end
    end
    return GetPlayerName(source)
end

function Bridge.IsPlayerLoaded(source)
    if QBCore then
        local Player = QBCore.Functions.GetPlayer(source)
        return Player ~= nil
    end
    return false
end

function Bridge.GetPlayerJob(source)
    if QBCore then
        local Player = QBCore.Functions.GetPlayer(source)
        if Player and Player.PlayerData and Player.PlayerData.job then
            return Player.PlayerData.job.name, Player.PlayerData.job.label, Player.PlayerData.job.grade.level, Player.PlayerData.job.grade.name
        end
    end
    return nil, nil, nil, nil
end

function Bridge.GetPlayerGang(source)
    if QBCore then
        local Player = QBCore.Functions.GetPlayer(source)
        if Player and Player.PlayerData and Player.PlayerData.gang then
            return Player.PlayerData.gang.name, Player.PlayerData.gang.label, Player.PlayerData.gang.grade.level, Player.PlayerData.gang.grade.name
        end
    end
    return nil, nil, nil, nil
end

function Bridge.GetPlayerMoney(source, account)
    account = account or 'cash'
    if QBCore then
        local Player = QBCore.Functions.GetPlayer(source)
        if not Player then return 0 end
        return Player.PlayerData.money[account] or 0
    end
    return 0
end

function Bridge.AddMoney(source, amount, account)
    account = account or 'cash'
    if QBCore then
        local Player = QBCore.Functions.GetPlayer(source)
        if not Player then return false end
        Player.Functions.AddMoney(account, amount)
        return true
    end
    return false
end

function Bridge.RemoveMoney(source, amount, account)
    account = account or 'cash'
    if QBCore then
        local Player = QBCore.Functions.GetPlayer(source)
        if not Player then return false end
        Player.Functions.RemoveMoney(account, amount)
        return true
    end
    return false
end

function Bridge.IsAdmin(source)
    if QBCore then
        return QBCore.Functions.HasPermission(source, 'admin') or QBCore.Functions.HasPermission(source, 'god')
    end
    return IsPlayerAceAllowed(source, 'command')
end

RegisterNetEvent('QBCore:Server:OnPlayerLoaded')
AddEventHandler('QBCore:Server:OnPlayerLoaded', function()
end)

RegisterNetEvent('QBCore:Server:OnJobUpdate')
AddEventHandler('QBCore:Server:OnJobUpdate', function(source, job)
end)

RegisterNetEvent('QBCore:Server:OnGangUpdate')
AddEventHandler('QBCore:Server:OnGangUpdate', function(source, gang)
end)
