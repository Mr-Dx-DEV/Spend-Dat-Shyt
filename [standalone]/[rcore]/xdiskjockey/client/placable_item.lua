function EditMixerData(data)
    data.speaker = {
        {
            pos = data.mixer[1].pos,
            distance = Config.PersonalMixerDistance or 20.0,
        },
    }

    data.mixer[1].distance = 30.0 or Config.PersonalMixerObjectDistance
    data.mixer[1].isPlayerMixer = true

    data.defaultVolume = 0.5

    return data
end

RegisterNetEvent("xdiskjockey:playPickAnim", function()
    PlayPickupAnim()
end)

RegisterNetEvent("xdiskjockey:addMixerToCache", function(data, identifier)
    data = EditMixerData(data)

    Config.MixerList[identifier] = data
end)

RegisterNetEvent("xdiskjockey:fetchCachedPlayerMixers", function(data)
    for k, v in pairs(data) do
        v = EditMixerData(v)

        Config.MixerList[k] = v
    end
end)

RegisterNetEvent("xdiskjockey:removeMixerCache", function(identifier)
    Wait(1000)
    if Config.MixerList[identifier] then
        for identifier, v in pairs(Config.MixerList[identifier]) do
            if type(v) == "table" then
                for key, val in pairs(v) do
                    if val.entity then
                        DeleteEntity(val.entity)
                    end
                end
            end
        end

        Config.MixerList[identifier] = nil
    end
end)