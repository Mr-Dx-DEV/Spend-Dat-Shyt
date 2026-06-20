CreateThread(function()
    while Bridge.Ambulance == nil do
        Wait(100)
    end

    if Bridge.Ambulance ~= 'wasabi_ambulance' then return end

    function Bridge.RevivePlayer()
        pcall(function()
            exports.wasabi_ambulance:reviveTarget()
        end)

        TriggerEvent('wasabi_ambulance:revive')
        TriggerServerEvent('wasabi_ambulance:revive')

        if Bridge.Framework == 'esx' then
            TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)
            TriggerEvent('esx:onPlayerSpawn')
            TriggerEvent('playerSpawned')
        elseif Bridge.Framework == 'qbcore' or Bridge.Framework == 'qbox' then
            TriggerServerEvent('hospital:server:SetDeathStatus', false)
            TriggerEvent('hospital:client:Revive')
            LocalPlayer.state:set('dead', false, true)
            LocalPlayer.state:set('isdead', false, true)
            LocalPlayer.state:set('isDead', false, true)
            LocalPlayer.state:set('inlaststand', false, true)
            LocalPlayer.state:set('isLastStand', false, true)
        end
    end

    function Bridge.SetDeathStatus(isDead)
        if Bridge.Framework == 'esx' then
            TriggerServerEvent('esx_ambulancejob:setDeathStatus', isDead)
        elseif Bridge.Framework == 'qbcore' or Bridge.Framework == 'qbox' then
            TriggerServerEvent('hospital:server:SetDeathStatus', isDead)
            LocalPlayer.state:set('dead', isDead, true)
            LocalPlayer.state:set('isdead', isDead, true)
            LocalPlayer.state:set('isDead', isDead, true)
            LocalPlayer.state:set('inlaststand', false, true)
        end
    end

    function Bridge.IsPlayerDead()
        local ped = PlayerPedId()
        if IsEntityDead(ped) then return true end
        if Bridge.Framework == 'qbcore' or Bridge.Framework == 'qbox' then
            if LocalPlayer.state.dead then return true end
            if LocalPlayer.state.isdead then return true end
            if LocalPlayer.state.isDead then return true end
            if LocalPlayer.state.inlaststand then return true end
            if LocalPlayer.state.isLastStand then return true end
        end
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
end)
