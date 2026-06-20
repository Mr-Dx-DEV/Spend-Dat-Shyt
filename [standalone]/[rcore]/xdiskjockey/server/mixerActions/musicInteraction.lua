RegisterNetEvent("xdiskjockey:loopMusic", function(mixer, data)
    local source = source
    if IsPlayerAllowedToUseMixer(source, mixer.identifier) then
        data = data.musicInfo

        UpdateCacheMixersMusicValues(mixer.identifier, data.Name, data.URL, {
            Loop = data.Loop,
        })

        UpdateCachePlayingMusic(mixer.identifier, data.Name, {
            Loop = data.Loop,
        })

        TriggerClientEvent("xdiskjockey:updateStatusPlayList", -1, "loopButton", data.Loop, data.URL, data.Name)

        TriggerClientEvent("xdiskjockey:sendMusicStatus", -1, "loop", {
            Loop = data.Loop,
            Volume = data.Volume,
            URL = data.URL,
            Name = data.Name,
            Identifier = mixer.identifier,
            Time = 0,
        })
    end
end)

RegisterNetEvent("xdiskjockey:stereoMusic", function(mixer, data)
    local source = source

    if IsPlayerAllowedToUseMixer(source, mixer.identifier) then
        if data.enabled then
            UpdateCachePlayingMusic(mixer.identifier, data.musicInfo.Name, {
                stereoInfo = {
                    time = data.time,
                },
            })

            UpdateCacheMixersMusicValues(mixer.identifier, data.musicInfo.Name, data.musicInfo.URL, {
                stereoInfo = {
                    time = data.time,
                },
            })
        else
            RemoveValueFromCachePlayingMusic(mixer.identifier, data.musicInfo.Name, { "stereoInfo" })
            RemoveCacheMixersMusicValues(mixer.identifier, data.musicInfo.Name, data.musicInfo.URL, { "stereoInfo" })
        end

        TriggerClientEvent("xdiskjockey:sendMusicStatus", -1, "stereoMusic", {
            Identifier = mixer.identifier,
            musicInfo = data.musicInfo,
            enabled = data.enabled,
            time = data.time,
            percentage = data.percentage,
        })
    end
end)

RegisterNetEvent("xdiskjockey:pulseMusic", function(mixer, data)
    local source = source

    if IsPlayerAllowedToUseMixer(source, mixer.identifier) then
        if data.enabled then
            UpdateCachePlayingMusic(mixer.identifier, data.musicInfo.Name, {
                pulseInfo = {
                    time = data.time,
                    percentage = data.percentage,
                },
            })

            UpdateCacheMixersMusicValues(mixer.identifier, data.musicInfo.Name, data.musicInfo.URL, {
                pulseInfo = {
                    time = data.time,
                    percentage = data.percentage,
                },
            })
        else
            RemoveValueFromCachePlayingMusic(mixer.identifier, data.musicInfo.Name, { "pulseInfo" })
            RemoveCacheMixersMusicValues(mixer.identifier, data.musicInfo.Name, data.musicInfo.URL, { "pulseInfo" })
        end

        TriggerClientEvent("xdiskjockey:sendMusicStatus", -1, "pulseMusic", {
            Identifier = mixer.identifier,
            musicInfo = data.musicInfo,
            enabled = data.enabled,
            time = data.time,
            percentage = data.percentage,
        })
    end
end)

RegisterNetEvent("xdiskjockey:fadeAction", function(mixer, data)
    local source = source
    if IsPlayerAllowedToUseMixer(source, mixer.identifier) then
        local volume = 0.0
        if data.type == "in" then
            volume = CachedVolumeMixer[mixer.identifier] or Config.DefaultMixerVolume
        end

        UpdateCachePlayingMusic(mixer.identifier, data.Name, {
            Volume = volume,
        })

        TriggerClientEvent("xdiskjockey:sendMusicStatus", -1, "fade", {
            Identifier = mixer.identifier,
            musicInfo = data.musicInfo,
            type = data.type,
            time = data.time,
            volume = data.volume,
        })
    end
end)

