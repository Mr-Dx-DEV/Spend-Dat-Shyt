------------------------------------------------------

local objectEffects = {
    [Effects.PANEL_PURPLE] = "ba_rig_dj_01_lights_04_a_scr",
    [Effects.PANEL_GREEN] = "ba_rig_dj_02_lights_04_a_scr",
    [Effects.PANEL_PINK] = "ba_rig_dj_04_lights_04_a_scr",

    [Effects.NEON_OBJECT_YELLOW] = "ba_rig_dj_01_lights_02_a",
    [Effects.NEON_OBJECT_WHITE] = "ba_rig_dj_02_lights_02_a",
    [Effects.NEON_OBJECT_PURPLE] = "ba_rig_dj_03_lights_02_a",
    [Effects.NEON_OBJECT_CYAN] = "ba_rig_dj_03_lights_02_a",

    [Effects.LIGHT_OBJECT_YELLOW] = "ba_rig_dj_01_lights_01_a",
    [Effects.LIGHT_OBJECT_GREEN] = "ba_rig_dj_02_lights_01_a",
    [Effects.LIGHT_OBJECT_WHITE] = "ba_rig_dj_03_lights_01_a",
    [Effects.LIGHT_OBJECT_PURPLE] = "ba_rig_dj_04_lights_01_a",

    [Effects.BANDS_OBJECT_YELLOW] = "ba_rig_dj_01_lights_03_a",
    [Effects.BANDS_OBJECT_GREEN] = "ba_rig_dj_02_lights_03_a",
    [Effects.BANDS_OBJECT_WHITE] = "ba_rig_dj_03_lights_03_a",
    [Effects.BANDS_OBJECT_CYAN] = "ba_rig_dj_04_lights_03_a",
}

function IsEffectNameForRemovingObjects(effect)
    local effects = {
        [Effects.REMOVE_PANEL] = true,
        [Effects.REMOVE_NEON] = true,
        [Effects.REMOVE_LIGHT] = true,
        [Effects.REMOVE_BANDS] = true,
    }
    return effects[effect] ~= nil
end

function GetObjectForEffect(effect)
    return objectEffects[effect]
end

function DoesHaveEffectObject(effect)
    return objectEffects[effect] ~= nil
end

------------------------------------------------------

function IsEffectTimerOne(effect)
    local effects = {
        [Effects.RGB] = true,
    }
    return effects[effect] ~= nil
end

------------------------------------------------------

function GetEffectLibraryByIdentifier(identifier)
    -- library, effect
    local effects = {
        [Effects.SMOKE_FLOOR] = { "cut_amb_tv", "cs_amb_tv_sauna_steam" },
        [Effects.SPARKLERS] = { "scr_indep_fireworks", "scr_indep_firework_fountain" },

        [Effects.YELLOW_BAR] = { "core", "proj_laser_player" },
        [Effects.RED_BAR] = { "core", "proj_laser_enemy" },
        [Effects.COMET] = { "proj_indep_firework", "proj_indep_flare_trail" },

        [Effects.FIREWORK_ONE] = { "proj_xmas_firework", "scr_firework_xmas_burst_rgw" },
        [Effects.FIREWORK_TWO] = { "scr_indep_fireworks", "scr_indep_firework_trailburst" },
        [Effects.FIREWORK_THREE] = { "proj_indep_firework", "scr_indep_firework_air_burst" },
    }

    if not effects[identifier] then
        return nil, nil
    end

    return effects[identifier][1], effects[identifier][2]
end

------------------------------------------------------