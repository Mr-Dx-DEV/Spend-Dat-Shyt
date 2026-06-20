Config = Config or {}

Config.Debug = false

Config.Framework = {
    -- 0 = standalone
    -- 1 = esx
    -- 2 = qbcore
    Active = 0,

    -- esx
    ESX_SHARED_OBJECT = "esx:getSharedObject",

    -- es_extended resource name
    ES_EXTENDED_NAME = "es_extended",

    -------

    -- qbcore
    QBCORE_SHARED_OBJECT = "QBCore:GetObject",

    -- qb-core resource name
    QB_CORE_NAME = "qb-core",

    -- will not detect any supported framework if on true.
    DisableDetection = false,
}

-- this is domain name so allow anything that you would like to be allowed
Config.WhitelistedURL = {
    "youtube",
    "youtu",
    "discordapp",
}

-- if there is any error this will help us to know from where does the error come from
Config.GeneralDebug = false

-- can be left on nil value it will automatically detect your database.
-- but just in case you had more than one mysql framework on your server
-- you will need to choose the type manually

-- 0 = oxmysql
-- 1 = ghmattimysql
-- 2 = mysql-async
Config.MysqlType = nil

-- using ox inv?
Config.ox_inv = true

-- using codem-inv?
Config.codem_inventory = false

-- item called
Config.ItemName = "mixer"

-- if using standalone how many mixers player will be allowed to have / place
Config.MixerInventoryCount = 1

-- Key to open menu
Config.KeyToOpen = "E"

-- Locale for script
Config.Locale = "en"

-- default start volume
Config.DefaultMixerVolume = 0.5

-- mixer object player place on ground
Config.MixerPlaceObject = "sf_prop_sf_dj_desk_02a"

-- the red marker above the mixer player can spawn offset
Config.MarkerOffsetForObject = vector3(0.0, 0.0, 1.0)

-- the teleport player behind/infront depends if you have changed the mixer place object offset
Config.MixerObjectOffsetTeleport = vector3(0.0, -0.75, 1.0)

-- if you have changed the object in "MixerPlaceObject" the rotation of player might be wrong here just edit
-- the number to greater/lower to rotate the player to correct way
Config.OffsetHeadingForObjectTeleport = 0.0

-- personal mixer distance playing
Config.PersonalMixerDistance = 20.0

-- how close player have to be in order to see the object player spawned via item / command
Config.PersonalMixerObjectDistance = 30.0

-- idle animation
Config.AnimDictMixerIdle = "anim@amb@nightclub@djs@dixon@"
Config.AnimClipMixerIdle = "dixn_dance_cntr_open_dix"

