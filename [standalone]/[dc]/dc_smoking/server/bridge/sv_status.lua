Status = {}

local ESX, QBCore

if Config.Framework == 'esx' then
    ESX = exports['es_extended']:getSharedObject()
elseif Config.Framework == 'qb' or Config.Framework == 'qbox' then
    QBCore = exports['qb-core']:GetCoreObject()
end

local function GetPlayer(src)
    if ESX then
        return ESX.GetPlayerFromId(src)
    elseif QBCore then
        return QBCore.Functions.GetPlayer(src)
    end
    return nil
end

--- Remove stress from a player.
--- @param src number Player server ID
--- @param amount number Stress amount to remove (0-25 range)
function Status.RemoveStress(src, amount)
    if amount <= 0 then return end

    if GetResourceState('jg-stress-addon') == 'started' then
        TriggerClientEvent('dc_smoking:relieveStress', src, amount)
        return
    end

    if Config.Framework == 'esx' then
        TriggerClientEvent('esx_status:remove', src, 'stress', amount * 10000)
    elseif Config.Framework == 'qb' or Config.Framework == 'qbox' then
        TriggerClientEvent('dc_smoking:relieveStress', src, amount)
    end
end

--- Reduce a player's thirst.
--- @param src number Player server ID
--- @param amount number Thirst drain amount (0-5 range)
function Status.RemoveThirst(src, amount)
    if amount <= 0 then return end

    if Config.Framework == 'esx' then
        TriggerClientEvent('esx_status:remove', src, 'thirst', amount * 10000)
    elseif Config.Framework == 'qb' or Config.Framework == 'qbox' then
        local player = GetPlayer(src)
        if player then
            local currentThirst = player.PlayerData.metadata['thirst'] or 100
            local currentHunger = player.PlayerData.metadata['hunger'] or 100
            local newThirst = math.max(0, currentThirst - amount)
            player.Functions.SetMetaData('thirst', newThirst)
            TriggerClientEvent('hud:client:UpdateNeeds', src, currentHunger, newThirst)
        end
    end
end

--- Reduce a player's hunger.
--- @param src number Player server ID
--- @param amount number Hunger drain amount (0-5 range)
function Status.RemoveHunger(src, amount)
    if amount <= 0 then return end

    if Config.Framework == 'esx' then
        TriggerClientEvent('esx_status:remove', src, 'hunger', amount * 10000)
    elseif Config.Framework == 'qb' or Config.Framework == 'qbox' then
        local player = GetPlayer(src)
        if player then
            local currentHunger = player.PlayerData.metadata['hunger'] or 100
            local currentThirst = player.PlayerData.metadata['thirst'] or 100
            local newHunger = math.max(0, currentHunger - amount)
            player.Functions.SetMetaData('hunger', newHunger)
            TriggerClientEvent('hud:client:UpdateNeeds', src, newHunger, currentThirst)
        end
    end
end
