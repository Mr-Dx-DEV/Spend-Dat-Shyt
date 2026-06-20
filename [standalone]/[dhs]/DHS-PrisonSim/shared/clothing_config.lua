ClothingConfig = {}

-- Read This For More Info https://docs.fivem.net/natives/?_0x262B14F48D29DE80
ClothingConfig.ClothingSettings = {
    removeClothingAnimations = {
        -- Top
        [11] = {
            anim = "michael_tux_fidget",
            dict = "missmic4",
        },
        [4] = {
            anim = "out_of_breath",
            dict = "re@construction",
        },
        -- Gloves
        [3] = {
            anim = "cs_nigel_dual-10",
            dict = "nmt_3_rcm-10",
        },
        -- Shoes
        [6] = {
            anim = "pickup_low",
            dict = "random@domestic",
        },
        -- Neck
        [7] = {
            anim = "try_tie_positive_a",
            dict = "clothingtie",
        },
        -- Vest
        [9] = {
            anim = "try_tie_negative_a",
            dict = "clothingtie",
        },
        -- Bag
        [5] = {
            anim = "intro",
            dict = "anim@heists@ornate_bank@grab_cash",
        },
        -- Mask
        [10] = {
            anim = "put_on_mask",
            dict = "mp_masks@standard_car@ds@",
        },
    },

    shower = {
        male = {
            clothing = {
                { componentid = 11, drawableid = 15, textureid = 0, paletteid = 0, waitTime = 0 }, -- Jacket
                { componentid = 3,  drawableid = 15, textureid = 0, paletteid = 0, waitTime = 1000 }, -- Upper / Arms
                { componentid = 4,  drawableid = 173, textureid = 0, paletteid = 0, waitTime = 1000 }, -- Lower
                { componentid = 5,  drawableid = 0,  textureid = 0, paletteid = 0, waitTime = 0 },    -- Bags & Parachutes
                { componentid = 6,  drawableid = 5, textureid = 0, paletteid = 0, waitTime = 0 },    -- Feet
                { componentid = 8,  drawableid = 15, textureid = 0, paletteid = 0, waitTime = 0 },    -- Undershirt
                { componentid = 9,  drawableid = 0,  textureid = 0, paletteid = 0, waitTime = 0 },    -- Body Armor
                { componentid = 10, drawableid = 0,  textureid = 0, paletteid = 0, waitTime = 0 },    -- Decals
            },
            props = {
                { componentid = 0, drawableid = -1, textureid = 0, paletteid = 0, waitTime = 0 }, -- Hat
            }
        },
        female = {
            clothing = {
                { componentid = 11, drawableid = 1046, textureid = 8, paletteid = 0, waitTime = 0 }, -- Jacket
                { componentid = 3,  drawableid = 67, textureid = 0, paletteid = 0, waitTime = 1000 }, -- Upper / Arms
                { componentid = 4,  drawableid = 408, textureid = 0, paletteid = 0, waitTime = 1000 }, -- Lower
                { componentid = 5,  drawableid = 0,  textureid = 0, paletteid = 0, waitTime = 0 },    -- Bags & Parachutes
                { componentid = 6,  drawableid = 109, textureid = 0, paletteid = 0, waitTime = 0 },    -- Feet
                { componentid = 8,  drawableid = 756, textureid = 0, paletteid = 0, waitTime = 0 },    -- Undershirt
                { componentid = 9,  drawableid = 0,  textureid = 0, paletteid = 0, waitTime = 0 },    -- Body Armor
                { componentid = 10, drawableid = 0,  textureid = 0, paletteid = 0, waitTime = 0 },    -- Decals
            },
            props = {
                { componentid = 0, drawableid = -1, textureid = 0, paletteid = 0, waitTime = 0 }, -- Hat
            }
        }
    },

    min = {
        male = {
            clothing = {
                { componentid = 11, drawableid = 795, textureid = 1,  paletteid = 0, waitTime = 0 }, -- Jacket
                { componentid = 3,  drawableid = 4,  textureid = 0,  paletteid = 0, waitTime = 1000 }, -- Upper / Arms
                { componentid = 4,  drawableid = 3, textureid = 4,  paletteid = 0, waitTime = 1000 }, -- Lower
                { componentid = 6,  drawableid = 117, textureid = 0, paletteid = 0, waitTime = 0 },    -- Feet
                { componentid = 8,  drawableid = 15, textureid = 0, paletteid = 0, waitTime = 0 }, -- Undershirt
                { componentid = 9,  drawableid = 0,  textureid = 0, paletteid = 0, waitTime = 0 }, -- Body Armor
                { componentid = 10, drawableid = 0,  textureid = 0, paletteid = 0, waitTime = 0 }, -- Decals
            },
            props = {
                { componentid = 0, drawableid = -1, textureid = 0, paletteid = 0, waitTime = 0 }, -- Hat
            }
        },
        female = {
            clothing = {
                { componentid = 11, drawableid = 819, textureid = 0,  paletteid = 0, waitTime = 0 }, -- Jacket
                { componentid = 3,  drawableid = 67,  textureid = 0,  paletteid = 0, waitTime = 1000 }, -- Upper / Arms
                { componentid = 4,  drawableid = 415, textureid = 0,  paletteid = 0, waitTime = 1000 }, -- Lower
                { componentid = 6,  drawableid = 78, textureid = 14, paletteid = 0, waitTime = 0 },    -- Feet
                { componentid = 8,  drawableid = 16, textureid = 0, paletteid = 0, waitTime = 0 }, -- Undershirt
                { componentid = 9,  drawableid = 0,  textureid = 0, paletteid = 0, waitTime = 0 }, -- Body Armor
                { componentid = 10, drawableid = 0,  textureid = 0, paletteid = 0, waitTime = 0 }, -- Decals
            },
            props = {
                { componentid = 0, drawableid = -1, textureid = 0, paletteid = 0, waitTime = 0 }, -- Hat
            }
        }
    },

    med = {
        male = {
            clothing = {
                { componentid = 11, drawableid = 795, textureid = 1, paletteid = 0, waitTime = 0 }, -- Jacket
                { componentid = 3,  drawableid = 4,  textureid = 0, paletteid = 0, waitTime = 1000 }, -- Upper / Arms
                { componentid = 4,  drawableid = 305, textureid = 1, paletteid = 0, waitTime = 1000 }, -- Lower
                { componentid = 6,  drawableid = 117, textureid = 0, paletteid = 0, waitTime = 0 },    -- Feet
                { componentid = 8,  drawableid = -1, textureid = 0, paletteid = 0, waitTime = 0 }, -- Undershirt
                { componentid = 9,  drawableid = 0,  textureid = 0, paletteid = 0, waitTime = 0 }, -- Body Armor
                { componentid = 10, drawableid = 0,  textureid = 0, paletteid = 0, waitTime = 0 }, -- Decals
            },
            props = {
                { componentid = 0, drawableid = -1, textureid = 0, paletteid = 0, waitTime = 0 }, -- Hat
            }
        },
        female = {
            clothing = {
                { componentid = 11, drawableid = 819, textureid = 0,  paletteid = 0, waitTime = 0 }, -- Jacket
                { componentid = 3,  drawableid = 67,  textureid = 0,  paletteid = 0, waitTime = 1000 }, -- Upper / Arms
                { componentid = 4,  drawableid = 415, textureid = 0,  paletteid = 0, waitTime = 1000 }, -- Lower
                { componentid = 6,  drawableid = 78, textureid = 14, paletteid = 0, waitTime = 0 },    -- Feet
                { componentid = 8,  drawableid = 16, textureid = 0, paletteid = 0, waitTime = 0 }, -- Undershirt
                { componentid = 9,  drawableid = 0,  textureid = 0, paletteid = 0, waitTime = 0 }, -- Body Armor
                { componentid = 10, drawableid = 0,  textureid = 0, paletteid = 0, waitTime = 0 }, -- Decals
            },
            props = {
                { componentid = 0, drawableid = -1, textureid = 0, paletteid = 0, waitTime = 0 }, -- Hat
            }
        }
    },

    max = {
        male = {
            clothing = {
                { componentid = 11, drawableid = 796, textureid = 0, paletteid = 0, waitTime = 0 }, -- Jacket
                { componentid = 3,  drawableid = 0,  textureid = 0, paletteid = 0, waitTime = 1000 }, -- Upper / Arms
                { componentid = 4,  drawableid = 524, textureid = 0, paletteid = 0, waitTime = 1000 }, -- Lower
                { componentid = 6,  drawableid = 247, textureid = 0, paletteid = 0, waitTime = 0 },    -- Feet
                { componentid = 8,  drawableid = 15, textureid = 0, paletteid = 0, waitTime = 0 }, -- Undershirt
                { componentid = 9,  drawableid = 0,  textureid = 0, paletteid = 0, waitTime = 0 }, -- Body Armor
                { componentid = 10, drawableid = 0,  textureid = 0, paletteid = 0, waitTime = 0 }, -- Decals
            },
            props = {
                { componentid = 0, drawableid = -1, textureid = 0, paletteid = 0, waitTime = 0 }, -- Hat
            }
        },
        female = {
            clothing = {
                { componentid = 11, drawableid = 819, textureid = 0,  paletteid = 0, waitTime = 0 }, -- Jacket
                { componentid = 3,  drawableid = 67,  textureid = 0,  paletteid = 0, waitTime = 1000 }, -- Upper / Arms
                { componentid = 4,  drawableid = 415, textureid = 0,  paletteid = 0, waitTime = 1000 }, -- Lower
                { componentid = 6,  drawableid = 78, textureid = 14, paletteid = 0, waitTime = 0 },    -- Feet
                { componentid = 8,  drawableid = 16, textureid = 0, paletteid = 0, waitTime = 0 }, -- Undershirt
                { componentid = 9,  drawableid = 0,  textureid = 0, paletteid = 0, waitTime = 0 }, -- Body Armor
                { componentid = 10, drawableid = 0,  textureid = 0, paletteid = 0, waitTime = 0 }, -- Decals
            },
            props = {
                { componentid = 0, drawableid = -1, textureid = 0, paletteid = 0, waitTime = 0 }, -- Hat
            }
        }
    },
}