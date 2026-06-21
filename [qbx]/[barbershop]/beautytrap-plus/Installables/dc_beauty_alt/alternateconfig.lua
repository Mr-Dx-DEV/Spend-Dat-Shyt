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
    System = "auto", -- Options: "qb-management", "qb-banking", "okokBanking", "renewed-banking", esx_society, "auto"
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
        ['pocketcomb']               = { label = 'Pocket Comb',                 price = {18, 30}, quantity = {1, 3} },
        ['neckduster']               = { label = 'Neck Duster',                 price = {18, 30}, quantity = {1, 3} },
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
    { title = "Beauty Salon", colour = 8, id = 279, vector3 = vector3(-1537.76, -406.91, 35.71) },
}

Config.BossLocations = {
    ["beauty"] = {
        coords = vector3(-1554.9, -394.5, 36.1), -- This is near your boss chair, adjust if needed
        job = "beauty" -- Use your actual job name
    }
}

-- Duty Configuration
Config.DutyLocations = {
    ["beauty"] = {
        coords = vector3(-1551.5, -396.29, 36.06),
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
        basketLocation = vector3(-1539.56, -409.5, 35.11),
        checkoutLocation = vector3(-1540.96, -404.52, 35.73),
        registerLocations = {
            vector3(-1542.23, -404.47, 36.07),
            vector3(-1540.72, -405.73, 36.07),
            vector3(-1535.32, -415.76, 36.06),
            vector3(-1533.81, -417.04, 36.05)
        },
        storeType = 'Grocery', 
        storeName = "Beauty Salon",
        zones = { 
            {
                label = "Shelf 1",
                location = vector3(-1528.68, -408.9, 35.79),
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
                location = vector3(-1531.54, -412.22, 35.79),
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
                location = vector3(-1531.91, -411.91, 35.79),
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
                location = vector3(-1529.05, -408.57, 35.8),
                items = {
                    { name = "faceprimer", label = "Face Primer", price = 500, icon = "fa-solid fa-tag" },
                    { name = "pediscrub",  label = "Pedi Scrub",  price = 500, icon = "fa-solid fa-tag" },
                    { name = "pedisoft",   label = "Pedi Soft",   price = 500, icon = "fa-solid fa-tag" }
                }
            },
            {
                label = "Shelf 5",
                location = vector3(-1530.52, -407.33, 35.8),
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
                location = vector3(-1533.37, -410.67, 35.79),
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
                location = vector3(-1533.74, -410.34, 35.81),
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
                location = vector3(-1530.89, -407.01, 35.8),
                items = {
                    { name = "annasui",       label = "Anna Perfume",    price = 500, icon = "fa-solid fa-tag" },
                    { name = "duneperfume",   label = "Dune Perfume",    price = 500, icon = "fa-solid fa-tag" },
                    { name = "oliveoilsheen", label = "Olive Oil Sheen", price = 500, icon = "fa-solid fa-tag" }, 
                    { name = "sheenspray",    label = "Sheen Spray",     price = 500, icon = "fa-solid fa-tag" }
                }
            },
            {
                label = "Shelf 9",
                location = vector3(-1532.38, -405.73, 35.81),
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
                location = vector3(-1535.24, -409.06, 35.8),
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
                location = vector3(-1535.61, -408.74, 35.81),
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
                location = vector3(-1532.74, -405.4, 35.8),
                items = {
                    { name = "faceprimer", label = "Face Primer", price = 500, icon = "fa-solid fa-tag" },
                    { name = "pediscrub",  label = "Pedi Scrub",  price = 500, icon = "fa-solid fa-tag" },
                    { name = "pedisoft",   label = "Pedi Soft",   price = 500, icon = "fa-solid fa-tag" }
                }
            },
            {
                label = "Shelf 13",
                location = vector3(-1531.3, -414.74, 35.92),
                items = {
                    { name = "mascara",       label = "Mascara",        price = 500, icon = "fa-solid fa-tag" }, 
                    { name = "settingpowder", label = "Setting Powder", price = 500, icon = "fa-solid fa-tag" },
                    { name = "lipstick",      label = "Lipstick",       price = 500, icon = "fa-solid fa-tag" }
                }
            },
            {
                label = "Shelf 14",
                location = vector3(-1533.09, -414.64, 35.83),
                items = {
                    { name = "faceprimer",      label = "Face Primer",       price = 500, icon = "fa-solid fa-tag" },
                    { name = "hommestylinggel", label = "Homme Styling Gel", price = 500, icon = "fa-solid fa-tag" },
                    { name = "lipset",          label = "Lip Set",           price = 500, icon = "fa-solid fa-tag" }
                }
            },
            {
                label = "Shelf 15",
                location = vector3(-1527.54, -404.75, 35.92),
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
                location = vector3(-1532.04, -400.81, 35.87),
                items = {
                    { name = "faceprimer",      label = "Face Primer",       price = 500, icon = "fa-solid fa-tag" },
                    { name = "hommestylinggel", label = "Homme Styling Gel", price = 500, icon = "fa-solid fa-tag" },
                    { name = "lipset",          label = "Lip Set",           price = 500, icon = "fa-solid fa-tag" }
                }
            },
            {
                label = "Shelf 17",
                location = vector3(-1536.73, -396.88, 35.9),
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
                location = vector3(-1538.25, -395.71, 35.85),
                items = {
                    { name = "concealer",    label = "Concealer",     price = 500, icon = "fa-solid fa-tag" }, 
                    { name = "blushpalette", label = "Blush Palette", price = 500, icon = "fa-solid fa-tag" }
                }
            },
            {
                label = "Shelf 19",
                location = vector3(-1539.92, -395.71, 35.81),
                items = {
                    { name = "eyelinerpencil",   label = "Eyeliner Pencil",    price = 500, icon = "fa-solid fa-tag" }, 
                    { name = "eyeshadowpalette", label = "Eye Shadow Palette", price = 500, icon = "fa-solid fa-tag" }

                }
            },
            {
                label = "Shelf 20",
                location = vector3(-1541.14, -397.13, 35.77),
                items = {
                    { name = "brushset",        label = "Makeup Brush Set",  price = 500, icon = "fa-solid fa-tag" },
                    { name = "powdereyeshadow", label = "Powder Eye Shadow", price = 500, icon = "fa-solid fa-tag" }
                }
            },
            {
                label = "Shelf 21",
                location = vector3(-1543.16, -399.74, 36.0),
                items = {
                    { name = "dyebrush", label = "Dye Brush",  price = 500, icon = "fa-solid fa-tag" },
                    { name = "flexirod", label = "Flexi Rods", price = 500, icon = "fa-solid fa-tag" },
                    { name = "durag",    label = "Durag",      price = 500, icon = "fa-solid fa-tag" }, 
                    { name = "bonnet",   label = "Bonnet",     price = 500, icon = "fa-solid fa-tag" }
                }
            }
            --[[{
                label = "Shelf 22",
                location = vector3(-1538.36, -401.78, 35.3),
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
                    targetCoords = vector3(-1541.8, -421.49, 35.31),
                    playerCoords = vector3(-1541.72, -421.43, 34.87),
                    heading = 315.07,
                    animDict = "dc@salonchairsit",
                    animName = "salonchairsit_clip",
                    returnCoords = vector4(-1540.8181152344, -422.09796142578, 35.691589355469, 230.79997253418)
                },
            },
            [2] = {
                client = {
                    targetCoords = vector3(-1546.3, -417.51, 35.31),
                    playerCoords = vector3(-1546.3, -417.51, 34.87),
                    heading = 315.07,
                    animDict = "dc@salonchairsit",
                    animName = "salonchairsit_clip",
                    returnCoords = vector4(-1546.7218017578, -417.99923706055, 35.775188446045, 143.37586975098)
                },
            },
            [3] = {
                client = {
                    targetCoords = vector3(-1550.84, -413.65, 35.3),
                    playerCoords = vector3(-1550.84, -413.65, 34.87),
                    heading = 315.07,
                    animDict = "dc@salonchairsit",
                    animName = "salonchairsit_clip",
                    returnCoords = vector4(-1551.2845458984, -414.05780029297, 35.769786834717, 140.40194702148)
                },
            }
        }
    },
    NailChair = {
        stations = {
            [1] = {
                client = {
                    targetCoords = vector3(-1543.97, -414.85, 35.39),
                    playerCoords = vector3(-1543.87, -414.9, 34.90),
                    heading = 224.02249145508,
                    animDict = "dc@manicure",
                    animName = "manicure_clip",
                    returnCoords = vector4(-1544.0627441406, -415.8232421875, 35.707977294922, 174.56912231445)
                },
                employee = {
                    targetCoords = vector3(-1544.68, -414.26, 35.43),
                    playerCoords = vector3(-1544.68, -414.26, 34.9),
                    heading = 44.713272094727,
                    animDict = "dc@paintnails",
                    animName = "paintnails_clip",
                    returnCoords = vector4(-1545.5111083984, -414.60110473633, 35.711494445801, 141.21438598633)
                }
            },
            [2] = {
                client = {
                    targetCoords = vector3(-1542.11, -412.79, 35.41),
                    playerCoords = vector3(-1542.08, -412.82, 34.9),
                    heading = 224.02249145508,
                    animDict = "dc@manicure",
                    animName = "manicure_clip",
                    returnCoords = vector4(-1542.0601806641, -413.7424621582, 35.707653045654, 234.5267791748)
                },
                employee = {
                    targetCoords = vector3(-1542.86, -412.16, 35.46),
                    playerCoords = vector3(-1542.86, -412.16, 34.9),
                    heading = 44.713272094727,
                    animDict = "dc@paintnails",
                    animName = "paintnails_clip",
                    returnCoords = vector4(-1542.6358642578, -411.40536499023, 35.711280822754, 324.12963867188)
                }
            },
            [3] = {
                client = {
                    targetCoords = vector3(-1545.24, -410.04, 35.42),
                    playerCoords = vector3(-1545.24, -410.04, 34.9),
                    heading = 44.713272094727,
                    animDict = "dc@manicure",
                    animName = "manicure_clip",
                    returnCoords = vector4(-1544.9456787109, -409.30267333984, 35.717235565186, 11.03333568573)
                },
                employee = {
                    targetCoords = vector3(-1544.51, -410.66, 35.46),
                    playerCoords = vector3(-1544.51, -410.66, 34.9),
                    heading = 224.02249145508,
                    animDict = "dc@paintnails",
                    animName = "paintnails_clip",
                    returnCoords = vector4(-1543.6202392578, -410.57028198242, 35.713680267334, 327.59164428711)
                }
            },
            [4] = {
                client = {
                    targetCoords = vector3(-1547.07, -412.17, 35.41),
                    playerCoords = vector3(-1547.07, -412.17, 34.9),
                    heading = 44.713272094727,
                    animDict = "dc@manicure",
                    animName = "manicure_clip",
                    returnCoords = vector4(-1547.69921875, -412.48907470703, 35.717124938965, 120.03057098389)
                },
                employee = {
                    targetCoords = vector3(-1546.33, -412.77, 35.45),
                    playerCoords = vector3(-1546.33, -412.77, 34.9),
                    heading = 224.02249145508,
                    animDict = "dc@paintnails",
                    animName = "paintnails_clip",
                    returnCoords = vector4(-1546.5589599609, -414.03414916992, 35.713672637939, 155.87533569336)
                }
            }
        }
    },
    HairWashChair = {
        stations = {
            [1] = {
                client = {
                    targetCoords = vector3(-1543.65, -419.86, 35.23),
                    playerCoords = vector3(-1543.65, -419.86, 34.8),
                    heading = 135.69429016113,
                    animDict = "dc@shampoosit",
                    animName = "shampoosit_clip",
                    returnCoords = vector4(-1543.0802001953, -419.1364440918, 35.702644348145, 322.2141418457)
                },
                employee = {
                    targetCoords = vector3(-1543.99, -420.44, 35.89),
                    playerCoords = vector3(-1543.68, -420.6, 34.75),
                    heading = 228.52,
                    animDict = "dc@shampoostand",
                    animName = "shampoostand_clip",
                    returnCoords = vector4(-1543.68, -420.8, 34.75, 52.11)
                }
            },
            [2] = {
                client = {
                    targetCoords = vector3(-1544.45, -419.25, 35.24),
                    playerCoords = vector3(-1544.45, -419.25, 34.8),
                    heading = 135.69429016113,
                    animDict = "dc@shampoosit",
                    animName = "shampoosit_clip",
                    returnCoords = vector4(-1543.912109375, -418.55883789062, 35.705062866211, 321.18447875977)
                },
                employee = {
                    targetCoords = vector3(-1545.05, -419.68, 35.91),
                    playerCoords = vector3(-1545.35, -419.49, 34.74),
                    heading = 52.11,
                    animDict = "dc@shampoostand",
                    animName = "shampoostand_clip",
                    returnCoords = vector4(-1545.35, -419.39, 34.74, 228.52)
                },
            },
            [3] = {
                client = {
                    targetCoords = vector3(-1548.57, -415.73, 35.22),
                    playerCoords = vector3(-1548.57, -415.73, 34.8),
                    heading = 135.69429016113,
                    animDict = "dc@shampoosit",
                    animName = "shampoosit_clip",
                    returnCoords = vector4(-1547.9638671875, -415.09872436523, 35.715705871582, 323.07391357422)
                },
                employee = {
                    targetCoords = vector3(-1548.88, -416.27, 35.87),
                    playerCoords = vector3(-1548.38, -416.48, 34.74),
                    heading = 228.52,
                    animDict = "dc@shampoostand",
                    animName = "shampoostand_clip",
                    returnCoords = vector4(-1548.58, -416.63, 34.74, 52.11)
                },
            },
            [4] = {
                client = {
                    targetCoords = vector3(-1549.36, -415.09, 35.22),
                    playerCoords = vector3(-1549.36, -415.09, 34.8),
                    heading = 135.69429016113,
                    animDict = "dc@shampoosit",
                    animName = "shampoosit_clip",
                    returnCoords = vector4(-1548.810546875, -414.34625244141, 35.716442108154, 320.25741577148)
                },
                employee = {
                    targetCoords = vector3(-1549.86, -415.48, 35.88),
                    playerCoords = vector3(-1550.25, -415.3, 34.74),
                    heading = 52.11,
                    animDict = "dc@shampoostand",
                    animName = "shampoostand_clip",
                    returnCoords = vector4(-1550.25, -415.2, 34.74, 228.52)
                },
            }
        }
    },
    PedicureChair = {
        stations = {
            [1] = {
                client = {
                    targetCoords = vector3(-1547.96, -405.61, 35.44),
                    playerCoords = vector3(-1548.12, -405.53, 35.0),
                    heading = 45.471187591553,
                    animDict = "dc@pedchairclient2",
                    animName = "pedchairclient2_clip",
                    returnCoords = vector4(-1548.1339111328, -406.51754760742, 35.773002624512, 234.11026000977)
                },
                employee = {
                    targetCoords = vector3(-1547.04, -406.37, 35.33),
                    playerCoords = vector3(-1547.04, -406.37, 34.8),
                    heading = 228.76783752441,
                    animDict = "dc@pedchairtech",
                    animName = "pedchairtech_clip",
                    returnCoords = vector4(-1546.5191650391, -406.84262084961, 35.722854614258, 233.04510498047)
                }
            },
            [2] = {
                client = {
                    targetCoords = vector3(-1549.09, -406.69, 35.44),
                    playerCoords = vector3(-1549.09, -406.69, 35.0),
                    heading = 45.471187591553,
                    animDict = "dc@pedchairclient2",
                    animName = "pedchairclient2_clip",
                    returnCoords = vector4(-1549.2565917969, -407.49765014648, 35.773677825928, 232.08917236328)
                },
                employee = {
                    targetCoords = vector3(-1548.02, -407.56, 35.33),
                    playerCoords = vector3(-1548.02, -407.56, 34.8),
                    heading = 228.76783752441,
                    animDict = "dc@pedchairtech",
                    animName = "pedchairtech_clip",
                    returnCoords = vector4(-1547.4458007812, -408.03854370117, 35.722537994385, 233.69540405273)
                }
            },
            [3] = {
                client = {
                    targetCoords = vector3(-1550.05, -407.87, 35.44),
                    playerCoords = vector3(-1550.05, -407.87, 35.0),
                    heading = 45.471187591553,
                    animDict = "dc@pedchairclient2",
                    animName = "pedchairclient2_clip",
                    returnCoords = vector4(-1550.1815185547, -408.7966003418, 35.773342132568, 230.46801757812)
                },
                employee = {
                    targetCoords = vector3(-1548.99, -408.74, 35.33),
                    playerCoords = vector3(-1548.99, -408.74, 34.8),
                    heading = 228.76783752441,
                    animDict = "dc@pedchairtech",
                    animName = "pedchairtech_clip",
                    returnCoords = vector4(-1548.4952392578, -409.11578369141, 35.722560882568, 229.81721496582)
                }
            },
            [4] = {
                client = {
                    targetCoords = vector3(-1551.15, -409.06, 35.44),
                    playerCoords = vector3(-1551.15, -409.06, 35.0),
                    heading = 45.471187591553,
                    animDict = "dc@pedchairclient2",
                    animName = "pedchairclient2_clip",
                    returnCoords = vector4(-1550.7728271484, -410.63626098633, 35.723777770996, 201.95877075195)
                },
                employee = {
                    targetCoords = vector3(-1550.06, -409.94, 35.33),
                    playerCoords = vector3(-1550.06, -409.94, 34.8),
                    heading = 228.76783752441,
                    animDict = "dc@pedchairtech",
                    animName = "pedchairtech_clip",
                    returnCoords = vector4(-1549.3836669922, -410.52752685547, 35.721900939941, 223.40135192871)
                }
            }
        }
    },
    WaxChair = {
        stations = {
            [1] = {
                client = {
                    targetCoords = vector3(-1561.35, -403.38, 35.69),
                    playerCoords = vector3(-1561.35, -403.38, 35.67),
                    heading = 45.453598022461,
                    animDict = "dc@facialanim",
                    animName = "facialanim_clip",
                    returnCoords = vector4(-1561.6186523438, -404.552734375, 35.747745513916, 228.75187683105)
                },
                employee = {
                    targetCoords = vector3(-1560.9, -402.8, 35.55), 
                    playerCoords = vector3(-1560.9, -402.8, 34.96),
                    heading = 316.99, 
                    animDict = "dc@pedchairtech",
                    animName = "pedchairtech_clip",
                    returnCoords = vector4(-1560.29, -402.95, 35.75, 230.92)
                }
            }
        }
    },
    HairDryer = {
        stations = {
            [1] = {
                client = {
                    targetCoords = vector3(-1541.87, -409.01, 35.23),
                    playerCoords = vector3(-1541.71, -408.85, 34.8),
                    heading = 315.5205078125,
                    animDict = "dc@salonchairsit",
                    animName = "salonchairsit_clip",
                    returnCoords = vector4(-1542.3831787109, -409.5764465332, 35.713134765625, 144.89279174805)
                }
            },
            [2] = {
                client = {
                    targetCoords = vector3(-1542.94, -407.88, 35.22),
                    playerCoords = vector3(-1542.9, -407.84, 34.8),
                    heading = 315.5205078125,
                    animDict = "dc@salonchairsit",
                    animName = "salonchairsit_clip",
                    returnCoords = vector4(-1543.5600585938, -408.50869750977, 35.71635055542, 141.52935791016)
                }
            },
            [3] = {
                client = {
                    targetCoords = vector3(-1544.04, -406.86, 35.22),
                    playerCoords = vector3(-1544.04, -406.86, 34.8),
                    heading = 315.5205078125,
                    animDict = "dc@salonchairsit",
                    animName = "salonchairsit_clip",
                    returnCoords = vector4(-1544.6859130859, -407.68051147461, 35.719078063965, 138.42868041992)
                }
            },
            [4] = {
                client = {
                    targetCoords = vector3(-1545.2, -405.86, 35.22),
                    playerCoords = vector3(-1545.2, -405.86, 34.8),
                    heading = 315.5205078125,
                    animDict = "dc@salonchairsit",
                    animName = "salonchairsit_clip",
                    returnCoords = vector4(-1545.7770996094, -406.61108398438, 35.726612091064, 143.99563598633)
                }
            }
        }
    },
    WaitingChair = { 
        stations = {
            [1] = {
                client = {
                    targetCoords = vector3(-1539.85, -416.1, 35.2),
                    playerCoords = vector3(-1539.85, -416.1, 34.2), 
                    heading = 316.82,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vector4(-1539.6, -415.75, 35.7, 316.82) 
                }
            },
            [2] = {
                client = {
                    targetCoords = vector3(-1538.93, -416.91, 35.19),
                    playerCoords = vector3(-1538.93, -416.91, 34.2),
                    heading = 328.79,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vector4(-1538.6, -416.6, 35.7, 328.79)
                }       
            },
            [3] = {
                client = {
                    targetCoords = vector3(-1538.22, -417.5, 35.19),
                    playerCoords = vector3(-1538.22, -417.5, 34.2),
                    heading = 313.72,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vector4(-1537.96, -417.16, 35.7, 313.72)
                }       
            },
            [4] = {
                client = {
                    targetCoords = vector3(-1537.32, -418.31, 35.18),
                    playerCoords = vector3(-1537.32, -418.31, 34.2),
                    heading = 317.5,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vector4(-1537.02, -417.96, 35.7, 317.5)
                }       
            },
            [5] = {
                client = {
                    targetCoords = vector3(-1538.01, -419.11, 35.18),
                    playerCoords = vector3(-1538.01, -419.11, 34.2),
                    heading = 136.45,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vector4(-1538.27, -419.51, 35.69, 136.45)
                }       
            },
            [6] = {
                client = {
                    targetCoords = vector3(-1538.93, -418.33, 35.18),
                    playerCoords = vector3(-1538.93, -418.33, 34.2),
                    heading = 135.11,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vector4(-1539.25, -418.66, 35.7, 135.11)
                }       
            },
            [7] = {
                client = {
                    targetCoords = vector3(-1539.65, -417.7, 35.19),
                    playerCoords = vector3(-1539.65, -417.7, 34.2),
                    heading = 135.18,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vector4(-1539.97, -418.05, 35.7, 135.18)
                }       
            },
            [8] = {
                client = {
                    targetCoords = vector3(-1540.55, -416.94, 35.19),
                    playerCoords = vector3(-1540.55, -416.94, 34.2),
                    heading = 143.06,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vector4(-1540.91, -417.25, 35.7, 143.06)
                }       
            },                        
        }
    },
    LoungeChair = { 
        stations = {
            [1] = {
                --[[client = {
                    targetCoords = vector3(-1545.37, -399.81, 35.23),
                    playerCoords = vector3(-1545.37, -399.81, 34.2),
                    heading = 319.43,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vector4(-1544.94, -399.5, 35.73, 319.43)
                },]]--
                employee = {
                    targetCoords = vector3(-1545.37, -399.81, 35.23),
                    playerCoords = vector3(-1545.37, -399.81, 34.2),
                    heading = 319.43,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vector4(-1544.94, -399.5, 35.73, 319.43)
                }
            },
            [2] = {
                --[[client = {
                    targetCoords = vector3(-1546.16, -399.21, 35.23),
                    playerCoords = vector3(-1546.16, -399.21, 34.2),
                    heading = 321.1,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vector4(-1545.78, -398.79, 35.74, 321.1)
                },]]--
                employee = {
                    targetCoords = vector3(-1546.16, -399.21, 35.23),
                    playerCoords = vector3(-1546.16, -399.21, 34.2),
                    heading = 321.1,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vector4(-1545.78, -398.79, 35.74, 321.1)
                }       
            },
            [3] = {
                --[[client = {
                    targetCoords = vector3(-1547.17, -398.04, 35.24),
                    playerCoords = vector3(-1547.17, -398.04, 34.2),
                    heading = 293.21,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vecotr4(-1546.67, -397.82, 35.73, 293.21)
                },]]--
                employee = {
                    targetCoords = vector3(-1547.17, -398.04, 35.24),
                    playerCoords = vector3(-1547.17, -398.04, 34.2),
                    heading = 293.21,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vector4(-1546.67, -397.82, 35.73, 293.21)
                }       
            },
            [4] = {
                --[[client = {
                    targetCoords = vector3(-1547.6, -397.18, 35.24),
                    playerCoords = vector3(-1547.6, -397.18, 34.2),
                    heading = 295.24,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vector4(-1547.1, -396.91, 35.73, 295.24)
                },]]--
                employee = {
                    targetCoords = vector3(-1547.6, -397.18, 35.24),
                    playerCoords = vector3(-1547.6, -397.18, 34.2),
                    heading = 295.24,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vector4(-1547.1, -396.91, 35.73, 295.24)
                },
            },
        },
    },
    OfficeCouch = { 
        stations = {
            [1] = {
                client = {
                    targetCoords = vector3(-1552.77, -396.71, 35.2),
                    playerCoords = vector3(-1552.77, -396.71, 34.2),
                    heading = 64.12,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vector4(-1553.15, -396.35, 35.74, 64.12)
                },
                --[[employee = {
                    targetCoords = vector3(-1552.77, -396.71, 35.2),
                    playerCoords = vector3(-1552.77, -396.71, 34.2),
                    heading = 64.12,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vector4(-1553.15, -396.35, 35.74, 64.12)
                }]]--
            },
            [2] = {
                client = {
                    targetCoords = vector3(-1551.97, -395.77, 35.21),
                    playerCoords = vector3(-1551.97, -395.77, 34.2),
                    heading = 64.09,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vector4(-1552.36, -395.42, 35.74, 64.09)
                },
                --[[employee = {
                    targetCoords = vector3(-1551.97, -395.77, 35.21),
                    playerCoords = vector3(-1551.97, -395.77, 34.2),
                    heading = 64.09,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vector4(-1552.36, -395.42, 35.74, 64.09)
                }]]--
            },
        },
    },
    ClientChair = { 
        stations = {
            [1] = {
                client = {
                    targetCoords = vector3(-1554.12, -394.94, 35.2),
                    playerCoords = vector3(-1554.12, -394.94, 34.2),
                    heading = 52.96,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vector4(-1554.4, -394.61, 35.89, 52.96)
                }
            },    
            [2] = {
                client = {
                    targetCoords = vector3(-1554.63, -395.54, 35.2),
                    playerCoords = vector3(-1554.63, -395.54, 34.2),
                    heading = 51.16,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vector4(-1554.12, -395.85, 35.75, 233.0)
                },         
            },
        },
    },
    BossChair = { 
        stations = {
            [1] = {
                employee = {
                    targetCoords = vector3(-1555.51, -393.98, 35.32),
                    playerCoords = vector3(-1555.51, -393.98, 34.3), 
                    heading = 230.56,
                    animDict = "amb@prop_human_seat_chair_mp@male@generic@base",
                    animName = "base",
                    returnCoords = vector4(-1555.1, -393.39, 35.75, 318.19)
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
            coords = vector3(-1550.01, -404.79, 35.8),
            job = "beauty",
            stashName = "beauty1storage",
            stashWeight = 100000,
            stashSlots = 50
        },
        { 
            label = "Refrigerator",
            coords = vector3(-1547.94, -392.81, 35.71),
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
        coords = vector3(-1548.56, -401.02, 35.7),
        job = "beauty"
    }
}
 
-- Shop Props Configuration
Config.ShopProps = {
    ["beauty"] = {
        {
            model = "yng_basketstack",
            coords = vector3(-1539.31, -409.31, 34.71),
            heading = 326.37,
            frozen = true
        }
                -- You can add more props here as needed
    }
    
}