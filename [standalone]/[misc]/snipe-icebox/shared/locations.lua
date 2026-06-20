Config.Zones = {

    -- 1, 2 and 3 are for normal jewellery store
    [1] = {
        type = "inspect", -- inspect chains before buying
        coords = vector3(-537.4160, -1230.3843, 18.4898),
        size = vec3(2.0, 1, 2),
        rotation = 154.8538,
        shopType = "jewellery-store-1" -- this type can be added to chains in chains.lua and watches.lua so it will only show those chains in this store
    },
    [2] = {
        type = "buy", -- if you want a shop to buy items
        coords = vector3(-533.1005, -1228.4138, 18.4847),
        size = vec3(2.0, 1, 2),
        rotation = 154.6754,
        shopType = "jewellery-store-1" -- this type can be added to chains in chains.lua and watches.lua so it will only show those chains in this store
    },
    [3] = {
        type = "craft", -- crafting chain (job required)
        coords = vector3(-540.9404, -1225.5051, 18.4905),
        size = vec3(2.0, 1, 1),
        rotation = 241.3889,
        job = "billionairecustoms", -- job is required!!!!
        shopType = "jewellery-store-1", -- this type can be added to chains in chains.lua and watches.lua so it will only show those chains in this store
    },
    [4] = {
        type = "safe",
        coords = vec3(-528.2894, -1235.8812, 18.1273),
        size = vec3(1, 1, 1),
        rotation = 238.4155,
        job = "billionairecustoms", -- job is required!!!!
        stashsize = 1000,
        stashslots = 100,
        stashName = "icebox_safe_1", -- make sure its unique if you create multiple stashes
        stashLabel = "Icebox Safe",
    },



    -- 4, 5 and 6 are for YBN milos Ice box MLO (https://ybnmilos-mlo-world.tebex.io/package/4978726)
    [5] = {
        type = "inspect", -- inspect chains before buying
        coords = vec3(-1238.14, -801.68, 18.0),
        size = vec3(1, 3.0, 1),
        rotation = 218.25,
        shopType = "jewellery-store-2" -- this type can be added to chains in chains.lua and watches.lua so it will only show those chains in this store
    },
    [6] = {
        type = "craft", -- crafting chain (job required)
        coords = vec3(-1256.24, -825.79, 17.0),
        size = vec3(1, 3.0, 1),
        rotation = 128.25,
        job = "police", -- job is required!!!!
        shopType = "jewellery-store-2" -- this type can be added to chains in chains.lua and watches.lua so it will only show those chains in this store
    },
    [7] = {
        type = "safe",
        coords = vec3(-1258.61, -805.35, 17.0),
        size = vec3(1, 3.0, 1),
        rotation = 308.25,
        job = "police", -- job is required!!!!
        stashsize = 1000,
        stashslots = 100,
        stashName = "icebox_safe_2", -- make sure its unique if you create multiple stashes
        stashLabel = "Icebox Safe",
    },

    -- mask store
    [8] = {
        type = "inspect", -- inspect chains before buying
        coords = vector3(69.74, -1397.3, 29.38),
        size = vec3(1, 1, 1),
        rotation = 0.0,
        shopType = "mask-store" -- this type can be added to chains in chains.lua and watches.lua so it will only show those chains in this store
    },
    [9] = {
        type = "buy", -- if you want a shop to buy items
        coords = vector3(73.37, -1400.23, 29.38),
        size = vec3(1, 1, 1),
        rotation = 0.0,
        shopType = "mask-store" -- this type can be added to chains in chains.lua and watches.lua so it will only show those chains in this store
    },
}
