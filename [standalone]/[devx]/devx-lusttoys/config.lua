Config = {}

--================================--
-- Global
--================================--

Config.HornyNotificationText = "You feel very horny..."
Config.HornyNotificationInterval = 10000 -- ms

--================================--
-- Vibrator settings (REQUIRED)
--================================--

Config.Vibrator = {
    LowFrequency = 1,     -- 1% per second
    MediumFrequency = 3,  -- 3% per second
    HighFrequency = 5,    -- 5% per second
    ExtremeFrequency = 10 -- 10% per second
}

--================================--
-- Non-vibrator settings (REQUIRED)
--================================--

Config.NonVibrator = {
    ProgressPerSecond = 10 -- % per second
}

--================================--
-- Toy Config (NEW SYSTEM)
--================================--

Config.Toys = {

    vibrating_stick = {
        toycategory = 'vibrator',
        progressType = 'vibrator',
        propModel = 'massage_toy',
        animDict = 'switch@trevor@jerking_off',
        animName = 'trev_jerking_off_loop',
        bone = 28422,
        offset = { x = 0.09, y = 0.05, z = -0.03 },
        rotation = { x = 90.0, y = 80.0, z = 30.0 },
        animFlag = 49,
        ignoreMoveCheck = false,
        message = 'You have begun to pleasure yourself using a vibrator. Use ↑/↓ to change modes.',
        resumeMessage = 'You resume with the vibrator, starting slow again...'
    },

    floral_toy = {
        toycategory = 'vibrator',
        progressType = 'vibrator',
        propModel = 'flower_toy',
        animDict = 'switch@trevor@jerking_off',
        animName = 'trev_jerking_off_loop',
        bone = 28422,
        offset = { x = 0.09, y = 0.00, z = -0.03 },
        rotation = { x = 90.0, y = 80.0, z = 30.0 },
        animFlag = 49,
        ignoreMoveCheck = false,
        message = 'You have begun to pleasure yourself using a vibrator. Use ↑/↓ to change modes.',
        resumeMessage = 'You resume with the vibrator, starting slow again...'
    },

    pink_stick = {
        toycategory = 'non-vibrator',
        progressType = 'nonvibrator',
        propModel = 'rod_toy',
        animDict = 'switch@trevor@jerking_off',
        animName = 'trev_jerking_off_loop',
        bone = 28422,
        offset = { x = 0.09, y = 0.10, z = -0.03 },
        rotation = { x = 90.0, y = 80.0, z = 30.0 },
        animFlag = 49,
        ignoreMoveCheck = false,
        message = 'You have begun to pleasure yourself using the toy.',
        resumeMessage = 'You resume using the toy...'
    },

    pocket_toy = {
        toycategory = 'pocket',
        progressType = 'nonvibrator',
        propModel = 'pocket_toy',
        animDict = 'timetable@trevor@skull_loving_bear',
        animName = 'skull_loving_bear',
        bone = 57005,
        offset = { x = 0.14, y = 0.02, z = 0.01 },
        rotation = { x = -95.0, y = 180.0, z = 0.0 },
        animFlag = 1,
        ignoreMoveCheck = true,
        message = 'You begin using your pocket toy...',
        resumeMessage = 'You resume using your pocket toy...'
    },

    teddybear = {
        toycategory = 'pocket',
        progressType = 'nonvibrator',
        propModel = 'prop_mr_raspberry_01',
        animDict = 'timetable@trevor@skull_loving_bear',
        animName = 'skull_loving_bear',
        bone = 57005,
        offset = { x = 0.0, y = 0.0, z = 0.0 },
        rotation = { x = -0.0, y = 0.0, z = 0.0 },
        animFlag = 1,
        ignoreMoveCheck = true,
        message = 'You begin using a teddy bear, you freak...',
        resumeMessage = 'You resume using your teddy bear, you freak...'
    },

}

--================================--
-- Misc
--================================--

Config.ShowVibeChat = true -- floating text

Config.FinishEffects = {
    Duration = 60000,
    Effects = {
        maxhealth = true,
        armor = 50,
        speed = 1.2,
        melee = 2.0,
    }
}