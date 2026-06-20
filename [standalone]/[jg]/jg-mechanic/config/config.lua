Config = {}

-- Integrations (recommended to leave as "auto")
Config.Framework = "auto" -- or "QBCore", "Qbox", "ESX"
Config.Inventory = "auto" -- or "ox_inventory", "qb-inventory", "esx_inventory", "codem-inventory", "qs-inventory"
Config.Notifications = "auto" -- or "default", "ox_lib", "lation_ui", "ps-ui", "okokNotify", "nox_notify"
Config.ProgressBar = "auto" -- or "ox-circle", "ox-bar", "lation_ui", "qb"
Config.SkillCheck = "auto" -- or "ox", "qb", "lation_ui"
Config.DrawText = "auto" -- or "jg-textui", "ox_lib", "okokTextUI", "ps-ui", "lation_ui", "qb"
Config.SocietyBanking = "Renewed-Banking" -- or "okokBanking", "fd_banking", "Renewed-Banking", "tgg-banking", "wasabi_banking", "qb-banking", "qb-management", "esx_addonaccount"
Config.Menus = "ox" -- or "ox", "lation_ui"

-- Localisation
Config.Locale = "en"
Config.NumberAndDateFormat = "en-US"
Config.Currency = "USD"

-- Set to false to use built-in job system
Config.UseFrameworkJobs = true

-- Mechanic Tablet
Config.UseTabletCommand = "tablet" -- set to false to disable command
Config.TabletConnectionMaxDistance = 4.0

-- Shops
Config.Target = "ox_target" -- (shops/stashes only) "qb-target" or "ox_target"
Config.UseSocietyFund = true -- set to false to use player balance
Config.PlayerBalance = "bank" -- or "bank" or "cash"

-- Skill Bars
Config.UseSkillbars = true -- set to false to use progress bars instead of skill bars for installations
Config.ProgressBarDuration = 10000 -- if not using skill bars, this is the progress bar duration in ms (10000 = 10 seconds)
Config.MaximumSkillCheckAttempts = 3 -- How many times the player can attempt a skill check before the skill check fails
Config.SkillCheckDifficulty = { "easy", "easy", "easy", "easy", "easy" } -- for ox only
Config.SkillCheckInputs = { "w", "a", "s", "d" } -- for ox only

-- Servicing
Config.EnableVehicleServicing = true
Config.ServiceRequiredThreshold = 20 -- [%] if any of the servicable parts hit this %, it will flag that the vehicle needs servicing 
Config.ServicingBlacklist = {
  "police", "police2" -- Vehicles that are excluded from servicing damage
}

-- Nitrous
Config.NitrousScreenEffects = true
Config.NitrousRearLightTrails = true -- Only really visible at night
Config.NitrousPowerIncreaseMult = 2.0
Config.NitrousDefaultKeyMapping = "RMENU"
Config.NitrousMaxBottlesPerVehicle = 3 -- The UI can't really handle more than 7, more than that would be unrealistic anyway
Config.NitrousBottleDuration = 10 -- [in seconds] How long a nitrous tank lasts
Config.NitrousBottleCooldown = 5 -- [in seconds] How long until player can start using the next bottle
Config.NitrousPurgeDrainRate = 0.1 -- purging drains bottle only 10% as fast as actually boosting - set to 1 to drain at the same rate 

-- Stancing
Config.StanceMinSuspensionHeight = -0.3
Config.StanceMaxSuspensionHeight = 0.3
Config.StanceMinCamber = 0.0
Config.StanceMaxCamber = 0.5
Config.StanceMinTrackWidth = 0.5
Config.StanceMaxTrackWidth = 1.25
Config.StanceNearbyVehiclesFreqMs = 500

-- Repairs
Config.AllowFixingAtOwnedMechanicsIfNoOneOnDuty = false
Config.DuctTapeMinimumEngineHealth = 100.0
Config.DuctTapeEngineHealthIncrease = 150.0

-- Tuning
Config.TuningGiveInstalledItemBackOnRemoval = false

-- Locations
Config.UseCarLiftPrompt = "[E] Use car lift"
Config.UseCarLiftKey = 38
Config.CustomiseVehiclePrompt = "[E] Customise vehicle"
Config.CustomiseVehicleKey = 38

-- Update vehicle props whenever they are changed [probably should not touch]
Config.UpdatePropsOnChange = true

-- Stops vehicles from immediately going to redline
Config.SmoothFirstGear = false

