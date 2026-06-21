-- MIT License
-- fs-doj Configuration File
-- Edit this file to configure the DOJ system for your server

Config = {}

-- Language Settings
Config.Language = 'en' -- Options: 'en' (English), 'es' (Spanish), add more in locales.lua

-- Framework Settings
Config.Framework = 'auto' -- Options: 'auto', 'esx', 'qb', 'qbox'

-- Adapter Configuration
Config.Use = {
    inventory = 'auto',        -- Options: 'auto', 'ox_inventory', 'qb-inventory'
    target = 'ox_target'       -- Options: 'ox_target', 'qb-target'
}

-- Job Configuration
Config.JobName = 'doj'         -- The job name for DOJ employees

-- Permissions by Rank (job.grade)
Config.Permissions = {
    [0] = {'mdt.view', 'citizens.view', 'vehicles.view'},                                    -- Cadet
    [1] = {'mdt.view', 'citizens.view', 'vehicles.view', 'reports.create', 'inspections'},  -- Officer
    [2] = {'mdt.view', 'citizens.view', 'vehicles.view', 'reports.create', 'reports.manage', 'inspections', 'licenses.view', 'citizens.manage', 'vehicles.manage', 'cases.view', 'cases.create', 'court.view', 'warrants.view', 'announcements.create'}, -- Sergeant
    [3] = {'*', '-cases.delete'},                                                            -- Lieutenant (all except sensitive)
    [4] = {'*', '-cases.delete'},                                                            -- Detective
    [5] = {'*'},                                                                             -- Captain
    [6] = {'*'},                                                                             -- Judge
    [7] = {'*'}                                                                              -- Chief
}

-- Warrant System Settings
Config.AutoGiveWarrantItem = false -- If true, warrant item automatically added to inventory when issued. If false, officers must retrieve it manually from MDT
Config.Debug = false -- Enable debug logging for troubleshooting

-- MDT Terminals Locations
Config.Coords = {
    -- Metal Detectors
    MetalDetectors = {
        -- Court House Entry
        {
            title = "Court House Metal Detector",
            entry = vector3(-543.9316, -627.0576, 35.6031),
            exit = vector3(-546.4277, -627.3796, 35.6031),
            width = 2.5,
            detectItems = {'WEAPON_', 'weapon_'}, -- Prefix matching for items
            alertJob = 'doj'
        },
    },

    -- Available Courtrooms (for scheduling hearings)
    AvailableCourtrooms = {
        "Courtroom 1",
        "Courtroom 2",
        "Courtroom 3",
        "Courtroom A",
        "Courtroom B",
        "Courtroom C",
        "Superior Court",
        "District Court",
        "Municipal Court"
    },

    -- TV Locations (synchronized displays)
    TVs = {
        {title = "Court Hall TV", coords = vector3(-508.8709, -609.7953, 36.2965), heading = 268.4732, syncRadius = 15.0},
    },

    -- Garages (Department Vehicles)
    Garages = {
        {
            title = "DOJ Garage - City Hall",
            coords = vector3(-495.1280, -602.9033, 33.9005),
            heading = 263.1292,
            spawnPoints = {
                {coords = vector3(-495.1280, -602.9033, 33.9005), heading = 263.1292},
            },
            allowedJobs = {'doj', 'police'},
        },
    }
}

-- Garage Vehicles by Job Grade
Config.GarageVehicles = {
    [0] = {}, -- Cadet - no vehicles
    [1] = { -- Officer
        {label = "Unmarked Sedan", model = 'oracle2', livery = 0},
    },
    [2] = { -- Sergeant
        {label = "Unmarked Sedan", model = 'oracle2', livery = 0},
        {label = "Unmarked SUV", model = 'granger', livery = 0},
    },
    [3] = { -- Lieutenant
        {label = "Unmarked Sedan", model = 'oracle2', livery = 0},
        {label = "Unmarked SUV", model = 'granger', livery = 0},
        {label = "Transport Van", model = 'pbus2', livery = 0},
    },
    [4] = { -- Detective
        {label = "Unmarked Sedan", model = 'oracle2', livery = 0},
        {label = "Unmarked SUV", model = 'granger', livery = 0},
        {label = "Forensics Van", model = 'burrito3', livery = 0},
    },
    [5] = { -- Captain
        {label = "Unmarked Sedan", model = 'oracle2', livery = 0},
        {label = "Unmarked SUV", model = 'granger', livery = 0},
        {label = "Transport Van", model = 'pbus2', livery = 0},
        {label = "Forensics Van", model = 'burrito3', livery = 0},
    },
    [6] = { -- Judge
        {label = "Unmarked Sedan", model = 'oracle2', livery = 0},
        {label = "Executive SUV", model = 'baller6', livery = 0},
    },
    [7] = { -- Chief
        {label = "Unmarked Sedan", model = 'oracle2', livery = 0},
        {label = "Unmarked SUV", model = 'granger', livery = 0},
        {label = "Transport Van", model = 'pbus2', livery = 0},
        {label = "Forensics Van", model = 'burrito3', livery = 0},
        {label = "Executive SUV", model = 'baller6', livery = 0},
    },
}

