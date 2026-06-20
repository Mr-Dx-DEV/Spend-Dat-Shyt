Config = {}

Config.Locale = "en" -- Language for the notifications (en, es, etc.) All languages are in the locales folder
Config.EnableMaxPuffs = true -- Enable max puffs for vapes
Config.ShowNotifications = true -- Show notifications when using the vape
Config.SpeedVapeInfiniteStamina = true -- Enable infinite stamina during speed_vape effect

Config.RemoveVapeCommand = "vape" -- Command name to remove the vape (e.g., 'vape', 'quitvape')
Config.PuffKey = "E" -- Default key to puff the vape (keyboard)

Config.StaticHealth = false -- If true, health vape will cap at Config.Health value; if false, health will stack
Config.StaticArmor = true -- If true, armor vape will cap at Config.Armor value; if false, armor will stack
Config.Health = 10 -- Maximum or incremental health added by health IF Config.StaticHealth = false put 1 - 100 if true put 101 - 200 
Config.Armor = 10 -- Maximum or incremental armor added by armor vape

-- Smoke Configuration
Config.VapeExhale = 0.4 -- Time to exhale the smoke in seconds
Config.SmokeOpacity = 1.0 -- Opacity of the smoke (0.0 to 1.0)
Config.SmokeDelay = 1.5 -- Delay between smoke puffs in seconds
Config.DisableCombatButtons = true -- Disable combat buttons when using the vape
Config.Stress = true -- Enable stress effect for all vapes. The logic is now in bridge/client.lua
-- Vape Configurations
Config.Vapes = {
    -- EXAMPLE VAPE THIS DON'T EXISTS
    ["example_vape"] = {
        prop = "mic_purple", -- Color of the Vape Prop (mic_purple, mic_red, mic_green, mic_blue, mic_yellow, mic_orange, mic_black, mic_lightblue, mic_pink)
        EffectDuration = 69, -- Duration of the effect in seconds
        ShowProgress = true, -- Show progress bar when using the vape
        Label = "Example Vape", -- Label of the vape
        SmokeColor = {R = 156, G = 39, B = 176}, -- Color of the smoke
        SmokeColor = "Rainbow", -- This is for rainbow smoke
        Cooldown = 5, -- Cooldown of the vape puff in seconds
        puffs = 10 -- Number of puffs before the vape runs out
    },
    ["vape_custom"] = {
        prop = "mic_purple",
        EffectDuration = 5,
        ShowProgress = true,
        Label = "Custom Vape",
        SmokeColor = {R = 156, G = 39, B = 176},
        Cooldown = 5,
        puffs = 10,
        power = {
            health = 10,
            armor = 10,
            speed_vape = 10
        }
    },
    -- Super Power Vapes
    ["invisibility_vape"] = {
        prop = "mic_purple",
        EffectDuration = 5,
        ShowProgress = true,
        Label = "Invisibility Vape",
        SmokeColor = {R = 156, G = 39, B = 176},
        Cooldown = 5,
        puffs = 10
    },
    ["speed_vape"] = {
        prop = "mic_red",
        EffectDuration = 15,
        SpeedMultiplier = 1.49,
        ShowProgress = true,
        Label = "Speed Vape",
        SmokeColor = {R = 244, G = 67, B = 54},
        Cooldown = 5,
        puffs = 10
    },
    ["superjump_vape"] = {
        prop = "mic_green",
        EffectDuration = 5,
        ShowProgress = true,
        Label = "Super Jump Vape",
        SmokeColor = {R = 76, G = 175, B = 80},
        Cooldown = 5,
        puffs = 10
    },
    ["teleport_vape"] = {
        prop = "mic_blue",
        EffectDuration = 5,
        ShowProgress = false,
        Label = "Teleport Vape",
        SmokeColor = {R = 33, G = 150, B = 243},
        Cooldown = 5,
        puffs = 10
    },
    ["invincibility_vape"] = {
        prop = "mic_yellow",
        EffectDuration = 5,
        ShowProgress = true,
        Label = "Invincibility Vape",
        SmokeColor = {R = 255, G = 235, B = 59},
        Cooldown = 5,
        puffs = 10
    },
    ["health_vape"] = {
        prop = "mic_orange",
        EffectDuration = 5,
        ShowProgress = false,
        Label = "Health Vape",
        SmokeColor = {R = 255, G = 152, B = 0},
        Cooldown = 1,
        puffs = 10
    },
    ["random_vape"] = {
        prop = "mic_black",
        EffectDuration = 5,
        ShowProgress = true,
        Label = "Random Vape",
        SmokeColor = "Rainbow",
        Cooldown = 5,
        puffs = 10
    },
    ["armor_vape"] = {
        prop = "mic_lightblue",
        EffectDuration = 0,
        ShowProgress = false,
        Label = "Armor Vape",
        SmokeColor = {R = 70, G = 130, B = 180},
        Cooldown = 1,
        puffs = 10
    },
    ["carspeed_vape"] = {
        prop = "mic_white",
        EffectDuration = 5,
        SpeedMultiplier = 2.0,
        ShowProgress = true,
        Label = "Car Speed Vape",
        SmokeColor = {R = 255, G = 255, B = 255},
        Cooldown = 10,
        puffs = 10
    },

    -- Vape Flavors
    ["premo"] = {
        prop = "mic_black",
        EffectDuration = 0,
        ShowProgress = false,
        Label = "Premo",
        SmokeColor = {R = 255, G = 255, B = 255},
        Cooldown = 0,
        puffs = 20
    },
    ["fuego"] = {
        prop = "mic_red",
        EffectDuration = 0,
        ShowProgress = false,
        Label = "Fuego",
        SmokeColor = {R = 255, G = 0, B = 0},
        Cooldown = 0,
        puffs = 20
    },
    ["vape_mango"] = {
        prop = "mic_yellow",
        EffectDuration = 0,
        ShowProgress = false,
        Label = "Mango Vape",
        SmokeColor = {R = 255, G = 255, B = 0},
        Cooldown = 0,
        puffs = 2
    },
    ["wolf_za"] = {
        prop = "mic_green",
        EffectDuration = 0,
        ShowProgress = false,
        Label = "Blueberry Vape",
        SmokeColor = {R = 0, G = 255, B = 0},
        Cooldown = 0,
        puffs = 20
    },
    ["pink_cocaine"] = {
        prop = "mic_pink",
        EffectDuration = 0,
        ShowProgress = false,
        Label = "Pink Cocaine",
        SmokeColor = {R = 255, G = 105, B = 180},
        Cooldown = 0,
        puffs = 10
        
    },
    ["vape_pineapple"] = {
        prop = "mic_orange",
        EffectDuration = 0,
        ShowProgress = false,
        Label = "Pineapple Vape",
        SmokeColor = {R = 255, G = 165, B = 0},
        Cooldown = 0,
        puffs = 20
    },
    ["dirty_diana"] = {
        prop = "mic_purple",
        EffectDuration = 0,
        ShowProgress = false,
        Label = "Dirty Diana",
        SmokeColor = {R = 128, G = 0, B = 128},
        Cooldown = 0,
        puffs = 20
    },
    ["vape_cherry"] = {
        prop = "mic_lightblue",
        EffectDuration = 0,
        ShowProgress = false,
        Label = "Cherry Vape",
        SmokeColor = {R = 135, G = 206, B = 250},
        Cooldown = 0,
        puffs = 20
    },
    ["vape_lime"] = {
        prop = "mic_green",
        EffectDuration = 0,
        ShowProgress = false,
        Label = "Lime Vape",
        SmokeColor = {R = 0, G = 255, B = 0},
        Cooldown = 0,
        puffs = 20
    },
    ["vape_coconut"] = {
        prop = "mic_white",
        EffectDuration = 0,
        ShowProgress = false,
        Label = "Coconut Vape",
        SmokeColor = {R = 255, G = 255, B = 255},
        Cooldown = 0,
        puffs = 20
    },
    ["vape_raspberry"] = {
        prop = "mic_black",
        EffectDuration = 0,
        ShowProgress = false,
        Label = "Raspberry Vape",
        SmokeColor = {R = 0, G = 0, B = 0},
        Cooldown = 0,
        puffs = 20
    },
    ["vape_peach"] = {
        prop = "mic_pink",
        EffectDuration = 0,
        ShowProgress = false,
        Label = "Peach Vape",
        SmokeColor = {R = 255, G = 218, B = 185},
        Cooldown = 0,
        puffs = 20
    },
    ["premo"] = {
        prop = "mic_green",
        EffectDuration = 0,
        ShowProgress = false,
        Label = "Premo",
        SmokeColor = {R = 0, G = 128, B = 128},
        Cooldown = 0,
        puffs = 20
    },
    ["vape_vanilla"] = {
        prop = "mic_white",
        EffectDuration = 0,
        ShowProgress = false,
        Label = "Vanilla Vape",
        SmokeColor = {R = 245, G = 245, B = 220},
        Cooldown = 0,
        puffs = 20
    },
    ["vape_lemon"] = {
        prop = "mic_yellow",
        EffectDuration = 0,
        ShowProgress = false,
        Label = "Lemon Vape",
        SmokeColor = {R = 255, G = 255, B = 102},
        Cooldown = 0,
        puffs = 20
    },
    ["vape_banana"] = {
        prop = "mic_orange",
        EffectDuration = 0,
        ShowProgress = false,
        Label = "Banana Vape",
        SmokeColor = {R = 255, G = 239, B = 0},
        Cooldown = 0,
        puffs = 20
    },
    ["vape_apple"] = {
        prop = "mic_red",
        EffectDuration = 0,
        ShowProgress = false,
        Label = "Apple Vape",
        SmokeColor = {R = 199, G = 21, B = 133},
        Cooldown = 0,
        puffs = 20
    },
    ["vape_kiwi"] = {
        prop = "mic_green",
        EffectDuration = 0,
        ShowProgress = false,
        Label = "Kiwi Vape",
        SmokeColor = {R = 50, G = 205, B = 50},
        Cooldown = 0,
        puffs = 20
    },
    ["vape_caramel"] = {
        prop = "mic_purple",
        EffectDuration = 0,
        ShowProgress = false,
        Label = "Caramel Vape",
        SmokeColor = {R = 210, G = 105, B = 30},
        Cooldown = 0,
        puffs = 20
    },
    ["vape_cinnamon"] = {
        prop = "mic_lightblue",
        EffectDuration = 0,
        ShowProgress = false,
        Label = "Cinnamon Vape",
        SmokeColor = {R = 165, G = 42, B = 42},
        Cooldown = 0,
        puffs = 20
    },
    ["vape_honey"] = {
        prop = "mic_black",
        EffectDuration = 0,
        ShowProgress = false,
        Label = "Honey Vape",
        SmokeColor = {R = 255, G = 215, B = 0},
        Cooldown = 0,
        puffs = 20
    },
    ["vape_pear"] = {
        prop = "mic_green",
        EffectDuration = 0,
        ShowProgress = false,
        Label = "Pear Vape",
        SmokeColor = {R = 154, G = 205, B = 50},
        Cooldown = 0,
        puffs = 20
    },
    ["vape_cranberry"] = {
        prop = "mic_red",
        EffectDuration = 0,
        ShowProgress = false,
        Label = "Cranberry Vape",
        SmokeColor = {R = 139, G = 0, B = 0},
        Cooldown = 0,
        puffs = 20
    },
    ["vape_coffee"] = {
        prop = "mic_black",
        EffectDuration = 0,
        ShowProgress = false,
        Label = "Coffee Vape",
        SmokeColor = {R = 139, G = 69, B = 19},
        Cooldown = 0,
        puffs = 20
    },
    ["vape_pomegranate"] = {
        prop = "mic_purple",
        EffectDuration = 0,
        ShowProgress = false,
        Label = "Pomegranate Vape",
        SmokeColor = {R = 153, G = 0, B = 76},
        Cooldown = 0,
        puffs = 20
    },
    ["vape_tangerine"] = {
        prop = "mic_orange",
        EffectDuration = 0,
        ShowProgress = false,
        Label = "Tangerine Vape",
        SmokeColor = {R = 255, G = 140, B = 0},
        Cooldown = 0,
        puffs = 20
    },
    ["vape_chocolate"] = {
        prop = "mic_pink",
        EffectDuration = 0,
        ShowProgress = false,
        Label = "Chocolate Vape",
        SmokeColor = {R = 92, G = 64, B = 51},
        Cooldown = 0,
        puffs = 20
    },
    ["vape_guava"] = {
        prop = "mic_lightblue",
        EffectDuration = 0,
        ShowProgress = false,
        Label = "Guava Vape",
        SmokeColor = {R = 255, G = 182, B = 193},
        Cooldown = 0,
        puffs = 20
    },
    ["vape_toffee"] = {
        prop = "mic_yellow",
        EffectDuration = 0,
        ShowProgress = false,
        Label = "Toffee Vape",
        SmokeColor = {R = 184, G = 134, B = 11},
        Cooldown = 0,
        puffs = 20
    },
    ["vape_blackberry"] = {
        prop = "mic_blue",
        EffectDuration = 0,
        ShowProgress = false,
        Label = "Blackberry Vape",
        SmokeColor = {R = 75, G = 0, B = 130},
        Cooldown = 0,
        puffs = 20
    },
    ["vape_apricot"] = {
        prop = "mic_white",
        EffectDuration = 0,
        ShowProgress = false,
        Label = "Apricot Vape",
        SmokeColor = {R = 255, G = 191, B = 128},
        Cooldown = 0,
        puffs = 20
    },
    ["vape_plum"] = {
        prop = "mic_purple",
        EffectDuration = 0,
        ShowProgress = false,
        Label = "Plum Vape",
        SmokeColor = {R = 106, G = 13, B = 173},
        Cooldown = 0,
        puffs = 20
    },
    ["vape_passionfruit"] = {
        prop = "mic_yellow",
        EffectDuration = 0,
        ShowProgress = false,
        Label = "Passionfruit Vape",
        SmokeColor = {R = 255, G = 207, B = 32},
        Cooldown = 0,
        puffs = 20
    },
    ["vape_lychee"] = {
        prop = "mic_white",
        EffectDuration = 0,
        ShowProgress = false,
        Label = "Lychee Vape",
        SmokeColor = {R = 255, G = 240, B = 245},
        Cooldown = 0,
        puffs = 20
    },
    ["vape_dragonfruit"] = {
        prop = "mic_pink",
        EffectDuration = 0,
        ShowProgress = false,
        Label = "Dragonfruit Vape",
        SmokeColor = {R = 199, G = 21, B = 133},
        Cooldown = 0,
        puffs = 20
    },
    ["vape_paella"] = {
        prop = "mic_yellow",
        EffectDuration = 0,
        ShowProgress = false,
        Label = "Paella Vape",
        SmokeColor = {R = 255, G = 255, B = 0},
        Cooldown = 0,
        puffs = 2
    },
    ["vape_cucumber"] = {
        prop = "mic_green",
        EffectDuration = 0,
        ShowProgress = false,
        Label = "Cucumber Vape",
        SmokeColor = {R = 124, G = 252, B = 0},
        Cooldown = 0,
        puffs = 20
    },
    ["vape_berrymix"] = {
        prop = "mic_blue",
        EffectDuration = 0,
        ShowProgress = false,
        Label = "Berry Mix Vape",
        SmokeColor = {R = 138, G = 43, B = 226},
        Cooldown = 0,
        puffs = 20
    },
    ["vape_hazelnut"] = {
        prop = "mic_orange",
        EffectDuration = 0,
        ShowProgress = false,
        Label = "Hazelnut Vape",
        SmokeColor = {R = 149, G = 69, B = 53},
        Cooldown = 0,
        puffs = 20
    },
    ["vape_melon"] = {
        prop = "mic_red",
        EffectDuration = 0,
        ShowProgress = false,
        Label = "Melon Vape",
        SmokeColor = {R = 240, G = 128, B = 128},
        Cooldown = 0,
        puffs = 20
    },
    ["vape_ginger"] = {
        prop = "mic_lightblue",
        EffectDuration = 0,
        ShowProgress = false,
        Label = "Ginger Vape",
        SmokeColor = {R = 255, G = 245, B = 157},
        Cooldown = 0,
        puffs = 1
    }
}

-- Particle Configuration
Config.Particle = {
    dict = "scr_recartheft",
    name = "scr_wheel_burnout"
}

-- Smoke Particle Offsets (position where the smoke comes out from the mouth)
Config.SmokeOffset = {
    PosX = 0.05,  -- Forward/backward offset
    PosY = 0.0,   -- Left/right offset
    PosZ = 0.5,   -- Up/down offset
    RotX = 0.0,   -- X rotation
    RotY = 0.0,   -- Y rotation
    RotZ = 0.0    -- Z rotation
}