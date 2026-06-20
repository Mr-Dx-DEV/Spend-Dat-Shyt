--- ######################### ---
--- ## DISCORD.GG/CODEWAVE ## ---
--- ######################### ---

--- ### WIGS & BUNDLES ### ---

Config = {}
Config.Framework       = 'QBCore'      -- 'ESX' or 'QBCore' (case sensitive)
Config.InteractionType = 'ox_target'   -- ox_target | 3dtext
Config.UseOxTargetForNpc = true
Config.TimeToCraft     = 8000
Config.DebugMode       = false

Config.bundleBoxPropName = "prop_shopping_bags01" -- If you have issues selling, try changing this prop to another head to Pleb Masters for a list of props

Config.MinItemsToSell    = 1
Config.MaxItemsToSell    = 3
Config.StopSellingCommand  = 'stopsellingbundles'
Config.StartSellingCommand = 'sellbundles'

Config.OnlyFemales   = true -- If true, be sure to add the models down below (there is already one in there as an example)
Config.PermittedPedModels = {
    GetHashKey("mp_f_freemode_01"),
    GetHashKey("some_other_male_ped_model")
}

Config.Jobs = {
    Enabled     = false,
    AllowedJobs = { "mechanic", "doctor" }
}

Config.NPC = {
    Model       = "CSB_CallGirl_01",
    Coords      = vector3(975.4017, -313.8904, 66.6298), -- IF PED IS FLOATING, DECREASE THE Z COORDINATE BY 1
    Heading     = 137.1861,
    BlipEnabled = true,
    BlipSprite  = 621,
    BlipScale   = 1.0,
    BlipColour  = 8,
    BlipName    = "Wigs & Bundles"
}


