Config.Effects = {
    -- Stress reduction: smoking lowers the player's stress level.
    -- Per-puff amount is defined on each item (Stats.Stress in the category config files).
    -- Strain Stats.Stress stacks on top. Short puffs scale proportionally to how long they're held.
    StressReduction = {
        Enabled = true,              -- false = smoking does nothing to stress
        ScalesWithHoldTime = true,   -- true = longer inhales reduce more stress. false = every puff reduces the full item value flat.
    },
    -- Armor gain: some items (like bongs) grant a small armor boost.
    -- Per-puff amount is defined on each item (Stats.Armor). Always scales with hold time.
    ArmorGain = {
        Enabled = false,              -- false = smoking never grants armor
        MaxArmor = 50,               -- Total armor cannot exceed this value from smoking (prevents stacking to full armor).
        DecayAfterSeconds = 300,     -- Seconds after the last puff before this armor starts wearing off (300 = 5 minutes).
    },
    -- Health change: subtly adjusts the player's health after every puff.
    -- Positive Stats.Health = HEAL, negative = DAMAGE. Leave Health unset on an item/strain to skip.
    -- Reads Stats.Health from the same places Stats.Stress/Stats.Armor come from:
    --   strains.lua (per strain), tobacco.lua / vapes.lua / mixing.lua (per item/group/juice/additive).
    -- Always scales with hold time. Kief/ground bonuses also apply.
    HealthChange = {
        Enabled = false,              -- false = smoking never modifies health
        MinHealth = 101,              -- Damage floor: health will never be reduced below this (101 = just above dead, prevents kills).
        MaxHealth = 200,              -- Healing ceiling: health will never be pushed above this (200 = GTA max).
        PerPuffCap = 5,               -- Hard sanity cap on absolute per-puff delta (server-side). Stops bad config or a hacked client from huge swings.
    },
    HighnessDecayRate = 2,           -- How much "high" is removed each decay tick. Higher = sober up faster.
    DecayIntervalMs = 5000,          -- How often (ms) the decay tick runs. 5000 = every 5 seconds.
    PeakHoldSeconds = 60,            -- How long (seconds) the player stays at peak high before decay begins. Per-strain PeakHoldSeconds overrides this.
    -- Gradual onset: instead of instantly hitting max high, the effect
    -- ramps up smoothly. Makes smoking feel more realistic.
    GradualOnset = {
        Enabled = true,              -- false = highness applies instantly with no smooth ramp
        RampUpSeconds = 25.0,        -- Seconds to reach full high after a puff.
        RampDownSeconds = 6.0,       -- Seconds for a recent puff's high to fade if you stop smoking.
        TickRateMs = 200,            -- How often (ms) the onset engine updates. Don't raise this too high or the ramp looks choppy.
    },
}

