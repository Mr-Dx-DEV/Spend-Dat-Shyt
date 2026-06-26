--- ######################### ---
--- ## DISCORD.GG/CODEWAVE ## ---
--- ######################### ---


--- ### nailS & BUNDLES ### ---

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
Config.StopSellingCommand = 'stopsellingnails'
Config.StartSellingCommand = 'sellnails'

-- NEW : DISABLE IF YOU HAVE FALSE/POSITIVIE CHEAT DETECTION ISSUES.
Config.DropPlayer = true -- true = kick on cheat detection, false = just log and deny

Config.FemaleModels = {
  "mp_f_freemode_01",
  "a_f_y_beach_01",
}
Config.OnlyFemales = false


Config.NPC = {
    Model = "a_f_m_soucentmc_01", -- Change to your desired NPC model
    Coords = vector3(215.1895, -1512.2305, 29.3610), -- Change to your desired NPC spawn location
    Heading = 227.9358, -- Adjust the heading as needed
    BlipEnabled = false,  -- New option to enable/disable blip
    BlipSprite = 621,        -- Example blip icon, see https://wiki.rage.mp/index.php?title=Blips for blip IDs
    BlipScale = 1.0,
    BlipColour = 8,
    BlipName = "Nails & Sets"
}

Config.Items = {
    { name = "Acrylic Liquid", id = "acrylic-liquid", img = "image/acrylic-liquid.png", price = 100 }, -- You don't really need too touch anything apart from PRICE
    { name = "Acrylic Powder", id = "acrylic-powder", img = "image/acrylic-powder.png", price = 200 },
    { name = "Acrylic Nails", id = "acrylic-nails", img = "image/acrylic-nails.png", price = 300 },
    { name = "Nail Work Phone", id = "nailphone", img = "image/nailphone.png", price = 1000 },
    { name = "Nail Table", id = "nailtable", img = "image/acrylic-table.png", price = 1200 }
}



-- Quantity is the amount of that item required to craft.
Config.CraftingRecipes = {
    { name = "Set Of Coffin Nails", id = "cfn-nails", img = "image/coffin-nail.png", requiredItems = { { id = "acrylic-liquid", quantity = 2 }, { id = "acrylic-nails", quantity = 2 }, { id = "acrylic-powder", quantity = 1 } } },
    { name = "Set Of Stiletto Nails", id = "sti-nails", img = "image/stiletto-nail.png", requiredItems = { { id = "acrylic-liquid", quantity = 3 }, { id = "acrylic-nails", quantity = 2 }, { id = "acrylic-nails", quantity = 1 } } },
    { name = "Set Of Almond Nails", id = "alm-nails", img = "image/almond-nail.png", requiredItems = { { id = "acrylic-liquid", quantity = 2 }, { id = "acrylic-nails", quantity = 2 }, { id = "acrylic-powder", quantity = 1 } } },
    { name = "Set Of Lipstick Nails", id = "lip-nails", img = "image/lipstick-nail.png", requiredItems = { { id = "acrylic-liquid", quantity = 2 }, { id = "acrylic-nails", quantity = 2 }, { id = "acrylic-powder", quantity = 1 } } },
    { name = "Set Of Ballerina Nails", id = "bal-nails", img = "image/ballerina-nail.png", requiredItems = { { id = "acrylic-liquid", quantity = 2 }, { id = "acrylic-nails", quantity = 2 }, { id = "acrylic-powder", quantity = 1 } } },
    { name = "Set Of Square Nails", id = "squ-nails", img = "image/square-nail.png", requiredItems = { { id = "acrylic-liquid", quantity = 2 }, { id = "acrylic-nails", quantity = 2 }, { id = "acrylic-powder", quantity = 1 } } },
    { name = "Set Of Flare Nails", id = "fla-nails", img = "image/flare-nail.png", requiredItems = { { id = "acrylic-liquid", quantity = 2 }, { id = "acrylic-nails", quantity = 2 }, { id = "acrylic-powder", quantity = 1 } } }
}

Config.PlayMusicWhileUIIsOpen = false --- True = music plays, False = music doesn't. (YOU CAN CHANGE MUSIC IN SOUNDS FILE)
Config.MusicVolume = 0.05 --- Music volume in the menu, Only applies if above is set to True

Config.nailTableItem = 'nailtable' --- The table item
Config.PropItemName = 'prop_ven_market_table1' -- You can change this if you want (to basically any prop, make it make sense though!)

Config.RequiredItems = {
    { item = 'cfn-nails', priceMin = 300, priceMax = 500 },
    { item = 'sti-nails', priceMin = 300, priceMax = 500 },
    { item = 'alm-nails', priceMin = 300, priceMax = 500 },
    { item = 'lip-nails', priceMin = 300, priceMax = 500 },
    { item = 'bal-nails', priceMin = 300, priceMax = 500 },
    { item = 'squ-nails', priceMin = 300, priceMax = 500 },
    { item = 'fla-nails', priceMin = 300, priceMax = 500 }
}

Config.NpcModelsSelling = {
    'a_f_m_beach_01', 
    'a_f_m_fatbla_01', 
    'a_f_m_fatcult_01', 
    'a_f_m_fatwhite_01', 
    'a_f_m_ktown_01', 
    'a_f_m_prolhost_01', 
    'a_f_m_salton_01'
}