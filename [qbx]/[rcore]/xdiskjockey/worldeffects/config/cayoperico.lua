local smokeHeight = -0.6

-- The key must be same like in Config.MixerList otherwise it wont show in mixer
Config.WorldEffects["Cayo Perico"] = {
    effects = {
        {
            label = "Smoke floor",
            name = Effects.SMOKE_FLOOR,

            ButtonType = ButtonType.TOGGLE,

            position = {
                {
                    mixerPosition = vector3(4893.1821289062, -4924.6953125, 4.0),
                    particlesPosition = {
                        { pos = vector3(4890.0864257812, -4917.3823242188, smokeHeight), rot = vector4(0, 0, 0, 1.3) },
                        { pos = vector3(4895.6845703125, -4918.0825195312, smokeHeight), rot = vector4(0, 0, 0, 1.3) },
                        { pos = vector3(4894.990234375, -4923.0307617188, smokeHeight), rot = vector4(0, 0, 0, 1.3) },
                        { pos = vector3(4888.9438476562, -4921.349609375, smokeHeight), rot = vector4(0, 0, 0, 1.3) },
                        { pos = vector3(4885.6171875, -4925.5087890625, smokeHeight), rot = vector4(0, 0, 0, 1.3) },
                        { pos = vector3(4890.6284179688, -4928.5913085938, smokeHeight), rot = vector4(0, 0, 0, 1.3) },
                        { pos = vector3(4897.3559570312, -4928.4467773438, smokeHeight), rot = vector4(0, 0, 0, 1.3) },
                        { pos = vector3(4895.1821289062, -4933.8295898438, smokeHeight), rot = vector4(0, 0, 0, 1.3) },
                        { pos = vector3(4899.9555664062, -4911.2080078125, smokeHeight), rot = vector4(0, 0, 0, 1.3) },
                        { pos = vector3(4894.2309570312, -4911.009765625, smokeHeight), rot = vector4(0, 0, 0, 1.3) },
                        { pos = vector3(4886.6372070312, -4911.4619140625, smokeHeight), rot = vector4(0, 0, 0, 1.3) },
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
                    mixerPosition = vector3(4893.1821289062, -4924.6953125, 4.0),
                    particlesPosition = {
                        { pos = vector3(4901.2495117188, -4923.3696289062, 3.0), rot = vector4(0.0, 0, 0, 0.2) },
                        { pos = vector3(4883.5708007812, -4915.4770507812, 3.0), rot = vector4(0.0, 0, 0, 0.2) },
                        { pos = vector3(4888.1665039062, -4934.4267578125, 3.0), rot = vector4(0.0, 0, 0, 0.2) },

                        { pos = vector3(4908.3974609375, -4934.3471679688, 3.0), rot = vector4(0.0, 0, 0, 0.2) },
                        { pos = vector3(4897.9536132812, -4939.2265625, 3.0), rot = vector4(0.0, 0, 0, 0.2) },
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
                    mixerPosition = vector3(4893.1821289062, -4924.6953125, 4.0),
                    particlesPosition = {
                        { pos = vector3(4891.86328125, -4911.841796875, 3.9), rot = vector4(0.0, 0, 0, 0.0), intensity = 1.0, lerpColor = 1.0, },
                        { pos = vector3(4891.5249023438, -4921.947265625, 3.9), rot = vector4(0.0, 0, 0, 0.0), intensity = 1.0, lerpColor = 2.0, },
                        { pos = vector3(4899.3701171875, -4934.4067382812, 3.9), rot = vector4(0.0, 0, 0, 0.0), intensity = 1.0, lerpColor = 3.0, },
                        { pos = vector3(4881.8911132812, -4925.4243164062, 3.9), rot = vector4(0.0, 0, 0, 0.0), intensity = 1.0, lerpColor = 4.0, },
                    }
                },
            },
        },
    },
}