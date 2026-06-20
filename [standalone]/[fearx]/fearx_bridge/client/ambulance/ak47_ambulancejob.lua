CreateThread(function()
    while Bridge.Ambulance == nil do
        Wait(100)
    end

    if Bridge.Ambulance ~= 'ak47_ambulancejob' then return end

    function Bridge.RevivePlayer()
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)

        TriggerEvent('ak47_ambulancejob:revive')
        TriggerServerEvent('ak47_ambulancejob:revive', GetPlayerServerId(PlayerId()))

        NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, GetEntityHeading(playerPed), true, false)
        SetPlayerInvincible(playerPed, false)
        ClearPedBloodDamage(playerPed)
        ClearPedTasksImmediately(playerPed)
        SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))

        ClearTimecycleModifier()
        SetPedMotionBlur(playerPed, false)
        ClearExtraTimecycleModifier()

        TriggerEvent('ak47_ambulancejob:skellyfix')

        if Bridge.Framework == 'esx' then
            TriggerEvent('esx_basicneeds:resetStatus')
            TriggerServerEvent('esx:onPlayerSpawn')
            TriggerEvent('esx:onPlayerSpawn')
        end
        TriggerEvent('playerSpawned')
    end

    function Bridge.SetDeathStatus(isDead)
        if not isDead then
            TriggerEvent('ak47_ambulancejob:revive')
            TriggerServerEvent('ak47_ambulancejob:revive', GetPlayerServerId(PlayerId()))
            TriggerEvent('ak47_ambulancejob:skellyfix')

            if Bridge.Framework == 'esx' then
                TriggerEvent('esx_basicneeds:resetStatus')
                TriggerServerEvent('esx:onPlayerSpawn')
                TriggerEvent('esx:onPlayerSpawn')
            end
            TriggerEvent('playerSpawned')
        end
    end

    function Bridge.IsPlayerDead()
        local playerId = GetPlayerServerId(PlayerId())

        local isDown = exports['ak47_ambulancejob']:IsPlayerDown()
        local isDead = exports['ak47_ambulancejob']:IsPlayerDead()

        if isDown or isDead then
            return true
        end

        return IsEntityDead(PlayerPedId())
    end

    function Bridge.OnPlayerDeath()
        TriggerEvent('ak47_ambulancejob:onPlayerDeath')
        TriggerServerEvent('ak47_ambulancejob:onPlayerDeath')

        if Bridge.Framework == 'esx' then
            TriggerServerEvent('esx:onPlayerDeath', {})
        end
    end

    function Bridge.GetDeathTime()
        return 0
    end

    function Bridge.GetPlayerInjuries()
        local success, damages = pcall(function()
            return exports['ak47_ambulancejob']:GetSkellyDamages()
        end)

        if success and damages then
            return damages
        end

        return {
            head = 0,
            chest = 0,
            larm = 0,
            rarm = 0,
            lleg = 0,
            rleg = 0
        }
    end

    exports('GetPlayerInjuries', Bridge.GetPlayerInjuries)
end)
