Config = {}

Config.Framework = "esx"

---------------------------------------------------------------------------
-- Virtual Storage (optional – no inventory items needed)
---------------------------------------------------------------------------
-- When true, all syringe_sisters items are stored in script storage only.
-- You do NOT need to add items to ox_inventory, qb-inventory, or ESX items.
-- Use commands: /usebbl, /delivery, /startrobbery (replaces inventory item use)
-- /givevirtual [id] [item] [amount] – give virtual items (requires GiveVirtualAce)
---------------------------------------------------------------------------
Config.UseVirtualStorage = false
Config.GiveVirtualAce = "group.admin"  -- ACE permission for /givevirtual (nil = anyone)
-- If you are female but get "This product is not for you", your framework may store sex as "Female"/"F" or in variables; the script now accepts those. If sex is never set, set this to false.
Config.FemaleOnly = true
-- Only players with this job can craft BBL Shots. Set to nil or "" to allow anyone (who passes FemaleOnly) to craft.
Config.CraftJob = "sisters"
Config.PoliceRequired = 0
Config.GangAttackChance = 1.0

---------------------------------------------------------------------------
-- BBL Shot usable item settings
---------------------------------------------------------------------------
Config.BBLShot = {
    HealthBoost   = 25,          -- HP to restore (out of 200 max)
    StaminaBoost  = 30.0,        -- Stamina to restore (0.0 – 100.0)
    ScreenEffect  = "DrugsMichaelAliensFightIn",  -- screen effect name
    EffectDuration = 5000,       -- screen effect duration in ms
    UseAnim = {
        dict = "anim@heists@narcotics@funding@ig4_female",
        clip = "yourewelcome_male",
    },
    UseTime       = 3000,        -- progress bar duration in ms
    Cooldown      = 30,          -- seconds before the item can be used again
}

---------------------------------------------------------------------------
-- Gang Interference settings
---------------------------------------------------------------------------
Config.GangAttack = {
    Chance = Config.GangAttackChance, -- probability per trigger (0.0 – 1.0)

    -- Which activities can trigger a gang attack
    Triggers = {
        crafting      = true,
        streetSelling = true,
        delivery      = true,
    },

    -- How many gang members spawn (random between min and max)
    MinPeds = 2,
    MaxPeds = 4,

    -- Ped models (one chosen at random per spawned ped)
    Models = {
        "g_m_y_ballasout_01",
        "g_m_y_ballaorig_01",
        "g_m_y_famca_01",
        "g_m_y_famdnf_01",
        "g_m_y_lost_01",
        "g_m_y_lost_02",
        "g_m_y_salvagoon_01",
        "g_m_y_salvagoon_02",
        "g_m_y_strpunk_01",
    },

    -- Weapons (one chosen at random per spawned ped)
    Weapons = {
        "WEAPON_PISTOL",
        "WEAPON_MICROSMG",
        "WEAPON_SWITCHBLADE",
        "WEAPON_PISTOL50",
    },

    -- How far from the player gang members appear
    SpawnDistance = { min = 25.0, max = 40.0 },

    -- Combat AI tuning
    CombatAbility  = 2,   -- 0 = poor, 1 = average, 2 = professional
    CombatMovement = 2,   -- 0 = stationary, 1 = defensive, 2 = offensive
    CombatRange    = 1,   -- 0 = near, 1 = medium, 2 = far
    Accuracy       = 45,  -- 0 – 100
    Armor          = 0,   -- 0 – 200

    -- Auto-despawn if the player survives (seconds)
    DespawnTime = 120,    -- 2 minutes

    -- Item theft when the player dies during an attack
    StealItem      = "bbl_shot",
    StealAmountMin = 1,
    StealAmountMax = 3,

    -- Cooldown between gang attacks so they don't chain (seconds)
    Cooldown = 0, -- 5 minutes
}

