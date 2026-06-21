---@meta

---@description Example inventory item data for wasabi_ambulance_v2
--- Copy `ox` into ox_inventory/data/items.lua, `qb` into qb-inventory items, `jaksam` into jaksam_inventory/_data/items.lua, `codem` into codem-inventory/config/itemlist.lua (`Config.Itemlist`), `tgiann` into tgiann-inventory/items/items.lua (itemsData).
---
--- HEALING ITEMS: These are used directly from inventory and have server exports
--- MEDICAL TREATMENT ITEMS: These are used via the medical inspection UI (drag onto limbs)
--- They do NOT need exports - they work through the UI system

local ox = {
    -- =====================================
    -- HEALING ITEMS (uses healingItems config)
    -- These can be used directly from inventory
    -- Wasabi Advanced Ambulance Job V2
    -- =====================================
    ["bandage"] = {      -- Make sure no duplicates exist in the original items.lua
        label = 'Bandage',
        description = 'A simple bandage to stop minor bleeding',
        weight = 25,
        server = {
            export = "wasabi_ambulance_v2.bandage"
        }
    },
    ["medkit"] = {
        label = 'Med-Kit',
        description = 'A medical kit for treating injuries',
        weight = 250,
        server = {
            export = "wasabi_ambulance_v2.medkit"
        }
    },
    ["firstaidkit"] = {
        label = 'First Aid Kit',
        description = 'A comprehensive first aid kit for serious injuries',
        weight = 350,
        server = {
            export = "wasabi_ambulance_v2.firstaidkit"
        }
    },
    ["painkillers"] = {
        label = 'Painkillers',
        description = 'Pills to temporarily relieve pain and reduce stun effects',
        weight = 10,
        server = {
            export = "wasabi_ambulance_v2.painkillers"
        }
    },
    ["ifak"] = {
        label = 'IFAK',
        description = 'Individual First Aid Kit',
        weight = 150,
        server = {
            export = "wasabi_ambulance_v2.ifak"
        }
    },

    -- =====================================
    -- MEDICAL TREATMENT ITEMS (uses medicalItems config)
    -- These are used via the inspection UI by dragging onto limbs
    -- They do NOT have exports - the UI system handles their usage
    -- Wasabi Advanced Ambulance
    -- =====================================
    ["forceps"] = {
        label = 'Forceps',
        description = 'Used to treat gunshot wounds',
        weight = 100,
    },
    ["pliers"] = {
        label = 'Pliers',
        description = 'Used to treat taser prong wounds',
        weight = 25,
    },
    ["suture"] = {
        label = 'Suture',
        description = 'Used to treat cuts',
        weight = 25,
    },
    ["splint"] = {
        label = 'Splint',
        description = 'Used to treat broken bones',
        weight = 50,
    },
    ["icepack"] = {
        label = 'Ice Pack',
        description = 'Used to treat punches and bruises',
        weight = 25,
    },
    ["traumakit"] = {
        label = 'Trauma Kit',
        description = 'Used to treat blunt force trauma',
        weight = 75,
    },
    ["burncream"] = {
        label = 'Burn Cream',
        description = 'Used to treat burns',
        weight = 10,
    },

    -- =====================================
    -- EQUIPMENT ITEMS
    -- Wasabi Advanced Ambulance
    -- =====================================
    ["medbag"] = {
        label = 'Medbag',
        description = 'A portable medical bag containing supplies',
        weight = 50,
        stack = false,
        close = true,
        consume = 0,
        server = {
            export = "wasabi_ambulance_v2.medbag"
        }
    }
}

