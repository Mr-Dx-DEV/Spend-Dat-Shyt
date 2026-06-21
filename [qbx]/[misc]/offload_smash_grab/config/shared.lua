--=============================================================================
-- SMASH & GRAB - MAIN CONFIGURATION
--=============================================================================
-- This is the MAIN configuration file for the Smash & Grab script
-- Here you can customize all the important settings for your server
--=============================================================================

return {
    
    --=============================================================================
    -- GENERAL SETTINGS
    --=============================================================================
    
    -- How often vehicles will spawn with loot (0.0 = never, 1.0 = always)
    -- Default: 0.5 (50% chance)
    SpawnChance = 0.5,
    
    -- Enable debug mode to see extra information in console
    -- Default: false (set to true only when testing)
    Debug = false,
    
    -- Which loot table to use by default (1 = Duffel Bag, 2 = Paper Bag, 3 = Purse)
    -- Default: 1
    DefaultLootIdx = 1,
    
    
    --=============================================================================
    -- LOOT CONFIGURATION
    --=============================================================================
    -- Here you can customize what items players can find in vehicles
    -- Each loot type has different models and reward possibilities
    --=============================================================================
    
    Loot = {
        
        --=========================================================================
        -- DUFFEL BAG LOOT
        --=========================================================================
        { 
            -- Display name for this loot type
            label = 'Duffel Bag',
            
            -- Physical bag models that can spawn in vehicles
            models = {
                `prop_cs_heist_bag_02`,           -- Standard heist bag
                `h4_prop_h4_med_bag_01b`,         -- Medical bag
                `m25_1_prop_m51_heistbag_02a`,    -- Modern heist bag
                `bkr_prop_duffel_bag_01a`,        -- Black duffel bag
            },
            
            -- Items that can be found in this bag type
            -- Format: { item = 'item_name', chance = %, min = minimum_amount, max = maximum_amount }
            rewards = {
                -- MONEY (always enabled - base reward)
                { item = 'money', chance = 80, min = 40, max = 60 },
                
                -- EXAMPLE ITEMS (commented out - remove -- to enable)
                -- { item = 'atminfo', chance = 10, min = 1, max = 1 },        -- ATM Info (10% chance)
                -- { item = 'cannabis_seed', chance = 5, min = 1, max = 1 },   -- Cannabis Seeds (5% chance)
                -- { item = 'goldchain', chance = 20, min = 1, max = 2 },      -- Gold Chain (20% chance)
                -- { item = 'rolex', chance = 20, min = 1, max = 2 },          -- Rolex Watch (20% chance)
                -- { item = 'usb_fake', chance = 30, min = 1, max = 1 },        -- Fake USB (30% chance)
                -- { item = 'green_watch', chance = 40, min = 1, max = 2 },     -- Green Watch (40% chance)
                -- { item = 'perle_cheap', chance = 40, min = 1, max = 2 },     -- Cheap Pearl (40% chance)
                -- { item = 'medical_prescription', chance = 15, min = 1, max = 1 }, -- Medical Prescription (15% chance)
            },
        },
        
        --=========================================================================
        -- PAPER BAG LOOT
        --=========================================================================
        { 
            label = 'Paper Bag',
            models = {
                `prop_paper_bag_01`,              -- Standard paper bag
                `prop_paper_bag_small`,           -- Small paper bag
                `prop_food_bag2`,                 -- Food bag
            },
            rewards = {
                -- MONEY (always enabled - base reward)
                { item = 'money', chance = 80, min = 40, max = 60 },
                
                -- Add your custom items here (copy from duffel bag examples above)
                -- Example: { item = 'your_item', chance = 25, min = 1, max = 3 },
            },
        },
        
        --=========================================================================
        -- PURSE LOOT
        --=========================================================================
        { 
            label = 'Purse',
            models = {
                `prop_ld_handbag`,                -- Ladies handbag
                `prop_cs_shopping_bag`,           -- Shopping bag
                `prop_beachbag_06`,               -- Beach bag
            },
            rewards = {
                -- MONEY (always enabled - base reward)
                { item = 'money', chance = 80, min = 40, max = 60 },
                
                -- Add your custom items here (copy from duffel bag examples above)
                -- Example: { item = 'your_item', chance = 25, min = 1, max = 3 },
            },
        },
    },
    
    
    --=============================================================================
    -- ITEM ADDING GUIDE
    --=============================================================================
    -- To add new items to any loot table:
    -- 1. Copy one of the example lines above
    -- 2. Replace 'item_name' with your actual item name from your inventory system
    -- 3. Set 'chance' to the percentage chance of finding this item (0-100)
    -- 4. Set 'min' and 'max' to the range of how many the player might find
    -- 5. Remove the -- at the start of the line to enable it
    --
    -- Example: { item = 'diamond', chance = 5, min = 1, max = 1 },
    -- This gives a 5% chance to find 1 diamond
    --=============================================================================
}