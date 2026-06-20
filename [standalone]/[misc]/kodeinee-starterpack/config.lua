Config = {}

-- Framework options: 'auto', 'qb', 'qbox', 'esx'
Config.Framework = 'auto'

-- Inventory options: 'auto', 'qb', 'ox', 'esx'
-- auto checks ox_inventory first, then qb-inventory, then ESX inventory.
Config.Inventory = 'auto'

-- Prevents using starterpack multiple times per character
Config.UseOnce = true

-- Command players use to claim the starter pack
Config.Command = 'starterpack'

-- If true, cash/money items are added as account money instead of inventory items.
-- This helps all frameworks because most ESX/QB/Qbox servers store cash as money, not an inventory item.
Config.MoneyItemsAsAccount = true
Config.MoneyAccount = 'cash' -- QB/Qbox = cash, ESX usually = money

-- Delay between giving each starter item
Config.ItemGiveDelay = 250

   Config.male_starterpack = {
    label = "Male Starter Pack",
    items = {
        { name = "bbs_12inch_chicken",           amount = 5 },
        { name = "bbs_12inch_beef",              amount = 5 },
        { name = "bbs_batorate_fruit_punch_can", amount = 10 },
        { name = "sky_gliders_plus",             amount = 1 },
        { name = "WEAPON_BAT",                   amount = 1 },
        { name = "cokebaggy",                    amount = 100 },
        { name = "money",                        amount = 10000 },
    }
}



Config.female_starterpack = {
    label = "Female Starter Pack",
    items = {
        { name = "bbs_12inch_chicken",           amount = 5 },
        { name = "bbs_12inch_beef",              amount = 5 },
        { name = "bbs_batorate_fruit_punch_can", amount = 10 },
        { name = "WEAPON_SWITCHBLADE",           amount = 1 },
        { name = "wigclientphone",               amount = 1 },
        { name = "deepwavewigs",                 amount = 100 },
        { name = "cokebaggy",                    amount = 100 },
        { name = "money",                        amount = 10000 },
    }
}