Config.Items = {
    { name = "Wig Cap",      id = "wigcap",        img = "image/wigcap.png",        price = 150 },
    { name = "Wig bundle",   id = "wigbundle",      img = "image/wigbundle.png",      price = 500 },
    { name = "Wig table",    id = "wigtable",       img = "image/wigtable.png",       price = 2000 },
    { name = "Sewing kit",   id = "sewingkit",      img = "image/sewingkit.png",      price = 100 },
    { name = "Client Phone", id = "wigclientphone", img = "image/wigclientphone.png", price = 2400 }
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

Config.CraftingRecipes = {
    -- Available from Level 1
    { name = "Short Hair Wig",    id = "short_hair_wig",   unlockLevel = 1, img = "image/short_hair_wig.png",   requiredItems = { { id = "wigcap", quantity = 1 }, { id = "wigbundle", quantity = 3 }, { id = "sewingkit", quantity = 1 } }, yield = 1 },
    { name = "Bang Wigs",         id = "bangwigs",          unlockLevel = 1, img = "image/bangwigs.png",          requiredItems = { { id = "wigcap", quantity = 1 }, { id = "wigbundle", quantity = 3 }, { id = "sewingkit", quantity = 1 } }, yield = 2 },
    { name = "Straight Wigs",     id = "straightwigs",      unlockLevel = 1, img = "image/straightwigs.png",      requiredItems = { { id = "wigcap", quantity = 1 }, { id = "wigbundle", quantity = 3 }, { id = "sewingkit", quantity = 1 } }, yield = 2 },

    -- Unlocked at Level 3
    { name = "Short Curled Wig",  id = "short_curled_wig",  unlockLevel = 3, img = "image/short_curled_wig.png",  requiredItems = { { id = "wigcap", quantity = 1 }, { id = "wigbundle", quantity = 3 }, { id = "sewingkit", quantity = 1 } }, yield = 2 },
    { name = "Body Wave Wigs",    id = "bodywavewigs",       unlockLevel = 3, img = "image/bodywavewigs.png",       requiredItems = { { id = "wigcap", quantity = 1 }, { id = "wigbundle", quantity = 3 }, { id = "sewingkit", quantity = 1 } }, yield = 1 },

    -- Unlocked at Level 5
    { name = "Long Curly Wig",    id = "long_curly",         unlockLevel = 5, img = "image/long_curly.png",         requiredItems = { { id = "wigcap", quantity = 1 }, { id = "wigbundle", quantity = 3 }, { id = "sewingkit", quantity = 1 } }, yield = 2 },
    { name = "Braid Wigs",        id = "braidwigs",           unlockLevel = 5, img = "image/braidwigs.png",           requiredItems = { { id = "wigcap", quantity = 1 }, { id = "wigbundle", quantity = 3 }, { id = "sewingkit", quantity = 1 } }, yield = 2 },

    -- Unlocked at Level 7
    { name = "Long Blonde Wig",   id = "long_blonde_wig",    unlockLevel = 7, img = "image/long_blonde_wig.png",    requiredItems = { { id = "wigcap", quantity = 1 }, { id = "wigbundle", quantity = 4 }, { id = "sewingkit", quantity = 1 } }, yield = 1 },
    { name = "Natural Wave Wigs", id = "naturalwavewigs",    unlockLevel = 7, img = "image/naturalwavewigs.png",    requiredItems = { { id = "wigcap", quantity = 1 }, { id = "wigbundle", quantity = 4 }, { id = "sewingkit", quantity = 1 } }, yield = 3 },

    -- Unlocked at Level 9 (prestige recipes)
    { name = "40 Inch Wigs",      id = "40inchwigs",          unlockLevel = 9, img = "image/40inchwigs.png",          requiredItems = { { id = "wigcap", quantity = 2 }, { id = "wigbundle", quantity = 5 }, { id = "sewingkit", quantity = 2 } }, yield = 3 },
    { name = "Deep Wave Wigs",    id = "deepwavewigs",         unlockLevel = 9, img = "image/deepwavewigs.png",         requiredItems = { { id = "wigcap", quantity = 2 }, { id = "wigbundle", quantity = 5 }, { id = "sewingkit", quantity = 2 } }, yield = 1 },

    -- Simply follow the same pattern to add more wigs and levels!
}

Config.PlayMusicWhileUIIsOpen = false
Config.MusicVolume            = 0.05

Config.bundleTableItem = 'wigtable'
Config.PropItemName    = 'prop_table_03'


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

Config.XP = {
    XpPerSaleMin = 15,
    XpPerSaleMax = 35,

    Levels = {
        [1]  = { xpRequired = 0,    payoutMultiplier = 1.00, title = "Newcomer"         },
        [2]  = { xpRequired = 150,  payoutMultiplier = 1.05, title = "Apprentice"        },
        [3]  = { xpRequired = 400,  payoutMultiplier = 1.10, title = "Wig Worker"        },
        [4]  = { xpRequired = 800,  payoutMultiplier = 1.15, title = "Bundle Hustler"    },
        [5]  = { xpRequired = 1400, payoutMultiplier = 1.20, title = "Seasoned Seller"   },
        [6]  = { xpRequired = 2200, payoutMultiplier = 1.28, title = "Style Dealer"      },
        [7]  = { xpRequired = 3200, payoutMultiplier = 1.36, title = "Hair Boss"         },
        [8]  = { xpRequired = 4500, payoutMultiplier = 1.45, title = "Wig Mogul"         },
        [9]  = { xpRequired = 6000, payoutMultiplier = 1.55, title = "Crown Supplier"    },
        [10] = { xpRequired = 8000, payoutMultiplier = 1.70, title = "Legendary Stylist" },
    },
}


-- NPC sale base prices (before level multiplier)
Config.RequiredItems = {
    { item = 'long_curly', priceMin = 1800, priceMax = 2200 },
    { item = 'short_hair_wig', priceMin = 1600, priceMax = 2000 },
    { item = 'short_curled_wig', priceMin = 1800, priceMax = 2200 },
    { item = 'long_blonde_wig', priceMin = 2000, priceMax = 2400 },
    { item = '40inchwigs', priceMin = 2400, priceMax = 3000 },
    { item = 'braidwigs', priceMin = 1600, priceMax = 1900 },
    { item = 'bodywavewigs', priceMin = 2000, priceMax = 2400 },    
    { item = 'bangwigs', priceMin = 1800, priceMax = 2200 },
    { item = 'straightwigs', priceMin = 2000, priceMax = 2400 },
    { item = 'naturalwavewigs', priceMin = 2000, priceMax = 2500 },
    { item = 'deepwavewigs', priceMin = 2400, priceMax = 3000 }
}


Config.NpcModels = {
    'a_f_m_beach_01', 'a_f_m_fatbla_01', 'a_f_m_fatcult_01',
    'a_f_m_ktown_01', 'a_f_m_prolhost_01', 'a_f_m_salton_01'
}

Config.WorkWithoutTable = {
    Enabled = true,
    Coords  = vector3(57.6370, -1607.3962, 29.5428),
    Text    = "Press [E] To Craft Wigs",
    JobRequired = {
        Enabled     = false,
        AllowedJobs = { "wigs_worker", "police" }
    }
}


Config.SpawnOffset = false -- If true the npc on selling will use these offsets, it helps with custom maps, NOT NEEDED FOR STANDARD LOS SANTOS MAP

Config.SpawnOffsets = {
    { x =  5.0, y =  0.0, z = 0.0 },
    { x = -5.0, y =  0.0, z = 0.0 },
    { x =  0.0, y =  5.0, z = 0.0 },
    { x =  0.0, y = -5.0, z = 0.0 },
    { x =  4.0, y =  4.0, z = 0.0 },
    { x = -4.0, y = -4.0, z = 0.0 },
}