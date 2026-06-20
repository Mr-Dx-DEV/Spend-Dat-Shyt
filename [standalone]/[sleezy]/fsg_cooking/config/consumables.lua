-- Per-item hunger/thirst values for QBCore metadata.
-- Adjust these to balance how much each food/drink restores.
--
-- hunger/thirst values are ADDED to the player's current level (capped at 100).
-- Example: a player at 40 hunger eats something worth 25 -> hunger becomes 65.

Config.Consumables = {}

-- Default values used when an item isn't listed below
Config.Consumables.DefaultFood = 25
Config.Consumables.DefaultDrink = 25

-- Format: ['item_name'] = hunger_value
Config.Consumables.Food = {
    -- Grilled / BBQ
    ['fsg_bbq_burger']              = 35,
    ['fsg_bbq_chicken']             = 30,
    ['fsg_bbq_chicken_flatbread']   = 30,
    ['fsg_bbq_ribs']                = 40,
    ['fsg_bbq_sausages']            = 30,
    ['fsg_bbq_bacon_wraps']         = 25,
    ['fsg_bbq_veggie_skewers']      = 20,
    ['fsg_grilled_cheese']          = 25,
    ['fsg_grilled_chicken_breast']  = 35,
    ['fsg_grilled_corn']            = 15,
    ['fsg_grilled_fish']            = 30,
    ['fsg_grilled_pineapple']       = 10,
    ['fsg_grilled_shrimp']          = 25,
    ['fsg_grilled_vegetables']      = 20,
    ['fsg_pulled_pork']             = 35,
    ['fsg_cooked_steak']            = 40,
    ['fsg_pan_seared_steak']        = 45,
    ['fsg_fancy_steak']             = 50,

    -- Fried
    ['fsg_fried_calamari']          = 20,
    ['fsg_fried_cheese_curds']      = 20,
    ['fsg_fried_cheese_sticks']     = 20,
    ['fsg_fried_chicken']           = 35,
    ['fsg_fried_chicken_wings']     = 30,
    ['fsg_fried_okra']              = 15,
    ['fsg_fried_potato']            = 20,
    ['fsg_fried_rice']              = 30,
    ['fsg_fried_shrimp']            = 25,
    ['fsg_chicken_nuggets']         = 25,
    ['fsg_fish_and_chips']          = 35,
    ['fsg_onion_rings']             = 15,
    ['fsg_mozzarella_sticks']       = 20,
    ['fsg_spring_rolls']            = 20,
    ['fsg_popcorn']                 = 10,

    -- Pizza
    ['fsg_pepperoni_pizza']         = 40,
    ['fsg_chicken_pesto_pizza']     = 35,
    ['fsg_meatlovers_pizza']        = 45,
    ['fsg_pineapple_pizza']         = 35,
    ['fsg_microwave_pizza_slice']   = 20,

    -- Rice / Noodles / Pasta
    ['fsg_bffriedrice']             = 30,
    ['fsg_ckfriedrice']             = 30,
    ['fsg_ramen']                   = 30,
    ['fsg_ramen_bowl']              = 35,
    ['fsg_pasta_dish']              = 35,
    ['fsg_risotto']                 = 30,
    ['fsg_stir_fry']                = 30,
    ['fsg_bstirfry']                = 30,
    ['fsg_curry']                   = 35,
    ['fsg_mac_n_cheese_bake']       = 30,
    ['fsg_microwave_mac_cheese']    = 20,

    -- Sandwiches / Wraps / Toast
    ['fsg_chickensand']             = 30,
    ['fsg_avocado_toast']           = 20,
    ['fsg_cheesy_toast']            = 20,
    ['fsg_cinnamon_toast']          = 15,
    ['fsg_ham_and_cheese_toast']    = 25,
    ['fsg_hamtoastie']              = 25,
    ['fsg_toast']                   = 15,
    ['fsg_toasti']                  = 20,
    ['fsg_veggie_wrap']             = 20,
    ['fsg_quesadilla']              = 25,
    ['fsg_breakfast_burrito']       = 30,

    -- Breakfast
    ['fsg_pancakes']                = 25,
    ['fsg_waffle']                  = 25,
    ['fsg_crepes']                  = 20,
    ['fsg_omelette']                = 25,
    ['fsg_microwave_omelette']      = 15,
    ['fsg_scrambled_eggs']          = 20,
    ['fsg_cooked_oatmeal']          = 20,
    ['fsg_breakfast_muffin']        = 20,

    -- Soups / Baked
    ['fsg_homemade_soup']           = 25,
    ['fsg_soup']                    = 20,
    ['fsg_baked_potato']            = 25,
    ['fsg_quiche']                  = 25,

    -- Seafood
    ['fsg_salmon']                  = 35,
    ['fsg_pepshrimp']               = 25,

    -- Microwave / Quick
    ['fsg_tv_dinner']               = 20,
    ['fsg_microwave_chocolate_mug_cake'] = 15,

    -- Sweets / Desserts
    ['fsg_apple_pie']               = 20,
    ['fsg_chocolate_mousse']        = 15,
    ['fsg_chocolate_spread']        = 10,
    ['fsg_creme_brulee']            = 15,
    ['fsg_donuts']                  = 15,
    ['fsg_bpudding']                = 15,
    ['fsg_berrycream']              = 10,
    ['fsg_choccream']               = 10,
    ['fsg_nanacream']               = 10,

    -- Sides / Light
    ['fsg_fruit_salad']             = 15,
    ['fsg_veggie_puree']            = 15,
    ['fsg_applesauce']              = 10,
}

-- Format: ['item_name'] = thirst_value
Config.Consumables.Drinks = {
    -- Juices
    ['fsg_apple_juice']             = 30,
    ['fsg_applejuice']              = 30,
    ['fsg_beet_juice']              = 25,
    ['fsg_carrot_juice']            = 25,
    ['fsg_celery_juice']            = 25,
    ['fsg_grape_juice']             = 30,
    ['fsg_orange_juice']            = 30,
    ['fsg_pineapple_juice']         = 30,
    ['fsg_tomato_juice']            = 25,
    ['fsg_watermelon_juice']        = 35,

    -- Mixed / Punch
    ['fsg_fruit_punch']             = 35,
    ['fsg_lemonade']                = 30,
    ['fsg_smoothie']                = 35,

    -- Coffee / Hot
    ['fsg_coffee']                  = 25,
    ['fsg_cappuccino']              = 25,
    ['fsg_iced_coffee']             = 30,
    ['fsg_mocha']                   = 25,
    ['fsg_vanilla_latte']           = 25,
    ['fsg_hot_chocolate']           = 30,

    -- Frozen / Dessert
    ['fsg_ice_cream']               = 20,
}
