ActiveMixer = nil
ActiveMusicCache = {}
MusicInfo = {}

RegisterCommand("mixervolume", function()
    SendNUIMessage({ type = "volumeManager" })
    SetNuiFocus(true, true)
end, false)

RegisterCommand("mixermusic", function()
    local playingData = {}

    for k, v in pairs(ActiveMusicCache) do
        for key, val in pairs(v) do
            if soundExists(key) then
                if not getInfo(key).wasSilenced then
                    table.insert(playingData, {
                        url = val.URL,
                        name = val.Name,
                    })
                end
            end
        end
    end

    if #playingData == 0 then
        ShowFancyNotification(_U("nothing_can_be_heard"), "danger")
        return
    end
    SendNUIMessage({ type = "mixermusic", sounds = playingData })
    SetNuiFocus(true, true)
end, false)

RegisterNUICallback("init", function(data, cb)
    TriggerServerEvent("xdiskjockey:fetchCachedPlayerMixers")
    Wait(1000)
    TriggerServerEvent("xdiskjockey:fetchMusicCacheToPlay")

    for k, v in pairs(SoundsEffects) do
        v.keyBind = GetResourceKvpInt("xdj-" .. hash_string(v.Name .. "-" .. v.URL))
        if v.keyBind == 0 then
            v.keyBind = nil
        end
    end

    if GetResourceKvpInt("xdj-volume-switch") == 0 then
        SetResourceKvpInt("xdj-volume-switch", 1)
        SetResourceKvpInt("xdj-volume", 80)
    end

    SendNUIMessage({
        type = "lowpass_intensity",
        intensity = Config.LowpassIntensity,
    })

    SendNUIMessage({
        type = "init",
        whitelist = Config.WhitelistedURL,
        SoundsEffects = SoundsEffects,
        custom = Config.UseExternalxSound,
        userVolume = GetResourceKvpInt("xdj-volume"),
        translation = Locales[Config.Locale],
        refreshTime = Config.RefreshTime,
    })

    if cb then
        cb(true)
    end
end)

RegisterNetEvent("xdiskjockey:fetchMusicCacheToPlay", function(data, volume)
    for k, v in pairs(data) do
        for key, value in pairs(v) do
            TriggerEvent("xdiskjockey:sendMusicStatus", "play", {
                Loop = value.Loop,
                Volume = value.Volume,
                URL = value.URL,
                Name = value.Name,
                MixerVolume = volume[k] or Config.DefaultMixerVolume,
                Identifier = k,
                Time = value.Time,
                pulseInfo = value.pulseInfo,
                stereoInfo = value.stereoInfo,
            })
        end
    end
end)