Config.Props = {
    bait = {
        model = 'm25_1_prop_m51_dog_bowl_full',
        placementRange = 8.0,
        playerLeaveRadius = 15.0,     -- player must be this far from bait before animal approaches
        scentEffect = {
            dict = 'core',
            name = 'exp_grd_bzgas_smoke',
            scale = 0.2,
            offset = vec3(0.0, 0.0, 0.15),
        },
        playerAttach = {
            bone = 28422, -- SKEL_R_Hand
            offset = vec3(0.01, -0.1, -0.2),
            rotation = vec3(0.0, 0.0, 0.0),
            animDict = 'anim@heists@box_carry@',
            animName = 'idle',
        },
    },
}

-- Deceased bag (garbage bag for remains collection)
Config.DeceasedBag = {
    model = 'm25_2_prop_m52_binbag_01a',
    playerAttach = {
        bone = 28422, -- SKEL_R_Hand
        offset = vec3(0.0, 0.0, 0.35),
        rotation = vec3(0.0, 0.0, 0.0),
    },
    carryAnim = {
        dict = 'missfbi4prepp1',
        clip = '_idle_garbage_man',
    },
    pickupDuration = 1500,
    loadDuration = 4000,
}

-- Progress bar animations for different actions
Config.CaptureAnimation = {
    duration = 8000,
    dict = 'mini@repair',
    anim = 'fixing_a_player',
    flag = 1,
    label = 'progress.capturing_animal',
}

Config.BaitPlaceAnimation = {
    duration = 3000,
    dict = 'pickup_object',
    anim = 'pickup_low',
    flag = 1,
    label = 'progress.placing_bait',
}

Config.LoadAnimation = {
    duration = 5000,
    dict = 'mini@repair',
    anim = 'fixing_a_player',
    flag = 1,
    label = 'progress.loading_animal',
}

Config.UnloadAnimation = {
    duration = 4000,
    dict = 'anim@heists@box_carry@',
    anim = 'idle',
    flag = 1,
    label = 'progress.unloading_animal',
}
