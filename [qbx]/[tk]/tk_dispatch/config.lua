Config = {}

Config.Framework = 'qb' -- standalone/esx/qb
Config.NotificationType = 'qb' -- esx/qb/mythic
Config.Locale = 'en' -- en/fi
Config.DebugMode = false -- false/true

Config.Phone = 'default' -- default/lb/qs/gks -- you can add your own in server/main_editable.lua
Config.Inventory = 'default' -- default/ox

Config.Controls = { -- https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard
    callManager = 'U',
    toggleMoveMode = 'I',
    map = 'COMMA',
    sidebar = 'PERIOD',
    toggleFocus = 'LMENU',
    calls = {
        next = 'LEFT',
        previous = 'RIGHT',
        accept = 'UP',
    },
    panicButton = 'O',
}

Config.RemoveCallFromEveryone = false -- false/true, should a call be removed from everyone if it is deleted manually by someone
Config.AttachAllUnitsInGroupToCall = false -- false/true, should all units of a group be attached to a call when it is accepted
Config.AttachAllUnitsInVehicleToCall = false -- false/true, should all units in a vehicle be attached to a call when it is accepted

Config.NotificationPosition = 'top-right' -- 'top-right' | 'top-left' | 'top-center' | 'bottom-left' | 'bottom-right' | 'bottom-center' | undefined
Config.CallManagerPosition = {
    x = 15,
    y = 500,
}
Config.CallManagerSize = { -- percentage of screen width and height
    width = 18,
    --height = 14,
}
Config.CallManagerAutoHide = {
    pauseMenu = true,
    bigMap = true,
}

Config.Commands = {
    callmanager = 'callmanager',
    togglemovemode = 'togglemovemode',
    previouscall = 'previouscall',
    nextcall = 'nextcall',
    acceptcall = 'acceptcall',
    dispatchmap = 'dispatchmap',
    dispatchsidebar = 'dispatchsidebar',
    togglefocus = 'togglefocus',
    panic = 'panic',
}

Config.Dispatch = {
    police = {
        jobs = { -- jobs to be included in the dispatch group
            police = true,
            sheriff = true,
            leo = true,
            --if using standalone (and badger discord api), replace the "police" for example with discord role id like this (has to be done in other job parts too):
            --['820394321600708608'] = true
        },
        permissions = {
            manageLayers = {
                police = 4, -- job name, minimum grade
                sheriff = 4,
            },
            dispatcher = { -- dispatchers can manage all units
                police = 4,
                sheriff = 4,
            },
        },
        panicButton = true, -- enable panic button
        pages = { -- pages to enable
            map = true,
            sidebar = true,
            callManager = true,
            notification = true,
        },
        iconName = 'police.png', -- unit icon for map, if not set, will use marker.png
        --neededItem = 'radio', -- item needed to use map, sidebar, callmanager, see notifications
    },
    ems = {
        jobs = {
            ambulance = true,
        },
        panicButton = true,
        pages = {
            map = true,
            sidebar = true,
            callManager = true,
            notification = true,
        },
    }
}

