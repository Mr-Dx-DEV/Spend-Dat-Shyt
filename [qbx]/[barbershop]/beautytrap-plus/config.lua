Config = {}

-- Framework Selection
Config.Framework = "qbcore" -- Options: "qbcore", "esx"

-- Language Selection
Config.Locale = 'en' -- Options: 'en', 'es', 'fr', 'de', 'pt', 'zh', 'ja'

-- Appearance System Selection
Config.AppearanceSystem = "auto" -- Options: "auto", "skinchanger", "illenium", "fivem-appearance", "qb-clothing", "rcore_clothing", "native", "codem-appearance", "17mov"
-- "auto" will detect which system is available and use the best one
-- "skinchanger" = ESX esx_skin/skinchanger system
-- "illenium" = illenium-appearance system
-- "fivem-appearance" = fivem-appearance system
-- "qb-clothing" = QBCore qb-clothing system
-- "rcore_clothing" = rcore_clothing system
-- "codem-appearance" = CodeM mAppearance 
-- "17mov" = 17 Movement CharacterSystem 
-- "native" = Direct GTA natives (fallback)

-- Debug Mode
Config.Debug = false -- Set to true to enable debug messages, false to disable

-- Target System
Config.Target = 'ox' -- 'ox' | 'qb'

-- Inventory System
Config.Inventory = 'ox' -- 'ox' | 'qb' | 'qs' | 'ak47'

-- Dispatch System
Config.DispatchSystem = "ps-dispatch" -- Options: "ps-dispatch", "qs-dispatch", "cd-dispatch", "rcore_dispatch", "lb-tablet", false
Config.UseDispatch = false -- true | false | Set to true to enable dispatch alerts

-- ============================================
-- LB TABLET INTEGRATION
-- ============================================
-- If you use LB Tablet (lb-tablet) and want the salon tablet to appear
-- as a custom app inside LB Tablet instead of spawning its own prop,
-- set this to true. When enabled:
--   • A "Beauty Salon" app icon appears on LB Tablet for employees with the job
--   • No separate tablet prop/animation is created (LB Tablet handles that)
--   • The tablet UI opens as a NUI overlay when the app is tapped
--   • Dispatch can also be routed through LB Tablet (set Config.DispatchSystem = "lb-tablet")
Config.UseLBTablet = false

