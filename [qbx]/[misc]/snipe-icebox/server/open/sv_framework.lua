QBCore, ESX = nil, nil
disabled = false
JobsTable = {}

if Config.Framework == "qb" then
    TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
    if QBCore == nil then
        QBCore = exports[Config.FrameworkTriggers["qb"].ResourceName]:GetCoreObject()
    end
    JobsTable = QBCore.Shared.Jobs
elseif Config.Framework == "esx" then
    local status, errorMsg = pcall(function() ESX = exports[Config.FrameworkTriggers["esx"].ResourceName]:getSharedObject() end)
    if (ESX == nil) then
        TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
    end
    while not next(ESX.GetJobs()) do 
        Wait(50) 
    end
    JobsTable = ESX.GetJobs()
else
    print("Framework not found")
    disabled = true
end

function RemovePlayerMoney(source, type, amount)
    if Config.Framework == "qb" then
        local xPlayer = QBCore.Functions.GetPlayer(source)
        return xPlayer.Functions.RemoveMoney(type, amount)
    elseif Config.Framework == "esx" then
        local xPlayer = ESX.GetPlayerFromId(source)
        if type == "cash" then
            if xPlayer.getMoney() >= amount then
                xPlayer.removeMoney(amount)
                return true
            else
                return false
            end
        elseif type == "bank" then
            if xPlayer.getAccount("bank").money >= amount then
                xPlayer.removeAccountMoney("bank", amount)
                return true
            else
                return false
            end
        end
    end
end

function AddPlayerMoney(source, type, amount)
    if Config.Framework == "qb" then
        local xPlayer = QBCore.Functions.GetPlayer(source)
        xPlayer.Functions.AddMoney(type, amount)
        return true
    elseif Config.Framework == "esx" then
        local xPlayer = ESX.GetPlayerFromId(source)
        if type == "cash" then
            xPlayer.addMoney(amount)
            return true
        elseif type == "bank" then
            xPlayer.addAccountMoney("bank", amount)
            return true
        end
    end
end

function GetPlayerJob(source)
    if Config.Framework == "qb" then
        local xPlayer = QBCore.Functions.GetPlayer(source)
        if xPlayer and xPlayer.PlayerData and xPlayer.PlayerData.job then
            return xPlayer.PlayerData.job.name
        end
    elseif Config.Framework == "esx" then
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer and xPlayer.job then
            return xPlayer.job.name
        end
    end
    return nil
end