UniqersMarriage = UniqersMarriage or {}

local function customclothes(manwear, womenwear, manringwear, womenringwear, unwearring)
if manwear then
-- your custom clothes script load clothes trigger like this TriggerEvent('qb-clothing:client:loadOutfit', UniqersMarriage.QBCoreManOutfit)
end
if womenwear then
-- your custom clothes script load clothes trigger like this TriggerEvent('qb-clothing:client:loadOutfit', UniqersMarriage.QBCoreGirlOutfit)
end
if manringwear then
-- your custom clothes script load clothes trigger like this TriggerEvent('qb-clothing:client:loadOutfit', UniqersMarriage.QBCoreManRing)
end
if womenringwear then
-- your custom clothes script load clothes trigger like this TriggerEvent('qb-clothing:client:loadOutfit', UniqersMarriage.QBCoreGirlRing)
end
if unwearring then
-- your custom clothes script load clothes trigger like this TriggerEvent('qb-clothing:client:loadOutfit', UniqersMarriage.QBCoreRingOff)
end
end 

-- QBCore Ring Data
UniqersMarriage.QBCoreRing = {
    ManRing = {
        outfitData = {
            ['accessory'] = {
                item = 1,
                texture = 0
            },
        }
    },
    GirlRing = {
        outfitData = {
            ['accessory'] = {
                item = 1,
                texture = 0
            },
        }
    },
    RingOff = {
        outfitData = {
            ['accessory'] = {
                item = 0,
                texture = 0
            },
        }
    }
}

-- QBCore Outfit Data
UniqersMarriage.QBCoreOutfit = {
    ManOutfit = {
        outfitData = {
            ['arms'] = { item = 1, texture = 0 },
            ['t-shirt'] = { item = 3, texture = 0 },
            ['torso2'] = { item = 4, texture = 0 },
            ['pants'] = { item = 24, texture = 0 },
            ['shoes'] = { item = 10, texture = 0 },
            ['mask'] = { item = 0, texture = 0 },
            ['hat'] = { item = -1, texture = 0 },
            ['glass'] = { item = 0, texture = 0 },
            ['bag'] = { item = 0, texture = 0 },
            ['decals'] = { item = 0, texture = 0 },
            ['accessory'] = { item = 0, texture = 0 },
            ['vest'] = { item = 0, texture = 0 }
        }
    },
    GirlOutfit = {
        outfitData = {
            ['arms'] = { item = 12, texture = 0 },
            ['t-shirt'] = { item = 2, texture = 0 },
            ['torso2'] = { item = 26, texture = 0 },
            ['pants'] = { item = 36, texture = 0 },
            ['shoes'] = { item = 15, texture = 14 },
            ['mask'] = { item = 0, texture = 0 },
            ['hat'] = { item = -1, texture = 0 },
            ['glass'] = { item = 0, texture = 0 },
            ['bag'] = { item = 0, texture = 0 },
            ['decals'] = { item = 0, texture = 0 },
            ['accessory'] = { item = 0, texture = 0 },
            ['vest'] = { item = 0, texture = 0 }
        }
    }
}

-- ESX Ring and Clothes Data
UniqersMarriage.ESX = {
    RingClothes = {
        male = { ['chain_1'] = 1 },
        female = { ['chain_1'] = 1 }
    },
    RingOff = { ['chain_1'] = 0 },
    Clothes = {
        male = {
            ['arms_1'] = 1,   ['tshirt_1'] = 3,
            ['torso_1']  = 4,  ['torso_2']  = 0, 
            ['pants_1']  = 28,
            ['pants_2']  = 0, ['chain_1']  = 0,
            ['shoes_1'] = 10, ['shoes_2'] = 0,
            ['mask_1'] = 0, ['hat_1']  = -1,
            ['glass_1'] = 0, ['bag_1'] = 0,
            ['decals_1'] = 0, ['accessory_1'] = 0,
            ['vest_1'] = 0
        },
        female = {
            ['arms_1'] = 12, ['arms_2'] = 0,
            ['tshirt_1'] = 2,
            ['torso_1'] = 26, ['torso_2'] = 0,
            ['pants_1'] = 36, ['pants_2'] = 0,
            ['shoes_1'] = 15, ['shoes_2'] = 14,
            ['mask_1'] = 0, ['hat_1'] = -1,
            ['glass_1'] = 0, ['bag_1'] = 0,
            ['decals_1'] = 0, ['accessory_1'] = 0,
            ['vest_1'] = 0, ['chain_1'] = 0
        }
    }
}

-- FivemAppearance and İllenum Apperance Data
UniqersMarriage.FivemAppearance = {
    RingUse = {
        ManClothes = {
            ["components"] = {
                { ["drawable"] = 1, ["texture"] = 0, ["component_id"] = 7 }
            }
        },
        GirlClothes = {
            ["components"] = {
                { ["drawable"] = 1, ["texture"] = 0, ["component_id"] = 7 }
            }
        },
        RingOff = {
            ["components"] = {
                { ["drawable"] = 0, ["texture"] = 0, ["component_id"] = 7 }
            }
        }
    },
    Outfit = {
        ManClothes = {
            ["components"] = {
                { ["drawable"] = 0, ["texture"] = 0, ["component_id"] = 3 },
                { ["drawable"] = 4, ["texture"] = 0, ["component_id"] = 4 },
                { ["drawable"] = 10, ["texture"] = 0, ["component_id"] = 6 },
                { ["drawable"] = 3, ["texture"] = 0, ["component_id"] = 8 },
                { ["drawable"] = 0, ["texture"] = 0, ["component_id"] = 9 },
                { ["drawable"] = 10, ["texture"] = 0, ["component_id"] = 11 }
            }
        },
        GirlClothes = {
            ["components"] = {
                { ["drawable"] = 0, ["texture"] = 0, ["component_id"] = 3 },
                { ["drawable"] = 4, ["texture"] = 0, ["component_id"] = 4 },
                { ["drawable"] = 10, ["texture"] = 0, ["component_id"] = 6 },
                { ["drawable"] = 3, ["texture"] = 0, ["component_id"] = 8 },
                { ["drawable"] = 0, ["texture"] = 0, ["component_id"] = 9 },
                { ["drawable"] = 10, ["texture"] = 0, ["component_id"] = 11 }
            }
        }
    }
}