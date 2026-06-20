Config = {}

-- Framework Selection
Config.Framework = "qbcore" -- Options: "qbcore", "esx"

Config.AppearanceSystem = "auto" -- Options: "auto", "skinchanger", "illenium", "fivem-appearance", "qb-clothing", "native", "codem-appearance", "17mov"
-- "auto" will detect which system is available and use the best one
-- "skinchanger" = ESX esx_skin/skinchanger system
-- "illenium" = illenium-appearance system
-- "fivem-appearance" = fivem-appearance system
-- "qb-clothing" = QBCore qb-clothing system
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
Config.DispatchSystem = "ps-dispatch" -- Options: "ps-dispatch", "qs-dispatch", "cd-dispatch", "origen-police", false
Config.UseDispatch = false -- true | false | Set to true to enable dispatch alerts

-- Banking System Configuration
Config.Banking = {
    System = "auto", -- Options: "qb-management", "qb-banking", "okokBanking", "renewed-banking", "tgg-banking", esx_society, "auto"
    -- "auto" will try each system in order until one works
}

-- Employee Jobs
Config.StoreEmployeeJobs = {
    'barber', -- barber employees
}

-- Society Configuration
Config.UseSocietyPayments = true  -- Set to false to disable society payments and pay employees directly
Config.StoreSocieties = {
    ["barber"] = "barber", -- Society accounts that receive payments
}

-- Default Duty Status - set to false to make employees start as off-duty
Config.DefaultDutyStatus = false

-- Hair Styling System Configuration
Config.Hair = {
    JobName = Config.StoreEmployeeJobs[1],
    MinimumJobGrade = 2, -- Minimum barber job grade to style hair
    CanMakeup = false, -- If true, allows makeup styling
    InteractionDistance = 2.0, -- Distance to interact with client in chair

        -- Hairstyle Whitelist System
        UseWhitelist = false, -- Set to false to allow all hairstyles
    
        -- Whitelisted hairstyle indices (only these will be available when UseWhitelist = true)
        -- These are the drawable variation indices for hair (component 2)
        WhitelistedHairstyles = {
            Male = {
                0, 38, 39, 40, 41, 65, 66, 68, 69
                -- Add or remove hairstyle indices as needed
            },
            Female = {
                0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36
                -- Add or remove hairstyle indices as needed
            }
        },

        -- Required Items to Style Hair
        RequireItems = true, -- Set to false to disable item requirement

        RequiredTools = {
            clippers = {
                label = "Clippers",
                canEquip = true,
                equipBone = 57005,
                items = {
                    {
                        item = 'magicclip',
                        label = 'Magic Clip Clippers',
                        maxUses = 25,
                        prop = {
                            model = 'yngclippers',
                            pos = vector3(0.1400, 0.0100, -0.0300),
                            rot = vector3(-16.0, -160.7, 46.0)
                        }
                    },
                    {
                        item = 'instincttrimmer',
                        label = 'Instinct Trimmer',
                        maxUses = 25,
                        prop = {
                            model = 'yngclippers',
                            pos = vector3(0.1400, 0.0100, -0.0300),
                            rot = vector3(-16.0, -160.7, 46.0)
                        }
                    },
                    {
                        item = 'gammaergo',
                        label = 'Gamma + Ergo Clippers',
                        maxUses = 25,
                        prop = {
                            model = 'yngclippers',
                            pos = vector3(0.1400, 0.0100, -0.0300),
                            rot = vector3(-16.0, -160.7, 46.0)
                        }
                    },
                }
            },
            comb = {
                label = "Comb",
                canEquip = true,
                equipBone = 18905,
                items = {
                    {
                        item = 'pocketcomb',
                        label = 'Pocket Comb',
                        maxUses = 50,
                        prop = {
                            model = 'yngcomb',
                            pos = vector3(0.1600, 0.0500, 0.0100),
                            rot = vector3(-49.0, -69.0, -4.0)
                        }
                    },
                }
            },
            toutliner = {
                label = "T-Outliner",
                items = {
                    {
                        item = 'toutliner',
                        label = 'T-Outliner',
                        maxUses = 30,
                    },
                    {
                        item = 'goldfx',
                        label = 'Gold FX Clippers',
                        maxUses = 30,
                    },
                }
            },
            duster = {
                label = "Duster",
                items = {
                    {
                        item = 'neckduster',
                        label = 'Neck Duster',
                        maxUses = 40,
                    },
                }
            },
        },

            -- Initial barber position (while using hair UI)
    InitialPosition = {
        offset = vector3(0.0, 1.3, -1.5285), -- Standing position offset from client
        heading = 180.0, -- Facing the client
    },
        
-- Barber Animation Sequence (styling stages)
Animations = {
    -- Stage 1: Fade
    Fade = {
        Barber = {
            dict = '', -- Leave empty for default
            anim = '', -- Leave empty for default
            offset = vector3(0.1, 0.0, 0.0),
            heading = 0.0,
            props = {
                { model = 'yngclippers', bone = 57005, pos = vector3(0.1320, 0.0500, -0.0440), rot = vector3(-25.3, -91.7, 0.0) },
                { model = 'yngcomb', bone = 18905, pos = vector3(0.1220, 0.0300, 0.0590), rot = vector3(-48.4, -87.6, 10.4) },
            }
        },
        Client = {
            dict = '', -- Leave empty for default
            anim = '', -- Leave empty for default
        }
    },
    -- Stage 2: Lineup
    Lineup = {
        Barber = {
            dict = '', -- Leave empty for default
            anim = '', -- Leave empty for default
            offset = vector3(-0.1, -0.1, 0.0),
            heading = 0.0,
            props = {
                { model = 'yngclippers', bone = 57005, pos = vector3(0.1130, 0.0400, -0.0220), rot = vector3(0.0, 183.2, 47.2) },
                { model = 'yngcomb', bone = 18905, pos = vector3(0.1220, 0.0440, 0.0470), rot = vector3(-80.6, -93.3, 17.3) },
            }
        },
        Client = {
            dict = '', -- Leave empty for default
            anim = '', -- Leave empty for default
        }
    },
    -- Stage 3: Duster
    Duster = {
        Barber = {
            dict = '', -- Leave empty for default
            anim = '', -- Leave empty for default
            offset = vector3(0.0, 0.0, 0.0),
            heading = 0.0,
            props = {
                { model = 'yngduster', bone = 57005, pos = vector3(0.1650, 0.0620, -0.0310), rot = vector3(-43.8, 164.7, 232.7) },
            }
        },
        Client = {
            dict = '', -- Leave empty for default
            anim = '', -- Leave empty for default
        }
    },
    -- Client bib (attached when sitting)
    ClientBib = {
        model = 'yngbarberbib',
        bone = 11816,
        pos = vector3(0.0700, 0.1300, -0.0060),
        rot = vector3(42.5, -88.1, -179.1)
    },
},
    -- Minigame Configuration
    Minigame = {
    Enabled = true,                    -- Set to false to disable minigame entirely
    Difficulty = 2,                    -- 1 = Easy, 2 = Medium, 3 = Hard
    
    -- Difficulty presets
    Difficulties = {
        [1] = { TotalHits = 5,  MaxMisses = 4, FlashDuration = 1300 },  -- Easy
        [2] = { TotalHits = 7,  MaxMisses = 3, FlashDuration = 1000 },  -- Medium  
        [3] = { TotalHits = 10, MaxMisses = 2, FlashDuration = 750 },   -- Hard
    },
    
    -- Messages
    FailMessageBarber = "You messed up their hairline!",
    FailMessageClient = "The barber messed up your hairline!",
},
}

