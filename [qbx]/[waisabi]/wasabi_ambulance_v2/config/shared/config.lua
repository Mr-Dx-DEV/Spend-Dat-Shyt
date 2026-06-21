-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
local config = {

    -------------------------------------------------------------------------------------------------------------
    --                                   FIRST TIME CONFIGURATION NOTE:                                        --
    -- * If not using ox_inventory, set inventoryImagePath to have images show properly.                       --
    -- * Hopsitals/Facilities can be set up by executing the command: /facilitypanel while in an admin group.  --
    -------------------------------------------------------------------------------------------------------------

    debug = false,

    treatmentDuration = 4000, -- Duration in ms for facility treatment progress bar (should match server minTreatmentTime)

    -- Legacy compatibility toggles
    compatibility = {
        -- Enables the deprecated client-side revive event (`TriggerEvent('wasabi_ambulance:revive')`).
        -- Not recommended: client-side revive triggers are easy to abuse. Keep disabled unless an older integration requires it.
        clientReviveEvent = false,

        -- Enables a client-side compatibility heal event (`TriggerEvent('wasabi_ambulance:heal')`).
        -- This lets older/client-only admin menus request a self heal. Keep disabled unless an integration requires it.
        clientHealEvent = false,
    },

    inventoryImagePath = "nui://ox_inventory/web/images/",
    -- Ox inventory path is "nui://ox_inventory/web/images/"
    -- QBCore inventory path is "nui://qb-inventory/html/images/"
    -- Jaksam inventory path is "nui://jaksam_inventory/_images/"
    -- Tgiann inventory path is "nui://inventory_images/images/"
    -- Codem inventory path is "nui://codem-inventory/html/itemimages/"

    -- Diagnose Patient
    -- Jobs/groups that can inspect, treat, and revive patients
    -- Supports two formats:
    --   Array of strings (any grade): { 'ambulance', 'ems', 'doctor' }
    --   Hash with minimum grade:      { ambulance = 0, ems = 2, doctor = 3 }
    ambulanceJobs = {
        'ambulance',
        'ems',
        'doctor',
        'admin',
    },

    --- Inventory Settings for job lockers
    personalLocker = {
        weight = 50000,
        slots = 30
    },

    -- Death state constants (shared between client and server)
    -- Internal state uses 0/1/2, but isDead state bags use boolean for framework compatibility
    deathStates = {
        ALIVE = 0,
        LAST_STAND = 1,
        DEAD = 2,
    },

    -- State bag name for internal death state tracking (0/1/2)
    -- isDead remain boolean (true/false) for framework compatibility
    internalDeathStateBag = 'wasabi:deathState',

    --- Dispatch Settings
    --- Supported types: "internal", "cd_dispatch", "ps-dispatch", "none"
    dispatch = {
        type = "internal", -- Type of dispatch system to use
        allowedJobs = {    -- Jobs that can access the internal dispatch menu / receive dispatch alerts
            'ambulance',
            'ems',
            'doctor',
        },
        keybind = 'F6',        -- Default keybind for the dispatch menu (internal only)
        distressCooldown = 45, -- Cooldown (in seconds) before player can ping EMS again
    },

    --- Respawn Settings
    respawn = {
        respawnTime = 180,                    -- Time (in seconds) before a player can respawn
        forcedRespawnTime = 600,              -- Time (in seconds) before a player is forced to respawn    
        wipeItems = true,                           -- Whether or not to wipe items when respawning
        itemsToKeep = { 'water', 'bandage' },       -- These items will be kept when respawning
        keepItemsIfNoEMS = true,                    -- Whether or not to keep items if EMS is not available
        allowClientStandaloneRespawn = true,        -- Allow client listener to request a standalone facility for jail/prison systems with client-only checks
        keepItemsOnDeathScreenCheckIn = false,           -- Keep inventory when using the death screen Check In button near a facility check-in point
    },

    --- wasabi_crutch Compatibility
    --- Requires wasabi_crutch to be started. Duration values are in minutes.
    wasabiCrutch = {
        enabled = true,     -- Master toggle for all wasabi_crutch compatibility below
        defaultDuration = 3, -- Default crutch duration when a flow does not override duration

        hospitalRespawn = {
            enabled = true, -- Give crutch after normal hospital/facility respawn completes
            duration = 15,
        },

        standaloneCheckIn = {
            enabled = true, -- Give crutch after standalone/special facility respawn completes
            duration = 15,
        },

        normalCheckIn = {
            enabled = true, -- Give crutch after normal check-in treatment completes
            duration = 15,
        },

        policeRespawn = {
            enabled = false, -- Give crutch after body bag police respawn completes
            duration = 3,
        },
    },

    medicalItems = {
        medkit = { healAmount = 300 },
        bandage = { healAmount = 150 },
        forceps = { healType = "gunshot", healAmount = 50 },
        pliers = { healType = "taser", healAmount = 50 },
        suture = { healType = "cut", healAmount = 50 },
        splint = { healType = "brokenbone", healAmount = 50 },
        burncream = { healType = "burn", healAmount = 50 },
        icepack = { healType = "fist", healAmount = 50 },
        traumakit = { healType = "blunt", healAmount = 50 },
    },

    -- Jobs/groups allowed to use configured healingItems below.
    -- Defaults to ambulanceJobs when nil. Set false to allow anyone to use healingItems.
    healingItemJobs = nil,

    -- Supported per-item options:
    -- requiredJob = nil,             -- nil uses healingItemJobs/ambulanceJobs; false allows anyone; string/array/grade table restricts to jobs/groups
    -- healAmount = 25,               -- instant health amount
    -- fullHeal = false,              -- fully heals health and clears limb injuries
    -- healOverTime = { amount = 5, interval = 1000, duration = 5000 },
    -- healOthers = true,             -- allows EMS to treat closest player instead of self only
    -- useTime = 3000,                -- progress duration in ms
    -- progress = { ... },            -- label/useWhileDead/canCancel/disable/anim/prop
    -- statusEffects = { ... },       -- remove/pause statuses like bleed, stun, limp
    -- removeItem = true,             -- removes item after successful use
    ---@type table<string, WasabiAmbulanceHealingItemConfig>
    healingItems = {
        ['bandage'] = {
            -- requiredJob = false, -- Uncomment to allow anyone to use this item despite global healingItemJobs restriction.
            healAmount = 50,
            remove = 1,
            healOverTime = {
                amount = 5,
                interval = 1000,
                duration = 5000,
            },
            useTime = 3000,
            progress = {
                label = "Applying bandage...",
                useWhileDead = false,
                canCancel = true,
                disable = {
                    move = true,
                    car = true,
                    combat = true,
                },
                anim = {
                    self = {
                        dict = "missmic4",
                        clip = "michael_tux_fidget",
                    },
                    others = {
                        dict = "mini@repair",
                        clip = "fixing_a_player",
                    }

                },
            },
            statusEffects = {
                bleed = {
                    action = "remove",
                    amount = 15,
                    removeChance = 75, -- 75% chance to remove, 25% chance to just pause
                    pauseDuration = 10000,
                },
            },
            healOthers = true, -- If true, the item will heal closest player to the player using the item (If they are config.ambulanceJobs)
            removeItem = true,
        },
        ['medkit'] = {
            remove = 1,
            healAmount = 100,
            healOverTime = {
                amount = 10,
                interval = 1000,
                duration = 10000,
            },
            useTime = 5000,
            progress = {
                label = "Using medkit...",
                useWhileDead = false,
                canCancel = true,
                disable = {
                    move = true,
                    car = true,
                    combat = true,
                },
                anim = {
                    self = {
                        dict = "missmic4",
                        clip = "michael_tux_fidget",
                    },
                    others = {
                        dict = "mini@repair",
                        clip = "fixing_a_player",
                    }
                },
            },
            statusEffects = {
                bleed = {
                    action = "remove",
                    amount = 50,
                    removeChance = 90,
                    pauseDuration = 15000,
                },
            },
            healOthers = true,
            removeItem = true,
        },
        ['firstaidkit'] = {
            remove = 1,
            healAmount = 75,
            fullHeal = false, -- If true, fully heals player health and clears all limb injuries
            healOverTime = {
                amount = 15,
                interval = 1500,
                duration = 15000,
            },
            useTime = 7000,
            progress = {
                label = "Applying first aid...",
                useWhileDead = false,
                canCancel = true,
                disable = {
                    move = true,
                    car = true,
                    combat = true,
                },
                anim = {
                    self = {
                        dict = "missmic4",
                        clip = "michael_tux_fidget",
                    },
                },
            },
            statusEffects = {
                bleed = {
                    action = "remove",
                    amount = 100,
                    removeChance = 100,
                },
                stun = {
                    action = "remove",
                    amount = 50,
                },
            },
            removeItem = true,
        },
        ['painkillers'] = {
            remove = 1,
            healAmount = 25,
            useTime = 2000,
            progress = {
                label = "Taking painkillers...",
                useWhileDead = false,
                canCancel = true,
                disable = {
                    move = false,
                    car = false,
                    combat = true,
                },
                anim = {
                    self = {
                        dict = "mp_suicide",
                        clip = "pill",
                    },
                },
            },
            statusEffects = {
                stun = {
                    action = "pause",
                    pauseDuration = 30000,
                },
            },
            removeItem = true,
        },
        ['ifak'] = {
            remove = 1,
            healAmount = 35,
            healOverTime = {
                amount = 8,
                interval = 1000,
                duration = 8000,
            },
            useTime = 4000,
            progress = {
                label = "Using IFAK...",
                useWhileDead = false,
                canCancel = true,
                disable = {
                    move = true,
                    car = true,
                    combat = true,
                },
                anim = {
                    self = {
                        dict = "missmic4",
                        clip = "michael_tux_fidget",
                    },
                },
            },
            statusEffects = {
                bleed = {
                    action = "remove",
                    amount = 35,
                    removeChance = 85,
                    pauseDuration = 12000,
                },
            },
            removeItem = true,
        },
    },

    medBag = {
        model = `xm_prop_x17_bag_med_01a`,
        allowedJobs = nil, -- Jobs/groups allowed to use/open medbags. Defaults to ambulanceJobs when nil. Set false to allow anyone.
        -- Add offset and bone for the med bag
        --offset = { x = 0.0, y = 0.0, z = 0.0 },
        --bone = 'bag_med_01a',
        items = {
            --  { 'water',     10, 'Water' }, -- Item, amount, label (Amount will not apply to non-metadata inventories)
            { 'bandage',   100, 'Bandage' },
            { 'medkit',    100, 'Medkit' },
            { 'forceps',   100, 'Forceps' },
            { 'pliers',    100, 'Pliers' },
            { 'suture',    100, 'Suture' },
            { 'splint',    100, 'Splint' },
            { 'burncream', 100, 'Burn Cream' },
            { 'icepack',   100, 'Ice Pack' },
            { 'traumakit', 100, 'Trauma Kit' },
        },
    },

    bodybag = {
        enabled = true,
        target = true,                              -- Adds a player target option for EMS jobs
        command = 'bodybag',                        -- Set false to disable the command fallback
        allowedJobs = nil,                          -- Defaults to ambulanceJobs; supports array or grade table
        distance = 2.5,
        placeDuration = 5000,
        prop = `xm_prop_body_bag`,
        respawnTime = 120,                          -- Custom time for respawning when placed in a body bag
        scenario = 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', -- This will be used first, set to false if you want to use dict/clip below
        animation = {                               -- This is used if scenario is false/nil
            dict = 'amb@medic@standing@kneel@base',
            clip = 'base'
        },
        policeRespawn = {
            enabled = true,
            jobs = { 'police', 'sheriff' },
            policeRespawnTime = 60,                 -- Default timer for all policeRespawn jobs; location respawnTime overrides this per job
            removeItemsOnRespawn = false,           -- Default item wipe behavior for all policeRespawn jobs; location removeItemsOnRespawn overrides this per job
            locations = {
                -- respawnTime/removeItemsOnRespawn below are optional per-job overrides; omit them to use the defaults above
                police = { coords = vec3(486.12, -991.68, 30.69), heading = 92.72, respawnTime = 60, removeItemsOnRespawn = false },
                sheriff = { coords = vec3(1851.63, 3685.90, 34.27), heading = 211.20, respawnTime = 60, removeItemsOnRespawn = false },
            }
        }
    },

    stretcher = {
        enabled = true,
        model = `wasabi_stretcher`,
        stretcherKey = 38,

        allowedJobs = {
            'ambulance',
            -- 'ems',
            -- 'doctor',
        },

        holdingOffset = {
            pos = { x = -0.032, y = -0.716, z = -1.269 },
            rot = { x = 16.489, y = 1.863, z = -1.3292 }
        },

        occupyingOffset = {
            pos = { x = 0.0, y = 0.0, z = 1.9 },
            rot = { x = 0.0, y = 0.0, z = 180.0 }
        },

        ambulanceOffsets = {
            [`ambulance`] = {
                trunkAsBackDoor = false,
                pos = { x = 0.15, y = -3.0, z = 0.00 },
                rot = { x = -1.3, y = 0.0, z = 90.0 }
            },
            -- Add more ambulance models here
            -- ['ambulance2'] = {
            --     trunkAsBackDoor = true,
            --     pos = { x = -0.26, y = -1.3, z = 0.3 },
            --     rot = { x = -1.3, y = 0.0, z = 360.0 }
            -- },
        },
    },

    -- Mapping of weapon hash to injury types and labels for the death screen
    -- injury types: "fist", "blunt", "cut", "gunshot", "taser", "burn", "brokenbone"
    weaponInjuries = {
        -- MELEE: FIST --
        [`WEAPON_UNARMED`] = { ["injuries"] = { "fist" }, ["label"] = "Fist" },

        -- MELEE: BLUNT --
        [`WEAPON_KNUCKLE`] = { ["injuries"] = { "blunt" }, ["label"] = "Brass Knuckles" },
        [`WEAPON_BAT`] = { ["injuries"] = { "blunt" }, ["label"] = "Baseball Bat" },
        [`WEAPON_BALL`] = { ["injuries"] = { "blunt" }, ["label"] = "Baseball" },
        [`WEAPON_CROWBAR`] = { ["injuries"] = { "blunt" }, ["label"] = "Crowbar" },
        [`WEAPON_FLASHLIGHT`] = { ["injuries"] = { "blunt" }, ["label"] = "Flashlight" },
        [`WEAPON_GOLFCLUB`] = { ["injuries"] = { "blunt" }, ["label"] = "Golf Club" },
        [`WEAPON_HAMMER`] = { ["injuries"] = { "blunt" }, ["label"] = "Hammer" },
        [`WEAPON_NIGHTSTICK`] = { ["injuries"] = { "blunt" }, ["label"] = "Nightstick" },
        [`WEAPON_POOLCUE`] = { ["injuries"] = { "blunt" }, ["label"] = "Pool Cue" },
        [`WEAPON_WRENCH`] = { ["injuries"] = { "blunt" }, ["label"] = "Wrench" },
        [`WEAPON_FALL`] = { ["injuries"] = { "blunt" }, ["label"] = "Fall" },
        [`WEAPON_RUN_OVER_BY_CAR`] = { ["injuries"] = { "blunt" }, ["label"] = "Run Over by Car" },
        [`WEAPON_RAMMED_BY_CAR`] = { ["injuries"] = { "blunt" }, ["label"] = "Rammed by Car" },

        -- MELEE: CUT --
        [`WEAPON_BOTTLE`] = { ["injuries"] = { "cut" }, ["label"] = "Bottle" },
        [`WEAPON_DAGGER`] = { ["injuries"] = { "cut" }, ["label"] = "Dagger" },
        [`WEAPON_HATCHET`] = { ["injuries"] = { "cut" }, ["label"] = "Hatchet" },
        [`WEAPON_KNIFE`] = { ["injuries"] = { "cut" }, ["label"] = "Knife" },
        [`WEAPON_MACHETE`] = { ["injuries"] = { "cut" }, ["label"] = "Machete" },
        [`WEAPON_BATTLEAXE`] = { ["injuries"] = { "cut" }, ["label"] = "Battle Axe" },
        [`WEAPON_SWITCHBLADE`] = { ["injuries"] = { "cut" }, ["label"] = "Switchblade" },
        [`WEAPON_STONE_HATCHET`] = { ["injuries"] = { "cut" }, ["label"] = "Stone Hatchet" },

        -- GUNS --
        -- pistols
        [`WEAPON_PISTOL`] = { ["injuries"] = { "gunshot" }, ["label"] = "Pistol" },
        [`WEAPON_PISTOL_MK2`] = { ["injuries"] = { "gunshot" }, ["label"] = "Pistol MK2" },
        [`WEAPON_COMBATPISTOL`] = { ["injuries"] = { "gunshot" }, ["label"] = "Combat Pistol" },
        [`WEAPON_PISTOL50`] = { ["injuries"] = { "gunshot" }, ["label"] = "Pistol 50" },
        [`WEAPON_SNSPISTOL`] = { ["injuries"] = { "gunshot" }, ["label"] = "SNS Pistol" },
        [`WEAPON_HEAVYPISTOL`] = { ["injuries"] = { "gunshot" }, ["label"] = "Heavy Pistol" },
        [`WEAPON_APPISTOL`] = { ["injuries"] = { "gunshot" }, ["label"] = "Appistol" },
        [`WEAPON_MACHINEPISTOL`] = { ["injuries"] = { "gunshot" }, ["label"] = "Machine Pistol" },
        [`WEAPON_DOUBLEACTION`] = { ["injuries"] = { "gunshot" }, ["label"] = "Double Action" },
        [`WEAPON_MARKSMANPISTOL`] = { ["injuries"] = { "gunshot" }, ["label"] = "Markman Pistol" },
        [`WEAPON_REVOLVER`] = { ["injuries"] = { "gunshot" }, ["label"] = "Revolver" },
        [`WEAPON_VINTAGEPISTOL`] = { ["injuries"] = { "gunshot" }, ["label"] = "Vintage Pistol" },

        -- shotguns
        [`WEAPON_PUMPSHOTGUN`] = { ["injuries"] = { "gunshot" }, ["label"] = "Pump Shotgun" },
        [`WEAPON_PUMPSHOTGUN_MK2`] = { ["injuries"] = { "gunshot" }, ["label"] = "Pump Shotgun MK2" },
        [`WEAPON_MUSKET`] = { ["injuries"] = { "gunshot" }, ["label"] = "Musket" },
        [`WEAPON_ASSAULTSHOTGUN`] = { ["injuries"] = { "gunshot" }, ["label"] = "Assault Shotgun" },
        [`WEAPON_AUTOSHOTGUN`] = { ["injuries"] = { "gunshot" }, ["label"] = "Auto Shotgun" },
        [`WEAPON_BULLPUPSHOTGUN`] = { ["injuries"] = { "gunshot" }, ["label"] = "Bullpup Shotgun" },
        [`WEAPON_DBSHOTGUN`] = { ["injuries"] = { "gunshot" }, ["label"] = "DB Shotgun" },
        [`WEAPON_HEAVYSHOTGUN`] = { ["injuries"] = { "gunshot" }, ["label"] = "Heavy Shotgun" },
        [`WEAPON_SAWNOFFSHOTGUN`] = { ["injuries"] = { "gunshot" }, ["label"] = "Sawed Off Shotgun" },

        -- SMGs --
        [`WEAPON_SMG`] = { ["injuries"] = { "gunshot" }, ["label"] = "SMG" },
        [`WEAPON_SMG_MK2`] = { ["injuries"] = { "gunshot" }, ["label"] = "SMG MK2" },
        [`WEAPON_GUSENBERG`] = { ["injuries"] = { "gunshot" }, ["label"] = "Gusenberg" },
        [`WEAPON_ASSAULTSMG`] = { ["injuries"] = { "gunshot" }, ["label"] = "Assault SMG" },
        [`WEAPON_COMBATPDW`] = { ["injuries"] = { "gunshot" }, ["label"] = "Combat PDW" },
        [`WEAPON_MICROSMG`] = { ["injuries"] = { "gunshot" }, ["label"] = "Micro SMG" },
        [`WEAPON_MINISMG`] = { ["injuries"] = { "gunshot" }, ["label"] = "Mini SMG" },

        -- MACHINE GUNS --
        [`WEAPON_COMBATMG`] = { ["injuries"] = { "gunshot" }, ["label"] = "Combat MG" },
        [`WEAPON_MG`] = { ["injuries"] = { "gunshot" }, ["label"] = "MG" },

        -- RIFLES --
        [`WEAPON_CARBINERIFLE`] = { ["injuries"] = { "gunshot" }, ["label"] = "Carbine Rifle" },
        [`WEAPON_CARBINERIFLE_MK2`] = { ["injuries"] = { "gunshot" }, ["label"] = "Carbine Rifle MK2" },
        [`WEAPON_COMPACTRIFLE`] = { ["injuries"] = { "gunshot" }, ["label"] = "Compact Rifle" },
        [`WEAPON_ADVANCEDRIFLE`] = { ["injuries"] = { "gunshot" }, ["label"] = "Advanced Rifle" },
        [`WEAPON_ASSAULTRIFLE`] = { ["injuries"] = { "gunshot" }, ["label"] = "Assault Rifle" },
        [`WEAPON_BULLPUPRIFLE`] = { ["injuries"] = { "gunshot" }, ["label"] = "Bullpup Rifle" },
        [`WEAPON_SPECIALCARBINE`] = { ["injuries"] = { "gunshot" }, ["label"] = "Special Carbine" },
        [`WEAPON_MARKSMANRIFLE`] = { ["injuries"] = { "gunshot" }, ["label"] = "Markman Rifle" },

        -- SNIPERS --
        [`WEAPON_HEAVYSNIPER`] = { ["injuries"] = { "gunshot" }, ["label"] = "Heavy Sniper" },
        [`WEAPON_SNIPERRIFLE`] = { ["injuries"] = { "gunshot" }, ["label"] = "Sniper Rifle" },

        -- TASER --
        [`WEAPON_STUNGUN`] = { ["injuries"] = { "taser" }, ["label"] = "Stun Gun" },

        -- BURN / EXPLOSIVES --
        [`WEAPON_FIRE`] = { ["injuries"] = { "burn" }, ["label"] = "Fire" },
        [`WEAPON_BZGAS`] = { ["injuries"] = { "burn" }, ["label"] = "BZ Gas" },
        [`WEAPON_FIREEXTINGUISHER`] = { ["injuries"] = { "burn" }, ["label"] = "Fire Extinguisher" },
        [`WEAPON_FIREWORK`] = { ["injuries"] = { "burn" }, ["label"] = "Firework" },
        [`WEAPON_FLARE`] = { ["injuries"] = { "burn" }, ["label"] = "Flare" },
        [`WEAPON_FLAREGUN`] = { ["injuries"] = { "burn" }, ["label"] = "Flare Gun" },
        [`WEAPON_GRENADE`] = { ["injuries"] = { "burn" }, ["label"] = "Grenade" },
        [`WEAPON_GRENADELAUNCHER`] = { ["injuries"] = { "burn" }, ["label"] = "Grenade Launcher" },
        [`WEAPON_HOMINGLAUNCHER`] = { ["injuries"] = { "burn" }, ["label"] = "Homing Launcher" },
        [`WEAPON_MOLOTOV`] = { ["injuries"] = { "burn" }, ["label"] = "Molotov" },
        [`WEAPON_PETROLCAN`] = { ["injuries"] = { "burn" }, ["label"] = "Petrol Can" },
        [`WEAPON_PIPEBOMB`] = { ["injuries"] = { "burn" }, ["label"] = "Pipe Bomb" },
        [`WEAPON_PROXMINE`] = { ["injuries"] = { "burn" }, ["label"] = "Proximity Mine" },
        [`WEAPON_RPG`] = { ["injuries"] = { "burn" }, ["label"] = "RPG" },
        [`WEAPON_SMOKEGRENADE`] = { ["injuries"] = { "burn" }, ["label"] = "Smoke Grenade" },
        [`WEAPON_STICKYBOMB`] = { ["injuries"] = { "burn" }, ["label"] = "Sticky Bomb" },
        [`WEAPON_EXPLOSION`] = { ["injuries"] = { "burn" }, ["label"] = "Explosion" },
    },

    damageFallbacks = {
        [2] = { ["injuries"] = { "blunt" }, ["label"] = "Blunt" },
        [3] = { ["injuries"] = { "gunshot" }, ["label"] = "Gunshot" },
        [5] = { ["injuries"] = { "burn" }, ["label"] = "Explosion" },
        [6] = { ["injuries"] = { "burn" }, ["label"] = "Burn" },
        [8] = { ["injuries"] = { "blunt" }, ["label"] = "Fall" },
        [10] = { ["injuries"] = { "burn" }, ["label"] = "Electric" },
        [11] = { ["injuries"] = { "cut" }, ["label"] = "Barbed Wire" },
    },

    --- Garage Settings
    --- Supported types: "internal"
    --- Future support planned for: "wasabi_garage", "jg_advancedgarage", "cd_garage", "ps_garage",
    --- "qb-garage", "esx_garage"
    garages = {
        enabled = true,
        requireDuty = false, -- If true, player must be on duty to access garage
        type = 'jg_advancedgarage',   -- Type of garage system to use


        -- If type = 'internal', set the garage vehicle options here

        account = 'bank', -- String, account to use for purchasing vehicles

        options = {

            ambulance = {                            -- Job name, this will be used to correlate when accessing the garage
                ownedVehicles = true,                -- If true, the garage will give ownership of vehicle and allow storage of owned vehicles
                plateFormat = 'EMS###',              -- String, format of the plate, use # for random letters and numbers(8 characters max)
                onlyNumbers = true,                  -- Boolean, if true, the plate will only contain numbers for the # characters
                recoveryCost = 200,                  -- Int, cost to recover a vehicle when not stored in garage (If it is lost or stolen)

                ranks = {                            -- Table, ranks that can access the garage

                    [1] = {                          -- Int, rank to access the garage
                        vehicles = {                 -- Table | nil, vehicles that can be accessed by the rank | nil if no vehicles are available for the rank
                            ['ambulance'] = {        -- String, vehicle model game name that will correlate when accessing the garage
                                label = 'Ambulance', -- String, label of the vehicle that will be displayed to the player
                                price = 1000,        -- Int | nil | false, price or false if the vehicle is free
                                type = 'automobile', -- String, type of the vehicle, can be 'automobile', 'bike', 'boat', 'heli', 'plane'
                                maxUpgrades = false, -- Boolean, true if the vehicle has max upgrades, false if the vehicle does not have max upgrades
                            },
                            ['sultan'] = {           -- This is example of available optional vehicle options
                                label = 'Sultan',
                                price = 2000,
                                type = 'automobile', -- String, type of the vehicle, can be 'automobile', 'bike', 'boat', 'heli', 'plane'
                                paint = {
                                    primary = 35,    -- Int | nil | false, primary color index or false (https://docs.fivem.net/docs/game-references/vehicle-references/vehicle-colours/)
                                    secondary = 0,   -- Int | nil | false, secondary color index or false
                                },
                                maxUpgrades = false, -- Boolean, true if the vehicle has max upgrades, false if the vehicle does not have max upgrades
                                livery = 0,          -- Int | nil | false, livery index or false if no livery is available/needed to set for the vehicle
                                extras = {           --Table | nil | false, extras to set for the vehicle | nil if no extras are available/needed to set for the vehicle }
                                    [1] = false,     -- Boolean, true if the extra is enabled, false if the extra is disabled
                                    [2] = false,
                                    [3] = false,
                                    [4] = false,
                                    [5] = false,
                                }
                            },
                        },
                        helicopters = {                  -- Table | nil, helicopters that can be accessed by the rank | nil if no helicopters are available for the rank
                            ['polmav'] = {               -- String, helicopter model game name that will correlate when accessing the garage
                                label = 'Medic Chopper', -- String, label of the helicopter that will be displayed to the player
                                price = 1000,            -- Int | nil | false, price or false if the helicopter is free
                                type = 'heli',           -- String, type of the helicopter, can be 'heli', 'plane'
                                livery = 1,              -- Int | nil | false, livery index or false if no livery is available/needed to set for the vehicles
                            }
                        },
                    },

                    [2] = {
                        vehicles = {
                            ['ambulance'] = {
                                label = 'Ambulance',
                                price = 1000,
                                type = 'automobile',
                            },
                        },
                        helicopters = {
                            ['polmav'] = {
                                label = 'Medic Chopper',
                                price = 1000,
                                type = 'heli',
                                livery = 1,
                            }
                        },
                    },
                },
            },

            --           Example of how to add a new job to the garage:

            --            sheriff = {
            --                ownedVehicles = false,
            --                ranks = {
            ---                    [1] = {
            --                       vehicles = {
            --                            ['sheriff'] = {
            --                                label = 'Sheriff Cruiser',
            --                                price = 1000,
            --                                type = 'automobile',
            --                            },
            --                        },
            --                        helicopters = nil
            --                    },
            --                    [2] = {
            --                       vehicles = {
            --                            ['sheriff'] = {
            --                                label = 'Sheriff Cruiser',
            --                                price = 1000,
            --                                type = 'automobile',
            --                            },
            --                        },
            --                        helicopters = {
            --                            ['sheriffmov'] = {
            --                                label = 'Sheriff Helicopter',
            --                                price = 1000,
            --                                type = 'heli',
            --                            }
            --                        }
            --                    },
            --                },
            --            },
        }
    },

    enviMedic = {            -- if you use Envi-Medic AI Ambulance System, set this to true - https://envi-scripts.tebex.io/package/5969648
        enabled = false,
        maximumEMSCount = 0, -- AI Medic is available only when EMS online is at most this number (0 = when no EMS online, 5 = when 5 or less EMS online) - Check Envi-Medic config and match up!
    },

}

---@ignore
Modules.register('config', config, true)
