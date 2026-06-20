-- Items that can be sold TO dealers (player sells these)
-- price = cash received, rep = reputation gained
Config.SellableItems = {
    -- Weed
    ['weed_1g'] = { price = 30, rep = 1 },
    ['weed_eighth'] = { price = 100, rep = 3 },
    ['weed_quarter'] = { price = 190, rep = 5 },
    ['weed_half'] = { price = 360, rep = 8 },
    ['weed_ounce'] = { price = 700, rep = 15 },
    ['weed_brick'] = { price = 500, rep = 15 },
    ['joint'] = { price = 30, rep = 1 },
    ['blunt'] = { price = 40, rep = 1 },
    -- Meth
    ['meth_baggy'] = { price = 250, rep = 10 },
    ['meth_baggy_glass'] = { price = 325, rep = 13 },
    ['meth_baggy_blue_sky'] = { price = 400, rep = 18 },
    ['meth_baggy_purple_haze'] = { price = 375, rep = 16 },
    ['meth_baggy_lean_crystal'] = { price = 300, rep = 11 },
    ['meth_baggy_green_rush'] = { price = 285, rep = 10 },
    ['meth_baggy_dirty_sprite'] = { price = 360, rep = 15 },
    ['meth_baggy_street_mix'] = { price = 175, rep = 6 },
    ['meth_baggy_rocket_fuel'] = { price = 340, rep = 14 },
    ['meth_baggy_club_special'] = { price = 385, rep = 17 },
    ['meth_baggy_ice'] = { price = 375, rep = 16 },
    -- Misc
    ['phone'] = { price = 100, rep = 2 },
}

