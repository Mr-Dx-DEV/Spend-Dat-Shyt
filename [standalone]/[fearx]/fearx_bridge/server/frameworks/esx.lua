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
    print('^5[FearXX Bridge]^7 ESX Framework loaded successfully')
end)

local function GetESXPlayer(source)
    if not ESXReady or not ESX then return nil end
    return ESX.GetPlayerFromId(source)
end

Bridge.GetPlayer = function(source)
    return GetESXPlayer(source)
end

Bridge.GetPlayerName = function(source)
    local xPlayer = GetESXPlayer(source)
    if xPlayer then
        return xPlayer.getName()
    end
    return GetPlayerName(source)
end

Bridge.IsPlayerLoaded = function(source)
    local xPlayer = GetESXPlayer(source)
    return xPlayer ~= nil
end

Bridge.GetPlayerJob = function(source)
    local xPlayer = GetESXPlayer(source)
    if xPlayer and xPlayer.job then
        return xPlayer.job.name, xPlayer.job.label, xPlayer.job.grade, xPlayer.job.grade_label
    end
    return nil, nil, nil, nil
end

Bridge.GetPlayerGang = function(source)
    return Bridge.GetPlayerJob(source)
end

Bridge.GetPlayerMoney = function(source, account)
    account = account or 'cash'
    local xPlayer = GetESXPlayer(source)
    if not xPlayer then
        return 0
    end
    if account == 'cash' or account == 'money' then
        return xPlayer.getMoney() or 0
    elseif account == 'bank' then
        local bankAccount = xPlayer.getAccount('bank')
        if bankAccount then
            return bankAccount.money or 0
        end
        return 0
    elseif account == 'black_money' then
        local blackAccount = xPlayer.getAccount('black_money')
        if blackAccount then
            return blackAccount.money or 0
        end
        return 0
    end
    return 0
end

Bridge.AddMoney = function(source, amount, account)
    account = account or 'cash'
    local ok, xPlayer = pcall(GetESXPlayer, source)
    if not ok or not xPlayer then return false end
    local success = pcall(function()
        if account == 'cash' or account == 'money' then
            xPlayer.addMoney(amount)
        elseif account == 'bank' then
            xPlayer.addAccountMoney('bank', amount)
        elseif account == 'black_money' then
            xPlayer.addAccountMoney('black_money', amount)
        end
    end)
    return success
end

Bridge.RemoveMoney = function(source, amount, account)
    account = account or 'cash'
    local xPlayer = GetESXPlayer(source)
    if not xPlayer then return false end
    if account == 'cash' or account == 'money' then
        xPlayer.removeMoney(amount)
    elseif account == 'bank' then
        xPlayer.removeAccountMoney('bank', amount)
    elseif account == 'black_money' then
        xPlayer.removeAccountMoney('black_money', amount)
    end
    return true
end

Bridge.IsAdmin = function(source)
    local xPlayer = GetESXPlayer(source)
    if xPlayer then
        local group = xPlayer.getGroup()
        return group == 'admin' or group == 'superadmin'
    end
    return IsPlayerAceAllowed(source, 'command')
end

Bridge.GetPlayerIdentifier = function(source)
    local xPlayer = GetESXPlayer(source)
    if xPlayer then
        return xPlayer.identifier
    end
    return nil
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
end)