Config.Alerts = {
    shooting = {
        enable = true,
        jobs = {'police'}, -- jobs to alert, will select dispatch group based on this
        ignoredJobs = { -- jobs to ignore for this alert
            police = true,
        },
        cooldown = 15000, -- cooldown for alert in ms
        --removeTime = 1000 * 60 * 5, -- time in ms to remove alert from map (5 minutes)
        checkForSuppressor = true,
        nearbyPed = {
            enable = false, -- enable nearby ped check
            needLos = false, -- should ped have line of sight to player
            dist = 100, -- distance to check for nearby peds
            anim = { -- animation to play on nearby ped on alert
                dict = 'cellphone@',
                name = 'cellphone_text_read_base',
                prop = {
                    model = `prop_npc_phone_02`,
                    bone = 28422,
                    pos = vec3(0.0, 0.0, 0.0),
                    rot = vec3(0.0, 0.0, 0.0),
                },
                duration = 5000,
            }
        },
        platePercentage = {min = 25, max = 100}, -- percentage of plate to be visible to alert, unknown characters are set as ?
        coordsOffset = 20, -- offset for alert coords
        chance = 90, -- chance for alert to be sent (0-100)
    },
    gunSeen = {
        enable = true,
        jobs = {'police'},
        ignoredJobs = {
            police = true,
        },
        cooldown = 15000,
        checkForSuppressor = false,
        nearbyPed = {
            enable = true,
            needLos = true,
            dist = 50,
            anim = {
                dict = 'cellphone@',
                name = 'cellphone_text_read_base',
                prop = {
                    model = `prop_npc_phone_02`,
                    bone = 28422,
                    pos = vec3(0.0, 0.0, 0.0),
                    rot = vec3(0.0, 0.0, 0.0),
                },
                duration = 5000,
            }
        },
        platePercentage = {min = 25, max = 100},
        coordsOffset = 20,
    },
    speeding = {
        enable = true,
        jobs = {'police'},
        ignoredJobs = {
            police = true,
            ambulance = true,
        },
        cooldown = 15000,
        locations = {
            {coords = vec3(100.78, -1016.51, 29.41), radius = 20.0, minSpeed = 25},
        },
        platePercentage = {min = 25, max = 100},
    },
    vehStealing = {
        enable = true,
        jobs = {'police'},
        ignoredJobs = {
            police = true,
        },
        cooldown = 15000,
        platePercentage = {min = 25, max = 100},
    },
    fighting = {
        enable = true,
        jobs = {'police'},
        ignoredJobs = {
            police = true,
        },
        cooldown = 15000,
        nearbyPed = {
            enable = true,
            needLos = true,
            dist = 100,
            anim = {
                dict = 'cellphone@',
                name = 'cellphone_text_read_base',
                prop = {
                    model = `prop_npc_phone_02`,
                    bone = 28422,
                    pos = vec3(0.0, 0.0, 0.0),
                    rot = vec3(0.0, 0.0, 0.0),
                },
                duration = 5000,
            }
        },
        coordsOffset = 20,
    },
    injuredPerson = {
        enable = true,
        jobs = {'ambulance'},
        cooldown = 60000,
        nearbyPed = {
            enable = true,
            needLos = true,
            dist = 50,
            anim = {
                dict = 'cellphone@',
                name = 'cellphone_text_read_base',
                prop = {
                    model = `prop_npc_phone_02`,
                    bone = 28422,
                    pos = vec3(0.0, 0.0, 0.0),
                    rot = vec3(0.0, 0.0, 0.0),
                },
                duration = 5000,
            }
        }
    },
    panicButton = {
        enable = true,
        cooldown = 15000,
        anim = {
            dict = 'random@arrests',
            name = 'generic_radio_chatter',
        },
        playSound = true,
        playSoundAll = true,
    },
    call = {
        enable = true,
        cooldown = 15000,
        jobs = {'police'},
    },
}

Config.BlacklistedWeapons = {
    [`WEAPON_STUNGUN`] = true,
    [`WEAPON_BALL`] = true,
    [`WEAPON_SNOWBALL`] = true,
    [`WEAPON_FLARE`] = true,
    [`WEAPON_SMOKEGRENADE`] = true,
    [`WEAPON_BZGAS`] = true,
    [`WEAPON_FIREEXTINGUISHER`] = true,
    [`WEAPON_JERRYCAN`] = true,
    [`WEAPON_HAZARDCAN`] = true,
    [`WEAPON_FERTILIZERCAN`] = true,
}

