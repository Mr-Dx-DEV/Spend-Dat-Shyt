Config = Config or {}

Config.ShopPed = {
    model = "a_f_m_beach_01",
    coords = vector3(143.3745, -1721.9862, 29.2918),
    heading = 138.2662,
    blip = {
        sprite = 279,
        color = 8,
        scale = 0.5,
        name = "Lust Toys Shop"
    },
    interaction = {
        useTarget = true,        -- false = use TextUI instead of target
        targetSystem = "ox_target",    -- "auto", "ox_target", "qb-target"
        textUI = {
            key = "E",
            text = "Press [E] to Shop",
            distance = 2.0
        }
    }
}

Config.Categories = {
    {
        id = "female",
        label = "For Her",
        icon = "zap"
    },
    {
        id = "male",
        label = "For Him",
        icon = "heart"
    },
    {
        id = "unisex",
        label = "Unisex",
        icon = "sparkles"
    },
}

Config.Products = {

    [1] = {
        id = "vibrating_stick", -- ✅ ADD THIS
        inventoryName = 'vibrating_stick',
        displayName = 'Vibrating Stick',
        sub = 'Elegant & Powerful',
        price = 100,
        image = 'images/vibrating_stick.png',
        rating = 5,
        description = "A stylish classic with a silky finish and deep vibration strength.",
        type = {'Vibrating'},
        category = "female"
    },

    [2] = {
        id = "pink_stick",
        inventoryName = 'pink_stick',
        displayName = 'Pink Stick',
        sub = 'Smooth & Sculpted',
        price = 135,
        image = 'images/pink_stick.png',
        rating = 4,
        description = "Expertly crafted with a realistic shape.",
        type = {'Non-Vibrating'},
        category = "female"
    },

    [3] = {
        id = "panties_bundle",
        inventoryName = {'vibrating_panties', 'panties_remote'},
        displayName = 'Vibrating Panties + Remote',
        sub = 'Playful Control',
        price = 85,
        image = 'images/vibrating_pantiesbundle.png',
        rating = 3,
        description = "Turn any moment into a secret thrill.",
        type = {'Vibrating', 'Wearable'},
        category = "unisex"
    },

    [4] = {
        id = "floral_toy",
        inventoryName = 'floral_toy',
        displayName = 'Floral Toy',
        sub = 'Gentle & Rhythmic',
        price = 85,
        image = 'images/floral_toy.png',
        rating = 5,
        description = "The viral favorite for a reason.",
        type = {'Vibrating', 'Wearable'},
        category = "unisex" -- ⚠️ you had "vibrators" which doesn't exist
    },

    [5] = {
        id = "pocket_toy",
        inventoryName = 'pocket_toy',
        displayName = 'Pocket Toy',
        sub = 'All you need',
        price = 85,
        image = 'images/pocket_toy.png',
        rating = 5,
        description = "The viral favorite for a reason.",
        type = {'Vibrating', 'Wearable'},
        category = "male"
    },

    [6] = {
        id = "teddybear",
        inventoryName = 'teddybear',
        displayName = 'Teddy Bear',
        sub = 'Your Favorite Buddy',
        price = 75,
        image = 'images/teddybear.png',
        rating = 4,
        description = "Small but mighty.",
        type = {'Non-Vibrating'},
        category = "male"
    },

}