RegisterNetEvent("xdiskjockey:syncVolume", function(mixer, volume, key)
    if hash_string(mixer .. volume) ~= key then
        return
    end
    local sanitizedVolume = tonumber(volume) or Config.DefaultMixerVolume
    if sanitizedVolume < 0.01 then
        sanitizedVolume = Config.DefaultMixerVolume
    elseif sanitizedVolume > 1.0 then
        sanitizedVolume = 1.0
    end

    if not CachePlayingMusic[mixer] then
        CachePlayingMusic[mixer] = {}
    end
    CachedVolumeMixer[mixer] = sanitizedVolume

    TriggerClientEvent("xdiskjockey:sendMusicStatus", -1, "volume", {
        Volume = sanitizedVolume,
        Identifier = mixer,
    })
end)

RegisterNetEvent("xdiskjockey:specificvolume", function(mixer, data)
    local source = source
    if IsPlayerAllowedToUseMixer(source, mixer.identifier) then
        local sanitizedVolume = tonumber(data.current_volume) / 100
        if not sanitizedVolume or sanitizedVolume < 0.0 then
            sanitizedVolume = 1.0
        elseif sanitizedVolume > 1.0 then
            sanitizedVolume = 1.0
        end

        local newData = {
            Volume = sanitizedVolume,
        }

        UpdateCachePlayingMusic(mixer.identifier, data.musicInfo.Name, newData)
        UpdateCacheMixersMusicValues(mixer.identifier, data.musicInfo.Name, data.musicInfo.URL, newData)

        TriggerClientEvent("xdiskjockey:sendMusicStatus", -1, "songvolume", {
            Name = data.musicInfo.Name,
            URL = data.musicInfo.URL,
            Identifier = mixer.identifier,
            Volume = sanitizedVolume,
            MixerVolume = CachedVolumeMixer[mixer.identifier],
        })
    end
end)

RegisterNetEvent("xdiskjockey:changeTimeStamp", function(mixer, data)
    local source = source
    if IsPlayerAllowedToUseMixer(source, mixer.identifier) then
        UpdateCachePlayingMusic(mixer.identifier, data.Name, {
            Time = data.newTime,
        })

        TriggerClientEvent("xdiskjockey:sendMusicStatus", -1, "timestamp", {
            URL = data.URL,
            Name = data.Name,
            Identifier = mixer.identifier,
            NewTime = data.newTime,
        })
    end
end)

RegisterNetEvent("xdiskjockey:playMusic", function(mixer, data)
    local source = source

    if not IsMusicWhitelisted(data.musicInfo.URL) then
        return
    end

    if IsPlayerAllowedToUseMixer(source, mixer.identifier) then
        data = data.musicInfo

        if not CachePlayingMusic[mixer.identifier] then
            CachePlayingMusic[mixer.identifier] = {}
        end

        if not CachedVolumeMixer[mixer.identifier] then
            CachedVolumeMixer[mixer.identifier] = Config.DefaultMixerVolume
        end

        if data.Active then
            CachePlayingMusic[mixer.identifier][data.Name] = nil
        else
            CachePlayingMusic[mixer.identifier][data.Name] = {
                Loop = data.Loop,
                Volume = 1.0,
                URL = data.URL,
                Name = data.Name,
                Identifier = mixer.identifier,
                MaxTime = data.time,
                Time = 0,
                Que = data.Que,
            }
        end

        TriggerClientEvent("xdiskjockey:updateStatusPlayList", -1, "playButton", data.Active and true or false, data.URL, data.Name)

        for k, v in pairs(CacheMixersMusic[mixer.identifier]) do
            if v.name == data.Name and v.url == data.URL then
                v.Active = data.Active
                break
            end
        end

        PerformedDiscordMessage(source, {
            url = data.URL,
        })

        PrepareMusicForMX(data.URL)
        TriggerClientEvent("xdiskjockey:sendMusicStatus", -1, data.Active and "stop" or "play", {
            Loop = data.Loop,
            Volume = 1.0,
            MixerVolume = CachedVolumeMixer[mixer.identifier],
            URL = data.URL,
            Name = data.Name,
            Identifier = mixer.identifier,
            Que = data.Que,
            Time = 0,
        })
    end
end)