Config = {}
Config.Debug = false               
Config.Language = 'en' 
Config.Framework = 'qb'           -- Options: 'esx', 'qb'
Config.Notify = 'built-in'         -- Options: 'built-in'(recommended) | 'ox' | 'esx' | 'qb' | 'qbox' | 'custom' *set custom in cl_notify.lua*
Config.ProgressBar = 'built-in'    -- Options: 'built-in'(recommended) | 'ox' | 'esx' | 'qb' | 'custom' *set custom in cl_progress.lua*
Config.Inventory = 'ox'            -- Options: 'ox', 'qs', 'qb', 'core', 'codem', 'tgiann', 'jaksam', 'ak47', 'ps'
Config.BlockInventory = true       -- true = lock the inventory UI while mid-action. Set false to allow free inventory access.
Config.DisableFiring = true        -- true = block punching and shooting while holding a smoking item (not blocked when item is in mouth).
Config.DisableAiming = true        -- true = block aiming and reloading weapons while holding a smoking item (not blocked when item is in mouth).
Config.InventoryImagePath = "nui://ox_inventory/web/images/" -- Must match your inventory's image folder.
------------------Image Paths for reference:-----------------------------------
--Config.InventoryImagePath = "nui://ox_inventory/web/images/" -- ox
--Config.InventoryImagePath = 'nui://qs-inventory/html/images/' -- qs
--Config.InventoryImagePath = 'nui://codem-inventory/html/itemimages/' -- codem
--Config.InventoryImagePath = 'nui://qb-inventory/html/images/' -- qb
--Config.InventoryImagePath = 'nui://ps-inventory/html/images/' -- ps
--Config.InventoryImagePath = 'nui://core_inventory/html/img/' -- core
--Config.InventoryImagePath = 'nui://jaksam_inventory/_images/' -- jaksam
--Config.InventoryImagePath = 'nui://inventory_images/images/' -- tgiann
--Config.InventoryImagePath = 'nui://ak47_inventory/web/build/images/' -- ak47
--Config.InventoryImagePath = "nui://ak47_qb_inventory/web/build/images/" -- ak47_qb
-------------------------------------------------------------------------------

---Commands--
Config.Commands = {
    CreateNewItems   = "createsmokeitems", -- Admin command to create new items
    SmokeFix = "smokefix", -- Command to fix smoke issues
    TimecycleTest = "timecycles", -- Command to test timecycle effects
    RangeTest = "rangetest" -- Command to test smoke range(Useful for new sounds)
}

-- =====================================================================
-- KEYBINDS
-- =====================================================================
Config.Keys = {
    Interact   = 'E',       -- Main key. Lighting, inhaling, confirming menu choices.
    BongWater  = 'H',       -- Bong water controls, swap item to/from mouth, and adds items into bags.
    Give       = 'G',       -- Offer the currently held item to a nearby player.
    Cancel     = 'BACK',    -- Backspace. Puts item away, drops it, exits menus.
    ThrowAway  = 'DELETE',  -- Delete key. Throws the current item on the ground.
    Ash        = 'N',       -- Tap ash off a cigar/joint. Also used to DENY a pass request from another player.
    ClipCigar  = 'Y',       -- Clip the end off a lit cigar. Also used to ACCEPT a pass request from another player.
    FreakItem  = 'U',       -- "Freak" a black cigar (custom cigar modification).
    ChargeVape = 'B',       -- Start/stop charging a vape that has a dead battery.
}

Config.SmokeSyncDistance = 20.0    -- Max distance (units) to sync smoke particles, lighter flames to nearby players.
Config.SyncSoundDistance = 15.0    -- Fallback max distance (units) for any sound not listed in Config.SoundDistances.
Config.CoughSounds = {
    Male   = "cough_m.ogg",
    Female = "cough_f.ogg",
}

-- =====================================================================
-- Per-sound max-distance
-- =====================================================================
Config.SoundDistances = {
    ["lighterflick.ogg"] = 5.0,    -- Lighter flick
    ["smokecrackle.ogg"] = 3.0,    -- Quiet crackle of a burning item while inhaling
    ["exhale.ogg"]       = 5.0,    -- Breath exhale after a hit
    ["cough_m.ogg"]      = 15.0,   -- Male cough
    ["cough_f.ogg"] = 15.0,   -- Female cough
    ["bong_rip.ogg"]     = 10.0,   -- Bong water rip
    ["vapeinhale.ogg"]   = 5.0,    -- Vape inhale
    ["pourwater.ogg"]    = 5.0,    -- Pouring water into a bong
}
-- =====================================================================
-- GIVE MENU
-- =====================================================================
Config.GiveMenu = {
    Distance = 4.0,  -- Max distance (meters) a player can be from you to appear in the give menu.
    MaxPlayers = 5,  -- Max number of nearest players shown in the menu. Extras beyond this are dropped (closest first).
}

-- =====================================================================
-- SMOKE RINGS
-- =====================================================================
Config.SmokeRings = {
    Enabled = true,
    Key = 'PAGEUP',              -- Key that triggers a ring blow.
    RingModel = 'dc_smokering3', -- 3D model used for each ring.
    RingCount = 4,               -- How many rings in one burst.
    StaggerDelay = 1000,         -- ms between each ring in the burst. Higher = slower stream.
    Lifetime = 4000,             -- How long (ms) each ring stays visible before fading.
    Speed = 0.10,                -- Forward speed the rings drift away from the player.
    UpwardDrift = 0.055,         -- Upward speed (rings slowly rise).
    StartAlpha = 200,            -- Starting opacity (0-255). Higher = more solid-looking.
    MouthOffset = 0.01,          -- Fine-tune how far the rings spawn from the mouth.
    HazeScale = 0.04,            -- Size of the faint haze particle inside each ring.
}

-- =====================================================================
-- UI THEME
-- =====================================================================
Config.UI = {
    ThemeColor = '#2ecc71',      -- Main accent color (used in menus and bars).
    Bar = {
        StartColor = '#2ecc71',  -- Color of the inhale bar when it starts filling.
        EndColor = '#e74c3c',    -- Color the bar shifts to as it fills into the red zone.
        ShakeStart = 0.75,       -- Bar fill percent (0-1) where it starts visually shaking to warn the player.
    },
}

Config.Refills = {}