---------------------------------------------------------------------------
-- Crafting table settings
---------------------------------------------------------------------------
Config.CraftingProp = "tr_prop_meth_table01a" -- Prop model for the crafting table

Config.CraftingLocations = {
    {
        coords = vector3(939.1633, -542.8693, 56.83),
        heading = 310.48,
    },
}

---------------------------------------------------------------------------
-- Recipes – ingredient amounts are fully configurable here
---------------------------------------------------------------------------
Config.Recipes = {
    bbl_shot = {
        label    = "BBL Shot",
        result   = { item = "bbl_shot", amount = 3 },
        ingredients = {
            { item = "medical_silicone", label = "Medical Silicone", amount = 2 },
            { item = "syringe",          label = "Syringe",          amount = 1 },
            { item = "painkillers",      label = "Painkillers",      amount = 3 },
        },
        time = 12000, -- crafting duration in ms (10 000 – 15 000 recommended)
        anim = {
            dict = "mini@repair",
            clip = "fixing_a_ped",
        },
    },
}

---------------------------------------------------------------------------
-- Other locations (unused stubs kept for future features)
---------------------------------------------------------------------------
Config.HospitalLocations = {
    vector3(311.2, -590.4, 43.3),
    vector3(-449.8, -340.2, 34.5),
    vector3(1839.5, 3672.9, 34.3),
}

Config.StreetSellZones = {
    { coords = vector3(1274.5, -1720.2, 54.8), radius = 15.0 },
    { coords = vector3(-1192.3, -767.1, 17.3), radius = 12.0 },
    { coords = vector3(1138.2, -982.8, 46.4), radius = 10.0 },
}

---------------------------------------------------------------------------
-- Street Selling settings  (/sellbbl)
---------------------------------------------------------------------------
Config.StreetSelling = {
    -- Commands
    Command       = "sellbbl",      -- Start selling
    CancelCommand = "cancelsell",   -- Stop selling
    BlipCommand   = "sellblips",    -- Toggle sell-zone blips on/off

    -- Item consumed per sale
    Item          = "bbl_shot",
    AmountPerSale = 1,

    -- NPC buyer timing (seconds) – random interval between buyers
    NpcIntervalMin = 30,
    NpcIntervalMax = 40,

    -- Payment
    PriceMin  = 800,
    PriceMax  = 2500,
    MoneyType = "cash", -- "cash" or "bank"

    -- Cooldown before /sellbbl can be used again after stopping (seconds)
    Cooldown = 300,

    -- Police alert chance per sale (0.0 – 1.0)
    PoliceChance      = 0.20,
    PoliceJobName     = "police",
    PoliceAlertMessage = "10-90 Suspicious street activity reported",
    PoliceBlipTime    = 45,     -- seconds the alert blip shows for cops
    PoliceBlipSprite  = 161,
    PoliceBlipColor   = 1,

    -- NPC buyer models (one chosen at random per buyer)
    BuyerModels = {
        "a_f_y_beach_01",
        "a_f_y_bevhills_01",
        "a_f_y_bevhills_02",
        "a_f_y_business_01",
        "a_f_y_fitness_01",
        "a_f_y_hipster_01",
        "a_f_y_vinewood_01",
        "a_f_m_bevhills_01",
        "a_f_m_bevhills_02",
        "a_f_y_tourist_01",
    },

    -- Sell-zone map blip appearance
    Blip = {
        sprite = 280,
        color  = 8,
        scale  = 0.7,
        label  = "BBL Sell Zone",
    },

    -- Animations during the hand-off
    SellerAnim = { dict = "mp_common", clip = "givetake1_a" },
    BuyerAnim  = { dict = "mp_common", clip = "givetake1_b" },
}

