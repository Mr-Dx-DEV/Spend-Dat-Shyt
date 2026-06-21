Config.Props = {
    jack = {
        model = 'imp_prop_car_jack_01a',
        vehicleAttach = {
            bone = 3,
            offset = vec3(-0.90, -2.75, 0.2),
            rotation = vec3(0.0, 0.0, 0.0),
        },
        playerAttach = {
            bone = 28422,
            offset = vec3(-0.4, -1.3, -0.60),
            rotation = vec3(180.0, 180.0, 0.0),
            animDict = 'missfinale_c2ig_11',
            animName = 'pushcar_offcliff_f',
        },
    },
    spareWheel = {
        model = 'imp_prop_impexp_tyre_02c',
        vehicleAttach = {
            bone = 3,
            offset = vec3(0.0, -0.7, 0.6),
            rotation = vec3(0.0, 0.0, 0.0),
        },
        playerAttach = {
            bone = 28422,
            offset = vec3(0.0, -0.10, 0.15),
            rotation = vec3(0.0, 0.0, 0.0),
            animDict = 'anim@heists@box_carry@',
            animName = 'idle',
        },
    },
    jerryCan = {
        model = 'w_am_jerrycan',
        vehicleAttach = {
            bone = 3,
            offset = vec3(0.90, -2.0, 0.45),
            rotation = vec3(0.0, 0.0, 180.0),
        },
        playerAttach = {
            bone = 28422,
            offset = vec3(0.26, 0.050, 0.0300),
            rotation = vec3(80.0, 180.0, 79.99),
            animDict = 'weapons@misc@jerrycan@franklin',
            animName = 'idle',
        },
    },
    battery = {
        model = 'prop_car_battery_01',
        vehicleAttach = {
            bone = 3,
            offset = vec3(-0.90, -2.0, 0.40),
            rotation = vec3(80.0, 180.0, 79.99),
            animdict = 'anim@heists@box_carry@',
            animName = 'idle',
        },
        playerAttach = {
            bone = 28422,
            offset = vec3(0.0, -0.10, 0.0),
            rotation = vec3(0.0, 0.0, 0.0),
            animDict = 'anim@heists@box_carry@',
            animName = 'idle',
        },
    },
}

-- Animation used when filling fuel
Config.FuelAnimation = {
    duration = 10000,
    dict = 'weapons@misc@jerrycan@',
    anim = 'fire',
    prop = {
        model = 'w_am_jerrycan',
        bone = 57005,
        offset = vec3(0.1800, 0.1300, -0.2400),
        rotation = vec3(-165.8693883, -11.2122753, -32.9453021),
    },
}

-- Animation used when changing wheel
Config.WheelAnimation = {
    duration = 10000,
    dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
    anim = 'machinic_loop_mechandplayer',
    flag = 1,
}

-- Jack attaches to the chassis center, offset left or right depending on which side the flat tire is on
Config.JackAttach = {
    bone = 'chassis',
    left = {
        offset = vec3(-0.70, 0.0, -0.45),
        rotation = vec3(0.0, 0.0, 90.0),
    },
    right = {
        offset = vec3(0.70, 0.0, -0.45),
        rotation = vec3(0.0, 0.0, -90.0),
    },
    -- Incremental Z offsets for the vehicle raise (just enough to clear a tire)
    raiseSteps = { 0.01, 0.03, 0.06, 0.09, 0.12, 0.15 },
    stepTime = 800, -- ms per pump stroke
}

-- Map wheel bones to jack side
Config.WheelJackSide = {
    wheel_lf = 'left',
    wheel_lr = 'left',
    wheel_rf = 'right',
    wheel_rr = 'right',
}

-- Wheel bone names and their GTA tire indices (randomly selected at runtime)
Config.WheelBones = {
    { name = 'wheel_lf', index = 0 },
    { name = 'wheel_rf', index = 1 },
    { name = 'wheel_lr', index = 2 },
    { name = 'wheel_rr', index = 3 },
}

-- Fuel cap bone names to search (first match used)
Config.FuelCapBones = { 'petrolcap', 'petroltank_l', 'hub_lr', 'handle_dside_r' }

-- Animation used when changing battery (leaning into engine bay)
Config.BatteryAnimation = {
    duration = 8000,
    dict = 'mini@repair',
    anim = 'fixing_a_player',
    flag = 1,
}

-- Engine bay bone names to search for battery target (first match used)
Config.EngineBones = { 'engine', 'bonnet' }
