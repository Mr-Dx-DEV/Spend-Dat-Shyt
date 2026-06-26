Config = {} -- webhook link can be placed in "server/main_editable.lua"

Config.DebugMode = false -- false / true

Config.Framework = 'qb' -- standalone/esx/qb
Config.NotificationType = 'esx' -- esx/qb/mythic
Config.Locale = 'en' -- en/fi
Config.UseOxLib = true -- false / true, remember to add " shared_script '@ox_lib/init.lua' " to fxmanifest.lua if set to true

Config.Commands = { -- command names, you can remove commands that you dont want to use
    spray = 'spray', -- spraying (works for all)
    remove = 'removespray', -- removing sprays (works for all)
    admin = 'sprayadmin', -- open admin menu which shows all sprays (restricted)
    clear = 'clearsprays', -- remove all sprays (restricted)
}

Config.SprayItem = 'spray_can' -- item to spray (remove if you don't want to use it)
Config.SprayRemoveItem = 'spray_cloth' -- item to remove sprays (remove if you don't want to use it)

Config.DeleteTime = 60 * 60 * 48 -- how long will it take for a spray to be removed automatically, last number is time in hours (default 48 hours) (remove if you dont want to use this)
Config.AlertOnDelete = { -- !only works with esx or qb!
    server = false, -- false/true, alert spray owner when their graffiti is removed by the server
    player = false, -- false/true, alert spray owner when their graffiti has been removed by another player
    start = false, -- false/true, alert spray owner when a player starts removing their graffiti
}
Config.DeleteBlip = { -- settings for blip that will be shown when someone removes your graffiti
    enable = false,
    sprite = 72,
    scale = 0.5,
    color = 1,
    display = 6,
    duration = 30, -- in seconds
}

Config.DefaultColor = '#fa5252' -- default color for spray (hex)
Config.Fonts = {
    {value = 'Bombing', label = 'Bombing', isCustom = true, width = 0.8}, -- font name, font label, is it a custom font, font width
    {value = 'Blowbrush', label = 'Blowbrush', isCustom = true, width = 1.0},
    {value = 'Degrassi', label = 'Degrassi', isCustom = true, width = 2.0},
    {value = 'Docallisme', label = 'Docallisme', isCustom = true, width = 1.0},
    {value = 'Drip', label = 'Drip', isCustom = true, width = 0.8},
    {value = 'DonGraffiti', label = 'DonGraffiti', isCustom = true, width = 0.9},
    {value = 'Mostwasted', label = 'Mostwasted', isCustom = true, width = 1.2},
    {value = 'OnePiece', label = 'OnePiece', isCustom = true, width = 0.9},
    {value = 'Painterz', label = 'Painterz', isCustom = true, width = 1.0},
    {value = 'SudegnakNo2', label = 'SudegnakNo2', isCustom = true, width = 0.7},
    {value = '$Font2_cond', label = 'Chalet Comprime', width = 0.7},
    {value = '$Font5', label = 'SignPainter', width = 0.9},
}
Config.Scale = { -- settings for spray scale
    default = 5.0, -- default scale
    step = 0.5, -- step (how much to increase / decrease when changing scale)
    min = 3.0, -- minimum scale
    max = 12.0, -- maximum scale
}

Config.TextLength = { -- minimum and maximum text length for sprays
    min = 1,
    max = 15,
}
Config.BlacklistedWords = {'fivem', 'roleplay'}  -- blacklist words, will also send a message to webhook is any of these words are used (you can add as many as you want)
Config.WhitelistedWords = { -- if any whitelisted words are set, players are only able to use these words and nothing else (you can add as many as you want)
    --[[ ballas = true,
    lostmc = true,
    randomword = { -- you can also whitelist certain words to certain jobs
        police = 0, -- job name, minimum grade
        ballas = 0,
    }, ]]
}

Config.Anim = { -- animation settings for spraying and removing sprays
    spray = {
        dict = 'anim@scripted@freemode@postertag@graffiti_spray@male@',
        name = 'spray_can_var_01_male',
        duration = 5000,
        prop = {
            model = `prop_cs_spray_can`,
            bone = 28422,
            pos = vec3(0.0, 0.0, 0.07),
            rot = vec3(0.001736, 0.0, 0.0),
        },
        ptfx = {
            asset = 'scr_paintnspray',
            name = 'scr_respray_smoke',
            offset = vec3(0.0, 0.0, 0.0),
            rot = vec3(0.0, 0.0, 0.0),
            scale = 0.15,
        },
    },
    remove = {
        dict = 'amb@world_human_maid_clean@',
        name = 'base',
        duration = 5000,
        prop = {
            model = `prop_sponge_01`,
            bone = 28422,
            pos = vec3(0.0, 0.0, -0.01),
            rot = vec3(90.0, 0.0, 0.0),
        },
    },
}

Config.Dist = { -- distances for different actions
    spray = 8.0, -- spraying
    see = 50, -- seeing sprays
    remove = 3 -- removing sprays
}
