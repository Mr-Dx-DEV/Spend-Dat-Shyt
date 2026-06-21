local smokeVanillaHeight = 25.0

-- The key must be same like in Config.MixerList otherwise it wont show in mixer
Config.WorldEffects["vanilla"] = {
    effects = {
        {
            label = "Smoke floor",
            name = Effects.SMOKE_FLOOR,

            ButtonType = ButtonType.TOGGLE,

            -- this is working for both vanilla unicorn + gabz map aswell
            position = {
                {
                    mixerPosition = vector3(120.7, -1281.31, 29.48),
                    particlesPosition = {
                        { pos = vector3(120.546654, -1287.174072, smokeVanillaHeight), rot = vector4(0, 0, 0, 1.3) },
                        { pos = vector3(115.967957, -1289.821289, smokeVanillaHeight), rot = vector4(0, 0, 0, 1.3) },
                        { pos = vector3(110.875992, -1292.411743, smokeVanillaHeight), rot = vector4(0, 0, 0, 1.3) },
                        { pos = vector3(112.447441, -1287.537476, smokeVanillaHeight), rot = vector4(0, 0, 0, 1.3) },
                        { pos = vector3(117.818039, -1284.921875, smokeVanillaHeight), rot = vector4(0, 0, 0, 1.3) },
                        { pos = vector3(112.875534, -1282.247070, smokeVanillaHeight), rot = vector4(0, 0, 0, 1.3) },
                        { pos = vector3(108.287720, -1284.305420, smokeVanillaHeight), rot = vector4(0, 0, 0, 1.3) },
                        { pos = vector3(102.995979, -1286.804565, smokeVanillaHeight), rot = vector4(0, 0, 0, 1.3) },
                    }
                },
            },
        },

        {
            label = "Sparklers",
            name = Effects.SPARKLERS,

            ButtonType = ButtonType.BUTTON,

            -- this variable will work only with Button type effects
            RemoveAfterTime = 10000,

            position = {
                {
                    mixerPosition = vector3(120.7, -1281.31, 29.48),
                    particlesPosition = {
                        { pos = vector3(120.77, -1284.88, 28.9), rot = vector4(0, 0, 0, 0.05) },
                        { pos = vector3(118.74, -1282.65, 28.9), rot = vector4(0, 0, 0, 0.05) },
                        { pos = vector3(121.72, -1286.65, 28.9), rot = vector4(0, 0, 0, 0.05) },
                        { pos = vector3(122.61, -1288.25, 28.9), rot = vector4(0, 0, 0, 0.05) },
                        { pos = vector3(105.9, -1283.39, 28.9), rot = vector4(0, 0, 0, 0.05) },
                        { pos = vector3(102.3, -1285.54, 28.9), rot = vector4(0, 0, 0, 0.05) },
                        { pos = vector3(107.91, -1296.54, 28.9), rot = vector4(0, 0, 0, 0.05) },
                        { pos = vector3(111.72, -1294.15, 28.9), rot = vector4(0, 0, 0, 0.05) },
                    }
                },
            },
        },

        {
            label = "Gold bars",
            name = Effects.YELLOW_BAR,

            ButtonType = ButtonType.TOGGLE,

            position = {
                {
                    mixerPosition = vector3(120.7, -1281.31, 29.48),
                    particlesPosition = {
                        { pos = vector3(112.64, -1287.05, 28.47), rot = vector4(90.0, 0, 0, 1.0) },
                        { pos = vector3(104.16, -1294.31, 29.48), rot = vector4(90.0, 0, 0, 1.0) },
                        { pos = vector3(102.17, -1290.93, 29.48), rot = vector4(90.0, 0, 0, 1.0) },
                    }
                },
            },
        },

        {
            label = "Red bars",
            name = Effects.RED_BAR,

            ButtonType = ButtonType.TOGGLE,

            position = {
                {
                    mixerPosition = vector3(120.7, -1281.31, 29.48),
                    particlesPosition = {
                        { pos = vector3(112.64, -1287.05, 28.47), rot = vector4(90.0, 0, 0, 1.0) },
                        { pos = vector3(104.16, -1294.31, 29.48), rot = vector4(90.0, 0, 0, 1.0) },
                        { pos = vector3(102.17, -1290.93, 29.48), rot = vector4(90.0, 0, 0, 1.0) },
                    }
                },
            },
        },

        {
            label = "Fountain",
            name = Effects.COMET,

            ButtonType = ButtonType.TOGGLE,

            position = {
                {
                    mixerPosition = vector3(120.7, -1281.31, 29.48),
                    particlesPosition = {
                        { pos = vector3(112.85, -1289.78, 31.3), rot = vector4(90.0, 0, 0, 0.5) },
                        { pos = vector3(110.3, -1285.54, 31.3), rot = vector4(90.0, 0, 0, 0.5) },
                    }
                },
            },
        },

        {
            label = "RGB",
            name = Effects.RGB,

            ButtonType = ButtonType.TOGGLE,

            position = {
                {
                    mixerPosition = vector3(120.7, -1281.31, 29.48),
                    particlesPosition = {
                        { pos = vector3(119.12, -1287.76, 29.0), rot = vector4(0.0, 0, 0, 0.0), intensity = 1.0, lerpColor = 1.0, },
                        { pos = vector3(116.07, -1282.66, 29.0), rot = vector4(0.0, 0, 0, 0.0), intensity = 1.0, lerpColor = 2.0, },
                        { pos = vector3(111.01, -1292.48, 29.0), rot = vector4(0.0, 0, 0, 0.0), intensity = 1.0, lerpColor = 3.0, },
                        { pos = vector3(105.51, -1285.7, 29.0), rot = vector4(0.0, 0, 0, 0.0), intensity = 1.0, lerpColor = 4.0, },
                    }
                },
            },
        },
    },
}

