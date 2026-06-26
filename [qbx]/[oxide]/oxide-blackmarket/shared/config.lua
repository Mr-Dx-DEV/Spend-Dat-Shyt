Config = {}

-- Debug mode (prints to console)
Config.Debug = true  -- Set to true for debugging

-- Tier System Toggle
-- Set to false to disable the reputation/tier system entirely.
-- All items will be available to all players regardless of reputation,
-- reputation will not be gained or lost, and tier UI/notifications are hidden.
Config.EnableTiers = true

-- Dirty Money Configuration
-- Controls how the blackmarket handles dirty money for transactions.
--
-- MODE:
--   'account' = Uses framework account balance (ESX, etc.)
--   'item'    = Uses an inventory item (QBCore, QBX, etc.)
--
-- ITEM MODE VARIANTS:
--   useMetadata = false (default) - value is the stack count (10 items = $10)
--   useMetadata = true            - value is stored in item metadata (one item with metadata.worth = 5000 is worth $5,000)
--                                   When removing money, bills are consumed greedily and change is returned as a new bill.
--
-- FRAMEWORK SETUP:
--
--   ESX (uses built-in black_money account):
--     Config.DirtyMoney = {
--         mode = 'account',
--         account = 'black_money',
--     }
--
--   QBCore / QBX (count-based inventory item):
--     Config.DirtyMoney = {
--         mode = 'item',
--         item = 'black_money',  -- Change to your server's dirty money item
--     }
--
--   Marked bills with value in metadata (e.g. some QB-style markedbills items):
--     Config.DirtyMoney = {
--         mode = 'item',
--         item = 'markedbills',
--         useMetadata = true,
--         metadataKey = 'worth', -- Set to whatever metadata field your bill item uses
--     }
--
--   Regular cash (any framework, simplest setup):
--     Config.DirtyMoney = {
--         mode = 'account',
--         account = 'cash',
--     }
--
Config.DirtyMoney = {
    mode = 'account',       -- 'account' or 'item'
    account = 'cash',       -- Account type when mode = 'account'
    item = 'black_money',   -- Item name when mode = 'item'
    useMetadata = false,    -- When mode = 'item', read/write value from item metadata instead of stack count
    metadataKey = 'worth',  -- Metadata field that holds the bill's value (only used when useMetadata = true)
}

-- Dealer Settings
Config.RelocationInterval = 45 * 60 * 1000  -- 45 minutes between relocations
Config.DealerWeapon = 'WEAPON_PISTOL'       -- Default weapon (re-armed on breakout)
Config.DealerModel = 's_m_y_dealer_01'      -- Ped model

-- Blip Settings
Config.BlipDetectionRange = 200.0           -- Range to trigger flash blip
Config.BlipDuration = {                     -- Duration by tier (ms)
    [0] = 3000,
    [1] = 4000,
    [2] = 5000,
    [3] = 6000,
    [4] = 10000,
}
Config.BlipCooldown = 120000                -- 2 min between flashes
Config.BlipSprite = 140                     -- Blip icon (dollar sign)
Config.BlipColor = 1                        -- Red

-- Reputation Settings
Config.KillPenalty = 500                    -- Rep lost for killing dealer

-- Reputation Tiers
Config.Tiers = {
    [0] = { name = 'tier.unknown', minRep = 0 },
    [1] = { name = 'tier.street', minRep = 100 },
    [2] = { name = 'tier.connected', minRep = 300 },
    [3] = { name = 'tier.trusted', minRep = 600 },
    [4] = { name = 'tier.inner_circle', minRep = 1000 },
}

-- Pager Settings
Config.PagerSuccessChance = {
    [2] = 0.40,
    [3] = 0.70,
    [4] = 1.00,
}
Config.PagerCooldown = 300000               -- 5 min cooldown

-- Police Arrest Settings
Config.ArrestReward = 5000                  -- Cash reward to arresting officer
Config.DepartmentCut = 2500                 -- Society fund deposit on arrest
Config.ArrestRespawnDelay = 900000          -- 15 min respawn after arrest
Config.DeathRespawnDelay = 600000           -- 10 min respawn after death
Config.SubduedDeathPayout = 500             -- Reduced society payout if killed while surrendered
Config.ArrestDistance = 3.0                 -- Max distance to show [E] arrest prompt
Config.PoliceJobs = { 'police', 'sheriff', 'bcso', 'sast', 'sasp', 'LSPD' }  -- Jobs that can arrest dealer

-- Dispatch Alert Settings (uses olink.dispatch - compatible with ps-dispatch, cd_dispatch, etc.)
Config.DispatchAlerts = {
    -- Alert triggered when a player buys or sells from the dealer
    transaction = {
        enabled = true,
        chance = 0.15,                -- 15% chance per transaction
        message = 'dispatch.transaction_message',
        code = '10-31',               -- Crime in progress
        icon = 'fas fa-exchange-alt',
        time = 30000,                 -- Blip duration (ms)
        blip = {
            sprite = 161,
            color = 1,
            scale = 0.5,
        }
    },
    -- Alert triggered when a police officer gets close to the dealer
    proximity = {
        enabled = true,
        chance = 0.10,                -- 10% chance (rare)
        range = 150.0,                -- Detection range
        message = 'dispatch.proximity_message',
        code = '10-66',               -- Suspicious person
        icon = 'fas fa-eye',
        time = 30000,                 -- Blip duration (ms)
        blip = {
            sprite = 161,
            color = 1,
            scale = 0.5,
        }
    },
}

