-- ######################### --
-- ## DISCORD.GG/CODEWAVE ## --
-- ######################### --

-- ### SNEAKERS ### --

Config = {}

-- ############################################################
-- ###               FRAMEWORK & GENERAL                    ###
-- ############################################################

-- Framework options:
-- 'auto'   = detect qb-core or es_extended automatically
-- 'ESX'    = force ESX
-- 'QBCore' = force QBCore
Config.Framework       = 'auto'
Config.InteractionType = 'ox_target'   -- ox_target | 3dtext
Config.UseOxTargetForNpc = true
Config.TimeToCraft     = 8000
Config.DebugMode       = false

-- ############################################################
-- ###            SHOE EQUIP & VISUAL SYSTEM                ###
-- ############################################################

-- How often to verify the player still has the currently equipped shoe item.
Config.InventoryCheckInterval = 3000 -- 3 seconds

-- Notify player when shoes are removed because the item is gone.
Config.NotifyOnAutoRemove = true

-- Only freemode peds are safely supported for clothing component changes.
Config.RestrictToFreemodePeds = true

-- Component id for shoes / feet.
Config.ShoeComponentId = 6

-- Animation settings for putting on / taking off shoes.
-- The player will kneel down, wait for the duration, then stand back up.
Config.Animation = {
    enabled = true,
    dict = 'pickup_object',
    anim = 'pickup_low',
    duration = 2000, -- ms – how long the animation plays
    flag = 0,        -- 0 = normal playback
}

-- Robbery settings.
Config.Robbery = {
    enabled = true,              -- set to false to completely disable shoe robbery
    maxDistance = 3.0,            -- how close the robber must be to the victim
    cooldown = 30000,             -- ms – per-player cooldown between rob attempts
    robberAnimation = true,       -- play the pickup animation on the robber after item transfer
    aimDuration = 3000,           -- ms – how long the robber aims at the victim before the prompt

    -- If true, the robber must have one of the weapons listed in AllowedWeapons equipped.
    -- If false, any player can use /robshoes without a weapon.
    requireWeapon = true,

    -- Weapon hashes that are allowed for robbing.
    -- Only checked when requireWeapon = true.
    -- Use the joaat hash name exactly as GTA recognises it.
    AllowedWeapons = {
        `WEAPON_PISTOL`,
        `WEAPON_PISTOL_MK2`,
        `WEAPON_COMBATPISTOL`,
        `WEAPON_APPISTOL`,
        `WEAPON_PISTOL50`,
        `WEAPON_SNSPISTOL`,
        `WEAPON_SNSPISTOL_MK2`,
        `WEAPON_HEAVYPISTOL`,
        `WEAPON_VINTAGEPISTOL`,
        `WEAPON_CERAMICPISTOL`,
        `WEAPON_NAVYREVOLVER`,
        `WEAPON_REVOLVER`,
        `WEAPON_REVOLVER_MK2`,
        `WEAPON_DOUBLEACTION`,
        `WEAPON_MICROSMG`,
        `WEAPON_SMG`,
        `WEAPON_SMG_MK2`,
        `WEAPON_COMBATPDW`,
        `WEAPON_PUMPSHOTGUN`,
        `WEAPON_SAWNOFFSHOTGUN`,
        `WEAPON_ASSAULTRIFLE`,
        `WEAPON_CARBINERIFLE`,
    },
}

-- Fallback appearance when a shoe item is removed.
-- These are defaults for freemode peds. Change them to fit your clothing pack.
Config.DefaultShoes = {
    male = {
        drawable = 34,
        texture = 0
    },
    female = {
        drawable = 35,
        texture = 0
    }
}

-- ############################################################
-- ###               SELLING & NPC SETTINGS                 ###
-- ############################################################

Config.sneakerBoxPropName = "gkms_solestreet_propbox1" -- If you have issues selling, try changing this prop


Config.NPCCooldown = 5 -- 15 seconds, this is the amount of time it will take for a new npc to spawn!
Config.MinItemsToSell    = 1
Config.MaxItemsToSell    = 3
Config.StopSellingCommand  = 'stopsellingsneakers'
Config.StartSellingCommand = 'sellsneakers'

Config.OnlyMales   = true -- If true, be sure to add the models down below
Config.PermittedPedModels = {
    GetHashKey("mp_m_freemode_01"),
    GetHashKey("some_other_male_ped_model")
}

Config.Jobs = {
    Enabled     = false,
    AllowedJobs = { "mechanic", "doctor" }
}

