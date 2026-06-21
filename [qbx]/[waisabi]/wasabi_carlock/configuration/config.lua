-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
Config                   = {}
------------------------------------------------------------------------------
-- Text UI's, notifications, frameworks, and other integrations can be made --
-- via dependency "wasabi_bridge" in the "customize" directory!             --
------------------------------------------------------------------------------

Config.CheckForUpdates   = true -- Recommended

-- Language Options are
-- 'en' (English)
-- 'fr' (French)
-- 'cn' (Chinese Simplified)
-- 'tw' (Chinese Traditional)
-- 'de' (German)
-- 'it' (Italian)
-- 'jp' (Japanese)
-- 'ko' (Korean)
-- 'pl' (Polish)
-- 'pt' (Portuguese)
-- 'es' (Spanish)
-- 'hi' (Hindi)
-- 'nl' (Dutch)
-- 'da' (Danish)
-- 'cs' (Czech)
-- If you would like us to add a language, join our discord and create a ticket!
-- All locale strings can be found in configuration/locales/
Config.Language          = 'en'

Config.UIColor           = false -- Color for UI elements or set to false to use default bridge color

Config.toggleLockKey     =
'U'                                                                                            -- Which key to register as toggle of vehicle locks?
Config.toggleSound       = { audioName = 'BUTTON', audioRef = 'MP_PROPERTIES_ELEVATOR_DOORS' } -- Sound to play when locking/unlocking vehicle. Leave empty for no sound. Ref:gtaforums.com/topic/795622-audio-for-mods
Config.lockDistance      = 10.0                                                                -- Distance in which one can unlock their closest car?

Config.progressBar       = false                                                               -- If true will use progress bar rather than progress circle.

Config.lockNPCVehicles   = false                                                               -- Lock all NPC cars?

Config.robPedKeys        = {                                                                   -- Ability to rob peds at gun point for their keys
    enabled = true,                                                                            -- Enable robbing peds for their car keys?
    timeToRob = 4,                                                                             -- Duration(In seconds) to rob ped when approaching at gunpoint
    label = 'Stealing Keys. . .'
}

Config.notifyPolice      = {
    enabled = true,      -- Chance of notifying police when lockpicking, hotwiring, and/or robbing peds
    hotwire = 50,        -- Chance % of notifying police when hotwiring (50 = 50% chance)
    lockpick = 30,       -- Chance % of notifying police when lockpicking (30 = 30% chance)
    robPed = 70,         -- Chance % of notifying police when robbing ped (70 = 70% chance)
    blip = {
        enabled = true,  -- Enable blip on map for police when notified?
        sprite = 161,    -- Blip sprite
        color = 1,       -- Blip color
        scale = 0.7,     -- Blip scale
        short = false,   -- Short blip
        flashing = true, -- Blip flashing
        duration = 20    -- Duration of blip on map (In seconds)
    },
    policeJobs = {       -- Jobs that are considered police to notify
        'police',
        'sheriff',
        --      'highway'
    }
}

Config.DisableAutoStart  = false -- Disable auto start of vehicle when entering with keys? (Will require Config.EngineToggle enabled or script)

Config.EngineToggle      = {
    enabled = true,                -- Enable engine toggle feature?
    hotkey = 47,                   -- Default 'G'(47) / https://docs.fivem.net/docs/game-references/controls/
    string = '[G] - Start Engine', -- String desired to display in Text UI or false for no hint Text UI.
}

Config.metadataKeys      = { -- Metadata keys options (Requires inventory integrated into wasabi_bridge)
    enabled = false,         -- Enable metadata keys feature?
    keyItem = 'carkeys',     -- Item to use as car key
}

Config.givingKeys        = { -- Giving keys options (only with metadata keys disabled)
    enabled = true,          -- Enable giving keys feature?
    command = 'givekey',     -- Desired command to give key
    removeKey = true,        -- Remove the key to vehicle from person giving key
    menuPosition =
    'bottom-right'           -- Choose where player selection menu is positioned. Options : 'top-left' or 'top-right' or 'bottom-left' or 'bottom-right'
}

Config.manageKeys        = { -- Manage keys in hand via menu (only with metadata keys disabled)
    enabled = true,          -- Enable this feature
    command = 'managekeys',  -- Command to open menu for opening key management menu (Set to false if not desired)
    allowRemove = true,      -- Allow removal of keys that were given
    menuPosition =
    'bottom-right'           -- Choose where key selection menu is positioned. Options : 'top-left' or 'top-right' or 'bottom-left' or 'bottom-right'
}

Config.noKeysNeeded      = { -- Vehicle models that don't require keys
    'BMX',
    'BMXST',
    'CRUISER',
    'FIXTER',
    'SCORCHER',
    'TRIBIKE',
    'TRIBIKE2',
    'TRIBIKE3',
    -- Add more here if desired
}

Config.WhitelistedJobs   = { -- Jobs that don't require keys
    'police',
    --  'sheriff',
    -- Add more as desired
}

Config.WhitelistedPlates = { -- Vehicle plates that don't require keys
    'ADMIN',
    -- Add more plates as desired
}

