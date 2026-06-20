local convertedTable = {}
local stopAllMusicFromEffect = false

function CheckStatusVanillaMusic(identifier, status)
    Wait(100)
    if not identifier then
        return
    end
    stopAllMusicFromEffect = false

    local mixerData = Config.MixerList[identifier]
    if not mixerData.skipEmitterForThis then
        for k, v in pairs(mixerData.speaker) do
            for key, val in pairs(convertedTable) do
                if #(v.pos - val.pos) < 50 then
                    if status == "play" then
                        SetStaticEmitterEnabled(val.name, false)
                    end

                    if status == "stop" then
                        if tableLenght(ActiveMusicCache[identifier] or {}) == 0 then
                            SetStaticEmitterEnabled(val.name, true)
                        end
                    end
                end
            end
        end
    end
end

AddEventHandler("xdiskjockey:localCheckMusicStatus", CheckStatusVanillaMusic)

RegisterNetEvent("xdiskjockey:sendMusicStatus", function(status, data)
    CheckStatusVanillaMusic(data.Identifier, status)
end)

RegisterNetEvent("xdiskjockey:stopAllMusic", function(mixer, queMusic)
    CheckStatusVanillaMusic(mixer, "stop")
end)

RegisterNetEvent("xdiskjockey:stopAllQueMusic", function(mixer, queMusic)
    CheckStatusVanillaMusic(mixer, "stop")
end)

RegisterNetEvent("xdiskjockey:playEffect", function(mixer, data)
    CheckStatusVanillaMusic(mixer.identifier, "play")
    stopAllMusicFromEffect = true
    Wait(20000)
    if stopAllMusicFromEffect then
        CheckStatusVanillaMusic(mixer.identifier, "stop")
    end
end)

CreateThread(function()
    local myPos = GetEntityCoords(PlayerPedId())
    local retval = LoadResourceFile(GetCurrentResourceName(), "emitter.json")
    local data = json.decode(retval)
    for k, v in pairs(data) do
        local emmiterPos = vector3(v.Position.X, v.Position.Y, v.Position.Z)
        table.insert(convertedTable, {
            pos = emmiterPos,
            name = v.Name,
        })
    end

    Wait(1000)
    collectgarbage()
end, "Fetching all emmiter and turning it into usable table")