Config.LBTablet = {
    -- App settings (what shows on the LB Tablet home screen)
    AppIdentifier = "beautytrap-salon",   -- Unique ID (don't change unless conflict)
    AppName = "Beauty Salon",             -- Display name on tablet
    AppDescription = "Salon Management & Services", -- App store description
    AppIcon = "hair/html/img/logo.png",   -- Path to icon from resource root
    AppDeveloper = "BeautyTrap+",         -- Developer name shown in app

    -- Set to true if you want the app to appear as a default/pre-installed app
    -- Set to false if employees need to "install" it from the LB Tablet app store
    DefaultApp = true,
}

-- Banking System Configuration
Config.Banking = {
    System = "auto", -- Options: "qb-management", "qb-banking", "okokBanking", "renewed-banking", "tgg-banking", esx_society, "auto"
    -- "auto" will try each system in order until one works
}

-- Shelf Inventory Configuration
Config.EnableShelfInventory = true  -- Set to false to disable shelf inventory system
Config.MaxShelfStock = 1000         -- Default maximum items per shelf type
Config.LowStockThreshold = 200      -- Show warning when stock is below this number

-- Purchase Limits
Config.EnablePurchaseLimit = true -- Set to false to disable the purchase limit system
Config.MaxItemsPerPeriod = 60 -- Maximum number of items that can be purchased before cooldown
Config.CooldownHours = 4 -- Cooldown period in hours

-- Basket Capacity
Config.MaxItemsPerBasket = 60 -- Maximum number of items that can be held in a basket at once

-- Employee Jobs
Config.StoreEmployeeJobs = {
    'beauty', -- Beauty store employees
}

-- Society Configuration
Config.UseSocietyPayments = true  -- Set to false to disable society payments and pay employees directly
Config.StoreSocieties = {
    ["beauty"] = "beauty", -- Society accounts that receive payments
    }

-- Register Split Configuration
-- When enabled, splits checkout payments between society and employee
Config.RegisterSplit = {
    Enabled = false,          -- Set to true to enable split payments
    SocietyPercent = 70,      -- Percentage that goes to society (e.g. 70 = 70%)
    EmployeePercent = 30,     -- Percentage that goes to employee (e.g. 30 = 30%)
}

-- Default Duty Status - set to false to make employees start as off-duty
Config.DefaultDutyStatus = false

-- Hair Styling System Configuration
Config.Hair = {
    JobName = Config.StoreEmployeeJobs[1],
    MinimumJobGrade = 2, -- Minimum beauty job grade to style hair
    CanMakeup = true, -- If true, allows makeup styling
    InteractionDistance = 2.0, -- Distance to interact with client in chair
    FemaleModels = {
        "mp_f_freemode_01",
    },
    Animations = {
        Female = {
            dict = "misshair_shop@barbers",
            anim = "keeper_idle_b"
        },
        Male = {
            dict = "mp_safehousevagos@",
            anim = "vag_chandelier_idle"                                                    
        }
    }
}

-- Nail Configuration
Config.Nails = {
    JobName = Config.StoreEmployeeJobs[1],
    MinimumJobGrade = 3,
    InteractionDistance = 3.0,
    
    -- Nail components based on the working script
    Components = {
        -- Long Nails (Component 9 - Body Armor)
        ["long_nails"] = {
            componentId = 9,
            label = "Long Nails",
            options = {
                { drawable = 6, texture = 0, label = "Long Green" },
                { drawable = 6, texture = 1, label = "Long Blue" },
                { drawable = 6, texture = 2, label = "Long Orange" },
                { drawable = 6, texture = 3, label = "Long Hot Pink" },
                { drawable = 177, texture = 0, label = "Long Black" },
                -- Long French Tips
                { drawable = 5, texture = 0, label = "French Green" },
                { drawable = 5, texture = 1, label = "French Blue" },
                { drawable = 5, texture = 2, label = "French White" },
                { drawable = 5, texture = 3, label = "French Hot Pink" },
                { drawable = 5, texture = 4, label = "French Red" },
            }
        },
        
        -- Short Nails (Component 7 - Accessories)
        ["short_nails"] = {
            componentId = 7,
            label = "Short Nails",
            options = {
                -- Short colored nails
                { drawable = 36, texture = 0, label = "Short Black" },
                { drawable = 36, texture = 1, label = "Short Pink" },
                { drawable = 36, texture = 2, label = "Short White" },
                { drawable = 36, texture = 14, label = "Cow Print" },
                { drawable = 36, texture = 20, label = "Black & Yellow" },
                -- Short nude nails
                { drawable = 35, texture = 0, label = "Nude Creme" },
                { drawable = 35, texture = 1, label = "Nude Ivory" },
                { drawable = 35, texture = 2, label = "Nude Toasted" },
                { drawable = 35, texture = 3, label = "Nude Caramel" },
                { drawable = 35, texture = 4, label = "Nude Pinkish" },
                { drawable = 35, texture = 6, label = "Nude Chocolate" },
            }
        }
    }
}

-- Lash Configuration (Component 10 - Decals)
Config.Lashes = {
    JobName = Config.StoreEmployeeJobs[1],
    MinimumJobGrade = 3,
    componentId = 10,
    options = {
        -- Long lashes
        { drawable = 4, texture = 0, label = "Long Length 1" },
        { drawable = 5, texture = 0, label = "Long Length 2" },
        -- Short lashes
        { drawable = 2, texture = 0, label = "Short Style 1" },
        { drawable = 2, texture = 1, label = "Short Style 2" },
        { drawable = 2, texture = 2, label = "Short Style 3" },
        { drawable = 2, texture = 3, label = "Short Style 4" },
        { drawable = 2, texture = 4, label = "Short Style 5" },
        { drawable = 2, texture = 5, label = "Short Style 6" },
        { drawable = 2, texture = 6, label = "Short Style 7" },
        { drawable = 2, texture = 7, label = "Short Style 8" },
        { drawable = 2, texture = 8, label = "Short Style 9" },
        { drawable = 2, texture = 9, label = "Short Style 10" },
        { drawable = 2, texture = 10, label = "Short Style 11" },
        { drawable = 2, texture = 11, label = "Short Style 12" },
        { drawable = 2, texture = 12, label = "Short Style 13" },
    }
}

-- Trap (Street Selling) Configuration
Config.Trap = {
    -- Enable/Disable Features
    Enabled = true,
    UseTarget = false, -- true = use target system (ox_target/qb-target), false = use E key to sell
    WomenOnly = true, -- Set to false to allow everyone to sell
    Command = 'beauty', -- Command to start selling
    
    -- Requirements
    MinPolice = 0, -- Minimum police required to start selling
    RequireBeautyJob = false, -- Set to true if only beauty job can sell (DEFAULT: false = anyone can sell)
    
    -- Selling Settings
    PedFrequency = {1, 5}, -- Time between customers in seconds (min, max)
    RejectChance = 20, -- Percent chance of rejected sale (1-100)
    RobberyChance = 10, -- Percent chance of robbery if sale is rejected (1-100)
    MaxDistance = 25, -- Max distance customer will walk to player
    
    -- Payment Settings
    PaymentAccount = 'cash', -- 'cash', 'bank', or 'black_money'
    
    -- Sellable Products (must match items in your store zones)
    Products = {
        ['lipstick']              = { label = 'Lipstick',                price = {10, 20}, quantity = {1, 3} },
        ['mascara']               = { label = 'Mascara',                 price = {15, 25}, quantity = {1, 3} },
        ['foundation']            = { label = 'Foundation',              price = {20, 35}, quantity = {1, 3} },
        ['eyeliner']              = { label = 'Eyeliner',                price = {12, 22}, quantity = {1, 3} },
        ['brushset']              = { label = 'Makeup Brush Set',        price = {30, 50}, quantity = {1, 3} },
        ['annasui']               = { label = 'Anna Perfume',            price = {25, 40}, quantity = {1, 3} },
        ['duneperfume']           = { label = 'Dune Perfume',            price = {25, 40}, quantity = {1, 3} },
        ['settingpowder']         = { label = 'Setting Powder',          price = {15, 25}, quantity = {1, 3} },
        ['lipgloss']              = { label = 'Lip Gloss',               price = {8, 18},  quantity = {1, 3} },
        ['prepnprime']            = { label = 'Prep n Prime',            price = {18, 30}, quantity = {1, 3} },
        ['faceprimer']            = { label = 'Face Primer',             price = {20, 30}, quantity = {1, 3} },
        ['settingspray']          = { label = 'Setting Spray',           price = {18, 28}, quantity = {1, 3} },
        ['lightliquidfoundation'] = { label = 'Light Liquid Foundation', price = {25, 35}, quantity = {1, 3} },
        ['brownliquidfoundation'] = { label = 'Brown Liquid Foundation', price = {25, 35}, quantity = {1, 3} },
        ['foundationprimer']      = { label = 'Foundation Primer',       price = {22, 32}, quantity = {1, 3} },
        ['activatorcream']        = { label = 'Activator Cream',         price = {18, 30}, quantity = {1, 3} },
        ['apricotoil']            = { label = 'Apricot Oil',             price = {18, 30}, quantity = {1, 3} },
        ['arganoil']              = { label = 'Argan Oil',               price = {18, 30}, quantity = {1, 3} },
        ['blushpalette']          = { label = 'Blush Palette',           price = {18, 30}, quantity = {1, 3} },
        ['bonnet']                = { label = 'Bonnet',                  price = {18, 30}, quantity = {1, 3} },
        ['castoroil']             = { label = 'Castor Oil',              price = {18, 30}, quantity = {1, 3} },
        ['concealer']             = { label = 'Concealer',               price = {18, 30}, quantity = {1, 3} },
        ['conditioner']           = { label = 'Conditioner',             price = {18, 30}, quantity = {1, 3} },
        ['curlingcream']          = { label = 'Curling Cream',           price = {18, 30}, quantity = {1, 3} },
        ['curlshampoo']           = { label = 'Curl Shampoo',            price = {18, 30}, quantity = {1, 3} },
        ['durag']                 = { label = 'Du-rag',                  price = {18, 30}, quantity = {1, 3} },
        ['dyebrush']              = { label = 'Dye Brush',               price = {18, 30}, quantity = {1, 3} },
        ['ecoblack']              = { label = 'Eco Gel (Black)',         price = {18, 30}, quantity = {1, 3} },
        ['ecoblue']               = { label = 'Eco Gel (Blue)',          price = {18, 30}, quantity = {1, 3} },
        ['ecobrown']              = { label = 'Eco Gel (Brown)',         price = {18, 30}, quantity = {1, 3} },
        ['ecored']                = { label = 'Eco Gel (Red)',           price = {18, 30}, quantity = {1, 3} },
        ['enameldryer']           = { label = 'Enamel Dryer',            price = {18, 30}, quantity = {1, 3} },
        ['eyelinerpencil']        = { label = 'Eyeliner Pencil',         price = {18, 30}, quantity = {1, 3} },
        ['eyeshadowpalette']      = { label = 'Eyeshadow Palette',       price = {18, 30}, quantity = {1, 3} },
        ['flexirod']              = { label = 'Flexi-Rod',               price = {18, 30}, quantity = {1, 3} },
        ['foambodywash']          = { label = 'Foaming Body Wash',       price = {18, 30}, quantity = {1, 3} },
        ['grocomplex']            = { label = 'Gro Complex',             price = {18, 30}, quantity = {1, 3} },
        ['hairgrease']            = { label = 'Hair Grease',             price = {18, 30}, quantity = {1, 3} },
        ['hairserum']             = { label = 'Hair Serum',              price = {18, 30}, quantity = {1, 3} },
        ['hommestylinggel']       = { label = 'Homme Styling Gel',       price = {18, 30}, quantity = {1, 3} },
        ['lipset']                = { label = 'Lip Set',                 price = {18, 30}, quantity = {1, 3} },
        ['masque']                = { label = 'Hair Masque',             price = {18, 30}, quantity = {1, 3} },
        ['menshampoo']            = { label = 'Men’s Shampoo',           price = {18, 30}, quantity = {1, 3} },
        ['moisturizer']           = { label = 'Moisturizer',             price = {18, 30}, quantity = {1, 3} },
        ['nailpolishremover']     = { label = 'Nail-Polish Remover',     price = {18, 30}, quantity = {1, 3} },
        ['oliveoilsheen']         = { label = 'Olive-Oil Sheen Spray',   price = {18, 30}, quantity = {1, 3} },
        ['pediscrub']             = { label = 'Pedi Scrub',              price = {18, 30}, quantity = {1, 3} },
        ['pedisoft']              = { label = 'Pedi Soft Cream',         price = {18, 30}, quantity = {1, 3} },
        ['powdereyeshadow']       = { label = 'Powder Eyeshadow',        price = {18, 30}, quantity = {1, 3} },
        ['restoringsmoothie']     = { label = 'Restoring Smoothie',      price = {18, 30}, quantity = {1, 3} },
        ['thermalwater']          = { label = 'Thermal Water Spray',     price = {18, 30}, quantity = {1, 3} },
        ['sheenspray']            = { label = 'Sheen Spray',             price = {18, 30}, quantity = {1, 3} },

        --[[ 
        
        -- THE FADE TRAP ITEMS (disabled by default because of use in The Fade Trap Barbershop)
        -- UNCOMMENT THESE TO MAKE THEM SELLABLE TO PEDS IN THE TRAPPING
        
        ['magicclipbox']             = { label = 'UNOPENED Magic Clip Clippers',     price = {18, 30}, quantity = {1, 3} },
        ['gammaergobox']             = { label = 'UNOPENED Gamma + Ergo Clippers',   price = {18, 30}, quantity = {1, 3} },
        ['goldfxbox']                = { label = 'UNOPENED GoldFX Trimmer',          price = {18, 30}, quantity = {1, 3} },
        ['instincttrimmerbox']       = { label = 'UNOPENED Instinct Trimmer',        price = {18, 30}, quantity = {1, 3} },
        ['toutlinerbox']             = { label = 'UNOPENED T-Outliner',              price = {18, 30}, quantity = {1, 3} },
        ['pocketcomb']               = { label = 'Pocket Comb',                      price = {18, 30}, quantity = {1, 3} },
        ['neckduster']               = { label = 'Neck Duster',                      price = {18, 30}, quantity = {1, 3} },
        ]]--
    
    },
    
    
    -- Customer Ped Models (Female customers for beauty products)
    CustomerPeds = {
        'a_f_m_beach_01',
        'a_f_m_bevhills_01',
        'a_f_m_bevhills_02',
        'a_f_m_business_02',
        'a_f_m_downtown_01',
        'a_f_m_eastsa_01',
        'a_f_m_eastsa_02',
        'a_f_m_ktown_01',
        'a_f_m_ktown_02',
        'a_f_m_soucent_01',
        'a_f_m_soucent_02',
        'a_f_m_tourist_01',
        'a_f_y_beach_01',
        'a_f_y_bevhills_01',
        'a_f_y_bevhills_02',
        'a_f_y_bevhills_03',
        'a_f_y_bevhills_04',
        'a_f_y_business_01',
        'a_f_y_business_02',
        'a_f_y_business_03',
        'a_f_y_business_04',
        'a_f_y_eastsa_01',
        'a_f_y_eastsa_02',
        'a_f_y_eastsa_03',
        'a_f_y_fitness_01',
        'a_f_y_fitness_02',
        'a_f_y_genhot_01',
        'a_f_y_golfer_01',
        'a_f_y_hiker_01',
        'a_f_y_hippie_01',
        'a_f_y_hipster_01',
        'a_f_y_hipster_02',
        'a_f_y_hipster_03',
        'a_f_y_hipster_04',
        'a_f_y_indian_01',
        'a_f_y_runner_01',
        'a_f_y_scdressy_01',
        'a_f_y_skater_01',
        'a_f_y_soucent_01',
        'a_f_y_soucent_02',
        'a_f_y_soucent_03',
        'a_f_y_tennis_01',
        'a_f_y_tourist_01',
        'a_f_y_tourist_02',
        'a_f_y_vinewood_01',
        'a_f_y_vinewood_02',
        'a_f_y_vinewood_03',
        'a_f_y_vinewood_04',
        'a_f_y_yoga_01'
    },
    
    -- Police Job Names (for minimum police check)
    PoliceJobs = {
        'police',
        'sheriff',
        'state'
    },
    
    -- Animation Settings
    Animations = {
        Player = {
            dict = 'mp_common',
            anim = 'givetake1_a'
        },
        Customer = {
            dict = 'mp_common', 
            anim = 'givetake1_a'
        }
    },

}

-- Blip Configuration
Config.EnableBlips = true
Config.Blips = {
    { title = "Beauty Salon", colour = 8, id = 279, vector3 = vector3(232.01, -1488.55, 29.33) },
}

Config.BossLocations = {
    ["beauty"] = {
        coords = vector3(218.28, -1472.19, 29.7), -- This is near your boss chair, adjust if needed
        job = "beauty" -- Use your actual job name
    }
}

-- Duty Configuration
Config.DutyLocations = {
    ["beauty"] = {
        coords = vector3(221.52, -1474.3, 29.64),
        label = "Clock In/Out",
        job = "beauty"
    }
}

-- ============================================
-- TABLET SYSTEM CONFIGURATION
-- ============================================

Config.Tablet = {
    -- Enable/Disable the tablet system
    Enabled = true,
    
    -- Item name that opens the tablet
    ItemName = 'beauty_tablet',
    
    -- Job settings
    JobName = Config.StoreEmployeeJobs[1], -- Uses same job as store (beauty)
    
    -- Management grades (who can access management features like prices, hiring, finances)
    -- Default: Grade 3 (Manager) and Grade 4 (Boss) can manage
    ManagementGrades = { 3, 4 },
    
    -- Payment destination options:
    -- "society" = All money goes to society account
    -- "employee" = All money goes directly to employee
    -- "split" = Base price to society, tips to employee
    PaymentDestination = "split",
    
    -- Custom charge settings
    CustomChargeEnabled = true,  -- Allow employees to add custom charges
    CustomChargeLimit = 5000,    -- Maximum amount for a single custom charge
    
    -- Tip presets (percentages shown to customer)
    TipPresets = { 10, 15, 20, 25 },
    
    -- Nearby player detection distance (for passing tablet)
    NearbyDistance = 5.0,
    
    -- Transaction expiry time (seconds) - how long customer has to pay
    TransactionTimeout = 300, -- 5 minutes
    
    -- Tablet prop and animation settings
    Prop = {
        model = 'prop_cs_tablet',
        bone = 57005,
        offset = vector3(0.1760, 0.1170, -0.1140),
        rotation = vector3(-155.0, -16.9, 25.0),
    },
    
    Animation = {
        dict = 'amb@world_human_seat_wall_tablet@female@base',
        anim = 'base',
    },
    
    -- Default services that employees can charge for
    -- These can be edited by management through the tablet
    -- id = unique identifier, label = display name, price = default price, category = grouping
    DefaultServices = {
        -- Hair Services
        { id = 'haircut',       label = 'Haircut',           price = 50,   category = 'hair' },
        { id = 'hairstyle',     label = 'Hair Styling',      price = 75,   category = 'hair' },
        { id = 'haircolor',     label = 'Hair Coloring',     price = 100,  category = 'hair' },
        { id = 'highlights',    label = 'Highlights',        price = 150,  category = 'hair' },
        { id = 'treatment',     label = 'Hair Treatment',    price = 80,   category = 'hair' },
        
        -- Nail Services
        { id = 'manicure',      label = 'Manicure',          price = 40,   category = 'nails' },
        { id = 'pedicure',      label = 'Pedicure',          price = 50,   category = 'nails' },
        { id = 'gelpolish',     label = 'Gel Polish',        price = 60,   category = 'nails' },
        { id = 'acrylics',      label = 'Acrylic Nails',     price = 100,  category = 'nails' },
        { id = 'nailart',       label = 'Nail Art',          price = 75,   category = 'nails' },
        
        -- Lash Services
        { id = 'lashbasic',     label = 'Classic Lashes',    price = 80,   category = 'lashes' },
        { id = 'lashfull',      label = 'Full Set Lashes',   price = 150,  category = 'lashes' },
        { id = 'lashfill',      label = 'Lash Fill',         price = 60,   category = 'lashes' },
        
        -- Makeup Services
        { id = 'makeupbasic',   label = 'Basic Makeup',      price = 60,   category = 'makeup' },
        { id = 'makeupfull',    label = 'Full Glam Makeup',  price = 120,  category = 'makeup' },
        
        -- Packages
        { id = 'pkgbasic',      label = 'Basic Package',     price = 150,  category = 'packages' },
        { id = 'pkgpremium',    label = 'Premium Package',   price = 300,  category = 'packages' },
        { id = 'pkgbridal',     label = 'Bridal Package',    price = 500,  category = 'packages' },
    },
    
    -- Service categories (for UI organization)
    ServiceCategories = {
        { id = 'hair',     label = 'Hair Services',  icon = 'fa-scissors' },
        { id = 'nails',    label = 'Nail Services',  icon = 'fa-hand-sparkles' },
        { id = 'lashes',   label = 'Lash Services',  icon = 'fa-eye' },
        { id = 'makeup',   label = 'Makeup',         icon = 'fa-palette' },
        { id = 'packages', label = 'Packages',       icon = 'fa-gift' },
    },
}

-- ============================================
-- APPOINTMENTS CONFIGURATION
-- ============================================

Config.Appointments = {
    -- Enable/Disable appointment system
    Enabled = true,
    
    -- How far in advance can appointments be booked (in days)
    BookingDaysAhead = 7,
    
    -- Default slot increment (minutes)
    DefaultSlotIncrement = 30,
    
    -- Deposit settings
    DepositPercent = 20, -- Customer pays 20% deposit when booking
    DepositAccount = "bank", -- "cash" or "bank"
    RefundCutoffHours = 24, -- Full refund if cancelled 24+ hours before
    
    -- Reminder settings
    DefaultReminderMinutes = 30, -- Remind 30 min before appointment

    -- Booking Target (where customers can book appointments)
    BookingTarget = {
        coords = vector3(235.5, -1496.8, 29.5), 
        radius = 1.5,
        icon = "fas fa-calendar-check",
        label = "Book Appointment"
    },
}

-- Store Configuration
Config.Stores = {
    ["beauty"] = {
        basketLocation = vector3(231.79, -1488.79, 28.65),
        checkoutLocation = vector3(231.02, -1483.74, 29.41),
        registerLocations = {
            vector3(229.84, -1483.53, 29.7),
            vector3(231.16, -1484.98, 29.69),
            vector3(236.62, -1496.95, 29.7),
            vector3(235.34, -1495.5, 29.68)
        },
        storeType = 'Grocery', 
        storeName = "Beauty Salon",
        zones = { 
            {
                label = "Shelf 1",
                location = vector3(242.7, -1489.47, 29.44),
                items = {
                    { name = "annasui",     label = "Anna Perfume",          price = 500, icon = "fa-solid fa-tag" },
                    { name = "apricotoil",  label = "Apricot Oil",           price = 500, icon = "fa-solid fa-tag" }, 
                    { name = "arganoil",    label = "Argan Oil",             price = 500, icon = "fa-solid fa-tag" },
                    { name = "ecoblack",    label = "Black Styling Gel",     price = 500, icon = "fa-solid fa-tag" },
                    { name = "ecoblue",     label = "Blue Styling Gel",      price = 500, icon = "fa-solid fa-tag" },
                    { name = "ecobrown",    label = "Brown Styling Gel",     price = 500, icon = "fa-solid fa-tag" },
                    { name = "ecored",      label = "Red Styling Gel",       price = 500, icon = "fa-solid fa-tag" },
                    { name = "enameldryer", label = "Nail Enamel Dryer",     price = 500, icon = "fa-solid fa-tag" },
                    { name = "duneperfume", label = "Dune Perfume",          price = 500, icon = "fa-solid fa-tag" },                    
                    { name = "grocomplex",  label = "Gro Complex Hairdress", price = 500, icon = "fa-solid fa-tag" }
                }
            },
            {
                label = "Shelf 2",
                location = vector3(239.48, -1492.46, 29.44),
                items = {
                    { name = "annasui",       label = "Anna Perfume",    price = 500, icon = "fa-solid fa-tag" }, 
                    { name = "duneperfume",   label = "Dune Perfume",    price = 500, icon = "fa-solid fa-tag" },
                    { name = "oliveoilsheen", label = "Olive Oil Sheen", price = 500, icon = "fa-solid fa-tag" },
                    { name = "sheenspray",    label = "Sheen Spray",     price = 500, icon = "fa-solid fa-tag" }
                }
            },
            -- THE FADE TRAP SUPPLIES
            {
                label = "Shelf 3",
                location = vector3(239.14, -1492.1, 29.42),
                items = {
                    { name = "magicclipbox",       label = "UNOPENED Magic Clip Clippers",   price = 50000, icon = "fa-solid fa-tag" }, 
                    { name = "toutlinerbox",       label = "UNOPENED T-Outliner",            price = 50000, icon = "fa-solid fa-tag" },
                    { name = "gammaergobox",       label = "UNOPENED Gamma + Ergo Clippers", price = 50000, icon = "fa-solid fa-tag" },
                    { name = "instincttrimmerbox", label = "UNOPENED Instinct Trimmer",      price = 50000, icon = "fa-solid fa-tag" },
                    { name = "goldfxbox",          label = "UNOPENED Gold FX Clippers",      price = 50000, icon = "fa-solid fa-tag" },
                    { name = "pocketcomb",         label = "Pocket Comb",               price = 20000, icon = "fa-solid fa-tag" },
                    { name = "neckduster",         label = "Neck Duster",               price = 20000, icon = "fa-solid fa-tag" },
                }
            },
            {
                label = "Shelf 4",
                location = vector3(242.37, -1489.11, 29.43),
                items = {
                    { name = "faceprimer", label = "Face Primer", price = 500, icon = "fa-solid fa-tag" },
                    { name = "pediscrub",  label = "Pedi Scrub",  price = 500, icon = "fa-solid fa-tag" },
                    { name = "pedisoft",   label = "Pedi Soft",   price = 500, icon = "fa-solid fa-tag" }
                }
            },
            {
                label = "Shelf 5",
                location = vector3(241.05, -1487.72, 29.43),
                items = {
                    { name = "curlshampoo",       label = "Curl Shampoo",          price = 500, icon = "fa-solid fa-tag" },
                    { name = "castoroil",         label = "Castor Oil",            price = 500, icon = "fa-solid fa-tag" },
                    { name = "masque",            label = "Masque",                price = 500, icon = "fa-solid fa-tag" },
                    { name = "moisturizer",       label = "Moisturizer",           price = 500, icon = "fa-solid fa-tag" },
                    { name = "apricotoil",        label = "Apricot Oil",           price = 500, icon = "fa-solid fa-tag" },
                    { name = "grocomplex",        label = "Gro Complex Hairdress", price = 500, icon = "fa-solid fa-tag" },
                    { name = "restoringsmoothie", label = "Restoring Smoothie",    price = 500, icon = "fa-solid fa-tag" },
                    { name = "hairserum",         label = "Hair Serum",            price = 500, icon = "fa-solid fa-tag" },
                    { name = "curlingcream",      label = "Curling Cream",         price = 500, icon = "fa-solid fa-tag" },
                    { name = "activatorcream",    label = "Curl Activator Cream",  price = 500, icon = "fa-solid fa-tag" },
                    { name = "oliveoilsheen",     label = "Olive Oil Sheen",       price = 500, icon = "fa-solid fa-tag" },
                    { name = "sheenspray",        label = "Sheen Spray",           price = 500, icon = "fa-solid fa-tag" }
                }
            },
            -- THE FADE TRAP SUPPLIES
            {
                label = "Shelf 6",
                location = vector3(237.84, -1490.7, 29.43),
                items = {
                    { name = "magicclipbox",       label = "UNOPENED Magic Clip Clippers",   price = 50000, icon = "fa-solid fa-tag" }, 
                    { name = "toutlinerbox",       label = "UNOPENED T-Outliner",            price = 50000, icon = "fa-solid fa-tag" },
                    { name = "gammaergobox",       label = "UNOPENED Gamma + Ergo Clippers", price = 50000, icon = "fa-solid fa-tag" },
                    { name = "instincttrimmerbox", label = "UNOPENED Instinct Trimmer",      price = 50000, icon = "fa-solid fa-tag" },
                    { name = "goldfxbox",          label = "UNOPENED Gold FX Clippers",      price = 50000, icon = "fa-solid fa-tag" },
                    { name = "pocketcomb",         label = "Pocket Comb",               price = 20000, icon = "fa-solid fa-tag" },
                    { name = "neckduster",         label = "Neck Duster",               price = 20000, icon = "fa-solid fa-tag" },
                }
            },
            {
                label = "Shelf 7",
                location = vector3(237.5, -1490.34, 29.43),
                items = {
                    { name = "foambodywash",      label = "Foaming Body Wash",       price = 500, icon = "fa-solid fa-tag" }, 
                    { name = "hairgrease",        label = "Blue Hair Grease",        price = 500, icon = "fa-solid fa-tag" },
                    { name = "thermalwater",      label = "Probiotic Thermal Water", price = 500, icon = "fa-solid fa-tag" },
                    { name = "menshampoo",        label = "Mens Shampoo",            price = 500, icon = "fa-solid fa-tag" }, 
                    { name = "nailpolishremover", label = "Nail Polish Remover",     price = 500, icon = "fa-solid fa-tag" },
                    { name = "conditioner",       label = "Conditioner",             price = 500, icon = "fa-solid fa-tag" }
                }
            },
            {
                label = "Shelf 8",
                location = vector3(240.73, -1487.34, 29.43),
                items = {
                    { name = "annasui",       label = "Anna Perfume",    price = 500, icon = "fa-solid fa-tag" },
                    { name = "duneperfume",   label = "Dune Perfume",    price = 500, icon = "fa-solid fa-tag" },
                    { name = "oliveoilsheen", label = "Olive Oil Sheen", price = 500, icon = "fa-solid fa-tag" }, 
                    { name = "sheenspray",    label = "Sheen Spray",     price = 500, icon = "fa-solid fa-tag" }
                }
            },
            {
                label = "Shelf 9",
                location = vector3(239.4, -1485.9, 29.43),
                items = {
                    { name = "annasui",     label = "Anna Perfume",          price = 500, icon = "fa-solid fa-tag" },
                    { name = "duneperfume", label = "Dune Perfume",          price = 500, icon = "fa-solid fa-tag" },
                    { name = "apricotoil",  label = "Apricot Oil",           price = 500, icon = "fa-solid fa-tag" }, 
                    { name = "grocomplex",  label = "Gro Complex Hairdress", price = 500, icon = "fa-solid fa-tag" },
                    { name = "ecoblack",    label = "Black Styling Gel",     price = 500, icon = "fa-solid fa-tag" },
                    { name = "ecoblue",     label = "Blue Styling Gel",      price = 500, icon = "fa-solid fa-tag" },
                    { name = "ecored",      label = "Red Styling Gel",       price = 500, icon = "fa-solid fa-tag" },
                    { name = "arganoil",    label = "Argan Oil",             price = 500, icon = "fa-solid fa-tag" },
                    { name = "ecobrown",    label = "Brown Styling Gel",     price = 500, icon = "fa-solid fa-tag" },
                    { name = "enameldryer", label = "Nail Enamel Dryer",     price = 500, icon = "fa-solid fa-tag" }

                }
            },
            {
                label = "Shelf 10",
                location = vector3(236.17, -1488.89, 29.42),
                items = {
                    { name = "curlshampoo",       label = "Curl Shampoo",          price = 500, icon = "fa-solid fa-tag" },
                    { name = "castoroil",         label = "Castor Oil",            price = 500, icon = "fa-solid fa-tag" },
                    { name = "masque",            label = "Masque",                price = 500, icon = "fa-solid fa-tag" }, 
                    { name = "moisturizer",       label = "Moisturizer",           price = 500, icon = "fa-solid fa-tag" },
                    { name = "apricotoil",        label = "Apricot Oil",           price = 500, icon = "fa-solid fa-tag" },
                    { name = "grocomplex",        label = "Gro Complex Hairdress", price = 500, icon = "fa-solid fa-tag" },
                    { name = "restoringsmoothie", label = "Restoring Smoothie",    price = 500, icon = "fa-solid fa-tag" }, 
                    { name = "hairserum",         label = "Hair Serum",            price = 500, icon = "fa-solid fa-tag" },
                    { name = "curlingcream",      label = "Curling Cream",         price = 500, icon = "fa-solid fa-tag" },
                    { name = "activatorcream",    label = "Curl Activator Cream",  price = 500, icon = "fa-solid fa-tag" },
                    { name = "oliveoilsheen",     label = "Olive Oil Sheen",       price = 500, icon = "fa-solid fa-tag" }, 
                    { name = "sheenspray",        label = "Sheen Spray",           price = 500, icon = "fa-solid fa-tag" }
                }
            },
            {
                label = "Shelf 11",
                location = vector3(235.84, -1488.53, 29.43),
                items = {
                    { name = "foambodywash",      label = "Foaming Body Wash",       price = 500, icon = "fa-solid fa-tag" }, 
                    { name = "hairgrease",        label = "Blue Hair Grease",        price = 500, icon = "fa-solid fa-tag" },
                    { name = "thermalwater",      label = "Probiotic Thermal Water", price = 500, icon = "fa-solid fa-tag" },
                    { name = "menshampoo",        label = "Mens Shampoo",            price = 500, icon = "fa-solid fa-tag" }, 
                    { name = "nailpolishremover", label = "Nail Polish Remover",     price = 500, icon = "fa-solid fa-tag" },
                    { name = "conditioner",       label = "Conditioner",             price = 500, icon = "fa-solid fa-tag" }
                }
            },
            {
                label = "Shelf 12",
                location = vector3(239.06, -1485.54, 29.42),
                items = {
                    { name = "faceprimer", label = "Face Primer", price = 500, icon = "fa-solid fa-tag" },
                    { name = "pediscrub",  label = "Pedi Scrub",  price = 500, icon = "fa-solid fa-tag" },
                    { name = "pedisoft",   label = "Pedi Soft",   price = 500, icon = "fa-solid fa-tag" }
                }
            },
            {
                label = "Shelf 13",
                location = vector3(239.4, -1495.01, 29.56),
                items = {
                    { name = "mascara",       label = "Mascara",        price = 500, icon = "fa-solid fa-tag" }, 
                    { name = "settingpowder", label = "Setting Powder", price = 500, icon = "fa-solid fa-tag" },
                    { name = "lipstick",      label = "Lipstick",       price = 500, icon = "fa-solid fa-tag" }
                }
            },
            {
                label = "Shelf 14",
                location = vector3(237.64, -1494.65, 29.48),
                items = {
                    { name = "faceprimer",      label = "Face Primer",       price = 500, icon = "fa-solid fa-tag" },
                    { name = "hommestylinggel", label = "Homme Styling Gel", price = 500, icon = "fa-solid fa-tag" },
                    { name = "lipset",          label = "Lip Set",           price = 500, icon = "fa-solid fa-tag" }
                }
            },
            {
                label = "Shelf 15",
                location = vector3(244.35, -1485.52, 29.6),
                items = {
                    { name = "annasui",     label = "Anna Perfume",     price = 500, icon = "fa-solid fa-tag" },
                    { name = "duneperfume", label = "Dune Perfume",     price = 500, icon = "fa-solid fa-tag" },
                    { name = "eyeliner",    label = "Eyeliner",         price = 500, icon = "fa-solid fa-tag" }, 
                    { name = "lipgloss",    label = "Lip Gloss",        price = 500, icon = "fa-solid fa-tag" },
                    { name = "prepnprime",  label = "Prep n Prime",     price = 500, icon = "fa-solid fa-tag" },
                    { name = "brushset",    label = "Makeup Brush Set", price = 500, icon = "fa-solid fa-tag" },
                    { name = "foundation",  label = "Foundation",       price = 500, icon = "fa-solid fa-tag" }
                }
            },
            {
                label = "Shelf 16",
                location = vector3(240.34, -1481.12, 29.71),
                items = {
                    { name = "faceprimer",      label = "Face Primer",       price = 500, icon = "fa-solid fa-tag" },
                    { name = "hommestylinggel", label = "Homme Styling Gel", price = 500, icon = "fa-solid fa-tag" },
                    { name = "lipset",          label = "Lip Set",           price = 500, icon = "fa-solid fa-tag" }
                }
            },
            {
                label = "Shelf 17",
                location = vector3(236.15, -1476.69, 29.68),
                items = {
                    { name = "annasui",               label = "Anna Perfume",            price = 500, icon = "fa-solid fa-tag" },
                    { name = "duneperfume",           label = "Dune Perfume",            price = 500, icon = "fa-solid fa-tag" },
                    { name = "foundationprimer",      label = "Foundation Primer",       price = 500, icon = "fa-solid fa-tag" },
                    { name = "settingspray",          label = "Setting Spray",           price = 500, icon = "fa-solid fa-tag" },
                    { name = "lightliquidfoundation", label = "Light Liquid Foundation", price = 500, icon = "fa-solid fa-tag" },
                    { name = "brownliquidfoundation", label = "Brown Liquid Foundation", price = 500, icon = "fa-solid fa-tag" },
                    { name = "brushset",              label = "Makeup Brush Set",        price = 500, icon = "fa-solid fa-tag" },
                    { name = "foundation",            label = "Foundation",              price = 500, icon = "fa-solid fa-tag" } 
                }
            },
            {
                label = "Shelf 18",
                location = vector3(234.73, -1475.31, 29.65),
                items = {
                    { name = "concealer",    label = "Concealer",     price = 500, icon = "fa-solid fa-tag" }, 
                    { name = "blushpalette", label = "Blush Palette", price = 500, icon = "fa-solid fa-tag" }
                }
            },
            {
                label = "Shelf 19",
                location = vector3(232.99, -1475.03, 29.47),
                items = {
                    { name = "eyelinerpencil",   label = "Eyeliner Pencil",    price = 500, icon = "fa-solid fa-tag" }, 
                    { name = "eyeshadowpalette", label = "Eye Shadow Palette", price = 500, icon = "fa-solid fa-tag" }

                }
            },
            {
                label = "Shelf 20",
                location = vector3(231.66, -1476.31, 29.46),
                items = {
                    { name = "brushset",        label = "Makeup Brush Set",  price = 500, icon = "fa-solid fa-tag" },
                    { name = "powdereyeshadow", label = "Powder Eye Shadow", price = 500, icon = "fa-solid fa-tag" }
                }
            },
            {
                label = "Shelf 21",
                location = vector3(229.35, -1478.74, 29.58),
                items = {
                    { name = "dyebrush", label = "Dye Brush",  price = 500, icon = "fa-solid fa-tag" },
                    { name = "flexirod", label = "Flexi Rods", price = 500, icon = "fa-solid fa-tag" },
                    { name = "durag",    label = "Durag",      price = 500, icon = "fa-solid fa-tag" }, 
                    { name = "bonnet",   label = "Bonnet",     price = 500, icon = "fa-solid fa-tag" }
                }
            }
            --[[{
                label = "Shelf 22",
                location = vector3(233.89, -1481.29, 29.11),
                items = {
                    { name = "", label = "", price = 500, icon = "fa-solid fa-tag" },
                    { name = "", label = "", price = 500, icon = "fa-solid fa-tag" },
                    { name = "", label = "", price = 500, icon = "fa-solid fa-tag" }, 
                    { name = "", label = "", price = 500, icon = "fa-solid fa-tag" }
                }
            }--]]
        }
    }
}

-- Salon Configuration
Config.SalonSections = {
    HairChair = {
        stations = {
            [1] = {
                client = {
                    targetCoords = vector3(228.3, -1500.48, 28.94),
                    playerCoords = vector3(228.33, -1500.42, 28.4),
                    heading = 315.07,
                    animDict = "dc@salonchairsit",
                    animName = "salonchairsit_clip",
                    returnCoords = vector4(228.0, -1500.0, 29.0, 319.30)
                },
            },
            [2] = {
                client = {
                    targetCoords = vector3(224.25, -1495.98, 28.92),
                    playerCoords = vector3(224.25, -1495.98, 28.4),
                    heading = 315.07,
                    animDict = "dc@salonchairsit",
                    animName = "salonchairsit_clip",
                    returnCoords = vector4(223.67, -1496.56, 29.39, 134.73)
                },
            },
            [3] = {
                client = {
                    targetCoords = vector3(220.17, -1491.64, 28.91),
                    playerCoords = vector3(220.17, -1491.64, 28.4),
                    heading = 315.07,
                    animDict = "dc@salonchairsit",
                    animName = "salonchairsit_clip",
                    returnCoords = vector4(219.65, -1492.17, 29.37, 136.42)
                },
            }
        }
    },
    NailChair = {
        stations = {
            [1] = {
                client = {
                    targetCoords = vector3(226.93, -1493.79, 29.0),
                    playerCoords = vector3(226.96, -1493.74, 28.5),
                    heading = 224.02249145508,
                    animDict = "dc@manicure",
                    animName = "manicure_clip",
                    returnCoords = vector4(226.67292785645, -1494.6143798828, 29.327373504639, 170.50720214844)
                },
                employee = {
                    targetCoords = vector3(226.06, -1492.87, 29.04),
                    playerCoords = vector3(226.19, -1492.98, 28.4),
                    heading = 44.713272094727,
                    animDict = "dc@paintnails",
                    animName = "paintnails_clip",
                    returnCoords = vector4(225.36427307129, -1493.2589111328, 29.327123641968, 132.77784729004)
                }
            },
			[2] = {
                 client = {
                     targetCoords = vector3(229.03, -1491.85, 29.0),
                     playerCoords = vector3(229.03, -1491.85, 28.5),
                     heading = 224.02249145508,
                     animDict = "dc@manicure",
                     animName = "manicure_clip",
                     returnCoords = vector4(228.42860412598, -1492.3973388672, 29.326942443848, 224.48881530762)
                 },
                 employee = {
                     targetCoords = vector3(228.25, -1491.11, 29.04),
                     playerCoords = vector3(228.25, -1491.11, 28.4),
                     heading = 44.713272094727,
                     animDict = "dc@paintnails",
                     animName = "paintnails_clip",
                     returnCoords = vector4(228.54493713379, -1490.3170166016, 29.326570510864, 308.9880065918)
                 }
            },
			[3] = {
                client = {
                    targetCoords = vector3(226.03, -1488.71, 29.0),
                    playerCoords = vector3(226.03, -1488.71, 28.5),
                    heading = 44.713272094727,
                    animDict = "dc@manicure",
                    animName = "manicure_clip",
                    returnCoords = vector4(226.56698608398, -1488.0350341797, 29.326284408569, 333.14038085938)
                },
                employee = {
                    targetCoords = vector3(226.78, -1489.4, 29.04),
                    playerCoords = vector3(226.78, -1489.4, 28.4),
                    heading = 224.02249145508,
                    animDict = "dc@paintnails",
                    animName = "paintnails_clip",
                    returnCoords = vector4(227.64817810059, -1489.3781738281, 29.326398849487, 311.32345581055)
                }
            },
			[4] = {
                client = {
                    targetCoords = vector3(223.97, -1490.57, 29.0),
                    playerCoords = vector3(223.97, -1490.57, 28.5),
                    heading = 44.713272094727,
                    animDict = "dc@manicure",
                    animName = "manicure_clip",
                    returnCoords = vector4(223.36810302734, -1490.8399658203, 29.326610565186, 133.25074768066)
                },
                employee = {
                    targetCoords = vector3(224.71, -1491.31, 29.04),
                    playerCoords = vector3(224.71, -1491.31, 28.4),
                    heading = 224.02249145508,
                    animDict = "dc@paintnails",
                    animName = "paintnails_clip",
                    returnCoords = vector4(224.29461669922, -1492.5020751953, 29.326929092407, 133.17335510254)
                }
            }
        }
    },
    HairWashChair = {
        stations = {
            [1] = {
                client = {
                    targetCoords = vector3(226.65, -1498.59, 28.86),
                    playerCoords = vector3(226.45, -1498.71, 28.4),
                    heading = 135.69429016113,
                    animDict = "dc@shampoosit",
                    animName = "shampoosit_clip",
                    returnCoords = vector4(226.95079040527, -1498.2271728516, 29.380102157593, 319.30633544922)
                },
                employee = {
                    targetCoords = vector3(226.29, -1499.21, 29.5),
                    playerCoords = vector3(226.59, -1499.37, 28.37),
                    heading = 222.48,
                    animDict = "dc@shampoostand",
                    animName = "shampoostand_clip",
                    returnCoords = vector4(226.39, -1499.57, 28.37, 37.0)
                }
            },
            [2] = {
                client = {
                    targetCoords = vector3(225.77, -1497.94, 28.86),
                    playerCoords = vector3(225.79, -1497.98, 28.4),
                    heading = 135.69429016113,
                    animDict = "dc@shampoosit",
                    animName = "shampoosit_clip",
                    returnCoords = vector4(226.44459533691, -1497.3002929688, 29.33203125, 315.79806518555)
                },
                employee = {
                    targetCoords = vector3(225.18, -1498.3, 29.54),
                    playerCoords = vector3(224.96, -1498.0, 28.37),
                    heading = 37.0,
                    animDict = "dc@shampoostand",
                    animName = "shampoostand_clip",
                    returnCoords = vector4(224.86, -1497.9, 28.37, 222.48)
                },
            },
            [3] = {
                client = {
                    targetCoords = vector3(222.1, -1494.04, 28.86),
                    playerCoords = vector3(222.1, -1494.04, 28.4),
                    heading = 135.69429016113,
                    animDict = "dc@shampoosit",
                    animName = "shampoosit_clip",
                    returnCoords = vector4(222.81625366211, -1493.4017333984, 29.327075958252, 315.4118347168)
                },
                employee = {
                    targetCoords = vector3(221.81, -1494.5, 29.48),
                    playerCoords = vector3(222.19, -1494.66, 28.36),
                    heading = 219.12,
                    animDict = "dc@shampoostand",
                    animName = "shampoostand_clip",
                    returnCoords = vector4(222.14, -1494.86, 28.36, 36.53)
                },
            },
            [4] = {
                client = {
                    targetCoords = vector3(221.41, -1493.27, 28.86),
                    playerCoords = vector3(221.41, -1493.27, 28.4),
                    heading = 135.69429016113,
                    animDict = "dc@shampoosit",
                    animName = "shampoosit_clip",
                    returnCoords = vector4(222.11706542969, -1492.6374511719, 29.326936721802, 312.02276611328)
                },
                employee = {
                    targetCoords = vector3(220.78, -1493.6, 29.51),
                    playerCoords = vector3(220.59, -1493.39, 28.35),
                    heading = 36.53,
                    animDict = "dc@shampoostand",
                    animName = "shampoostand_clip",
                    returnCoords = vector4(220.44, -1493.19, 28.35, 219.12)
                },
            }
        }
    },
    PedicureChair = {
        stations = {
            [1] = {
                client = {
                    targetCoords = vector3(220.45, -1487.16, 29.04),
                    playerCoords = vector3(220.35, -1487.2, 28.7),
                    heading = 45.471187591553,
                    animDict = "dc@pedchairclient2",
                    animName = "pedchairclient2_clip",
                    returnCoords = vector4(220.80131530762, -1488.7552490234, 29.326286315918, 185.28707885742)
                },
                employee = {
                    targetCoords = vector3(221.32, -1488.05, 28.93),
                    playerCoords = vector3(221.43, -1488.12, 28.4),
                    heading = 228.76783752441,
                    animDict = "dc@pedchairtech",
                    animName = "pedchairtech_clip",
                    returnCoords = vector4(221.91578674316, -1488.4467773438, 29.326290130615, 222.72453308105)
                }
            },
            [2] = {
                client = {
                    targetCoords = vector3(221.61, -1486.08, 29.04),
                    playerCoords = vector3(221.61, -1486.08, 28.7),
                    heading = 45.471187591553,
                    animDict = "dc@pedchairclient2",
                    animName = "pedchairclient2_clip",
                    returnCoords = vector4(221.21446228027, -1486.6810302734, 29.374635696411, 217.97840881348)
                },
                employee = {
                    targetCoords = vector3(222.61, -1487.05, 28.93),
                    playerCoords = vector3(222.61, -1487.05, 28.4),
                    heading = 228.76783752441,
                    animDict = "dc@pedchairtech",
                    animName = "pedchairtech_clip",
                    returnCoords = vector4(222.93334960938, -1487.4285888672, 29.326299667358, 219.93719482422)
                }
            },
            [3] = {
                client = {
                    targetCoords = vector3(222.72, -1485.01, 29.04),
                    playerCoords = vector3(222.72, -1485.01, 28.7),
                    heading = 45.471187591553,
                    animDict = "dc@pedchairclient2",
                    animName = "pedchairclient2_clip",
                    returnCoords = vector4(222.38307189941, -1485.7476806641, 29.374200820923, 219.09735107422)
                },
                employee = {
                    targetCoords = vector3(223.72, -1486.02, 28.93),
                    playerCoords = vector3(223.72, -1486.02, 28.4),
                    heading = 228.76783752441,
                    animDict = "dc@pedchairtech",
                    animName = "pedchairtech_clip",
                    returnCoords = vector4(224.12091064453, -1486.4458007812, 29.326299667358, 218.79623413086)
                }
            },
            [4] = {
                client = {
                    targetCoords = vector3(223.83, -1483.97, 29.04),
                    playerCoords = vector3(223.83, -1483.97, 28.7),
                    heading = 45.471187591553,
                    animDict = "dc@pedchairclient2",
                    animName = "pedchairclient2_clip",
                    returnCoords = vector4(223.74887084961, -1484.8504638672, 29.373399734497, 219.36065673828)
                },
                employee = {
                    targetCoords = vector3(224.83, -1484.96, 28.93),
                    playerCoords = vector3(224.83, -1484.96, 28.4),
                    heading = 228.76783752441,
                    animDict = "dc@pedchairtech",
                    animName = "pedchairtech_clip",
                    returnCoords = vector4(225.1644744873, -1485.3571777344, 29.326307296753, 219.98063659668)
                }
            }
        }
    },
    WaxChair = {
        stations = {
            [1] = {
                client = {
                    targetCoords = vector3(211.0, -1480.3, 29.27),
                    playerCoords = vector3(211.0, -1480.3, 29.1),
                    heading = 45.453598022461,
                    animDict = "dc@facialanim",
                    animName = "facialanim_clip",
                    returnCoords = vector4(211.10757446289, -1481.2670898438, 29.326299667358, 132.95454406738)
                },
                employee = {
                    targetCoords = vector3(211.36, -1479.7, 29.15),
                    playerCoords = vector3(211.36, -1479.7, 28.61),
                    heading = 321.33,
                    animDict = "dc@pedchairtech",
                    animName = "pedchairtech_clip",
                    returnCoords = vector4(211.97, -1479.93, 29.33, 223.48)
                }
            }
        }
    },
    HairDryer = {
        stations = {
            [1] = {
                client = {
                    targetCoords = vector3(229.77, -1487.91, 28.82),
                    playerCoords = vector3(229.77, -1487.91, 28.4),
                    heading = 315.5205078125,
                    animDict = "dc@salonchairsit",
                    animName = "salonchairsit_clip",
                    returnCoords = vector4(229.0396270752, -1488.6135253906, 29.326387405396, 136.19464111328)
                }
            },
            [2] = {
                client = {
                    targetCoords = vector3(228.69, -1486.79, 28.82),
                    playerCoords = vector3(228.69, -1486.79, 28.4),
                    heading = 315.5205078125,
                    animDict = "dc@salonchairsit",
                    animName = "salonchairsit_clip",
                    returnCoords = vector4(228.03453063965, -1487.4598388672, 29.326284408569, 134.95741271973)
                }
            },
            [3] = {
                client = {
                    targetCoords = vector3(227.67, -1485.71, 28.82),
                    playerCoords = vector3(227.67, -1485.71, 28.4),
                    heading = 315.5205078125,
                    animDict = "dc@salonchairsit",
                    animName = "salonchairsit_clip",
                    returnCoords = vector4(226.9593963623, -1486.3392333984, 29.326284408569, 132.22645568848)
                }
            },
            [4] = {
                client = {
                    targetCoords = vector3(226.64, -1484.61, 28.82),
                    playerCoords = vector3(226.64, -1484.61, 28.4),
                    heading = 315.5205078125,
                    animDict = "dc@salonchairsit",
                    animName = "salonchairsit_clip",
                    returnCoords = vector4(226.02104187012, -1485.2447509766, 29.328680038452, 135.64456176758)
                }
            }
        }
    },
    WaitingChair = {
        stations = {
            [1] = {
                client = {
                    targetCoords = vector3(230.7, -1495.38, 28.82),
                    playerCoords = vector3(230.7, -1495.38, 27.83),
                    heading = 315.02,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vector4(231.27, -1495.08, 29.34, 312.27)
                }
            },
            [2] = {
                client = {
                    targetCoords = vector3(231.56, -1496.3, 28.82),
                    playerCoords = vector3(231.56, -1496.3, 27.83),
                    heading = 315.02,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vector4(232.08, -1495.94, 29.33, 311.96)
                }       
            },
            [3] = {
                client = {
                    targetCoords = vector3(232.17, -1496.97, 28.83),
                    playerCoords = vector3(232.17, -1496.97, 27.83),
                    heading = 315.02,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vector4(232.71, -1496.64, 29.34, 308.49)
                }       
            },
            [4] = {
                client = {
                    targetCoords = vector3(233.02, -1497.82, 28.83),
                    playerCoords = vector3(233.02, -1497.82, 27.83),
                    heading = 315.02,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vector4(233.58, -1497.5, 29.33, 306.38)
                }       
            },
            [5] = {
                client = {
                    targetCoords = vector3(229.97, -1496.03, 28.83),
                    playerCoords = vector3(229.97, -1496.03, 27.83),
                    heading = 133.84,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vector4(229.47, -1496.41, 29.34, 133.84)
                }       
            },
            [6] = {
                client = {
                    targetCoords = vector3(230.91, -1497.05, 28.83),
                    playerCoords = vector3(230.91, -1497.05, 27.83),
                    heading = 133.84,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vector4(230.35, -1497.34, 29.33, 124.13)
                }       
            },
            [7] = {
                client = {
                    targetCoords = vector3(231.46, -1497.64, 28.83),
                    playerCoords = vector3(231.46, -1497.64, 27.83),
                    heading = 133.84,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vector4(230.93, -1497.98, 29.34, 129.08)
                }       
            },
            [8] = {
                client = {
                    targetCoords = vector3(232.26, -1498.5, 28.83),
                    playerCoords = vector3(232.26, -1498.5, 27.83),
                    heading = 133.84,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vector4(231.74, -1498.86, 29.34, 132.17)
                }       
            },                        
        }
    },
    LoungeChair = {
        stations = {
            [1] = {
                --[[client = {
                    targetCoords = vector3(227.19, -1478.54, 28.83),
                    playerCoords = vector3(227.19, -1478.54, 27.83),
                    heading = 319.37,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vector4(227.66, -1478.12, 29.33, 319.37)
                },]]--
                employee = {
                    targetCoords = vector3(227.19, -1478.54, 28.83),
                    playerCoords = vector3(227.19, -1478.54, 27.83),
                    heading = 319.37,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vector4(227.66, -1478.12, 29.33, 319.37)
                }
            },
            [2] = {
                --[[client = {
                    targetCoords = vector3(226.53, -1477.84, 28.82),
                    playerCoords = vector3(226.53, -1477.84, 27.83),
                    heading = 319.37,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vector4(227.12, -1477.38, 29.33, 314.44)
                },]]--
                employee = {
                    targetCoords = vector3(226.53, -1477.84, 28.82),
                    playerCoords = vector3(226.53, -1477.84, 27.83),
                    heading = 319.37,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vector4(227.12, -1477.38, 29.33, 314.44)
                }       
            },
            [3] = {
                --[[client = {
                    targetCoords = vector3(225.62, -1476.61, 28.83),
                    playerCoords = vector3(225.62, -1476.61, 27.83),
                    heading = 289.95,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vector4(226.24, -1476.46, 29.34, 290.55)
                },]]--
                employee = {
                    targetCoords = vector3(225.62, -1476.61, 28.83),
                    playerCoords = vector3(225.62, -1476.61, 27.83),
                    heading = 289.95,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vector4(226.24, -1476.46, 29.34, 290.55)
                }       
            },
            [4] = {
                --[[client = {
                    targetCoords = vector3(225.3, -1475.64, 28.83),
                    playerCoords = vector3(225.3, -1475.64, 27.83),
                    heading = 294.58,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vector4(225.9, -1475.45, 29.34, 294.58)
                },]]--
                employee = {
                    targetCoords = vector3(225.3, -1475.64, 28.83),
                    playerCoords = vector3(225.3, -1475.64, 27.83),
                    heading = 294.58,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vector4(225.9, -1475.45, 29.34, 294.58)
                },
            },
        },
    },
    OfficeCouch = {
        stations = {
            [1] = {
                client = {
                    targetCoords = vector3(220.26, -1474.49, 28.83),
                    playerCoords = vector3(220.26, -1474.49, 27.83),
                    heading = 45.84,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vector4(219.86, -1474.0, 29.33, 45.84)
                },
                --[[employee = {
                    targetCoords = vector3(220.26, -1474.49, 28.83),
                    playerCoords = vector3(220.26, -1474.49, 27.83),
                    heading = 45.84,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vector4(219.86, -1474.0, 29.33, 45.84)
                }]]--
            },
            [2] = {
                client = {
                    targetCoords = vector3(221.07, -1473.73, 28.82),
                    playerCoords = vector3(221.07, -1473.73, 27.83),
                    heading = 45.84,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vector4(220.67, -1473.26, 29.33, 39.97)
                },
                --[[employee = {
                    targetCoords = vector3(221.07, -1473.73, 28.82),
                    playerCoords = vector3(221.07, -1473.73, 27.83),
                    heading = 45.84,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vector4(220.67, -1473.26, 29.33, 39.97)
                }]]--
            },
        },
    },
    ClientChair = {
        stations = {
            [1] = {
                client = {
                    targetCoords = vector3(218.45, -1473.25, 28.84),
                    playerCoords = vector3(218.45, -1473.25, 27.83),
                    heading = 50.05,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vector4(220.67, -1473.26, 29.33, 39.97)
                }
            },    
            [2] = {
                client = {
                    targetCoords = vector3(219.12, -1472.72, 28.84),
                    playerCoords = vector3(219.12, -1472.72, 27.83),
                    heading = 50.05,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vector4(218.76, -1472.3, 29.34, 44.81)
                },         
            },
        },
    },
    BossChair = {
        stations = {
            [1] = {
                employee = {
                targetCoords = vector3(217.91, -1471.74, 28.83),
                playerCoords = vector3(217.71, -1471.54, 27.93),
                heading = 227.01,
                animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                animName = "base",
                returnCoords = vector4(218.16, -1470.98, 29.33, 302.81)
                },       
            },
        },
    },
 }

 -- Stash and Clothing Locker Configuration
 Config.StashLocations = {
    ["beauty"] = {
        { 
            label = "Storage Room",
            coords = vector3(221.79, -1482.73, 29.33),
            job = "beauty",  -- Job required to access this stash
            stashName = "beauty1storage",
            stashWeight = 100000,  -- Weight limit in grams
            stashSlots = 50        -- Number of inventory slots
        },
        { 
            label = "Refrigerator",
            coords = vector3(225.2, -1471.47, 29.33),
            job = "beauty",
            stashName = "beauty2storage",
            stashWeight = 100000,
            stashSlots = 50
        }
    }
 }
 
 Config.ClothingLockers = {
    ["beauty"] = {
        label = "Staff Changing Lockers",
        coords = vector3(223.95, -1479.09, 29.33),
        job = "beauty"  -- Job required to access the locker
    }
 }
 
  -- Shop Props Configuration
 Config.ShopProps = {
    ["beauty"] = {
        {
            model = "yng_basketstack",
            coords = vector3(232.09, -1488.54, 28.33),
            heading = 313.0, -- Adjust this heading value as needed
            frozen = true  -- Whether the prop should be frozen in place
        }
        -- You can add more props here as needed
    }

 }