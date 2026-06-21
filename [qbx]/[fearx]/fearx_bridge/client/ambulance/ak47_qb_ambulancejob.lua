CreateThread(function()
    while Bridge.Ambulance == nil do
        Wait(100)
    end

    if Bridge.Ambulance ~= 'ak47_qb_ambulancejob' then return end

    function Bridge.RevivePlayer()
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)

        TriggerEvent('ak47_qb_ambulancejob:revive')
        TriggerServerEvent('ak47_qb_ambulancejob:revive', GetPlayerServerId(PlayerId()))

        NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, GetEntityHeading(playerPed), true, false)
        SetPlayerInvincible(playerPed, false)
        ClearPedBloodDamage(playerPed)
        ClearPedTasksImmediately(playerPed)
        SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))

        ClearTimecycleModifier()
        SetPedMotionBlur(playerPed, false)
        ClearExtraTimecycleModifier()

        TriggerEvent('ak47_qb_ambulancejob:skellyfix')
        TriggerEvent('ak47_qb_ambulancejob:onPlayerRevive')
        TriggerServerEvent('ak47_qb_ambulancejob:onPlayerRevive')

        LocalPlayer.state:set('dead', false, true)
        LocalPlayer.state:set('isdead', false, true)
        LocalPlayer.state:set('isDead', false, true)
        LocalPlayer.state:set('inlaststand', false, true)
        LocalPlayer.state:set('isLastStand', false, true)
        LocalPlayer.state:set('laststand', false, true)
        LocalPlayer.state:set('InLaststand', false, true)

        TriggerEvent('playerSpawned')
    end

    function Bridge.SetDeathStatus(isDead)
        if not isDead then
            TriggerEvent('ak47_qb_ambulancejob:revive')
            TriggerServerEvent('ak47_qb_ambulancejob:revive', GetPlayerServerId(PlayerId()))
            TriggerEvent('ak47_qb_ambulancejob:skellyfix')
            TriggerEvent('ak47_qb_ambulancejob:onPlayerRevive')
            TriggerServerEvent('ak47_qb_ambulancejob:onPlayerRevive')

            LocalPlayer.state:set('dead', false, true)
            LocalPlayer.state:set('isdead', false, true)
            LocalPlayer.state:set('isDead', false, true)
            LocalPlayer.state:set('inlaststand', false, true)
            LocalPlayer.state:set('isLastStand', false, true)
            LocalPlayer.state:set('laststand', false, true)
            LocalPlayer.state:set('InLaststand', false, true)

            TriggerEvent('playerSpawned')
        else
            LocalPlayer.state:set('dead', true, true)
            LocalPlayer.state:set('isdead', true, true)
            LocalPlayer.state:set('isDead', true, true)
        end
    end

    function Bridge.IsPlayerDead()
        local isDown = exports['ak47_qb_ambulancejob']:IsPlayerDown()
        local isDead = exports['ak47_qb_ambulancejob']:IsPlayerDead()

        if isDown or isDead then
            return true
        end

        if LocalPlayer.state.dead then return true end
        if LocalPlayer.state.isdead then return true end
        if LocalPlayer.state.isDead then return true end
        if LocalPlayer.state.inlaststand then return true end
        if LocalPlayer.state.isLastStand then return true end
        if LocalPlayer.state.laststand then return true end
        if LocalPlayer.state.InLaststand then return true end

        return IsEntityDead(PlayerPedId())
    end

    function Bridge.OnPlayerDeath()
        TriggerEvent('ak47_qb_ambulancejob:onPlayerDeath')
        TriggerServerEvent('ak47_qb_ambulancejob:onPlayerDeath')

        LocalPlayer.state:set('dead', true, true)
        LocalPlayer.state:set('isdead', true, true)
        LocalPlayer.state:set('isDead', true, true)
    end

    function Bridge.GetDeathTime()
        return 0
    end

    function Bridge.GetPlayerInjuries()
        local success, damages = pcall(function()
            return exports['ak47_qb_ambulancejob']:GetSkellyDamages()
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

    function Bridge.GetDoctorCount()
        local success, count = pcall(function()
            return exports['ak47_qb_ambulancejob']:GetDoctorCount()
        end)

        if success and count then
            return count
        end

        return 0
    end

    exports('GetPlayerInjuries', Bridge.GetPlayerInjuries)
    exports('GetDoctorCount', Bridge.GetDoctorCount)
end)
