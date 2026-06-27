-- ######################### --
-- ## DISCORD.GG/CODEWAVE ## --
-- ######################### --

-- ### TechWorkzS ### --

CodeWave_TechWorkz_Config = {}

-- ############################################################
-- ###               FRAMEWORK & GENERAL                    ###
-- ############################################################

-- CodeWave_TechWorkz_Framework options:
-- 'auto'   = detect qb-core or es_extended automatically
-- 'ESX'    = force ESX
-- 'QBCore' = force QBCore
CodeWave_TechWorkz_Config.Framework       = 'auto'

-- Inventory options:
-- 'auto'         = ox_inventory if running, otherwise qb-inventory if running, otherwise framework inventory
-- 'ox_inventory' = use ox_inventory exports for carry checks
-- 'qb-inventory' = use qb-inventory exports for carry checks
-- 'esx'          = use ESX xPlayer.canCarryItem / canSwapItem
-- 'framework'    = fallback; uses CodeWave_TechWorkz_Framework:CanCarryItem if your bridge has it, otherwise allows add
CodeWave_TechWorkz_Config.Inventory       = 'ox_inventory'
CodeWave_TechWorkz_Config.InteractionType = 'ox_target'   -- ox_target | 3dtext
CodeWave_TechWorkz_Config.UseOxTargetForNpc = true
CodeWave_TechWorkz_Config.TimeToCraft     = 8000
CodeWave_TechWorkz_Config.DebugMode       = false

-- ############################################################
-- ###               SELLING & NPC SETTINGS                 ###
-- ############################################################

CodeWave_TechWorkz_Config.TechWorkzBoxPropName = "gkms_prop_box" -- If you have issues selling, try changing this prop


CodeWave_TechWorkz_Config.NPCCooldown = 5 -- 15 seconds, this is the amount of time it will take for a new npc to spawn!
CodeWave_TechWorkz_Config.MinItemsToSell    = 1
CodeWave_TechWorkz_Config.MaxItemsToSell    = 3

-- ─── Rare drop on sale ───────────────────────────────────────────────────────
-- After every successful sale, the server rolls once for a bonus item drop.
-- This is independent of XP and money — it's just a chance to receive an extra
-- "JailBreak" item the player can use elsewhere (e.g. at the second crafting
-- bench). One roll per sale event, regardless of how many items were sold.
CodeWave_TechWorkz_Config.JailBreakItem = {
    Enabled  = true,
    Chance   = 1,                  -- Percent (0–100). 1 = 1% chance per sale.
    Item     = "workz_usb",    -- Item ID to give on success. Must exist as a usable inventory item.
    Quantity = 1,                  -- How many to give when the roll hits.
    Notify   = true,               -- Show the player a notification when they receive one.
}

-- ─── Usable consoles (Box / Inspect UI) ──────────────────────────────────────
-- When a player uses any item listed below, a small "Condition / Box" UI
-- opens. A random condition value is rolled on each use. If the player clicks
-- "Box", the console is consumed and they receive the mapped boxed item.
CodeWave_TechWorkz_Config.UsableConsoles = {
    Enabled = true,
    Tiers = {
        { id = "poor",      label = "Poor",      colourVar = "--cond-poor",     maxRoll = 25,  weight = 15 },
        { id = "fair",      label = "Fair",      colourVar = "--cond-fair",     maxRoll = 55,  weight = 30 },
        { id = "good",      label = "Good",      colourVar = "--cond-good",     maxRoll = 80,  weight = 35 },
        { id = "pristine",  label = "Pristine",  colourVar = "--cond-pristine", maxRoll = 95,  weight = 17 },
        { id = "mint",      label = "Mint",      colourVar = "--cond-mint",     maxRoll = 100, weight = 3  },
    },

    -- Map of console item id → { boxed, box } where:
    --   `boxed` = the item ID the player receives after boxing.
    --   `box`   = the box item ID required to perform the action. Each console
    --             needs its own box type (the boxes are sized/branded per
    --             console model in-fiction). One box is consumed per box action.
    --
    -- All three item IDs (the console, the box, and the boxed product) must
    -- exist in your inventory framework's items registry. Comment out a line
    -- to disable boxing for that console.
    Map = {
        ["vortex_x"]            = { boxed = "vortex_x_boxed",            box = "vortex_x_box"   },
        ["phantom"]             = { boxed = "phantom_boxed",             box = "phantom_box"    },
        ["prodigy_5"]           = { boxed = "prodigy_5_boxed",           box = "prodigy_5_box"  },
        ["novadeck"]            = { boxed = "novadeck_boxed",            box = "novadeck_box"   },
        ["vortex_x_jailbreak"]  = { boxed = "vortex_x_jailbreak_boxed",  box = "vortex_x_box"   },
        ["phantom_jailbreak"]   = { boxed = "phantom_jailbreak_boxed",   box = "phantom_box"    },
        ["prodigy_5_jailbreak"] = { boxed = "prodigy_5_jailbreak_boxed", box = "prodigy_5_box"  },
        ["novadeck_jailbreak"]  = { boxed = "novadeck_jailbreak_boxed",  box = "novadeck_box"   },
    },
}
CodeWave_TechWorkz_Config.StopSellingCommand  = 'stopsellingconsoles' -- Command to stop the selling process if you want to end it early for any reason
CodeWave_TechWorkz_Config.StartSellingCommand = 'sellconsoles'