Config.BlackMarketPed = {
    model  = "a_m_m_eastsa_01",                     -- Ped model (configurable)
    coords = vector4(18.16, -1329.44, 28.48, 174.08),  -- Spawn location

    -- Third-eye target system: "ox_target" or "qb-target"
    targetSystem    = "ox_target",
    interactLabel   = "Browse Black Market",
    interactIcon    = "fas fa-skull-crossbones",
    interactDistance = 2.0,

    -- Map blip
    blip = {
        enabled = true,
        sprite  = 110,
        color   = 1,
        scale   = 0.7,
        label   = "Shady Dealer",
    },

    -- Money type to charge: "cash" or "bank"
    moneyType = "cash",

    -- Purchasable items (id must match your inventory item name)
    items = {
        {
            id          = "medical_silicone",
            label       = "Medical Silicone",
            price       = 500,
            max         = 10,
            description = "Industrial-grade silicone filler",
        },
        {
            id          = "syringe",
            label       = "Syringe",
            price       = 150,
            max         = 20,
            description = "Sterile injection syringe",
        },
        {
            id          = "painkillers",
            label       = "Painkillers",
            price       = 250,
            max         = 15,
            description = "Strong prescription painkillers",
        },
        {
            id          = "stolen_keycard",
            label       = "Stolen Keycard",
            price       = 2000,
            max         = 1,
            description = "Hospital access keycard — single use",
        },
    },
}

---------------------------------------------------------------------------
-- Hospital Robbery settings
---------------------------------------------------------------------------
Config.Robbery = {
    Cooldown        = 0,     -- Global cooldown in seconds (30 minutes)
    PoliceRequired  = 0,        -- Minimum police online to start
    PoliceJobName   = "police", -- Job name used to count cops

    -- Hospital target location (inside Pillbox Medical Center)
    Location = {
        coords        = vector3(-1834.71, -340.66, 49.46),
        heading       = 59.9,
        interactRadius = 2.0,
    },

    -- Blip shown to the robber while robbery is active
    Blip = {
        sprite = 61,
        color  = 1,
        scale  = 0.9,
        label  = "Hospital Robbery",
    },

    -- Security guards that spawn during the hack
    Guards = {
        model  = "s_m_m_security_01",
        weapon = "WEAPON_PISTOL",
        armor  = 50,
        spawnPoints = {
            vector4(-1891.8309, -352.9628, 49.2639, 306.2794),
            vector4(-1864.3269, -360.0431, 49.2972, 294.1010),
            vector4(-1849.4969, -372.6477, 49.1291, 15.3936),
        },
        spawnDelay  = 3000,  -- ms after hack starts before guards appear
        despawnTime = 60,    -- seconds after robbery ends before cleanup
    },

    -- Skillcheck (moving-bar timing minigame)
    Skillcheck = {
        rounds        = 4,
        baseSpeed     = 0.012,
        speedIncrease = 0.003,  -- added per round
        zoneSize      = 0.22,   -- fraction of bar that is the success zone
    },

    -- Animation played while hacking the cabinet
    HackAnim = {
        dict = "mini@repair",
        clip = "fixing_a_ped",
    },

    -- Configurable reward pool – random items given on success
    RewardPool = {
        { item = "medical_silicone", label = "Medical Silicone", min = 1, max = 3 },
        { item = "painkillers",      label = "Painkillers",      min = 2, max = 5 },
        { item = "syringe",          label = "Syringe",          min = 1, max = 3 },
        -- { item = "sterile_gauze",    label = "Sterile Gauze",    min = 1, max = 2 },
        -- { item = "saline_bag",       label = "Saline Bag",       min = 1, max = 2 },
        -- { item = "filler_compound",  label = "Filler Compound",  min = 1, max = 2 },
    },
    RewardsCount = { min = 2, max = 4 }, -- how many different items to receive

    -- Police alert on failure
    PoliceAlert = {
        enabled  = true,
        blipTime = 60,  -- how long the alert blip shows for cops (seconds)
        message  = "10-31 Burglary in progress at Pillbox Medical Center",
    },
}

