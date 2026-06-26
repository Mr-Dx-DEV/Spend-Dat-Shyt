Config = {}

-- ============================================================================
-- ORBIT ONLYPICS v2.0.0
-- ============================================================================

-- Framework Configuration
Config.Framework = "QBOX" -- Options: "ESX", "QBCORE", "QBOX"

-- Inventory System
Config.Inventory = "ox_inventory" -- Options: "ox_inventory", "qb-inventory", "qs-inventory", "lj-inventory", "esx_inventoryhud"

-- UI System Configuration
Config.UISystem = "ox_lib" -- Options: "ox_lib", "esx", "qb", "custom"

-- Notification System Configuration
Config.Notification = 'ox_lib' -- Options: 'ox_lib', 'esx', 'qb', 'custom'

-- If using custom notification system, add your custom function here
Config.CustomNotify = function(message, type)
    -- Your custom notification code here
end

-- Shop Interaction Settings
Config.Interaction = {
    Method = 'ox_target', -- 'ox_target', 'ox_lib', 'qb-target'
    Distance = 3.0,
    Key = 'E',
    KeyLabel = '[E]'
}

Config.PhotoLoot = {
    Distance = 2.0,
    LootTime = 5000,
    Label = 'Take Back Photos',
    Icon = 'fas fa-image'
}

-- 📸 PICTURE WEBHOOK (Required For Script To Work)
Config.PicWebhook = ""

Config.Shop = {
    Enabled = true,
    Coords = vec3(143.4503, -1721.9485, 28.2935),
    Price = 10000,                  -- ADDED IN V2 (was referenced but undefined)
    Success = 'Camera purchased!',  -- ADDED IN V2
    NoMoney = 'You cannot afford this!', -- ADDED IN V2
    Ped = {
        model = 'a_f_y_bevhills_01',
        coords = vec4(143.4503, -1721.9485, 28.2935, 150.0),
        freeze = true,
        invincible = true,
        blockEvents = true,
        scenario = 'WORLD_HUMAN_CLIPBOARD',
    },
    Blip = {
        Enabled = true,
        Sprite = 617,
        Color = 8,
        Scale = 0.5,
        Label = 'Photography Shop',
        ShortRange = true,
    },
    Label = '[E] Open Photography Shop',
}

Config.Target = {
    Shop = {
        label = 'Buy Camera - $10,000',
        icon = 'fa-solid fa-camera',
        color = '#ffffff',
        canInteract = function(entity, distance, coords, name, bone)
            return distance <= Config.Interaction.Distance
        end
    }
}

Config.SellSettings = {
    Command = "onlypics",
    Price = 500,
    BundlePrice = 2000,
    SellTime = 3000,
    SuccessChance = 75,
    RejectChance = 15,
    StealChance = 10
}

Config.Reactions = {
    [1] = { label = "Nice body girl to this", sale = true },
    [2] = { label = "This is stunning", sale = true },
    [3] = { label = "I am going to goon to this", sale = true },
    [4] = { label = "I am going to buy more from you", sale = true },
    [5] = { label = "This is Mid.", sale = false, steal = false },
    [6] = { label = "This is trash. I'm keeping this.", sale = false, steal = true }
}

Config.BundleReactions = {
    [1] = { label = "A whole set?! Take my money!", sale = true },
    [2] = { label = "This collection is fire!", sale = true },
    [3] = { label = "Premium content right here!", sale = true },
    [4] = { label = "I need more sets like this!", sale = true },
    [5] = { label = "This set is mid honestly.", sale = false, steal = false },
    [6] = { label = "I'm taking this whole set. Later!", sale = false, steal = true }
}

Config.Bundle = {
    Enabled = true,
    PhotoCount = 4,
    DelayBetween = 500,
}