Config.hotwire           = {  -- Hotwire options
    enabled = true,           -- Enable ability to hotwire?
    string = '[H] - Hotwire', -- String desired to display in Text UI
    hotkey = 74,              -- Default 'H'(74) / https://docs.fivem.net/docs/game-references/controls/
    maxAttempts = 2,          -- Max attempts someone can take at hotwiring vehicle
    difficulties = {
        -- Comment out if you want no hotwire for category(Like cycles below)
        [0] = { 'easy', 'medium', 'easy' },      -- Compacts
        [1] = { 'easy', 'easy', 'easy' },        -- Sedans
        [2] = { 'easy', 'medium', 'easy' },      -- Compacts
        [3] = { 'medium', 'medium', 'easy' },    -- Coupes
        [4] = { 'medium', 'medium', 'easy' },    -- Muscle
        [5] = { 'medium', 'medium', 'medium' },  -- Sports Classics
        [6] = { 'medium', 'medium', 'medium' },  -- Sports
        [7] = { 'medium', 'hard', 'hard' },      -- Super
        [8] = { 'easy', 'easy', 'easy' },        -- Motorcycles
        [9] = { 'easy', 'medium', 'easy' },      -- Off-road
        [10] = { 'easy', 'easy', 'easy' },       -- Industrial
        [11] = { 'easy', 'easy', 'easy' },       -- Utility
        [12] = { 'easy', 'easy', 'easy' },       -- Vans
        --       [13] = { 'easy', 'easy', 'easy' }, -- Cycles
        [14] = { 'easy', 'easy', 'easy' },       -- Boats
        [15] = { 'medium', 'hard', 'easy' },     -- Helicopters
        [16] = { 'medium', 'hard', 'easy' },     -- Planes
        [17] = { 'medium', 'medium', 'medium' }, -- Service
        [18] = { 'hard', 'medium', 'hard' },     -- Emergency
        [19] = { 'hard', 'hard', 'hard' },       -- Military
        [20] = { 'easy', 'medium', 'easy' },     -- Commercial
        --        [21] = { 'easy', 'easy', 'easy' }, -- Trains
        --        [22] = { 'easy', 'easy', 'easy' }, -- Open Wheel?
    }
}

Config.lockpick          = {
    enabled = true,    -- Enable lockpick functionality?
    item = 'lockpick',
    chanceOfLoss = 50, -- Chance of bending lockpick and losing item
    difficulties = {
        -- Comment out if you want no lockpick for category(Like cycles below)
        [0] = { 'easy', 'medium', 'easy' },      -- Compacts
        [1] = { 'easy', 'easy', 'easy' },        -- Sedans
        [2] = { 'easy', 'medium', 'easy' },      -- Compacts
        [3] = { 'medium', 'medium', 'easy' },    -- Coupes
        [4] = { 'medium', 'medium', 'easy' },    -- Muscle
        [5] = { 'medium', 'medium', 'medium' },  -- Sports Classics
        [6] = { 'medium', 'medium', 'medium' },  -- Sports
        [7] = { 'medium', 'hard', 'hard' },      -- Super
        [8] = { 'easy', 'easy', 'easy' },        -- Motorcycles
        [9] = { 'easy', 'medium', 'easy' },      -- Off-road
        [10] = { 'easy', 'easy', 'easy' },       -- Industrial
        [11] = { 'easy', 'easy', 'easy' },       -- Utility
        [12] = { 'easy', 'easy', 'easy' },       -- Vans
        --       [13] = { 'easy', 'easy', 'easy' }, -- Cycles
        [14] = { 'easy', 'easy', 'easy' },       -- Boats
        [15] = { 'medium', 'hard', 'easy' },     -- Helicopters
        [16] = { 'medium', 'hard', 'easy' },     -- Planes
        [17] = { 'medium', 'medium', 'medium' }, -- Service
        [18] = { 'hard', 'medium', 'hard' },     -- Emergency
        [19] = { 'hard', 'hard', 'hard' },       -- Military
        [20] = { 'easy', 'medium', 'easy' },     -- Commercial
        --        [21] = { 'easy', 'easy', 'easy' }, -- Trains
        --        [22] = { 'easy', 'easy', 'easy' }, -- Open Wheel?
    }
}

Config.searchingVehicle  = {                                                                     -- Vehicle search options
    enabled = true,                                                                              -- Enable searching of vehicle for keys/loot
    string = '[L] - Search',                                                                     -- String desired to display in Text UI
    hotkey = 7,                                                                                  -- Default 'S' (78) / https://docs.fivem.net/docs/game-references/controls/
    progressLabel = 'Searching Vehicle. . .',
    timeToSearch = 8,                                                                            -- Time it takes to search vehicle (In seconds)
    rewards = {                                                                                  -- Obtainable random items
        [1] = { chance = 50, type = 'account', name = 'money', quantity = math.random(30, 75) }, -- Example of money as reward
        [2] = { chance = 30, type = 'key' },                                                     -- If want to give key as reward??
        [3] = { chance = 50, type = 'item', name = 'water', label = 'Water', quantity = 1 },     -- Example of item reward
    }
}
