local carryingBackInProgress = false
local carryAnimNamePlaying = ""
local carryAnimDictPlaying = ""
local carryControlFlagPlaying = 0

RegisterCommand("carry", function(source, args)
    if IsPlayerDead(PlayerId()) or IsEntityDead(PlayerPedId()) then
        lib.notify({ title = 'Carry', description = 'You cant carry someone when you are dead!', type = 'error' })
        return
    end

    if not carryingBackInProgress then
        local player = PlayerPedId()
        local lib_anim   = 'missfinale_c2mcs_1'
        local anim1      = 'fin_c2_mcs_1_camman'
        local lib2       = 'nm'
        local anim2      = 'firemans_carry'
        local distans    = 0.15
        local distans2   = 0.27
        local height     = 0.63
        local spin       = 0.0
        local length     = 100000
        local controlFlagMe     = 49
        local controlFlagTarget = 33
        local animFlagTarget    = 1

        local closestPlayer = GetClosestPlayer(3)

        if closestPlayer ~= -1 and closestPlayer ~= nil then
            carryingBackInProgress = true
            local target = GetPlayerServerId(closestPlayer)
            TriggerServerEvent('CarryPeople:sync', closestPlayer, lib_anim, lib2, anim1, anim2, distans, distans2, height, target, length, spin, controlFlagMe, controlFlagTarget, animFlagTarget)
        else
            lib.notify({ title = 'Carry', description = 'There is no one around', type = 'error' })
        end
    else
        carryingBackInProgress = false
        ClearPedSecondaryTask(GetPlayerPed(-1))
        DetachEntity(GetPlayerPed(-1), true, false)

        local closestPlayer = GetClosestPlayer(3)
        if closestPlayer ~= nil then
            local target = GetPlayerServerId(closestPlayer)
            TriggerServerEvent("CarryPeople:stop", target)
        end
    end
end, false)

RegisterNetEvent('CarryPeople:syncTarget')
AddEventHandler('CarryPeople:syncTarget', function(target, animationLib, animation2, distans, distans2, height, length, spin, controlFlag)
    local playerPed = GetPlayerPed(-1)
    local targetPed = GetPlayerPed(GetPlayerFromServerId(target))

    carryingBackInProgress = true

    RequestAnimDict(animationLib)
    while not HasAnimDictLoaded(animationLib) do
        Citizen.Wait(10)
    end

    if spin == nil then spin = 180.0 end
    if controlFlag == nil then controlFlag = 0 end

    AttachEntityToEntity(GetPlayerPed(-1), targetPed, 0, distans2, distans, height, 0.5, 0.5, spin, false, false, false, false, 2, false)
    TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)

    carryAnimNamePlaying = animation2
    carryAnimDictPlaying = animationLib
    carryControlFlagPlaying = controlFlag
end)

RegisterNetEvent('CarryPeople:syncMe')
AddEventHandler('CarryPeople:syncMe', function(animationLib, animation, length, controlFlag)
    local playerPed = GetPlayerPed(-1)

    RequestAnimDict(animationLib)
    while not HasAnimDictLoaded(animationLib) do
        Citizen.Wait(10)
    end

    if controlFlag == nil then controlFlag = 0 end

    TaskPlayAnim(playerPed, animationLib, animation, 8.0, -8.0, length, controlFlag, 0, false, false, false)

    carryAnimNamePlaying = animation
    carryAnimDictPlaying = animationLib
    carryControlFlagPlaying = controlFlag
end)

RegisterNetEvent('CarryPeople:cl_stop')
AddEventHandler('CarryPeople:cl_stop', function()
    carryingBackInProgress = false
    ClearPedSecondaryTask(GetPlayerPed(-1))
    DetachEntity(GetPlayerPed(-1), true, false)
end)

Citizen.CreateThread(function()
    while true do
        if carryingBackInProgress then
            if not IsEntityPlayingAnim(GetPlayerPed(-1), carryAnimDictPlaying, carryAnimNamePlaying, 3) then
                TaskPlayAnim(GetPlayerPed(-1), carryAnimDictPlaying, carryAnimNamePlaying, 8.0, -8.0, 100000, carryControlFlagPlaying, 0, false, false, false)
            end
            Citizen.Wait(0)
        else
            Citizen.Wait(500)
        end
    end
end)

function GetPlayers()
    local players = {}
    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end
    return players
end

function GetClosestPlayer(radius)
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = nil
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)

    for _, value in ipairs(players) do
        local target = GetPlayerPed(value)
        if target ~= ply then
            local targetCoords = GetEntityCoords(target, 0)
            local distance = GetDistanceBetweenCoords(targetCoords.x, targetCoords.y, targetCoords.z, plyCoords.x, plyCoords.y, plyCoords.z, true)
            if closestDistance == -1 or distance < closestDistance then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end

    if closestDistance ~= -1 and closestDistance <= radius then
        return closestPlayer
    end
    return nil
end