-- DJ mixer list
Config.MixerList = {
    ["vanilla"] = {
        mixer = {
            {
                pos = vector3(120.72, -1281.12, 29.48),
                distance = 5,

                -- this will teleport player infront of the mixer so he stands correctly
                teleportPlayer = {
                    pos = vector3(120.58, -1281.12, 29.48),
                    heading = 119.98,

                    animDict = Config.AnimDictMixerIdle,
                    animClip = Config.AnimClipMixerIdle,
                },
            },
        },
        speaker = {
            {
                pos = vector3(117.47, -1290.58, 29.17),
                distance = 75.0,
            },
        },

        -- if you want to hear muffled sound if outside interior then set the interior ID here
        -- you can check what interior ID you're in by enabling "Config.InteriorDebug" in this very config.lua
        interiorIdentifier = {
            [197121] = true
        },

        -- if you do not wish to have muffled sound effect then just uncomment this below.
        --interiorIdentifier = nil,

        -- max value is 1.0
        -- 1.0 = 100% volume
        defaultVolume = 0.5,
        --jobs = {"police","other job"}, -- if left nil everyone will be able to open it

        -- if this is set to true it will not try to disable music around you from in-game world
        skipEmitterForThis = false,
    },
      ["rmobile"] = {
        mixer = {
            {
                pos = vector3(276.0580, 137.2528, 104.4179),
                distance = 5,

                -- this will teleport player infront of the mixer so he stands correctly
                teleportPlayer = {
                    pos = vector3(276.0580, 137.2528, 104.4179),
                    heading = 343.4798,

                    animDict = Config.AnimDictMixerIdle,
                    animClip = Config.AnimClipMixerIdle,
                },
            },
        },
        speaker = {
            {
                pos = vector3(276.0580, 137.2528, 104.4179),
                distance = 30.0,
            },
        },

        -- if you want to hear muffled sound if outside interior then set the interior ID here
        -- you can check what interior ID you're in by enabling "Config.InteriorDebug" in this very config.lua
        interiorIdentifier = {
            [197121] = true
        },

        -- if you do not wish to have muffled sound effect then just uncomment this below.
        --interiorIdentifier = nil,

        -- max value is 1.0
        -- 1.0 = 100% volume
        defaultVolume = 0.5,
        --jobs = {"police","other job"}, -- if left nil everyone will be able to open it

        -- if this is set to true it will not try to disable music around you from in-game world
        skipEmitterForThis = false,
    },
     ["djbooth1"] = {
        mixer = {
            {
                pos = vector3(760.9935, 1261.1573, 360.5603),
                distance = 5,

                -- this will teleport player infront of the mixer so he stands correctly
                teleportPlayer = {
                    pos = vector3(760.9935, 1261.1573, 360.5603),
                    heading = 274.0790,

                    animDict = Config.AnimDictMixerIdle,
                    animClip = Config.AnimClipMixerIdle,
                },
            },
        },
        speaker = {
            {
                pos = vector3(760.9935, 1261.1573, 360.5603),
                distance = 30.0,
            },
        },

        -- if you want to hear muffled sound if outside interior then set the interior ID here
        -- you can check what interior ID you're in by enabling "Config.InteriorDebug" in this very config.lua
        interiorIdentifier = {
            [197121] = true
        },

        -- if you do not wish to have muffled sound effect then just uncomment this below.
        --interiorIdentifier = nil,

        -- max value is 1.0
        -- 1.0 = 100% volume
        defaultVolume = 0.5,
        --jobs = {"police","other job"}, -- if left nil everyone will be able to open it

        -- if this is set to true it will not try to disable music around you from in-game world
        skipEmitterForThis = false,
    },
     ["djbooth2"] = {
        mixer = {
            {
                pos = vector3(-80.5434, -421.8566, 41.6779),
                distance = 5,

                -- this will teleport player infront of the mixer so he stands correctly
                teleportPlayer = {
                    pos = vector3(-80.5434, -421.8566, 41.6779),
                    heading = 255.3567,

                    animDict = Config.AnimDictMixerIdle,
                    animClip = Config.AnimClipMixerIdle,
                },
            },
        },
        speaker = {
            {
                pos = vector3(-80.5434, -421.8566, 41.6779),
                distance = 30.0,
            },
        },

        -- if you want to hear muffled sound if outside interior then set the interior ID here
        -- you can check what interior ID you're in by enabling "Config.InteriorDebug" in this very config.lua
        interiorIdentifier = {
            [197121] = true
        },

        -- if you do not wish to have muffled sound effect then just uncomment this below.
        --interiorIdentifier = nil,

        -- max value is 1.0
        -- 1.0 = 100% volume
        defaultVolume = 0.5,
        --jobs = {"police","other job"}, -- if left nil everyone will be able to open it

        -- if this is set to true it will not try to disable music around you from in-game world
        skipEmitterForThis = false,
    },
     ["djbooth3"] = {
        mixer = {
            {
                pos = vector3(19.2524, -1103.5508, 29.7970),
                distance = 5,

                -- this will teleport player infront of the mixer so he stands correctly
                teleportPlayer = {
                    pos = vector3(19.2524, -1103.5508, 29.7970),
                    heading = 340.8022,

                    animDict = Config.AnimDictMixerIdle,
                    animClip = Config.AnimClipMixerIdle,
                },
            },
        },
        speaker = {
            {
                pos = vector3(19.2524, -1103.5508, 29.7970),
                distance = 30.0,
            },
        },

        -- if you want to hear muffled sound if outside interior then set the interior ID here
        -- you can check what interior ID you're in by enabling "Config.InteriorDebug" in this very config.lua
        interiorIdentifier = {
            [197121] = true
        },

        -- if you do not wish to have muffled sound effect then just uncomment this below.
        --interiorIdentifier = nil,

        -- max value is 1.0
        -- 1.0 = 100% volume
        defaultVolume = 0.5,
        --jobs = {"police","other job"}, -- if left nil everyone will be able to open it

        -- if this is set to true it will not try to disable music around you from in-game world
        skipEmitterForThis = false,
    },
     ["djbooth4"] = {
        mixer = {
            {
                pos = vector3(603.5745, -181.2569, 54.5224),
                distance = 5,

                -- this will teleport player infront of the mixer so he stands correctly
                teleportPlayer = {
                    pos = vector3(603.5745, -181.2569, 54.5224),
                    heading = 186.2501,

                    animDict = Config.AnimDictMixerIdle,
                    animClip = Config.AnimClipMixerIdle,
                },
            },
        },
        speaker = {
            {
                pos = vector3(603.5745, -181.2569, 54.5224),
                distance = 30.0,
            },
        },

        -- if you want to hear muffled sound if outside interior then set the interior ID here
        -- you can check what interior ID you're in by enabling "Config.InteriorDebug" in this very config.lua
        interiorIdentifier = {
            [197121] = true
        },

        -- if you do not wish to have muffled sound effect then just uncomment this below.
        --interiorIdentifier = nil,

        -- max value is 1.0
        -- 1.0 = 100% volume
        defaultVolume = 0.5,
        --jobs = {"police","other job"}, -- if left nil everyone will be able to open it

        -- if this is set to true it will not try to disable music around you from in-game world
        skipEmitterForThis = false,
    },
     ["bowling"] = {
        mixer = {
            {
                pos = vector3(-141.6441, -192.7144, 44.0086),
                distance = 5,

                -- this will teleport player infront of the mixer so he stands correctly
                teleportPlayer = {
                    pos = vector3(-141.6441, -192.7144, 44.0086),
                    heading = 255.3312,

                    animDict = Config.AnimDictMixerIdle,
                    animClip = Config.AnimClipMixerIdle,
                },
            },
        },
        speaker = {
            {
                pos = vector3(-141.6441, -192.7144, 44.0086),
                distance = 30.0,
            },
        },

        -- if you want to hear muffled sound if outside interior then set the interior ID here
        -- you can check what interior ID you're in by enabling "Config.InteriorDebug" in this very config.lua
        interiorIdentifier = {
            [197121] = true
        },

        -- if you do not wish to have muffled sound effect then just uncomment this below.
        --interiorIdentifier = nil,

        -- max value is 1.0
        -- 1.0 = 100% volume
        defaultVolume = 0.5,
        --jobs = {"police","other job"}, -- if left nil everyone will be able to open it

        -- if this is set to true it will not try to disable music around you from in-game world
        skipEmitterForThis = false,
    },
     ["skate"] = {
        mixer = {
            {
                pos = vector3(-180.1927, -125.7071, 56.2741),
                distance = 5,

                -- this will teleport player infront of the mixer so he stands correctly
                teleportPlayer = {
                    pos = vector3(-180.1927, -125.7071, 56.2741),
                    heading = 250.3208,

                    animDict = Config.AnimDictMixerIdle,
                    animClip = Config.AnimClipMixerIdle,
                },
            },
        },
        speaker = {
            {
                pos = vector3(-180.1927, -125.7071, 56.2741),
                distance = 30.0,
            },
        },

        -- if you want to hear muffled sound if outside interior then set the interior ID here
        -- you can check what interior ID you're in by enabling "Config.InteriorDebug" in this very config.lua
        interiorIdentifier = {
            [197121] = true
        },

        -- if you do not wish to have muffled sound effect then just uncomment this below.
        --interiorIdentifier = nil,

        -- max value is 1.0
        -- 1.0 = 100% volume
        defaultVolume = 0.5,
        --jobs = {"police","other job"}, -- if left nil everyone will be able to open it

        -- if this is set to true it will not try to disable music around you from in-game world
        skipEmitterForThis = false,
    },
    ["bennysdocks"] = {
        mixer = {
            {
                pos = vector3(138.9490, -3053.1560, 11.0131),
                distance = 5,

                -- this will teleport player infront of the mixer so he stands correctly
                teleportPlayer = {
                    pos = vector3(138.9490, -3053.1560, 11.0131),
                    heading = 185.1972,

                    animDict = Config.AnimDictMixerIdle,
                    animClip = Config.AnimClipMixerIdle,
                },
            },
        },
        speaker = {
            {
                pos = vector3(138.9490, -3053.1560, 11.0131),
                distance = 75.0,
            },
        },

        -- if you want to hear muffled sound if outside interior then set the interior ID here
        -- you can check what interior ID you're in by enabling "Config.InteriorDebug" in this very config.lua
        interiorIdentifier = {
            [197121] = true
        },

        -- if you do not wish to have muffled sound effect then just uncomment this below.
        --interiorIdentifier = nil,

        -- max value is 1.0
        -- 1.0 = 100% volume
        defaultVolume = 1.0,
        --jobs = {"police","other job"}, -- if left nil everyone will be able to open it

        -- if this is set to true it will not try to disable music around you from in-game world
        skipEmitterForThis = false,
    },
     ["tropicslheights"] = {
        mixer = {
            {
                pos = vector3(287.6833, -935.1067, 57.5947),
                distance = 5,

                -- this will teleport player infront of the mixer so he stands correctly
                teleportPlayer = {
                    pos = vector3(287.6833, -935.1067, 57.5947),
                    heading = 311.5417,

                    animDict = Config.AnimDictMixerIdle,
                    animClip = Config.AnimClipMixerIdle,
                },
            },
        },
        speaker = {
            {
                pos = vector3(287.6833, -935.1067, 57.5947),
                distance = 75.0,
            },
        },

        -- if you want to hear muffled sound if outside interior then set the interior ID here
        -- you can check what interior ID you're in by enabling "Config.InteriorDebug" in this very config.lua
        interiorIdentifier = {
            [197121] = true
        },

        -- if you do not wish to have muffled sound effect then just uncomment this below.
        --interiorIdentifier = nil,

        -- max value is 1.0
        -- 1.0 = 100% volume
        defaultVolume = 1.0,
        jobs = {"tropicalheights"}, -- if left nil everyone will be able to open it

        -- if this is set to true it will not try to disable music around you from in-game world
        skipEmitterForThis = false,
    },
    -----------------------------
    ["Galaxy club"] = {
        mixer = {
            {
                pos = vector3(-1603.39, -3012.6, -77.79),
                distance = 5,

                -- this will teleport player infront of the mixer so he stands correctly
                teleportPlayer = {
                    pos = vector3(-1603.04, -3012.61, -77.8),
                    heading = 271.38,

                    animDict = Config.AnimDictMixerIdle,
                    animClip = Config.AnimClipMixerIdle,
                },
            },
        },
        speaker = {
            {
                pos = vector3(-1596.71, -3012.88, -77.79),
                distance = 25.0,
            },
        },

        -- if you want to hear muffled sound if outside interior then set the interior ID here
        -- you can check what interior ID you're in by enabling "Config.InteriorDebug" in this very config.lua
        interiorIdentifier = {
            [271617] = true
        },

        -- if you do not wish to have muffled sound effect then just uncomment this below.
        --interiorIdentifier = nil,

        -- max value is 1.0
        -- 1.0 = 100% volume
        defaultVolume = 0.5,
        --jobs = {"police","other job"}, -- if left nil everyone will be able to open it

        -- if this is set to true it will not try to disable music around you from in-game world
        skipEmitterForThis = false,
    },
    -----------------------------
    ["Vinewood Bowl"] = {
        mixer = {
            {
                pos = vector3(684.02, 571.54, 130.46),
                distance = 5,

                -- this will teleport player infront of the mixer so he stands correctly
                teleportPlayer = {
                    pos = vector3(683.95, 571.36, 130.46),
                    heading = 159.88,

                    animDict = Config.AnimDictMixerIdle,
                    animClip = Config.AnimClipMixerIdle,
                },
            },
        },
        speaker = {
            {
                pos = vector3(672, 536, 135),
                distance = 100.0,
            },
        },

        -- if you want to hear muffled sound if outside interior then set the interior ID here
        -- you can check what interior ID you're in by enabling "Config.InteriorDebug" in this very config.lua
        --interiorIdentifier = {
        --    [271617] = true
        --},

        -- if you do not wish to have muffled sound effect then just uncomment this below.
        interiorIdentifier = nil,

        -- max value is 1.0
        -- 1.0 = 100% volume
        defaultVolume = 0.5,
        --jobs = {"police","other job"}, -- if left nil everyone will be able to open it

        -- if this is set to true it will not try to disable music around you from in-game world
        skipEmitterForThis = false,
    },
    -----------------------------
    ["Sisyphus"] = {
        mixer = {
            {
                pos = vec3(200.129929, 1165.890991, 227.004898),
                distance = 5,

                -- this will teleport player infront of the mixer so he stands correctly
                teleportPlayer = {
                    pos = vector3(200.02, 1165.9, 227),
                    heading = 103.22,

                    animDict = Config.AnimDictMixerIdle,
                    animClip = Config.AnimClipMixerIdle,
                },
            },
        },
        speaker = {
            {
                pos = vec3(169.950256, 1157.810913, 233.494263),
                distance = 100.0,
            },
        },

        -- if you want to hear muffled sound if outside interior then set the interior ID here
        -- you can check what interior ID you're in by enabling "Config.InteriorDebug" in this very config.lua
        --interiorIdentifier = {
        --    [271617] = true
        --},

        -- if you do not wish to have muffled sound effect then just uncomment this below.
        interiorIdentifier = nil,

        -- max value is 1.0
        -- 1.0 = 100% volume
        defaultVolume = 0.5,
        --jobs = {"police","other job"}, -- if left nil everyone will be able to open it

        -- if this is set to true it will not try to disable music around you from in-game world
        skipEmitterForThis = false,
    },
    -----------------------------
    -- default interior
    ["Bahama Mamas"] = {
        mixer = {
            {
                pos = vec3(-1381.943848, -614.373230, 31.497889),
                distance = 5,

                -- this will teleport player infront of the mixer so he stands correctly
                teleportPlayer = {
                    pos = vector3(-1382.169189, -614.539734, 31.497890),
                    heading = 121.22,

                    animDict = Config.AnimDictMixerIdle,
                    animClip = Config.AnimClipMixerIdle,
                },
            },
        },
        speaker = {
            {
                pos = vec3(-1387.117432, -620.849243, 30.819593),
                distance = 30.0,
            },
        },

        -- if you want to hear muffled sound if outside interior then set the interior ID here
        -- you can check what interior ID you're in by enabling "Config.InteriorDebug" in this very config.lua
        interiorIdentifier = {
            [168961] = true
        },

        -- if you do not wish to have muffled sound effect then just uncomment this below.
        --interiorIdentifier = nil,

        -- max value is 1.0
        -- 1.0 = 100% volume
        defaultVolume = 0.5,
        --jobs = {"police","other job"}, -- if left nil everyone will be able to open it

        -- if this is set to true it will not try to disable music around you from in-game world
        skipEmitterForThis = false,
    },

    -- cfx-gabz-bahama
    --[[
    ["Bahama Mamas"] = {
        mixer = {
            {
                pos = vec3(-1376.87, -607.71, 31.32),
                distance = 5,

                -- this will teleport player infront of the mixer so he stands correctly
                teleportPlayer = {
                    pos = vec3(-1376.87, -607.71, 31.32),
                    heading = 126.27,

                    animDict = Config.AnimDictMixerIdle,
                    animClip = Config.AnimClipMixerIdle,
                },
            },
        },
        speaker = {
            {
                pos = vec3(-1390.41, -616.69, 31.32),
                distance = 30.0,
            },
        },

        -- if you want to hear muffled sound if outside interior then set the interior ID here
        -- you can check what interior ID you're in by enabling "Config.InteriorDebug" in this very config.lua
        interiorIdentifier = {
            [121090] = true
        },

        -- if you do not wish to have muffled sound effect then just uncomment this below.
        --interiorIdentifier = nil,

        -- max value is 1.0
        -- 1.0 = 100% volume
        defaultVolume = 0.5,
        --jobs = {"police","other job"}, -- if left nil everyone will be able to open it

        -- if this is set to true it will not try to disable music around you from in-game world
        skipEmitterForThis = false,
    },
    --]]
    -----------------------------
    ["Yellow Jacket"] = {
        mixer = {
            {
                pos = vec3(1987.5, 3051.02, 47.22),
                distance = 5,
            },
        },
        speaker = {
            {
                pos = vec3(1987.5, 3051.02, 47.22),
                distance = 10.0,
            },
        },

        -- if you want to hear muffled sound if outside interior then set the interior ID here
        -- you can check what interior ID you're in by enabling "Config.InteriorDebug" in this very config.lua
        interiorIdentifier = {
            [201217] = true
        },

        -- if you do not wish to have muffled sound effect then just uncomment this below.
        --interiorIdentifier = nil,

        -- max value is 1.0
        -- 1.0 = 100% volume
        defaultVolume = 0.5,
        --jobs = {"police","other job"}, -- if left nil everyone will be able to open it

        -- if this is set to true it will not try to disable music around you from in-game world
        skipEmitterForThis = false,
    },
    -----------------------------
    ["Tequila Bar"] = {
        mixer = {
            {
                pos = vec3(-553.49, 278.6, 82.18),
                distance = 5,
            },
        },
        speaker = {
            {
                pos = vec3(-556, 285, 82),
                distance = 20.0,
            },
        },

        -- if you want to hear muffled sound if outside interior then set the interior ID here
        -- you can check what interior ID you're in by enabling "Config.InteriorDebug" in this very config.lua
        interiorIdentifier = {
            [233729] = true
        },

        -- if you do not wish to have muffled sound effect then just uncomment this below.
        --interiorIdentifier = nil,

        -- max value is 1.0
        -- 1.0 = 100% volume
        defaultVolume = 0.2,
        --jobs = {"police","other job"}, -- if left nil everyone will be able to open it

        -- the range is between 0-100 this mixer will be only able to have 20% volume max
        maxMixerVolume = 20,

        -- if this is set to true it will not try to disable music around you from in-game world
        skipEmitterForThis = false,
    },
    -----------------------------
    ["Cayo Perico"] = {
        mixer = {
            {
                pos = vector3(4893.42, -4905.39, 3.49),
                distance = 5,

                -- this will teleport player infront of the mixer so he stands correctly
                teleportPlayer = {
                    pos = vector3(4893.42, -4905.39, 3.49),
                    heading = 177.21,

                    animDict = Config.AnimDictMixerIdle,
                    animClip = Config.AnimClipMixerIdle,
                },
            },
        },
        speaker = {
            {
                pos = vector3(4893.23, -4924.65, 5.0),
                distance = 40.0,
            },
        },

        -- if you want to hear muffled sound if outside interior then set the interior ID here
        -- you can check what interior ID you're in by enabling "Config.InteriorDebug" in this very config.lua
        --interiorIdentifier = {
        --    [197121] = true
        --},

        -- if you do not wish to have muffled sound effect then just uncomment this below.
        interiorIdentifier = nil,

        -- max value is 1.0
        -- 1.0 = 100% volume
        defaultVolume = 0.5,
        --jobs = {"police","other job"}, -- if left nil everyone will be able to open it

        -- if this is set to true it will not try to disable music around you from in-game world
        skipEmitterForThis = false,
    },
}