-- Box Items Configuration (Items you can open in boxes to give clippers or etc)
Config.BoxItems = {
    ['gammaergobox'] = { gives = 'gammaergo', label = 'Gamma + Ergo Clippers' },
    ['goldfxbox'] = { gives = 'goldfx', label = 'Gold FX Clippers' },
    ['instincttrimmerbox'] = { gives = 'instincttrimmer', label = 'Instinct Trimmer' },
    ['magicclipbox'] = { gives = 'magicclip', label = 'Magic Clip Clippers' },
    ['toutlinerbox'] = { gives = 'toutliner', label = 'T-Outliner' },
}

Config.Tablet = {
    Enabled = true,
    ItemName = 'barber_tablet',  -- Item name in your inventory system
    
    -- Payment destination: "society" (all to business), "barber" (all to employee), "split" (base to society, tip to barber)
    PaymentDestination = "split",
    
    -- Custom charge limits
    CustomChargeLimit = 5000,           -- Default max custom charge amount
    AllowManagementToSetLimit = true,   -- Can management change the limit from tablet?
    
    -- Tip presets (percentages shown to customer)
    TipPresets = { 10, 15, 20, 25 },
    
    -- Who can access management features (job grade levels)
    ManagementGrades = { 3, 4 },  -- 3 = Manager, 4 = Boss (from your job_grades)
    
    -- Appointment reminder notifications (minutes before appointment)
    AppointmentReminders = { 15, 5 },
    
    -- Animations
    Animations = {
        HoldTablet = { 
            dict = "amb@world_human_seat_wall_tablet@female@base", 
            anim = "base" 
        },
        Handoff = { 
            dict = "mp_common", 
            anim = "givetake1_a" 
        },
        ReceiveTablet = { 
            dict = "mp_common", 
            anim = "givetake1_b" 
        },
    },
    
    -- Tablet prop settings
    Prop = {
        Model = "prop_cs_tablet",
        Bone = 57005,
        Offset = vector3(0.11, 0.10, -0.14),
        Rotation = vector3(24.0, 158.0, 147.0),
    },
    
    -- Default services (management can edit prices in-game, saved to database)
    DefaultServices = {
        { id = "haircut", name = "Haircut", price = 50 },
        { id = "hair_color", name = "Hair Color", price = 75 },
        { id = "beard_trim", name = "Beard Trim", price = 30 },
        { id = "beard_color", name = "Beard Color", price = 40 },
        { id = "eyebrows", name = "Eyebrow Styling", price = 20 },
        { id = "contacts", name = "Contacts", price = 35 },
        { id = "full_service", name = "Full Service", price = 120 },
    },
    
    -- Localization / Messages
    Locale = {
        -- General
        ['tablet_no_job'] = 'You must be a barber to use this.',
        ['tablet_opened'] = 'Tablet opened.',
        ['tablet_closed'] = 'Tablet closed.',
        
        -- Passing tablet
        ['select_customer'] = 'Select a customer to pass the tablet to.',
        ['no_nearby_players'] = 'No customers nearby.',
        ['pass_tablet'] = 'Pass Tablet',
        ['passing_tablet'] = 'Passing tablet to customer...',
        ['tablet_passed'] = 'Tablet passed. Waiting for customer response.',
        
        -- Customer prompts
        ['tablet_offer_title'] = 'Barber Tablet',
        ['tablet_offer_desc'] = '%s wants to hand you the payment tablet.',
        ['accept_tablet'] = 'Accept',
        ['decline_tablet'] = 'Decline',
        ['decline_reason_title'] = 'Decline Reason',
        ['decline_reason_desc'] = 'Why are you declining? (optional)',
        
        -- Customer received
        ['tablet_received'] = 'Review your services and complete payment.',
        
        -- Decline handling
        ['tablet_declined'] = 'Customer declined the tablet.',
        ['tablet_declined_reason'] = 'Customer declined: %s',
        ['you_declined'] = 'You declined the tablet.',
        
        -- Payment
        ['payment_success_barber'] = 'Payment of $%s received! (Tip: $%s)',
        ['payment_success_customer'] = 'You paid $%s. Thank you for visiting The Fade Trap!',
        ['no_money_cash'] = 'You don\'t have enough cash.',
        ['no_money_bank'] = 'You don\'t have enough in your bank account.',
        
        -- Appointments
        ['appointment_added'] = 'Appointment scheduled for %s.',
        ['appointment_cancelled'] = 'Appointment cancelled.',
        ['appointment_reminder'] = 'Reminder: %s has an appointment in %d minutes.',
        ['no_appointments'] = 'No upcoming appointments.',
        
        -- Management
        ['price_updated'] = 'Price for %s updated to $%s.',
        ['limit_updated'] = 'Custom charge limit set to $%s.',
        ['no_permission'] = 'You don\'t have permission to do this.',
        
        -- Stats
        ['stats_today'] = 'Today\'s Sales: $%s (%d customers)',
        ['stats_week'] = 'This Week: $%s (%d customers)',
    }
}

