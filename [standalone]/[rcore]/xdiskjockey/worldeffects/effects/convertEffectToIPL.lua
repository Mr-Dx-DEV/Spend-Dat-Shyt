function ConvertLaserToIPL(effectName)
    local lights = {
        [Effects.LASER_YELLOW] = "DJ_01_Lights_04",
        [Effects.LASER_GREEN] = "DJ_02_Lights_04",
        [Effects.LASER_WHITE] = "DJ_03_Lights_04",
        [Effects.LASER_PURPLE] = "DJ_04_Lights_04",
    }
    return lights[effectName]
end

function ConvertNeonToIPL(effectName)
    local lights = {
        [Effects.NEON_YELLOW] = "DJ_01_Lights_02",
        [Effects.NEON_WHITE] = "DJ_02_Lights_02",
        [Effects.NEON_PURPLE] = "DJ_03_Lights_02",
        [Effects.NEON_CYAN] = "DJ_04_Lights_02",
    }
    return lights[effectName]
end

function ConvertLightToIPL(effectName)
    local lights = {
        [Effects.LIGHT_YELLOW] = "DJ_01_Lights_01",
        [Effects.LIGHT_GREEN] = "DJ_02_Lights_01",
        [Effects.LIGHT_WHITE] = "DJ_03_Lights_01",
        [Effects.LIGHT_PURPLE] = "DJ_04_Lights_01",
    }
    return lights[effectName]
end

function ConvertBandsToIPL(effectName)
    local lights = {
        [Effects.BANDS_YELLOW] = "DJ_01_Lights_03",
        [Effects.BANDS_GREEN] = "DJ_02_Lights_03",
        [Effects.BANDS_WHITE] = "DJ_03_Lights_03",
        [Effects.BANDS_CYAN] = "DJ_04_Lights_03",
    }
    return lights[effectName]
end