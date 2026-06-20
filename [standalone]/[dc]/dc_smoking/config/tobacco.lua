-- =====================================================================
-- TOBACCO
-- Cigarettes and cigars. Most fields behave exactly like joints/blunts.
-- Cigar-specific mechanics (clipping, freaking, cigar-only animations)
-- live in CigarDefaults below — they automatically apply to any item
-- that sets Type = 'cigar' in its ItemGroups block.
-- =====================================================================
Config.Tobacco = {
    -- Default values used by cigarettes (not cigars — cigars override these via CigarDefaults).
    DefaultLitTime = { Min = 30000, Max = 50000 },   -- How long (ms) a cigarette stays lit. Random between Min and Max. Cigarettes burn faster than joints.
    MinInhaleTime = 1000,                            -- Shortest (ms) an inhale can count. Shorter presses don't register.
    MaxInhaleTime = 4000,                            -- Longest (ms) an inhale can be held before auto-release.

    -- Animations for each part of the cigarette flow.
    -- Each animation uses: Dict, Anim, Duration, Flag, BlendIn, BlendOut (see config/vapes.lua for a full explanation).
    Animations = {
        GrabItem    = { Dict = "dc@pack", Anim = "packgrab_c", Duration = 1500, AttachPropAt = 800, Flag = 0 },                        -- Pulling the cig out of a pack.
        Idle        = { Dict = "dc@handsmoke", Anim = "handsmokehold_c", Flag = 49,      BlendIn = 2.0, BlendOut = -1.0 },             -- Holding it at their side between hits.
        Lighting      = { Dict = "dc@lhs", Anim = "lhs_c", Duration = 13000, BlendIn = 2.0, BlendOut = -1.0 },                          -- Lighting while holding it in hand.
        LightingMouth = { Dict = "dc@lhs", Anim = "lms_c", Duration = 8500, BlendIn = 2.0, BlendOut = -1.0 },                          -- Lighting while it's in the mouth.
        Smoking     = { Dict = "dc@handsmoke", Anim = "handsmoke_c", Flag = 49,      BlendIn = 2.0, BlendOut = -1.0 },                 -- Taking a hit.
        Ashing      = { Dict = "dc@handsmoke", Anim = "handsmokeash_c", Duration = 2200, Flag = 49, BlendIn = 2.0, BlendOut = -1.0 },  -- Tapping ash off.
        ToFromMouth = { Dict = "dc@handsmoke", Anim = "handsmokemouth_c", Duration = 1000, AttachAt = 900, BlendIn = 2.0, BlendOut = -2.0 } -- Moving between hand and mouth. AttachAt = when in the anim (ms) to reattach the prop.
    },
    Sounds = {
        Lighting = { File = "lighterflick.ogg", Volume = 0.2 },                  -- Lighter flick sound.
        Inhale   = { File = "smokecrackle.ogg", Volume = 0.06, Loop = true },     -- Quiet crackle while burning.
        Cough = { Volume = 0.2, Delay = 700 }, -- Change sound name in config.lua
        Exhale   = { File = "exhale.ogg", Volume = 0.06 },                        -- Exhale sound (slightly louder than joints).
    },
    CoughChance = { Base = 0.15, Max = 0.35 },   -- Chance of coughing. Base = normal hit, Max = holding into the red zone.
    Facials = {
        Inhale     = "mood_Smug_1",
        Exhale     = "mood_Stressed_1",
        ExhaleDuration = 2500,
    },
    -- Exhale smoke cloud. Field meanings identical to vapes (see config/vapes.lua).
    ExhaleParticle = {
        Dict = "core",
        Name = "exp_grd_bzgas_smoke",
        Bone = 47495,
        Offset = vector3(0.078, 0.003, -0.000),
        Rotation = vector3(0.0, 0.0, 0.0),
        MinScale = 0.05,
        MaxScale = 0.3,
        MaxHoldTime = 4000,
        Duration = 2000,
    },
    -- LightSequence: precise timing of each step in the lighting animation (for cigarettes — cigars override this).
    -- Each "At" value is ms into the Lighting animation when that step fires.
    LightSequence = {
        ItemToMouthAt = 1000,                                 -- ms when the cigarette moves to the mouth.
        AttachLighterAt = 3200,                               -- ms when the lighter appears in hand.
        LighterSoundAt = 2300,                                -- ms when the flick sound plays.
        FlameAt = 2500,                                       -- ms when the flame particle starts.
        LitModelAt = 5000,                                    -- ms when the unlit cig swaps to the lit version.
        FlameOffAt = 8500,                                    -- ms when the flame stops.
        DeleteLighterAt = 8500,                               -- ms when the lighter disappears.
        ItemToHandAt = 11700,                                 -- ms when the lit cig moves from mouth back to hand.
    },
    -- LightSequenceMouth: overrides for when the player is lighting the cigarette while it's already in their mouth (uses the shorter lms_c anim).
    -- Only define fields that differ from LightSequence; anything omitted falls back to the values above.
    -- ItemToMouthAt is skipped automatically when lighting from mouth, so no need to define it here.
    -- Note: cigars have their own lighting flow and do NOT use this (see CigarDefaults below).
    -- Note: ItemToHandAt is intentionally omitted — when lighting from mouth, the cigarette stays in the mouth until the player presses the ToMouth key (H) to bring it back to hand.
    LightSequenceMouth = {
        LighterSoundAt = 1500,                                -- ms when the flick sound plays.
        AttachLighterAt = 1330,                               -- ms when the lighter appears in hand.
        FlameAt = 2400,                                       -- ms when the flame particle starts.
        LitModelAt = 4230,                                    -- ms when the unlit cig swaps to the lit version.
        FlameOffAt = 5540,                                    -- ms when the flame stops.
        DeleteLighterAt = 7200,                               -- ms when the lighter disappears.
    },

    -- -----------------------------------------------------------------
    -- CigarDefaults: default settings for any item marked Type = 'cigar'
    -- below. Cigars burn slower, make bigger clouds, have higher cough
    -- chance, and can be clipped before lighting. Items with Type = 'cigar'
    -- inherit these values unless they override them in their own block.
    -- -----------------------------------------------------------------
    CigarDefaults = {
        DefaultLitTime = { Min = 60000, Max = 120000 },   -- Cigars stay lit much longer than cigarettes (60-120 seconds).

        -- Cigar-specific animations (uses the dc@cigar* dictionaries).
        Animations = {
            GrabItem    = { Dict = "dc@pack", Anim = "packgrab_c", Duration = 1500, AttachPropAt = 800, Flag = 0 },                              -- Pulling the cigar out.
            Idle          = { Dict = "dc@cigarsmoke", Anim = "cigarsmokehold_c", Flag = 49, BlendIn = 2.0, BlendOut = -1.0 },                    -- Holding the cigar between hits.
            Lighting      = { Dict = "dc@cigarlight100", Anim = "cigarlight100_c", Duration = 12000, BlendIn = 2.0, BlendOut = -1.0 },           -- Lighting while in hand (slow, deliberate).
            LightingMouth = { Dict = "dc@cigarlight100", Anim = "cigarlightmouth_c", Duration = 8660, BlendIn = 2.0, BlendOut = -1.0 },         -- Lighting while in mouth.
            Smoking       = { Dict = "dc@cigarsmoke", Anim = "cigarsmoke_c", Flag = 49, BlendIn = 2.0, BlendOut = -1.0 },                        -- Taking a puff.
            Ashing        = { Dict = "dc@cigarsmoke", Anim = "cigarsmokeash_c", Duration = 2200, Flag = 49, BlendIn = 2.0, BlendOut = -1.0 },    -- Tapping ash off.
            ToFromMouth   = { Dict = "dc@cigarsmoke", Anim = "cigarsmokemouth_c", Duration = 2500, BlendIn = 2.0, BlendOut = -2.0, AttachAt = 1200 }, -- Moving between hand and mouth.
        },

        Sounds = {
            Lighting = { File = "lighterflick.ogg", Volume = 0.2, Delay = 5000 },   -- Delay = ms before the flick sound plays (matches the slower cigar lighting anim).
            Inhale   = { File = "smokecrackle.ogg", Volume = 0.06, Loop = true },    -- Crackle while puffing.
            Cough = { Volume = 0.2, Delay = 700 }, -- Change sound name in config.lua
            Exhale   = { File = "exhale.ogg", Volume = 0.06 },                       -- Exhale sound.
        },
        CoughChance = { Base = 0.35, Max = 0.50 },   -- Cigars hit harder than cigarettes so cough chance is much higher.

        Facials = {
            Inhale     = "mood_Smug_1",
            Exhale     = "mood_Stressed_1",
            ExhaleDuration = 2500,
        },
        -- Cigar exhale cloud — bigger and longer than the default tobacco cloud.
        ExhaleParticle = {
            Dict = "core",
            Name = "exp_grd_bzgas_smoke",
            Bone = 47495,
            Offset = vector3(0.078, 0.003, 0.0),
            Rotation = vector3(0.0, 0.0, 0.0),
            MinScale = 0.05,
            MaxScale = 0.4,                 -- Bigger max cloud than cigarettes (0.7).
            MaxHoldTime = 4000,
            Duration = 2500,                -- Lingers slightly longer than cigarette exhale.
        },

        -- Default cigar lighting sequence timing. Individual cigar items can override this in their own block.
        LightSequence = {
            ItemToMouthAt = 1000,                                 -- ms when the cigar moves to the mouth.
            AttachLighterAt = 3200,                               -- ms when the lighter appears in hand.
            LighterSoundAt = 2300,                                -- ms when the flick sound plays.
            FlameAt = 2500,                                       -- ms when the flame particle starts.
            LitModelAt = 5000,                                    -- ms when the unlit cigar swaps to the lit version.
            FlameOffAt = 8500,                                    -- ms when the flame stops.
            DeleteLighterAt = 8500,                               -- ms when the lighter disappears.
            ItemToHandAt = 11700,                                 -- ms when the lit cigar moves from mouth back to hand.
        },
        -- ClipSequence: cigars must be clipped before they can be lit.
        -- Triggered by the ClipCigar key (see Config.Keys in config.lua).
        ClipSequence = {
            RequireClip = true,                                -- false = cigars can be lit without clipping first.
            ClipperItem = "dc_cigarclipper",                   -- Required inventory item to perform the clip.
            ClipperProp = "dc_cigarcutter",                    -- 3D model that appears during the clip animation.
            ClipperBone = 26610,                               -- Bone to attach the clipper to (26610 = left hand).
            ClipperOffset = vector3(0.117, -0.026, -0.029),    -- Fine-tune clipper position in hand.
            ClipperRotation = vector3(56.5, -67.3, 101.8),     -- Clipper rotation in degrees.
            -- Animation played during the clip.
            Animation = {
                Dict = "dc@cigarclip",
                Anim = "cigarclip_c",
                Duration = 4000,
                Flag = 49,
                BlendIn = 2.0,
                BlendOut = -2.0,
            },
            AttachClipperAt = 500,       -- ms into the anim when the clipper appears.
            DeleteClipperAt = 4300,      -- ms into the anim when the clipper disappears.
            Label = "Clipping the cigar...",   -- Text shown in the progress bar while clipping.
        },
    },
    ItemGroups = {
        {
            ItemInfo = {
                { Name = 'dc_bluecig', Label = 'Menthol Blue Cigarette' },
                { Name = 'dc_goldcig', Label = 'Gold Cigarette' },
                { Name = 'dc_greencig', Label = 'Menthol Green Cigarette' },
                { Name = 'dc_redcig', Label = 'Red Cigarette' },
                { Name = 'dc_silvercig', Label = 'Silver Cigarette' },
            },
            --MinInhaleTime = 1000,                            -- Shortest (ms) an inhale can count. Shorter presses don't register.
            --MaxInhaleTime = 5000,                            -- Longest (ms) an inhale can count. Longer presses are capped.
            Bone = 58866,
            MouthBone = 47495,
            FreshModel = {
                Model = "dc_cig100",
                Offset = vector3(0.109,-0.055,-0.004),
                Rotation = vector3(31.6,18.9,-7.3),
                MouthOffset = vector3(0.081,-0.001,0.000),
                MouthRotation = vector3(15.9,10.6,91.1),
            },
            PropStages = {
                Unlit = {
                    {
                        Percent = 100, Model = "dc_cig100unlit",
                        Offset = vector3(0.109,-0.055,-0.004),
                        Rotation = vector3(31.6,18.9,-7.3),
                        MouthOffset = vector3(0.081,-0.001,0.000),
                        MouthRotation = vector3(15.9,10.6,91.1),
                    },
                    {
                        Percent = 50, Model = "dc_cig50unlit",
                        Offset = vector3(0.114,-0.041,0.004),
                        Rotation = vector3(31.6,18.9,-7.3),
                        MouthOffset = vector3(0.066,-0.001,0.005),
                        MouthRotation = vector3(15.9,10.6,91.1),
                    },
                    { 
                        Percent = 25, Model = "dc_cig25unlit",
                        Offset = vector3(0.114,-0.040,0.005),
                        Rotation = vector3(31.6,18.9,-7.3),
                        MouthOffset = vector3(0.059,-0.000,0.007),
                        MouthRotation = vector3(15.9,10.6,91.1),
                    },
                },
                Lit = {
                    {
                        Percent = 100, Model = "dc_cig100lit",
                        Offset = vector3(0.109,-0.055,-0.004),
                        Rotation = vector3(31.6,18.9,-7.3),
                        MouthOffset = vector3(0.081,-0.001,0.000),
                        MouthRotation = vector3(15.9,10.6,91.1),
                        Particle = { dict = "core", name = "exp_grd_bzgas_smoke", scale = 0.04, offset = vector3(0.0000, -0.0320, 0.0000), rot = vector3(0.0000, -0.0000, 0.0000) },
                    },
                    {
                        Percent = 50, Model = "dc_cig50lit",
                        Offset = vector3(0.114,-0.041,0.004),
                        Rotation = vector3(31.6,18.9,-7.3),
                        MouthOffset = vector3(0.066,-0.001,0.005),
                        MouthRotation = vector3(15.9,10.6,91.1),
                        Particle = { dict = "core", name = "exp_grd_bzgas_smoke", scale = 0.03, offset = vector3(0.0000, -0.0217, 0.0000), rot = vector3(0.0000, -0.0000, 0.0000) },
                    },
                    {
                        Percent = 25, Model = "dc_cig25lit",
                        Offset = vector3(0.114,-0.040,0.005),
                        Rotation = vector3(31.6,18.9,-7.3),
                        MouthOffset = vector3(0.059,-0.000,0.007),
                        MouthRotation = vector3(15.9,10.6,91.1),
                        Particle = { dict = "core", name = "exp_grd_bzgas_smoke", scale = 0.02, offset = vector3(0.0000, -0.0138, 0.0000), rot = vector3(0.0000, -0.0000, 0.0000) },
                    },
                }
            },
            Stats = { Stress = 20, Armor = 0, High = 0 },
            DegradePerSecond = 3.0,
            LightSequence = {
                MoveToMouth = true,
                LighterBone = 57005,
                LighterOffset = vector3(0.112, -0.004, -0.041),
                LighterRotation = vector3(-93.8, -19.7, -22.9),
                ItemToMouthAt = 1000,
                AttachLighterAt = 3200,
                LighterSoundAt = 2300,
                FlameAt = 4700,
                LitModelAt = 5300,
                FlameOffAt = 7760,
                DeleteLighterAt = 8500,
                ItemToHandAt = 11700,
            },
            Sounds = {
                Lighting = { File = "lighterflick.ogg", Volume = 0.2, Delay = 2000 },
                Inhale   = { File = "smokecrackle.ogg", Volume = 0.06, Loop = true },
                Cough = { Volume = 0.2, Delay = 700 }, -- Change sound name in config.lua
                Exhale   = { File = "exhale.ogg", Volume = 0.06 },
            },
        },

        {
            ItemInfo = {
                { Name = 'dc_smacknwild', Label = 'SmacknWild Cigar' },
            },
            Bone = 58866,
            MouthBone = 47495,
            FreshModel = {
                Model = "dc_black100",
                Offset = vector3(0.106, -0.066, -0.016),
                Rotation = vector3(39.8, 24.9, 1.4),
                MouthOffset = vector3(0.101, 0.003, 0.002),
                MouthRotation = vector3(7.6, 4.2, 96.9),
            },
            PropStages = {
                Unlit = {
                    {
                        Percent = 100, Model = "dc_black100unlit",
                        Offset = vector3(0.109, -0.058, -0.010),
                        Rotation = vector3(39.8, 24.9, 1.4),
                        MouthOffset = vector3(0.094, 0.002, 0.003),
                        MouthRotation = vector3(7.6, 4.2, 96.9),
                    },
                    {
                        Percent = 50, Model = "dc_black50unlit",
                        Offset = vector3(0.111, -0.050, -0.005),
                        Rotation = vector3(39.8, 24.9, 1.4),
                        MouthOffset = vector3(0.077, 0.000, 0.005),
                        MouthRotation = vector3(7.6, 4.2, 96.9),
                    },
                    {
                        Percent = 25, Model = "dc_black25unlit",
                        Offset = vector3(0.115, -0.038, 0.005),
                        Rotation = vector3(39.8, 24.9, 1.4),
                        MouthOffset = vector3(0.061, -0.002, 0.007),
                        MouthRotation = vector3(7.6, 4.2, 96.9),
                    },
                },
                Lit = {
                    {
                        Percent = 100, Model = "dc_black100lit",
                        Offset = vector3(0.109, -0.058, -0.010),
                        Rotation = vector3(39.8, 24.9, 1.4),
                        MouthOffset = vector3(0.094, 0.002, 0.003),
                        MouthRotation = vector3(7.6, 4.2, 96.9),
                        Particle = { dict = "core", name = "exp_grd_bzgas_smoke", scale = 0.04, offset = vector3(0.0000, -0.0609, 0.0000), rot = vector3(0.0000, -0.0000, 0.0000) },
                    },
                    {
                        Percent = 50, Model = "dc_black50lit",
                        Offset = vector3(0.111, -0.050, -0.005),
                        Rotation = vector3(39.8, 24.9, 1.4),
                        MouthOffset = vector3(0.077, 0.000, 0.005),
                        MouthRotation = vector3(7.6, 4.2, 96.9),
                        Particle = { dict = "core", name = "exp_grd_bzgas_smoke", scale = 0.03, offset = vector3(0.0000, -0.0427, 0.0000), rot = vector3(0.0000, -0.0000, 0.0000) },
                    },
                    {
                        Percent = 25, Model = "dc_black25lit",
                        Offset = vector3(0.115, -0.038, 0.005),
                        Rotation = vector3(39.8, 24.9, 1.4),
                        MouthOffset = vector3(0.061, -0.002, 0.007),
                        MouthRotation = vector3(7.6, 4.2, 96.9),
                        Particle = { dict = "core", name = "exp_grd_bzgas_smoke", scale = 0.02, offset = vector3(0.0000, -0.0264, 0.0000), rot = vector3(0.0000, -0.0000, 0.0000) },
                    },
                }
            },
            Stats = { Stress = 20, Armor = 0, High = 0 },
            DegradePerSecond = 3.0,
            Freakable = true,
            FreakAnimation = {
                Dict = "dc@freakblack",
                Anim = "freakblack_c",
                Duration = 14300,
                Label = "Removing the cancer paper...",
                -- ItemSequence: moves the cigar to different bones/offsets at specific points in the anim.
                -- "At" = ms into the anim when that pose takes over.
                ItemSequence = {
                    {
                        At = 0,
                        Bone = 58866,
                        Offset = vector3(0.103, -0.067, -0.017),
                        Rotation = vector3(62.8, 53.8, 36.3),
                    },
                    {
                        At = 1150,
                        Bone = 18905,
                        Offset = vector3(0.117, 0.005, 0.022),
                        Rotation = vector3(-22.5, 77.8, -19.3),
                    },
                    {
                        At = 10490,
                        Bone = 58866,
                        Offset = vector3(0.103, -0.067, -0.017),
                        Rotation = vector3(62.8, 53.8, 36.3),
                    },
                },
                -- CancerPaper: the paper prop that appears in hand near the end of the freak anim (what the player is pulling out).
                CancerPaper = {
                    Prop = "dc_cancerpaper",
                    AttachAt = 12656,                               -- ms into the freak anim when the paper appears.
                    DeleteAt = 14000,                               -- ms into the anim when it disappears.
                    Bone = 26610,
                    Offset = vector3(0.125, -0.029, -0.004),
                    Rotation = vector3(-24.5, -80.5, 133.0),
                },
            },
            -- FreakedModifiers: stat changes applied after a successful freak.
            FreakedModifiers = {
                DegradePerSecond = 3.5,       
                HarshnessReduction = 0.15,      -- Makes hits smoother (0-1 scale).
                CoughChanceReduction = 0.20,    -- Reduces cough chance by this amount.
                StressBonus = 5,                -- Extra stress reduction per hit after freaking.
            },
            FreakedFlavorNote = "Smooth hit — no cancer paper.",   -- Text shown to the player after they take a hit on a freaked cigar.
            LightSequence = {
                MoveToMouth = true,
                LighterBone = 57005,
                LighterOffset = vector3(0.112, -0.004, -0.041),
                LighterRotation = vector3(-93.8, -19.7, -22.9),
                ItemToMouthAt = 1000,
                AttachLighterAt = 3200,
                LighterSoundAt = 2300,
                FlameAt = 4700,
                LitModelAt = 5000,
                FlameOffAt = 7760,
                DeleteLighterAt = 8500,
                ItemToHandAt = 11700,
            },
            Sounds = {
                Lighting = { File = "lighterflick.ogg", Volume = 0.2, Delay = 2000 },
                Inhale   = { File = "smokecrackle.ogg", Volume = 0.06, Loop = true },
                Cough = { Volume = 0.2, Delay = 700 }, -- Change sound name in config.lua
                Exhale   = { File = "exhale.ogg", Volume = 0.06 },
            },
        },

        {
            ItemInfo = {
                { Name = 'dc_cigar', Label = 'Cuban Cigar' },
            },
            Type = 'cigar',   -- Marks this item as a cigar, which makes it inherit CigarDefaults above (slower burn, clip support, etc.).
            Bone = 58866,
            MouthBone = 47495,
            FreshModel = {
                Model = "dc_cigar100",
                Offset = vector3(0.098, -0.050, 0.025),
                Rotation = vector3(10.5, 0.7, -4.0),
                MouthOffset = vector3(0.098, -0.011, 0.008),
                MouthRotation = vector3(1.7, -10.4, 80.4),
            },
            PropStages = {
                Unlit = {
                    {
                        Percent = 100, Model = "dc_cigar100unlit",
                        Offset = vector3(0.098, -0.050, 0.025),
                        Rotation = vector3(10.5, 0.7, -4.0),
                        MouthOffset = vector3(0.098, -0.011, 0.008),
                        MouthRotation = vector3(1.7, -10.4, 80.4),
                    },
                    {
                        Percent = 50, Model = "dc_cigar50unlit",
                        Offset = vector3(0.098, -0.047, 0.025),
                        Rotation = vector3(10.5, 0.7, -4.0),
                        MouthOffset = vector3(0.085, -0.009, 0.008),
                        MouthRotation = vector3(1.7, -10.4, 80.4),
                    },
                    {
                        Percent = 25, Model = "dc_cigar25unlit",
                        Offset = vector3(0.099, -0.029, 0.027),
                        Rotation = vector3(10.5, 0.7, -4.0),
                        MouthOffset = vector3(0.070, -0.007, 0.009),
                        MouthRotation = vector3(1.7, -10.4, 80.4),
                    },
                },
                Lit = {
                    {
                        Percent = 100, Model = "dc_cigar100lit",
                        Offset = vector3(0.098, -0.050, 0.025),
                        Rotation = vector3(10.5, 0.7, -4.0),
                        MouthOffset = vector3(0.098, -0.011, 0.008),
                        MouthRotation = vector3(1.7, -10.4, 80.4),
                        Particle = { dict = "core", name = "exp_grd_bzgas_smoke", scale = 0.05, offset = vector3(0.0000, -0.0765, 0.0000), rot = vector3(0.0000, -0.0000, 0.0000) },
                    },
                    {
                        Percent = 50, Model = "dc_cigar50lit",
                        Offset = vector3(0.098, -0.047, 0.025),
                        Rotation = vector3(10.5, 0.7, -4.0),
                        MouthOffset = vector3(0.085, -0.009, 0.008),
                        MouthRotation = vector3(1.7, -10.4, 80.4),
                        Particle = { dict = "core", name = "exp_grd_bzgas_smoke", scale = 0.05, offset = vector3(0.0000, -0.0591, 0.0000), rot = vector3(0.0000, -0.0000, 0.0000) },
                    },
                    {
                        Percent = 25, Model = "dc_cigar25lit",
                        Offset = vector3(0.099, -0.029, 0.027),
                        Rotation = vector3(10.5, 0.7, -4.0),
                        MouthOffset = vector3(0.070, -0.007, 0.009),
                        MouthRotation = vector3(1.7, -10.4, 80.4),
                        Particle = { dict = "core", name = "exp_grd_bzgas_smoke", scale = 0.05, offset = vector3(0.0000, -0.0431, 0.0000), rot = vector3(0.0000, -0.0000, 0.0000) },
                    },
                },
            },
            Stats = { Stress = 35, Armor = 0, High = 0 },
            DegradePerSecond = 3.0,
            LightSequence = {
                MoveToMouth = false,
                LighterBone = 26610,
                LighterOffset = vector3(0.079, -0.040, -0.004),
                LighterRotation = vector3(-155.0, 63.0, -114.5),
                AttachLighterAt = 1650,
                LighterSoundAt = 3220,
                FlameAt = 3265,
                LitModelAt = 8650,
                FlameOffAt = 9312,
                DeleteLighterAt = 10668,
            },
            Sounds = {
                Lighting = { File = "lighterflick.ogg", Volume = 0.2, Delay = 100 },
                Inhale   = { File = "smokecrackle.ogg", Volume = 0.06, Loop = true },
                Cough = { Volume = 0.2, Delay = 700 }, -- Change sound name in config.lua
                Exhale   = { File = "exhale.ogg", Volume = 0.06 },
            },
        },
    },
    Items = {} -- Don't Touch (auto-filled from ItemGroups)
}
ExpandItemGroups(Config.Tobacco)