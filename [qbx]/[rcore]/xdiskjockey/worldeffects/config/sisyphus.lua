-- The key must be same like in Config.MixerList otherwise it wont show in mixer
Config.WorldEffects["Sisyphus"] = {
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
                    mixerPosition = vec3(182.712463, 1160.771729, 227.126358),
                    particlesPosition = {
                        { pos = vec3(196.701843, 1171.063965, 226.009567), rot = vector4(0, 0, 0, 0.6) },
                        { pos = vec3(199.472443, 1159.847412, 226.009506), rot = vector4(0, 0, 0, 0.6) },
                        { pos = vec3(195.663055, 1162.590698, 226.009476), rot = vector4(0, 0, 0, 0.6) },
                        { pos = vec3(194.689987, 1166.990234, 226.009476), rot = vector4(0, 0, 0, 0.6) },
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
                    mixerPosition = vec3(182.712463, 1160.771729, 227.126358),
                    particlesPosition = {
                        { pos = vec3(187.264450, 1134.497192, 252.584473), rot = vector4(0, 0, 0, 1.0) },
                        { pos = vec3(178.495178, 1148.593018, 252.584473), rot = vector4(0, 0, 0, 1.0) },
                        { pos = vec3(171.926300, 1168.437500, 252.584473), rot = vector4(0, 0, 0, 1.0) },

                        { pos =  vec3(176.387054, 1190.660156, 252.584473), rot = vector4(0, 0, 0, 1.0) },
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
                    mixerPosition = vec3(182.712463, 1160.771729, 227.126358),
                    particlesPosition = {
                        { pos = vec3(171.230469, 1182.226074, 225.994247), rot = vector4(0, 0, 0, 1.0) },
                        { pos = vec3(172.023270, 1167.036377, 225.994263), rot = vector4(0, 0, 0, 1.0) },
                        { pos = vec3(175.797562, 1152.129639, 225.994263), rot = vector4(0, 0, 0, 1.0) },
                        { pos =  vec3(182.117676, 1138.716064, 225.993896), rot = vector4(0, 0, 0, 1.0) },
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
                    mixerPosition = vec3(182.712463, 1160.771729, 227.126358),
                    particlesPosition = {
                        { pos = vec3(700.347473, 540.134033, 155.183548), rot = vector4(0, 0, 0, 1.0) },
                        { pos = vec3(686.113647, 539.889954, 155.183548), rot = vector4(0, 0, 0, 1.0) },
                        { pos = vec3(670.337769, 545.618713, 155.183548), rot = vector4(0, 0, 0, 1.0) },

                        { pos =  vec3(655.340027, 559.352417, 155.183548), rot = vector4(0, 0, 0, 1.0) },
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
                    mixerPosition = vec3(182.712463, 1160.771729, 227.126358),
                    particlesPosition = {
                        { pos = vector3(192.908463, 1175.37427, 223.765289), rot = vector4(0, 0, -167, 0.0) },
                        { pos = vector3(198.21344, 1152.95337, 223.765289), rot = vector4(0, 0, -167, 0.0) },
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
                    mixerPosition = vec3(182.712463, 1160.771729, 227.126358),
                    particlesPosition = {
                        { pos = vector3(193.5376, 1185.895, 217.681), rot = vector4(180, -90, 15, 0.0) },
                        { pos = vector3(203.3371, 1144.991, 217.6584), rot = vector4(180, -90, 15, 0.0) },
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
                    mixerPosition = vec3(182.712463, 1160.771729, 227.126358),
                    particlesPosition = {
                        { pos = vector3(213.119, 1178.455, 226.6152), rot = vector4(0, 0, 195, 0.0) },
                        { pos = vector3(215.8766, 1168.522, 226.6152), rot = vector4(0, 0, 195, 0.0) },
                        { pos = vector3(218.5921, 1158.742, 226.6152), rot = vector4(0, 0, 195, 0.0) },
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
                    mixerPosition = vec3(182.712463, 1160.771729, 227.126358),
                    particlesPosition = {
                        { pos = vector3(206.105591, 1177.97156, 229.9974), rot = vector4(-90, 0, -80, 0.0) },
                    }
                },
            },
        },
    },
}