return {
    checkInCost = 2000, -- Price for using the hospital check-in system
    minForCheckIn = 2, -- Minimum number of people with the ambulance job to prevent the check-in system from being used

    locations = { -- Various interaction points
        duty = {
            vec3(311.18, -599.25, 43.29),
            vec3(-254.88, 6324.5, 32.58),
        },
        vehicle = {
            vec4(294.578, -574.761, 43.179, 35.79),
            vec4(-234.28, 6329.16, 32.15, 222.5),
        },
        helicopter = {
            vec4(351.58, -587.45, 74.16, 160.5),
            vec4(-475.43, 5988.353, 31.716, 31.34),
        },
        armory = {
            {
                shopType = 'AmbulanceArmory',
                name = 'Armory',
                groups = { ambulance = 0 },
                inventory = {
                    { name = 'radio', price = 0 },
                    { name = 'bandage', price = 0 },
                    { name = 'painkillers', price = 0 },
                    { name = 'firstaid', price = 0 },
                     { name = 'crutch', price = 0 },
                    { name = 'wheelchair', price = 0 },
                    { name = 'weapon_flashlight', price = 0 },
                    { name = 'weapon_fireextinguisher', price = 0 },
                },
                locations = {
                    vec3(299.3413, -599.8958, 43.1961)
                }
            }
        },
        roof = {
            vec3(338.54, -583.88, 74.17),
        },
        main = {
            vec3(298.62, -599.66, 43.29),
        },
        stash = {
            {
                name = 'ambulanceStash',
                label = 'Personal stash',
                weight = 100000,
                slots = 30,
                groups = { ambulance = 0 },
                owner = true, -- Set to false for group stash
                location = vec3(309.5392, -604.0244, 43.1961)
            }
        },

        ---@class Bed
        ---@field coords vector4
        ---@field model number

        ---@type table<string, {coords: vector3, checkIn?: vector3|vector3[], beds: Bed[]}>
        hospitals = {
            pillbox = {
                coords = vec3(350, -580, 43),
                checkIn = vec3(315.4744, -595.7088, 43.1923),
                beds = {
                    {coords = vec4(310.1938, -561.0402, 44.1247, 157.9740), model = 1631638868},
                    {coords = vec4(313.3704, -562.2919, 44.1247, 152.0741), model = 1631638868},
                    {coords = vec4(316.6768, -563.2911, 44.1247, 150.6588), model = 2117668672},
                },
            },
           
        },

        stations = {
            {label = 'Pillbox Hospital', coords = vec4(304.27, -600.33, 43.28, 272.249)},
        }
    },
}