-- ═══════════════════════════════════════════════════════════════════════════════
-- APPOINTMENT BOOKING SYSTEM
-- ═══════════════════════════════════════════════════════════════════════════════
Config.Appointments = {
    Enabled = true,
    
    -- Deposit Settings
    DepositPercent = 20,                    -- Percentage of total services as deposit
    DepositAccount = "bank",                -- "bank" or "cash"
    
    -- Cancellation Policy
    RefundCutoffHours = 24,                 -- Hours before appointment to get refund
    
    -- Booking Settings
    BookingDaysAhead = 7,                   -- How many days in advance customers can book
    
    -- Slot Settings
    DefaultSlotIncrement = 30,              -- Default slot duration in minutes
    SlotIncrementOptions = { 15, 30, 45, 60 }, -- Options barbers can choose from
    
    -- Reminder Settings
    ReminderOptions = { 15, 30, 60 },       -- Minutes before appointment (customer chooses)
    
    -- Time Range (what barbers can choose from)
    TimeRangeStart = 6,                     -- Earliest start time (6 AM)
    TimeRangeEnd = 22,                      -- Latest end time (10 PM)
    
    -- Target Settings (for customer booking)
    BookingTarget = {
        coords = vector3(-831.25, -1095.76, 11.83),    -- Set this to your booking station location
        radius = 1.5,
        icon = "fas fa-calendar-check",
        label = "Book Appointment",
    },
    
    -- Messages
    Locale = {
        ['booking_title'] = "Book Appointment",
        ['select_barber'] = "Select a Barber",
        ['select_services'] = "Select Services",
        ['select_date'] = "Select Date",
        ['select_time'] = "Select Time",
        ['select_reminder'] = "Reminder Notification",
        ['confirm_booking'] = "Confirm Booking",
        ['no_barbers'] = "No barbers are currently accepting appointments",
        ['no_availability'] = "No available slots for this date",
        ['booking_success'] = "Appointment booked! Deposit of $%s paid.",
        ['booking_cancelled'] = "Appointment cancelled",
        ['refund_given'] = "Your deposit of $%s has been refunded",
        ['no_refund'] = "Cancellation too late - no refund",
        ['reminder_notification'] = "Reminder: You have an appointment in %s minutes!",
        ['not_enough_money'] = "Not enough money for deposit ($%s required)",
        ['appointment_starting'] = "Your appointment with %s is starting now!",
        ['customer_arrived'] = "%s has arrived for their appointment!",
    },
}

