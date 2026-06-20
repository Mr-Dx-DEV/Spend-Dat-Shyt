CreateThread(function()
    while Bridge.Ambulance == nil do
        Wait(100)
    end

    if Bridge.Ambulance ~= 'qb-ambulancejob' then return end
    if Bridge.Framework ~= 'qbcore' and Bridge.Framework ~= 'qbox' then return end

    function Bridge.RevivePlayer()
        TriggerServerEvent('hospital:server:SetDeathStatus', false)
        TriggerEvent('hospital:client:Revive')

        LocalPlayer.state:set('dead', false, true)
        LocalPlayer.state:set('isdead', false, true)
        LocalPlayer.state:set('isDead', false, true)
        LocalPlayer.state:set('inlaststand', false, true)
        LocalPlayer.state:set('isLastStand', false, true)
        LocalPlayer.state:set('laststand', false, true)
        LocalPlayer.state:set('InLaststand', false, true)
    end

    function Bridge.SetDeathStatus(isDead)
        TriggerServerEvent('hospital:server:SetDeathStatus', isDead)
        LocalPlayer.state:set('dead', isDead, true)
        LocalPlayer.state:set('isdead', isDead, true)
        LocalPlayer.state:set('isDead', isDead, true)
        LocalPlayer.state:set('inlaststand', false, true)
        LocalPlayer.state:set('isLastStand', false, true)
        LocalPlayer.state:set('laststand', false, true)
        LocalPlayer.state:set('InLaststand', false, true)
    end

    function Bridge.IsPlayerDead()
        local ped = PlayerPedId()
        if IsEntityDead(ped) then return true end
        if LocalPlayer.state.dead then return true end
        if LocalPlayer.state.isdead then return true end
        if LocalPlayer.state.isDead then return true end
        if LocalPlayer.state.inlaststand then return true end
        if LocalPlayer.state.isLastStand then return true end
        if LocalPlayer.state.laststand then return true end
        if LocalPlayer.state.InLaststand then return true end
        return false
    end

    function Bridge.OnPlayerDeath()
        TriggerServerEvent('hospital:server:SetDeathStatus', true)
        LocalPlayer.state:set('dead', true, true)
        LocalPlayer.state:set('isdead', true, true)
        LocalPlayer.state:set('isDead', true, true)
    end

    function Bridge.GetDeathTime()
        return 0
    end
end)