Config.NPC = {
    Model       = "CSB_CallGirl_01",
    Coords      = vector3(-667.6820, -142.2312, 36.9152), -- IF PED IS FLOATING, DECREASE THE Z COORDINATE BY 1
    Heading     = 301.5443,
    BlipEnabled = true,
    BlipSprite  = 120,
    BlipScale   = 1.0,
    BlipColour  = 3,
    BlipName    = "Sole Street"
}

-- ############################################################
-- ###                  STORE ITEMS                         ###
-- ############################################################

Config.Items = {
    { name = "Assortment Of leather materials", id = "leather_materials",  img = "image/leather_materials.png", price = 100 },
    { name = "Shoe foam",                       id = "shoe_foam",          img = "image/shoe_foam.png",         price = 200 },
    { name = "Cloth Materials",                 id = "clothe_materials",   img = "image/cloth_materials.png",   price = 300 },
    { name = "Work Station",                    id = "work_station",       img = "image/work_station.png",      price = 100 },
    { name = "Work Phone",                      id = "shoe_phone",         img = "image/shoe_phone.png",        price = 300 }
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
    { name = "Sky Gliders Plus", id = "sky_gliders_plus", unlockLevel = 1, img = "image/sky_gliders_plus.png", requiredItems = { { id = "leather_materials", quantity = 1 }, { id = "shoe_foam", quantity = 2 }, { id = "clothe_materials", quantity = 1 } }, yield = 5 },
    { name = "Breeze Bangs",     id = "breeze_bangs",     unlockLevel = 1, img = "image/breeze_bangs.png",     requiredItems = { { id = "leather_materials", quantity = 1 }, { id = "shoe_foam", quantity = 3 }, { id = "clothe_materials", quantity = 1 } }, yield = 1 },
    { name = "Tiger Mediums",    id = "tiger_mediums",    unlockLevel = 1, img = "image/tiger_mediums.png",    requiredItems = { { id = "leather_materials", quantity = 1 }, { id = "shoe_foam", quantity = 3 }, { id = "clothe_materials", quantity = 1 } }, yield = 3 },

    -- Unlocked at Level 3
    { name = "Galaxy X",         id = "galaxy_x",         unlockLevel = 3, img = "image/galaxy_x.png",         requiredItems = { { id = "leather_materials", quantity = 1 }, { id = "shoe_foam", quantity = 2 }, { id = "clothe_materials", quantity = 2 } }, yield = 1 },
    { name = "Sky Walkers",      id = "sky_walkers",      unlockLevel = 3, img = "image/sky_walkers.png",      requiredItems = { { id = "leather_materials", quantity = 1 }, { id = "shoe_foam", quantity = 3 }, { id = "clothe_materials", quantity = 1 } }, yield = 2 },

    -- Unlocked at Level 5
    { name = "Sky Pilots",       id = "sky_pilots",       unlockLevel = 5, img = "image/sky_pilots.png",       requiredItems = { { id = "leather_materials", quantity = 1 }, { id = "shoe_foam", quantity = 3 }, { id = "clothe_materials", quantity = 1 } }, yield = 2 },
    { name = "Sky Flyers",       id = "sky_flyers",       unlockLevel = 5, img = "image/sky_flyers.png",       requiredItems = { { id = "leather_materials", quantity = 1 }, { id = "shoe_foam", quantity = 3 }, { id = "clothe_materials", quantity = 1 } }, yield = 3 },

    -- Unlocked at Level 7
    { name = "Sky Gliders",      id = "sky_gliders",      unlockLevel = 7, img = "image/sky_gliders.png",      requiredItems = { { id = "leather_materials", quantity = 1 }, { id = "shoe_foam", quantity = 3 }, { id = "clothe_materials", quantity = 1 } }, yield = 1 },
    { name = "Fast Runners",     id = "fastrunner_2000",  unlockLevel = 7, img = "image/fastrunner_2000.png",  requiredItems = { { id = "shoe_foam", quantity = 2 }, { id = "clothe_materials", quantity = 1 } }, yield = 2 },

    -- Unlocked at Level 9 (prestige recipes)
    { name = "Speedster 300",    id = "speedster_300",    unlockLevel = 9, img = "image/speedster_300.png",    requiredItems = { { id = "leather_materials", quantity = 2 }, { id = "shoe_foam", quantity = 1 }, { id = "clothe_materials", quantity = 1 } }, yield = 1 },
    { name = "Runner Prime",     id = "runner_prime",     unlockLevel = 9, img = "image/runner_prime.png",     requiredItems = { { id = "leather_materials", quantity = 2 }, { id = "shoe_foam", quantity = 3 }, { id = "clothe_materials", quantity = 2 } }, yield = 2 },
    { name = "Breeze 95s",       id = "breeze_95s",       unlockLevel = 9, img = "image/breeze_95s.png",       requiredItems = { { id = "leather_materials", quantity = 3 }, { id = "shoe_foam", quantity = 2 }, { id = "clothe_materials", quantity = 1 } }, yield = 1 },
    { name = "Breeze 100s",      id = "breeze_100s",      unlockLevel = 9, img = "image/breeze_100s.png",      requiredItems = { { id = "leather_materials", quantity = 1 }, { id = "shoe_foam", quantity = 2 }, { id = "clothe_materials", quantity = 1 } }, yield = 3 },
    { name = "Breeze 90s",       id = "breeze_90s",       unlockLevel = 9, img = "image/breeze_90s.png",       requiredItems = { { id = "leather_materials", quantity = 2 }, { id = "shoe_foam", quantity = 3 }, { id = "clothe_materials", quantity = 1 } }, yield = 2 },
    { name = "Sky Walkers Red",  id = "sky_walkers_red",  unlockLevel = 9, img = "image/sky_walkers_red.png",  requiredItems = { { id = "leather_materials", quantity = 1 }, { id = "shoe_foam", quantity = 3 }, { id = "clothe_materials", quantity = 2 } }, yield = 1 },
    { name = "Shadow Yellows",   id = "shadow_yellows",   unlockLevel = 9, img = "image/shadow_yellows.png",   requiredItems = { { id = "leather_materials", quantity = 2 }, { id = "shoe_foam", quantity = 2 }, { id = "clothe_materials", quantity = 1 } }, yield = 2 },
}