CreateThread(function()
    local breakme = 10
    while not IsResourceOnServer("cfx-gabz-vu") do
        Wait(1000)
        breakme = breakme - 1
        if breakme == 0 then
            return
        end
    end

    Config.WorldEffects["vanilla"] = {
        effects = {
            {
                label = "Smoke floor",
                name = Effects.SMOKE_FLOOR,

                ButtonType = ButtonType.TOGGLE,

                -- this is working for both vanilla unicorn + gabz map aswell
                position = {
                    {
                        mixerPosition = vector3(120.7, -1281.31, 29.48),
                        particlesPosition = {
                            { pos = vector3(120.17, -1288.24, smokeVanillaHeight), rot = vector4(0, 0, 0, 1.0) },
                            { pos = vector3(122.22, -1292.15, smokeVanillaHeight), rot = vector4(0, 0, 0, 1.0) },
                            { pos = vector3(119.81, -1293.62, smokeVanillaHeight), rot = vector4(0, 0, 0, 1.0) },
                            { pos = vector3(117.6, -1288.08, smokeVanillaHeight), rot = vector4(0, 0, 0, 1.0) },
                            { pos = vector3(115.69, -1296.02, smokeVanillaHeight), rot = vector4(0, 0, 0, 1.0) },
                            { pos = vector3(111.74, -1297.89, smokeVanillaHeight), rot = vector4(0, 0, 0, 1.0) },
                            { pos = vector3(108.69, -1300.3, smokeVanillaHeight), rot = vector4(0, 0, 0, 1.0) },
                            { pos = vector3(112.87, -1287.05, smokeVanillaHeight), rot = vector4(0, 0, 0, 1.0) },
                            { pos = vector3(109.57, -1289.73, smokeVanillaHeight), rot = vector4(0, 0, 0, 1.0) },
                            { pos = vector3(106.8, -1291.01, smokeVanillaHeight), rot = vector4(0, 0, 0, 1.0) },
                            { pos = vector3(103.51, -1292.55, smokeVanillaHeight), rot = vector4(0, 0, 0, 1.0) },
                            { pos = vector3(114.77, -1291.05, smokeVanillaHeight), rot = vector4(0, 0, 0, 1.0) },
                        }
                    },
                },
            },

            {
                label = "Sparklers",
                name = Effects.SPARKLERS,

                ButtonType = ButtonType.BUTTON,

                -- this variable will work only with Button type effects
                RemoveAfterTime = 10000,

                position = {
                    {
                        mixerPosition = vector3(120.7, -1281.31, 29.48),
                        particlesPosition = {
                            { pos = vector3(115.862991, -1286.881714, 28.4), rot = vector4(0, 0, 0, 0.05) },
                            { pos = vector3(117.535698, -1282.966675, 28.4), rot = vector4(0, 0, 0, 0.05) },
                            { pos = vector3(112.757103, -1283.085205, 28.4), rot = vector4(0, 0, 0, 0.05) },
                        }
                    },
                },
            },

            {
                label = "Gold bars",
                name = Effects.YELLOW_BAR,

                ButtonType = ButtonType.TOGGLE,

                position = {
                    {
                        mixerPosition = vector3(120.7, -1281.31, 29.48),
                        particlesPosition = {
                            { pos = vector3(108.853439, -1289.231567, 29.249727), rot = vector4(90.0, 0, 0, 1.0) },
                            { pos = vector3(104.848686, -1294.414673, 29.249680), rot = vector4(90.0, 0, 0, 1.0) },
                            { pos = vector3(102.344284, -1290.051147, 29.249685), rot = vector4(90.0, 0, 0, 1.0) },
                        }
                    },
                },
            },

            {
                label = "Red bars",
                name = Effects.RED_BAR,

                ButtonType = ButtonType.TOGGLE,

                position = {
                    {
                        mixerPosition = vector3(120.7, -1281.31, 29.48),
                        particlesPosition = {
                            { pos = vector3(108.853439, -1289.231567, 29.249727), rot = vector4(90.0, 0, 0, 1.0) },
                            { pos = vector3(104.848686, -1294.414673, 29.249680), rot = vector4(90.0, 0, 0, 1.0) },
                            { pos = vector3(102.344284, -1290.051147, 29.249685), rot = vector4(90.0, 0, 0, 1.0) },
                        }
                    },
                },
            },

            {
                label = "Fountain",
                name = Effects.COMET,

                ButtonType = ButtonType.TOGGLE,

                position = {
                    {
                        mixerPosition = vector3(120.7, -1281.31, 29.48),
                        particlesPosition = {
                            { pos = vector3(112.85, -1289.78, 31.3), rot = vector4(90.0, 0, 0, 0.5) },
                            { pos = vector3(110.3, -1285.54, 31.3), rot = vector4(90.0, 0, 0, 0.5) },
                        }
                    },
                },
            },

            {
                label = "RGB",
                name = Effects.RGB,

                ButtonType = ButtonType.TOGGLE,

                position = {
                    {
                        mixerPosition = vector3(120.7, -1281.31, 29.48),
                        particlesPosition = {
                            -- intensity, how fast the colors are changing
                            { pos = vector3(119.12, -1287.76, 29.0), rot = vector4(0.0, 0, 0, 0.0), intensity = 10.0, lerpColor = 1.0, },
                            { pos = vector3(116.07, -1282.66, 29.0), rot = vector4(0.0, 0, 0, 0.0), intensity = 10.0, lerpColor = 2.0, },
                            { pos = vector3(111.01, -1292.48, 29.0), rot = vector4(0.0, 0, 0, 0.0), intensity = 10.0, lerpColor = 3.0, },
                            { pos = vector3(105.51, -1285.7, 29.0), rot = vector4(0.0, 0, 0, 0.0), intensity = 10.0, lerpColor = 4.0, },
                        }
                    },
                },
            },
        },
    }
end,"thread for checking for certain assets on server and updating the config accordingly")