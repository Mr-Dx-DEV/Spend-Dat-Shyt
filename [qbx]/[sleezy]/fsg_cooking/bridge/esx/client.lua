if GetResourceState(Config.ResourceNames.ESX) ~= 'started' then return end

ESX = exports.es_extended:getSharedObject()

local cachedAdminStatus = false
local lastAdminCheck = 0
local ADMIN_CHECK_INTERVAL = 30000 -- Check every 30 seconds

function GetCharacterIdentifier()
    local playerData = ESX.GetPlayerData()

    if playerData and playerData.identifier then
        return playerData.identifier
    else
        return nil
    end
end

function GetAllItems()
    local items = exports.ox_inventory:Items()
    return items
end

function isAdmin()
    local currentTime = GetGameTimer()

    if currentTime - lastAdminCheck > ADMIN_CHECK_INTERVAL then
        cachedAdminStatus = lib.callback.await('fsg_cooking:getGroupStatus', false)
        lastAdminCheck = currentTime
    end

    return cachedAdminStatus
end

function RefreshAdminStatus()
    cachedAdminStatus = lib.callback.await('fsg_cooking:getGroupStatus', false)
    lastAdminCheck = GetGameTimer()
end