Config.SpawnMixerTable = {
    {
        model = "sf_prop_sf_dj_desk_02a",
        pos = vector3(683.8, 570.87, 129.46),
        heading = 161.39,
        renderDistance = 100.0,
    },

    {
        model = "sf_prop_sf_dj_desk_02a",
        pos = vector3(199.58, 1165.72, 226.01),
        heading = 105.42,
        renderDistance = 100.0,
    },

    {
        model = 1945457558,
        pos = vector3(-552.31, 278.56, 81.18),
        heading = -95.0,
        renderDistance = 100.0,
    },
}


-- This will disable all teleport markers on map (from this resource)
Config.EnableTeleportMarker = true

Config.TeleportMarker = {
    {
        entrance = {
            markerPosition = vector3(-577.01, 239.84, 81.8),

            markerStyle = {
                style = 27,
                rotation = true,
                faceCamera = false,

                scale = vector3(2, 2, 1),
                color = { r = 255, g = 255, b = 255, a = 125 },

                keysToOpen = { 38 },
            },

            destination = vector3(-1569.4, -3016.94, -74.41),
            heading = 358.87,
        },

        exit = {
            markerPosition = vector3(-1569.43, -3016.83, -75.3),

            markerStyle = {
                style = 27,
                rotation = true,
                faceCamera = false,

                scale = vector3(1, 1, 1),
                color = { r = 255, g = 255, b = 255, a = 125 },

                keysToOpen = { 38 },
            },

            destination = vector3(-577.01, 239.84, 82.65),
            heading = 352.87,
        },
    },
}