-- QB-Inventory
local qb = {
    -- =====================================
    -- HEALING ITEMS (uses healingItems config)
    -- These can be used directly from inventory
    -- Wasabi Advanced Ambulance
    -- =====================================
    bandage = {name = "bandage", label = "Bandage", weight = 25, type = "item", image = "bandage.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "A simple bandage to stop minor bleeding"}, -- Make sure no duplicates exist in the original items.lua
    medkit = {name = "medkit", label = "Med-Kit", weight = 250, type = "item", image = "medkit.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "A medical kit for treating injuries"},
    firstaidkit = {name = "firstaidkit", label = "First Aid Kit", weight = 350, type = "item", image = "firstaidkit.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "A comprehensive first aid kit for serious injuries"},
    painkillers = {name = "painkillers", label = "Painkillers", weight = 10, type = "item", image = "painkillers.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "Pills to temporarily relieve pain and reduce stun effects"}, -- Make sure no duplicates exist in the original items.lua
    ifak = {name = "ifak", label = "IFAK", weight = 150, type = "item", image = "ifak.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "Individual First Aid Kit"},

    -- =====================================
    -- MEDICAL TREATMENT ITEMS (uses medicalItems config)
    -- These are used via the inspection UI by dragging onto limbs
    -- They do NOT have exports - the UI system handles their usage
    -- Wasabi Advanced Ambulance
    -- =====================================
    forceps = {name = "forceps", label = "Forceps", weight = 100, type = "item", image = "forceps.png", unique = false, useable = false, shouldClose = true, combinable = nil, description = "Used to treat gunshot wounds"},
    pliers = {name = "pliers", label = "Pliers", weight = 25, type = "item", image = "pliers.png", unique = false, useable = false, shouldClose = true, combinable = nil, description = "Used to treat taser prong wounds"},
    suture = {name = "suture", label = "Suture", weight = 25, type = "item", image = "suture.png", unique = false, useable = false, shouldClose = true, combinable = nil, description = "Used to treat cuts"},
    splint = {name = "splint", label = "Splint", weight = 50, type = "item", image = "splint.png", unique = false, useable = false, shouldClose = true, combinable = nil, description = "Used to treat broken bones"},
    icepack = {name = "icepack", label = "Ice Pack", weight = 25, type = "item", image = "icepack.png", unique = false, useable = false, shouldClose = true, combinable = nil, description = "Used to treat punches and bruises"},
    traumakit = {name = "traumakit", label = "Trauma Kit", weight = 75, type = "item", image = "traumakit.png", unique = false, useable = false, shouldClose = true, combinable = nil, description = "Used to treat blunt force trauma"},
    burncream = {name = "burncream", label = "Burn Cream", weight = 10, type = "item", image = "burncream.png", unique = false, useable = false, shouldClose = true, combinable = nil, description = "Used to treat burns"},

    -- =====================================
    -- EQUIPMENT ITEMS
    -- Wasabi Advanced Ambulance
    -- =====================================
    medbag = {name = "medbag", label = "Medbag", weight = 50, type = "item", image = "medbag.png", unique = true, useable = true, shouldClose = true, combinable = nil, description = "A portable medical bag containing supplies"}, -- Make sure no duplicates exist in the original items.lua
}

-- codem-inventory (config/itemlist.lua)
local codem = {
    -- =====================================
    -- HEALING ITEMS (uses healingItems config)
    -- These can be used directly from inventory
    -- Wasabi Advanced Ambulance
    -- =====================================
    bandage = { name = "bandage", label = "Bandage", weight = 25, type = "item", image = "bandage.png", unique = false, useable = true, shouldClose = true, description = "A simple bandage to stop minor bleeding" }, -- Make sure no duplicates exist in the original itemlist
    medkit = { name = "medkit", label = "Med-Kit", weight = 250, type = "item", image = "medkit.png", unique = false, useable = true, shouldClose = true, description = "A medical kit for treating injuries" },
    firstaidkit = { name = "firstaidkit", label = "First Aid Kit", weight = 350, type = "item", image = "firstaidkit.png", unique = false, useable = true, shouldClose = true, description = "A comprehensive first aid kit for serious injuries" },
    painkillers = { name = "painkillers", label = "Painkillers", weight = 10, type = "item", image = "painkillers.png", unique = false, useable = true, shouldClose = true, description = "Pills to temporarily relieve pain and reduce stun effects" }, -- Make sure no duplicates exist in the original itemlist
    ifak = { name = "ifak", label = "IFAK", weight = 150, type = "item", image = "ifak.png", unique = false, useable = true, shouldClose = true, description = "Individual First Aid Kit" },

    -- =====================================
    -- MEDICAL TREATMENT ITEMS (uses medicalItems config)
    -- These are used via the inspection UI by dragging onto limbs
    -- They do NOT have exports - the UI system handles their usage
    -- Wasabi Advanced Ambulance
    -- =====================================
    forceps = { name = "forceps", label = "Forceps", weight = 100, type = "item", image = "forceps.png", unique = false, useable = false, shouldClose = true, description = "Used to treat gunshot wounds" },
    pliers = { name = "pliers", label = "Pliers", weight = 25, type = "item", image = "pliers.png", unique = false, useable = false, shouldClose = true, description = "Used to treat taser prong wounds" },
    suture = { name = "suture", label = "Suture", weight = 25, type = "item", image = "suture.png", unique = false, useable = false, shouldClose = true, description = "Used to treat cuts" },
    splint = { name = "splint", label = "Splint", weight = 50, type = "item", image = "splint.png", unique = false, useable = false, shouldClose = true, description = "Used to treat broken bones" },
    icepack = { name = "icepack", label = "Ice Pack", weight = 25, type = "item", image = "icepack.png", unique = false, useable = false, shouldClose = true, description = "Used to treat punches and bruises" },
    traumakit = { name = "traumakit", label = "Trauma Kit", weight = 75, type = "item", image = "traumakit.png", unique = false, useable = false, shouldClose = true, description = "Used to treat blunt force trauma" },
    burncream = { name = "burncream", label = "Burn Cream", weight = 10, type = "item", image = "burncream.png", unique = false, useable = false, shouldClose = true, description = "Used to treat burns" },

    -- =====================================
    -- EQUIPMENT ITEMS
    -- Wasabi Advanced Ambulance
    -- =====================================
    medbag = { name = "medbag", label = "Medbag", weight = 50, type = "item", image = "medbag.png", unique = true, useable = true, shouldClose = true, description = "A portable medical bag containing supplies" }, -- Make sure no duplicates exist in the original itemlist
}

-- tgiann-inventory (items.lua itemsData)
-- Copy into tgiann-inventory/items/items.lua — resolve name clashes with any existing items (e.g. bandage, painkillers).
local tgiann = {
    -- =====================================
    -- HEALING ITEMS (uses healingItems config)
    -- These can be used directly from inventory
    -- Wasabi Advanced Ambulance Job V2
    -- =====================================
    bandage = { hasMetadata = true, label = "Bandage", weight = 25, type = "item", image = "bandage.png", useable = true, shouldClose = true, description = "A simple bandage to stop minor bleeding" }, -- Make sure no duplicates exist in the original items.lua
    medkit = { hasMetadata = true, label = "Med-Kit", weight = 250, type = "item", image = "medkit.png", useable = true, shouldClose = true, description = "A medical kit for treating injuries" },
    firstaidkit = { hasMetadata = true, label = "First Aid Kit", weight = 350, type = "item", image = "firstaidkit.png", useable = true, shouldClose = true, description = "A comprehensive first aid kit for serious injuries" },
    painkillers = { hasMetadata = true, label = "Painkillers", weight = 10, type = "item", image = "painkillers.png", useable = true, shouldClose = true, description = "Pills to temporarily relieve pain and reduce stun effects" }, -- Make sure no duplicates exist in the original items.lua
    ifak = { hasMetadata = true, label = "IFAK", weight = 150, type = "item", image = "ifak.png", useable = true, shouldClose = true, description = "Individual First Aid Kit" },

    -- =====================================
    -- MEDICAL TREATMENT ITEMS (uses medicalItems config)
    -- These are used via the inspection UI by dragging onto limbs
    -- They do NOT have exports - the UI system handles their usage
    -- Wasabi Advanced Ambulance
    -- =====================================
    forceps = { hasMetadata = true, label = "Forceps", weight = 100, type = "item", image = "forceps.png", useable = false, shouldClose = true, description = "Used to treat gunshot wounds" },
    pliers = { hasMetadata = true, label = "Pliers", weight = 25, type = "item", image = "pliers.png", useable = false, shouldClose = true, description = "Used to treat taser prong wounds" },
    suture = { hasMetadata = true, label = "Suture", weight = 25, type = "item", image = "suture.png", useable = false, shouldClose = true, description = "Used to treat cuts" },
    splint = { hasMetadata = true, label = "Splint", weight = 50, type = "item", image = "splint.png", useable = false, shouldClose = true, description = "Used to treat broken bones" },
    icepack = { hasMetadata = true, label = "Ice Pack", weight = 25, type = "item", image = "icepack.png", useable = false, shouldClose = true, description = "Used to treat punches and bruises" },
    traumakit = { hasMetadata = true, label = "Trauma Kit", weight = 75, type = "item", image = "traumakit.png", useable = false, shouldClose = true, description = "Used to treat blunt force trauma" },
    burncream = { hasMetadata = true, label = "Burn Cream", weight = 10, type = "item", image = "burncream.png", useable = false, shouldClose = true, description = "Used to treat burns" },

    -- =====================================
    -- EQUIPMENT ITEMS
    -- Wasabi Advanced Ambulance
    -- =====================================
    medbag = { hasMetadata = true, label = "Medbag", weight = 50, type = "item", image = "medbag.png", unique = true, useable = true, shouldClose = true, description = "A portable medical bag containing supplies" }, -- Make sure no duplicates exist in the original items.lua
}

-- jaksam_inventory: installed under `Script.Items` in `jaksam_inventory/_data/items.lua`.
-- Duplicate keys removed there: stock `['medkit']` and `['bandage']` were replaced by this block.
-- When updating: copy changes from here into that file, or edit both and grep `jaksam_inventory/_data/items.lua` for `['bandage']` / `['medkit']` / other ids so you never define the same key twice.
-- Healing/equipment items are driven by wasabi_ambulance_v2 via registerUsableItem; you do not need `onUse` here (see jaksam item_example.lua).
local jaksam = {
    -- =====================================
    -- HEALING ITEMS (uses healingItems config)
    -- These can be used directly from inventory
    -- Wasabi Advanced Ambulance Job V2
    -- =====================================
    ['bandage'] = { -- Check for duplicates in jaksam_inventory/_data/items.lua
        label = 'Bandage',
        description = 'A simple bandage to stop minor bleeding',
        weight = 1,
        stackable = true,
        close = true,
        maxStack = 50,
        consume = 1,
    },
    ['medkit'] = { -- Check for duplicates in jaksam_inventory/_data/items.lua
        label = 'Med-Kit',
        description = 'A medical kit for treating injuries',
        weight = 1,
        stackable = true,
        close = true,
        maxStack = 20,
        consume = 1,
    },
    ['firstaidkit'] = {
        label = 'First Aid Kit',
        description = 'A comprehensive first aid kit for serious injuries',
        weight = 0.5,
        stackable = true,
        close = true,
        maxStack = 10,
        consume = 1,
    },
    ['painkillers'] = {
        label = 'Painkillers',
        description = 'Pills to temporarily relieve pain and reduce stun effects',
        weight = 0.5,
        stackable = true,
        close = true,
        maxStack = 30,
        consume = 1,
    },
    ['ifak'] = {
        label = 'IFAK',
        description = 'Individual First Aid Kit',
        weight = 0.5,
        stackable = true,
        close = true,
        maxStack = 10,
        consume = 1,
    },

    -- =====================================
    -- MEDICAL TREATMENT ITEMS (uses medicalItems config)
    -- These are used via the inspection UI by dragging onto limbs
    -- Block direct "use" from inventory (same idea as qb useable = false)
    -- =====================================
    ['forceps'] = {
        label = 'Forceps',
        description = 'Used to treat gunshot wounds',
        weight = 1,
        stackable = true,
        close = true,
        maxStack = 10,
        canUse = function(_playerId, _inventoryId, _itemName, _metadata, _slotId)
            return false
        end,
    },
    ['pliers'] = {
        label = 'Pliers',
        description = 'Used to treat taser prong wounds',
        weight = 0.5,
        stackable = true,
        close = true,
        maxStack = 10,
        canUse = function(_playerId, _inventoryId, _itemName, _metadata, _slotId)
            return false
        end,
    },
    ['suture'] = {
        label = 'Suture',
        description = 'Used to treat cuts',
        weight = 1,
        stackable = true,
        close = true,
        maxStack = 20,
        canUse = function(_playerId, _inventoryId, _itemName, _metadata, _slotId)
            return false
        end,
    },
    ['splint'] = { -- Check for duplicates in jaksam_inventory/_data/items.lua
        label = 'Splint',
        description = 'Used to treat broken bones',
        weight = 1,
        stackable = true,
        close = true,
        maxStack = 10,
        canUse = function(_playerId, _inventoryId, _itemName, _metadata, _slotId)
            return false
        end,
    },
    ['icepack'] = {
        label = 'Ice Pack',
        description = 'Used to treat punches and bruises',
        weight = 1,
        stackable = true,
        close = true,
        maxStack = 15,
        canUse = function(_playerId, _inventoryId, _itemName, _metadata, _slotId)
            return false
        end,
    },
    ['traumakit'] = {
        label = 'Trauma Kit',
        description = 'Used to treat blunt force trauma',
        weight = 1.5,
        stackable = true,
        close = true,
        maxStack = 10,
        canUse = function(_playerId, _inventoryId, _itemName, _metadata, _slotId)
            return false
        end,
    },
    ['burncream'] = {
        label = 'Burn Cream',
        description = 'Used to treat burns',
        weight = 0.5,
        stackable = true,
        close = true,
        maxStack = 20,
        canUse = function(_playerId, _inventoryId, _itemName, _metadata, _slotId)
            return false
        end,
    },

    -- =====================================
    -- EQUIPMENT ITEMS
    -- Wasabi Advanced Ambulance
    -- =====================================
    ['medbag'] = { -- Check for duplicates in jaksam_inventory/_data/items.lua
        label = 'Medbag',
        description = 'A portable medical bag containing supplies',
        weight = 2,
        stackable = false,
        close = true,
    },
}