Config.StrainEffects = {
    Enabled = true,

    Cottonmouth = {
        Enabled = true,
        Thirst = { Min = 1, Max = 3 },
        Hunger = { Min = 1, Max = 3 },
    },

    TimeCycleFade = 15,

    sativa = {
        Timecycle = 'spectator5',                    -- Color filter applied over the screen while high. Use any GTA timecycle name.
        TimecycleStrength = 1.0,                     -- Max strength cap. 1.0 = normal full, 2.0 = overdrive, 0.5 = half.
        TimecycleStartAt = 1,                        -- Highness (0-100) where the linear ramp begins (after the fade-in band).
        TimecycleFullAt = 70,                        -- Highness (0-100) where strength reaches the cap. Lower = intensifies sooner.
        CameraShakeType = 'FAMILY5_DRUG_TRIP_SHAKE', -- Which camera shake preset to use. Common options: DRUNK_SHAKE, FAMILY5_DRUG_TRIP_SHAKE, HAND_SHAKE, SMALL_EXPLOSION_SHAKE.
        CameraShakeStrength = 0.1,                   -- How intense the shake is. 0.0 = none, 1.0 = strong.
        CameraShakeStartAt = 30,                     -- Highness level (0-100) where the shake starts.
        MotionBlurStartAt = 50,                      -- Highness level (0-100) where motion blur kicks in.
        HungerMultiplier = 0.8,                      -- Multiplier on the shared Cottonmouth hunger value. 0.8 = this type makes you LESS hungry than average.
        ThirstMultiplier = 1.3,                      -- Multiplier on the shared Cottonmouth thirst value. 1.3 = this type makes you 30% MORE thirsty.

        -- ScreenEffects: random post-processing flashes while very high.
        ScreenEffects = {
            Enabled = true,
            MinHighness = 60,                              -- These effects only trigger once the player is at least this high (0-100).
            WhenLowHigh  = { Min = 15000, Max = 20000 },   -- Time (ms) between effects when just above MinHighness. Random between Min and Max.
            WhenPeakHigh = { Min = 10000,  Max = 15000 },   -- Time (ms) between effects at 100% high. Effects fire much more often at peak.
            -- The actual screen effects to pick from randomly.
            --   name     = the GTA AnimPostFX effect name
            --   out      = the matching fade-out effect to stop it cleanly
            --   duration = how long (ms) it plays
            --   loop     = true for continuous effects, false for one-shot
            Effects = {
                { name = 'TinyRacerGreen', out = 'TinyRacerGreenOut', duration = 1500, loop = true },
            },
        },
    },

    indica = {
        Timecycle = 'spectator7',
        TimecycleStrength = 1.0,
        TimecycleStartAt = 10,
        TimecycleFullAt = 60,                       
        CameraShakeType = 'FAMILY5_DRUG_TRIP_SHAKE', 
        CameraShakeStrength = 0.1,                   
        CameraShakeStartAt = 30,                     
        MotionBlurStartAt = 50,                      
        HungerMultiplier = 0.8,                      
        ThirstMultiplier = 1.3,                      

        ScreenEffects = {
            Enabled = true,
            MinHighness = 70,                              
            WhenLowHigh  = { Min = 25000, Max = 40000 },   
            WhenPeakHigh = { Min = 8000,  Max = 15000 },   
            Effects = {
                { name = 'TinyRacerPink', out = 'TinyRacerPinkOut', duration = 1500, loop = true },
            },
        },
    },

    hybrid = {
        Timecycle = 'NG_filmic23',
        TimecycleStrength = 1.0,
        TimecycleStartAt = 10,
        TimecycleFullAt = 70,                       
        CameraShakeType = 'FAMILY5_DRUG_TRIP_SHAKE', 
        CameraShakeStrength = 0.1,                   
        CameraShakeStartAt = 30,                    
        MotionBlurStartAt = 50,                  
        HungerMultiplier = 0.8,                      
        ThirstMultiplier = 1.3,                     
        ScreenEffects = {
            Enabled = true,
            MinHighness = 60,                             
            WhenLowHigh  = { Min = 25000, Max = 40000 },  
            WhenPeakHigh = { Min = 8000,  Max = 15000 },   
            Effects = {
                { name = 'PPPurple', out = 'PPPurpleOut', duration = 1500, loop = false },
            },
        },
    },
}

-- =====================================================================
-- INHALE OVERLOAD EFFECT
-- =====================================================================
Config.InhaleOverload = {
    Enabled = true,
    Effect = 'CarDamageHit',     -- The AnimPostFX effect name to use for the pulse.
    TriggerAtPercent = 0.75,     -- Starts when the inhale bar is this full (0-1). 0.75 = 75% = the red zone.
    ReplayIntervalMs = 400,      -- How often (ms) the pulse replays while in the red zone. Lower = faster pulses.
    TrailOnReleaseMs = 300,      -- How long (ms) the pulse keeps going after release, if the player did NOT cough.
    TrailOnCoughMs   = 3000,     -- How long (ms) the pulse keeps going after release if a cough fires. Longer = coughs feel rougher.
}