-- this will disable all blips on map (from this resource)
Config.EnableBlipsOnMap = true

Config.BlipList = {
    {
        Position = vector3(-577.01, 239.84, 82.65),
        Sprite = 614,
        Options = {
            name = "Galaxy club",
            type = 4,
            scale = 1.0,
            shortRange = true,
        },
    },
}

-- see in worldeffects/config/*.lua
Config.WorldEffects = {}

SoundsEffects = {
    {
        Name = "Countdown from 10 to 0 and hyping on end",
        URL = "https://www.youtube.com/watch?v=iwYDfyCABAc",
    },

    {
        Name = "Count down from 5 to 1 and hyping on end",
        URL = "https://www.youtube.com/watch?v=LZyIgCOeLLU",
    },
}

-- How much ofter the player position is updated ?
Config.RefreshTime = 300

-- how much close player has to be to the sound before starting updating position ?
Config.distanceBeforeUpdatingPos = 40

-- lowpass intensity the lower the number is the more hard it will be to hear the sound
-- like it is far away behind door
-- the higher the number will be the opposite will happen
Config.LowpassIntensity = 500

-- Message list
Config.Messages = {
    ["streamer_on"] = "Streamer mode is on. From now you will not hear any music/sound.",
    ["streamer_off"] = "Streamer mode is off. From now you will be able to listen to music that players might play.",
}

-- if set true you will see on your screen in what interior ID you're in
Config.InteriorDebug = false

-------------------------
-------------------------
-------------------------
-- if you're going to use external xsound alot of effects wont work from xdiskjockey so I dont recommend switching anything to true from below.
-------------------------
-------------------------
-------------------------
-- external xsound?
Config.UseExternalxSound = false

-- if you want to use high_3dsounds
Config.UseHighSound = false

-- if you want to use mx-surround
Config.MXSurround = false

-- name of the lib
Config.xSoundName = "xsound"

if Config.MXSurround then
    Config.UseExternalxSound = true
    Config.xSoundName = "mx-surround"
end

if Config.UseHighSound then
    Config.xSoundName = "high_3dsounds"
    Config.UseExternalxSound = true
end