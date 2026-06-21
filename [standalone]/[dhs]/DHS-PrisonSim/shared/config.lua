Config = {}

Config.Debug = true -- If true, debug prints will be shown
Config.ClockDebug = false -- If true, the clock will be debugged
Config.ZoneDebug = false -- If true, the zones will be debugged

Config.VehicleKeys = "wasabi_carlock"
Config.Notify = "ox_lib"
Config.DispatchSystem = "ox_dispatch"
Config.RadialMenu = "ox_lib" -- "qb-radialmenu" or "ox_lib"
Config.AlternateObjectTurnIn = 'none'  -- "command" or "radial" or "none" If true, players will use the alternate system for turning in objects to the object turn in system if false the player will be able to turn in objects to the normal object turn in system.
Config.UsingClothingSystem = true -- If true, You will use the built in clothing system if false prisoners will not change clothes when leaving or during showers.
Config.Clothing = "illenium-appearance" -- "illenium-appearance" or "custom" modify in editablefunctions_cl.lua
Config.MedicalSystem = 'wasabi' -- Options: 'builtin', 'p_ambulancejob', 'wasabi', 'brutal', 'qb-ambulancejob' modify in editablefunctions_cl.lua

Config.MLOSelection = 'prompt-prison' -- 'molo-alcatraz' or 'prompt-prison' or 'gabz-prison' or 'custom'

Config.Phone = 'lb-phone' -- 'lb-phone' or 'custom'
Config.PayPhoneCallerID = "Prison Inmate"

Config.TimeMetric = "minutes" -- "hours"/"minutes"/"seconds" (Real Life Time)
Config.DoJobsReduceTime = true -- If true, jobs will reduce the time the player is sentenced for
Config.ReleaseFromPrisonImmediately = true -- If true, the player will be released from prison immediately when their time is up
Config.UseBuiltInMedicalSystem = true -- If true, the built in medical system will be used if false modify in editablefunctions_cl.lua
Config.UseBuiltInDoorLockSystem = true -- If true, the built in door lock system will be used if false a few features will be disabled mainly lockdown and more features in the future!
Config.UseTargetForDoorLock = true -- If true, the target will be used for the door lock system if false the press e key to interact with the door will be used
Config.PerimiterEscapeEnabled = false -- If true, the player will not teleport back to their cell if they leave the perimiter and will instead be considered escaped
Config.ControlPanelEscapeEnabled = true -- If true, the control panel escape method will be able to be used doesnt work with Molo Alcatraz
Config.ReturnItemsOnEscape = false -- If true, escaped prisoners will get their confiscated items back (prevents item loss from death/hospital)
Config.DoorWaitingTime = 1000 -- How long the player will wait for the door before walking through it (Change this if your doors are opening too slowly and your getting stuck)
Config.AttendanceInterval = 0 -- How long the player will wait for the attendance to be set (Change this if your attendance is not being set correctly)
Config.RemoveMoneySeperatelyFromItems = false -- Set this to true if you dont use cash as an item and would like the money to be removed still
Config.LockdownGuardsEnabled = false -- If true, lockdown guards will be enabled
Config.UseBaggedLunch = true -- If true, the player will be able to use the bagged lunch item instead of placing a tray down
Config.BaggedLunchCooldown = 10 -- How long the player will wait to collect another bagged lunch (in minutes)
Config.LunchTrayCooldown = 10 -- How long the player will wait to place another lunch tray (in minutes)
Config.StorageBoxCooldown = 5000 -- Cooldown in milliseconds between item usage (5000 = 5 seconds) [Increase This if your getting duplicated objects]
Config.SpawnTimeOut = 5000 -- How long the player will wait to get their data before spawning in the prison [Increase this if your players are having issues loading into prison properly]
Config.FailSafeCoords = vector3(1692.77, 2493.17, 45.56) -- If the player is not in the prison after the spawn timeout, they will be teleported to these coords

Config.NoPunishmentsForAttendance = false -- If true, the player will not receive any punishments for not attending to the schedule

