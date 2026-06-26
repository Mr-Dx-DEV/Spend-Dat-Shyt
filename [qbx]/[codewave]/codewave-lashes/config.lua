--- ######################### ---
--- ## DISCORD.GG/CODEWAVE ## ---
--- ######################### ---


--- ### CODEWAVE LASHES V1 ### ---

Config = {}
Config.Framework = 'QBCore' -- 'ESX' or 'QBCore' (case sensitive)
Config.InteractionType = 'ox_target' -- ox_target | 3dtext
Config.UseOxTargetForNpc = true -- Set to true to enable ox_target, false to use key press interaction
Config.TimeToCraft = 8000
Config.DebugMode = true  -- Set to true to enable debug messages

-- ONLY FOR NPC SALES.
Config.MinItemsToSell = 1 
Config.MaxItemsToSell = 3
-- Change the commands if you wish
Config.StopSellingCommand = 'stopsellinglashes'
Config.StartSellingCommand = 'selllashes'


Config.OnlyFemales = true  -- Enable or disable the restriction to only allow male peds
Config.MalePedModels = {
    GetHashKey("mp_f_freemode_01"),  -- Male freemode character
    GetHashKey("some_other_female_ped_model")  -- Add other peds here if you want
}

Config.NPC = {
    Model = "s_f_m_fembarber", -- Change to your desired NPC model
    Coords = vector3(212.2207, -1523.3300, 28.3610), -- Change to your desired NPC spawn location # !!!! DECREASE THE LAST VALUE BY 1 IF FLOATING !!!! #
    Heading = 315.6622, -- Adjust the heading as needed
    BlipSprite = 621,        -- Example blip icon, see https://wiki.rage.mp/index.php?title=Blips for blip IDs
    BlipScale = 0.5,
    BlipColour = 8,
    BlipName = "Eyelashes & Strips"
}


-- Add anything you want here (For example if you want a new required item you can add it here for them to purchase!)
Config.Items = {
    { name = "Empty Lash Box", id = "empty_lash_box", img = "image/empty_lash_box.png", price = 100 }, -- You don't really need too touch anything apart from PRICE
    { name = "Eyelash Strips", id = "strips", img = "image/strips.png", price = 200 },
    { name = "Eyelash Glue", id = "eyelash_glue", img = "image/eyelash_glue.png", price = 300 },
    { name = "Lashes Client Phone", id = "lashes_phone", img = "image/lashes_phone.png", price = 300 },
    { name = "Lashes Work Table", id = "lashes_table", img = "image/lashes_table.png", price = 300 },

}



-- YOU CAN ADD AS MANY lashes AS YOU WANT, LITERALLY UNLIMITED! YOU CAN MAKE DIFFERENT COMBINATIONS TOO!
-- Quantity is the amount of that item required to craft.
Config.CraftingRecipes = {
    { name = "Ellipse lashes", id = "ellipse_lashes", img = "image/ellipse_lashes.png", requiredItems = { { id = "empty_lash_box", quantity = 1 }, { id = "strips", quantity = 3 }, { id = "eyelash_glue", quantity = 1 } } },
    { name = "Faux mink lashes", id = "faux_mink_lashes", img = "image/faux_mink_lashes.png", requiredItems = { { id = "empty_lash_box", quantity = 1 }, { id = "strips", quantity = 3 }, { id = "eyelash_glue", quantity = 1 } } },
    { name = "Mink Lashes", id = "mink_lashes", img = "image/mink_lashes.png", requiredItems = { { id = "empty_lash_box", quantity = 1 }, { id = "strips", quantity = 3 }, { id = "eyelash_glue", quantity = 1 } } },
    { name = "Silk Lashes", id = "silk_lashes", img = "image/silk_lashes.png", requiredItems = { { id = "empty_lash_box", quantity = 1 }, { id = "strips", quantity = 3 }, { id = "eyelash_glue", quantity = 1 } } },
    { name = "Synthetic lashes", id = "synthetic_lashes", img = "image/synthetic_lashes.png", requiredItems = { { id = "empty_lash_box", quantity = 1 }, { id = "strips", quantity = 3 }, { id = "eyelash_glue", quantity = 1 } } },
    { name = "Volume lashes", id = "volume_lashes", img = "image/volume_lashes.png", requiredItems = { { id = "empty_lash_box", quantity = 1 }, { id = "strips", quantity = 3 }, { id = "eyelash_glue", quantity = 1 } } }

}

Config.PlayMusicWhileUIIsOpen = false --- True = music plays, False = music doesn't. (YOU CAN CHANGE MUSIC IN SOUNDS FILE)
Config.MusicVolume = 0.05 --- Music volume in the menu, Only applies if above is set to True

Config.lasheTableItem = 'lashes_table' --- The table item
Config.PropItemName = 'prop_ven_market_table1' -- You can change this if you want (to basically any prop, make it make sense though!)

Config.RequiredItems = {
    { item = 'ellipse_lashes', priceMin = 500, priceMax = 700 },
    { item = 'faux_mink_lashes', priceMin = 500, priceMax = 700 },
    { item = 'mink_lashes', priceMin = 500, priceMax = 700 },
    { item = 'silk_lashes', priceMin = 500, priceMax = 700 },
    { item = 'synthetic_lashes', priceMin = 500, priceMax = 700 },
    { item = 'volume_lashes', priceMin = 500, priceMax = 700 }
}