-- ============================================================================
-- 🎥 CAMERA CONTROLS (selfie mode — zoom + camera up/down)
-- ============================================================================
-- The selfie cam is a scripted camera, so we have full control over it. The
-- rear cellphone cam uses GTA's built-in CellCamActivate, which already has
-- its own native scroll-wheel zoom — these settings only affect SELFIE mode.
Config.Camera = {
    -- FiveM control IDs — change these to rebind. Reference:
    --   14  = Mouse Wheel Down (INPUT_WEAPON_WHEEL_NEXT)
    --   15  = Mouse Wheel Up   (INPUT_WEAPON_WHEEL_PREV)
    --   172 = Arrow Up    (already used for Flip Camera — don't reuse)
    --   173 = Arrow Down
    --   174 = Arrow Left
    --   175 = Arrow Right
    Controls = {
        ZoomIn         = 15,   -- Mouse wheel up
        ZoomOut        = 14,   -- Mouse wheel down
        MoveUp         = 175,  -- Arrow Right — raises camera
        MoveDown       = 174,  -- Arrow Left  — lowers camera
        ToggleSubmenu  = 47,   -- G key      — opens the camera settings submenu
        NextPhotoType  = 173,  -- Arrow Down — cycles to next photo type (see Config.PhotoTypes)
    },
    -- FOV in degrees. Smaller = more zoomed in.
    Fov = {
        Default = 40.0,
        Min     = 15.0,   -- max zoom in
        Max     = 115.0,  -- max zoom out (roughly 2× the previous range; raise further for fisheye)
        Step    = 1.5,    -- FOV change per scroll click
    },
    -- Vertical offset (Z) added on top of the base selfie attachment (0.65).
    Height = {
        Default = 0.0,
        Min     = -0.5,   -- camera dips toward waist
        Max     = 0.6,    -- camera rises above head
        Step    = 0.015,  -- offset change per frame while key held
    },
    -- Smoothing factor for FOV/height transitions. 0 = no movement,
    -- 1 = instant snap. ~0.15 feels nice and cinematic.
    SmoothFactor = 0.15,
}

-- ============================================================================
-- 📸 PHOTO TYPES (selfie-mode framing presets)
-- ============================================================================
-- Each preset reattaches the selfie cam at a specific offset on the ped and
-- points it at a specific bone. Player still gets zoom + height tweaks on top
-- via the settings submenu — changing preset resets those tweaks.
--
-- Offset is in ped object space: +X = ped's right, +Y = ped forward, +Z = up.
-- e.g. (0, 0.7, 0.65) sits in front of the ped at face height.
--
-- Bones are GTA V skeleton hashes. Common ones:
--   31086 SKEL_Head        24818 SKEL_Spine3 (upper chest)
--   24817 SKEL_Spine2      11816 SKEL_Pelvis
--   14201 SKEL_L_Foot      52301 SKEL_R_Foot
-- See: https://docs.fivem.net/docs/game-references/ped-bones/
--
-- Labels are user-facing — feel free to rename to whatever fits your server.
-- The first preset is applied automatically when the player enters selfie mode.
Config.PhotoTypes = {
    Enabled = true,
    Presets = {
        { id = "face",  label = "Face",      offset = vec3(0.0,  0.7,  0.65), bone = 31086, fov = 38.0 },
        { id = "chest", label = "Chest",     offset = vec3(0.0,  0.6,  0.50), bone = 24818, fov = 35.0 },
        { id = "full",  label = "Full Body", offset = vec3(0.0,  1.8,  0.20), bone = 24817, fov = 50.0 },
        { id = "rear",  label = "Rear",      offset = vec3(0.0, -0.9,  0.40), bone = 11816, fov = 45.0 },
        { id = "feet",  label = "Feet",      offset = vec3(0.0,  0.4,  1.10), bone = 14201, fov = 38.0 },
    },
}

-- ============================================================================
-- 🤝 PLAYER-TO-PLAYER PHOTO OFFER
-- ============================================================================
-- Lets a player target another player (third-eye) and offer them a photo or
-- bundle from their inventory for a price. The buyer sees a blurred preview
-- plus the price and can accept or decline.
--
-- Note: third-eye option uses ox_target or qb-target depending on
-- Config.Interaction.Method. The option only shows up for players who
-- actually carry at least one photo or bundle item.
Config.PlayerOffer = {
    Enabled        = true,
    TargetLabel    = 'Offer Photos',
    TargetIcon     = 'fa-solid fa-camera-retro',
    TargetDistance = 3.0,                  -- max range for the third-eye to show
    -- Price bounds. Server enforces these; client only suggests.
    MinPrice       = 50,
    MaxPrice       = 1000000,
    DefaultPrice   = 500,
    -- Offer auto-expires if the buyer doesn't respond within this many seconds.
    TimeoutSec     = 30,
    -- How blurred the preview is, in CSS pixels. Higher = more obscured.
    -- Setting to 0 disables the blur entirely.
    PreviewBlurPx  = 25,
}

Config.Leaderboard = {
    Enabled = true,
    Command = 'topbaddies',
    MaxEntries = 10,
    Title = 'OnlyPics Top Earners',
    RefreshCooldown = 10,
}

Config.Peds = {
    'g_m_y_ballasout_01', 'g_m_y_famca_01', 'a_m_y_skater_01',
    'a_m_m_soucent_01', 'a_m_m_tramp_01', 'a_m_m_business_01'
}

Config.Offsets = {
    vec3(10.0, 0.0, 0.0), vec3(-10.0, 0.0, 0.0),
    vec3(0.0, 10.0, 0.0), vec3(0.0, -10.0, 0.0)
}

Config.Items = {
    camera = "baddie_cam",
    photo = "baddie_pic",
    bundle = "baddie_bundle"
}

Config.FemaleModel = "mp_f_freemode_01"

Config.Poses = {
    {dict = "amb@world_human_hang_out_street@female_hold_arm@idle_a", anim = "idle_a", label = "Hold Arm"},
    {dict = "amb@world_human_hang_out_street@female_arms_crossed@idle_a", anim = "idle_a", label = "Arms Crossed"},
    {dict = "missmic4", anim = "michael_tux_fidget", label = "Tux Pose"},
    {dict = "random@street_race", anim = "_street_race_girl", label = "Race Girl"},
    {dict = "anim@amb@nightclub@dancers@solomun_entourage@", anim = "mi_dance_facedj_17_v1_female^1", label = "Dance 1"},
    {dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "high_center", label = "Dance High"},
    {dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "med_center", label = "Dance Med"},
    {dict = "friends@frj@ig_1", anim = "wave_a", label = "Wave"},
    {dict = "mp_ped_interaction", anim = "hugs_guy_a", label = "Hug Pose"},
    {dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "high_center", label = "Sway"},
    {dict = "anim@heists@heist_corona@single_team", anim = "single_team_loop_boss", label = "Boss Pose"},
    {dict = "mp_safehouse", anim = "lap_dance_girl", label = "Seated Pose"}
}

Config.Logging = {
    enable = false,
    console = false,
    format = '[OnlyPics] %s'
}

Config.Debug = false

-- ============================================================================
-- ✨ V2 FEATURES START HERE
-- ============================================================================

-- ============================================================================
-- 🎯 XP & RANK SYSTEM
-- ============================================================================
Config.XP = {
    Enabled = true,

    Rewards = {
        PhotoSale       = 10,    -- Base XP per photo sold
        BundleSale      = 50,    -- Base XP per bundle sold
        PremiumReaction = 15,    -- Bonus XP for reactions 1-4
        ViralPhoto      = 500,   -- Jackpot XP on viral
        Rejection       = 2,     -- Consolation XP on reject
        LocationBonus   = 5,     -- First sale at a new location
    },

    Followers = {
        PerPhotoSale  = 5,
        PerBundleSale = 25,
        PerViralPhoto = 1000,
        LostOnReject  = 2,
        LostOnSteal   = 10,
    },
}

-- Ranks. 'xp' is the CUMULATIVE total XP to reach that rank.
Config.Ranks = {
    [1]  = { name = "Rookie",      xp = 0,     color = "#9CA3AF", priceMult = 1.00, bundleMax = 3,  unlocks = "Basic poses" },
    [2]  = { name = "Amateur",     xp = 250,   color = "#6EE7B7", priceMult = 1.05, bundleMax = 4,  unlocks = "4-photo bundles" },
    [3]  = { name = "Rising Star", xp = 750,   color = "#34D399", priceMult = 1.10, bundleMax = 4,  unlocks = "Beach location" },
    [4]  = { name = "Influencer",  xp = 1500,  color = "#60A5FA", priceMult = 1.15, bundleMax = 5,  unlocks = "5-photo bundles + Rooftop" },
    [5]  = { name = "Trending",    xp = 3000,  color = "#3B82F6", priceMult = 1.20, bundleMax = 5,  unlocks = "Nightclub location" },
    [6]  = { name = "Verified",    xp = 5500,  color = "#8B5CF6", priceMult = 1.25, bundleMax = 6,  unlocks = "6-photo bundles" },
    [7]  = { name = "Elite",       xp = 9000,  color = "#A78BFA", priceMult = 1.35, bundleMax = 6,  unlocks = "Premium poses + Yacht" },
    [8]  = { name = "Superstar",   xp = 14000, color = "#EC4899", priceMult = 1.45, bundleMax = 7,  unlocks = "7-photo bundles" },
    [9]  = { name = "Icon",        xp = 21000, color = "#F472B6", priceMult = 1.60, bundleMax = 8,  unlocks = "8-photo bundles + Exclusive poses" },
    [10] = { name = "Legend",      xp = 32000, color = "#FBBF24", priceMult = 1.80, bundleMax = 10, unlocks = "Max payout + Golden camera" },
}

-- ============================================================================
-- 📍 LOCATION SYSTEM (photo spot payout multipliers)
-- ============================================================================
Config.Locations = {
    Enabled = true,
    DetectionRadius = 15.0,

    Spots = {
        ["vinewood_sign"] = {
            label = "Vinewood Sign",
            coords = vec3(721.0, 1232.0, 360.0),
            priceMult = 1.15,
            requiredRank = 1,
            blip = { enabled = true, sprite = 494, color = 5 },
        },
        ["beach_pier"] = {
            label = "Del Perro Pier",
            coords = vec3(-1850.0, -1240.0, 8.6),
            priceMult = 1.25,
            requiredRank = 3,
            blip = { enabled = true, sprite = 494, color = 5 },
        },
        ["maze_rooftop"] = {
            label = "Maze Bank Rooftop",
            coords = vec3(-75.0, -818.0, 326.0),
            priceMult = 1.50,
            requiredRank = 4,
            blip = { enabled = true, sprite = 494, color = 5 },
        },
        ["galaxy_nightclub"] = {
            label = "Galaxy Nightclub",
            coords = vec3(-1605.0, -3013.0, -78.0),
            priceMult = 1.60,
            requiredRank = 5,
            blip = { enabled = true, sprite = 494, color = 5 },
        },
        ["luxury_yacht"] = {
            label = "Luxury Yacht",
            coords = vec3(-2043.0, -1030.0, 11.0),
            priceMult = 2.00,
            requiredRank = 7,
            blip = { enabled = true, sprite = 494, color = 5 },
        },
    },
}

-- ============================================================================
-- 📅 DAILY & WEEKLY CHALLENGES
-- ============================================================================
Config.Challenges = {
    Enabled = true,
    DailyCount = 3,
    WeeklyCount = 2,

    Daily = {
        { id = "daily_sales_10",    label = "Sell 10 photos",          target = 10,    type = "photo_sales",   reward = { cash = 2500, xp = 100 } },
        { id = "daily_bundles_3",   label = "Sell 3 bundles",          target = 3,     type = "bundle_sales",  reward = { cash = 5000, xp = 200 } },
        { id = "daily_premium_5",   label = "Get 5 premium reactions", target = 5,     type = "premium_react", reward = { cash = 3000, xp = 150 } },
        { id = "daily_locations_3", label = "Sell at 3 locations",     target = 3,     type = "locations",     reward = { cash = 3500, xp = 150 } },
        { id = "daily_earn_10k",    label = "Earn $10,000",            target = 10000, type = "earnings",      reward = { cash = 2000, xp = 125 } },
    },

    Weekly = {
        { id = "weekly_sales_100",  label = "Sell 100 photos",         target = 100,    type = "photo_sales",  reward = { cash = 25000, xp = 1000 } },
        { id = "weekly_viral_3",    label = "Get 3 viral photos",      target = 3,      type = "viral",        reward = { cash = 50000, xp = 2500 } },
        { id = "weekly_earn_100k",  label = "Earn $100,000",           target = 100000, type = "earnings",     reward = { cash = 20000, xp = 1500 } },
        { id = "weekly_bundles_25", label = "Sell 25 bundles",         target = 25,     type = "bundle_sales", reward = { cash = 30000, xp = 1800 } },
    },
}

-- ============================================================================
-- 🏅 ACHIEVEMENTS
-- ============================================================================
Config.Achievements = {
    Enabled = true,
    List = {
        { id = "first_sale",    label = "First Flash",     desc = "Make your first sale",        type = "photo_sales",   target = 1,      reward = { cash = 500,    xp = 50 } },
        { id = "sales_50",      label = "Getting Noticed", desc = "Make 50 sales",               type = "photo_sales",   target = 50,     reward = { cash = 5000,   xp = 500 } },
        { id = "sales_250",     label = "In Demand",       desc = "Make 250 sales",              type = "photo_sales",   target = 250,    reward = { cash = 25000,  xp = 2500 } },
        { id = "sales_1000",    label = "Household Name",  desc = "Make 1000 sales",             type = "photo_sales",   target = 1000,   reward = { cash = 100000, xp = 10000 } },
        { id = "first_viral",   label = "Going Viral",     desc = "Get your first viral photo",  type = "viral",         target = 1,      reward = { cash = 10000,  xp = 1000 } },
        { id = "viral_10",      label = "Trending Queen",  desc = "Get 10 viral photos",         type = "viral",         target = 10,     reward = { cash = 75000,  xp = 5000 } },
        { id = "all_locations", label = "World Tour",      desc = "Sell at every location",      type = "all_locations", target = 1,      reward = { cash = 20000,  xp = 2000 } },
        { id = "earn_100k",     label = "Six Figures",     desc = "Earn $100,000 total",         type = "earnings",      target = 100000, reward = { cash = 10000,  xp = 1000 } },
        { id = "earn_1m",       label = "Millionaire Club",desc = "Earn $1,000,000 total",       type = "earnings",      target = 1000000,reward = { cash = 100000, xp = 10000 } },
        { id = "legend_rank",   label = "Legendary",       desc = "Reach Legend rank",           type = "rank",          target = 10,     reward = { cash = 250000, xp = 0 } },
    },
}

-- ============================================================================
-- ⚡ RANDOM EVENTS
-- ============================================================================
Config.Events = {
    -- 🌟 Viral photo — rolled WHEN THE PHOTO IS TAKEN
    -- When viral, the photo itself is marked as viral in inventory metadata.
    -- Selling a viral-marked photo pays out PayoutMultiplier × the normal price.
    Viral = {
        Enabled = true,
        -- Chance per single photo taken (out of 100). Default 20 = 2/10 chance.
        PhotoChance = 20,
        -- Chance per photo inside a bundle. Lower than singles because bundles have multiple photos.
        BundlePhotoChance = 10,
        -- Bonus chance per rank (adds to both of the above). Rank 10 Legend adds +5%.
        ChancePerRank = 0.5,
        PayoutMultiplier = 8,     -- 8x the normal sale price
    },

    -- 💰 Generous tip — small bonus on top of a successful sale
    Tip = {
        Enabled = true,
        Chance = 10,              -- 10%
        MinBonus = 100,
        MaxBonus = 1000,
    },
}

-- ============================================================================
-- 🔔 COMMANDS
-- ============================================================================
Config.Commands = {
    Stats        = "baddiestats",   -- /baddiestats   — personal stats panel
    Challenges   = "baddiegoals",   -- /baddiegoals   — daily + weekly challenges
    Achievements = "baddieawards",  -- /baddieawards  — achievement grid
}
-- ============================================================================
-- 📱 BADDIE PHONE — in-app digital camera + social earnings app
-- ============================================================================
-- A separate item (baddie_phone) that opens a phone in the corner with the
-- "Baddie" app permanently on it. Make an account, take photos in the app,
-- they save to your Gallery, then upload them and they passively earn views,
-- likes, followers and donations over time (with viral mechanics).
--
-- This is DIFFERENT from the baddie_cam item (the real-world camera that makes
-- sellable photo items). The phone app is its own self-contained social loop.
Config.BaddiePhone = {
    enable  = true,
    item    = "baddie_phone",  -- inventory item that opens the app
    command = "baddiephone",   -- chat command to toggle the phone (optional)
    keybind = "",              -- optional default key (e.g. "F4"). "" = disabled (command/item only)
    closeKey = true,           -- ESC puts the phone away

    -- Phone frame (same look as the companion app's built-in phone)
    position = "bottom-right",  -- bottom-right | bottom-left | top-right | top-left
    offsetX  = 24,
    offsetY  = 24,
    width    = 360,
    scale    = 1.0,
    use24h   = true,

    -- Account / gallery
    maxGallery   = 30,    -- max photos kept in the gallery
    captionMax   = 140,
    usernameMax  = 20,
    bioMax       = 200,

    -- ========================================================================
    -- 🔓 UNLOCK — auto-give the phone item when a player reaches a rank
    -- ========================================================================
    -- Uses the existing XP/Rank system (Config.Ranks). e.g. Rank = 10 hands the
    -- player a baddie_phone the moment they hit Legend. Set Enabled = false to
    -- only ever give it via the shop / admin / your own logic.
    Unlock = {
        Enabled          = true,   -- master toggle for auto-granting
        Rank             = 10,     -- rank that grants the phone (see Config.Ranks)
        GiveOnRankUp     = true,   -- give it the moment they rank up to/over Rank
        GiveOnLogin      = true,   -- also give to players already at/above Rank when they load in
        OncePerCharacter = true,   -- never auto-give again once a character has received it
        Notify           = true,   -- notify the player when it's granted
        NotifyText       = 'You unlocked the Baddie Phone! Check your inventory. 📱',
    },

    -- ========================================================================
    -- 🚫 REQUIREMENTS TO OPEN THE APP
    -- ========================================================================
    -- Checked every time the phone is opened (item, command or keybind). If the
    -- player doesn't qualify, the phone won't open and they're told what's missing.
    Requirements = {
        Female      = true,   -- must be a female ped (uses Config.FemaleModel)
        RequireRank = true,   -- must have reached a rank to use it
        Rank        = nil,    -- nil = use the Unlock.Rank above; or set a specific rank (1-10)
        -- Messages (shown when a requirement isn't met)
        FemaleMsg   = 'Only baddies (females) can use the OnlyPics app.',
        RankMsg     = 'Reach %s (rank %d) before you can use the OnlyPics app.',  -- %s = rank name, %d = rank number
    },

    -- ========================================================================
    -- 🔔 NOTIFICATIONS — slide the phone up from the corner with a banner
    -- ========================================================================
    -- When the app has activity (earnings every interval, etc.) the phone peeks
    -- up from the bottom-right, shows an iOS-style notification, then slides back
    -- down. Set UsePhonePopup = false to fall back to your normal notify system.
    Notifications = {
        UsePhonePopup = true,
        Duration      = 4500,   -- ms the popup stays on screen before sliding down
    },


    -- ========================================================================
    -- Defaults are tuned to the user's spec: ~10 views per interval gives ~3-4
    -- likes, ~4-5 followers, and 2-3 donations of $2,000-3,000 (normal photos).
    Growth = {
        IntervalMinutes = 15,   -- how often uploaded photos earn

        -- Earn while offline too? false = only while the owner is online.
        OfflineEarnings = false,

        -- VIEWS per photo per interval. Bias > 1 makes high view counts rarer.
        -- value = Min + (Max-Min) * (random ^ Bias)
        Views = {
            Min  = 5,
            Max  = 20,
            Bias = 2.2,   -- higher = rarer to roll near Max
        },

        -- LIKES gained ≈ a third of that interval's views.
        Likes = {
            PerView = 0.34,   -- 10 views -> ~3-4 likes
            Jitter  = 0.15,   -- ±15% randomness
        },

        -- FOLLOWERS gained ≈ ~0.45 × views (10 views -> ~4-5 followers).
        Followers = {
            PerView = 0.45,
            Jitter  = 0.25,
        },

        -- DONATIONS — a slice of viewers tip you.
        Donations = {
            DonorsPerView = 0.25,   -- 10 views -> ~2-3 donors
            DonorsJitter  = 0.30,
            MaxDonors     = 8,      -- hard cap per photo per interval
            PayTo         = "cash", -- "cash" or "bank"
            Normal = { Min = 2000, Max = 3000 },  -- per donor, normal photos
            Viral  = { Min = 3000, Max = 5000 },  -- per donor, viral photos
            -- Notify the player each interval with what a photo earned?
            Notify = true,
        },

        -- How long a NORMAL photo keeps earning before it goes stale (random per photo).
        DurationHours = { Min = 12, Max = 24 },

        -- ⭐ VIRAL photos
        Viral = {
            ChanceOnUpload = 8,   -- % chance a freshly uploaded photo goes viral
            Views = {             -- viral photos pull way more views per interval
                Min  = 50,
                Max  = 100,
                Bias = 1.6,
            },
            DurationHours = { Min = 24, Max = 48 },  -- viral photos last longer
        },
    },
}