Config.DisablePrisonIntro = true -- If true, the prison intro will be disabled
Config.DisablePrisonTutorial = true -- If true, the prison tutorial will be disabled
Config.DisablePrisonSchedule = true -- If true, the prison schedule will be disabled
Config.SpawnInCell = true -- If false, prisoners will spawn at SkipCoords instead of their cell on login

Config.PoliceJob = { ["police"] = 0, ["mechanic"] = 0} -- Job names that will be considered police officers
Config.DOCJob = { ["police"] = 0, ["mechanic"] = 0} -- Job names that will be considered DOC officers

Config.GuardWeapons = {
    convoy = "WEAPON_ASSAULTRIFLE", -- Weapon for convoy guards
    lockdown = "WEAPON_STUNGUN", -- Weapon for lockdown guards
}

Config.LevelSystem = {
    usingLevelSystem = false, -- Keep this false unless you would like to integrate your level system into the script (would reccomend opening a ticket so I can personally assist you with this)
    amountofXPToGainPerWorkout = 10, -- This is quite simple how much xp would you like the player to gain everytime they successfully workout
}

Config.StorageandStashSettings = {
    storageBoxWeight = 10000, -- How much weight the storage box can hold
    storageBoxSlots = 10, -- How many slots the storage box has
}

Config.FoodFromTray = {
    hunger = 100, -- How much hunger will the food from tray give the player
    thirst = 100, -- How much thirst will the food from tray give the player
}

Config.PrisonPocketSettings = {
    weight = 1000, -- How much weight the prison pocket can hold
    slots = 1, -- How many slots the prison pocket has
}

Config.CommisaryItems = {
    { item = "sandwich", label = "Sandwich", price = 10, icon = "fas fa-burger" },
    { item = "water",    label = "Water",    price = 10, icon = "fas fa-bottle-water" },
}

if Config.MLOSelection == 'prompt-prison' then
    Config.SkipCoords = vector4(1691.63, 2565.7, 45.56, 180.58) -- If true, the player will be teleported to these coords if skipping intro

    Config.Blips = {
        {coords = vector3(1614.06, 2477.4, 45.65), sprite = 188, color = 3, scale = 0.5, name = "Min Cell Block", enabled = true},
        {coords = vector3(1692.49, 2450.53, 45.65), sprite = 188, color = 17, scale = 0.5, name = "Med Cell Block", enabled = true},
        {coords = vector3(1763.21, 2485.41, 45.65), sprite = 188, color = 1, scale = 0.5, name = "Max Cell Block", enabled = true},
        {coords = vector3(1780.06, 2552.0, 45.78), sprite = 285, color = 0, scale = 0.5, name = "Release", enabled = true},
        {coords = vector3(1733.52, 2576.09, 45.42), sprite = 89, color = 0, scale = 0.5, name = "Cafeteria", enabled = true},
        {coords = vector3(1587.07, 2553.82, 45.63), sprite = 643, color = 0, scale = 0.5, name = "Work Block", enabled = true},
    }

    Config.PrisonMedicalBeds = {
        [1] = {
            coords = vector4(1761.79, 2582.64, 45.78, 265.0),
            taken = false, -- Dont Touch This!
        },
        [2] = {
            coords = vector4(1761.79, 2584.92, 45.78, 265.0),
            taken = false, -- Dont Touch This!
        },
        [3] = {
            coords = vector4(1761.79,  2587.17, 45.78, 265.0),
            taken = false, -- Dont Touch This!
        },
        [4] = {
            coords = vector4(1757.17, 2587.45, 45.78, 90.0),
            taken = false, -- Dont Touch This!
        },
        [5] = {
            coords = vector4(1757.17, 2585.44, 45.78, 90.0),
            taken = false, -- Dont Touch This!
        },
        [6] = {
            coords = vector4(1757.17, 2583.42, 45.78, 90.0),
            taken = false, -- Dont Touch This!
        },
        [7] = {
            coords = vector4(1757.17, 2581.31, 45.78, 90.0),
            taken = false, -- Dont Touch This!
        },
    }
