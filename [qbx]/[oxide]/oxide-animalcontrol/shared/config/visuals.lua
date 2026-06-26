Config.NpcModel = 's_m_m_doctor_01'
Config.NpcScenario = 'WORLD_HUMAN_CLIPBOARD'

Config.Blip = {
    sprite = 273,
    color = 2,
    scale = 0.5,
    label = 'blip.animal_control',
}

Config.EventBlip = {
    sprite = 463,
    color = 1,
    scale = 0.5,
}

Config.DeliveryBlip = {
    sprite = 141,
    color = 2,
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

-- Civilian ped models for the person who reported the animal incident
Config.ReportingNpcModels = {
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

-- Reporting NPC behavior (the civilian who called animal control)
Config.ReportingNPC = {
    standOffset = vec3(3.0, 0.0, 0.0),
    animations = {
        { dict = 'gestures@m@standing@casual', clip = 'gesture_come_here_hard', duration = 8000 },
        { dict = 'anim@mp_player_intcelebrationmale@frightened', clip = 'frightened', duration = 10000 },
        { dict = 'gestures@m@standing@casual', clip = 'gesture_hand_down', duration = 8000 },
    },
    thankAnim = { dict = 'gestures@m@standing@casual', clip = 'gesture_thanks' },
    farScenario = 'WORLD_HUMAN_STAND_MOBILE',
    animationDistance = 40.0,
}

-- Safety zone around animal scenes (lighter than roadside since not road-based)
Config.SafetyZone = {
    enabled = true,
    speedZones = {
        { radius = 15.0, speed = 8.0 },
        { radius = 30.0, speed = 20.0 },
    },
    scenarioBlockRadius = 15.0,
    clearVehiclesRadius = 8.0,
}