-- Trap (Street Selling) Configuration
Config.Trap = {
    -- Enable/Disable Features
    Enabled = true,
    UseTarget = false, -- true = use target system (ox_target/qb-target), false = use E key to sell
    GenderRestriction = "none", -- "male" = men only, "female" = women only, "none" = anyone can sell
    Command = 'fadetrap', -- Command to start selling
    
    -- Requirements
    MinPolice = 0, -- Minimum police required to start selling
    RequireBarberJob = false, -- Set to true if only barber job can sell (DEFAULT: false = anyone can sell)
    
    -- Selling Settings
    PedFrequency = {1, 5}, -- Time between customers in seconds (min, max)
    RejectChance = 20, -- Percent chance of rejected sale (1-100)
    RobberyChance = 10, -- Percent chance of robbery if sale is rejected (1-100)
    MaxDistance = 25, -- Max distance customer will walk to player
    
    -- Payment Settings
    PaymentAccount = 'cash', -- 'cash', 'bank', or 'black_money'
    
    -- Sellable Products (bootleg goods)
    Products = {
        -- DVDs & Media
        ['bootleg_dvd']           = { label = 'Bootleg DVD',              price = {5, 15},   quantity = {1, 5} },
        ['bootleg_cd']            = { label = 'Bootleg CD',               price = {3, 10},   quantity = {1, 5} },
        ['bootleg_game']          = { label = 'Bootleg Video Game',       price = {10, 25},  quantity = {1, 3} },
        
        -- Fake Designer Shoes
        ['fake_j_sneakers']       = { label = 'Fake Js',                  price = {25, 60},  quantity = {1, 2} },
        ['fake_y_sneakers']       = { label = 'Fake Yees',                price = {30, 70},  quantity = {1, 2} },
        ['fake_n_sneakers']       = { label = 'Fake Zikes',               price = {20, 45},  quantity = {1, 2} },
        ['fake_af_sneakers']      = { label = 'Fake Forces',              price = {20, 40},  quantity = {1, 2} },
        
        -- Fake Designer Clothing
        ['fake_g_belt']           = { label = 'Fake Belt',                price = {15, 35},  quantity = {1, 3} },
        ['fake_lv_bag']           = { label = 'Fake Bag',                 price = {30, 75},  quantity = {1, 2} },
        ['fake_designer_shirt']   = { label = 'Fake Designer Shirt',      price = {10, 25},  quantity = {1, 3} },
        ['fake_designer_hat']     = { label = 'Fake Designer Hat',        price = {8, 20},   quantity = {1, 3} },
        ['fake_designer_glasses'] = { label = 'Fake Designer Shades',     price = {5, 15},   quantity = {1, 4} },
        
        -- Fake Jewelry
        ['fake_gold_chain']       = { label = 'Fake Gold Chain',          price = {15, 40},  quantity = {1, 2} },
        ['fake_watch']            = { label = 'Fake Watch',               price = {25, 60},  quantity = {1, 2} },
        ['fake_earrings']         = { label = 'Fake Earrings',            price = {10, 25},  quantity = {1, 3} },
        ['fake_bracelet']         = { label = 'Fake Gold Bracelet',       price = {12, 30},  quantity = {1, 3} },
        
        -- Electronics
        ['fake_airpods']          = { label = 'AirNods',                  price = {10, 25},  quantity = {1, 3} },
        ['fake_beats']            = { label = 'Heats Headphones',         price = {15, 35},  quantity = {1, 2} },
        ['bootleg_charger']       = { label = 'Bootleg Charger',          price = {3, 8},    quantity = {1, 5} },
        ['fake_phone']            = { label = 'tPhone',                   price = {15, 35},  quantity = {1, 2} },
        ['fake_tablet']           = { label = 'iPed',                     price = {15, 35},  quantity = {1, 2} },
        
        -- Fragrances
        ['fake_cologne']          = { label = 'Fake Cologne',             price = {8, 20},   quantity = {1, 3} },
        ['fake_perfume']          = { label = 'Fake Perfume',             price = {8, 20},   quantity = {1, 3} },
        
        -- Misc Bootleg
        ['bootleg_jersey']        = { label = 'Bootleg Jersey',           price = {12, 30},  quantity = {1, 2} },
        ['fake_wallet']           = { label = 'Fake Designer Wallet',     price = {10, 25},  quantity = {1, 3} },
        ['loose_cigs']            = { label = 'Loose Cigarettes',         price = {1, 3},    quantity = {1, 10} },
    },
    
    -- Customer Ped Models (Male customers for bootleg goods)
    CustomerPeds = {
        'a_m_m_afriamer_01',
        'a_m_m_beach_01',
        'a_m_m_beach_02',
        'a_m_m_bevhills_01',
        'a_m_m_bevhills_02',
        'a_m_m_business_01',
        'a_m_m_eastsa_01',
        'a_m_m_eastsa_02',
        'a_m_m_farmer_01',
        'a_m_m_fatlatin_01',
        'a_m_m_genfat_01',
        'a_m_m_genfat_02',
        'a_m_m_golfer_01',
        'a_m_m_hasjew_01',
        'a_m_m_hillbilly_01',
        'a_m_m_indian_01',
        'a_m_m_ktown_01',
        'a_m_m_malibu_01',
        'a_m_m_mexcntry_01',
        'a_m_m_mexlabor_01',
        'a_m_m_og_boss_01',
        'a_m_m_paparazzi_01',
        'a_m_m_polynesian_01',
        'a_m_m_soucent_01',
        'a_m_m_soucent_02',
        'a_m_m_soucent_03',
        'a_m_m_soucent_04',
        'a_m_m_stlat_02',
        'a_m_m_tennis_01',
        'a_m_m_tourist_01',
        'a_m_m_tramp_01',
        'a_m_m_trampbeac_01',
        'a_m_o_acult_01',
        'a_m_y_beach_01',
        'a_m_y_beach_02',
        'a_m_y_beach_03',
        'a_m_y_beachvesp_01',
        'a_m_y_bevhills_01',
        'a_m_y_bevhills_02',
        'a_m_y_breakdance_01',
        'a_m_y_busicas_01',
        'a_m_y_business_01',
        'a_m_y_business_02',
        'a_m_y_business_03',
        'a_m_y_downtown_01',
        'a_m_y_eastsa_01',
        'a_m_y_eastsa_02',
        'a_m_y_epsilon_01',
        'a_m_y_epsilon_02',
        'a_m_y_gay_01',
        'a_m_y_gay_02',
        'a_m_y_genstreet_01',
        'a_m_y_genstreet_02',
        'a_m_y_golfer_01',
        'a_m_y_hasjew_01',
        'a_m_y_hiker_01',
        'a_m_y_hippy_01',
        'a_m_y_hipster_01',
        'a_m_y_hipster_02',
        'a_m_y_hipster_03',
        'a_m_y_indian_01',
        'a_m_y_jetski_01',
        'a_m_y_juggalo_01',
        'a_m_y_ktown_01',
        'a_m_y_ktown_02',
        'a_m_y_latino_01',
        'a_m_y_methhead_01',
        'a_m_y_mexthug_01',
        'a_m_y_motox_01',
        'a_m_y_motox_02',
        'a_m_y_musclbeac_01',
        'a_m_y_musclbeac_02',
        'a_m_y_polynesian_01',
        'a_m_y_roadcyc_01',
        'a_m_y_runner_01',
        'a_m_y_runner_02',
        'a_m_y_salton_01',
        'a_m_y_skater_01',
        'a_m_y_skater_02',
        'a_m_y_soucent_01',
        'a_m_y_soucent_02',
        'a_m_y_soucent_03',
        'a_m_y_soucent_04',
        'a_m_y_stbla_01',
        'a_m_y_stbla_02',
        'a_m_y_stlat_01',
        'a_m_y_stwhi_01',
        'a_m_y_stwhi_02',
        'a_m_y_sunbathe_01',
        'a_m_y_surfer_01',
        'a_m_y_vindouche_01',
        'a_m_y_vinewood_01',
        'a_m_y_vinewood_02',
        'a_m_y_vinewood_03',
        'a_m_y_vinewood_04',
        'a_m_y_yoga_01',
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
    
    -- Localization
    Locale = {
        ['not_male'] = 'Only men can sell on the street!',
        ['not_female'] = 'Only women can sell on the street!',
        ['no_police'] = 'Not enough police online to start selling.',
        ['no_products'] = 'You don\'t have anything to sell!',
        ['already_selling'] = 'You are already selling!',
        ['wait_customer'] = 'Looking for customers... Stay in the area.',
        ['customer_approaching'] = 'A customer is coming your way!',
        ['sell_product'] = 'Sell %s',
        ['sale_success'] = 'Sold %dx %s for $%d',
        ['sale_rejected'] = 'Customer wasn\'t interested.',
        ['customer_left'] = 'Customer got impatient and left.',
        ['too_far'] = 'You went too far from the customer!',
        ['robbed'] = 'The customer tried to rob you!',
        ['stopped_selling'] = 'Stopped selling.',
        ['in_vehicle'] = 'You can\'t sell from a vehicle!',
        ['not_barber_job'] = 'You need to work at The Fade Trap to sell!',
        ['robbery_failed'] = 'You fought off the robber!',
        ['customer_waiting'] = 'Customer is ready to buy!'
    }
}

-- bootlegger Ped Configuration
Config.Bootlegger = {
    Enabled = true,
    
    -- Spawn Settings
    SpawnChance = 20, -- % chance to spawn each check
    CheckInterval = {50, 70}, -- Minutes between spawn checks (min, max)
    StayDuration = {3, 7}, -- Minutes bootlegger stays (min, max)
    
    -- Location Settings
    DoorCoords = vector4(-828.08, -1092.46, 11.17, 292.59), -- TODO: Where they spawn at door
    StandCoords = vector4(-827.94, -1093.55, 11.15, 33.47), -- TODO: Where they stand inside
    
    -- Ped Settings
    PedModels = {
        's_m_y_dealer_01',
        'a_m_m_eastsa_02',
        'a_m_y_mexthug_01',
        'g_m_y_famca_01',
        'g_m_y_famdnf_01',
    },
    
    -- Interaction
    InteractionDistance = 2.0,
    
    -- Purchase Limits
    MaxItemsPerPerson = 60, -- Max total items one person can buy per bootlegger visit
    
    -- Products bootlegger sells (buy these to resell on street)
    -- stock = how many bootlegger has, maxBuy = max one person can buy of this item
    Products = {
        -- DVDs & Media
        ['bootleg_dvd']           = { label = 'Bootleg DVD',              price = 3,   stock = 100, maxBuy = 10 },
        ['bootleg_cd']            = { label = 'Bootleg CD',               price = 2,   stock = 100, maxBuy = 10 },
        ['bootleg_game']          = { label = 'Bootleg Video Game',       price = 7,   stock = 100, maxBuy = 10 },
        
        -- Fake Designer Shoes
        ['fake_j_sneakers']       = { label = 'Fake Js',                  price = 15,  stock = 100, maxBuy = 10 },
        ['fake_y_sneakers']       = { label = 'Fake Yees',                price = 20,  stock = 100, maxBuy = 10 },
        ['fake_n_sneakers']       = { label = 'Fake Zikes',               price = 12,  stock = 100, maxBuy = 10 },
        ['fake_af_sneakers']      = { label = 'Fake Forces',              price = 10,  stock = 100, maxBuy = 10 },
        
        -- Fake Designer Clothing
        ['fake_g_belt']           = { label = 'Fake Belt',                price = 8,   stock = 100, maxBuy = 10 },
        ['fake_lv_bag']           = { label = 'Fake Bag',                 price = 20,  stock = 100, maxBuy = 10 },
        ['fake_designer_shirt']   = { label = 'Fake Designer Shirt',      price = 6,   stock = 100, maxBuy = 10 },
        ['fake_designer_hat']     = { label = 'Fake Designer Hat',        price = 5,   stock = 100, maxBuy = 10 },
        ['fake_designer_glasses'] = { label = 'Fake Designer Shades',     price = 3,   stock = 100, maxBuy = 10 },
        
        -- Fake Jewelry
        ['fake_gold_chain']       = { label = 'Fake Gold Chain',          price = 10,  stock = 100, maxBuy = 10 },
        ['fake_watch']            = { label = 'Fake Watch',               price = 15,  stock = 100, maxBuy = 10 },
        ['fake_earrings']         = { label = 'Fake Earrings',            price = 6,   stock = 100, maxBuy = 10 },
        ['fake_bracelet']         = { label = 'Fake Gold Bracelet',       price = 7,   stock = 100, maxBuy = 10 },
        
        -- Electronics
        ['fake_airpods']          = { label = 'AirNods',                  price = 6,   stock = 100, maxBuy = 10 },
        ['fake_beats']            = { label = 'Heats Headphones',         price = 10,  stock = 100, maxBuy = 10 },
        ['bootleg_charger']       = { label = 'Bootleg Charger',          price = 2,   stock = 100, maxBuy = 10 },
        ['fake_phone']            = { label = 'tPhone',                   price = 10,  stock = 100, maxBuy = 10 },
        ['fake_tablet']           = { label = 'iPed',                     price = 10,  stock = 100, maxBuy = 10 },
        
        -- Fragrances
        ['fake_cologne']          = { label = 'Fake Cologne',             price = 5,   stock = 100, maxBuy = 10 },
        ['fake_perfume']          = { label = 'Fake Perfume',             price = 5,   stock = 100, maxBuy = 10 },
        
        -- Misc
        ['bootleg_jersey']        = { label = 'Bootleg Jersey',           price = 8,   stock = 100, maxBuy = 10 },
        ['fake_wallet']           = { label = 'Fake Designer Wallet',     price = 6,   stock = 100, maxBuy = 10 },
        ['loose_cigs']            = { label = 'Loose Cigarettes',         price = 1,   stock = 100, maxBuy = 10 },
    },
    
    -- Locale
    Locale = {
        ['bootlegger_arrived'] = 'Word on the street... a bootlegger just walked into The Fade Trap.',
        ['bootlegger_leaving'] = 'The bootlegger is leaving soon...',
        ['bootlegger_left'] = 'The bootlegger left.',
        ['purchase_success'] = 'Bought %dx %s for $%d',
        ['no_money'] = 'You don\'t have enough cash.',
        ['no_stock'] = 'bootlegger is out of that.',
        ['max_reached'] = 'You can\'t buy any more of that.',
        ['max_total_reached'] = 'You\'ve bought enough for now.',
        ['interact_bootlegger'] = 'Talk to Bootlegger',
    }
}

-- Blip Configuration
Config.EnableBlips = true
Config.Blips = {
    { title = "The Fade Trap", colour = 0, id = 71, vector3 = vector3(-832.88, -1094.12, 11.15) },
}

-- Duty Configuration
Config.DutyLocations = {
    ["barber"] = {
        coords = vector3(-838.76, -1083.38, 10.95),
        label = "Clock In/Out",
        job = "barber"
    }
}

-- Salon/Barbershop Chair Configuration
Config.SalonSections = {
    -- Barber Chairs (Main service stations)
    HairChair = {
        stations = {
            [1] = {
                client = {
                    targetCoords = vector3(-830.58, -1089.7, 10.74),
                    playerCoords = vector3(-830.58, -1089.7, 10.17),
                    heading = 25.81,
                    animDict = "", -- Leave empty for default
                    animName = "", -- Leave empty for default
                    returnCoords = vector4(-830.41, -1090.11, 10.05, 204.09)
                },
            },
            [2] = {
                client = {
                    targetCoords = vector3(-832.4, -1090.74, 10.74),
                    playerCoords = vector3(-832.4, -1090.74, 10.17),
                    heading = 25.81,
                    animDict = "", -- Leave empty for default
                    animName = "", -- Leave empty for default
                    returnCoords = vector4(-832.17, -1091.13, 10.05, 212.45)
                },
            },
            [3] = {
                client = {
                    targetCoords = vector3(-834.24, -1091.78, 10.74),
                    playerCoords = vector3(-834.24, -1091.78, 10.17),
                    heading = 25.81,
                    animDict = "", -- Leave empty for default
                    animName = "", -- Leave empty for default
                    returnCoords = vector4(-834.03, -1092.2, 10.05, 209.3)
                },
            },
            [4] = {
                client = {
                    targetCoords = vector3(-836.05, -1092.84, 10.74), 
                    playerCoords = vector3(-836.05, -1092.84, 10.17),
                    heading = 25.81,
                    animDict = "", -- Leave empty for default
                    animName = "", -- Leave empty for default
                    returnCoords = vector4(-835.85, -1093.22, 10.05, 211.03)
                },
            }
        }
    },
    -- Hair Wash Chairs
    HairWashChair = {
        stations = {
            [1] = {
                client = {
                    targetCoords = vector3(-835.1, -1096.85, 10.65), 
                    playerCoords = vector3(-835.1, -1096.85, 10.27),
                    heading = 202.25,
                    animDict = "dc@shampoosit",
                    animName = "shampoosit_clip",
                    returnCoords = vector4(-835.39, -1096.24, 10.04, 28.78)
                },
                employee = {
                    targetCoords = vector3(-834.76, -1097.44, 11.02),
                    playerCoords = vector3(-835.31, -1097.57, 10.27),
                    heading = 86.97,
                    animDict = "dc@shampoostand",
                    animName = "shampoostand_clip",
                    returnCoords = vector4(-835.3, -1097.59, 10.04, 28.78)
                }
            },
            [2] = {
                client = {
                    targetCoords = vector3(-836.56, -1097.74, 10.65), 
                    playerCoords = vector3(-836.56, -1097.74, 10.27),
                    heading = 202.25,
                    animDict = "dc@shampoosit",
                    animName = "shampoosit_clip",
                    returnCoords = vector4(-836.94, -1097.14, 10.04, 28.78)
                },
                employee = {
                    targetCoords = vector3(-836.21, -1098.36, 11.03),
                    playerCoords = vector3(-835.87, -1097.89, 10.27),
                    heading = 304.04,
                    animDict = "dc@shampoostand",
                    animName = "shampoostand_clip",
                    returnCoords = vector4(-835.85, -1097.91, 11.15, 28.78)
                },
            }
        }
    },
    -- Waiting Chairs (9 total)
    WaitingChair = {
        stations = {
            [1] = { client = { targetCoords = vector3(-828.61, -1093.97, 10.69), playerCoords = vector3(-828.61, -1093.97, 9.74), heading = 28.78, animDict = "amb@prop_human_seat_chair_mp@male@generic@base", animName = "base", returnCoords = vector4(-828.95, -1093.46, 10.34, 28.78) }},
            [2] = { client = { targetCoords = vector3(-829.23, -1094.32, 10.69), playerCoords = vector3(-829.23, -1094.32, 9.74), heading = 28.78, animDict = "amb@prop_human_seat_chair_mp@male@generic@base", animName = "base", returnCoords = vector4(-829.5, -1093.78, 10.34, 28.78) }},
            [3] = { client = { targetCoords = vector3(-829.86, -1094.68, 10.69), playerCoords = vector3(-829.86, -1094.68, 9.74), heading = 28.78, animDict = "amb@prop_human_seat_chair_mp@male@generic@base", animName = "base", returnCoords = vector4(-830.15, -1094.17, 10.34, 28.78) }},
            [4] = { client = { targetCoords = vector3(-830.48, -1095.03, 10.69), playerCoords = vector3(-830.48, -1095.03, 9.74), heading = 28.78, animDict = "amb@prop_human_seat_chair_mp@male@generic@base", animName = "base", returnCoords = vector4(-830.74, -1094.51, 10.34, 28.78) }},
            [5] = { client = { targetCoords = vector3(-831.1, -1095.38, 10.69), playerCoords = vector3(-831.1, -1095.38, 9.74), heading = 28.78, animDict = "amb@prop_human_seat_chair_mp@male@generic@base", animName = "base", returnCoords = vector4(-831.33, -1094.85, 10.34, 28.78) }},
            [6] = { client = { targetCoords = vector3(-831.7, -1095.74, 10.69), playerCoords = vector3(-831.7, -1095.74, 9.74), heading = 28.78, animDict = "amb@prop_human_seat_chair_mp@male@generic@base", animName = "base", returnCoords = vector4(-832.01, -1095.24, 10.34, 28.78) }},
            [7] = { client = { targetCoords = vector3(-832.31, -1096.09, 10.69), playerCoords = vector3(-832.31, -1096.09, 9.74), heading = 28.78, animDict = "amb@prop_human_seat_chair_mp@male@generic@base", animName = "base", returnCoords = vector4(-832.59, -1095.56, 10.34, 28.78) }},
            [8] = { client = { targetCoords = vector3(-832.93, -1096.45, 10.69), playerCoords = vector3(-832.93, -1096.45, 9.74), heading = 28.78, animDict = "amb@prop_human_seat_chair_mp@male@generic@base", animName = "base", returnCoords = vector4(-833.19, -1095.92, 10.34, 28.78) }},
            [9] = { client = { targetCoords = vector3(-833.55, -1096.82, 10.69), playerCoords = vector3(-833.55, -1096.82, 9.74), heading = 28.78, animDict = "amb@prop_human_seat_chair_mp@male@generic@base", animName = "base", returnCoords = vector4(-833.85, -1096.29, 10.34, 28.78) }}
        }
    },
    -- Lounge Chairs (4 total)
    LoungeChair = {
        stations = {
            [1] = { client = { targetCoords = vector3(0.0, 0.0, 0.0), playerCoords = vector3(-835.6, -1089.17, 9.74), heading = 295.14, animDict = "timetable@ron@ig_3_couch", animName = "base", returnCoords = vector4(-835.0, -1088.87, 10.34, 295.7) }},
            [2] = { client = { targetCoords = vector3(0.0, 0.0, 0.0), playerCoords = vector3(0.0, 0.0, 0.0), heading = 0.0, animDict = "timetable@ron@ig_3_couch", animName = "base", returnCoords = vector4(0.0, 0.0, 0.0, 0.0) }},
            [3] = { client = { targetCoords = vector3(0.0, 0.0, 0.0), playerCoords = vector3(0.0, 0.0, 0.0), heading = 0.0, animDict = "timetable@ron@ig_3_couch", animName = "base", returnCoords = vector4(0.0, 0.0, 0.0, 0.0) }},
            [4] = { client = { targetCoords = vector3(0.0, 0.0, 0.0), playerCoords = vector3(0.0, 0.0, 0.0), heading = 0.0, animDict = "timetable@ron@ig_3_couch", animName = "base", returnCoords = vector4(0.0, 0.0, 0.0, 0.0) }}
        }
    }
}

-- Stash and Clothing Locker Configuration
Config.StashLocations = {
    ["barber"] = {
        { 
            label = "Storage Room",
            coords = vector3(-842.16, -1085.49, 11.31),
            job = "barber",
            stashName = "barber_storage",
            stashWeight = 100000,
            stashSlots = 50
        },
        { 
            label = "Refrigerator",
            coords = vector3(-836.76, -1082.29, 11.31),
            job = "barber",
            stashName = "barber_fridge",
            stashWeight = 100000,
            stashSlots = 50
        }
    }
}


Config.ClothingLockers = {
--[[
    ["barber"] = {
        label = "Staff Changing Locker",
        coords = vector3(0.0, 0.0, 0.0),
        job = "barber"
    }
]]
}