Config.PlayMusicWhileUIIsOpen = false
Config.MusicVolume            = 0.05

Config.sneakerTableItem = 'work_station'
Config.PropItemName    = 'gkms_solestreet_proptable'

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
        [1]  = { xpRequired = 0,    payoutMultiplier = 1.00, title = "Fresh Kicks"         },
        [2]  = { xpRequired = 150,  payoutMultiplier = 1.05, title = "Apprentice"        },
        [3]  = { xpRequired = 400,  payoutMultiplier = 1.10, title = "Sneaker Worker"        },
        [4]  = { xpRequired = 800,  payoutMultiplier = 1.15, title = "Sneaker Hustler"    },
        [5]  = { xpRequired = 1400, payoutMultiplier = 1.20, title = "Seasoned Seller"   },
        [6]  = { xpRequired = 2200, payoutMultiplier = 1.28, title = "Kicks Dealer"      },
        [7]  = { xpRequired = 3200, payoutMultiplier = 1.36, title = "Kicks Boss"         },
        [8]  = { xpRequired = 4500, payoutMultiplier = 1.45, title = "Sole Mogul"         },
        [9]  = { xpRequired = 6000, payoutMultiplier = 1.55, title = "Sole Supplier"    },
        [10] = { xpRequired = 8000, payoutMultiplier = 1.70, title = "Legendary Cobbler" },
    },
}

-- NPC sale base prices (before level multiplier)
Config.RequiredItems = {
    { item = 'sky_gliders_plus',  priceMin = 180, priceMax = 220 },
    { item = 'breeze_bangs',      priceMin = 180, priceMax = 220 },
    { item = 'tiger_mediums',     priceMin = 180, priceMax = 220 },
    { item = 'galaxy_x',          priceMin = 200, priceMax = 240 },
    { item = 'sky_walkers',       priceMin = 200, priceMax = 240 },
    { item = 'sky_pilots',        priceMin = 220, priceMax = 270 },
    { item = 'sky_flyers',        priceMin = 220, priceMax = 270 },
    { item = 'sky_gliders',       priceMin = 250, priceMax = 310 },
    { item = 'fastrunner_2000',   priceMin = 250, priceMax = 310 },
    { item = 'speedster_300',     priceMin = 300, priceMax = 380 },
    { item = 'runner_prime',      priceMin = 300, priceMax = 380 },
    { item = 'breeze_95s',        priceMin = 300, priceMax = 380 },
    { item = 'breeze_100s',       priceMin = 300, priceMax = 380 },
    { item = 'breeze_90s',        priceMin = 300, priceMax = 380 },
    { item = 'sky_walkers_red',   priceMin = 300, priceMax = 380 },
    { item = 'shadow_yellows',    priceMin = 300, priceMax = 380 },
    { item = 'shadow_yellows_verified',    priceMin = 300, priceMax = 380 },

}