elseif Config.MLOSelection == 'molo-alcatraz' then
    Config.SkipCoords = vector4(3909.9, 25.53, 23.89, 82.67) -- If true, the player will be teleported to these coords if skipping intro

    Config.Blips = {
        {coords = vector3(3902.98, 25.69, 23.89), sprite = 188, color = 17, scale = 0.5, name = "Detention Center", enabled = true},
        {coords = vector3(3927.55, 29.48, 23.89), sprite = 89, color = 0, scale = 0.5, name = "Cafeteria", enabled = true},
        {coords = vector3(3923.72, -15.84, 10.74), sprite = 285, color = 0, scale = 0.5, name = "Release", enabled = true},
        {coords = vector3(4006.22, 29.56, 20.51), sprite = 643, color = 0, scale = 0.5, name = "Mining Work Area", enabled = true},
        {coords = vector3(4080.34, 44.69, 18.79), sprite = 643, color = 0, scale = 0.5, name = "Laundry Work Area", enabled = true},
        {coords = vector3(4003.27, 59.68, 12.3), sprite = 643, color = 0, scale = 0.5, name = "Recycling Work Area", enabled = true},
    }

    Config.PrisonMedicalBeds = {
        [1] = {
            coords = vector4(4040.65, -2.02, 18.7, 94.01),
            taken = false, -- Dont Touch This!
        },
        [2] = {
            coords = vector4(4043.27, -8.69, 18.7, 269.43),
            taken = false, -- Dont Touch This!
        },
        [3] = {
            coords = vector4(4046.17, -8.14, 18.7, 90.46),
            taken = false, -- Dont Touch This!
        },
        [4] = {
            coords = vector4(4048.78, -1.71, 18.7, 89.07),
            taken = false, -- Dont Touch This!
        },
    }
elseif Config.MLOSelection == 'gabz-prison' then
    Config.SkipCoords = vector4(1774.71, 2552.13, 45.57, 87.69) -- If true, the player will be teleported to these coords if skipping intro

    Config.Blips = {
        {coords = vector3(1762.22, 2487.99, 45.74), sprite = 188, color = 17, scale = 0.5, name = "Cell Block", enabled = true},
        {coords = vector3(1784.08, 2552.05, 45.67), sprite = 89, color = 0, scale = 0.5, name = "Cafeteria", enabled = true},
        {coords = vector3(1830.83, 2595.82, 46.01), sprite = 285, color = 0, scale = 0.5, name = "Release", enabled = true},
    }

    Config.PrisonMedicalBeds = {
        [1] = {
            coords = vector4(1762.01, 2591.47, 45.66, 88.84),
            taken = false, -- Dont Touch This!
        },
        [2] = {
            coords = vector4(1761.87, 2594.66, 45.66, 86.95),
            taken = false, -- Dont Touch This!
        },
        [3] = {
            coords = vector4(1761.77, 2597.75, 45.66, 84.56),
            taken = false, -- Dont Touch This!
        },
        [4] = {
            coords = vector4(1771.97, 2591.88, 45.66, 268.41),
            taken = false, -- Dont Touch This!
        },
        [5] = {
            coords = vector4(1772.05, 2594.94, 45.66, 267.48),
            taken = false, -- Dont Touch This!
        },
        [6] = {
            coords = vector4(1772.06, 2597.94, 45.66, 267.69),
            taken = false, -- Dont Touch This!
        },
    }
elseif Config.MLOSelection == 'custom' then
    -- Open a Ticket So I can help you with your custom prison
end

Config.MedicineItems = {
    { item = "bandage", label = "Bandage", price = 10, icon = "fas fa-band-aid" },
}

