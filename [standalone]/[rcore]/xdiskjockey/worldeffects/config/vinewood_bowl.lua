-- The key must be same like in Config.MixerList otherwise it wont show in mixer
Config.WorldEffects["Vinewood Bowl"] = {
    effects = {
        {
            label = "Sparklers",
            name = Effects.SPARKLERS,

            ButtonType = ButtonType.BUTTON,

            -- this variable will work only with Button type effects
            RemoveAfterTime = 10000,

            -- this is working for both vanilla unicorn + gabz map aswell
            position = {
                {
                    mixerPosition = vector3(684.02, 571.54, 130.46),
                    particlesPosition = {
                        { pos = vector3(687.64, 567.76, 129.46), rot = vector4(0, 0, 0, 0.6) },
                        { pos = vector3(679.02, 571.07, 129.46), rot = vector4(0, 0, 0, 0.6) },
                        { pos = vector3(681.29, 568.09, 129.46), rot = vector4(0, 0, 0, 0.6) },
                        { pos = vector3(684.18, 567.04, 129.46), rot = vector4(0, 0, 0, 0.6) },
                    }
                },
            },
        },

        {
            label = "Red + Green + Blue firework",
            name = Effects.FIREWORK_ONE,

            ButtonType = ButtonType.BUTTON,

            -- this variable will work only with Button type effects
            RemoveAfterTime = 10000,

            -- this is working for both vanilla unicorn + gabz map aswell
            position = {
                {
                    mixerPosition = vector3(684.02, 571.54, 130.46),
                    particlesPosition = {
                        { pos = vec3(700.347473, 540.134033, 155.183548), rot = vector4(0, 0, 0, 1.0) },
                        { pos = vec3(686.113647, 539.889954, 155.183548), rot = vector4(0, 0, 0, 1.0) },
                        { pos = vec3(670.337769, 545.618713, 155.183548), rot = vector4(0, 0, 0, 1.0) },

                        { pos = vec3(655.340027, 559.352417, 155.183548), rot = vector4(0, 0, 0, 1.0) },
                    }
                },
            },
        },

        {
            label = "White trail + explosion firework",
            name = Effects.FIREWORK_TWO,

            ButtonType = ButtonType.BUTTON,

            -- this variable will work only with Button type effects
            RemoveAfterTime = 10000,

            -- this is working for both vanilla unicorn + gabz map aswell
            position = {
                {
                    mixerPosition = vector3(684.02, 571.54, 130.46),
                    particlesPosition = {
                        { pos = vec3(700.347473, 540.134033, 128.183548), rot = vector4(0, 0, 0, 1.0) },
                        { pos = vec3(686.113647, 539.889954, 128.183548), rot = vector4(0, 0, 0, 1.0) },
                        { pos = vec3(670.337769, 545.618713, 128.183548), rot = vector4(0, 0, 0, 1.0) },
                        { pos = vec3(655.340027, 559.352417, 128.183548), rot = vector4(0, 0, 0, 1.0) },
                    }
                },
            },
        },

        {
            label = "Rainbow color firework explosion",
            name = Effects.FIREWORK_THREE,

            ButtonType = ButtonType.BUTTON,

            -- this variable will work only with Button type effects
            RemoveAfterTime = 10000,

            -- this is working for both vanilla unicorn + gabz map aswell
            position = {
                {
                    mixerPosition = vector3(684.02, 571.54, 130.46),
                    particlesPosition = {
                        { pos = vec3(700.347473, 540.134033, 155.183548), rot = vector4(0, 0, 0, 1.0) },
                        { pos = vec3(686.113647, 539.889954, 155.183548), rot = vector4(0, 0, 0, 1.0) },
                        { pos = vec3(670.337769, 545.618713, 155.183548), rot = vector4(0, 0, 0, 1.0) },

                        { pos = vec3(655.340027, 559.352417, 155.183548), rot = vector4(0, 0, 0, 1.0) },
                    }
                },
            },
        },

        {
            label = "Panel lights",

            identifier = Effects.PANEL_OBJECTS,
            name = { Effects.REMOVE_PANEL, Effects.PANEL_PURPLE, Effects.PANEL_GREEN, Effects.PANEL_PINK },

            ButtonType = ButtonType.LIST,

            position = {
                {
                    mixerPosition = vector3(684.02, 571.54, 130.46),
                    particlesPosition = {
                        { pos = vector3(694.5, 563.5466, 126.465), rot = vector4(0, 0, 250, 0.0) },
                        { pos = vector3(672.8753, 571.6515, 126.465), rot = vector4(0, 0, 250, 0.0) },
                    }
                },
            },
        },
        {
            label = "Neon lights",

            identifier = Effects.NEON_OBJECTS,
            name = { Effects.REMOVE_NEON, Effects.NEON_OBJECT_YELLOW, Effects.NEON_OBJECT_WHITE, Effects.NEON_OBJECT_PURPLE, Effects.NEON_OBJECT_CYAN },

            ButtonType = ButtonType.LIST,

            position = {
                {
                    mixerPosition = vector3(684.02, 571.54, 130.46),
                    particlesPosition = {
                        { pos = vector3(672.5605, 580.397, 122.2647), rot = vector4(0, -50, -25, 0.0) },
                        { pos = vector3(675.7465, 587.7654, 122.3849), rot = vector4(0, -50, -20, 0.0) },

                        { pos = vector3(697.4873, 571.2699, 121.9021), rot = vector4(0, -50, 155, 0.0) },
                        { pos = vector3(700.2397, 579.2167, 121.824), rot = vector4(0, -50, 155, 0.0) },
                    }
                },
            },
        },
        {
            label = "Droplets",

            identifier = Effects.LIGHT_OBJECTS,
            name = { Effects.REMOVE_LIGHT, Effects.LIGHT_OBJECT_YELLOW, Effects.LIGHT_OBJECT_GREEN, Effects.LIGHT_OBJECT_WHITE, Effects.LIGHT_OBJECT_PURPLE },

            ButtonType = ButtonType.LIST,

            position = {
                {
                    mixerPosition = vector3(684.02, 571.54, 130.46),
                    particlesPosition = {
                        { pos = vector3(688.5735, 583.7896, 132.3493), rot = vector4(0, 0, 250, 0.0) },
                    }
                },
            },
        },

        {
            label = "Bands",

            identifier = Effects.BANDS_OBJECTS,
            name = { Effects.REMOVE_BANDS, Effects.BANDS_OBJECT_YELLOW, Effects.BANDS_OBJECT_GREEN, Effects.BANDS_OBJECT_WHITE, Effects.BANDS_OBJECT_CYAN },

            ButtonType = ButtonType.LIST,

            position = {
                {
                    mixerPosition = vector3(684.02, 571.54, 130.46),
                    particlesPosition = {
                        { pos = vector3(678.1111, 584.4409, 134.0), rot = vector4(-90, 0, -24, 0.0) },
                    }
                },
            },
        },
    },
}