CodeWave_TechWorkz_Config.OnlyMales   = false -- If true, be sure to add the models down below
CodeWave_TechWorkz_Config.PermittedPedModels = {
    GetHashKey("mp_m_freemode_01"),
    GetHashKey("some_other_male_ped_model")
}

CodeWave_TechWorkz_Config.Jobs = {
    Enabled     = false,
    AllowedJobs = { "mechanic", "doctor" }
}

CodeWave_TechWorkz_Config.NPC = {
    Model       = "CSB_CallGirl_01",
    Coords      = vector3(-829.0472, -1088.5660, 11.1364), -- IF PED IS FLOATING, DECREASE THE Z COORDINATE BY 1
    Heading     = 305.3142,
    BlipEnabled = true,
    BlipSprite  = 521,
    BlipScale   = 0.5,
    BlipColour  = 3,
    BlipName    = "TechWorkz"
}

CodeWave_TechWorkz_Config.Negotiation = {
    Enabled             = true,  -- false = instant sale, no haggling
    OpenMinPct          = 70,    -- opening offer floor (% of base value)
    OpenMaxPct          = 100,   -- opening offer ceiling
    CounterMaxPct       = 130,   -- best possible negotiated payout (%)
    CounterAggression   = 0.6,   -- 0..1, how far a successful counter pushes toward the ceiling
    WalkBaseChance      = 8,     -- min % chance the NPC walks on a counter
    WalkMaxChance       = 35,    -- max % chance (when countering from the lowest opening offer)
    AcceptCounterChance = 55,    -- % chance the NPC accepts the counter vs holding firm
    SingleCounter       = true,  -- only one counter allowed per negotiation
    TimeoutSeconds      = 30,    -- seconds before an un-actioned offer expires
}

-- ############################################################
-- ###                  STORE ITEMS                         ###
-- ############################################################

