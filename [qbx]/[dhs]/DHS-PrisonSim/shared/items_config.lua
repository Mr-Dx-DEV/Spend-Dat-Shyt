ItemsConfig = {}

ItemsConfig.ItemRequiredToHackGates = 'trojan_usb'

ItemsConfig.JobItems = {
    ["Laundry"] = {
        prisonJumpSuitDirtyItem = "prison_jump_suit_dirty",
        guardUniformDirtyItem = "guard_uniform_dirty",
        prisonJumpSuitWetItem = "prison_jump_suit_wet",
        guardUniformWetItem = "guard_uniform_wet",
        prisonJumpSuitCleanItem = "prison_jump_suit_clean",
        guardUniformCleanItem = "guard_uniform_clean",
        prisonJumpSuitCleanFoldedItem = "prison_jump_suit_clean_folded",
        guardUniformCleanFoldedItem = "guard_uniform_clean_folded",
    },
    ["MetalShop"] = {
        metalBarItem = "metalbar",
        metalPlateItem = "metalplate",
        licensePlateItem = "licenseplate",
    },
    ["Mining"] = {
        pickaxeItem = "pickaxe",
        rockItem = "rock",
    },
    ["Recycling"] = {
        recyclableMaterialItem = "recyclable_material",
        recyclableMaterialBlockItem = "recyclable_material_block",
    },
    ["WoodShop"] = {
        woodenLogItem = "woodlog",
        woodenPlankItem = "woodplank",
        woodenChairItem = {
            item = "wooden_chair",
            requiredItems = {
                woodenPlankItem = 2,
            },
        },
        woodenTableItem = {
            item = "wooden_table",
            requiredItems = {
                woodenPlankItem = 4,
            },
        },
        woodenStorageItem = {
            item = "wooden_storage_box",
            requiredItems = {
                woodenPlankItem = 6,
            },
        },
    },
    
}
