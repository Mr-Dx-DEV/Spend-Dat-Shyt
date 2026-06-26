Config.NpcModel = 's_m_m_autoshop_01'
Config.NpcScenario = 'WORLD_HUMAN_CLIPBOARD'

Config.Blip = {
    sprite = 68,
    color = 36,
    scale = 0.5,
    label = 'blip.tow_yard',
}

Config.EventBlip = {
    sprite = 280,
    color = 33,
    scale = 0.5,
}

Config.DeliveryBlip = {
    sprite = 225,
    color = 5,
    scale = 0.5,
}

Config.Waypoints = {
    heightOffset = 5.0,
    updateInterval = 0,
    scaleMin = 0.5,
    scaleMax = 1.0,
    scaleNearDist = 30.0,
    scaleFarDist = 300.0,
}

Config.DriverPeds = {
    'a_m_y_hipster_01',
    'a_m_y_hipster_02',
    'a_m_m_business_01',
    'a_f_y_business_01',
    'a_m_y_business_02',
    'a_f_y_hipster_01',
    'a_m_m_soucent_03',
    'a_f_m_beach_01',
    'a_m_m_bevhills_02',
    'a_m_m_tourist_01',
    'a_f_y_tourist_01',
    'a_m_y_genstreet_02',
    'a_f_m_bevhills_01',
    'a_m_y_downtown_01',
    'a_f_y_scdressy_01',
    'a_m_m_afriamer_01',
}

-- Stranded NPC behavior configuration
Config.StrandedNPC = {
    -- Offset from vehicle for NPC standing position (right side of vehicle)
    standOffset = vec3(2.5, 0.5, 0.0),
    -- Animations the NPC cycles through while waiting
    animations = {
        { dict = 'oddjobs@towingcome_here', clip = 'come_here_idle_a', duration = 8000 },
        { dict = 'oddjobs@towingpleadingidle_a', clip = 'idle_c', duration = 10000 },
        { dict = 'oddjobs@towingpleadingidle_b', clip = 'idle_d', duration = 10000 },
    },
    -- Impatient animation when timer is running low (< 60s remaining)
    impatientAnim = { dict = 'oddjobs@towingangryidle_a', clip = 'idle_b' },
    -- Ambient scenarios when player is far away
    farScenario = 'WORLD_HUMAN_STAND_MOBILE',
    -- Distance threshold to switch between animation cycle and ambient scenario
    animationDistance = 40.0,
}

-- Vehicle breakdown visual effects
Config.BreakdownVisuals = {
    -- Damage points applied to stranded vehicles (offset from vehicle center)
    damagePoints = {
        { offset = vec3(0.0, 1.2, 0.0), amount1 = 200.0, amount2 = 100.0 },
        { offset = vec3(0.0, 0.75, 0.05), amount1 = 150.0, amount2 = 80.0 },
    },
    -- Engine health for smoking effect (1.0 = critical smoke, no fire)
    engineHealth = 100.0,
    -- Whether to enable hazard lights on all breakdown types
    alwaysHazards = true,
}

-- Traffic safety zone around breakdown scenes
Config.SafetyZone = {
    enabled = true,
    -- Speed zone tiers: { radius, speed } (inner to outer)
    speedZones = {
        { radius = 15.0, speed = 4.0 },
        { radius = 30.0, speed = 15.0 },
        { radius = 50.0, speed = 25.0 },
    },
    -- Scenario blocking radius (prevents ambient peds from entering)
    scenarioBlockRadius = 20.0,
    -- Clear parked vehicles radius
    clearVehiclesRadius = 10.0,
}

-- Road cone system (take from truck, free-place via ghost preview, pick up)
Config.Cones = {
    enabled = true,
    model = 'prop_roadcone01a',
    maxCones = 3,
    -- Bonus payment per cone placed when job completes
    bonusPerCone = 5,
    -- Max placement distance from player (meters)
    placementRange = 6.0,
    -- Attach positions on the tow truck bed (one per cone)
    truckAttach = {
        { bone = 3, offset = vec3(0.85, -1.4, 0.25), rotation = vec3(0.0, 0.0, 0.0) },
        { bone = 3, offset = vec3(-0.85, -1.4, 0.25), rotation = vec3(0.0, 0.0, 0.0) },
        { bone = 3, offset = vec3(-0.85, -1.0, 0.25), rotation = vec3(0.0, 0.0, 0.0) },
    },
    -- How the cone attaches to the player's hand (held from the top)
    playerAttach = {
        bone = 28422,  -- SKEL_R_Hand
        offset = vec3(0.7, -0.4, -0.1),
        rotation = vec3(-30.0, -90.0, -15.0),
    },
}

-- Particle effects for repair work
Config.RepairEffects = {
    enabled = true,
    -- Spark effect used during battery and wheel work
    spark = {
        dict = 'core',
        name = 'ent_dst_elec_fire_sp',
        scale = 0.4,
        duration = 1500,
    },
}
