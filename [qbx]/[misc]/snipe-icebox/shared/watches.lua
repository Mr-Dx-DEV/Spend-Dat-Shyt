Config.Watches = {
    ["clothing_watch"] = { -- item name
        label = "Clothing Watch", -- item label that will show on the context menu
        category = "gang",
        drawable = true, -- if the chain is clothing item
        itemPrice = 4999, 
        shopType = "jewellery-store-1", -- shoptype is taken from locations.lua (if no shoptype is defined, it will show the item in every shop)
        -- propId = 7, -- prop id for watch (by default its 6 but you can set the value here to override)
        clothing = {
            ["mp_m_freemode_01"] = {drawable = 3, texture = 0}, -- texture and drawable if its a male ped model
            ["mp_f_freemode_01"] = {drawable = 3, texture = 1}, -- texture and drawable if its a female ped model
        },
        pedBone = 18905, -- bone on which the watch will be attached (by default its 18905) ( if you use bracelet, find the bone id for bracelet and set it here) https://wiki.rage.mp/index.php?title=Bones
        offsets = { -- offsets for different infused items particle effects
            ["diamond"] = vec3(-0.01, -0.06, -0.05), -- offset for diamond
            ["ruby"] = vec3(-0.02, -0.02, -0.02),   -- offset for ruby
        },
        craftItems = {
            ["diamond"] = {
                label = "Diamond",
                amount = 1,
            },
            ["ruby"] = {
                label = "Ruby",
                amount = 1,
            },
        }
    },
}