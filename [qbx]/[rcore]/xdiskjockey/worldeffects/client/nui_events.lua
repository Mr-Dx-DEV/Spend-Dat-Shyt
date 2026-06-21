RegisterNUICallback("effectName", function(data, cb)
    if IsActiveMixerValid() then
        TriggerServerEvent("xdiskjockey:sendEffectStatus", ActiveMixer, data)
    end
    if cb then cb(true) end
end)