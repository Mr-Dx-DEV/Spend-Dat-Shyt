function IsResourceOnServer(resourceName)
    if GetResourceState(resourceName) == "started" or GetResourceState(resourceName) == "starting" then
        return true
    end
    return false
end

-- must be in shared because for dependency in server side.
function IsEffectForDisable(effectName)
    local effects = {
        [Effects.DISABLE_LIGHTS] = true,
        [Effects.DISABLE_NEON] = true,
        [Effects.DISABLE_LASER] = true,
        [Effects.DISABLE_BANDS] = true,
    }

    return effects[effectName] ~= nil
end