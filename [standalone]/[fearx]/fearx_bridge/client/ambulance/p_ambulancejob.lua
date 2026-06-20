CreateThread(function()
    while Bridge.Ambulance == nil do
        Wait(100)
    end

    if Bridge.Ambulance ~= 'p_ambulancejob' then return end

    function Bridge.RevivePlayer()
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)

        -- Primary p_ambulancejob revive event
        TriggerEvent('p_ambulancejob/client/death/revive')

        -- Stop any active bleeding
        pcall(function()
            exports['p_ambulancejob']:stopBleeding()
        end)

        -- Reset vitals
        pcall(function()
            exports['p_ambulancejob']:resetPulse()
            exports['p_ambulancejob']:resetTemperature()
        end)

        -- Clear native death state
        NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, GetEntityHeading(playerPed), true, false)
        SetPlayerInvincible(playerPed, false)
        ClearPedBloodDamage(playerPed)
        ClearPedTasksImmediately(playerPed)
        SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))

        ClearTimecycleModifier()
        SetPedMotionBlur(playerPed, false)
        ClearExtraTimecycleModifier()

        -- Clear all death state bags
        pcall(function()
            LocalPlayer.state:set('dead', false, true)
            LocalPlayer.state:set('isdead', false, true)
            LocalPlayer.state:set('isDead', false, true)
            LocalPlayer.state:set('inlaststand', false, true)
            LocalPlayer.state:set('isLastStand', false, true)
            LocalPlayer.state:set('laststand', false, true)
            LocalPlayer.state:set('InLaststand', false, true)
        end)

        -- Framework-specific events
        if Bridge.Framework == 'esx' then
            TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)
            TriggerEvent('esx:onPlayerSpawn')
            TriggerEvent('playerSpawned')
        elseif Bridge.Framework == 'qbcore' or Bridge.Framework == 'qbox' then
            TriggerServerEvent('hospital:server:SetDeathStatus', false)
            TriggerEvent('hospital:client:Revive')
        end
    end

    function Bridge.SetDeathStatus(isDead)
        if not isDead then
            TriggerEvent('p_ambulancejob/client/death/revive')
            pcall(function()
                exports['p_ambulancejob']:stopBleeding()
                exports['p_ambulancejob']:resetPulse()
                exports['p_ambulancejob']:resetTemperature()
            end)
        else
            TriggerEvent('p_ambulancejob/client/death/kill')
        end

        pcall(function()
            LocalPlayer.state:set('dead', isDead, true)
            LocalPlayer.state:set('isdead', isDead, true)
            LocalPlayer.state:set('isDead', isDead, true)
            LocalPlayer.state:set('inlaststand', false, true)
            LocalPlayer.state:set('isLastStand', false, true)
        end)

        if Bridge.Framework == 'esx' then
            TriggerServerEvent('esx_ambulancejob:setDeathStatus', isDead)
        elseif Bridge.Framework == 'qbcore' or Bridge.Framework == 'qbox' then
            TriggerServerEvent('hospital:server:SetDeathStatus', isDead)
        end
    end

    function Bridge.IsPlayerDead()
        local ped = PlayerPedId()
        if IsEntityDead(ped) then return true end

        -- Use p_ambulancejob export
        local success, deathInfo = pcall(function()
            return exports['p_ambulancejob']:getDeathInfo()
        end)
        if success and deathInfo then
            if deathInfo.isDead then return true end
            if deathInfo.stage and deathInfo.stage ~= 'none' then return true end
        end

        -- Fallback to state bags
        if LocalPlayer.state.isDead then return true end
        if LocalPlayer.state.dead then return true end
        local deathType = LocalPlayer.state.deathType
        if deathType and deathType ~= 'none' then return true end

        return false
    end

    function Bridge.OnPlayerDeath()
        if Bridge.Framework == 'esx' then
            TriggerServerEvent('esx_ambulancejob:setDeathStatus', true)
        elseif Bridge.Framework == 'qbcore' or Bridge.Framework == 'qbox' then
            TriggerServerEvent('hospital:server:SetDeathStatus', true)
            LocalPlayer.state:set('dead', true, true)
            LocalPlayer.state:set('isdead', true, true)
            LocalPlayer.state:set('isDead', true, true)
        end
    end

    function Bridge.GetDeathTime()
        return 0
    end

    print('^5[FearX Bridge]^7 ^2p_ambulancejob ambulance module loaded^7')
end)
