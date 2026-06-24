Config = Config or {}

--------------------------------------------------------------------
-- CORE SETTINGS
--------------------------------------------------------------------

-- 'auto' | 'QBCORE' | 'ESX' | 'STANDALONE'
-- 'auto' will detect qb-core, qbx_core, or es_extended automatically
Config.Framework = 'auto'

-- Notification system: 'auto' | 'ox_lib' | 'okokNotify' | 'native'
-- 'auto' = tries ox_lib > okokNotify > framework > native
Config.Notifications = 'auto'

-- Target integration: 'auto' | 'ox' | 'qb' | 'none'
Config.TargetMode = 'auto'

-- Available locales:
-- 'en','es','fr','de','it','pt','nl','sv','da','no','fi','pl','cs','hu','ro','bg','el','ru',
-- 'tr','tk','ar','ja','jp','zh','ch'
Config.Locale = 'en'

-- Enable extra prints for debugging
Config.Debug = false


--------------------------------------------------------------------
-- INVENTORY / MONEY HANDLING
--------------------------------------------------------------------

Config.Inventory = {
    -- 'auto' will try to detect the inventory system (ox_inventory, qs-inventory, etc.)
    Mode = 'auto',

    QBCore = {
        cashAccount       = 'cash',
        blackMoneyAccount = nil,            -- Set to a money account name if using account-based dirty money
        blackMoneyAsItem  = true,           -- true = give dirty money as an item (e.g. markedbills)
        blackMoneyItem    = 'markedbills',
        blackMoneyField   = 'worth',        -- Metadata field for the amount
    },

    ESX = {
        cashAccount       = 'money',
        blackMoneyAccount = 'black_money',
        blackMoneyAsItem  = false,
        blackMoneyItem    = 'black_money',
        blackMoneyField   = nil,
    }
}


--------------------------------------------------------------------
-- LOOT CONFIGURATION
--------------------------------------------------------------------

Config.Loot = {
    cash = {
        chance = 0,     -- % chance (0-100)
        min    = 50,
        max    = 150,
    },

    black_money = {
        chance = 0,
        min    = 50,
        max    = 150,
    },

    -- Extra loot items
    items = {
        {
            name   = "black_money",
            chance = 100,
            min    = 100,
            max    = 500,
        },
        {
            name   = "phone",
            chance = 7,
            min    = 1,
            max    = 1,
        },
    }
}


--------------------------------------------------------------------
-- ROBBERY / AIMING SETTINGS
--------------------------------------------------------------------

Config.MaxRayDistance  = 8.0
Config.RayRadius      = 0.25
Config.TargetKeepMs   = 2000
Config.AimLostGraceMs = 1000
Config.RobberyWindowMs = 30000

-- Weapons allowed for robbery
Config.AllowedWeapons = {
    `WEAPON_PISTOL`,
    `WEAPON_COMBATPISTOL`,
    `WEAPON_PISTOL_MK2`,
    `WEAPON_PISTOL50`,
    `WEAPON_REVOLVER`,
    `WEAPON_REVOLVER_MK2`,
    `WEAPON_DOUBLEACTION`,
    `WEAPON_NAVYREVOLVER`,
    `WEAPON_CERAMICPISTOL`,
    `WEAPON_MICROSMG`,
    `WEAPON_MINISMG`,
    `WEAPON_MACHINEPISTOL`,
    `WEAPON_SAWNOFFSHOTGUN`,
    `WEAPON_DBSHOTGUN`,
    `WEAPON_KNIFE`,
    `WEAPON_SWITCHBLADE`,
    `WEAPON_DAGGER`,
    `WEAPON_APPISTOL`,
    `WEAPON_SNSPISTOL`,
    `WEAPON_SNSPISTOL_MK2`,
    `WEAPON_HEAVYPISTOL`,
    `WEAPON_VINTAGEPISTOL`,
    `WEAPON_MARKSMANPISTOL`,
}

-- NPC resist chance (0.0 = never, 1.0 = always)
Config.ResistChance = 0.15

-- Weapons NPCs may use when resisting
Config.NPCResistWeapons = {
    `WEAPON_PISTOL`,
    `WEAPON_COMBATPISTOL`,
    `WEAPON_KNIFE`,
    `WEAPON_SWITCHBLADE`,
}

-- Fallback interaction key (for 3D help text mode)
Config.InteractKey = 38  -- E

-- Following behavior
Config.FollowDistance      = 2.0
Config.FollowSpeedWalk     = 1.3
Config.FollowSpeedRun      = 2.0
Config.EnterVehicleTimeout = 8000


--------------------------------------------------------------------
-- SKILLCHECK (requires ox_lib)
--------------------------------------------------------------------