-- Items available for PURCHASE from dealers (dealer sells these)
-- Organized by reputation tier
Config.ShopInventory = {
    -- Tier 0: Unknown (0-99 rep)
    [0] = {
        { item = 'lockpick', label = 'Lockpick', price = 300, stock = 10 },
        { item = 'joint', label = 'Joint', price = 50, stock = 20 },
        { item = 'rolling_papers', label = 'Rolling Papers', price = 10, stock = 50 },
        { item = 'lighter', label = 'Lighter', price = 15, stock = 20 },
        { item = 'weapon_switchblade', label = 'Switchblade', price = 200, stock = 5 },
    },

    -- Tier 1: Street (100-299 rep)
    [1] = {
        { item = 'ammo_pistol', label = '9mm Ammo', price = 15, stock = 100 },
        { item = 'radio', label = 'Radio', price = 500, stock = 5 },
        { item = 'bandage', label = 'Bandage', price = 100, stock = 15 },
        { item = 'growing_manual', label = "Grower's Manual", price = 800, stock = 3 },
        { item = 'weapon_knife', label = 'Knife', price = 350, stock = 5 },
        { item = 'hydrogen_peroxide', label = 'Hydrogen Peroxide', price = 80, stock = 20 },
        { item = 'ammonia', label = 'Ammonia', price = 80, stock = 20 },
        { item = 'hydrochloric_acid', label = 'Hydrochloric Acid', price = 80, stock = 20 },
        { item = 'sodium_benzoate', label = 'Sodium Benzoate', price = 80, stock = 20 },
        { item = 'baggy', label = 'Empty Baggy', price = 10, stock = 50 },
    },

    -- Tier 2: Connected (300-599 rep)
    [2] = {
        { item = 'blackmarket_pager', label = 'Burner Pager', price = 2500, stock = 2 },
        { item = 'weapon_pistol', label = 'Pistol (No Serial)', price = 5000, stock = 2, info = { serie = '' } },
        { item = 'weapon_snspistol', label = 'SNS Pistol', price = 3500, stock = 3, info = { serie = '' } },
        { item = 'weapon_sawnoffshotgun', label = 'Sawed-Off Shotgun', price = 4500, stock = 2, info = { serie = '' } },
        { item = 'ammo_smg', label = 'SMG Ammo', price = 25, stock = 100 },
        { item = 'weapon_molotov', label = 'Molotov', price = 500, stock = 5 },
        { item = 'meth_table', label = 'Meth Table', price = 3000, stock = 2 },
        { item = 'meth_crystallizer', label = 'Meth Crystallizer', price = 4500, stock = 2 },
        { item = 'meth_manual', label = "The Cook's Notebook", price = 1500, stock = 3 },
        { item = 'gas_mask', label = 'Gas Mask', price = 500, stock = 5 },
        { item = 'cough_syrup', label = 'Cough Syrup', price = 60, stock = 15 },
        { item = 'pain_killer', label = 'Pain Killer', price = 40, stock = 15 },
        { item = 'cannabis_leaf', label = 'Cannabis Leaf', price = 50, stock = 15 },
        { item = 'lax_to_the_max', label = 'Lax to the Max', price = 45, stock = 15 },
    },

    -- Tier 3: Trusted (600-999 rep)
    [3] = {
        { item = 'weapon_microsmg', label = 'Micro SMG', price = 12000, stock = 2, info = { serie = '' } },
        { item = 'weapon_pumpshotgun', label = 'Pump Shotgun', price = 15000, stock = 1, info = { serie = '' } },
        { item = 'ammo_rifle', label = 'Rifle Ammo', price = 50, stock = 100 },
        { item = 'ammo_shotgun', label = 'Shotgun Ammo', price = 40, stock = 50 },
        { item = 'med_armor', label = 'Body Armor', price = 5000, stock = 5 },
        { item = 'printer_usb', label = 'SNS Pistol USB', price = 2500, stock = 3, info = { blueprint = 'sns_pistol' } },
        { item = 'printer_usb', label = 'Pistol USB', price = 3000, stock = 3, info = { blueprint = 'pistol' } },
        { item = 'printer_usb', label = 'Micro SMG USB', price = 4000, stock = 2, info = { blueprint = 'micro_smg' } },
        { item = 'printer_usb', label = 'Pump Shotgun USB', price = 4000, stock = 2, info = { blueprint = 'pump_shotgun' } },
        { item = 'magnesium_oxide', label = 'Magnesium Oxide', price = 120, stock = 10 },
        { item = 'hazardous_waste', label = 'Hazardous Waste', price = 150, stock = 10 },
        { item = 'vanilla_unicorn_pills', label = 'V.U. Pills', price = 200, stock = 10 },
        { item = 'acetone', label = 'Acetone', price = 250, stock = 10 },
        { item = 'adrenaline', label = 'Adrenaline', price = 300, stock = 10 },
    },

    -- Tier 4: Inner Circle (1000+ rep)
    [4] = {
        { item = 'weapon_assaultrifle', label = 'Assault Rifle', price = 35000, stock = 1, info = { serie = '' } },
        { item = 'weapon_carbinerifle', label = 'Carbine Rifle', price = 40000, stock = 1, info = { serie = '' } },
        { item = 'weapon_smg', label = 'SMG', price = 20000, stock = 2, info = { serie = '' } },
        { item = 'heavy_armor', label = 'Heavy Armor', price = 10000, stock = 3 },
        { item = 'ammo_sniper', label = 'Sniper Ammo', price = 100, stock = 50 },
        { item = 'printer_usb', label = 'Assault Rifle USB', price = 8000, stock = 1, info = { blueprint = 'assault_rifle' } },
        { item = 'printer_usb', label = 'Carbine Rifle USB', price = 8500, stock = 1, info = { blueprint = 'carbine_rifle' } },
        { item = 'printer_usb', label = 'Combat Pistol USB', price = 5000, stock = 2, info = { blueprint = 'combat_pistol' } },
        { item = 'toluene', label = 'Toluene', price = 400, stock = 8 },
    },
}

-- Helper function to get tier from reputation
function GetTierFromRep(rep)
    if not Config.EnableTiers then
        return 4, locale(Config.Tiers[4].name)
    end
    rep = rep or 0
    local tier = 0
    for i = 4, 0, -1 do
        if rep >= Config.Tiers[i].minRep then
            tier = i
            break
        end
    end
    return tier, locale(Config.Tiers[tier].name)
end
