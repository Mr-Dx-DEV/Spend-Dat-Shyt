Config.Joints = {
    DefaultLitTime = { Min = 45000, Max = 90000 },   -- How long (ms) a joint stays lit after lighting. Random between Min and Max. 45000 = 45 seconds.
    MinInhaleTime = 1000,                            -- Shortest (ms) an inhale can count. Presses shorter than this don't register as a hit.
    MaxInhaleTime = 4000,                            -- Longest (ms) an inhale can be held before auto-release.

    -- Animations for each part of the joint flow.
    -- Dict/Anim/Duration/Flag/BlendIn/BlendOut mean the same thing they do on vapes.
    Animations = {
        GrabItem    = { Dict = "dc@pack", Anim = "packgrab_c", Duration = 1500, AttachPropAt = 800, Flag = 0 },                        -- Pulling the joint out of a pack/pocket.
        Idle        = { Dict = "dc@handsmoke", Anim = "handsmokehold_c", Flag = 49,      BlendIn = 2.0, BlendOut = -1.0 },             -- Holding the joint at their side between hits.
        Lighting      = { Dict = "dc@lhs", Anim = "lhs_c", Duration = 13000, BlendIn = 2.0, BlendOut = -1.0 },                          -- Lighting the joint while holding it in hand.
        LightingMouth = { Dict = "dc@lhs", Anim = "lms_c", Duration = 8500, BlendIn = 2.0, BlendOut = -1.0 },                          -- Lighting the joint while it's in the player's mouth.
        Smoking     = { Dict = "dc@handsmoke", Anim = "handsmoke_c", Flag = 49,      BlendIn = 2.0, BlendOut = -1.0 },                 -- Taking a hit.
        Ashing      = { Dict = "dc@handsmoke", Anim = "handsmokeash_c", Duration = 2200, Flag = 49, BlendIn = 2.0, BlendOut = -1.0 },  -- Tapping ash off.
        ToFromMouth = { Dict = "dc@handsmoke", Anim = "handsmokemouth_c", Duration = 1000, AttachAt = 900, BlendIn = 2.0, BlendOut = -2.0 } -- Moving between hand and mouth. AttachAt = when in the anim (ms) to reattach the prop to the new location.
    },
    Sounds = {
        Lighting = { File = "lighterflick.ogg", Volume = 0.2, Delay = 2000 },                  -- Lighter flick sound.
        Inhale   = { File = "smokecrackle.ogg", Volume = 0.06, Loop = true },     -- Quiet crackle of the joint burning while inhaling.
        Cough = { Volume = 0.2, Delay = 700 }, -- Change sound name in config.lua
        Exhale   = { File = "exhale.ogg", Volume = 0.06 },                        -- Exhale sound.
    },
    CoughChance = { Base = 0.15, Max = 0.35 },   -- Joints are smooth — lowest cough chance of the weed items.
    Facials = {
        Inhale     = "mood_Smug_1",
        Exhale     = "mood_Stressed_1",
        ExhaleDuration = 2500,
    },
    -- Exhale cloud. Same fields as vapes.
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
    -- LightSequence: the precise timing of the multi-step lighting animation.
    -- Each "At" value is ms into the Lighting animation when that step fires.
    -- The gaps between these values control how the sequence looks; keep them spread out or steps will overlap visually.
    LightSequence = {
        MoveToMouth = true,                                   -- If true, the joint auto-moves to the mouth as part of lighting.
        LighterBone = 57005,                                  -- Which bone to attach the lighter to (57005 = right hand).
        LighterOffset = vector3(0.112,-0.004,-0.041),         -- Fine-tune lighter position on the bone.
        LighterRotation = vector3(-93.8,-19.7,-22.9),         -- Lighter rotation in degrees.
        ItemToMouthAt = 1000,                                 -- ms into the anim when the joint moves to the mouth.
        AttachLighterAt = 3200,                               -- When the lighter appears in the hand.
        LighterSoundAt = 2300,                                -- When the flick sound plays.
        FlameAt = 4700,                                       -- When the flame particle starts.
        LitModelAt = 5500,                                    -- When the unlit joint swaps to the lit version (embers visible).
        FlameOffAt = 7760,                                    -- When the flame stops.
        DeleteLighterAt = 8500,                               -- When the lighter disappears.
        ItemToHandAt = 11700,                                 -- When the lit joint moves from mouth back to hand.
    },
    -- LightSequenceMouth: overrides for when the player is lighting the joint while it's already in their mouth (uses the shorter lms_c anim).
    -- Only define fields that differ from LightSequence; anything omitted falls back to the values above.
    -- ItemToMouthAt is skipped automatically when lighting from mouth, so no need to define it here.
    -- Note: ItemToHandAt is intentionally omitted — when lighting from mouth, the joint stays in the mouth until the player presses the ToMouth key (H) to bring it back to hand.
    LightSequenceMouth = {
        LighterSoundAt = 1500,                                -- ms when the flick sound plays.
        AttachLighterAt = 1330,                               -- ms when the lighter appears in hand.
        FlameAt = 2400,                                       -- ms when the flame particle starts.
        LitModelAt = 4230,                                    -- ms when the unlit joint swaps to the lit version.
        FlameOffAt = 5540,                                    -- ms when the flame stops.
        DeleteLighterAt = 7200,                               -- ms when the lighter disappears.
    },
    -- ItemGroups: share settings across joint variants.
    ItemGroups = {
        {
            ItemInfo = {
                { Name = 'rolled_joint', Label = 'Rolled Joint' }, -- 1 item, strain will be determined dynamically as metadata
            },
            LitTime = { Min = 50000, Max = 100000 },           -- Overrides DefaultLitTime for this group. Longer = joint lasts longer before burning out.
            Bone = 58866,                                      -- Which bone the joint attaches to in hand (fingertip).
            MouthBone = 47495,                                 -- Which bone the joint attaches to when in the mouth.
            -- FreshModel: the prop used briefly when the joint is first pulled out (before it's categorized as unlit/lit).
            FreshModel = {
                Model = "dc_joint100",
                Offset = vector3(0.105,-0.065,-0.019),
                Rotation = vector3(44.2,26.0,0.9),
                MouthOffset = vector3(0.093,-0.010,0.007),      -- Separate position for when it's in the mouth.
                MouthRotation = vector3(3.0,17.7,83.0),
            },
            -- PropStages: the joint's model changes as it burns down. Each stage has a "Percent" (how much joint is left).
            --   The script picks the stage whose Percent matches the current burn amount.
            --   Unlit = models shown before lighting, Lit = models shown after lighting (with embers + smoke particle).
            PropStages = {
                Unlit = {
                    {
                        Percent = 100, Model = "dc_joint100unlit",
                        Offset = vector3(0.105,-0.065,-0.019),
                        Rotation = vector3(44.2,26.0,0.9),
                        MouthOffset = vector3(0.093,-0.010,0.007),
                        MouthRotation = vector3(3.0,17.7,83.0),
                    },
                    {
                        Percent = 50, Model = "dc_joint50unlit",
                        Offset = vector3(0.110,-0.050,-0.008),
                        Rotation = vector3(44.2,26.0,0.9),
                        MouthOffset = vector3(0.075,-0.008,0.008),
                        MouthRotation = vector3(3.0,17.7,83.0),
                    },
                    {
                        Percent = 25, Model = "dc_joint25unlit",
                        Offset = vector3(0.115,-0.037,0.003),
                        Rotation = vector3(44.2,26.0,0.9),
                        MouthOffset = vector3(0.064,-0.006,0.008),
                        MouthRotation = vector3(3.0,17.7,83.0),
                    },
                },
                Lit = {
                    {
                        Percent = 100, Model = "dc_joint100lit",
                        Offset = vector3(0.105,-0.065,-0.019),
                        Rotation = vector3(44.2,26.0,0.9),
                        MouthOffset = vector3(0.093,-0.010,0.007),
                        MouthRotation = vector3(3.0,17.7,83.0),
                        Particle = { dict = "core", name = "exp_grd_bzgas_smoke", scale = 0.04, offset = vector3(0.0000, -0.0517, 0.0000), rot = vector3(0.0000, -0.0000, 0.0000) },
                    },
                    {
                        Percent = 50, Model = "dc_joint50lit",
                        Offset = vector3(0.110,-0.050,-0.008),
                        Rotation = vector3(44.2,26.0,0.9),
                        MouthOffset = vector3(0.075,-0.008,0.008),
                        MouthRotation = vector3(3.0,17.7,83.0),
                        Particle = { dict = "core", name = "exp_grd_bzgas_smoke", scale = 0.03, offset = vector3(0.0000, -0.0393, 0.0000), rot = vector3(0.0000, -0.0000, 0.0000) },
                    },
                    {
                        Percent = 25, Model = "dc_joint25lit",
                        Offset = vector3(0.115,-0.037,0.003),
                        Rotation = vector3(44.2,26.0,0.9),
                        MouthOffset = vector3(0.064,-0.006,0.008),
                        MouthRotation = vector3(3.0,17.7,83.0),
                        Particle = { dict = "core", name = "exp_grd_bzgas_smoke", scale = 0.02, offset = vector3(0.0000, -0.0258, 0.0000), rot = vector3(0.0000, -0.0000, 0.0000) },
                    },
                }
            },
            DegradePerSecond = 6.5,                           -- How much burn progress ticks each second while lit. Higher = joint burns down faster.
            Roughness = 0.0,                                  -- Device cough bias. Positive = harsher hit (more cough), negative = smoother. Joints are smoothest (rolling paper). Multiplier on final cough chance: 0.0 = no change, 0.1 = +10% cough.
        },
    },
    Items = {} -- Don't Touch (auto-filled from ItemGroups)
}
ExpandItemGroups(Config.Joints)