-- =====================================================================
-- VIDEO OVERLAYS
-- Videos layered over the screen while high.
-- One for "any high" (regardless of strain type) and one per strain
-- type for more specific visual flavor.
-- All shared settings:
--   File              = path to .webm/.mp4 inside ui/overlays/
--   HasAlpha          = true if the video has transparency already baked in
--   BlendMode         = how it blends with the screen. 'screen' brightens, 'multiply' darkens.
--   MaxOpacity        = strongest the overlay gets (0.0 = invisible, 1.0 = solid)
--   FadeInMs/FadeOutMs = how long the overlay takes to fade in/out
--   HighnessThreshold = (base only) minimum highness before the overlay shows
-- =====================================================================
Config.VideoOverlays = {
    Enabled = true,
    -- Highness: the base overlay that plays once the player is high enough, regardless of strain type.
    OverlayFade  = 20, 
    Highness = {
        Enabled = true,
        File = 'overlays/smoke1.webm', -- dc_smoking\ui\overlays
        HasAlpha = false, 
        BlendMode = 'screen',
        MaxOpacity = 0.20,
        HighnessThreshold = 20,
        FadeInMs = 3000,
        FadeOutMs = 4000,
    },
    -- StrainType: per-type overlays that layer on top of the Highness one.
    -- File = '' means no extra overlay for that type (empty on purpose).
    StrainType = {
        sativa = {
            File = 'overlays/effect1.webm',
            HasAlpha = false,
            BlendMode = 'screen',
            MaxOpacity = 0.06,
            HighnessThreshold = 20,
            FadeInMs = 10000,
            FadeOutMs = 8000,
        },
        indica = {
            File = 'overlays/effect1.webm',
            HasAlpha = false,
            BlendMode = 'screen',
            MaxOpacity = 0.06,
            HighnessThreshold = 20,
            FadeInMs = 10000,
            FadeOutMs = 8000,
        },
        hybrid = {
            File = 'overlays/effect1.webm',
            HasAlpha = false,
            BlendMode = 'screen',
            MaxOpacity = 0.06,
            HighnessThreshold = 20,
            FadeInMs = 10000,
            FadeOutMs = 8000,
        },
    },
}

-- =====================================================================
-- COUGH
-- =====================================================================
Config.Cough = {
    ExhaleCooldown = 3500,   -- After ANY exhale (not just coughs), the player can't inhale again for this many ms. Prevents spam-hitting.
    -- The cough animation played on the player.
    Animation = {
        Dict     = "timetable@gardener@smoking_joint",   -- Which animation dictionary to load.
        Anim     = "idle_cough",                         -- The specific clip to play.
        Duration = 3000,                                 -- How long (ms) the cough animation runs.
        Flag     = 49,                                   -- Animation flag. 49 = upper body + loop.
        BlendIn  = 2.0,                                  -- Fade-in speed (higher = snappier start).
        BlendOut = -2.0,                                 -- Fade-out speed (negative = smooth).
    },
    -- Small camera shake that fires while coughing.
    ScreenShake = {
        Enabled = true,                         -- false = disable the shake (cough animation still plays).
        ShakeType = "SMALL_EXPLOSION_SHAKE",    -- Which shake preset. Good options: SMALL_EXPLOSION_SHAKE, HAND_SHAKE, DRUNK_SHAKE.
        Intensity = 1.0,                        -- 0.0 = barely visible, 1.0 = strong.
        DelayMs = 500,                          -- ms delay after the cough starts before the shake begins.
        DurationMs = 1500,                      -- How long (ms) the shake lasts.
    },
}

-- =====================================================================
-- SECONDHAND SMOKE
-- =====================================================================
Config.SecondhandSmoke = {
    Enabled = true,
    Radius = 3.0,                  -- How close (meters) the smoker has to be for passive highness to transfer.
    HighnessGainFraction = 0.45,   -- Fraction of the smoker's hit that passes to each nearby player. 0.45 = 45%.
    CheckInterval = 5000,          -- How often (ms) the script checks for nearby smokers. Lower = more responsive but heavier.
    VehicleMultiplier = 2.0,       -- Multiplier applied to range AND strength when both players are in the same vehicle. Cars trap smoke.
    MaxPassiveHighness = 15,       -- Ceiling on total highness someone can get from passive smoke alone. Keeps passive from maxing anyone out.

    -- Subtle screen flash when you catch a whiff of someone else's smoke.
    VisualEffect = {
        Enabled = true,
        Effect = 'BikerFormation',   -- AnimPostFX effect name.
        Out = 'BikerFormationOut',   -- Matching fade-out effect.
        DurationMs = 1200,           -- How long (ms) the flash lasts.
        MinAmount = 1.0,             -- Skip the flash if the passive hit is smaller than this (avoids flashing on tiny whiffs).
        CooldownMs = 15000,          -- Minimum time (ms) between visual flashes, so you don't get spammed with flashes in a smoky room.
    },
}

-- =====================================================================
-- AUDIO EFFECTS
-- Muffled/warped audio filter while high enough.
-- =====================================================================
Config.AudioEffects = {
    Enabled = true,
    HighnessThreshold = 30,   -- Highness (0-100) required before the audio effect kicks in.
}