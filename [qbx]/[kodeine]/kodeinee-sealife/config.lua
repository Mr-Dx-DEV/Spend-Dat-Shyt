Config = {}

-- =========================================================
-- KODEINEE SEALIFE CONFIG
-- By Kodeinee Studios
-- =========================================================

-- Framework Options:
-- 'auto'       = Auto detect Qbox, QBCore, ESX, then standalone
-- 'qbox'       = qbx_core
-- 'qb'         = qb-core
-- 'esx'        = es_extended
-- 'standalone' = No framework required
Config.Framework = 'auto'

-- Notification Options:
-- 'auto'       = Uses ox_lib if started, then framework notify, then chat
-- 'ox'         = ox_lib notify
-- 'framework'  = QBCore/Qbox/ESX notify through bridge
-- 'chat'       = GTA chat message fallback
-- 'none'       = silent
Config.Notify = 'auto'

-- Inventory setting is included for all-framework compatibility/future expansion.
-- This script does not require inventory items by default.
-- Options: 'auto', 'ox', 'qb', 'ak47_qb', 'qs', 'none'
Config.Inventory = 'auto'

-- Target setting is included for all-framework compatibility/future expansion.
-- This script does not require target by default.
-- Options: 'auto', 'qb', 'ox', 'none'
Config.Target = 'auto'

-- Debug prints in F8/client console.
Config.Debug = false

-- =========================================================
-- GLOBAL WATER SETTINGS
-- =========================================================

-- Only run sea life in ocean-style water, not pools/rivers. Set false to allow any water.
Config.OnlyOcean = true

-- How often the main water checks run in milliseconds.
Config.CheckInterval = 1000

-- =========================================================
-- AMBIENT SEA LIFE
-- These are decoration/atmosphere only. They do NOT kill players.
-- Every animal can be turned on/off with Enabled = true/false.
-- =========================================================

Config.AmbientSealife = {
    Enabled = true,

    -- Only spawn ambient animals while player is swimming/in water.
    -- Set false if you want them to appear when standing near ocean water too.
    SpawnOnlyWhenPlayerInWater = false,

    -- Cleanup animals when player gets this far away from their spawn.
    CleanupDistance = 130.0,

    -- Hard cap per player/client so this stays optimized.
    MaxAmbientAnimals = 12,

    -- How often to try spawning ambient animals.
    SpawnIntervalMs = 9000,

    -- Water animals included in GTA/FiveM.
    Animals = {
        dolphins = {
            Enabled = true,
            Model = 'a_c_dolphin',
            Label = 'Dolphin',
            MaxAlive = 3,
            GroupSizeMin = 1,
            GroupSizeMax = 2,
            MinSpawnDistance = 28.0,
            MaxSpawnDistance = 70.0,
            DepthOffset = -0.5,
            WanderRadius = 45.0,
            SwimSpeed = 5.0,
        },

        humpback_whales = {
            Enabled = true,
            Model = 'a_c_humpback',
            Label = 'Humpback Whale',
            MaxAlive = 1,
            GroupSizeMin = 1,
            GroupSizeMax = 1,
            MinSpawnDistance = 55.0,
            MaxSpawnDistance = 110.0,
            DepthOffset = -2.5,
            WanderRadius = 75.0,
            SwimSpeed = 3.0,
        },

        killer_whales = {
            Enabled = true,
            Model = 'a_c_killerwhale',
            Label = 'Killer Whale',
            MaxAlive = 1,
            GroupSizeMin = 1,
            GroupSizeMax = 1,
            MinSpawnDistance = 50.0,
            MaxSpawnDistance = 95.0,
            DepthOffset = -1.8,
            WanderRadius = 65.0,
            SwimSpeed = 4.0,
        },

        stingrays = {
            Enabled = true,
            Model = 'a_c_stingray',
            Label = 'Stingray',
            MaxAlive = 3,
            GroupSizeMin = 1,
            GroupSizeMax = 2,
            MinSpawnDistance = 18.0,
            MaxSpawnDistance = 45.0,
            DepthOffset = -1.1,
            WanderRadius = 30.0,
            SwimSpeed = 2.0,
        },

        fish = {
            Enabled = true,
            Model = 'a_c_fish',
            Label = 'Fish',
            MaxAlive = 5,
            GroupSizeMin = 2,
            GroupSizeMax = 4,
            MinSpawnDistance = 14.0,
            MaxSpawnDistance = 42.0,
            DepthOffset = -0.8,
            WanderRadius = 25.0,
            SwimSpeed = 2.5,
        },
    }
}

-- =========================================================
-- SHARK ATTACKS
-- Shark attacks are separate from ambient sea life.
-- These are the ONLY animals that damage/kill players.
-- =========================================================

Config.SharkAttacks = {
    Enabled = true,

    -- Seconds the LOCAL player must remain in ocean water before a shark attack starts.
    TimeInWaterBeforeAttack = 30,

    -- Shark model options:
    -- a_c_sharkhammer = Hammerhead Shark
    -- a_c_sharktiger  = Tiger Shark
    SharkModel = 'a_c_sharktiger',

    -- Randomly choose from this list instead of SharkModel if enabled.
    RandomizeSharkModels = true,
    SharkModels = {
        'a_c_sharktiger',
        'a_c_sharkhammer',
    },

    -- Spawn distance around player in meters.
    MinSpawnDistance = 18.0,
    MaxSpawnDistance = 35.0,

    -- How long to keep the shark alive after the encounter in seconds.
    DespawnAfter = 20,

    -- Damage tuning.
    BiteDamage = 35,
    BiteIntervalMs = 650,
    BitesToKill = 6,

    -- Warnings at seconds spent in water before attack time.
    WarnAt = { 30, 40, 44 },
}

-- =========================================================
-- OLD CONFIG COMPATIBILITY
-- Do not edit unless you know what you are doing.
-- Keeps older files from breaking if they still reference old keys.
-- =========================================================
Config.TimeInWaterBeforeAttack = Config.SharkAttacks.TimeInWaterBeforeAttack
Config.SharkModel = Config.SharkAttacks.SharkModel
Config.MinSpawnDistance = Config.SharkAttacks.MinSpawnDistance
Config.MaxSpawnDistance = Config.SharkAttacks.MaxSpawnDistance
Config.DespawnAfter = Config.SharkAttacks.DespawnAfter
Config.BiteDamage = Config.SharkAttacks.BiteDamage
Config.BiteIntervalMs = Config.SharkAttacks.BiteIntervalMs
Config.BitesToKill = Config.SharkAttacks.BitesToKill
Config.WarnAt = Config.SharkAttacks.WarnAt
