Config.Vehicle = {
    model = 'boxville2',
    spawnDistance = 5.0,
    healthCheckInterval = 1000,
    destroyedThreshold = 150,
    damageChargeRate = 0.50,
    damageChargeThreshold = 950,
    rearDoors = { 2, 3 },
    primaryColor = { 255, 255, 255 },
    secondaryColor = { 255, 255, 255 },
}

Config.Pallet = {
    model = 'bkr_prop_coke_pallet_01a',
    boxModel = 'prop_cs_cardbox_01',
    maxVisibleBoxes = 12,
    pickupTime = 3000,
    loadTime = 2000,
    vanProximity = 5.0,
    palletProximity = 2.5,
    carryBone = 24818,
    carryOffset = vector3(-0.2, 0.54, 0.0),
    carryRotation = vector3(0.0, 90.0, 0.0),
    carry = {
        dict = 'anim@heists@box_carry@',
        anim = 'idle',
        flags = 49,
    },
    pickupAnimation = {
        duration = 3000,
        dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
        anim = 'machinic_loop_mechandplayer',
        flags = 1,
    },
}

Config.Letter = {
    postBoxModel = 'prop_postbox_01a',
    letterBoxModels = {
        'prop_letterbox_01', 'prop_letterbox_02',
        'prop_letterbox_03', 'prop_letterbox_04',
    },
    mailBagModel = 'h4_prop_h4_med_bag_01b',
    envelopeModel = 'prop_cash_envelope_01',
    searchRadius = 15.0,
    pickupTime = 3000,
    loadTime = 2000,
    deliverTime = 2500,
    carryBone = 57005,
    carryOffset = vector3(0.35, 0.0, 0.0),
    carryRotation = vector3(-5.0, -90.0, 40.0),
    pickupAnimation = {
        duration = 3000,
        dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
        anim = 'machinic_loop_mechandplayer',
        flags = 1,
    },
}

Config.BoxOffsets = {
    { x = -0.3, y = -0.3, z = 0.40 },
    { x = 0.3,  y = -0.3, z = 0.40 },
    { x = -0.3, y = 0.3,  z = 0.40 },
    { x = 0.3,  y = 0.3,  z = 0.40 },
    { x = -0.3, y = -0.3, z = 0.699 },
    { x = 0.3,  y = -0.3, z = 0.699 },
    { x = -0.3, y = 0.3,  z = 0.699 },
    { x = 0.3,  y = 0.3,  z = 0.699 },
    { x = -0.3, y = -0.3, z = 0.99 },
    { x = 0.3,  y = -0.3, z = 0.99 },
    { x = -0.3, y = 0.3,  z = 0.99 },
    { x = 0.3,  y = 0.3,  z = 0.99 },
}

Config.VanBoxOffsets = {
    { x = -0.6, y = 0.0,  z = 0.2 },
    { x = 0.2,  y = 0.0,  z = -0.2 },
    { x = 0.6,  y = 0.0,  z = 0.2 },
    { x = -0.6, y = -0.6, z = 0.2 },
    { x = -0.3,  y = -0.6, z = -0.2 },
    { x = 0.6,  y = -0.6, z = 0.2 },
    { x = -0.6, y = -1.2, z = 0.2 },
    { x = -0.1,  y = -1.2, z = -0.2 },
    { x = 0.6,  y = -1.2, z = 0.2 },
    { x = -0.6, y = 0.0,  z = 0.55 },
    { x = 0.6,  y = 0.0,  z = 0.55 },
}

Config.VanBoxRotation = vector3(0.0, 0.0, 0.0)