Config.Colors = {
    [0] = "Metallic Black",
    [1] = "Metallic Graphite Black",
    [2] = "Metallic Black Steel",
    [3] = "Metallic Dark Silver",
    [4] = "Metallic Silver",
    [5] = "Metallic Blue Silver",
    [6] = "Metallic Steel Gray",
    [7] = "Metallic Shadow Silver",
    [8] = "Metallic Stone Silver",
    [9] = "Metallic Midnight Silver",
    [10] = "Metallic Gun Metal",
    [11] = "Metallic Anthracite Grey",
    [12] = "Matte Black",
    [13] = "Matte Gray",
    [14] = "Matte Light Grey",
    [15] = "Util Black",
    [16] = "Util Black Poly",
    [17] = "Util Dark silver",
    [18] = "Util Silver",
    [19] = "Util Gun Metal",
    [20] = "Util Shadow Silver",
    [21] = "Worn Black",
    [22] = "Worn Graphite",
    [23] = "Worn Silver Grey",
    [24] = "Worn Silver",
    [25] = "Worn Blue Silver",
    [26] = "Worn Shadow Silver",
    [27] = "Metallic Red",
    [28] = "Metallic Torino Red",
    [29] = "Metallic Formula Red",
    [30] = "Metallic Blaze Red",
    [31] = "Metallic Graceful Red",
    [32] = "Metallic Garnet Red",
    [33] = "Metallic Desert Red",
    [34] = "Metallic Cabernet Red",
    [35] = "Metallic Candy Red",
    [36] = "Metallic Sunrise Orange",
    [37] = "Metallic Classic Gold",
    [38] = "Metallic Orange",
    [39] = "Matte Red",
    [40] = "Matte Dark Red",
    [41] = "Matte Orange",
    [42] = "Matte Yellow",
    [43] = "Util Red",
    [44] = "Util Bright Red",
    [45] = "Util Garnet Red",
    [46] = "Worn Red",
    [47] = "Worn Golden Red",
    [48] = "Worn Dark Red",
    [49] = "Metallic Dark Green",
    [50] = "Metallic Racing Green",
    [51] = "Metallic Sea Green",
    [52] = "Metallic Olive Green",
    [53] = "Metallic Green",
    [54] = "Metallic Gasoline Blue Green",
    [55] = "Matte Lime Green",
    [56] = "Util Dark Green",
    [57] = "Util Green",
    [58] = "Worn Dark Green",
    [59] = "Worn Green",
    [60] = "Worn Sea Wash",
    [61] = "Metallic Midnight Blue",
    [62] = "Metallic Dark Blue",
    [63] = "Metallic Saxony Blue",
    [64] = "Metallic Blue",
    [65] = "Metallic Mariner Blue",
    [66] = "Metallic Harbor Blue",
    [67] = "Metallic Diamond Blue",
    [68] = "Metallic Surf Blue",
    [69] = "Metallic Nautical Blue",
    [70] = "Metallic Bright Blue",
    [71] = "Metallic Purple Blue",
    [72] = "Metallic Spinnaker Blue",
    [73] = "Metallic Ultra Blue",
    [74] = "Metallic Bright Blue",
    [75] = "Util Dark Blue",
    [76] = "Util Midnight Blue",
    [77] = "Util Blue",
    [78] = "Util Sea Foam Blue",
    [79] = "Util Lightning blue",
    [80] = "Util Maui Blue Poly",
    [81] = "Util Bright Blue",
    [82] = "Matte Dark Blue",
    [83] = "Matte Blue",
    [84] = "Matte Midnight Blue",
    [85] = "Worn Dark blue",
    [86] = "Worn Blue",
    [87] = "Worn Light blue",
    [88] = "Metallic Taxi Yellow",
    [89] = "Metallic Race Yellow",
    [90] = "Metallic Bronze",
    [91] = "Metallic Yellow Bird",
    [92] = "Metallic Lime",
    [93] = "Metallic Champagne",
    [94] = "Metallic Pueblo Beige",
    [95] = "Metallic Dark Ivory",
    [96] = "Metallic Choco Brown",
    [97] = "Metallic Golden Brown",
    [98] = "Metallic Light Brown",
    [99] = "Metallic Straw Beige",
    [100] = "Metallic Moss Brown",
    [101] = "Metallic Biston Brown",
    [102] = "Metallic Beechwood",
    [103] = "Metallic Dark Beechwood",
    [104] = "Metallic Choco Orange",
    [105] = "Metallic Beach Sand",
    [106] = "Metallic Sun Bleeched Sand",
    [107] = "Metallic Cream",
    [108] = "Util Brown",
    [109] = "Util Medium Brown",
    [110] = "Util Light Brown",
    [111] = "Metallic White",
    [112] = "Metallic Frost White",
    [113] = "Worn Honey Beige",
    [114] = "Worn Brown",
    [115] = "Worn Dark Brown",
    [116] = "Worn straw beige",
    [117] = "Brushed Steel",
    [118] = "Brushed Black steel",
    [119] = "Brushed Aluminium",
    [120] = "Chrome",
    [121] = "Worn Off White",
    [122] = "Util Off White",
    [123] = "Worn Orange",
    [124] = "Worn Light Orange",
    [125] = "Metallic Securicor Green",
    [126] = "Worn Taxi Yellow",
    [127] = "Police Car Blue",
    [128] = "Matte Green",
    [129] = "Matte Brown",
    [130] = "Worn Orange",
    [131] = "Matte White",
    [132] = "Worn White",
    [133] = "Worn Olive Army Green",
    [134] = "Pure White",
    [135] = "Hot Pink",
    [136] = "Salmon pink",
    [137] = "Metallic Vermillion Pink",
    [138] = "Orange",
    [139] = "Green",
    [140] = "Blue",
    [141] = "Mettalic Black Blue",
    [142] = "Metallic Black Purple",
    [143] = "Metallic Black Red",
    [144] = "Hunter Green",
    [145] = "Metallic Purple",
    [146] = "Metallic V Dark Blue",
    [147] = "MODSHOP BLACK1",
    [148] = "Matte Purple",
    [149] = "Matte Dark Purple",
    [150] = "Metallic Lava Red",
    [151] = "Matte Forest Green",
    [152] = "Matte Olive Drab",
    [153] = "Matte Desert Brown",
    [154] = "Matte Desert Tan",
    [155] = "Matte Foilage Green",
    [156] = "DEFAULT ALLOY",
    [157] = "Epsilon Blue",
    [158] = "Pure Gold",
    [159] = "Brushed Gold",
}

