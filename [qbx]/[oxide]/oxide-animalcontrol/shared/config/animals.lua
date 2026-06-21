-- Animal model definitions
Config.Animals = {
    ['a_c_rottweiler']    = { name = 'Rottweiler', health = 200 },
    ['a_c_rottweiler_02'] = { name = 'Rottweiler', health = 200 },
    ['a_c_shepherd']      = { name = 'German Shepherd', health = 200 },
    ['a_c_husky']         = { name = 'Husky', health = 200 },
    ['a_c_retriever']     = { name = 'Golden Retriever', health = 200 },
    ['a_c_poodle']        = { name = 'Poodle', health = 100 },
    ['a_c_pug']           = { name = 'Pug', health = 80 },
    ['a_c_westy']         = { name = 'West Highland Terrier', health = 100 },
    ['a_c_cat_01']        = { name = 'Cat', health = 80 },
    ['a_c_cat_02']        = { name = 'Cat', health = 80 },
    ['a_c_coyote']        = { name = 'Coyote', health = 250 },
    ['a_c_mtlion']        = { name = 'Mountain Lion', health = 350 },
    ['a_c_panther']       = { name = 'Panther', health = 400 },
    ['a_c_deer']          = { name = 'Deer', health = 200 },
}

-- Tranquilizer weapon configuration
Config.Tranquilizer = {
    weaponHash = 'WEAPON_G2',
    weaponItem = 'weapon_g2',    -- inventory item name for the tranq gun
    ammoItem = 'ammo-9',    -- inventory item name for ammo (QBCore: 'ammo_pistol', ox_inventory: 'ammo-9')
    ammoPerCall = 5,
    sedationDuration = 30000, -- ms the animal stays ragdolled/sedated before waking up
    ammoResupplyCost = 50,    -- cost per additional ammo pack (deducted from shift pay)
    maxAmmoResupplies = 5,    -- max additional packs per shift (first pack at clock-in is free)
}

-- Stealth detection settings
-- Set useNativeStealth to false if your server uses a custom crouch system
-- that GetPedStealthMovement doesn't detect. When false, spook checks use
-- random chance instead of crouch detection.
Config.Stealth = {
    useNativeStealth = true,       -- true = use GetPedStealthMovement, false = random chance
    fallbackSpookChance = 0.35,    -- chance to spook per check when not using native stealth
    fallbackSafeChance = 0.70,     -- chance to NOT spook (simulates "being careful") when close
}

-- Per-job-type animal behavior settings
Config.AnimalBehavior = {
    [JobType.AGGRESSIVE_ANIMAL] = {
        task = 'combat',          -- TaskCombatPed on reporting NPC
        attackPlayerRange = 10.0, -- Range at which animal redirects aggression to player
        escapeRadius = 80.0,      -- If animal goes beyond this from spawn, it "escapes"
        npcScanRadius = 30.0,     -- Scan radius for nearby world peds to target/flee
        npcFleeRadius = 20.0,     -- World peds within this radius flee from the animal
    },
    [JobType.STRAY_CAPTURE] = {
        task = 'stray',
        wanderRadius = 15.0,      -- area the animal wanders in
        escapeRadius = 60.0,
        fleeRange = 12.0,         -- animal flees if player gets this close while not sneaking
        sneakRange = 5.0,         -- player can get this close while crouching without spooking
        spookChance = 0.4,        -- 40% chance to spook if player approaches standing
        spookFleeDistance = 20.0,  -- how far animal runs when spooked
        returnToBaitDelay = 8000,  -- ms before spooked animal returns to bait
        baitApproachDelay = 5000,  -- ms after player leaves before animal approaches bait
        captureRange = 2.5,        -- must be this close to capture
    },
    [JobType.WILDLIFE_REMOVAL] = {
        task = 'patrol',
        spotRange = 25.0,               -- animal spots standing player at this distance
        sneakRange = 12.0,              -- crouching player can get this close
        panicRange = 5.0,               -- spooks regardless of crouch
        wanderAtPointRadius = 8.0,      -- wander radius at each waypoint
        wanderAtPointTime = { 5000, 10000 }, -- min/max ms to wander before moving
        escapeRadius = 100.0,
        npcFleeRadius = 25.0,           -- World peds within this radius flee from wildlife
    },
    [JobType.DECEASED_PICKUP] = {
        task = 'dead',            -- Dead state / ragdoll
    },
}

-- Animal loading/unloading into the vehicle
Config.AnimalLoading = {
    loadDuration = 5000,          -- ms progress bar for loading animal into truck
    unloadDuration = 4000,        -- ms progress bar for unloading at shelter
    loadRange = 7.0,              -- Max distance from animal to begin loading
    shelterRange = 15.0,          -- Max distance from shelter point to unload
    vehicleAttachOffset = vec3(0.0, -1.5, 0.5), -- Offset inside vehicle cargo area
    vehicleAttachRotation = vec3(0.0, 0.0, 0.0),
}
