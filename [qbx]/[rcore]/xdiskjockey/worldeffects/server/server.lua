CacheEffects = {}

RegisterNetEvent("xdiskjockey:fetchEffectCache", function()
    TriggerClientEvent("xdiskjockey:fetchEffectCache", source, CacheEffects)
end)

RegisterNetEvent("xdiskjockey:sendEffectStatus", function(mixer, data)
    local source = source
    if IsPlayerAllowedToUseMixer(source, mixer.identifier) then
        if not CacheEffects[mixer.identifier] then
            CacheEffects[mixer.identifier] = {}
        end

        CacheEffects[mixer.identifier][data.effectName] = data.status

        if IsEffectForDisable(data.status) then
            data.status = false
        end

        TriggerClientEvent("xdiskjockey:sendEffectStatus", -1, mixer.identifier, data.effectName, data.status, data.isList ~= nil)
    end
end)