Config.NpcModels = {
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

Config.WorkWithoutTable = {
    Enabled = false,
    Coords  = vector3(-672.2610, -147.2214, 36.9348),
    Heading = 30.0,       -- NPC heading at this location
    NpcModel = nil,      -- nil = uses Config.NPC.Model
    Text    = "Press [E] To Craft Sneakers",
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

-- ############################################################
-- ###        SECOND CRAFTING TABLE — APPAREL / CLOTHING    ###
-- ############################################################
--
-- Entirely separate recipe set with its own location.
-- No store, no NPC selling, no XP bar — crafting only.
-- Add or remove entries exactly like Config.CraftingRecipes above.

Config.CraftingRecipes2 = {
    { name = "Breeze 90s",        id = "breeze_90s_verified",        unlockLevel = 1, img = "image/breeze_90s_verified.png",        requiredItems = { { id = "breeze_90s",        quantity = 1 } }, yield = 1 },
    { name = "Breeze 95s",        id = "breeze_95s_verified",        unlockLevel = 1, img = "image/breeze_95s_verified.png",        requiredItems = { { id = "breeze_95s",        quantity = 1 } }, yield = 1 },
    { name = "Breeze 100s",       id = "breeze_100s_verified",       unlockLevel = 1, img = "image/breeze_100s_verified.png",       requiredItems = { { id = "breeze_100s",       quantity = 1 } }, yield = 1 },
    { name = "Breeze Bangs",      id = "breeze_bangs_verified",      unlockLevel = 1, img = "image/breeze_bangs_verified.png",      requiredItems = { { id = "breeze_bangs",      quantity = 1 } }, yield = 1 },
    { name = "Fastrunner 2000",   id = "fastrunner_2000_verified",   unlockLevel = 1, img = "image/fastrunner_2000_verified.png",   requiredItems = { { id = "fastrunner_2000",   quantity = 1 } }, yield = 1 },
    { name = "Galaxy X",          id = "galaxy_x_verified",          unlockLevel = 1, img = "image/galaxy_x_verified.png",          requiredItems = { { id = "galaxy_x",          quantity = 1 } }, yield = 1 },
    { name = "Runner Prime",      id = "runner_prime_verified",      unlockLevel = 1, img = "image/runner_prime_verified.png",      requiredItems = { { id = "runner_prime",      quantity = 1 } }, yield = 1 },
    { name = "Shadow Yellows",    id = "shadow_yellows_verified",    unlockLevel = 1, img = "image/shadow_yellows_verified.png",    requiredItems = { { id = "shadow_yellows",    quantity = 1 } }, yield = 1 },
    { name = "Sky Flyers",        id = "sky_flyers_verified",        unlockLevel = 1, img = "image/sky_flyers_verified.png",        requiredItems = { { id = "sky_flyers",        quantity = 1 } }, yield = 1 },
    { name = "Sky Gliders Plus",  id = "sky_gliders_plus_verified",  unlockLevel = 1, img = "image/sky_gliders_plus_verified.png",  requiredItems = { { id = "sky_gliders_plus",  quantity = 1 } }, yield = 1 },
    { name = "Sky Gliders",       id = "sky_gliders_verified",       unlockLevel = 1, img = "image/sky_gliders_verified.png",       requiredItems = { { id = "sky_gliders",       quantity = 1 } }, yield = 1 },
    { name = "Sky Pilots",        id = "sky_pilots_verified",        unlockLevel = 1, img = "image/sky_pilots_verified.png",        requiredItems = { { id = "sky_pilots",        quantity = 1 } }, yield = 1 },
    { name = "Sky Walkers Red",   id = "sky_walkers_red_verified",   unlockLevel = 1, img = "image/sky_walkers_red_verified.png",   requiredItems = { { id = "sky_walkers_red",   quantity = 1 } }, yield = 1 },
    { name = "Sky Walkers",       id = "sky_walkers_verified",       unlockLevel = 1, img = "image/sky_walkers_verified.png",       requiredItems = { { id = "sky_walkers",       quantity = 1 } }, yield = 1 },
    { name = "Speedster 300",     id = "speedster_300_verified",     unlockLevel = 1, img = "image/speedster_300_verified.png",     requiredItems = { { id = "speedster_300",     quantity = 1 } }, yield = 1 },
    { name = "Tiger Mediums",     id = "tiger_mediums_verified",     unlockLevel = 1, img = "image/tiger_mediums_verified.png",     requiredItems = { { id = "tiger_mediums",     quantity = 1 } }, yield = 1 },
}

-- Static crafting location for the SECOND crafting table
Config.WorkWithoutTable2 = {
    Enabled = true,
    Coords  = vector3(-672.2610, -147.2214, 36.9348),
    Heading = 30.0,       -- NPC heading at this location
    NpcModel = nil,      -- nil = uses Config.NPC.Model
    Text    = "Press [E] To Craft Apparel",
    JobRequired = {
        Enabled     = false,
        AllowedJobs = { "tailor", "police" }
    }
}

-- ############################################################
-- ###          ox_lib NOTIFICATION LOCALE                  ###
-- ############################################################

-- ox_lib notification settings.
-- 'type' values: 'success', 'error', 'inform'
-- See https://overextended.dev/ox_lib/Modules/Interface/Client/notify
Config.Locale = {
    equipped = { description = 'Shoes equipped.', type = 'success', icon = 'shoe-prints' },
    removed = { description = 'Shoes removed.', type = 'inform', icon = 'shoe-prints' },
    auto_removed = { description = 'Your shoes were removed because you no longer have the item.', type = 'error', icon = 'shoe-prints' },
    invalid_ped = { description = 'This ped model does not support configurable shoes.', type = 'error', icon = 'triangle-exclamation' },
    missing_item = { description = 'You no longer have this shoe item.', type = 'error', icon = 'triangle-exclamation' },

    -- Robbery locale
    rob_no_target = { description = 'No player close enough to rob.', type = 'error', icon = 'user-slash' },
    rob_no_shoes = { description = 'That player is not wearing any shoes to steal.', type = 'error', icon = 'shoe-prints' },
    rob_cooldown = { description = 'You must wait before attempting another robbery.', type = 'error', icon = 'clock' },
    rob_denied = { description = 'The player refused to hand over their shoes.', type = 'error', icon = 'hand' },
    rob_success_robber = { description = 'You stole their shoes!', type = 'success', icon = 'shoe-prints' },
    rob_success_victim = { description = 'Your shoes were stolen!', type = 'error', icon = 'shoe-prints' },
    rob_failed = { description = 'Shoe robbery failed.', type = 'error', icon = 'triangle-exclamation' },
    rob_no_weapon = { description = 'You need a weapon equipped to rob someone.', type = 'error', icon = 'gun' },
    rob_wrong_weapon = { description = 'You can\'t rob someone with that weapon.', type = 'error', icon = 'gun' },
    rob_disabled = { description = 'Shoe robbery is disabled.', type = 'error', icon = 'ban' },
    rob_prompt_title = 'Shoe Robbery',
    rob_prompt_description = 'Someone is pointing a gun at you and demanding your shoes. Do you comply?',
}

-- ############################################################
-- ###          SHOE DRAWABLE MAPPINGS (Equip System)       ###
-- ############################################################
--
-- Map each usable item to the clothing variation it should equip.
--
-- itemName = {
--     drawable = number,
--     texture = number,
--     male = { drawable = number, texture = number },   -- optional override
--     female = { drawable = number, texture = number }, -- optional override
-- }
Config.Shoes = {
    sky_gliders_plus = {
        male = {
            drawable = 1,
            texture = 0
        }
    },

    breeze_bangs = {
        male = {
            drawable = 2,
            texture = 0
        }
    },

    tiger_mediums = {
        male = {
            drawable = 3,
            texture = 0
        }
    },

    galaxy_x = {
        male = {
            drawable = 4,
            texture = 0
        }
    },

    sky_walkers = {
        male = {
            drawable = 5,
            texture = 0
        }
    },

    sky_pilots = {
        male = {
            drawable = 6,
            texture = 0
        }
    },

    sky_flyers = {
        male = {
            drawable = 7,
            texture = 0
        }
    },

    sky_gliders = {
        male = {
            drawable = 8,
            texture = 0
        }
    },

    fastrunner_2000 = {
        male = {
            drawable = 9,
            texture = 0
        }
    },

    speedster_300 = {
        male = {
            drawable = 10,
            texture = 0
        }
    },

    runner_prime = {
        male = {
            drawable = 11,
            texture = 0
        }
    },

    breeze_95s = {
        male = {
            drawable = 12,
            texture = 0
        }
    },

    breeze_100s = {
        male = {
            drawable = 13,
            texture = 0
        }
    },

    breeze_90s = {
        male = {
            drawable = 14,
            texture = 0
        }
    },

    sky_walkers_red = {
        male = {
            drawable = 15,
            texture = 0
        }
    },

    shadow_yellows = {
        male = {
            drawable = 16,
            texture = 0
        }
    }
}