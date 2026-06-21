Config.HousesList = {
    -- ███████╗ █████╗ ███████╗██╗   ██╗
    -- ██╔════╝██╔══██╗██╔════╝╚██╗ ██╔╝
    -- █████╗  ███████║███████╗ ╚████╔╝ 
    -- ██╔══╝  ██╔══██║╚════██║  ╚██╔╝  
    -- ███████╗██║  ██║███████║   ██║   
    -- ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝   
    ['1'] = {
        image = 'house_1.png',
        address = {street = 'Grove Street', zone = 'Davis'},
        difficultyLevel = 1, -- 1 / 2 / 3
        
        lockpickType = 'normal', -- CL.Lockpick
        lockpickItem = 'lockpick',
        lockpickRemove = 1, -- 0 = Don't remove, 1 = Remove on use, 2 = Remove only on done
        
        robberyTimeout = 45 * 60, -- 45 minutes

        requiredPolices = 0,

        interior = 'standardmotel_shell',
        enterCoords = vector3(126.6, -1929.81, 21.38),
        loot = {
            [1] = {
                coords = vector4(1.57, -3.13, -19.22, 200.32),
                animation = {"anim@scripted@cbr1@ig1_washmach_grab_cash@heeled@", "grab", 1500, 1},
                probablyLoots = {
                    ['tv'] = {spawnChance = 90, count = 1},
                    ['laptop'] = {spawnChance = 65, count = 1},
                    ['dj'] = {spawnChance = 60, count = 1},
                },
            },
            [2] = {
                coords = vector4(2.41, 3.19, -19.3, 168.95),
                animation = {"anim@scripted@player@freemode@tun_prep_grab_midd_ig3@heeled@", "tun_prep_grab_midd_ig3", 800, 1},
                probablyLoots = {
                    ['weapon_pistol'] = {spawnChance = 35, count = 1},
                },
            },
            [3] = {
                coords = vector4(-2.41, 3.44, -18.94, 181.96),
                animation = {"anim@scripted@player@freemode@tun_prep_grab_midd_ig3@heeled@", "tun_prep_grab_midd_ig3", 800, 1},
                probablyLoots = {
                    ['perfume'] = {spawnChance = 75, count = 1},
                },
            },
            [4] = {
                coords = vector4(-0.3, 3.22, -19.99, 359.83),
                isCabinet = 'prop_rub_cabinet01',
                animation = {"anim@scripted@cbr1@ig1_washmach_grab_cash@heeled@", "grab", 1500, 1},
                money = 'cash',
                count = {120, 820},
            },
        },
        tenants = {
            [1] = {
                model = 'g_m_y_ballasout_01',
                isArmedWith = 'weapon_pistol', -- when the player wakes him up, attacks him with this weapon
                hoursAtHome = {7, 10}, -- Tenant 1 will be home from 7:00 to 10:00 and will not sleep
                hoursAreSleeping = {22, 6}, -- Tenant 1 will sleep from 22:00 to 6:00
                activitesAtHome = {
                    -- {coords = vector4(-2.62, 0.64, -18.91, 81.63), animation = {'mp_safehouseshower@male@', 'male_shower_idle_a'}},
                    {coords = vector4(-2.94, 2.52, -18.95, 192.7), animation = {'timetable@ron@ig_3_couch', 'base'}},
                    {coords = vector4(0.71, -1.53, -18.57, 193.51), animation = {'timetable@ron@ig_3_couch', 'base'}},
                },
                sleeping = {
                    coords = vector4(-0.32, 0.06, -18.27, 167.96),
                    animation = {'anim@amb@nightclub@lazlow@lo_sofa@', 'lowsofa_dlg_fuckedup_laz'},
                },
            },
        },
        requirements = {
            [1] = "You need Lockpick.",
        },
        informations = {
            
        },
    },
    ['2'] = {
        image = 'house_2.png',
        address = {street = 'Palomino Ave', zone = 'Little Seoul'},
        difficultyLevel = 1, -- 1 / 2 / 3
        
        lockpickType = 'normal', -- CL.Lockpick
        lockpickItem = 'lockpick',
        lockpickRemove = 1, -- 0 = Don't remove, 1 = Remove on use, 2 = Remove only on done
        
        robberyTimeout = 50 * 60, -- 45 minutes

        requiredPolices = 0,

        interior = 'furnitured_midapart',
        enterCoords = vector4(-579.98, -778.62, 25.02, 92.13),
        loot = {
            [1] = {
                coords = vector4(0.36, 1.34, -19.01, 97.51),
                animation = {"anim@scripted@player@freemode@tun_prep_grab_midd_ig3@heeled@", "tun_prep_grab_midd_ig3", 800, 1},
                probablyLoots = {
                    ['laptop'] = {spawnChance = 60, count = 1},
                },
            },
            [2] = {
                coords = vector4(-7.54, 6.11, -19.3, 97.03),
                animation = {"anim@scripted@player@fix_chop_petting@male@", "petting", 1700, 1},
                probablyLoots = {
                    ['dvd'] = {spawnChance = 40, count = 1},
                },
            },
            [3] = {
                coords = vector4(-7.11, 8.76, -19.9, 65.77),
                animation = {"veh@common@motorbike@low@ps", "pickup", 700, 1},
                probablyLoots = {
                    ['speaker'] = {spawnChance = 30, count = 1},
                },
            },
            [4] = {
                coords = vector4(-3.04, -1.06, -18.93, 158.59),
                animation = {"anim@scripted@player@freemode@tun_prep_ig3_grab_high@heeled@", "tun_prep_ig3_grab_high", 1300, 1},
                probablyLoots = {
                    ['toaster'] = {spawnChance = 55, count = 1},
                    ['mixer'] = {spawnChance = 70, count = 1},
                    ['microwave'] = {spawnChance = 60, count = 1},
                },
            },
            [5] = {
                coords = vector4(1.65, 9.03, -18.95, 304.56),
                animation = {"anim@scripted@player@freemode@tun_prep_grab_midd_ig3@heeled@", "tun_prep_grab_midd_ig3", 800, 1},
                probablyLoots = {
                    ['perfume'] = {spawnChance = 55, count = 1},
                },
            },
            [6] = {
                coords = vector4(6.21, 2.84, -19.18, 190.67),
                animation = {"anim@scripted@cbr1@ig1_washmach_grab_cash@heeled@", "grab", 1500, 1},
                probablyLoots = {
                    ['tv'] = {spawnChance = 65, count = 1},
                },
            },
        },
        tenants = {
            [1] = {
                model = 'a_m_m_og_boss_01',
                isArmedWith = 'weapon_combatpistol', -- when the player wakes him up, attacks him with this weapon
                hoursAtHome = {7, 10}, -- Tenant 1 will be home from 7:00 to 10:00 and will not sleep
                hoursAreSleeping = {22, 6}, -- Tenant 1 will sleep from 22:00 to 6:00
                activitesAtHome = {
                    {coords = vector4(-2.94, 2.52, -18.95, 192.7), animation = {'timetable@ron@ig_3_couch', 'base'}},
                    {coords = vector4(0.71, -1.53, -18.57, 193.51), animation = {'timetable@ron@ig_3_couch', 'base'}},
                },
                sleeping = {
                    coords = vector4(-0.32, 0.06, -18.27, 167.96),
                    animation = {'anim@amb@nightclub@lazlow@lo_sofa@', 'lowsofa_dlg_fuckedup_laz'},
                },
            },
        },
        requirements = {
            [1] = "You need Lockpick.",
        },
        informations = {
            
        },
    },
    ['3'] = {
        image = 'house_3.png',
        address = {street = 'Route 68', zone = 'Harmony'},
        difficultyLevel = 1, -- 1 / 2 / 3
        
        lockpickType = 'normal', -- CL.Lockpick
        lockpickItem = 'lockpick',
        lockpickRemove = 1, -- 0 = Don't remove, 1 = Remove on use, 2 = Remove only on done
        
        robberyTimeout = 50 * 60, -- 45 minutes

        requiredPolices = 0,

        interior = 'Motel',
        enterCoords = vector4(379.84, 2629.43, 44.67, 33.13),
        loot = {
            [1] = {
                coords = vector4(150.79, -1003.08, -100.0, 84.57),
                targetSize = vector3(1.2, 0.5, 2.0),
                isCabinet = true,
                animation = {"anim@scripted@cbr1@ig1_washmach_grab_cash@heeled@", "grab", 1500, 1},
                probablyLoots = {
                    ['money_bundle_1'] = {spawnChance = 70, count = {300, 800}},
                    ['money_bundle_2'] = {spawnChance = 60, count = {700, 3500}},
                    ['bleuterd_champagne'] = {spawnChance = 64, count = 1},
                    ['bong'] = {spawnChance = 72, count = 1},
                    ['cocaine'] = {spawnChance = 55, count = {15, 25}},
                    ['perfume'] = {spawnChance = 80, count = 1},
                },
            },
            [2] = {
                coords = vector4(155.37, -1003.3, -99.23, 260.36),
                animation = {"anim@scripted@player@freemode@tun_prep_grab_midd_ig3@heeled@", "tun_prep_grab_midd_ig3", 800, 1},
                probablyLoots = {
                    ['money_bundle_2'] = {spawnChance = 60, count = {700, 3500}},
                    ['perfume'] = {spawnChance = 80, count = 1},
                },
            },
            [3] = {
                coords = vector4(150.41, -1006.89, -99.23, 90.88),
                animation = {"anim@scripted@player@freemode@tun_prep_ig3_grab_high@heeled@", "tun_prep_ig3_grab_high", 1300, 1},
                probablyLoots = {
                    ['golden_sales_certificate'] = {spawnChance = 65, count = 1},
                },
            },
            [4] = {
                coords = vector4(150.91, -1001.44, -99.45, 93.67),
                animation = {"anim@scripted@cbr1@ig1_washmach_grab_cash@heeled@", "grab", 1500, 1},
                probablyLoots = {
                    ['money_bundle_1'] = {spawnChance = 68, count = {300, 800}},
                    ['money_bundle_2'] = {spawnChance = 55, count = {700, 3500}},
                    ['vase_1'] = {spawnChance = 60, count = 1},
                    ['bong'] = {spawnChance = 65, count = 1},
                    ['dj'] = {spawnChance = 72, count = 1},
                },
            },
        },
        tenants = {
            [1] = {
                model = 'a_m_m_og_boss_01',
                isArmedWith = 'weapon_combatpistol', -- when the player wakes him up, attacks him with this weapon
                hoursAtHome = {7, 10}, -- Tenant 1 will be home from 7:00 to 10:00 and will not sleep
                hoursAreSleeping = {22, 6}, -- Tenant 1 will sleep from 22:00 to 6:00
                activitesAtHome = {
                    {coords = vector4(154.25, -1002.81, -100.0, 109.71), animation = {'timetable@ron@ig_3_couch', 'base'}},
                    {coords = vector4(154.64, -1001.19, -100.0, 87.28), animation = {'timetable@ron@ig_3_couch', 'base'}},
                },
                sleeping = {
                    coords = vector4(154.32, -1004.91, -99.42, 2.1),
                    animation = {'anim@amb@nightclub@lazlow@lo_sofa@', 'lowsofa_dlg_fuckedup_laz'},
                },
            },
        },
        requirements = {
            [1] = "You need Lockpick.",
        },
        informations = {
            
        },
    },
    ['4'] = {
        image = 'house_4.png',
        address = {street = 'Meteor St', zone = 'Downtown Vinewood'},
        difficultyLevel = 1, -- 1 / 2 / 3
        
        lockpickType = 'normal', -- CL.Lockpick
        lockpickItem = 'lockpick',
        lockpickRemove = 1, -- 0 = Don't remove, 1 = Remove on use, 2 = Remove only on done
        
        robberyTimeout = 65 * 60, -- 65 minutes

        requiredPolices = 0,

        interior = 'modernhotel_shell',
        enterCoords = vector4(525.96, 207.36, 104.74, 70.72),
        loot = {
            [1] = {
                coords = vector4(6.39, 0.07, -18.88, 271.79),
                animation = {"anim@scripted@player@freemode@tun_prep_ig3_grab_high@heeled@", "tun_prep_ig3_grab_high", 1300, 1},
                probablyLoots = {
                    ['tv'] = {spawnChance = 75, count = 1},
                },
            },
            [2] = {
                coords = vector4(0.02, 2.03, -19.36, 309.99),
                animation = {"anim@scripted@cbr1@ig1_washmach_grab_cash@heeled@", "grab", 1500, 1},
                probablyLoots = {
                    ['laptop'] = {spawnChance = 75, count = 1},
                    ['dj'] = {spawnChance = 65, count = 1},
                },
            },
            [3] = {
                coords = vector4(-4.27, 4.18, -18.88, 0.38),
                animation = {"anim@scripted@player@freemode@tun_prep_ig3_grab_high@heeled@", "tun_prep_ig3_grab_high", 1300, 1},
                probablyLoots = {
                    ['perfume'] = {spawnChance = 80, count = 1},
                },
            },
            [4] = {
                coords = vector4(5.81, 1.44, -19.83, 285.12),
                animation = {"veh@common@motorbike@low@ps", "pickup", 700, 1},
                probablyLoots = {
                    ['speaker'] = {spawnChance = 74, count = 1},
                },
            },
            [5] = {
                coords = vector4(-1.38, -4.19, -19.83, 180.0),
                targetSize = vector3(1.6, 1.1, 5.0),
                isCabinet = true,
                animation = {"anim@scripted@cbr1@ig1_washmach_grab_cash@heeled@", "grab", 1500, 1},
                probablyLoots = {
                    ['perfume'] = {spawnChance = 80, count = 1},
                    ['laptop'] = {spawnChance = 75, count = 1},
                },
            },
            [6] = {
                coords = vector4(-6.81, -2.83, -19.83, 90.0),
                isSafe = 'prop_ld_int_safe_01',
                animation = {"anim@scripted@cbr1@ig1_washmach_grab_cash@heeled@", "grab", 1500, 1},
                money = 'cash',
                count = {340, 1620},
            },
        },
        tenants = {
            [1] = {
                model = 'a_m_m_prolhost_01',
                isArmedWith = 'weapon_combatpistol', -- when the player wakes him up, attacks him with this weapon
                hoursAtHome = {7, 10}, -- Tenant 1 will be home from 7:00 to 10:00 and will not sleep
                hoursAreSleeping = {22, 6}, -- Tenant 1 will sleep from 22:00 to 6:00
                activitesAtHome = {
                    {coords = vector4(1.39, 3.09, -18.83, 163.95), animation = {'timetable@ron@ig_3_couch', 'base'}},
                    -- {coords = vector4(-4.09, 0.95, -18.94, 298.27), animation = {'misscarsteal4@aliens', 'rehearsal_base_idle_director'}},
                    -- {coords = vector4(5.33, 5.44, -18.73, 198.8), animation = {'timetable@ron@ig_3_couch', 'base'}},
                },
                sleeping = {
                    coords = vector4(-4.89, 0.51, -18.11, 183.17),
                    animation = {'anim@amb@nightclub@lazlow@lo_sofa@', 'lowsofa_dlg_fuckedup_laz'},
                },
            },
        },
        requirements = {
            [1] = "You need Lockpick.",
        },
        informations = {
            
        },
    },

    -- ███╗   ███╗███████╗██████╗ ██╗██╗   ██╗███╗   ███╗
    -- ████╗ ████║██╔════╝██╔══██╗██║██║   ██║████╗ ████║
    -- ██╔████╔██║█████╗  ██║  ██║██║██║   ██║██╔████╔██║
    -- ██║╚██╔╝██║██╔══╝  ██║  ██║██║██║   ██║██║╚██╔╝██║
    -- ██║ ╚═╝ ██║███████╗██████╔╝██║╚██████╔╝██║ ╚═╝ ██║
    -- ╚═╝     ╚═╝╚══════╝╚═════╝ ╚═╝ ╚═════╝ ╚═╝     ╚═╝    
    ['5'] = {
        image = 'house_5.png',
        address = {street = 'Ace Jones Dr', zone = 'Richman'},
        difficultyLevel = 2, -- 1 / 2 / 3
        
        lockpickType = 'advanced', -- CL.Lockpick
        lockpickItem = 'lockpick_advanced',
        lockpickRemove = 1, -- 0 = Don't remove, 1 = Remove on use, 2 = Remove only on done
        
        robberyTimeout = 90 * 60, -- 90 minutes

        requiredPolices = 5,

        interior = 'furnitured_midapart',
        enterCoords = vector4(-1673.18, 385.66, 89.35, 350.56),
        turnOffElectricity = vector4(-1688.88, 379.18, 85.12, 257.5),
        loot = {
            [1] = {
                coords = vector4(0.53, 1.37, -19.01, 97.51),
                animation = {"anim@scripted@player@mission@tun_table_grab@gold@", "grab", 900, },
                probablyLoots = {
                    ['laptop'] = {spawnChance = 60, count = 1},
                    ['cigars'] = {spawnChance = 60, count = 1},
                    ['art_2'] = {spawnChance = 30, count = 1},
                },
            },
            [2] = {
                coords = vector4(7.31, 6.57, -19.94, 270.62),
                animation = {"anim@scripted@player@freemode@tun_prep_ig1_grab_low@male@", "grab_low", 800, 1},
                probablyLoots = {
                    ['dj'] = {spawnChance = 47, count = 1},
                },
            },
            [3] = {
                coords = vector4(-7.11, 8.76, -19.9, 65.77),
                animation = {"veh@common@motorbike@low@ps", "pickup", 700, 1},
                probablyLoots = {
                    ['speaker'] = {spawnChance = 50, count = 1},
                    ['pc'] = {spawnChance = 44, count = 1},
                },
            },
            [4] = {
                coords = vector4(-3.04, -1.06, -18.93, 158.59),
                animation = {"anim@scripted@player@freemode@tun_prep_ig3_grab_high@heeled@", "tun_prep_ig3_grab_high", 1300, 1},
                probablyLoots = {
                    ['toaster'] = {spawnChance = 55, count = 1},
                    ['mixer'] = {spawnChance = 70, count = 1},
                    ['microwave'] = {spawnChance = 60, count = 1},
                },
            },
            [5] = {
                coords = vector4(-0.57, -0.12, -18.87, 253.92),
                animation = {"anim@scripted@player@freemode@tun_prep_ig3_grab_high@heeled@", "tun_prep_ig3_grab_high", 1300, 1},
                probablyLoots = {
                    ['pot'] = {spawnChance = 90, count = 1},
                },
            },
            [6] = {
                coords = vector4(-3.58, 1.16, -18.85, 6.82),
                animation = {"anim@scripted@player@freemode@tun_prep_ig3_grab_high@heeled@", "tun_prep_ig3_grab_high", 1300, 1},
                probablyLoots = {
                    ['kettle'] = {spawnChance = 68, count = 1},
                    ['mixer'] = {spawnChance = 70, count = 1},
                    ['bong'] = {spawnChance = 75, count = 1},
                },
            },
            [7] = {
                coords = vector4(1.65, 9.03, -19.0, 181.0),
                animation = {"anim@scripted@player@freemode@tun_prep_grab_midd_ig3@heeled@", "tun_prep_grab_midd_ig3", 800, 1},
                probablyLoots = {
                    ['perfume'] = {spawnChance = 55, count = 1},
                },
            },
            [8] = {
                coords = vector4(6.21, 2.84, -19.2, 190.67),
                animation = {"anim@scripted@player@freemode@tun_prep_ig3_grab_high@heeled@", "tun_prep_ig3_grab_high", 1300, 1},
                probablyLoots = {
                    ['tv'] = {spawnChance = 65, count = 1},
                },
            },
            [9] = {
                coords = vector4(3.69, 7.87, -19.94, 90.0),
                targetSize = vector3(0.7, 0.6, 1.9),
                isCabinet = true,
                animation = {"anim@scripted@cbr1@ig1_washmach_grab_cash@heeled@", "grab", 1500, 1},
                probablyLoots = {
                    ['money_bundle_1'] = {spawnChance = 60, count = {1200, 2900}},
                    ['necklace_2'] = {spawnChance = 25, count = 1},
                    ['necklace_3'] = {spawnChance = 25, count = 1},
                    ['watch_2'] = {spawnChance = 22, count = 1},
                    ['cocaine'] = {spawnChance = 48, count = {5, 12}},
                    ['weapon_pistol'] = {spawnChance = 45, count = 1},
                },
            },
        },
        tenants = {
            [1] = {
                model = 'g_m_y_ballasout_01',
                isArmedWith = 'weapon_bat', -- when the player wakes him up, attacks him with this weapon
                hoursAtHome = {7, 10}, -- Tenant 1 will be home from 7:00 to 10:00 and will not sleep
                hoursAreSleeping = {22, 6}, -- Tenant 1 will sleep from 22:00 to 6:00
                activitesAtHome = {
                    {coords = vector4(-2.83, 5.83, -18.93, 76.24), animation = {'timetable@ron@ig_3_couch', 'base'}},
                    {coords = vector4(-4.09, 0.95, -18.94, 298.27), animation = {'misscarsteal4@aliens', 'rehearsal_base_idle_director'}},
                    {coords = vector4(5.33, 5.44, -18.73, 198.8), animation = {'timetable@ron@ig_3_couch', 'base'}},
                },
                sleeping = {
                    coords = vector4(4.68, 6.67, -18.28, 167.79),
                    animation = {'anim@amb@nightclub@lazlow@lo_sofa@', 'lowsofa_dlg_fuckedup_laz'},
                },
            },
        },
        laserDetectors = {
            {startCoords = vector3(3.68, 2.49, -19.3), endCoords = vector3(3.43, 5.38, -19.3)},
            {startCoords = vector3(-3.38, 2.41, -19.3), endCoords = vector3(1.17, 5.33, -19.3)},
        },
        requirements = {
            [1] = "You need Lockpick Advanced.",
        },
        informations = {
            [1] = {icon = "fa-solid fa-key", placeholder = 'Security Information.', information = 'The house is secured inside with detection lasers.', price = 350},
            [2] = {icon = "fa-solid fa-user", placeholder = 'Tenant Information.', information = 'Tenant may have firearms with them.', price = 400},
            [3] = {icon = "fa-solid fa-user", placeholder = 'Tenant Information.', information = 'Tenant tenant is not at home at night.', price = 1000},
            [4] = {icon = "fa-solid fa-user", placeholder = 'Tenant Information.', information = 'Tenant is out of the house between 11:00 and 21:00.', price = 1000},
        },
    },
    ['6'] = {
        image = 'house_6.png',
        address = {street = 'Ace Jones Dr', zone = 'Vinewood Hills'},
        difficultyLevel = 2, -- 1 / 2 / 3
        
        lockpickType = 'advanced', -- CL.Lockpick
        lockpickItem = 'lockpick_advanced',
        lockpickRemove = 1, -- 0 = Don't remove, 1 = Remove on use, 2 = Remove only on done
        
        robberyTimeout = 90 * 60, -- 90 minutes

        requiredPolices = 5,

        interior = 'furnitured_midapart',
        enterCoords = vector4(-931.83, 809.14, 184.78, 185.54),
        turnOffElectricity = vector4(-922.21, 823.76, 184.34, 183.81),
        loot = {
            [1] = {
                coords = vector4(3.33, -1.78, -19.0, 270.0),
                animation = {"anim@scripted@player@freemode@tun_prep_ig3_grab_high@heeled@", "tun_prep_ig3_grab_high", 1300, 1},
                probablyLoots = {
                    ['painting_1'] = {spawnChance = 30, count = 1},
                    ['painting_2'] = {spawnChance = 30, count = 1},
                    ['painting_3'] = {spawnChance = 32, count = 1},
                    ['wallart_1'] = {spawnChance = 65, count = 1},
                },
            },
            [2] = {
                coords = vector4(0.4, 1.2, -19.97, 90.0),
                targetSize = vector3(1.5, 0.8, 2.3),
                isCabinet = true,
                animation = {"anim@scripted@cbr1@ig1_washmach_grab_cash@heeled@", "grab", 1500, 1},
                probablyLoots = {
                    ['cigars'] = {spawnChance = 42, count = 1},
                    ['watch_1'] = {spawnChance = 20, count = 1},
                    ['perfume'] = {spawnChance = 65, count = 1},
                    ['weapon_pistol'] = {spawnChance = 35, count = 1},
                },
            },
            [3] = {
                coords = vector4(-0.28, -0.91, -18.93, 210.19),
                animation = {"anim@scripted@player@freemode@tun_prep_ig3_grab_high@heeled@", "tun_prep_ig3_grab_high", 1300, 1},
                probablyLoots = {
                    ['pot'] = {spawnChance = 70, count = 1},
                    ['kettle'] = {spawnChance = 70, count = 1},
                    ['toaster'] = {spawnChance = 75, count = 1},
                },
            },
            [4] = {
                coords = vector4(-2.96, -1.06, -18.98, 154.24),
                animation = {"anim@scripted@player@freemode@tun_prep_ig3_grab_high@heeled@", "tun_prep_ig3_grab_high", 1300, 1},
                probablyLoots = {
                    ['mixer'] = {spawnChance = 78, count = 1},
                    ['microwave'] = {spawnChance = 70, count = 1},
                },
            },
            [5] = {
                coords = vector4(-6.5, 1.27, -19.17, 249.91),
                animation = {"anim@scripted@player@mission@tun_table_grab@gold@", "grab", 900, 1},
                probablyLoots = {
                    ['camera'] = {spawnChance = 62, count = 1},
                    ['car_toy_1'] = {spawnChance = 70, count = 1},
                    ['bleuterd_champagne'] = {spawnChance = 65, count = 1},
                    ['bong'] = {spawnChance = 80, count = 1},
                    ['cocaine'] = {spawnChance = 40, count = {4, 14}},
                    ['perfume'] = {spawnChance = 70, count = 1},
                },
            },
            [6] = {
                coords = vector4(-3.68, 6.46, -19.34, 1.67),
                animation = {"anim@scripted@player@fix_chop_petting@male@", "petting", 1700, 1},
                probablyLoots = {
                    ['car_toy_2'] = {spawnChance = 70, count = 1},
                    ['art_1'] = {spawnChance = 50, count = 1},
                    ['art_3'] = {spawnChance = 45, count = 1},
                    ['cigars'] = {spawnChance = 57, count = 1},
                },
            },
            [7] = {
                coords = vector4(-6.08, 8.52, -19.25, 90.0),
                animation = {"anim@scripted@player@freemode@tun_prep_grab_midd_ig3@heeled@", "tun_prep_grab_midd_ig3", 800, 1},
                probablyLoots = {
                    ['laptop'] = {spawnChance = 70, count = 1},
                    ['money_counter'] = {spawnChance = 70, count = 1},
                },
            },
            [8] = {
                coords = vector4(7.43, 3.96, -19.94, 270.0),
                targetSize = vector3(1.3, 0.7, 1.2),
                isCabinet = true,
                animation = {"anim@scripted@cbr1@ig1_washmach_grab_cash@heeled@", "grab", 1500, 1},
                probablyLoots = {
                    ['necklace_2'] = {spawnChance = 24, count = 1},
                    ['golden_sales_certificate'] = {spawnChance = 58, count = 1},
                    ['tv'] = {spawnChance = 70, count = 1},
                    ['monitor'] = {spawnChance = 65, count = 1},
                },
            },
            [9] = {
                coords = vector4(3.6, 7.9, -19.94, 90.0),
                targetSize = vector3(0.7, 0.7, 1.8),
                isCabinet = true,
                animation = {"anim@scripted@cbr1@ig1_washmach_grab_cash@heeled@", "grab", 1500, 1},
                probablyLoots = {
                    ['money_bundle_1'] = {spawnChance = 50, count = {400, 1200}},
                    ['money_bundle_2'] = {spawnChance = 35, count = {2000, 4000}},
                    ['car_toy_2'] = {spawnChance = 68, count = 1},
                    ['watch_2'] = {spawnChance = 20, count = 1},
                    ['bong'] = {spawnChance = 75, count = 1},
                    ['cocaine'] = {spawnChance = 40, count = {2, 10}},
                },
            },
            [10] = {
                coords = vector4(5.99, 9.91, -19.94, 0.0),
                targetSize = vector3(1.3, 0.7, 4.8),
                isCabinet = true,
                animation = {"anim@scripted@cbr1@ig1_washmach_grab_cash@heeled@", "grab", 1500, 1},
                probablyLoots = {
                    ['dj'] = {spawnChance = 62, count = 1},
                    ['speaker'] = {spawnChance = 65, count = 1},
                    ['pc'] = {spawnChance = 72, count = 1},
                },
            },
        },
        tenants = {
            [1] = {
                model = 'g_m_y_ballasout_01',
                isArmedWith = 'weapon_bat', -- when the player wakes him up, attacks him with this weapon
                hoursAtHome = {7, 10}, -- Tenant 1 will be home from 7:00 to 10:00 and will not sleep
                hoursAreSleeping = {22, 6}, -- Tenant 1 will sleep from 22:00 to 6:00
                activitesAtHome = {
                    {coords = vector4(-2.83, 5.83, -18.93, 76.24), animation = {'timetable@ron@ig_3_couch', 'base'}},
                    {coords = vector4(-4.09, 0.95, -18.94, 298.27), animation = {'misscarsteal4@aliens', 'rehearsal_base_idle_director'}},
                    {coords = vector4(5.33, 5.44, -18.73, 198.8), animation = {'timetable@ron@ig_3_couch', 'base'}},
                },
                sleeping = {
                    coords = vector4(4.68, 6.67, -18.28, 167.79),
                    animation = {'anim@amb@nightclub@lazlow@lo_sofa@', 'lowsofa_dlg_fuckedup_laz'},
                },
            },
        },
        laserDetectors = {
            {startCoords = vector3(3.53, -2.91, -19.7), endCoords = vector3(-0.03, -2.99, -19.7)},
            {startCoords = vector3(3.87, 4.76, -19.1), endCoords = vector3(3.88, 2.87, -19.1)},
        },
        requirements = {
            [1] = "You need Lockpick Advanced.",
        },
        informations = {
            [1] = {icon = "fa-solid fa-key", placeholder = 'Security Information.', information = 'The house is secured inside with detection lasers.', price = 350},
            [2] = {icon = "fa-solid fa-user", placeholder = 'Tenant Information.', information = 'Tenant may have firearms with them.', price = 400},
            [3] = {icon = "fa-solid fa-user", placeholder = 'Tenant Information.', information = 'Tenant tenant is not at home at night.', price = 1000},
            [4] = {icon = "fa-solid fa-user", placeholder = 'Tenant Information.', information = 'Tenant is out of the house between 11:00 and 21:00.', price = 1000},
        },
    },
    ['7'] = {
        image = 'house_7.png',
        address = {street = 'North Rockford Dr', zone = 'Vinewood Hills'},
        difficultyLevel = 2, -- 1 / 2 / 3
        
        lockpickType = 'advanced', -- CL.Lockpick
        lockpickItem = 'lockpick_advanced',
        lockpickRemove = 1, -- 0 = Don't remove, 1 = Remove on use, 2 = Remove only on done
        
        robberyTimeout = 90 * 60, -- 90 minutes

        requiredPolices = 5,

        interior = 'furnitured_midapart',
        enterCoords = vector4(-1896.23, 642.5, 130.21, 138.63),
        turnOffElectricity = vector4(-1887.98, 631.73, 130.0, 315.62),
        loot = {
            [1] = {
                coords = vector4(0.75, 5.95, -19.335, 281.16),
                animation = {"anim@scripted@player@fix_chop_petting@male@", "petting", 1700, 1},
                probablyLoots = {
                    ['laptop'] = {spawnChance = 65, count = 1},
                    ['microwave'] = {spawnChance = 55, count = 1},
                },
            },
            [2] = {
                coords = vector4(-3.66, 6.67, -19.33, 69.0),
                animation = {"anim@scripted@player@freemode@tun_prep_grab_midd_ig3@heeled@", "tun_prep_grab_midd_ig3", 800, 1},
                probablyLoots = {
                    ['cigars'] = {spawnChance = 62, count = 1},
                    ['vase_1'] = {spawnChance = 55, count = 1},
                    ['money_counter'] = {spawnChance = 75, count = 1},
                    ['bong'] = {spawnChance = 80, count = 1},
                },
            },
            [3] = {
                coords = vector4(-5.88, 1.58, -19.17, 172.86),
                animation = {"anim@scripted@player@mission@tun_table_grab@gold@", "grab", 900, 1},
                probablyLoots = {
                    ['money_bundle_2'] = {spawnChance = 40, count = {750, 1420}},
                    ['art_3'] = {spawnChance = 60, count = 1},
                    ['car_toy_1'] = {spawnChance = 50, count = 1},
                    ['cocaine'] = {spawnChance = 28, count = {5, 12}},
                    ['perfume'] = {spawnChance = 60, count = 1},
                },
            },
            [4] = {
                coords = vector4(-7.34, 3.62, -19.93, 107.44),
                animation = {"veh@common@motorbike@low@ps", "pickup", 700, 1},
                probablyLoots = {
                    ['speaker'] = {spawnChance = 65, count = 1},
                },
            },
            [5] = {
                coords = vector4(-2.83, -1.09, -18.92, 167.74),
                animation = {"anim@scripted@player@freemode@tun_prep_ig3_grab_high@heeled@", "tun_prep_ig3_grab_high", 1300, 1},
                probablyLoots = {
                    ['knife_block'] = {spawnChance = 65, count = 1},
                    ['pot'] = {spawnChance = 68, count = 1},
                    ['kettle'] = {spawnChance = 74, count = 1},
                    ['toaster'] = {spawnChance = 80, count = 1},
                },
            },
            [6] = {
                coords = vector4(-3.3, 1.07, -18.99, 73.48),
                animation = {"anim@scripted@player@freemode@tun_prep_ig3_grab_high@heeled@", "tun_prep_ig3_grab_high", 1300, 1},
                probablyLoots = {
                    ['mixer'] = {spawnChance = 65, count = 1},
                    ['kettle'] = {spawnChance = 65, count = 1},
                },
            },
            [7] = {
                coords = vector4(6.19, 2.96, -19.95, 180.0),
                targetSize = vector3(1.45, 0.7, 2.0),
                isCabinet = true,
                animation = {"anim@scripted@cbr1@ig1_washmach_grab_cash@heeled@", "grab", 1500, 1},
                probablyLoots = {
                    ['money_bundle_1'] = {spawnChance = 45, count = {500, 1000}},
                    ['money_bundle_2'] = {spawnChance = 38, count = {700, 2560}},
                    ['art_2'] = {spawnChance = 60, count = 1},
                    ['camera'] = {spawnChance = 68, count = 1},
                    ['car_toy_2'] = {spawnChance = 74, count = 1},
                    ['bong'] = {spawnChance = 80, count = 1},
                },
            },
            [8] = {
                coords = vector4(3.58, 7.9, -19.94, 90.0),
                targetSize = vector3(0.7, 0.75, 2.0),
                isCabinet = true,
                animation = {"anim@scripted@cbr1@ig1_washmach_grab_cash@heeled@", "grab", 1500, 1},
                probablyLoots = {
                    ['necklace_2'] = {spawnChance = 25, count = 1},
                    ['necklace_3'] = {spawnChance = 25, count = 1},
                    ['watch_1'] = {spawnChance = 20, count = 1},
                    ['cigars'] = {spawnChance = 70, count = 1},
                    ['perfume'] = {spawnChance = 70, count = 1},
                },
            },
            [9] = {
                coords = vector4(5.99, 9.85, -19.94, 0.0),
                targetSize = vector3(1.4, 0.55, 4.7),
                isCabinet = true,
                animation = {"anim@scripted@cbr1@ig1_washmach_grab_cash@heeled@", "grab", 1500, 1},
                probablyLoots = {
                    ['cocaine'] = {spawnChance = 40, count = {10, 18}},
                    ['perfume'] = {spawnChance = 60, count = 1},
                    ['dj'] = {spawnChance = 68, count = 1},
                    ['pc'] = {spawnChance = 70, count = 1},
                },
            },
            [10] = {
                coords = vector4(0.2, -1.6, -19.0, 90.0),
                animation = {"anim@scripted@player@freemode@tun_prep_ig3_grab_high@heeled@", "tun_prep_ig3_grab_high", 1300, 1},
                probablyLoots = {
                    ['painting_1'] = {spawnChance = 30, count = 1},
                    ['painting_2'] = {spawnChance = 30, count = 1},
                    ['painting_3'] = {spawnChance = 32, count = 1},
                    ['wallart_1'] = {spawnChance = 65, count = 1},
                },
            },
        },
        tenants = {
            [1] = {
                model = 'g_m_y_ballasout_01',
                isArmedWith = 'weapon_bat', -- when the player wakes him up, attacks him with this weapon
                hoursAtHome = {7, 10}, -- Tenant 1 will be home from 7:00 to 10:00 and will not sleep
                hoursAreSleeping = {22, 6}, -- Tenant 1 will sleep from 22:00 to 6:00
                activitesAtHome = {
                    {coords = vector4(-2.83, 5.83, -18.93, 76.24), animation = {'timetable@ron@ig_3_couch', 'base'}},
                    {coords = vector4(-4.09, 0.95, -18.94, 298.27), animation = {'misscarsteal4@aliens', 'rehearsal_base_idle_director'}},
                    {coords = vector4(5.33, 5.44, -18.73, 198.8), animation = {'timetable@ron@ig_3_couch', 'base'}},
                },
                sleeping = {
                    coords = vector4(4.68, 6.67, -18.28, 167.79),
                    animation = {'anim@amb@nightclub@lazlow@lo_sofa@', 'lowsofa_dlg_fuckedup_laz'},
                },
            },
        },
        laserDetectors = {
            {startCoords = vector3(3.94, 2.84, -19.6), endCoords = vector3(3.76, 4.75, -19.6)},
        },
        requirements = {
            [1] = "You need Lockpick Advanced.",
        },
        informations = {
            [1] = {icon = "fa-solid fa-key", placeholder = 'Security Information.', information = 'The house is secured inside with detection lasers.', price = 350},
            [2] = {icon = "fa-solid fa-user", placeholder = 'Tenant Information.', information = 'Tenant may have firearms with them.', price = 400},
            [3] = {icon = "fa-solid fa-user", placeholder = 'Tenant Information.', information = 'Tenant tenant is not at home at night.', price = 1000},
            [4] = {icon = "fa-solid fa-user", placeholder = 'Tenant Information.', information = 'Tenant is out of the house between 11:00 and 21:00.', price = 1000},
        },
    },
    ['8'] = {
        image = 'house_8.png',
        address = {street = 'North Rockford Dr', zone = 'Banham Canyon'},
        difficultyLevel = 2, -- 1 / 2 / 3
        
        lockpickType = 'advanced', -- CL.Lockpick
        lockpickItem = 'lockpick_advanced',
        lockpickRemove = 1, -- 0 = Don't remove, 1 = Remove on use, 2 = Remove only on done
        
        robberyTimeout = 90 * 60, -- 90 minutes

        requiredPolices = 5,

        interior = 'furnitured_midapart',
        enterCoords = vector4(-2014.55, 499.71, 107.17, 255.21),
        turnOffElectricity = vector4(-2017.04, 481.55, 107.15, 78.16),
        loot = {
            [1] = {
                coords = vector4(6.18, 2.89, -19.94, 180.0),
                targetSize = vector3(1.4, 0.85, 2.0),
                isCabinet = true,
                animation = {"anim@scripted@cbr1@ig1_washmach_grab_cash@heeled@", "grab", 1500, 1},
                probablyLoots = {
                    ['money_bundle_1'] = {spawnChance = 58, count = {200, 2100}},
                    ['camera'] = {spawnChance = 82, count = 1},
                    ['dvd'] = {spawnChance = 88, count = 1},
                },
            },
            [2] = {
                coords = vector4(3.59, 7.89, -19.94, 90.0),
                targetSize = vector3(0.7, 0.7, 2.0),
                isCabinet = true,
                animation = {"anim@scripted@cbr1@ig1_washmach_grab_cash@heeled@", "grab", 1500, 1},
                probablyLoots = {
                    ['car_toy_1'] = {spawnChance = 70, count = 1},
                    ['money_counter'] = {spawnChance = 60, count = 1},
                    ['watch_1'] = {spawnChance = 15, count = 1},
                    ['laptop'] = {spawnChance = 65, count = 1},
                },
            },
            [3] = {
                coords = vector4(5.99, 9.93, -19.94, 0.0),
                targetSize = vector3(1.4, 0.6, 4.7),
                isCabinet = true,
                animation = {"anim@scripted@player@freemode@tun_prep_ig3_grab_high@heeled@", "tun_prep_ig3_grab_high", 1300, 1},
                probablyLoots = {
                    ['dj'] = {spawnChance = 70, count = 1},
                    ['statue_art_1'] = {spawnChance = 50, count = 1},
                    ['monitor'] = {spawnChance = 61, count = 1},
                    ['pc'] = {spawnChance = 85, count = 1},
                },
            },
            [4] = {
                coords = vector4(-3.62, 6.67, -19.39, 93.86),
                animation = {"anim@scripted@player@freemode@tun_prep_grab_midd_ig3@heeled@", "tun_prep_grab_midd_ig3", 800, 1},
                probablyLoots = {
                    ['laptop'] = {spawnChance = 70, count = 1},
                    ['money_counter'] = {spawnChance = 64, count = 1},
                    ['car_toy_2'] = {spawnChance = 59, count = 1},
                },
            },
            [5] = {
                coords = vector4(-5.73, 1.83, -19.17, 165.14),
                animation = {"anim@scripted@player@mission@tun_table_grab@gold@", "grab", 900, 1},
                probablyLoots = {
                    ['cigars'] = {spawnChance = 70, count = 1},
                    ['bong'] = {spawnChance = 68, count = 1},
                    ['bleuterd_champagne'] = {spawnChance = 68, count = 1},
                },
            },
            [6] = {
                coords = vector4(-2.64, -1.07, -18.96, 169.64),
                animation = {"anim@scripted@player@freemode@tun_prep_ig3_grab_high@heeled@", "tun_prep_ig3_grab_high", 1300, 1},
                probablyLoots = {
                    ['kettle'] = {spawnChance = 70, count = 1},
                    ['toaster'] = {spawnChance = 70, count = 1},
                    ['knife_block'] = {spawnChance = 70, count = 1},
                },
            },
            [7] = {
                coords = vector4(-3.46, 0.95, -18.88, 83.29),
                animation = {"anim@scripted@player@freemode@tun_prep_ig3_grab_high@heeled@", "tun_prep_ig3_grab_high", 1300, 1},
                probablyLoots = {
                    ['mixer'] = {spawnChance = 70, count = 1},
                },
            },
        },
        tenants = {
            [1] = {
                model = 's_m_y_robber_01',
                isArmedWith = 'weapon_microsmg', -- when the player wakes him up, attacks him with this weapon
                hoursAtHome = {15, 21}, -- Tenant 1 will be home from 15:00 to 21:00 and will not sleep
                hoursAreSleeping = {6, 14}, -- Tenant 1 will sleep from 6:00 to 14:00
                activitesAtHome = {
                    {coords = vector4(6.9, 4.04, -19.86, 90.95), animation = {'timetable@ron@ig_3_couch', 'base'}},
                    {coords = vector4(-2.77, 6.15, -19.79, 92.77), animation = {'timetable@ron@ig_3_couch', 'base'}},
                    {coords = vector4(-5.07, 7.93, -19.93, 194.96), animation = {'timetable@ron@ig_3_couch', 'base'}},
                },
                sleeping = {
                    coords = vector4(4.67, 6.87, -19.28, 180.74),
                    animation = {'anim@amb@nightclub@lazlow@lo_sofa@', 'lowsofa_dlg_fuckedup_laz'},
                },
            },
        },
        laserDetectors = {
            {startCoords = vector3(3.86, 2.86, -19.25), endCoords = vector3(3.89, 4.68, -19.25)},
            {startCoords = vector3(-0.56, 2.38, -18.93), endCoords = vector3(-6.64, 10.42, -18.93)},
        },
        requirements = {
            [1] = "You need Lockpick Advanced.",
        },
        informations = {
            [1] = {icon = "fa-solid fa-key", placeholder = 'Security Information.', information = 'The house is secured inside with detection lasers and cameras.', price = 350},
            [2] = {icon = "fa-solid fa-key", placeholder = 'Security Information.', information = 'Armed guards are present in the house at all times.', price = 350},
            [3] = {icon = "fa-solid fa-magnifying-glass-dollar", placeholder = 'Loot Information.', information = 'You can find expensive jewelry in the house.', price = 120},
            [4] = {icon = "fa-solid fa-user", placeholder = 'Tenant Information.', information = 'Tenant may have firearms with them.', price = 400},
            [5] = {icon = "fa-solid fa-user", placeholder = 'Tenant Information.', information = 'Tenant tenant is not at home at night.', price = 1000},
            [6] = {icon = "fa-solid fa-user", placeholder = 'Tenant Information.', information = 'Tenant is out of the house between 22:00 and 5:00.', price = 1000},
        },
    },

    -- ██╗  ██╗ █████╗ ██████╗ ██████╗ 
    -- ██║  ██║██╔══██╗██╔══██╗██╔══██╗
    -- ███████║███████║██████╔╝██║  ██║
    -- ██╔══██║██╔══██║██╔══██╗██║  ██║
    -- ██║  ██║██║  ██║██║  ██║██████╔╝
    -- ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝     
    ['9'] = {
        image = 'house_9.png',
        address = {street = 'Didion Dr.', zone = 'Vinewood Hills'},
        difficultyLevel = 3, -- 1 / 2 / 3
        
        lockpickType = 'advanced', -- CL.Lockpick
        lockpickItem = 'lockpick_advanced',
        lockpickRemove = 1, -- 0 = Don't remove, 1 = Remove on use, 2 = Remove only on done
        
        robberyTimeout = 120 * 60, -- 120 minutes

        requiredPolices = 8,

        interior = 'Apt28',
        enterCoords = vector4(-406.44, 567.45, 124.6, 152.91),
        turnOffElectricity = vector4(-402.12, 576.28, 124.62, 152.26),
        loot = {
            [1] = {
                coords = vector4(-39.1, -587.1, 77.83, 68.79),
                isSafe = 'prop_ld_int_safe_01',
                animation = {"anim@scripted@cbr1@ig1_washmach_grab_cash@heeled@", "grab", 1500, 1},
                money = 'cash',
                count = {5000, 20000},
            },
            [2] = {
                coords = vector4(-41.6, -585.03, 78.52, 142.31),
                animation = {"anim@scripted@player@freemode@tun_prep_grab_midd_ig3@heeled@", "tun_prep_grab_midd_ig3", 800, 1},
                probablyLoots = {
                    ['perfume'] = {spawnChance = 82, count = 1},
                },
            },
            [3] = {
                coords = vector4(-25.79, -578.02, 78.23, 20.08),
                animation = {"anim@scripted@player@freemode@tun_prep_ig1_grab_low@male@", "grab_low", 800, 1},
                probablyLoots = {
                    ['flowers_1'] = {spawnChance = 80, count = 1},
                    ['statue_art_2'] = {spawnChance = 60, count = 1},
                    ['statue_art_3'] = {spawnChance = 55, count = 1},
                },
            },
            [4] = {
                coords = vector4(-16.22, -583.22, 79.25, 201.87),
                animation = {"anim@scripted@player@mission@tun_table_grab@gold@", "grab", 900, 1},
                probablyLoots = {
                    ['laptop'] = {spawnChance = 70, count = 1},
                    ['money_bundle_1'] = {spawnChance = 62, count = {300, 800}},
                    ['money_bundle_2'] = {spawnChance = 55, count = {700, 4200}},
                    ['bleuterd_champagne'] = {spawnChance = 72, count = 1},
                },
            },
            [5] = {
                coords = vector4(-13.68, -587.11, 79.385, 31.42),
                animation = {"anim@scripted@player@freemode@tun_prep_grab_midd_ig3@heeled@", "tun_prep_grab_midd_ig3", 800, 1},
                probablyLoots = {
                    ['kettle'] = {spawnChance = 80, count = 1},
                    ['pot'] = {spawnChance = 75, count = 1},
                    ['mixer'] = {spawnChance = 78, count = 1},
                    ['toaster'] = {spawnChance = 82, count = 1},
                },
            },
            [6] = {
                coords = vector4(-11.96, -599.89, 78.43, 161.19),
                targetSize = vector3(2.0, 0.8, 5.3),
                isCabinet = true,
                animation = {"anim@scripted@player@fix_chop_petting@male@", "petting", 3500, 1},
                probablyLoots = {
                    ['weapon_pistol'] = {spawnChance = 30, count = 1},
                },
            },
            [7] = {
                coords = vector4(-7.47, -595.93, 78.43, 247.76),
                animation = {"veh@common@motorbike@low@ps", "pickup", 700, 1},
                probablyLoots = {
                    ['speaker'] = {spawnChance = 60, count = 1},
                    ['pc'] = {spawnChance = 72, count = 1},
                },
            },
            [8] = {
                coords = vector4(-31.97, -583.99, 77.87, 250.0),
                targetSize = vector3(3.3, 0.75, 2.3),
                isCabinet = true,
                animation = {"anim@scripted@cbr1@ig1_washmach_grab_cash@heeled@", "grab", 1500, 1},
                probablyLoots = {
                    ['money_bundle_1'] = {spawnChance = 62, count = {300, 800}},
                    ['money_counter'] = {spawnChance = 62, count = 1},
                    ['bong'] = {spawnChance = 78, count = 1},
                    ['laptop'] = {spawnChance = 70, count = 1},
                    ['watch_1'] = {spawnChance = 21, count = 1},
                },
            },
            [9] = {
                coords = vector3(-39.97, -589.38, 78.77),
                animation = {"anim@scripted@player@mission@tun_table_grab@gold@", "grab", 900, 1},
                probablyLoots = {
                    ['cocaine'] = {spawnChance = 62, count = {12, 26}},
                    ['watch_1'] = {spawnChance = 20, count = 1},
                    ['watch_2'] = {spawnChance = 20, count = 1},
                    ['necklace_2'] = {spawnChance = 25, count = 1},
                },
            },
        },
        tenants = {
            [1] = {
                model = 's_m_m_armoured_01',
                isArmedWith = 'weapon_assaultrifle_mk2', -- when the player wakes him up, attacks him with this weapon
                hoursAtHome = {0, 23}, -- Tenant 1 will be home from 7:00 to 10:00 and will not sleep
                activitesAtHome = {
                    {coords = vector4(-13.98, -588.18, 78.43, 85.47)},
                },
            },
            [2] = {
                model = 's_m_m_armoured_02',
                isArmedWith = 'weapon_specialcarbine_mk2', -- when the player wakes him up, attacks him with this weapon
                hoursAtHome = {0, 23}, -- Tenant 1 will be home from 7:00 to 10:00 and will not sleep
                activitesAtHome = {
                    {coords = vector4(-24.35, -579.28, 78.24, 204.59)},
                },
            },
            [3] = {
                model = 's_m_m_armoured_02',
                isArmedWith = 'weapon_tacticalrifle', -- when the player wakes him up, attacks him with this weapon
                hoursAtHome = {0, 23}, -- Tenant 1 will be home from 7:00 to 10:00 and will not sleep
                activitesAtHome = {
                    {coords = vector4(-36.98, -583.96, 77.83, 237.85)},
                },
            },
            [4] = {
                model = 's_m_m_armoured_02',
                isArmedWith = 'weapon_bullpuprifle_mk2', -- when the player wakes him up, attacks him with this weapon
                hoursAtHome = {0, 23}, -- Tenant 1 will be home from 7:00 to 10:00 and will not sleep
                activitesAtHome = {
                    {coords = vector4(-7.85, -596.86, 78.43, 73.14)},
                },
            },
            [5] = {
                model = 's_m_y_westsec_01',
                isArmedWith = 'weapon_sawnoffshotgun', -- when the player wakes him up, attacks him with this weapon
                hoursAtHome = {7, 18}, -- Tenant 1 will be home from 7:00 to 18:00 and will not sleep
                hoursAreSleeping = {22, 6}, -- Tenant 1 will sleep from 22:00 to 6:00
                activitesAtHome = {
                    {coords = vector4(-25.39, -583.19, 78.23, 251.67), animation = {'timetable@ron@ig_3_couch', 'base'}},
                    {coords = vector4(-26.81, -578.88, 78.23, 242.15), animation = {'timetable@ron@ig_3_couch', 'base'}},
                    {coords = vector4(-21.5, -582.57, 78.23, 72.16), animation = {'timetable@ron@ig_3_couch', 'base'}},
                    {coords = vector4(-34.58, -583.18, 77.9, 252.3), animation = {'timetable@ron@ig_3_couch', 'base'}},
                },
                sleeping = {
                    coords = vector4(-35.89, -582.06, 78.5, 159.85),
                    animation = {'anim@amb@nightclub@lazlow@lo_sofa@', 'lowsofa_dlg_fuckedup_laz'},
                },
            },
        },
        laserDetectors = {
            {startCoords = vector3(-16.03, -590.39, 79.4), endCoords = vector3(-21.26, -589.0, 79.4)},
            {startCoords = vector3(-31.41, -586.22, 78.5), endCoords = vector3(-32.14, -588.1, 78.5)},
        },
        camerasDetectors = {
            {prop = 'hei_prop_bank_cctv_02', propCoords = vector4(-23.48, -582.76, 82.2, 0.0), detectorCoords = vector3(-23.55, -582.78, 78.25), detectorRadius = 4.25}
        },
        requirements = {
            [1] = "You need Lockpick Advanced.",
        },
        informations = {
            [1] = {icon = "fa-solid fa-key", placeholder = 'Security Information.', information = 'The house is secured inside with detection lasers and cameras.', price = 350},
            [2] = {icon = "fa-solid fa-key", placeholder = 'Security Information.', information = 'Armed guards are present in the house at all times.', price = 350},
            [3] = {icon = "fa-solid fa-magnifying-glass-dollar", placeholder = 'Loot Information.', information = 'You can find expensive jewelry in the house.', price = 120},
            [4] = {icon = "fa-solid fa-user", placeholder = 'Tenant Information.', information = 'Tenants may have firearms with them.', price = 400},
            [5] = {icon = "fa-solid fa-user", placeholder = 'Tenant Information.', information = 'Tenants sleep through the night.', price = 1000},
            [6] = {icon = "fa-solid fa-user", placeholder = 'Tenant Information.', information = 'Tenant is out of the house between 19:00 and 21:00.', price = 1000},
        },
    },
    ['10'] = {
        image = 'house_10.png',
        address = {street = 'Wild Oats Dr.', zone = 'Vinewood Hills'},
        difficultyLevel = 3, -- 1 / 2 / 3
        
        lockpickType = 'advanced', -- CL.Lockpick
        lockpickItem = 'lockpick_advanced',
        lockpickRemove = 1, -- 0 = Don't remove, 1 = Remove on use, 2 = Remove only on done
        
        robberyTimeout = 120 * 60, -- 120 minutes = 2 hours

        requiredPolices = 8,

        interior = 'WildOatsDrive',
        enterCoords = vector4(57.65, 449.89, 147.03, 145.92),
        turnOffElectricity = vector4(30.18, 451.0, 146.75, 188.7),
        loot = {
            [1] = {
                coords = vector4(-169.4, 493.48, 137.59, 116.86),
                animation = {"anim@scripted@player@freemode@tun_prep_grab_midd_ig3@heeled@", "tun_prep_grab_midd_ig3", 800, 1},
                probablyLoots = {
                    ['knife_block'] = {spawnChance = 68, count = 1},
                    ['kettle'] = {spawnChance = 58, count = 1},
                    ['toaster'] = {spawnChance = 50, count = 1},
                    ['mixer'] = {spawnChance = 75, count = 1},
                },
            },
            [2] = {
                coords = vector4(-167.58, 488.58, 137.2, 292.83),
                animation = {"anim@scripted@player@mission@tun_table_grab@gold@", "grab", 900, 1},
                probablyLoots = {
                    ['money_bundle_1'] = {spawnChance = 80, count = {300, 800}},
                    ['money_bundle_3'] = {spawnChance = 52, count = {6000, 35000}},
                    ['bleuterd_champagne'] = {spawnChance = 64, count = 1},
                    ['watch_2'] = {spawnChance = 20, count = 1},
                },
            },
            [3] = {
                coords = vector4(-169.67, 479.59, 136.24, 162.53),
                animation = {"veh@common@motorbike@low@ps", "pickup", 700, 1},
                probablyLoots = {
                    ['statue_art_1'] = {spawnChance = 70, count = 1},
                    ['statue_art_2'] = {spawnChance = 52, count = 1},
                },
            },
            [4] = {
                coords = vector4(-166.3, 488.53, 133.35, 359.76),
                animation = {"anim@scripted@player@mission@tun_table_grab@gold@", "grab", 900, 1},
                probablyLoots = {
                    ['cocaine'] = {spawnChance = 56, count = {10, 20}},
                    ['necklace_1'] = {spawnChance = 25, count = 1},
                    ['necklace_2'] = {spawnChance = 25, count = 1},
                    ['necklace_3'] = {spawnChance = 25, count = 1},
                    ['watch_1'] = {spawnChance = 20, count = 1},
                    ['watch_2'] = {spawnChance = 20, count = 1},
                },
            },
            [5] = {
                coords = vector4(-177.98, 491.57, 132.84, 186.36),
                animation = {"veh@common@motorbike@low@ps", "pickup", 700, 1},
                probablyLoots = {
                    ['vase_1'] = {spawnChance = 56, count = 1},
                    ['flowers_1'] = {spawnChance = 85, count = 1},
                },
            },
            [6] = {
                coords = vector4(-175.82, 489.88, 129.76, 118.27),
                animation = {"anim@scripted@player@mission@tun_table_grab@gold@", "grab", 900, 1},
                probablyLoots = {
                    ['money_counter'] = {spawnChance = 75, count = 1},
                    ['cigars'] = {spawnChance = 58, count = 1},
                    ['laptop'] = {spawnChance = 72, count = 1},
                    ['watch_2'] = {spawnChance = 20, count = 1},
                    ['camera'] = {spawnChance = 62, count = 1},
                    ['car_toy_2'] = {spawnChance = 69, count = 1},
                },
            },
            [7] = {
                coords = vector4(-172.6, 489.12, 130.2, 191.23),
                animation = {"anim@scripted@player@freemode@tun_prep_ig3_grab_high@heeled@", "tun_prep_ig3_grab_high", 1300, 1},
                probablyLoots = {
                    ['golden_sales_certificate'] = {spawnChance = 72, count = 1},
                    ['wallart_1'] = {spawnChance = 70, count = 1},
                    ['painting_1'] = {spawnChance = 40, count = 1},
                    ['painting_2'] = {spawnChance = 45, count = 1},
                    ['painting_3'] = {spawnChance = 42, count = 1},
                },
            },
            [8] = {
                coords = vector4(-165.89, 496.25, 133.52, 71.62),
                animation = {"anim@scripted@player@mission@tun_table_grab@gold@", "grab", 900, 1},
                probablyLoots = {
                    ['perfume'] = {spawnChance = 80, count = 1},
                    ['necklace_3'] = {spawnChance = 28, count = 1},
                },
            },
            [9] = {
                coords = vector4(-171.98, 486.73, 136.7, 101.2),
                targetSize = vector3(3.2, 0.75, 1.5),
                isCabinet = true,
                animation = {"anim@scripted@cbr1@ig1_washmach_grab_cash@heeled@", "grab", 1500, 1},
                probablyLoots = {
                    ['laptop'] = {spawnChance = 75, count = 1},
                    ['necklace_1'] = {spawnChance = 15, count = 1},
                    ['dj'] = {spawnChance = 68, count = 1},
                    ['car_toy_1'] = {spawnChance = 80, count = 1},
                    ['dvd'] = {spawnChance = 62, count = 1},
                },
            },
        },
        tenants = {
            [1] = {
                model = 's_m_m_armoured_01',
                isArmedWith = 'weapon_carbinerifle_mk2', -- when the player wakes him up, attacks him with this weapon
                hoursAtHome = {0, 23}, -- Tenant 1 will be home from 7:00 to 10:00 and will not sleep
                activitesAtHome = {
                    {coords = vector4(-162.84, 480.53, 136.27, 48.59)},
                },
            },
            [2] = {
                model = 's_m_m_armoured_02',
                isArmedWith = 'weapon_combatmg_mk2', -- when the player wakes him up, attacks him with this weapon
                hoursAtHome = {0, 23}, -- Tenant 1 will be home from 7:00 to 10:00 and will not sleep
                activitesAtHome = {
                    {coords = vector4(-171.11, 491.49, 132.84, 31.48)},
                },
            },
            [3] = {
                model = 's_m_m_armoured_02',
                isArmedWith = 'weapon_compactrifle', -- when the player wakes him up, attacks him with this weapon
                hoursAtHome = {0, 23}, -- Tenant 1 will be home from 7:00 to 10:00 and will not sleep
                activitesAtHome = {
                    {coords = vector4(-175.39, 492.86, 129.04, 271.5)},
                },
            },
            [4] = {
                model = 's_m_m_highsec_02',
                isArmedWith = 'weapon_minismg', -- when the player wakes him up, attacks him with this weapon
                hoursAtHome = {7, 14}, -- Tenant 1 will be home from 7:00 to 14:00 and will not sleep
                hoursAreSleeping = {22, 6}, -- Tenant 1 will sleep from 22:00 to 6:00
                activitesAtHome = {
                    {coords = vector4(-166.74, 480.91, 136.27, 16.82), animation = {'timetable@ron@ig_3_couch', 'base'}},
                    {coords = vector4(-165.73, 496.52, 136.65, 148.64)},
                },
                sleeping = {
                    coords = vector4(-163.5, 483.96, 133.56, 9.3),
                    animation = {'anim@amb@nightclub@lazlow@lo_sofa@', 'lowsofa_dlg_fuckedup_laz'},
                },
            },
            [5] = {
                model = 's_f_y_clubbar_01',
                isArmedWith = 'weapon_appistol', -- when the player wakes him up, attacks him with this weapon
                hoursAtHome = {6, 16}, -- Tenant 1 will be home from 6:00 to 16:00 and will not sleep
                hoursAreSleeping = {22, 5}, -- Tenant 1 will sleep from 22:00 to 5:00
                activitesAtHome = {
                    {coords = vector4(-164.52, 484.02, 136.27, 145.04), animation = {'timetable@ron@ig_3_couch', 'base'}},
                },
                sleeping = {
                    coords = vector4(-163.56, 483.16, 133.56, 11.31),
                    animation = {'anim@amb@nightclub@lazlow@lo_sofa@', 'lowsofa_dlg_fuckedup_laz'},
                },
            },
        },
        laserDetectors = {
            {startCoords = vector3(-163.3, 491.26, 137.01), endCoords = vector3(-172.9, 489.41, 136.96)},
        },
        camerasDetectors = {
            {prop = 'hei_prop_bank_cctv_02', propCoords = vector4(-173.18, 498.46, 132.03, 0.0), detectorCoords = vector3(-173.18, 498.46, 129.04), detectorRadius = 3.0}
        },
        requirements = {
            [1] = "You need Lockpick Advanced.",
        },
        informations = {
            [1] = {icon = "fa-solid fa-key", placeholder = 'Security Information.', information = 'The house is secured inside with detection lasers and cameras.', price = 350},
            [2] = {icon = "fa-solid fa-key", placeholder = 'Security Information.', information = 'Armed guards are present in the house at all times.', price = 350},
            [3] = {icon = "fa-solid fa-magnifying-glass-dollar", placeholder = 'Loot Information.', information = 'You can find expensive jewelry in the house.', price = 120},
            [4] = {icon = "fa-solid fa-user", placeholder = 'Tenant Information.', information = 'Tenants may have firearms with them.', price = 400},
            [5] = {icon = "fa-solid fa-user", placeholder = 'Tenant Information.', information = 'Tenants sleep through the night.', price = 1000},
            [6] = {icon = "fa-solid fa-user", placeholder = 'Tenant Information.', information = 'The male tenant is out of the house between 15:00 and 21:00.', price = 1000},
            [7] = {icon = "fa-solid fa-user", placeholder = 'Tenant Information.', information = 'The female tenant is out of the house between 17:00 and 21:00.', price = 1000},
        },
    },
    ['11'] = {
        image = 'house_11.png',
        address = {street = 'Picture Perfect Drive', zone = 'Vinewood Hills'},
        difficultyLevel = 3, -- 1 / 2 / 3
        
        lockpickType = 'advanced', -- CL.Lockpick
        lockpickItem = 'lockpick_advanced',
        lockpickRemove = 1, -- 0 = Don't remove, 1 = Remove on use, 2 = Remove only on done
        
        robberyTimeout = 160 * 60, -- 160 minutes

        requiredPolices = 8,

        interior = 'Monochrome2Apartment',
        enterCoords = vector4(-717.92, 448.75, 106.91, 27.6),
        turnOffElectricity = vector4(-737.79, 432.8, 106.9, 297.68),
        loot = {
            [1] = {
                coords = vector4(-789.52, 320.88, 187.27, 90.0),
                targetSize = vector3(2.5, 0.75, 1.3),
                isCabinet = true,
                animation = {"anim@scripted@cbr1@ig1_washmach_grab_cash@heeled@", "grab", 1500, 1},
                probablyLoots = {
                    ['money_bundle_1'] = {spawnChance = 65, count = {300, 800}},
                    ['money_bundle_2'] = {spawnChance = 60, count = {700, 3500}},
                    ['bleuterd_champagne'] = {spawnChance = 70, count = 1},
                    ['bong'] = {spawnChance = 80, count = 1},
                },
            },
            [2] = {
                coords = vector4(-789.85, 331.71, 187.11, 158.43),
                animation = {"anim@scripted@player@freemode@tun_prep_grab_midd_ig3@heeled@", "tun_prep_grab_midd_ig3", 800, 1},
                probablyLoots = {
                    ['money_bundle_1'] = {spawnChance = 65, count = {300, 800}},
                    ['money_counter'] = {spawnChance = 80},
                    ['bleuterd_champagne'] = {spawnChance = 70, count = 1},
                    ['bong'] = {spawnChance = 80, count = 1},
                    ['perfume'] = {spawnChance = 70, count = 1},
                    ['laptop'] = {spawnChance = 78, count = 1},
                },
            },
            [3] = {
                coords = vector4(-783.58, 327.51, 187.28, 295.95),
                animation = {"anim@scripted@player@freemode@tun_prep_grab_midd_ig3@heeled@", "tun_prep_grab_midd_ig3", 800, 1},
                probablyLoots = {
                    ['kettle'] = {spawnChance = 65, count = 1},
                    ['mixer'] = {spawnChance = 73, count = 1},
                },
            },
            [4] = {
                coords = vector4(-783.84, 338.58, 186.56, 355.82),
                animation = {"anim@scripted@player@freemode@tun_prep_ig1_grab_low@male@", "grab_low", 800, 1},
                probablyLoots = {
                    ['art_3'] = {spawnChance = 68, count = 1},
                    ['money_bundle_2'] = {spawnChance = 60, count = {1000, 3250}},
                    ['money_bundle_3'] = {spawnChance = 55, count = {7500, 40000}},
                },
            },
            [5] = {
                coords = vector4(-785.31, 338.82, 186.56, 229.93),
                animation = {"anim@scripted@player@freemode@tun_prep_ig1_grab_low@male@", "grab_low", 800, 1},
                probablyLoots = {
                    ['laptop'] = {spawnChance = 78, count = 1},
                },
            },
            [6] = {
                coords = vector4(-782.54, 343.07, 186.11, 166.09),
                animation = {"veh@common@motorbike@low@ps", "pickup", 700, 1},
                probablyLoots = {
                    ['vase_2'] = {spawnChance = 55, count = 1},
                    ['statue_art_1'] = {spawnChance = 55, count = 1},
                    ['statue_art_2'] = {spawnChance = 70, count = 1},
                    ['statue_art_3'] = {spawnChance = 65, count = 1},
                },
            },
            [7] = {
                coords = vector4(-793.97, 341.45, 187.06, 92.36),
                animation = {"anim@scripted@player@freemode@tun_prep_grab_midd_ig3@heeled@", "tun_prep_grab_midd_ig3", 800, 1},
                probablyLoots = {
                    ['art_1'] = {spawnChance = 62, count = 1},
                    ['art_2'] = {spawnChance = 65, count = 1},
                    ['car_toy_1'] = {spawnChance = 78, count = 1},
                },
            },
            [8] = {
                coords = vector4(-799.89, 330.89, 189.71, 90.9),
                isSafe = 'prop_ld_int_safe_01',
                animation = {"anim@treasurehunt@hatchet@action", "hatchet_pickup", 2500, 1},
                probablyLoots = {
                    ['money_bundle_1'] = {spawnChance = 60, count = {400, 950}},
                    ['necklace_1'] = {spawnChance = 25, count = 1},
                    ['necklace_2'] = {spawnChance = 25, count = 1},
                    ['necklace_3'] = {spawnChance = 25, count = 1},
                    ['watch_1'] = {spawnChance = 20, count = 1},
                    ['watch_2'] = {spawnChance = 20, count = 1},
                },
            },
            [9] = {
                coords = vector4(-795.72, 327.83, 190.58, 266.97),
                animation = {"anim@scripted@player@mission@tun_table_grab@gold@", "grab", 900, 1},
                probablyLoots = {
                    ['cocaine'] = {spawnChance = 85, count = {12, 22}},
                    ['cigars'] = {spawnChance = 55, count = 1},
                },
            },
            [10] = {
                coords = vector4(-798.91, 328.44, 186.22, 0.5),
                targetSize = vector3(1.9, 0.85, 1.85),
                isCabinet = true,
                animation = {"anim@scripted@cbr1@ig1_washmach_grab_cash@heeled@", "grab", 1500, 1},
                probablyLoots = {
                    ['laptop'] = {spawnChance = 60, count = 1},
                    ['dj'] = {spawnChance = 62, count = 1},
                    ['watch_1'] = {spawnChance = 22, count = 1},
                    ['money_counter'] = {spawnChance = 55, count = 1},
                },
            },
            [11] = {
                coords = vector4(-799.59, 323.4, 186.31, 90.37),
                animation = {"anim@treasurehunt@hatchet@action", "hatchet_pickup", 2500, 1},
                probablyLoots = {
                    ['pc'] = {spawnChance = 90, count = 1},
                },
            },
        },
        tenants = {
            [1] = {
                model = 's_m_m_armoured_01',
                isArmedWith = 'weapon_carbinerifle_mk2', -- when the player wakes him up, attacks him with this weapon
                hoursAtHome = {0, 23}, -- Tenant 1 will be home from 7:00 to 10:00 and will not sleep
                activitesAtHome = {
                    {coords = vector4(-784.61, 341.8, 186.12, 153.84)},
                },
            },
            [2] = {
                model = 's_m_m_armoured_02',
                isArmedWith = 'weapon_militaryrifle', -- when the player wakes him up, attacks him with this weapon
                hoursAtHome = {0, 23}, -- Tenant 1 will be home from 7:00 to 10:00 and will not sleep
                activitesAtHome = {
                    {coords = vector4(-792.95, 323.81, 186.31, 268.48)},
                },
            },
            [3] = {
                model = 's_m_m_armoured_02',
                isArmedWith = 'weapon_gusenberg', -- when the player wakes him up, attacks him with this weapon
                hoursAtHome = {0, 23}, -- Tenant 1 will be home from 7:00 to 10:00 and will not sleep
                activitesAtHome = {
                    {coords = vector4(-798.95, 338.49, 189.71, 215.18)},
                },
            },
            [4] = {
                model = 's_m_y_westsec_01',
                isArmedWith = 'weapon_dbshotgun', -- when the player wakes him up, attacks him with this weapon
                hoursAtHome = {7, 18}, -- Tenant 1 will be home from 7:00 to 10:00 and will not sleep
                hoursAreSleeping = {22, 6}, -- Tenant 1 will sleep from 22:00 to 6:00
                activitesAtHome = {
                    {coords = vector4(-786.11, 338.83, 186.11, 267.05), animation = {'timetable@ron@ig_3_couch', 'base'}},
                },
                sleeping = {
                    coords = vector4(-798.29, 335.82, 190.39, 264.88),
                    animation = {'anim@amb@nightclub@lazlow@lo_sofa@', 'lowsofa_dlg_fuckedup_laz'},
                },
            },
        },
        laserDetectors = {
            {startCoords = vector3(-784.74, 324.56, 186.9), endCoords = vector3(-791.28, 325.21, 186.9)},
            {startCoords = vector3(-790.48, 337.35, 186.45), endCoords = vector3(-785.27, 334.61, 186.45)},
        },
        camerasDetectors = {
            {prop = 'hei_prop_bank_cctv_02', propCoords = vector4(-793.95, 343.49, 189.47, 47.13), detectorCoords = vector3(-789.57, 340.88, 186.11), detectorRadius = 2.5},
            {prop = 'hei_prop_bank_cctv_02', propCoords = vector4(-795.47, 328.32, 189.29, 342.72), detectorCoords = vector3(-797.28, 324.49, 186.31), detectorRadius = 2.5}
        },
        requirements = {
            [1] = "You need Lockpick Advanced.",
        },
        informations = {
            [1] = {icon = "fa-solid fa-key", placeholder = 'Security Information.', information = 'The house is secured inside with detection lasers and cameras.', price = 350},
            [2] = {icon = "fa-solid fa-key", placeholder = 'Security Information.', information = 'Armed guards are present in the house at all times.', price = 350},
            [3] = {icon = "fa-solid fa-magnifying-glass-dollar", placeholder = 'Loot Information.', information = 'You can find expensive jewelry in the house.', price = 120},
            [4] = {icon = "fa-solid fa-user", placeholder = 'Tenant Information.', information = 'Tenants may have firearms with them.', price = 400},
            [5] = {icon = "fa-solid fa-user", placeholder = 'Tenant Information.', information = 'Tenants sleep through the night.', price = 1000},
            [6] = {icon = "fa-solid fa-user", placeholder = 'Tenant Information.', information = 'Tenant is out of the house between 19:00 and 21:00.', price = 1000},
        },
    },
    ['12'] = {
        image = 'house_12.png',
        address = {street = 'Steele Way', zone = 'Rockford Hills'},
        difficultyLevel = 3, -- 1 / 2 / 3
        
        lockpickType = 'advanced', -- CL.Lockpick
        lockpickItem = 'lockpick_advanced',
        lockpickRemove = 1, -- 0 = Don't remove, 1 = Remove on use, 2 = Remove only on done
        
        robberyTimeout = 90 * 60, -- 90 minutes

        requiredPolices = 8,

        interior = 'DellPerroHeights',
        enterCoords = vector4(-949.32, 196.78, 67.39, 167.04),
        turnOffElectricity = vector4(-938.04, 212.17, 67.46, 80.0),
        loot = {
            [1] = {
                coords = vector4(-1471.66, -541.79, 73.26, 40.47),
                animation = {"anim@scripted@player@freemode@tun_prep_grab_midd_ig3@heeled@", "tun_prep_grab_midd_ig3", 800, 1},
                probablyLoots = {
                    ['cigars'] = {spawnChance = 55, count = 1},
                    ['bleuterd_champagne'] = {spawnChance = 65, count = 1},
                    ['camera'] = {spawnChance = 70, count = 1},
                    ['art_3'] = {spawnChance = 68, count = 1},
                },
            },
            [2] = {
                coords = vector4(-1469.49, -524.76, 72.44, 38.03),
                isCabinet = 'prop_cabinet_02b',
                animation = {"anim@scripted@cbr1@ig1_washmach_grab_cash@heeled@", "grab", 1500, 1},
                probablyLoots = {
                    ['money_bundle_1'] = {spawnChance = 68, count = {200, 700}},
                    ['dvd'] = {spawnChance = 72, count = 1},
                    ['laptop'] = {spawnChance = 78, count = 1},
                },
            },
            [3] = {
                coords = vector4(-1459.98, -548.31, 72.24, 217.1),
                isCabinet = 'prop_cabinet_02b',
                animation = {"anim@scripted@cbr1@ig1_washmach_grab_cash@heeled@", "grab", 1500, 1},
                probablyLoots = {
                    ['bong'] = {spawnChance = 78, count = 1},
                    ['laptop'] = {spawnChance = 70, count = 1},
                    ['watch_1'] = {spawnChance = 32, count = 1},
                },
            },
            [4] = {
                coords = vector4(-1454.18, -548.81, 71.84, 304.4),
                targetSize = vector3(1.7, 0.8, 2.15),
                isCabinet = true,
                animation = {"anim@scripted@cbr1@ig1_washmach_grab_cash@heeled@", "grab", 1500, 1},
                probablyLoots = {
                    ['money_bundle_1'] = {spawnChance = 60, count = {400, 950}},
                    ['necklace_1'] = {spawnChance = 25, count = 1},
                    ['necklace_2'] = {spawnChance = 25, count = 1},
                    ['necklace_3'] = {spawnChance = 25, count = 1},
                    ['watch_1'] = {spawnChance = 20, count = 1},
                    ['watch_2'] = {spawnChance = 20, count = 1},
                },
            },
            [5] = {
                coords = vector4(-1450.46, -551.58, 71.84, 217.2),
                isSafe = 'p_v_43_safe_s',
                animation = {"anim@scripted@cbr1@ig1_washmach_grab_cash@heeled@", "grab", 1500, 1},
                probablyLoots = {
                    ['money_bundle_1'] = {spawnChance = 50, count = {350, 1000}},
                    ['money_bundle_2'] = {spawnChance = 40, count = {800, 4000}},
                    ['pc'] = {spawnChance = 58, count = 1},
                    ['golden_sales_certificate'] = {spawnChance = 55, count = 1},
                    ['necklace_2'] = {spawnChance = 32, count = 1},
                },
            },
            [6] = {
                coords = vector4(-1472.28, -537.31, 73.4, 185.34),
                animation = {"anim@scripted@player@freemode@tun_prep_ig3_grab_high@heeled@", "tun_prep_ig3_grab_high", 1300, 1},
                probablyLoots = {
                    ['pot'] = {spawnChance = 98, count = 1},
                },
            },
            [7] = {
                coords = vector4(-1467.97, -533.14, 72.44, 125.51),
                animation = {"anim@treasurehunt@hatchet@action", "hatchet_pickup", 2500, 1},
                probablyLoots = {
                    ['flowers_1'] = {spawnChance = 70, count = 1},
                    ['vase_1'] = {spawnChance = 60, count = 1},
                },
            },
            [8] = {
                coords = vector4(-1465.43, -546.45, 72.72, 128.98),
                animation = {"anim@scripted@cbr1@ig1_washmach_grab_cash@heeled@", "grab", 1500, 1},
                probablyLoots = {
                    ['money_bundle_1'] = {spawnChance = 50, count = {300, 800}},
                    ['money_bundle_2'] = {spawnChance = 35, count = {700, 3500}},
                    ['money_bundle_3'] = {spawnChance = 25, count = {7500, 40000}},
                    ['money_counter'] = {spawnChance = 65, count = 1},
                },
            },
            [9] = {
                coords = vector4(-1459.32, -526.68, 73.04, 339.92),
                animation = {"anim@treasurehunt@hatchet@action", "hatchet_pickup", 2500, 1},
                probablyLoots = {
                    ['flowers_1'] = {spawnChance = 70, count = 1},
                    ['vase_2'] = {spawnChance = 62, count = 1},
                },
            },
        },
        tenants = {
            [1] = {
                model = 's_m_m_armoured_01',
                isArmedWith = 'weapon_assaultrifle_mk2', -- when the player wakes him up, attacks him with this weapon
                hoursAtHome = {0, 23}, -- Tenant 1 will be home from 7:00 to 10:00 and will not sleep
                activitesAtHome = {
                    {coords = vector4(-1470.73, -545.51, 72.24, 321.93)},
                },
            },
            [2] = {
                model = 's_m_m_armoured_02',
                isArmedWith = 'weapon_specialcarbine_mk2', -- when the player wakes him up, attacks him with this weapon
                hoursAtHome = {0, 23}, -- Tenant 1 will be home from 7:00 to 10:00 and will not sleep
                activitesAtHome = {
                    {coords = vector4(-1467.29, -525.3, 72.44, 157.86)},
                },
            },
            [3] = {
                model = 's_m_m_armoured_02',
                isArmedWith = 'weapon_tacticalrifle', -- when the player wakes him up, attacks him with this weapon
                hoursAtHome = {0, 23}, -- Tenant 1 will be home from 7:00 to 10:00 and will not sleep
                activitesAtHome = {
                    {coords = vector4(-1458.12, -552.76, 71.88, 324.11)},
                },
            },
            [4] = {
                model = 's_m_m_armoured_02',
                isArmedWith = 'weapon_bullpuprifle_mk2', -- when the player wakes him up, attacks him with this weapon
                hoursAtHome = {0, 23}, -- Tenant 1 will be home from 7:00 to 10:00 and will not sleep
                activitesAtHome = {
                    {coords = vector4(-1459.14, -546.59, 72.86, 25.09)},
                },
            },
            [5] = {
                model = 's_m_y_westsec_01',
                isArmedWith = 'weapon_sawnoffshotgun', -- when the player wakes him up, attacks him with this weapon
                hoursAtHome = {7, 18}, -- Tenant 1 will be home from 7:00 to 18:00 and will not sleep
                hoursAreSleeping = {22, 6}, -- Tenant 1 will sleep from 22:00 to 6:00
                activitesAtHome = {
                    -- {coords = vector4(-1465.3, -551.28, 72.24, 31.56), animation = {'timetable@ron@ig_3_couch', 'base'}},
                    -- {coords = vector4(-1465.24, -547.8, 72.25, 33.46), animation = {'timetable@ron@ig_3_couch', 'base'}},
                    {coords = vector4(-1471.67, -527.18, 73.01, 220.41), animation = {'timetable@ron@ig_3_couch', 'base'}},
                    -- {coords = vector4(-1451.01, -555.7, 71.97, 31.33), animation = {'timetable@ron@ig_3_couch', 'base'}},
                },
                sleeping = {
                    coords = vector4(-1456.04, -553.52, 72.51, 310.21),
                    animation = {'anim@amb@nightclub@lazlow@lo_sofa@', 'lowsofa_dlg_fuckedup_laz'},
                },
            },
        },
        laserDetectors = {
            {startCoords = vector3(-1451.7, -551.51, 72.7), endCoords = vector3(-1452.83, -550.02, 72.7)},
            {startCoords = vector3(-1457.26, -547.81, 72.8), endCoords = vector3(-1455.52, -546.46, 72.8)},
            {startCoords = vector3(-1467.14, -535.28, 73.0), endCoords = vector3(-1465.32, -529.36, 73.0)},
        },
        camerasDetectors = {
            {prop = 'hei_prop_bank_cctv_02', propCoords = vector4(-1468.8, -543.31, 75.73, 82.98), detectorCoords = vector3(-1469.88, -542.24, 72.48), detectorRadius = 3.75}
        },
        requirements = {
            [1] = "You need Lockpick Advanced.",
        },
        informations = {
            [1] = {icon = "fa-solid fa-key", placeholder = 'Security Information.', information = 'The house is secured inside with detection lasers and cameras.', price = 350},
            [2] = {icon = "fa-solid fa-key", placeholder = 'Security Information.', information = 'Armed guards are present in the house at all times.', price = 350},
            [3] = {icon = "fa-solid fa-magnifying-glass-dollar", placeholder = 'Loot Information.', information = 'You can find expensive jewelry in the house.', price = 120},
            [4] = {icon = "fa-solid fa-magnifying-glass-dollar", placeholder = 'Loot Information.', information = 'You can find drugs in the house.', price = 120},
            [5] = {icon = "fa-solid fa-user", placeholder = 'Tenant Information.', information = 'Tenants may have firearms with them.', price = 400},
            [6] = {icon = "fa-solid fa-user", placeholder = 'Tenant Information.', information = 'Tenants sleep through the night.', price = 1000},
            [7] = {icon = "fa-solid fa-user", placeholder = 'Tenant Information.', information = 'Tenant is out of the house between 19:00 and 21:00.', price = 1000},
        },
    },
}