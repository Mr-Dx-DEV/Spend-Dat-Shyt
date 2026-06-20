local isQbxMedical = false
local DEATH_STATE_ALIVE = 1
local DEATH_STATE_LAST_STAND = 2
local DEATH_STATE_DEAD = 3

local function ShouldUseQbxMedical()
    return Bridge.Ambulance == 'qbx_medical' or Bridge.Framework == 'qbox'
end

local function QbxRevivePlayer()
    local ped = PlayerPedId()
    local playerId = PlayerId()
    local coords = GetEntityCoords(ped)

    LocalPlayer.state:set('qbx_medical:deathState', DEATH_STATE_ALIVE, true)
    NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, GetEntityHeading(ped), true, false)

    ped = PlayerPedId()

    SetEntityMaxHealth(ped, 200)
    SetEntityHealth(ped, 200)
    SetEntityInvincible(ped, false)
    ClearPedBloodDamage(ped)
    SetPlayerSprint(playerId, true)
    ResetPedMovementClipset(ped, 0.0)
    ClearPedTasksImmediately(ped)

    LocalPlayer.state:set('dead', false, true)
    LocalPlayer.state:set('isdead', false, true)
    LocalPlayer.state:set('isDead', false, true)
    LocalPlayer.state:set('inlaststand', false, true)
    LocalPlayer.state:set('isLastStand', false, true)
    LocalPlayer.state:set('laststand', false, true)
    LocalPlayer.state:set('InLaststand', false, true)
    LocalPlayer.state.invBusy = false

    TriggerServerEvent('fearx_bridge:server:revivePlayer')
    TriggerEvent('qbx_medical:client:playerRevived')
end

local function QbxSetDeathStatus(isDead)
    if isDead then
        LocalPlayer.state:set('qbx_medical:deathState', DEATH_STATE_DEAD, true)
    else
        LocalPlayer.state:set('qbx_medical:deathState', DEATH_STATE_ALIVE, true)
    end
    LocalPlayer.state:set('dead', isDead, true)
    LocalPlayer.state:set('isdead', isDead, true)
    LocalPlayer.state:set('isDead', isDead, true)
    LocalPlayer.state:set('inlaststand', false, true)
    LocalPlayer.state:set('isLastStand', false, true)
end

local function QbxIsPlayerDead()
    local ped = PlayerPedId()
    if IsEntityDead(ped) then return true end
    local deathState = LocalPlayer.state['qbx_medical:deathState']
    if deathState and deathState ~= DEATH_STATE_ALIVE then return true end
    if LocalPlayer.state.dead then return true end
    if LocalPlayer.state.isdead then return true end
    if LocalPlayer.state.isDead then return true end
    if LocalPlayer.state.inlaststand then return true end
    if LocalPlayer.state.isLastStand then return true end
    return false
end

local function QbxOnPlayerDeath()
    LocalPlayer.state:set('qbx_medical:deathState', DEATH_STATE_DEAD, true)
    LocalPlayer.state:set('dead', true, true)
    LocalPlayer.state:set('isdead', true, true)
    LocalPlayer.state:set('isDead', true, true)
end

local function QbxGetDeathTime()
    return 0
end

CreateThread(function()
    while Bridge.Ambulance == nil do
        Wait(100)
    end

    if not ShouldUseQbxMedical() then
        return
    end

    isQbxMedical = true

    Bridge.RevivePlayer = QbxRevivePlayer
    Bridge.SetDeathStatus = QbxSetDeathStatus
    Bridge.IsPlayerDead = QbxIsPlayerDead
    Bridge.OnPlayerDeath = QbxOnPlayerDeath
    Bridge.GetDeathTime = QbxGetDeathTime

    print('^5[FearX Bridge]^7 ^2qbx_medical ambulance module loaded^7')
end)
