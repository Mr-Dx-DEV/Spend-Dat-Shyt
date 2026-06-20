--[[
    AMBULANCE / REVIVE SYSTEM
    Customize how players are revived when they die inside a community service zone.

    This function is called when Config.AutoReviveInZone is enabled and the
    player dies or reaches critical health inside any service zone.

    Default: wasabi_ambulance > esx_ambulancejob > QB hospital > GTA native
    You can replace this with whatever ambulance/death system your server uses.

    Examples:
        -- wasabi_ambulance (default primary)
        TriggerEvent('wasabi_ambulance:revive')

        -- esx_ambulancejob
        TriggerEvent('esx_ambulancejob:revive')

        -- QB hospital
        TriggerServerEvent('hospital:server:RevivePlayer', GetPlayerServerId(PlayerId()))

        -- Starter Hospital (nh-hospital)
        TriggerServerEvent('hospital:server:revivePlayer')

        -- qbx_medical
        TriggerEvent('qbx_medical:client:revive')

        -- Renewed-Ambulance
        TriggerEvent('renewed-ambulancejob:client:revive')

        -- GTA native (no dependency, always works)
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local heading = GetEntityHeading(ped)
        NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
        Wait(100)
        SetEntityHealth(ped, GetEntityMaxHealth(ped))
        ClearPedBloodDamage(ped)
        ClearPedTasksImmediately(ped)
        SetPlayerInvincible(PlayerId(), false)
        SetEntityInvincible(ped, false)
]]

function CustomRevive()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local heading = GetEntityHeading(ped)

    if GetResourceState('wasabi_ambulance') == 'started' then
        TriggerEvent('wasabi_ambulance:revive')
    elseif GetResourceState('esx_ambulancejob') == 'started' then
        TriggerEvent('esx_ambulancejob:revive')
    elseif GetResourceState('hospital') == 'started' then
        TriggerServerEvent('hospital:server:RevivePlayer', GetPlayerServerId(PlayerId()))
    else
        NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
        Wait(100)
        SetEntityHealth(ped, GetEntityMaxHealth(ped))
        ClearPedBloodDamage(ped)
        ClearPedTasksImmediately(ped)
        SetPlayerInvincible(PlayerId(), false)
        SetEntityInvincible(ped, false)
    end
end
