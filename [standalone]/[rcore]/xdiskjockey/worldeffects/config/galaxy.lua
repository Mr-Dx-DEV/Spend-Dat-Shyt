-- The key must be same like in Config.MixerList otherwise it wont show in mixer
Config.WorldEffects["Galaxy club"] = {
    effects = {
        {
            label = "Fountain",
            name = Effects.COMET,

            ButtonType = ButtonType.TOGGLE,

            position = {
                {
                    mixerPosition = vector3(-1595, -3012, -79),
                    particlesPosition = {
                        { pos = vector3(-1596.2, -3008.02, -80.8), rot = vector4(-90.0, 0, 0, 1.5) },
                        { pos = vector3(-1598.43, -3015.68, -80.8), rot = vector4(-90.0, 0, 0, 1.5) },
                    }
                },
            },
        },

        {
            label = "RGB",
            name = Effects.RGB,

            ButtonType = ButtonType.TOGGLE,

            -- this is working for both vanilla unicorn + gabz map aswell
            position = {
                {
                    mixerPosition = vector3(-1595, -3012, -79),
                    particlesPosition = {
                        { pos = vector3(-1591, -3009, -79), rot = vector4(0.0, 0, 0, 0.0), intensity = 1.0, lerpColor = 1.0, },
                        { pos = vector3(-1592, -3014, -79), rot = vector4(0.0, 0, 0, 0.0), intensity = 1.0, lerpColor = 2.0, },
                        { pos = vector3(-1599, -3016, -79), rot = vector4(0.0, 0, 0, 0.0), intensity = 1.0, lerpColor = 3.0,},
                        { pos = vector3(-1599, -3009, -79), rot = vector4(0.0, 0, 0, 0.0), intensity = 1.0, lerpColor = 4.0, },
                    }
                },
            },
        },
    },
}

CreateThread(function()
    local breakme = 10
    while not IsResourceOnServer("bob74_ipl") do
        Wait(1000)
        breakme = breakme - 1
        if breakme == 0 then
            return
        end
    end

    table.insert(Config.WorldEffects["Galaxy club"].effects,
            {
                label = "Dry ice",
                name = Effects.GALAXY_SMOKE_FLOOR,

                ButtonType = ButtonType.TOGGLE,

                position = {
                    {
                        mixerPosition = vector3(-1595, -3012, -79),
                        particlesPosition = {},
                    },
                },
            })

    table.insert(Config.WorldEffects["Galaxy club"].effects,
            {
                label = "Lights",

                identifier = Effects.LIGHTS,
                name = { Effects.DISABLE_LIGHTS, Effects.LIGHT_YELLOW, Effects.LIGHT_GREEN, Effects.LIGHT_WHITE, Effects.LIGHT_PURPLE },

                ButtonType = ButtonType.LIST,

                position = {
                    {
                        mixerPosition = vector3(-1595, -3012, -79),
                        particlesPosition = {},
                    },
                },
            })

    table.insert(Config.WorldEffects["Galaxy club"].effects,
            {
                label = "Neons",

                identifier = Effects.NEONS,
                name = { Effects.DISABLE_NEON, Effects.NEON_YELLOW, Effects.NEON_WHITE, Effects.NEON_PURPLE, Effects.NEON_CYAN },

                ButtonType = ButtonType.LIST,

                position = {
                    {
                        mixerPosition = vector3(-1595, -3012, -79),
                        particlesPosition = {},
                    },
                },
            })

    table.insert(Config.WorldEffects["Galaxy club"].effects,
            {
                label = "Lasers",

                identifier = Effects.LASERS,
                name = { Effects.DISABLE_LASER, Effects.LASER_YELLOW, Effects.LASER_GREEN, Effects.LASER_WHITE, Effects.LASER_PURPLE },

                ButtonType = ButtonType.LIST,

                position = {
                    {
                        mixerPosition = vector3(-1595, -3012, -79),
                        particlesPosition = {},
                    },
                },
            })

    table.insert(Config.WorldEffects["Galaxy club"].effects,
            {
                label = "Bands",

                identifier = Effects.BANDS,
                name = { Effects.DISABLE_BANDS, Effects.BANDS_YELLOW, Effects.BANDS_GREEN, Effects.BANDS_WHITE, Effects.BANDS_CYAN },

                ButtonType = ButtonType.LIST,

                position = {
                    {
                        mixerPosition = vector3(-1595, -3012, -79),
                        particlesPosition = {},
                    },
                },
            })
end, "Thread for changing how galaxy club looks")