-- Death & Cleanup Settings
Config.BodyFadeDelay = 45000                -- 45 seconds before body fades
Config.DeathNotifyRadius = 500.0            -- Notification radius for nearby players
Config.DeathNotifyMinTier = 1               -- Minimum rep tier to receive death notification

-- Loot Drop Settings
Config.LootDropEnabled = true               -- Enable loot drops on dealer death
Config.LootCashMin = 500                    -- Minimum cash drop
Config.LootCashMax = 2500                   -- Maximum cash drop
Config.LootStockPercent = 0.3               -- 30% of remaining stock drops as items
Config.LootMaxItems = 5                     -- Max different item types to drop
Config.LootBagModel = 'prop_cs_heist_bag_01' -- Prop model for loot bag
Config.LootBagDespawnTime = 300000          -- 5 minutes before uncollected loot despawns

-- Target Interaction Settings
Config.TargetDistance = 2.5
Config.TargetIcon = 'fas fa-handshake'
Config.TargetLabel = 'target.trade_dealer'

-- Hit Squad Settings (retaliation for killing dealer)
Config.HitSquadEnabled = true
Config.HitSquadEscapeDistance = 500.0     -- Distance player must reach to escape
Config.HitSquadCheckInterval = 1000       -- How often to check escape/combat state (ms)
Config.HitSquadFootEngageDistance = 50.0  -- Distance at which they exit car to fight on foot
Config.HitSquadDriveSpeed = 30.0          -- Cruise speed in m/s (~110 km/h / ~67 mph). Above ~40 the AI loses control on corners.
Config.HitSquadSpawnDistMin = 200.0       -- Minimum spawn distance from death location
Config.HitSquadSpawnDistMax = 300.0       -- Maximum spawn distance from death location
Config.HitSquadTaskRefreshInterval = 5000 -- How often to refresh chase/combat tasks (ms)
Config.HitSquadMaxChaseDuration = 90000   -- Release the squad if it spends this many ms in vehicle mode without engaging on foot (safety net)

-- Hit Squad Vehicle Options (random selection, 4-door sedans)
Config.HitSquadVehicles = {
    'sultan',
    'sultan2',
    'oracle',
    'oracle2',
    'schafter2',
    'tailgater',
}

-- Hit Squad Ped Models (mob/suit style)
Config.HitSquadPedModels = {
    'a_m_m_business_01',
    'a_m_y_business_01',
    'a_m_y_business_02',
    'a_m_m_soucent_01',
    'g_m_m_mexboss_01',
}

-- Difficulty preset (determines weapons and combat ability)
Config.HitSquadDifficulty = 'medium'  -- 'easy', 'medium', 'hard'

-- Weapons per difficulty (4 weapons for 4 peds: driver, front passenger, rear left, rear right)
Config.HitSquadWeapons = {
    easy = {
        'WEAPON_PISTOL',
        'WEAPON_PISTOL',
        'WEAPON_PISTOL',
        'WEAPON_PISTOL',
    },
    medium = {
        'WEAPON_PISTOL50',
        'WEAPON_SMG',
        'WEAPON_SMG',
        'WEAPON_PUMPSHOTGUN',
    },
    hard = {
        'WEAPON_COMBATPISTOL',
        'WEAPON_ASSAULTRIFLE',
        'WEAPON_ASSAULTRIFLE',
        'WEAPON_CARBINERIFLE',
    },
}

-- Combat ability per difficulty (0-100 scale, affects accuracy)
Config.HitSquadCombatAbility = {
    easy = 50,
    medium = 75,
    hard = 100,
}

-- Combat movement style (0 = stationary, 1 = defensive, 2 = offensive, 3 = suicidal)
Config.HitSquadCombatMovement = 2

-- Combat range (0 = near, 1 = medium, 2 = far)
Config.HitSquadCombatRange = 2

-- Spawn Locations (vector4: x, y, z, heading)
-- Dealer will spawn at a random location from this list
-- Selected for open areas where peds won't get stuck

Config.Locations = {
    vector4(889.39, -2185.3, 30.52, 357.26),    -- Cypress Flats
    vector4(33.57, -1906.16, 21.76, 137.9),    -- Davis
    vector4(-690.83, -724.43, 28.72, 84.58),     -- Little Seoul
    vector4(1065.79, -720.8, 56.77, 143.09),   -- Mirror Park
    vector4(-3062.4, 599.71, 7.46, 113.42),    -- Banham Canyon
    vector4(1867.5, 3744.72, 33.0, 211.69),    -- Sandy Shores
    vector4(2259.36, 4759.79, 39.22, 343.04),    -- Grapeseed
    vector4(346.51, 2578.13, 43.52, 29.79),    -- Grand Senora Desert
}

-- Dealer Surrender/Flee Settings
Config.FleeDistanceThreshold = 8.0    -- Distance cop must be for flee chance
Config.FleeChance = 0.35              -- 35% chance to flee per check
Config.FleeCheckInterval = 1000       -- Check every 1 second (ms)
Config.SurrenderCooldownTime = 1000   -- 1 second before can re-surrender
Config.AimSurrenderDistance = 10.0    -- Police aim range for surrender
Config.IdleWanderCheckDistance = 50.0 -- Distance to check for idle dealer

-- Shared debug print function
function DebugPrint(msg)
    if Config.Debug then
        print('[oxide-blackmarket] ' .. msg)
    end
end