CodeWave_TechWorkz_Config.Items = {
    { name = "TechWorkz Station", id = "techworkz_station", img = "image/techworkz_station.png", price = 1000 },
    { name = "Vortex X Shell", id = "vortex_x_shell", img = "image/vortex_x_shell.png", price = 100 },
    { name = "Prodigy 5 Shell", id = "prodigy_5_shell", img = "image/prodigy_5_shell.png", price = 100 },
    { name = "Nova Deck Shell", id = "novadeck_shell", img = "image/novadeck_shell.png", price = 150 },
    { name = "Phantom Shell", id = "phantom_shell", img = "image/phantom_shell.png", price = 200 },

    { name = "LCD Screen", id = "lcd_screen", img = "image/lcd_screen.png", price = 150 },
    { name = "Console Motherboard", id = "console_motherboard", img = "image/console_motherboard.png", price = 500 },
    { name = "Power Unit", id = "power_unit", img = "image/power_unit.png", price = 300 },
    { name = "Cooling Kit", id = "cooling_kit", img = "image/cooling_kit.png", price = 250 },
    { name = "Storage Module", id = "storage_module", img = "image/storage_module.png", price = 400 },
    { name = "Disc Drive", id = "disc_drive", img = "image/disc_drive.png", price = 350 },
    { name = "Network Module", id = "network_module", img = "image/network_module.png", price = 200 },

    { name = "Vortex X Controller Parts", id = "vortex_x_controller_parts", img = "image/vortex_x_controller_parts.png", price = 150 },
    { name = "Prodigy 5 Controller Parts", id = "prodigy_5_controller_parts", img = "image/prodigy_5_controller_parts.png", price = 150 },
    { name = "Vortex X Battery", id = "vortex_x_battery", img = "image/vortex_x_battery.png", price = 120 },
    { name = "Prodigy 5 Battery", id = "prodigy_5_battery", img = "image/prodigy_5_battery.png", price = 120 },
    { name = 'vortex_x_box', id = 'vortex_x_box', img = 'image/vortex_x_box.png', price = 50 },
    { name = 'phantom_box', id = 'phantom_box', img = 'image/phantom_box.png', price = 50 },
    { name = 'prodigy_5_box', id = 'prodigy_5_box', img = 'image/prodigy_5_box.png', price = 50 },
    { name = 'novadeck_box', id = 'novadeck_box', img = 'image/novadeck_box.png', price = 50 }
}

-- ############################################################
-- ###          CRAFTING RECIPES & LEVEL UNLOCKS            ###
-- ############################################################
--
-- Each recipe has an optional 'unlockLevel' field.
-- Players below that level will see the recipe in the UI but
-- it will be locked — they cannot craft it until they level up.
-- Recipes with no 'unlockLevel' (or unlockLevel = 1) are
-- available to everyone from the start.

CodeWave_TechWorkz_Config.CraftingRecipes = {
    -- Available from Level 1
    {
        name = "Vortex X",
        id = "vortex_x",
        unlockLevel = 1,
        img = "image/vortex_x.png",
        requiredItems = {
            { id = "vortex_x_shell", quantity = 1 },
            { id = "console_motherboard", quantity = 2 },
            { id = "power_unit", quantity = 1 },
            { id = "cooling_kit", quantity = 1 },
            { id = "storage_module", quantity = 1 },
            { id = "disc_drive", quantity = 1 },
            { id = "network_module", quantity = 1 }
        },
        yield = 5
    },

    {
        name = "Prodigy 5",
        id = "prodigy_5",
        unlockLevel = 1,
        img = "image/prodigy_5.png",
        requiredItems = {
            { id = "prodigy_5_shell", quantity = 1 },
            { id = "console_motherboard", quantity = 2 },
            { id = "power_unit", quantity = 1 },
            { id = "cooling_kit", quantity = 1 },
            { id = "storage_module", quantity = 1 },
            { id = "disc_drive", quantity = 1 },
            { id = "network_module", quantity = 1 }
        },
        yield = 5
    },

    {
        name = "Novadeck",
        id = "novadeck",
        unlockLevel = 1,
        img = "image/novadeck.png",
        requiredItems = {
            { id = "novadeck_shell", quantity = 1 },
            { id = "console_motherboard", quantity = 2 },
            { id = "power_unit", quantity = 1 },
            { id = "cooling_kit", quantity = 1 },
            { id = "storage_module", quantity = 1 },
            { id = "disc_drive", quantity = 1 },
            { id = "network_module", quantity = 1 }
        },
        yield = 5
    },

    {
        name = "Phantom",
        id = "phantom",
        unlockLevel = 1,
        img = "image/phantom.png",
        requiredItems = {
            { id = "phantom_shell", quantity = 1 },
            { id = "console_motherboard", quantity = 2 },
            { id = "power_unit", quantity = 1 },
            { id = "cooling_kit", quantity = 1 },
            { id = "storage_module", quantity = 1 },
            { id = "disc_drive", quantity = 1 },
            { id = "network_module", quantity = 1 }
        },
        yield = 5
    },

    -- Unlocked at Level 3
    {
        name = "Prodigy 5 Controller",
        id = "prodigy_5_controller",
        unlockLevel = 3,
        img = "image/prodigy_5_controller.png",
        requiredItems = {
            { id = "prodigy_5_controller_parts", quantity = 1 },
            { id = "prodigy_5_battery", quantity = 2 }
        },
        yield = 1
    },

    {
        name = "Vortex X Controller",
        id = "vortex_x_controller",
        unlockLevel = 3,
        img = "image/vortex_x_controller.png",
        requiredItems = {
            { id = "vortex_x_controller_parts", quantity = 1 },
            { id = "vortex_x_battery", quantity = 2 }
        },
        yield = 1
    },
}