-- Items (for inventory adapters)
Config.Items = {
    printedPhoto   = 'printed_photo',
    evidencePaper  = 'evidence_paper',  -- manually typed/printed documents
    evidenceReport = 'evidence_report', -- printed reports from the database
}

-- Metal Detector Settings
Config.MetalDetectorSettings = {
    scanInterval = 1000,        -- How often to check for players (ms)
    scanRadius = 2.5,           -- Radius around detector entry/exit
    detectionDelay = 2000,      -- Cooldown between alerts for same player (ms)
    alertSound = true,          -- Play alert sound when weapon detected
    confiscateOnDetect = false, -- Auto-confiscate or just alert
    notifyNearbyOfficers = true, -- Notify nearby DOJ/Police
    notifyRadius = 50.0,        -- Radius to notify officers
}

-- Gavel Configuration Settings
Config.Gavels = {
    ['Gavel_1'] = {
        coords = vector3(-516.02, -589.89, 36.2),
        jobs = {['doj'] = 0},
        volume = 0.5,       -- sound volume [0.0 - 1.0]
        distance = 17.5,    -- sound distance
        courtroom = 1       -- Link to courtroom index (optional)
    },
}

-- Available gavel sounds (all sounds available at each gavel location)
Config.GavelSounds = {
    {name = 'Gavel 1', file = 'gavel_one'},
    {name = 'Gavel 2', file = 'gavel_three'},
}

-- Microphone Configuration Settings
Config.Microphones = {
    ['Judge'] = {
        coords = vector3(-516.6304, -589.6918, 36.2142),
        volume = 0.7,         -- Voice volume multiplier [0.0 - 1.0]
        distance = 20.0,      -- Voice range distance (radius in meters)
        boost = 2.5,          -- Voice range boost multiplier
        courtroom = 1         -- Link to courtroom index
    },
    ['Defense'] = {
        coords = vector3(-518.2222, -595.0991, 35.6030),
        volume = 0.6,
        distance = 18.0,
        boost = 2.0,
        courtroom = 1
    },
    ['Prosecutor'] = {
        coords = vector3(-513.1133, -595.3092, 35.4555),
        volume = 0.6,
        distance = 18.0,
        boost = 2.0,
        courtroom = 1
    },
}

-- Printer Locations Configuration
Config.Printers = {
    ['CityHall_1'] = {
        coords = vector3(-615.1823, -568.9207, 34.9786),
        radius = 0.5,
        jobs = {
            ['doj'] = 0,
        },
    },
    ['CityHall_2'] = {
        coords = vector3(-567.14, -604.0, 35.7),
        radius = 0.5,
        jobs = {
            ['doj'] = 0,
        },
    },
}

-- Printer Settings
Config.PrinterSettings = {
    printCost = 0,              -- Cost per print (deducted from society or personal)
    printTime = 5000,           -- Time to print in ms
    maxDocumentSize = 5000,     -- Max characters in document
    allowColorPrint = true,
    paperItem = 'paper',        -- Inventory item for paper
    requirePaper = false,       -- Require paper item in inventory to print
    colorPrintCost = 10,        -- Cost for color printing (if different from regular)
}

-- Notification Settings
Config.NotificationSettings = {
    position = 'top-right',     -- ox_lib notification position
    duration = 5000,            -- Default notification duration (ms)
    icons = {
        success = 'check-circle',
        error = 'exclamation-triangle',
        info = 'info-circle',
        warning = 'exclamation-circle',
    }
}