Config.Lang = {
    police_alert = {
        convoy_attacked = "Convoy attacked by unknown suspects",
        prisoner_escaped = "Prisoner escaped from prison",
        prison_gates_down = "Prison gates down",
    },
    peds = {
        doctor_request_medicine = "Request Medicine",
        doctor_request_health_care = "Request Health Care",
        prisoner_release_check_time = "Release Prisoner/ Check Time",
        prisoner_check_in = "Check In As A Prisoner",

    },
    target = {
        unlock_gate = "Toggle Gate Lock",
        chair_label = "Sit Down",
        use_toilet = "Use Toilet",
        use_bed = "Use Bed",
        commisary = "Commisary",
        use_shower = "Use Shower",
        grab_tray = "Grab Food Tray",
        workout = "Work Out",
        use_payphone = "Use Payphone",
        grab_metal = "Grab Metal",
        cut_metal = "Flatten and Cut Metal",
        drill_metal = "Drill and Engrave Metal",
        grab_wood = "Grab Wood",
        use_workbench = "Use Workbench",
        grab_laundry = "Grab Clothes",
        use_washer = "Use Washer",
        use_dryer = "Use Dryer",
        use_folding = "Fold Clothes",
        unlock_door = "Unlock Door",
        lock_door = "Lock Door",
        deposit_work_objects = "Deposit Work Objects",
        open_storage = "Open Storage",
        pick_up_box = "Pick Up Box",
        eat_food_from_tray = "Eat Food",
        grab_pickaxe = "Grab A Pickaxe",
        mine_rock = "Mine Rock",
        grab_material = "Grab Recyclable Material",
        compact_material = "Compact Material Into a Block",
    },
    text = {
        cell_text = "Your Cell",
        place_tray_down = "[E] Place Tray Down",
        get_up = "[E] Get Up",
    },
    menu = {
        prison_convoy_title = "Prison Convoy Register",
        registry_max_label = "Maximum Security",
        registry_med_label = "Medium Security",
        registry_min_label = "Minimum Security",
        hours_until_release = "Hours Until Release",
        hours_until_release_description = "Amount of Hours Until Prisoner is Released",
        minutes_until_release = "Minutes Until Release",
        minutes_until_release_description = "Amount of Minutes Until Prisoner is Released",
        seconds_until_release = "Seconds Until Release",
        seconds_until_release_description = "Amount of Seconds Until Prisoner is Released",
        toilet_menu_title = "Toilet",
        toilet_stash_title = "Toilet Stash",
        toilet_stash_description = "Reach Inside Toilet",
        toilet_flush_title = "Flush Toilet",
        toilet_flush_description = "Flush The Toilet",
        toilet_drink_title = "Drink From Water Fountain",
        commisary_title = "Commisary",
        prisoner_id = "Prisoner ID: ",
        no_prisoners_found = "No Prisoners Found",
        DOC_menu_title = "DOC Menu",
        prisoner_menu_go_back = "Go Back",
        prisoner_menu_go_back_description = "Go Back To DOC Menu",
        modify_sentence_title = "Modify Sentence",
        modify_sentence_description = "Current Sentence: ",
        release_from_prison = "Release From Prison",
        release_from_prison_description = "Release Prisoner",
        medicine_menu_title = "Medicine",
        register_convoy = "Register Convoy",
        wood_workbench_title = "Wood Workbench",
        cut_wood_logs_into_planks = "Cut Wood Logs Into Planks",
        cut_wood_logs_into_planks_description = "Cut Wood Logs Into Planks",
        craft_wooden_chair = "Craft Wooden Chair",
        craft_wooden_chair_description = "2x Wood Planks",
        craft_wooden_table = "Craft Wooden Table",
        craft_wooden_table_description = "4x Wood Planks",
        craft_wooden_storage = "Craft Wooden Storage",
        craft_wooden_storage_description = "6x Wood Planks",
    },
    input = {
        registry_title = "Prison Registry",
        inmates_name = "Inmates Name",
        inmates_security_level = "Inmates Security Level",
        sign_here = "Sign Here",
        sign_here_description = "Sign Your Name",
        modify_sentence_input_title = "Modify Sentence",
        prison_convoy_title = "Prison Convoy Register",
        prisoner_id = "Prisoner ID",
        prisoner_id_description = "Prisoners ID",
        request_transport = "Request Transport (Corrections Will Pick Up Prisoner)",
        security_level = "Security Level",
        is_final_prisoner = "Is Final Prisoner (Sends in Order For Convoy)",
        minimum_security = "Minimum Security",
        medium_security = "Medium Security",
        maximum_security = "Maximum Security",
        have_county_pick_up_prisoner = "Have County Pick Up Prisoner (Skips Convoy)",
        license_plate_engraving = "License Plate Engraving",
        license_plate_number = "License Plate Number",
    },
    notify_error = {
        not_your_name = "That is Not Your Name Try Again!",
        workout_failed = "You failed to workout",
        guard_alert_1_rollcall = "You Missed Rollcall, Guards Will be Increasing Patrols",
        guard_alert_2_rollcall = "You Missed Rollcall, Guards Are On High Alert",
        guard_alert_3_rollcall = "You Missed Rollcall, Guards Are Placing a Lockdown on the Prison",
        guard_alert_1_breakfast = "You Missed Breakfast, Guards Will be Increasing Patrols",
        guard_alert_2_breakfast = "You Missed Breakfast, Guards Are On High Alert",
        guard_alert_3_breakfast = "You Missed Breakfast, Guards Are Placing a Lockdown on the Prison",
        guard_alert_1_lunch = "You Missed Lunch, Guards Will be Increasing Patrols",
        guard_alert_2_lunch = "You Missed Lunch, Guards Are On High Alert",
        guard_alert_3_lunch = "You Missed Lunch, Guards Are Placing a Lockdown on the Prison",
        you_already_collected_bagged_lunch = "You already collected a bagged lunch, wait 10 minutes before collecting another one!",
        you_already_placed_lunch_tray = "You already placed a lunch tray, wait 10 minutes before placing another one!",
        guard_alert_1_dinner = "You Missed Dinner, Guards Will be Increasing Patrols",
        guard_alert_2_dinner = "You Missed Dinner, Guards Are On High Alert",
        guard_alert_3_dinner = "You Missed Dinner, Guards Are Placing a Lockdown on the Prison",  
        guard_alert_1_work = "You Missed Work, Guards Will be Increasing Patrols",
        guard_alert_2_work = "You Missed Work, Guards Are On High Alert",
        guard_alert_3_work = "You Missed Work, Guards Are Placing a Lockdown on the Prison",
        guard_alert_1_shower = "You Missed Shower, Guards Will be Increasing Patrols",
        guard_alert_2_shower = "You Missed Shower, Guards Are On High Alert",
        guard_alert_3_shower = "You Missed Shower, Guards Are Placing a Lockdown on the Prison",
        you_still_have = "You still have ",
        minutes_left = " minutes left in your sentence",
        not_meal_time = "Its Not MealTime!",
        no_medical_beds_available = "No Medical Beds Available",
        prison_lockdown = "PRISON LOCKDOWN INITIATED - Prisoner(s) not in cells",
        license_plate_number_too_long = "License plate must be less than 7 characters!",
        prisoner_not_found = "Prisoner Not Found",
        no_metal_bar = "You don't have a metal bar!",
        no_metal_plate = "You don't have a metal plate!",
        you_dont_have_any_work_objects = "You don't have any work objects to deposit!",
        you_dont_have_a_wood_log = "You don't have a wood log!",
        you_dont_have_enough_wood_planks = "You don't have enough wood planks!",
        you_dont_have_any_dirty_clothes = "You don't have any dirty clothes!",
        you_dont_have_any_wet_clothes = "You don't have any wet clothes!",
        you_dont_have_any_clean_clothes = "You don't have any clean clothes!",
        you_dont_have_enough_money = "You don't have enough money!",
        invalid_storage_box = "Invalid Storage Box!",
        you_are_not_a_doc_officer = "You are not a DOC Officer!",
        you_are_not_a_police_officer = "You are not a Police Officer!",
        you_are_not_in_registry = "You are not in Registry!",
        doors_are_already_broken = "The doors are already broken!",
        doors_are_already_fixed = "The doors are already fixed!",
        you_are_already_carrying_object = "You are already carrying an object!",
        you_are_not_an_admin = "You are not an admin!",
        you_are_not_allowed_to_use_the_prison_pocket = "You are not allowed to use the prison pocket!",
        no_pickaxe = "You don't have a pickaxe!",
        no_recyclable_material = "You don't have any recyclable material!",
        no_police_station_found = "No Police Station Nearby",
        missing_item_required_to_hack_gates = "You are missing the item required to hack the gates!",
        invalid_punishment_time = "Invalid Punishment Time!",
        you_are_currently_busy = "You are currently busy!",
        item_on_cooldown = "You need to wait before using another item!",
        not_a_prisoner = "You are not a prisoner!",
    },
    notify_success = {
        workout_success = "You successfully worked out",
        you_have_served_your_time = "You have served your time!",
        you_have_been_given = "You have been given ",
        months_off = " months off",
        license_plate_deposited = "License plate deposited!",
        wooden_chair_deposited = "Wooden Chair deposited!",
        wooden_table_deposited = "Wooden Table deposited!",
        wooden_storage_deposited = "Wooden Storage deposited!",
        clean_folded_prison_jumpsuit_deposited = "Clean Folded Prison Jumpsuit deposited!",
        clean_folded_guard_uniform_deposited = "Clean Folded Guard Uniform deposited!",
        you_have_escaped_from_prison = "You have escaped from prison!",
        you_have_disabled_the_doors = "Your hack disabled the prison doors!",
        rock_deposited = "Rock deposited!",
        recyclable_material_block_deposited = "Recyclable Material Block deposited!",
        successfully_attended_lights_out = "Successfully attended Lights-Out",
        successfully_attended_shower = "Successfully attended Shower",
        successfully_attended_breakfast = "Successfully attended Breakfast",
        successfully_attended_lunch = "Successfully attended Lunch",
        successfully_attended_dinner = "Successfully attended Dinner",
        successfully_attended_work = "Successfully attended Work",
        you_have_been_freed_from_solitary = "You have been freed from Solitary Confinement",
    },

    notify_info = {
        lights_out = "Head to Your Cell Its Time For Lights Out",
        rollcall = "Head to Rollcall",
        cafeteria = "Head to the Cafeteria",
        work = "Head to The Work Area",
        yard = "Head to The Yard",
        free_time = "Enjoy Your Free Time",
        shower = "Head to Your Cell Block For Shower Time",
        prison_bus_waiting = "Prison Bus is waiting outside",
        you_have_been_moved_to_solitary = "You have been moved to Solitary Confinement For",
        minutes = " minutes",
    },
    progressbar = {
        open_storage_box = "Opening Storage Box...",
        recovering = "Recovering...",
        cutting_metal = "Cutting Metal...",
        drilling_and_engraving = "Drilling and Engraving Metal Into a License Plate...",
        cutting_wood = "Cutting Wood Log...",
        crafting_wooden_chair = "Crafting Wooden Chair...",
        crafting_wooden_table = "Crafting Wooden Table...",
        crafting_wooden_storage = "Crafting Wooden Storage...",
        using_laundry_washer = "Using Washer...",
        using_laundry_dryer = "Using Dryer...",
        folding_laundry = "Folding Laundry...",
        eating_food_from_tray = "Eating Food From Tray...",
        fixing_gate_control_panel = "Fixing Gate Control Panel...",
        mining_rock = "Mining Rock...",
        compacting_material = "Compacting Material...",
    },
    prison_schedule = {
        recovery = "Recovery",
        lockdown = "LOCKDOWN",
        release = "Ready for Release",
        normal = "Normal",
        freedom = "Freedom",
        lights_out = "Lights Out",
        rollcall = "Rollcall",
        shower = "Shower",
        breakfast = "Breakfast",
        lunch = "Lunch",
        dinner = "Dinner",
        work = "Work",
        yard = "Yard",
        free_time = "Free Time",
        solitary = "Solitary",
    },
    textUI = {
        sit_down = "[E] Sit Down",
        stand_up = "[E] Stand Up",
        lock_door = "[E] Lock Door",
        unlock_door = "[E] Unlock Door",
        instructions = "[Up Arrow] Move Forward  \n [Down Arrow] Move Backwards  \n[Left Arrow] Move Left  \n[Right Arrow] Move Right  \n [B] Move Backwards  \n [G] Move Forwards  \n [X] Rotate Prop  \n [E] Confirm Placement",
    },
    commands = {
        lockdown = "lockdown",
        stopLockdown = "stoplockdown",
        resetPrisoner = "resetprisoner",
        doc = "doc",
        prison = "prison",
        prisonPocket = "prisonpocket",
        resetClothes = "resetclothes",
        solitary = "solitary",
        removeSolitary = "removesolitary",
    },
    radialmenu = {
        depositWorkObjects = "Deposit Work Objects",
    }
}