CodeWave_TechWorkz_Config.PlayMusicWhileUIIsOpen = false
CodeWave_TechWorkz_Config.MusicVolume            = 0.05

CodeWave_TechWorkz_Config.PCTableItem = 'techworkz_station'
CodeWave_TechWorkz_Config.PropItemName    = 'gkms_prop_pctable'

-- ############################################################
-- ###               XP & LEVEL SYSTEM                      ###
-- ############################################################
--
-- XP is earned per item sold to an NPC client.
-- Higher levels unlock additional crafting recipes (see above)
-- and increase the money earned per sale via payoutMultiplier.
--
-- xpRequired       = total cumulative XP to reach this level.
-- payoutMultiplier = multiplier on the BASE sale price at this level.
-- title            = rank name shown in the crafting UI.

CodeWave_TechWorkz_Config.XP = {
    XpPerSaleMin = 15,
    XpPerSaleMax = 35,

    Levels = {
        [1]  = { xpRequired = 0,    payoutMultiplier = 1.00, title = "First Boot"          },
        [2]  = { xpRequired = 150,  payoutMultiplier = 1.05, title = "Console Rookie"      },
        [3]  = { xpRequired = 400,  payoutMultiplier = 1.10, title = "Tech Apprentice"     },
        [4]  = { xpRequired = 800,  payoutMultiplier = 1.15, title = "Console Flipper"     },
        [5]  = { xpRequired = 1400, payoutMultiplier = 1.20, title = "System Specialist"   },
        [6]  = { xpRequired = 2200, payoutMultiplier = 1.28, title = "Hardware Dealer"     },
        [7]  = { xpRequired = 3200, payoutMultiplier = 1.36, title = "Console Boss"        },
        [8]  = { xpRequired = 4500, payoutMultiplier = 1.45, title = "Game System Mogul"   },
        [9]  = { xpRequired = 6000, payoutMultiplier = 1.55, title = "TechWorkz Supplier"  },
        [10] = { xpRequired = 8000, payoutMultiplier = 1.70, title = "Console Legend"      },
    },
}

-- NPC sale base prices (before level multiplier)
CodeWave_TechWorkz_Config.RequiredItems = {
    { item = 'vortex_x',  priceMin = 180, priceMax = 220 },
    { item = 'prodigy_5',      priceMin = 180, priceMax = 220 },
    { item = 'novadeck',     priceMin = 180, priceMax = 220 },
    { item = 'phantom',          priceMin = 200, priceMax = 240 },
    { item = 'prodigy_5_controller',       priceMin = 200, priceMax = 240 },
    { item = 'vortex_x_controller',        priceMin = 220, priceMax = 270 },
    { item = 'vortex_x_jailbreak',        priceMin = 220, priceMax = 270 },
    { item = 'phantom_jailbreak',       priceMin = 250, priceMax = 310 },
    { item = 'prodigy_5_jailbreak',       priceMin = 250, priceMax = 310 },
    { item = 'novadeck_jailbreak',       priceMin = 250, priceMax = 310 },
    { item = 'vortex_x_boxed',        priceMin = 300, priceMax = 390 },
    { item = 'phantom_boxed',         priceMin = 360, priceMax = 400 },
    { item = 'prodigy_5_boxed',       priceMin = 340, priceMax = 490 },
    { item = 'novadeck_boxed',        priceMin = 340, priceMax = 490 },
}


