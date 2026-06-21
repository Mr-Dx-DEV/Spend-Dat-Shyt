local playerItemsCount = {}
local cachedDefaultMixers = Deepcopy(Config.MixerList)

function calculateForwardVector(yawDegrees)
    local yawRadians = math.rad(yawDegrees)
    local forwardVector = vec3(-math.sin(yawRadians), 0, math.cos(yawRadians))
    return forwardVector
end

function getPlayerForwardVector(player)
    local playerHeading = GetEntityHeading(player)
    local forwardVector = calculateForwardVector(playerHeading)
    return forwardVector
end

SharedObject.RegisterUsableItem(Config.ItemName, function(source)
    if Config.Framework.Active == 0 then
        if not playerItemsCount[source] then
            playerItemsCount[source] = Config.MixerInventoryCount
        end

        if playerItemsCount[source] <= 0 then
            return
        end

        playerItemsCount[source] = playerItemsCount[source] - 1
    end

    local player = SharedObject.GetPlayerFromId(source)
    local ped = GetPlayerPed(source)
    local heading = GetEntityHeading(ped)
    local pPos = GetEntityCoords(ped) + getPlayerForwardVector(ped)

    local data = {
        mixer = {
            {
                pos = pPos,
                heading = heading,
            },
        },
    }

    player.removeInventoryItem(Config.ItemName, 1)

    Config.MixerList[player.identifier] = data
    TriggerClientEvent("xdiskjockey:playPickAnim", source)
    Wait(800)

    TriggerClientEvent("xdiskjockey:addMixerToCache", -1, data, player.identifier)
end)

RegisterNetEvent("xdiskjockey:fetchCachedPlayerMixers", function()
    local playerPlacedMixers = Deepcopy(Config.MixerList)

    for k, v in pairs(cachedDefaultMixers) do
        playerPlacedMixers[k] = nil
    end

    TriggerClientEvent("xdiskjockey:fetchCachedPlayerMixers", source, playerPlacedMixers)
end)

RegisterNetEvent("xdiskjockey:pickupMixer", function(mixerData)
    local source = source
    if not Config.MixerList[mixerData.identifier] then
        return
    end
    if Config.Framework.Active == 0 then
        if not playerItemsCount[source] then
            playerItemsCount[source] = Config.MixerInventoryCount
        end

        playerItemsCount[source] = playerItemsCount[source] + 1
    else
        local player = SharedObject.GetPlayerFromId(source)
        if not player.canCarryItem(Config.ItemName, 1) then
            return
        end
        player.addInventoryItem(Config.ItemName, 1)
    end
    Config.MixerList[mixerData.identifier] = nil

    TriggerClientEvent("xdiskjockey:removeMixerCache", -1, mixerData.identifier)
    TriggerEvent("xdiskjockey:stopAllMusic", mixerData)
end)