Config.Weapons = {
    [`WEAPON_STUNGUN`] = 'WEAPON_STUNGUN',
    [`WEAPON_VINTAGEPISTOL`] = 'WEAPON_VINTAGEPISTOL',
    [`WEAPON_SNSPISTOL`] = 'WEAPON_SNSPISTOL',
    [`WEAPON_SNSPISTOL_MK2`] = 'WEAPON_SNSPISTOL_MK2',
    [`WEAPON_PISTOL`] = 'WEAPON_PISTOL',
    [`WEAPON_PISTOL_MK2`] = 'WEAPON_PISTOL_MK2',
    [`WEAPON_COMBATPISTOL`] = 'WEAPON_COMBATPISTOL',
    [`WEAPON_APPISTOL`] = 'WEAPON_APPISTOL',
    [`WEAPON_HEAVYPISTOL`] = 'WEAPON_HEAVYPISTOL',
    [`WEAPON_PISTOL50`] = 'WEAPON_PISTOL50',
    [`WEAPON_REVOLVER`] = 'WEAPON_REVOLVER',
    [`WEAPON_REVOLVER_MK2`] = 'WEAPON_REVOLVER_MK2',
    [`WEAPON_MARKSMANPISTOL`] = 'WEAPON_MARKSMANPISTOL',
    [`WEAPON_DOUBLEACTION`] = 'WEAPON_DOUBLEACTION',
    [`WEAPON_MICROSMG`] = 'WEAPON_MICROSMG',
    [`WEAPON_SMG`] = 'WEAPON_SMG',
    [`WEAPON_SMG_MK2`] = 'WEAPON_SMG_MK2',
    [`WEAPON_ASSAULTSMG`] = 'WEAPON_ASSAULTSMG',
    [`WEAPON_COMBATPDW`] = 'WEAPON_COMBATPDW',
    [`WEAPON_MACHINEPISTOL`] = 'WEAPON_MACHINEPISTOL',
    [`WEAPON_MINISMG`] = 'WEAPON_MINISMG',
    [`WEAPON_PUMPSHOTGUN`] = 'WEAPON_PUMPSHOTGUN',
    [`WEAPON_PUMPSHOTGUN_MK2`] = 'WEAPON_PUMPSHOTGUN_MK2',
    [`WEAPON_ASSAULTSHOTGUN`] = 'WEAPON_ASSAULTSHOTGUN',
    [`WEAPON_BULLPUPSHOTGUN`] = 'WEAPON_BULLPUPSHOTGUN',
    [`WEAPON_SAWNOFFSHOTGUN`] = 'WEAPON_SAWNOFFSHOTGUN',
    [`WEAPON_DBSHOTGUN`] = 'WEAPON_DBSHOTGUN',
    [`WEAPON_HEAVYSHOTGUN`] = 'WEAPON_HEAVYSHOTGUN',
    [`WEAPON_MUSKET`] = 'WEAPON_MUSKET',
    [`WEAPON_AUTOSHOTGUN`] = 'WEAPON_AUTOSHOTGUN',
    [`WEAPON_COMBATSHOTGUN`] = 'WEAPON_COMBATSHOTGUN',
    [`WEAPON_ASSAULTRIFLE`] = 'WEAPON_ASSAULTRIFLE',
    [`WEAPON_ASSAULTRIFLE_MK2`] = 'WEAPON_ASSAULTRIFLE_MK2',
    [`WEAPON_CARBINERIFLE`] = 'WEAPON_CARBINERIFLE',
    [`WEAPON_CARBINERIFLE_MK2`] = 'WEAPON_CARBINERIFLE_MK2',
    [`WEAPON_ADVANCEDRIFLE`] = 'WEAPON_ADVANCEDRIFLE',
    [`WEAPON_SPECIALCARBINE`] = 'WEAPON_SPECIALCARBINE',
    [`WEAPON_SPECIALCARBINE_MK2`] = 'WEAPON_SPECIALCARBINE_MK2',
    [`WEAPON_BULLPUPRIFLE`] = 'WEAPON_BULLPUPRIFLE',
    [`WEAPON_BULLPUPRIFLE_MK2`] = 'WEAPON_BULLPUPRIFLE_MK2',
    [`WEAPON_COMPACTRIFLE`] = 'WEAPON_COMPACTRIFLE',
    [`WEAPON_MILITARYRIFLE`] = 'WEAPON_MILITARYRIFLE',
    [`WEAPON_MG`] = 'WEAPON_MG',
    [`WEAPON_COMBATMG`] = 'WEAPON_COMBATMG',
    [`WEAPON_COMBATMG_MK2`] = 'WEAPON_COMBATMG_MK2',
    [`WEAPON_GUSENBERG`] = 'WEAPON_GUSENBERG',
    [`WEAPON_SNIPERRIFLE`] = 'WEAPON_SNIPERRIFLE',
    [`WEAPON_HEAVYSNIPER`] = 'WEAPON_HEAVYSNIPER',
    [`WEAPON_HEAVYSNIPER_MK2`] = 'WEAPON_HEAVYSNIPER_MK2',
    [`WEAPON_MARKSMANRIFLE`] = 'WEAPON_MARKSMANRIFLE',
    [`WEAPON_MARKSMANRIFLE_MK2`] = 'WEAPON_MARKSMANRIFLE_MK2'
}