Config.Skillcheck = {
    Enabled    = false,          -- Set to true to require skillcheck before looting
    Difficulty = {'easy'},       -- {'easy'}, {'easy','easy','medium'}, etc.
    Inputs     = {'w','a','s','d'},
}


--------------------------------------------------------------------
-- HOSTAGE ANIMATIONS
--------------------------------------------------------------------

Config.HostageAnim = {
    perpDict   = "anim@gangops@hostage@",
    perpAnim   = "perp_idle",
    victimDict = "anim@gangops@hostage@",
    victimAnim = "victim_idle"
}


--------------------------------------------------------------------
-- DISPATCH & POLICE REQUIREMENTS
--------------------------------------------------------------------

Config.MinPolice  = 0
Config.PoliceJobs = { 'police', 'sheriff' }

Config.Dispatch = {
    Enabled = true,

    -- Supported:
    -- 'origen_police' | 'cd_dispatch' | 'qs-dispatch' | 'ps-dispatch'
    -- 'rcore_dispatch' | 'sonoran_cad' | 'default' | 'test' | 'none'
    System = 'ps-dispatch',

    Title   = 'ASSAULT',
    Message = 'Civilian Assault on-going',
    Jobs    = { 'police' },

    Blip = {
        sprite  = 431,
        scale   = 1.2,
        colour  = 3,
        flashes = false,
        text    = '911 - Civilian Assault',
        time    = 5,
        radius  = 0,
    },

    RCore = {
        code      = '10-64',
        priority  = 'high',
        type      = 'alerts',
        blip_time = 5,
    }
}


--------------------------------------------------------------------
-- TIMERS & COOLDOWNS
--------------------------------------------------------------------

Config.KneelAutoLeaveSeconds = 15
Config.PostMoneyLeaveSeconds = 10
Config.CooldownSameNPCMs    = 10 * 60 * 1000  -- 10 minutes
Config.GlobalCooldownMs      = 30 * 1000       -- 30s between ANY robbery (anti-spam)

-- Maximum number of NPCs you can control simultaneously
Config.MaxControlledNPCs     = 5

-- Loot prop on the ground
Config.LootProp = `prop_cs_cashenvelope`


--------------------------------------------------------------------
-- BLACKLISTS
--------------------------------------------------------------------

Config.BlacklistedModels = {
    -- Shop / store keepers
    `mp_m_shopkeep_01`, `s_f_y_shop_low`, `s_f_y_shop_mid`, `s_f_m_shop_high`,
    `s_m_y_ammucity_01`, `s_m_m_linecook`,
    -- Security
    `s_m_m_security_01`, `s_m_m_highsec_01`, `s_m_m_highsec_02`, `s_m_m_bouncer_01`,
    `s_m_m_prisguard_01`, `s_m_m_armoured_01`, `s_m_m_armoured_02`,
    -- Law enforcement
    `s_m_y_cop_01`, `s_m_y_sheriff_01`, `s_m_y_hwaycop_01`,
    -- Emergency services
    `s_m_m_paramedic_01`, `s_m_y_fireman_01`,
    -- Workers
    `s_m_m_autoshop_01`, `s_m_m_autoshop_02`, `s_m_y_xmech_01`, `s_m_y_xmech_02_mp`,
    -- Special
    `cs_lifeinvad_01`,
}

Config.BlacklistedRelGroups = {
    `COP`,
    `SECURITY_GUARD`,
    `FIREMAN`,
    `MEDIC`,
}


--------------------------------------------------------------------
-- HOSTAGE CONFIG
--------------------------------------------------------------------

Config.Hostage = {
    releaseKey = 38,  -- E
    killKey    = 47,  -- G

    perpDict   = "anim@gangops@hostage@",
    perpAnim   = "perp_idle",
    victimDict = "anim@gangops@hostage@",
    victimAnim = "victim_idle",

    attach = {
        bone = 0,
        x    = -0.24,
        y    = 0.11,
        z    = 0.0,
        xr   = 0.5,
        yr   = 0.5,
        zr   = 0.0,
    }
}


--------------------------------------------------------------------
-- DISCORD WEBHOOK
--------------------------------------------------------------------

Config.Webhook = {
    url       = "https://discord.com/api/webhooks/1485433474868576286/ujYmx0aofZbS6OMT57SfhUOjKsGjwGBBX5ncH5ofd9kXyDzZCjVbb5S9DVrazEyYvN50", -- Put your discord webhook here
    username  = "Synz Labs Hostage System",
    avatar    = "https://synzlabs.com/assets/img/dc-logo.png",
    serverTag = "Synz Labs", -- name of your server
}
