--- ######################### ---
--- ## DISCORD.GG/CODEWAVE ## ---
--- ######################### ---


--- ### PERFUMS & COLOGNE ### ---

Config = {}
Config.Framework = 'QBCore' -- 'ESX' or 'QBCore' (case sensitive)
Config.InteractionType = '3dtext' -- ox_target | 3dtext
Config.UseOxTargetForNpc = true -- Set to true to enable ox_target, false to use key press interaction
Config.TimeToCraft = 8000
Config.DebugMode = false  -- Set to true to enable debug messages

Config.CologneBoxPropName = "prop_shopping_bags01" -- ### YOU MAY NEED TO CHANGE THIS PROP, HEAD TO PLEB MASTER & SEARCH FOR BAGS AND USE ANOTHER PROP ###

-- ONLY FOR NPC SALES.
Config.MinItemsToSell = 1 
Config.MaxItemsToSell = 3
-- Change the commands if you wish
Config.StopSellingCommand = 'stopsellingsprays'
Config.StartSellingCommand = 'sellsprays'


Config.OnlyFemales = false  -- Enable or disable the restriction to only allow male peds ((YOU CAN JUST ADD MALE PEDS IF YOU WANT, IT DOESN'T HAVE TO BE FEMALE))
Config.MalePedModels = {
    GetHashKey("mp_f_freemode_01"),  -- FEMALE freemode character
    GetHashKey("some_other_male_ped_model")  -- Add other female ped models here
}


Config.Jobs = {
    Enabled = true,
    AllowedJobs = { "mechanic", "doctor" } -- YOU MUST ADD YOUR OWN JOB ROLES FOR THIS (EG Cologne_seller or whatever you want it to be)
}


Config.NPC = {
    Model = "a_f_m_soucent_02", -- Change to your desired NPC model
    Coords = vector3(-829.6940, -1087.2389, 11.1341), -- Change to your desired NPC spawn location
    Heading = 299.4346, -- Adjust the heading as needed
    BlipEnabled = true,  -- New option to enable/disable blip
    BlipSprite = 389,        -- Example blip icon, see https://wiki.rage.mp/index.php?title=Blips for blip IDs
    BlipScale = 0.5,
    BlipColour = 3,
    BlipName = "Perfumes & Colognes"
}


-- Add anything you want here (For example if you want a new required item you can add it here for them to purchase!)
Config.Items = {
    { name = "Glass Bottle", id = "glass_bottle", img = "image/glass_bottle.png", price = 100 }, -- You don't really need too touch anything apart from PRICE
    { name = "Female Infused Scents", id = "female_scents", img = "image/female_scents.png", price = 200 },
    { name = "Male Infused Scents", id = "male_scents", img = "image/male_scents.png", price = 300 },
    { name = "Sprays Client Phone", id = "sprays_phone", img = "image/sprays_phone.png", price = 1300 },
    { name = "Perfume & Cologne Table", id = "cologne_crafting_table", img = "image/cologne_crafting_table.png", price = 100 }
}



Config.CraftingRecipes = {
    { name = "Elegant Black Cherry", id = "elegant_black_cherry", img = "image/elegant_black_cherry.png", requiredItems = { { id = "glass_bottle", quantity = 1 }, { id = "female_scents", quantity = 3 } }, yield = 2 },
    { name = "Miss Rose", id = "miss_rose", img = "image/miss_rose.png", requiredItems = { { id = "glass_bottle", quantity = 1 }, { id = "female_scents", quantity = 3 } }, yield = 1 },
    { name = "Blooming Crystal", id = "blooming_crystal", img = "image/blooming_crystal.png", requiredItems = { { id = "glass_bottle", quantity = 1 }, { id = "female_scents", quantity = 3 } }, yield = 2 },
    { name = "Rose Bloom", id = "rose_bloom", img = "image/rose_bloom.png", requiredItems = { { id = "glass_bottle", quantity = 1 }, { id = "female_scents", quantity = 3 } }, yield = 1 },
    { name = "Mens Be Simple", id = "mens_be_simple", img = "image/mens_be_simple.png", requiredItems = { { id = "glass_bottle", quantity = 1 }, { id = "male_scents", quantity = 3 } }, yield = 3 },
    { name = "Mens Aqua Infused", id = "mens_aqua_infused", img = "image/mens_aqua_infused.png", requiredItems = { { id = "glass_bottle", quantity = 1 }, { id = "male_scents", quantity = 3 } }, yield = 2 },
    { name = "Mens Demon Red", id = "mens_demon_red", img = "image/mens_demon_red.png", requiredItems = { { id = "glass_bottle", quantity = 1 }, { id = "male_scents", quantity = 3 } }, yield = 1 },
    { name = "Mens Ocean Blue", id = "mens_ocean_blue", img = "image/mens_ocean_blue.png", requiredItems = { { id = "glass_bottle", quantity = 1 }, { id = "male_scents", quantity = 3 } }, yield = 2 }
}

Config.CoolDownOnScents = 60000 -- 60 seconds - This is the it puts in place for using the item, so users can't spam use the items.

Config.ScentsUsage = {
    ["elegant_black_cherry"] = {
        label = "Elegant Black Cherry",
        effects = {
            health = { enabled = true, amount = 20 }, -- Small health boost
            armour = { enabled = true, amount = 15 }, -- Small armour boost
            speed = { enabled = true, multiplier = 2.2, duration = 15 } -- Small speed boost for 15 seconds
        }
    },
    ["miss_rose"] = {
        label = "Miss Rose",
        effects = {
            health = { enabled = false, amount = 0 },
            armour = { enabled = true, amount = 30 }, -- Moderate armour boost
            speed = { enabled = false, multiplier = 0, duration = 0 }
        }
    },
    ["blooming_crystal"] = {
        label = "Blooming Crystal",
        effects = {
            health = { enabled = true, amount = 50 }, -- Large health boost
            armour = { enabled = false, amount = 0 },
            speed = { enabled = true, multiplier = 1.5, duration = 10 } -- Strong speed boost for 10 seconds
        }
    },
    ["rose_bloom"] = {
        label = "Rose Bloom",
        effects = {
            health = { enabled = false, amount = 0 },
            armour = { enabled = true, amount = 50 }, -- Large armour boost
            speed = { enabled = true, multiplier = 1.3, duration = 7 } -- Moderate speed boost for 7 seconds
        }
    },
    ["mens_be_simple"] = {
        label = "Men's Be Simple",
        effects = {
            health = { enabled = true, amount = 10 }, -- Small health boost
            armour = { enabled = false, amount = 0 },
            speed = { enabled = false, multiplier = 0, duration = 0 }
        }
    },
    ["mens_aqua_infused"] = {
        label = "Men's Aqua Infused",
        effects = {
            health = { enabled = false, amount = 0 },
            armour = { enabled = true, amount = 20 }, -- Small armour boost
            speed = { enabled = true, multiplier = 1.1, duration = 4 } -- Minor speed boost for 4 seconds
        }
    },
    ["mens_demon_red"] = {
        label = "Men's Demon Red",
        effects = {
            health = { enabled = true, amount = 30 }, -- Moderate health boost
            armour = { enabled = false, amount = 0 },
            speed = { enabled = true, multiplier = 1.4, duration = 8 } -- Strong speed boost for 8 seconds
        }
    },
    ["mens_ocean_blue"] = {
        label = "Men's Ocean Blue",
        effects = {
            health = { enabled = false, amount = 0 },
            armour = { enabled = true, amount = 40 }, -- Moderate armour boost
            speed = { enabled = true, multiplier = 1.3, duration = 6 } -- Moderate speed boost for 6 seconds
        }
    }
}




Config.PlayMusicWhileUIIsOpen = false --- True = music plays, False = music doesn't. (YOU CAN CHANGE MUSIC IN SOUNDS FILE)
Config.MusicVolume = 0.05 --- Music volume in the menu, Only applies if above is set to True


Config.CologneTableItem = 'cologne_crafting_table' --- The table item
Config.PropItemName = 'prop_table_03' -- You can change this if you want (to basically any prop, make it make sense though!)


-- This is for NPC sales (Ensure to change prices according to your servers economy.)
Config.RequiredItems = {
    { item = 'elegant_black_cherry', priceMin = 180, priceMax = 220 },
    { item = 'miss_rose', priceMin = 180, priceMax = 220 },
    { item = 'blooming_crystal', priceMin = 180, priceMax = 220 },
    { item = 'rose_bloom', priceMin = 180, priceMax = 220 },
    { item = 'mens_be_simple', priceMin = 180, priceMax = 220 },
    { item = 'mens_aqua_infused', priceMin = 180, priceMax = 220 },
    { item = 'mens_demon_red', priceMin = 180, priceMax = 220 },    
    { item = 'mens_ocean_blue', priceMin = 180, priceMax = 220 }
}


--- ### DISCORD.GG/CODEWAVE ### ---
