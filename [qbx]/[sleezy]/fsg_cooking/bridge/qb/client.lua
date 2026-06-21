if GetResourceState(Config.ResourceNames.QBCore) ~= 'started' then return end

QBCore = exports['qb-core']:GetCoreObject()

local cachedAdminStatus = false
local lastAdminCheck = 0
local ADMIN_CHECK_INTERVAL = 30000

-- Wait for player to be loaded
CreateThread(function()
    while not LocalPlayer.state.isLoggedIn do
        Wait(100)
    end
end)

function GetCharacterIdentifier()
    if not LocalPlayer.state.isLoggedIn then
        return nil
    end

    local Player = QBCore.Functions.GetPlayerData()
    if Player and Player.citizenid then
        return Player.citizenid
    else
        return nil
    end
end

function GetAllItems()
    local items = QBCore.Shared.Items
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

RegisterNetEvent('fsg_cooking:client:consume', function(consumeType, itemName)
    local ped = PlayerPedId()
    local dict = consumeType == 'food' and 'mp_player_inteat@burger' or 'mp_player_intdrink'
    local clip = consumeType == 'food' and 'mp_player_int_eat_burger' or 'loop_bottle'

    lib.requestAnimDict(dict)
    TaskPlayAnim(ped, dict, clip, 8.0, -8.0, 2500, 49, 0, false, false, false)
    Wait(2500)
    ClearPedTasks(ped)

    lib.callback.await('fsg_cooking:server:finishConsume', false)

    local label = itemName:gsub('fsg_', ''):gsub('_', ' ')
    lib.notify({
        title = consumeType == 'food' and 'Ate' or 'Drank',
        description = 'You consumed ' .. label,
        type = 'success'
    })
end)