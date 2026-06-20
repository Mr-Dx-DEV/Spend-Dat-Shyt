CreateThread(function()
    while Bridge.Ambulance == nil do
        Wait(100)
    end

    if Bridge.Ambulance ~= 'esx_ambulancejob' then return end

    function Bridge.RevivePlayer()
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)

        TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)

        NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, GetEntityHeading(playerPed), true, false)
        SetPlayerInvincible(playerPed, false)
        ClearPedBloodDamage(playerPed)
        ClearPedTasksImmediately(playerPed)
        SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))

        ClearTimecycleModifier()
        SetPedMotionBlur(playerPed, false)
        ClearExtraTimecycleModifier()

        TriggerEvent('esx_basicneeds:resetStatus')
        TriggerServerEvent('esx:onPlayerSpawn')
        TriggerEvent('esx:onPlayerSpawn')
        TriggerEvent('playerSpawned')
    end

    function Bridge.SetDeathStatus(isDead)
        TriggerServerEvent('esx_ambulancejob:setDeathStatus', isDead)
        if not isDead then
            TriggerEvent('esx_basicneeds:resetStatus')
            TriggerServerEvent('esx:onPlayerSpawn')
            TriggerEvent('esx:onPlayerSpawn')
            TriggerEvent('playerSpawned')
        end
    end

    function Bridge.IsPlayerDead()
        local ped = PlayerPedId()
        return IsEntityDead(ped)
    end

    function Bridge.OnPlayerDeath()
        TriggerServerEvent('esx_ambulancejob:setDeathStatus', true)
        TriggerServerEvent('esx:onPlayerDeath', {})
    end

    function Bridge.GetDeathTime()
        return 0
    end
end)
