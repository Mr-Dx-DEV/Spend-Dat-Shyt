local smokeHeight = 27.6


-- The key must be same like in Config.MixerList otherwise it wont show in mixer
Config.WorldEffects["Bahama Mamas"] = {
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
                    mixerPosition = vec3(-1387.117432, -620.849243, 30.819593),
                    particlesPosition = {
                        { pos = vec3(-1393.696655, -620.059753, 30.338564), rot = vector4(0, 0, 0, 0.1) },
                        { pos = vec3(-1390.913940, -624.091492, 30.338564), rot = vector4(0, 0, 0, 0.1) },
                        { pos = vec3(-1381.507202, -623.405518, 30.338564), rot = vector4(0, 0, 0, 0.1) },
                        { pos = vec3(-1377.970093, -621.085510, 30.338564), rot = vector4(0, 0, 0, 0.1) },
                    }
                },
            },
        },

        {
            label = "Smoke floor",
            name = Effects.SMOKE_FLOOR,

            ButtonType = ButtonType.TOGGLE,

            -- this is working for both vanilla unicorn + gabz map aswell
            position = {
                {
                    mixerPosition = vec3(-1387.117432, -620.849243, 30.819593),
                    particlesPosition = {
                        { pos = vector3(-1390.637451, -618.373779, smokeHeight), rot = vector4(0, 0, 0, 1.2) },
                        { pos = vector3(-1387.608154, -615.676819, smokeHeight), rot = vector4(0, 0, 0, 1.2) },

                        { pos = vector3(-1384.484741, -619.496460, smokeHeight), rot = vector4(0, 0, 0, 1.2) },
                        { pos = vector3(-1387.991943, -621.928711, smokeHeight), rot = vector4(0, 0, 0, 1.2) },

                        { pos = vector3(-1383.476929, -621.997742, smokeHeight), rot = vector4(0, 0, 0, 1.2) },


                        { pos = vector3(-1383.055542, -625.182861, smokeHeight), rot = vector4(0, 0, 0, 1.2) },
                        { pos = vector3(-1380.601563, -623.829224, smokeHeight), rot = vector4(0, 0, 0, 1.2) },
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
                    mixerPosition = vec3(-1387.117432, -620.849243, 30.819593),
                    particlesPosition = {
                        { pos = vec3(-1381.110352, -624.237183, 30.819550), rot = vector4(90, 0, 0, 1.0) },
                        { pos = vec3(-1391.769897, -624.655151, 30.819599), rot = vector4(90, 0, 0, 1.0) },
                        { pos = vec3(-1394.501709, -620.457947, 30.819548), rot = vector4(90, 0, 0, 1.0) },
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
                    mixerPosition = vec3(-1387.117432, -620.849243, 30.819593),
                    particlesPosition = {
                        { pos = vec3(-1381.110352, -624.237183, 30.819550), rot = vector4(90, 0, 0, 1.0) },
                        { pos = vec3(-1391.769897, -624.655151, 30.819599), rot = vector4(90, 0, 0, 1.0) },
                        { pos = vec3(-1394.501709, -620.457947, 30.819548), rot = vector4(90, 0, 0, 1.0) },
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
                    mixerPosition = vec3(-1387.117432, -620.849243, 30.819593),
                    particlesPosition = {
                        { pos = vector3(-1384.255615, -627.097534, 30.812243), rot = vector4(0.0, 0, 0, 0.0), intensity = 10.0, lerpColor = 1.0, },
                        { pos = vector3(-1392.152100, -616.627625, 30.819561), rot = vector4(0.0, 0, 0, 0.0), intensity = 10.0, lerpColor = 2.0, },
                        { pos = vector3(-1384.232788, -617.954529, 30.819561), rot = vector4(0.0, 0, 0, 0.0), intensity = 10.0, lerpColor = 3.0, },
                        { pos = vector3(-1375.515137, -622.712280, 30.819569), rot = vector4(0.0, 0, 0, 0.0), intensity = 10.0, lerpColor = 4.0, },
                    }
                },
            },
        },
    },
}

CreateThread(function()
    local breakme = 10
    while not IsResourceOnServer("cfx-gabz-bahama") do
        Wait(1000)
        breakme = breakme - 1
        if breakme == 0 then
            return
        end
    end

    local subtractSmokeZ = 3
    Config.WorldEffects["Bahama Mamas"] = {
        effects = {
            {
                label = "Smoke floor",
                name = Effects.SMOKE_FLOOR,

                ButtonType = ButtonType.TOGGLE,

                -- this is working for both vanilla unicorn + gabz map aswell
                position = {
                    {
                        mixerPosition = vector3(-1389.32, -615.96, 29.72),
                        particlesPosition = {
                            { pos = vector3(-1385.14, -620.07, 29.72 - subtractSmokeZ), rot = vector4(0, 0, 0, 1.0) },
                            { pos = vector3(-1385.88, -624.24, 29.72 - subtractSmokeZ), rot = vector4(0, 0, 0, 1.0) },
                            { pos = vector3(-1390.67, -622.34, 29.72 - subtractSmokeZ), rot = vector4(0, 0, 0, 1.0) },
                            { pos = vector3(-1393.05, -618.47, 29.72 - subtractSmokeZ), rot = vector4(0, 0, 0, 1.0) },
                            { pos = vector3(-1395.85, -613.79, 29.72 - subtractSmokeZ), rot = vector4(0, 0, 0, 1.0) },
                            { pos = vector3(-1395.56, -609.24, 29.72 - subtractSmokeZ), rot = vector4(0, 0, 0, 1.0) },
                            { pos = vector3(-1391.51, -610.77, 29.72 - subtractSmokeZ), rot = vector4(0, 0, 0, 1.0) },
                            { pos = vector3(-1388.79, -614.94, 29.72 - subtractSmokeZ), rot = vector4(0, 0, 0, 1.0) },
                            { pos = vector3(-1386.21, -618.73, 29.72 - subtractSmokeZ), rot = vector4(0, 0, 0, 1.0) },
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
                        mixerPosition = vector3(-1389.32, -615.96, 29.72),
                        particlesPosition = {
                            { pos = vector3(-1403.74,-602.07,30.7), rot = vector4(0.0, 0, 0, 0.5) },
                            { pos = vector3(-1399.11,-598.92,30.7), rot = vector4(0.0, 0, 0, 0.5) },
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
                        mixerPosition = vector3(-1389.32, -615.96, 29.72),
                        particlesPosition = {
                            { pos = vector3(-1390.86,-616.81,30.83), rot = vector4(90.0, 0, 0, 1.0) },
                            { pos = vector3(-1393.79,-612.29,30.83), rot = vector4(90.0, 0, 0, 1.0) },
                            { pos = vector3(-1387.86,-621.42,30.83), rot = vector4(90.0, 0, 0, 1.0) },
                            { pos = vector3(-1391.33,-632.29,31.08), rot = vector4(90.0, 0, 0, 1.0) },
                            { pos = vector3(-1409.10,-606.85,30.64), rot = vector4(90.0, 0, 0, 1.0) },
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
                        mixerPosition = vector3(-1389.32, -615.96, 29.72),
                        particlesPosition = {
                            { pos = vector3(-1390.86,-616.81,30.83), rot = vector4(90.0, 0, 0, 1.0) },
                            { pos = vector3(-1393.79,-612.29,30.83), rot = vector4(90.0, 0, 0, 1.0) },
                            { pos = vector3(-1387.86,-621.42,30.83), rot = vector4(90.0, 0, 0, 1.0) },
                            { pos = vector3(-1391.33,-632.29,31.08), rot = vector4(90.0, 0, 0, 1.0) },
                            { pos = vector3(-1409.10,-606.85,30.64), rot = vector4(90.0, 0, 0, 1.0) },
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
                        mixerPosition = vector3(-1389.32, -615.96, 29.72),
                        particlesPosition = {
                            -- intensity, how fast the colors are changing
                            { pos = vector3(-1380.72,-609.96,31.51), rot = vector4(0.0, 0, 0, 0.0), intensity = 10.0, lerpColor = 1.0, },
                            { pos = vector3(-1396.17,-620.57,31.07), rot = vector4(0.0, 0, 0, 0.0), intensity = 10.0, lerpColor = 2.0, },
                            { pos = vector3(-1384.76,-626.76,31.07), rot = vector4(0.0, 0, 0, 0.0), intensity = 10.0, lerpColor = 3.0, },
                            { pos = vector3(-1398.25,-605.53,31.07), rot = vector4(0.0, 0, 0, 0.0), intensity = 10.0, lerpColor = 4.0, },
                        }
                    },
                },
            },
        },
    }
end, "thread for checking for certain assets on server and updating the config accordingly")