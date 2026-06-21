return {
    {
        Blip = {
            label = "Rent",
            coords = vector3(-809.7993, -2415.1545, 14.7550),
            sprite = 227,
            color = 3,
            scale = 0.7,
            shortRange = true
        },
        Return = {
            ped = "s_m_y_airworker",
            coord = vector4(-788.0145, -2408.8877, 14.5707, 17.6034),
            marker = {
                radius = 20.0,
                type = 21,
                size = vector3(1.0, 1.0, 1.0),
                animated = true,
                color = {
                    r = 199,
                    g = 246,
                    b = 108,
                    a = 100
                }
            },
            returnZone = {
                height = 5.0,
                points = {
                    vector3(228.5157, -756.4479, 34.8539),
                    vector3(219.1872, -753.2778, 34.8391),
                    vector3(221.5695, -746.8062, 34.6440),
                    vector3(230.8242, -750.0836, 34.6264)
                }
            }
        },
        Vehicles = {
            {
                model = "sultan",
                coords = vector4(233.8379, -739.3013, 34.5784, 159.0240),
                hourPrice = 30
            },
            {
                model = "sultanrs",
                coords = vector4(237.1670, -740.2575, 34.5981, 163.1255),
                hourPrice = 60
            },
             {
                model = "reg15",
                coords = vector4(237.1670, -740.2575, 34.5981, 163.1255),
                hourPrice = 150
            },
             {
                model = "malibu",
                coords = vector4(237.1670, -740.2575, 34.5981, 163.1255),
                hourPrice = 150
            },
        }
    }
}