CodeWave_TechWorkz_Config.NpcModels = {
    'a_m_m_business_01',
    'a_m_m_eastsa_01',
    'a_m_m_hillbilly_01',
    'a_m_m_ktown_01',
    'a_m_m_mexcntry_01',
    'a_m_m_og_boss_01',
    'a_m_y_stbla_01',
    'a_m_y_stbla_02',
    'g_m_m_armboss_01',
    'g_m_m_armgoon_01',
    'g_m_y_azteca_01',
    'g_m_y_ballaeast_01',
    'g_m_y_ballaorig_01',
    'g_m_y_ballasout_01',
    'g_m_y_famca_01',
    'g_m_y_famdnf_01',
    'g_m_y_lost_01',
    'g_m_y_lost_02',
    'g_m_y_lost_03',
    'g_m_y_mexgang_01',
    'g_m_y_mexgoon_01',
    'g_m_y_salvaboss_01',
    'g_m_y_salvagoon_01',
    'g_m_y_strpunk_01',
    'g_m_y_strpunk_02'
}

-- ############################################################
-- ###          CRAFTING TABLE & STATIC LOCATIONS           ###
-- ############################################################

CodeWave_TechWorkz_Config.WorkWithoutTable = {
    Enabled = false,
    Coords  = vector3(-672.2610, -147.2214, 36.9348),
    Heading = 30.0,       -- NPC heading at this location
    NpcModel = nil,      -- nil = uses CodeWave_TechWorkz_Config.NPC.Model
    Text    = "Press [E] To Assemble Electronics",
    JobRequired = {
        Enabled     = false,
        AllowedJobs = { "wigs_worker", "police" }
    }
}

CodeWave_TechWorkz_Config.SpawnOffset = false -- If true the npc on selling will use these offsets, it helps with custom maps, NOT NEEDED FOR STANDARD LOS SANTOS MAP

CodeWave_TechWorkz_Config.SpawnOffsets = {
    { x =  5.0, y =  0.0, z = 0.0 },
    { x = -5.0, y =  0.0, z = 0.0 },
    { x =  0.0, y =  5.0, z = 0.0 },
    { x =  0.0, y = -5.0, z = 0.0 },
    { x =  4.0, y =  4.0, z = 0.0 },
    { x = -4.0, y = -4.0, z = 0.0 },
}

-- ############################################################
-- ###        SECOND CRAFTING TABLE — APPAREL / CLOTHING    ###
-- ############################################################
--
-- Entirely separate recipe set with its own location.
-- No store, no NPC selling, no XP bar — crafting only.
-- Add or remove entries exactly like CodeWave_TechWorkz_Config.CraftingRecipes above.
CodeWave_TechWorkz_Config.CraftingRecipes2 = {
    { name = "Vortex X JailBreak",        id = "vortex_x_jailbreak",        unlockLevel = 1, img = "image/vortex_x_jailbreak.png",        requiredItems = { { id = "vortex_x",        quantity = 1 }, { id = "workz_usb",     quantity = 1 } }, yield = 1 },
    { name = "Phantom JailBreak",        id = "phantom_jailbreak",        unlockLevel = 1, img = "image/phantom_jailbreak.png",        requiredItems = { { id = "phantom",        quantity = 1 }, { id = "workz_usb",     quantity = 1 } }, yield = 1 },
    { name = "Prodigy 5 JailBreak",       id = "prodigy_5_jailbreak",       unlockLevel = 1, img = "image/prodigy_5_jailbreak.png",       requiredItems = { { id = "prodigy_5",       quantity = 1 }, { id = "workz_usb",     quantity = 1 } }, yield = 1 },
    { name = "Nova JailBreak",       id = "novadeck_jailbreak",       unlockLevel = 1, img = "image/novadeck_jailbreak.png",       requiredItems = { { id = "novadeck",       quantity = 1 }, { id = "workz_usb",     quantity = 1 } }, yield = 1 },

}

-- Static crafting location for the SECOND crafting table
CodeWave_TechWorkz_Config.JailBreakNPC = {
    Enabled = true,
    Coords  = vector3(-280.4609, 98.0022, 67.7185),
    Heading = 88.0,       -- NPC heading at this location
    NpcModel = 'HC_Hacker',
    Text    = "Press [E] To Jailbreak Consoles",
    JobRequired = {
        Enabled     = false,
        AllowedJobs = { "tailor", "police" }
    }
}
