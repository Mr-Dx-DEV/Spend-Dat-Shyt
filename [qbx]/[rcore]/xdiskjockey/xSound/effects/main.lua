local fading = {}

function IsSoundFading(name)
    return fading[name] ~= nil
end

function StartPulseStereo(name, time)
    if Config.UseExternalxSound then
        exports[Config.xSoundName]:StartPulseStereo(name, time)
        return
    end
    if soundInfo[name] then
        soundInfo[name].stereo = {
            time = time,
        }
        SendNUIMessage({
            type = "stereoStart",
            name = name,
            time = time,
        })
    end
end

function EndPulseStereo(name, ignoreVariable)
    if Config.UseExternalxSound then
        exports[Config.xSoundName]:EndPulseStereo(name)
        return
    end
    if soundInfo[name] then
        if not ignoreVariable then
            soundInfo[name].stereo = nil
        end
        SendNUIMessage({
            type = "stereoEnd",
            name = name,
        })
    end
end

function PulseSoundStart(name, percentage, time)
    if Config.UseExternalxSound then
        exports[Config.xSoundName]:PulseSound(name, percentage, time)
        return
    end
    if soundInfo[name] then
        soundInfo[name].pulse = {
            percentage = percentage,
            time = time,
        }
        SendNUIMessage({
            type = "pulseStart",
            name = name,
            percentage = percentage,
            time = time,
        })
    end
end

function EndPulseSound(name, ignoreVariable)
    if Config.UseExternalxSound then
        exports[Config.xSoundName]:EndPulseSound(name)
        return
    end
    if soundInfo[name] then
        if not ignoreVariable then
            soundInfo[name].pulse = nil
        end
        SendNUIMessage({
            type = "pulseEnd",
            name = name,
        })
    end
end

function fadeIn(name, time, volume_)
    -- the only way how to make fade with mx is to use pause + resume which is not what this function does exactly.
    -- so we will simply disable it.
    if Config.MXSurround then
        return
    end

    if type(time) == "string" then
        time = tonumber(time)
    end
    CreateThread(function()
        fading[name] = true
        Wait(time)
        fading[name] = nil
    end, "thread for 'fading' variable state")

    if Config.UseExternalxSound then
        exports[Config.xSoundName]:fadeIn(name, time, volume_)
        return
    end
    if soundExists(name) then
        volumeType(name, 0)

        local addVolume = (volume_ / time) * 100
        local called = 0
        local volume = volume_

        while true do
            volume = volume - addVolume
            if volume < 0 then
                volume = 0
            end
            if volume == 0 then
                break
            end
            called = called + 1
        end

        volume = getVolume(name)
        while true do
            Wait(time / called)

            if not soundExists(name) then
                return
            end

            volume = volume + addVolume
            if volume > volume_ then
                volume = volume_
                volumeType(name, volume)
                break
            end
            volumeType(name, volume)
        end
    end
end

function fadeOut(name, time)
    -- the only way how to make fade with mx is to use pause + resume which is not what this function does exactly.
    -- so we will simply disable it.
    if Config.MXSurround then
        return
    end

    if type(time) == "string" then
        time = tonumber(time)
    end
    CreateThread(function()
        fading[name] = true
        Wait(time)
        fading[name] = nil
    end, "thread for 'fading' variable state")

    if Config.UseExternalxSound then
        exports[Config.xSoundName]:fadeOut(name, time)
        return
    end

    if soundExists(name) then
        local volume = getVolume(name)

        local addVolume = (volume / time) * 100
        local called = 0

        while true do
            volume = volume - addVolume
            if volume < 0 then
                volume = 0
            end
            if volume == 0 then
                break
            end
            called = called + 1
        end

        volume = getVolume(name)
        while true do
            Wait(time / called)

            if not soundExists(name) then
                return
            end

            volume = volume - addVolume
            if volume < 0 then
                volume = 0
                volumeType(name, volume)
                break
            end
            volumeType(name, volume)
        end
    end
end

function volumeType(name, volume)
    if isDynamic(name) then
        setVolumeMax(name, volume)
        setVolume(name, volume)
    else
        setVolume(name, volume)
    end
end