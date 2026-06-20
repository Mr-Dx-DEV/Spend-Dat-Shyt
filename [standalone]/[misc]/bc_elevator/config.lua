Config = {}

Config.Debug = false
Config.UseDistanceCheck = true
Config.MaxUseDistance = 3.0
Config.CooldownMs = 2500
Config.TravelTimePerFloor = 1200
Config.BaseTravelTime = 1600
Config.UseSounds = true

Config.Elevators = {
    ["pillbox"] = {
        label = "Pillbox Hospital",

        panels = {
            {
                coords = vec3(-950.2013, -278.6956, 39.5928),
                size = vec3(1.2, 1.2, 2.2),
                heading = 29.8423
            },
             {
                coords = vec3(-950.1923, -278.7301, 62.1018),
                size = vec3(1.2, 1.2, 2.2),
                heading = 31.6479
            },
             {
                coords = vec3(-950.2908, -278.8937, 76.2140),
                size = vec3(1.2, 1.2, 2.2),
                heading = 26.2261
            },
           
        },

        floors = {
            {
                id = "lobby_ground",
                label = "Ground Lobby (Floor 1)",
                order = 1,
                coords = vec4(-950.6727, -280.2037, 39.5928, 33.5548),
            },
            {
                id = "lobby_upper",
                label = "Insurance Floor",
                order = 2,
                coords = vec4(-950.4144, -280.2732, 62.1018, 36.7184),
            },
             {
                id = "lobby_upper",
                label = "Real Estate Floor",
                order = 2,
                coords = vec4(-950.9862, -280.0789, 76.2140, 19.0488),
            },
            
        }
    },
}