-- If using a manual gearbox, show a notification with key binds when high RPMs 
-- have been detected for too long
Config.ManualHighRPMNotifications = true

-- Misc
Config.UniqueBlips = true
Config.ModsPricesAsPercentageOfVehicleValue = true
Config.AdminsHaveEmployeePermissions = false
Config.MechanicEmployeesCanSelfServiceMods = false
Config.FullRepairAdminCommand = "vfix"
Config.MechanicAdminCommand = "mechanicadmin"
Config.ChangePlateDuringPreview = "PREVIEW"
Config.RequireManagementForOrderDeletion = false 
Config.UseCustomNamesInTuningMenu = false
Config.DisableNoPaymentOptionForEmployees = false

-- Mechanic Locations
Config.MechanicLocations = {

  -- ── BENNY'S ─────────────────────────────────────────────────────
  bennys = {
    type = "self-service",
    logo = "bennys.png",
    locations = {
      {
        coords = vector3(-211.6, -1324.73, 30.23),
        size = 8.0,
        showBlip = true,
      }
    },
    blip = {
      id = 446,
      color = 47,
      scale = 0.7
    },
    mods = {
      repair           = { enabled = true, price = 500, percentVehVal = 0.01 },
      performance      = { enabled = true, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      cosmetics        = { enabled = true, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      stance           = { enabled = true, price = 500, percentVehVal = 0.01 },
      respray          = { enabled = true, price = 500, percentVehVal = 0.01 },
      wheels           = { enabled = true, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      neonLights       = { enabled = true, price = 500, percentVehVal = 0.01 },
      headlights       = { enabled = true, price = 500, percentVehVal = 0.01 },
      tyreSmoke        = { enabled = true, price = 500, percentVehVal = 0.01 },
      bulletproofTyres = { enabled = true, price = 500, percentVehVal = 0.01 },
      extras           = { enabled = true, price = 500, percentVehVal = 0.01 }
    },
  }, -- FIX: closes bennys

  -- ── LS CUSTOMS (bennysdocks) ─────────────────────────────────────
  -- FIX: was a duplicate key 'lscustoms' nested inside itself — renamed to distinguish
  lscustoms_docks = {
    type = "owned",
    job = "bennysdocks",
    jobManagementRanks = {4},
    logo = "ls_customs.png",
    commission = 0,
    locations = {
      {
        coords = vector3(141.056046, -3029.938721, 7.040637),
        size = 6.5,
        showBlip = true,
      },
      {
        coords = vector3(141.986221, -3020.258057, 7.249924),
        size = 3.0,
        showBlip = false,
        employeeOnly = true,
      },
      {
        coords = vector3(126.779549, -3023.769531, 7.249923),
        size = 3.0,
        showBlip = false,
        employeeOnly = true,
      },
      {
        coords = vector3(127.194489, -3031.256836, 7.249931),
        size = 3.0,
        showBlip = false,
        employeeOnly = true,
      },
      {
        coords = vector3(127.194489, -3031.256836, 7.249931),
        size = 3.0,
        showBlip = false,
        employeeOnly = true,
      },
      {
        coords = vector3(127.152863, -3037.990967, 7.249936),
        size = 3.0,
        showBlip = false,
        employeeOnly = true,
      },
    },
    blip = {
      id = 446,
      color = 47,
      scale = 0.7
    },
    mods = {
      repair           = { enabled = true,  price = 500, percentVehVal = 0.01 },
      performance      = { enabled = true,  price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      cosmetics        = { enabled = true,  price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      stance           = { enabled = true,  price = 500, percentVehVal = 0.01 },
      respray          = { enabled = false, price = 500, percentVehVal = 0.01 },
      wheels           = { enabled = false, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      neonLights       = { enabled = true,  price = 500, percentVehVal = 0.01 },
      headlights       = { enabled = true,  price = 500, percentVehVal = 0.01 },
      tyreSmoke        = { enabled = false, price = 500, percentVehVal = 0.01 },
      bulletproofTyres = { enabled = false, price = 500, percentVehVal = 0.01 },
      extras           = { enabled = true,  price = 500, percentVehVal = 0.01 }
    },
    tuning = {
      engineSwaps  = { enabled = true, requiresItem = true },
      drivetrains  = { enabled = true, requiresItem = true },
      turbocharging = { enabled = true, requiresItem = true },
      tyres        = { enabled = true, requiresItem = true },
      brakes       = { enabled = true, requiresItem = true },
      driftTuning  = { enabled = true, requiresItem = true },
      gearboxes    = { enabled = true, requiresItem = true },
    },
    carLifts = {
      vector4(141.472000, -3033.947266, 7.040633, 82.582947)
    },
    shops = {
      {
        name = "Servicing Supplies",
        coords = vector3(-345.54, -131.32, 39.01),
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        items = {
          { name = "engine_oil",           label = "Engine Oil",           price = 50   },
          { name = "tyre_replacement",     label = "Tyre Replacement",     price = 2500 },
          { name = "clutch_replacement",   label = "Clutch Replacement",   price = 3000 },
          { name = "air_filter",           label = "Air Filter",           price = 300  },
          { name = "spark_plug",           label = "Spark Plug",           price = 100  },
          { name = "suspension_parts",     label = "Suspension Parts",     price = 2500 },
          { name = "brakepad_replacement", label = "Brakepad Replacement", price = 1500 },
        },
      },
      {
        name = "Advanced Upgrades",
        coords = vector3(-343.79, -139.92, 39.01),
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        items = {
          { name = "turbocharger",   label = "Turbo Charger",    price = 25000 },
          { name = "v8_engine",      label = "V8 Engine Upgrade", price = 40000 },
          { name = "ceramic_brakes", label = "Ceramic Brakes",   price = 15000 },
        },
      },
    },
    stashes = {
      {
        name = "Parts Bin",
        coords = vector3(-339.24, -132.2, 39.01),
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        slots = 10,
        weight = 50000,
      },
    },
  }, -- FIX: closes lscustoms_docks

  chicago_tint = {
    type = "owned",
    job = "chicagotint",
    jobManagementRanks = {4},
    logo = "ls_customs.png",
    commission = 0,
    locations = {
      {
        coords = vector3(111.165329, -207.871826, 54.587864),
        size = 6.5,
        showBlip = true,
      },
      {
        coords = vector3(113.6945, -208.9107, 54.5881),
        size = 3.0,
        showBlip = false,
        employeeOnly = true,
      },
      {
        coords = vector3(126.779549, -3023.769531, 7.249923),
        size = 3.0,
        showBlip = false,
        employeeOnly = true,
      },
    },
    blip = {
      id = 446,
      color = 47,
      scale = 0.7
    },
    mods = {
      repair           = { enabled = false,  price = 500, percentVehVal = 0.01 },
      performance      = { enabled = false,  price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      cosmetics        = { enabled = true,  price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      stance           = { enabled = false,  price = 500, percentVehVal = 0.01 },
      respray          = { enabled = true, price = 500, percentVehVal = 0.01 },
      wheels           = { enabled = false, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      neonLights       = { enabled = false,  price = 500, percentVehVal = 0.01 },
      headlights       = { enabled = false,  price = 500, percentVehVal = 0.01 },
      tyreSmoke        = { enabled = false, price = 500, percentVehVal = 0.01 },
      bulletproofTyres = { enabled = false, price = 500, percentVehVal = 0.01 },
      extras           = { enabled = true,  price = 500, percentVehVal = 0.01 }
    },
    tuning = {
      engineSwaps  = { enabled = false, requiresItem = true },
      drivetrains  = { enabled = false, requiresItem = true },
      turbocharging = { enabled = false, requiresItem = true },
      tyres        = { enabled = false, requiresItem = true },
      brakes       = { enabled = false, requiresItem = true },
      driftTuning  = { enabled = false, requiresItem = true },
      gearboxes    = { enabled = false, requiresItem = true },
    },
    carLifts = {
      vector4(0,0,0,0)
    },
    shops = {
      {
        name = "Servicing Supplies",
        coords = vector3(-345.54, -131.32, 39.01),
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        items = {
          { name = "engine_oil",           label = "Engine Oil",           price = 50   },
          { name = "tyre_replacement",     label = "Tyre Replacement",     price = 2500 },
          { name = "clutch_replacement",   label = "Clutch Replacement",   price = 3000 },
          { name = "air_filter",           label = "Air Filter",           price = 300  },
          { name = "spark_plug",           label = "Spark Plug",           price = 100  },
          { name = "suspension_parts",     label = "Suspension Parts",     price = 2500 },
          { name = "brakepad_replacement", label = "Brakepad Replacement", price = 1500 },
        },
      },
      {
        name = "Advanced Upgrades",
        coords = vector3(-343.79, -139.92, 39.01),
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        items = {
          { name = "turbocharger",   label = "Turbo Charger",    price = 25000 },
          { name = "v8_engine",      label = "V8 Engine Upgrade", price = 40000 },
          { name = "ceramic_brakes", label = "Ceramic Brakes",   price = 15000 },
        },
      },
    },
    stashes = {
      {
        name = "Parts Bin",
        coords = vector3(-339.24, -132.2, 39.01),
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        slots = 10,
        weight = 50000,
      },
    },
  },
    bennys = {
    type = "self-service",
    logo = "bennys.png",
    locations = {
      {
        coords = vector3(-211.6, -1324.73, 30.23),
        size = 8.0,
        showBlip = true,
      }
    },
    blip = {
      id = 446,
      color = 47,
      scale = 0.7
    },
    mods = {
      repair           = { enabled = true, price = 500, percentVehVal = 0.01 },
      performance      = { enabled = true, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      cosmetics        = { enabled = true, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      stance           = { enabled = true, price = 500, percentVehVal = 0.01 },
      respray          = { enabled = true, price = 500, percentVehVal = 0.01 },
      wheels           = { enabled = true, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      neonLights       = { enabled = true, price = 500, percentVehVal = 0.01 },
      headlights       = { enabled = true, price = 500, percentVehVal = 0.01 },
      tyreSmoke        = { enabled = true, price = 500, percentVehVal = 0.01 },
      bulletproofTyres = { enabled = true, price = 500, percentVehVal = 0.01 },
      extras           = { enabled = true, price = 500, percentVehVal = 0.01 }
    },
  }, -- FIX: closes bennys

  -- ── LS CUSTOMS (bennysdocks) ─────────────────────────────────────
  -- FIX: was a duplicate key 'lscustoms' nested inside itself — renamed to distinguish
  lscustoms_docks = {
    type = "owned",
    job = "ghostcustoms",
    jobManagementRanks = {4},
    logo = "ls_customs.png",
    commission = 0,
    locations = {
      {
        coords = vector3(587.2729, -178.0810, 54.7727),
        size = 6.5,
        showBlip = true,
      },
      {
        coords = vector3(583.3828, -177.9237, 54.7727),
        size = 3.0,
        showBlip = false,
        employeeOnly = true,
      },
      {
        coords = vector3(579.3454, -178.8031, 54.7644),
        size = 3.0,
        showBlip = false,
        employeeOnly = true,
      },
      {
        coords = vector3(575.7635, -178.7348, 54.7645),
        size = 3.0,
        showBlip = false,
        employeeOnly = true,
      },
    },
    blip = {
      id = 446,
      color = 47,
      scale = 0.7
    },
    mods = {
      repair           = { enabled = true,  price = 500, percentVehVal = 0.01 },
      performance      = { enabled = true,  price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      cosmetics        = { enabled = true,  price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      stance           = { enabled = true,  price = 500, percentVehVal = 0.01 },
      respray          = { enabled = true, price = 500, percentVehVal = 0.01 },
      wheels           = { enabled = false, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      neonLights       = { enabled = true,  price = 500, percentVehVal = 0.01 },
      headlights       = { enabled = true,  price = 500, percentVehVal = 0.01 },
      tyreSmoke        = { enabled = false, price = 500, percentVehVal = 0.01 },
      bulletproofTyres = { enabled = false, price = 500, percentVehVal = 0.01 },
      extras           = { enabled = true,  price = 500, percentVehVal = 0.01 }
    },
    tuning = {
      engineSwaps  = { enabled = true, requiresItem = true },
      drivetrains  = { enabled = true, requiresItem = true },
      turbocharging = { enabled = true, requiresItem = true },
      tyres        = { enabled = true, requiresItem = true },
      brakes       = { enabled = true, requiresItem = true },
      driftTuning  = { enabled = true, requiresItem = true },
      gearboxes    = { enabled = true, requiresItem = true },
    },
    carLifts = {
      vector4(141.472000, -3033.947266, 7.040633, 82.582947)
    },
    shops = {
      {
        name = "Servicing Supplies",
        coords = vector3(-345.54, -131.32, 39.01),
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        items = {
          { name = "engine_oil",           label = "Engine Oil",           price = 50   },
          { name = "tyre_replacement",     label = "Tyre Replacement",     price = 2500 },
          { name = "clutch_replacement",   label = "Clutch Replacement",   price = 3000 },
          { name = "air_filter",           label = "Air Filter",           price = 300  },
          { name = "spark_plug",           label = "Spark Plug",           price = 100  },
          { name = "suspension_parts",     label = "Suspension Parts",     price = 2500 },
          { name = "brakepad_replacement", label = "Brakepad Replacement", price = 1500 },
        },
      },
      {
        name = "Advanced Upgrades",
        coords = vector3(-343.79, -139.92, 39.01),
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        items = {
          { name = "turbocharger",   label = "Turbo Charger",    price = 25000 },
          { name = "v8_engine",      label = "V8 Engine Upgrade", price = 40000 },
          { name = "ceramic_brakes", label = "Ceramic Brakes",   price = 15000 },
        },
      },
    },
    stashes = {
      {
        name = "Parts Bin",
        coords = vector3(-339.24, -132.2, 39.01),
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        slots = 10,
        weight = 50000,
      },
    },
  }, -- FIX: closes lscustoms_docks

  -- ── LS CUSTOMS (ttmcustoms) ──────────────────────────────────────
  lscustoms = {
    type = "owned",
    job = "ttmcustoms",
    jobManagementRanks = {4},
    logo = "ls_customs.png",
    commission = 0,
    locations = {
      {
        coords = vector3(-942.554810, -2047.339966, 9.051043),
        size = 6.5,
        showBlip = true,
      },
      {
        coords = vector3(-937.3876, -2056.8064, 9.2509),
        size = 3.0,
        showBlip = false,
        employeeOnly = true,
      },
      {
        coords = vector3(-932.7174, -2051.6516, 9.2509),
        size = 3.0,
        showBlip = false,
        employeeOnly = true,
      },
      {
        coords = vector3(-950.5607, -2033.8109, 9.2509),
        size = 3.0,
        showBlip = false,
        employeeOnly = true,
      },
      {
        coords = vector3(-955.4609, -2028.3301, 9.2709),
        size = 3.0,
        showBlip = false,
        employeeOnly = true,
      },
      {
        coords = vector3(-964.4181, -2036.9161, 9.2509),
        size = 3.0,
        showBlip = false,
        employeeOnly = true,
      },
    },
    blip = {
      id = 446,
      color = 47,
      scale = 0.7
    },
    mods = {
      repair           = { enabled = true,  price = 500, percentVehVal = 0.01 },
      performance      = { enabled = true,  price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      cosmetics        = { enabled = true,  price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      stance           = { enabled = true,  price = 500, percentVehVal = 0.01 },
      respray          = { enabled = true, price = 500, percentVehVal = 0.01 },
      wheels           = { enabled = false, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      neonLights       = { enabled = true,  price = 500, percentVehVal = 0.01 },
      headlights       = { enabled = true,  price = 500, percentVehVal = 0.01 },
      tyreSmoke        = { enabled = true, price = 500, percentVehVal = 0.01 },
      bulletproofTyres = { enabled = true, price = 500, percentVehVal = 0.01 },
      extras           = { enabled = true,  price = 500, percentVehVal = 0.01 }
    },
    tuning = {
      engineSwaps   = { enabled = true, requiresItem = true },
      drivetrains   = { enabled = true, requiresItem = true },
      turbocharging = { enabled = true, requiresItem = true },
      tyres         = { enabled = true, requiresItem = true },
      brakes        = { enabled = true, requiresItem = true },
      driftTuning   = { enabled = true, requiresItem = true },
      gearboxes     = { enabled = true, requiresItem = true },
    },
    carLifts = {
      vector4(-944.0649, -2041.3660, 9.0510, 313.5771),
    },
    shops = {
      {
        name = "Servicing Supplies",
        coords = vector3(-345.54, -131.32, 39.01),
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        items = {
          { name = "engine_oil",           label = "Engine Oil",           price = 50   },
          { name = "tyre_replacement",     label = "Tyre Replacement",     price = 2500 },
          { name = "clutch_replacement",   label = "Clutch Replacement",   price = 3000 },
          { name = "air_filter",           label = "Air Filter",           price = 300  },
          { name = "spark_plug",           label = "Spark Plug",           price = 100  },
          { name = "suspension_parts",     label = "Suspension Parts",     price = 2500 },
          { name = "brakepad_replacement", label = "Brakepad Replacement", price = 1500 },
        },
      },
      {
        name = "Advanced Upgrades",
        coords = vector3(-343.79, -139.92, 39.01),
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        items = {
          { name = "turbocharger",   label = "Turbo Charger",     price = 25000 },
          { name = "v8_engine",      label = "V8 Engine Upgrade", price = 40000 },
          { name = "ceramic_brakes", label = "Ceramic Brakes",    price = 15000 },
        },
      },
    },
    stashes = {
      {
        name = "Parts Bin",
        coords = vector3(-339.24, -132.2, 39.01),
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        slots = 10,
        weight = 50000,
      },
    },
  }, -- FIX: closes lscustoms
   -- ── LS CUSTOMS (chicago ──────────────────────────────────────
  chicago = {
    type = "owned",
    job = "chicago",
    jobManagementRanks = {4},
    logo = "ls_customs.png",
    commission = 0,
    locations = {
      {
        coords = vector3(275.227966, -1161.710938, 29.291508),
        size = 6.5,
        showBlip = true,
      },
      {
        coords = vector3(-937.3876, -2056.8064, 9.2509),
        size = 3.0,
        showBlip = false,
        employeeOnly = true,
      },
      {
        coords = vector3(-932.7174, -2051.6516, 9.2509),
        size = 3.0,
        showBlip = false,
        employeeOnly = true,
      },
    },
    blip = {
      id = 446,
      color = 47,
      scale = 0.7
    },
    mods = {
      repair           = { enabled = false,  price = 500, percentVehVal = 0.01 },
      performance      = { enabled = false,  price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      cosmetics        = { enabled = false,  price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      stance           = { enabled = false,  price = 500, percentVehVal = 0.01 },
      respray          = { enabled = false, price = 500, percentVehVal = 0.01 },
      wheels           = { enabled = true, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      neonLights       = { enabled = false,  price = 500, percentVehVal = 0.01 },
      headlights       = { enabled = false,  price = 500, percentVehVal = 0.01 },
      tyreSmoke        = { enabled = false, price = 500, percentVehVal = 0.01 },
      bulletproofTyres = { enabled = false, price = 500, percentVehVal = 0.01 },
      extras           = { enabled = false,  price = 500, percentVehVal = 0.01 }
    },
    tuning = {
      engineSwaps   = { enabled = false, requiresItem = true },
      drivetrains   = { enabled = false, requiresItem = true },
      turbocharging = { enabled = false, requiresItem = true },
      tyres         = { enabled = true, requiresItem = true },
      brakes        = { enabled = false, requiresItem = true },
      driftTuning   = { enabled = false, requiresItem = true },
      gearboxes     = { enabled = false, requiresItem = true },
    },
    carLifts = {
      vector4(273.159058, -1168.734253, 29.285635, 180.786621),
      vector4(277.176361, -1167.964844, 29.285591, 178.034546),
    },
    shops = {
      {
        name = "Servicing Supplies",
        coords = vector3(-345.54, -131.32, 39.01),
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        items = {
          { name = "engine_oil",           label = "Engine Oil",           price = 50   },
          { name = "tyre_replacement",     label = "Tyre Replacement",     price = 2500 },
          { name = "clutch_replacement",   label = "Clutch Replacement",   price = 3000 },
          { name = "air_filter",           label = "Air Filter",           price = 300  },
          { name = "spark_plug",           label = "Spark Plug",           price = 100  },
          { name = "suspension_parts",     label = "Suspension Parts",     price = 2500 },
          { name = "brakepad_replacement", label = "Brakepad Replacement", price = 1500 },
        },
      },
      {
        name = "Advanced Upgrades",
        coords = vector3(-343.79, -139.92, 39.01),
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        items = {
          { name = "turbocharger",   label = "Turbo Charger",     price = 25000 },
          { name = "v8_engine",      label = "V8 Engine Upgrade", price = 40000 },
          { name = "ceramic_brakes", label = "Ceramic Brakes",    price = 15000 },
        },
      },
    },
    stashes = {
      {
        name = "Parts Bin",
        coords = vector3(-339.24, -132.2, 39.01),
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        slots = 10,
        weight = 50000,
      },
    },
  },

} -- closes Config.MechanicLocationsssss

-- Add electric vehicles to disable combustion engine features
-----------------------------------------------------------------------
-- PLEASE NOTE: In b3258 (Bottom Dollar Bounties) and newer, electric
-- vehicles are detected automatically, so this list is not used! 
Config.ElectricVehicles = {
  "Airtug",     "buffalo5",   "caddy",
  "Caddy2",     "caddy3",     "coureur",
  "cyclone",    "cyclone2",   "imorgon",
  "inductor",   "iwagen",     "khamelion",
  "metrotrain", "minitank",   "neon",
  "omnisegt",   "powersurge", "raiden",
  "rcbandito",  "surge",      "tezeract",
  "virtue",     "vivanite",   "voltic",
  "voltic2",
}

-- Nerd options
Config.DisableSound = false
Config.AutoRunSQL = true
Config.Debug = false