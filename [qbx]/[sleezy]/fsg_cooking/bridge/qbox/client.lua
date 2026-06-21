if GetResourceState(Config.ResourceNames.QBox) ~= 'started' then return end

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

    local Player = QBX.PlayerData
    if Player and Player.citizenid then
        return Player.citizenid
    else
        return nil
    end
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

-- Consumption handler for qb-inventory
RegisterNetEvent('fsg_cooking:client:consume', function(consumeType, itemName)
    local ped = PlayerPedId()
    local dict = consumeType == 'food' and 'mp_player_inteat@burger' or 'mp_player_intdrink'
    local clip = consumeType == 'food' and 'mp_player_int_eat_burger' or 'loop_bottle'

    -- Load and play animation
    lib.requestAnimDict(dict)
    TaskPlayAnim(ped, dict, clip, 8.0, -8.0, 2500, 49, 0, false, false, false)
    Wait(2500)
    ClearPedTasks(ped)

    -- Update player status using QBCore metadata
    TriggerServerEvent('QBCore:Server:SetMetaData', consumeType == 'food' and 'hunger' or 'thirst', 100)

    -- Notify player
    local label = itemName:gsub('fsg_', ''):gsub('_', ' ')
    lib.notify({
        title = consumeType == 'food' and 'Ate' or 'Drank',
        description = 'You consumed ' .. label,
        type = 'success'
    })
end)