---------------------------------------------------------------------------
-- Delivery System settings  (illegal_phone item)
---------------------------------------------------------------------------
Config.Delivery = {
    -- Item that opens the delivery phone menu (must be registered in your inventory)
    PhoneItem     = "illegal_phone",
    -- Item consumed per delivery
    DeliveryItem  = "bbl_shot",

    -- Random amount of shots required per delivery (2 – 5)
    MinShots = 2,
    MaxShots = 5,

    ---------------------------------------------------------------------------
    -- Payment (intentionally higher than street price $800–$2500)
    ---------------------------------------------------------------------------
    BasePricePerShot = 3000,    -- minimum per-shot payment
    MaxPricePerShot  = 4500,    -- maximum per-shot payment
    -- Scaling: each additional shot above MinShots adds this % bonus
    ScalingBonusPerShot = 0.10, -- +10 % per extra shot
    MoneyType = "cash",         -- "cash" or "bank"

    ---------------------------------------------------------------------------
    -- Cooldown
    ---------------------------------------------------------------------------
    Cooldown = 0,             -- seconds between deliveries (1 minutes)
    CancelPenalty = 120,        -- seconds cooldown when cancelling early
    Timeout  = 320,             -- seconds before an accepted delivery expires (1.5 min)

    ---------------------------------------------------------------------------
    -- Police alert chance per completed delivery
    ---------------------------------------------------------------------------
    PoliceChance       = 0.25,
    PoliceJobName      = "police",
    PoliceAlertMessage = "10-47 Suspicious package delivery reported",
    PoliceBlipSprite   = 161,
    PoliceBlipColor    = 1,
    PoliceBlipTime     = 60,    -- seconds the alert blip shows for cops

    ---------------------------------------------------------------------------
    -- Drop-off locations (one is chosen at random per delivery)
    ---------------------------------------------------------------------------
    DropLocations = {
        vector3(195.2, -932.8, 30.7),       -- Legion Square
        vector3(-1172.4, -1571.8, 4.7),     -- Vespucci Canals
        vector3(89.9, -1949.0, 20.8),       -- Davis
        vector3(1158.3, -314.5, 69.2),      -- Mirror Park
        vector3(-71.5, -46.5, 57.8),        -- Burton
        vector3(332.9, -207.6, 54.1),       -- Hawick
        vector3(-1531.9, -299.3, 48.9),     -- Del Perro
        vector3(1537.5, -2152.9, 77.0),     -- El Burro Heights
        vector3(728.6, -758.2, 26.3),       -- La Mesa
        vector3(-854.1, -232.1, 39.6),      -- Rockford Hills
        vector3(-722.7, -903.1, 19.1),      -- Little Seoul
        vector3(2432.04, 4979.05, 45.90),   -- Grapeseed (rural run)
    },

    -- Drop-off interaction radius
    InteractRadius = 3.0,

    -- Map blip shown while delivery is active
    Blip = {
        sprite = 501,
        color  = 5,
        scale  = 0.8,
        label  = "Delivery Drop-off",
    },

    ---------------------------------------------------------------------------
    -- NPC receiver at the drop-off
    ---------------------------------------------------------------------------
    ReceiverModels = {
        "a_m_y_business_01",
        "a_m_y_hipster_01",
        "a_m_m_eastsa_01",
        "a_m_m_soucent_01",
        "a_f_y_bevhills_01",
        "a_f_y_business_01",
        "a_m_y_vinewood_01",
        "a_m_m_skater_01",
    },

    -- Animations during the hand-off
    HandoffAnim   = { dict = "mp_common", clip = "givetake1_a" },
    ReceiverAnim  = { dict = "mp_common", clip = "givetake1_b" },
    HandoffTime   = 4000, -- ms for the exchange animation

    -- Phone animation while the menu is open
    PhoneAnim = { dict = "cellphone@", clip = "cellphone_text_read_base" },
}
