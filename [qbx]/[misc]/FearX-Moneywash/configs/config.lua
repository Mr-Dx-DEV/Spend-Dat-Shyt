Config = {}

-- Framework selector. Leave at 'auto' to detect; override if you run multiple
-- frameworks or want to force a specific one.
--   'auto'   — detect at boot (priority: qbox > qbcore > esx)
--   'esx'    — force ESX Legacy
--   'qbcore' — force QBCore
--   'qbox'   — force QBox
Config.Framework = 'auto'

-- Inventory selector. Leave at 'auto' to detect; override if your server runs
-- the resource for a non-default inventory.
--   'auto'  — detect at boot (priority: ox > qb > qs > codem > esx)
--   'ox'    — ox_inventory
--   'qb'    — qb-inventory
--   'qs'    — qs-inventory
--   'codem' — codem-inventory
--   'esx'   — ESX legacy inventory (no ox_inventory)
Config.Inventory = 'auto'

-- Locale code from locales/. Filled: 'en'. Stubs: 'es', 'de', 'fr'.
Config.Locale = 'en'

-- ox_inventory item name representing dirty money. Must match an item in
-- ox_inventory/data/items.lua.
Config.DirtyMoneyItem = 'black_money'

-- Percentage cut taken from dirty -> clean. 25 means $10,000 dirty pays out $7,500 clean.
Config.TaxPercent = 10

-- Wash duration scaling in seconds per $1000 dirty.
-- Total wash time = (dirty / 1000) * SecondsPer1000Dirty.
-- Production tip: 30 (so $10k = 5 min). Keep at 1 for testing.
Config.SecondsPer1000Dirty = 1

-- Smallest amount of dirty money allowed in a single wash.
Config.MinDeposit = 1000

-- Largest amount of dirty money allowed in a single wash. Server enforces.
Config.MaxDeposit = 250000

-- Per-player cooldown (seconds) after a completed wash. Per-identifier, not global —
-- one player's cooldown does not affect anyone else.
-- Production tip: 1800 (30 min). Keep at 60 for testing.
Config.CooldownSeconds = 60

-- Block new deposits this many minutes before a scheduled txAdmin restart, if the
-- wash timer wouldn't finish before the restart fires. Active washes survive
-- restarts regardless.
-- Production tip: 5. Keep at 1 for testing.
Config.RestartLockoutMinutes = 1

-- ox_target interaction radius (metres). Server adds +1.5 jitter tolerance.
Config.InteractionDistance = 2.0

-- Each entry = one launderette. Integer key is stored as the wash row's location_id.
-- Add more entries to add launderettes. Interior block is optional — omit it for
-- locations where the greeter ped opens the NUI directly (no teleport flow).
Config.Locations = {
    [1] = {
        -- Display name on the map blip and in Discord embeds.
        label = 'Sandy Shores Launderette',

        -- Outside greeter ped position. w = heading.
        coords = vector4(899.2916, -2155.7976, 31.5537, 349.4676),

        -- GTA V ped model for the greeter.
        pedModel = 'a_m_y_business_03',

        -- Map blip. Set show = false (or omit the blip table) to hide.
        blip = { sprite = 207, color = 2, scale = 0.5, show = false },

        -- Optional interior teleport flow. Omit this whole table to disable.
        interior = {
            -- true  = spawn visible wash machine props at each washPoint
            -- false = invisible BoxZones with floating 3D markers (use when
            --         your MLO already has visible machines baked in)
            showProps = false,

            -- Teleport destination when the player enters the launderette.
            enter = vector4(1137.985474, -3199.096191, -39.665638, 183.282898),

            -- Invisible door target inside the interior. Third-eye to leave.
            exitTarget = vector4(1138.002075, -3199.201660, -39.665642, 187.991913),

            -- Teleport destination when the player exits back outside.
            outsideSpawn = vector4(1144.068726, -986.284912, 45.920971, 271.978424),

            -- Unlimited wash machines per location. Each one locks to a single
            -- player while in use; everyone else gets steered to a free machine.
            -- Per entry:
            --   coords  = vector3 position (required)
            --   heading = number (optional, default 0) — rotation of prop / BoxZone
            --   prop    = string (optional) — prop model when showProps = true
            washPoints = {
                { coords = vector3(1126.910522, -3194.358887, -40.397804), heading = 1.037366, prop = 'prop_washer_01' },
                { coords = vector3(1125.571289, -3194.298584, -40.397388), heading = 1.058970, prop = 'prop_washer_01' },
                { coords = vector3(1123.844849, -3194.270020, -40.397259), heading = 6.672988, prop = 'prop_washer_01' },
            },
        },
    },
}

-- Police alert config. The resource is dispatch-agnostic — it fires a server
-- event that you wire to your dispatch resource of choice. See
-- docs/exports-and-events.md for ps-/qs-/cd_dispatch snippets.
Config.PoliceAlert = {
    -- Master toggle.
    enabled = true,

    -- Percent (0-100) chance per deposit to fire the alert.
    chance = 15,

    -- Server event name your dispatch resource listens for.
    -- Receives (coords, locationId).
    dispatchEvent = 'fearx-moneywash:police:alert',
}

-- Animation played on the player while interacting with a wash machine.
-- duration = -1 loops until they leave the interaction.
Config.Animation = {
    dict = 'anim@amb@business@bgen@bgen_no_work@',
    clip = 'stand_phone_phoneputdown_idle_nowork',
    duration = -1,
}
