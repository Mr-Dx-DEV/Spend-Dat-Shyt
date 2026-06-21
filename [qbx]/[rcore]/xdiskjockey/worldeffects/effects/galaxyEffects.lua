function IsEffectOnlyForGalaxy(effect)
    local effects = {
        [Effects.GALAXY_SMOKE_FLOOR] = true,

        [Effects.LIGHTS] = true,

        [Effects.LIGHT_YELLOW] = true,
        [Effects.LIGHT_GREEN] = true,
        [Effects.LIGHT_WHITE] = true,
        [Effects.LIGHT_PURPLE] = true,

        [Effects.NEONS] = true,

        [Effects.NEON_YELLOW] = true,
        [Effects.NEON_WHITE] = true,
        [Effects.NEON_PURPLE] = true,
        [Effects.NEON_CYAN] = true,

        [Effects.LASERS] = true,

        [Effects.LASER_YELLOW] = true,
        [Effects.LASER_GREEN] = true,
        [Effects.LASER_WHITE] = true,
        [Effects.LASER_PURPLE] = true,

        [Effects.BANDS] = true,

        [Effects.BANDS_YELLOW] = true,
        [Effects.BANDS_GREEN] = true,
        [Effects.BANDS_WHITE] = true,
        [Effects.BANDS_CYAN] = true,
    }
    return effects[effect] ~= nil
end

function IsNeonEffectGalaxy(light)
    local lights = {
        [Effects.DISABLE_NEON] = true,
        [Effects.NEON_YELLOW] = true,
        [Effects.NEON_WHITE] = true,
        [Effects.NEON_PURPLE] = true,
        [Effects.NEON_CYAN] = true,
    }
    return lights[light] ~= nil
end

function IsLightForGalaxy(light)
    local lights = {
        [Effects.DISABLE_LIGHTS] = true,
        [Effects.LIGHT_YELLOW] = true,
        [Effects.LIGHT_GREEN] = true,
        [Effects.LIGHT_WHITE] = true,
        [Effects.LIGHT_PURPLE] = true,
    }
    return lights[light] ~= nil
end

function IsEffectLaserForGalaxy(light)
    local lights = {
        [Effects.DISABLE_LASER] = true,
        [Effects.LASER_YELLOW] = true,
        [Effects.LASER_GREEN] = true,
        [Effects.LASER_WHITE] = true,
        [Effects.LASER_PURPLE] = true,
    }
    return lights[light] ~= nil
end

function IsEffectBandsForGalaxy(light)
    local lights = {
        [Effects.DISABLE_BANDS] = true,
        [Effects.BANDS_YELLOW] = true,
        [Effects.BANDS_GREEN] = true,
        [Effects.BANDS_WHITE] = true,
        [Effects.BANDS_CYAN] = true,
    }
    return lights[light] ~= nil
end