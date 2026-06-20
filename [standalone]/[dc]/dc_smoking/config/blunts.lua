Config.Blunts = {
    DefaultLitTime = { Min = 45000, Max = 90000 },   -- How long (ms) a blunt stays lit after lighting. Random between Min and Max.
    MinInhaleTime = 1000,                            -- Shortest (ms) an inhale can count. Shorter presses don't register as a hit.
    MaxInhaleTime = 4000,                            -- Longest (ms) an inhale can be held before auto-release.

    -- Animations for each part of the blunt flow.
    -- Each animation uses: Dict, Anim, Duration, Flag, BlendIn, BlendOut (see config/vapes.lua for a full explanation of these fields).
    Animations = {
        GrabItem    = { Dict = "dc@pack", Anim = "packgrab_c", Duration = 1500, AttachPropAt = 800, Flag = 0 },                        -- Pulling the blunt out of a pack/pocket.
        Idle        = { Dict = "dc@handsmoke", Anim = "handsmokehold_c", Flag = 49,      BlendIn = 2.0, BlendOut = -1.0 },             -- Holding the blunt at their side between hits.
        Lighting      = { Dict = "dc@lhs", Anim = "lhs_c", Duration = 13000, BlendIn = 2.0, BlendOut = -1.0 },                          -- Lighting the blunt while holding it in hand.
        LightingMouth = { Dict = "dc@lhs", Anim = "lms_c", Duration = 8500, BlendIn = 2.0, BlendOut = -1.0 },                           -- Lighting the blunt while it's in the mouth.
        Smoking     = { Dict = "dc@handsmoke", Anim = "handsmoke_c", Flag = 49,      BlendIn = 2.0, BlendOut = -1.0 },                 -- Taking a hit.
        Ashing      = { Dict = "dc@handsmoke", Anim = "handsmokeash_c", Duration = 2200, Flag = 49, BlendIn = 2.0, BlendOut = -1.0 },  -- Tapping ash off.
        ToFromMouth = { Dict = "dc@handsmoke", Anim = "handsmokemouth_c", Duration = 1000, AttachAt = 900, BlendIn = 2.0, BlendOut = -2.0 } -- Moving between hand and mouth. AttachAt = when in the anim (ms) to reattach the prop.
    },
    Sounds = {
        Lighting = { File = "lighterflick.ogg", Volume = 0.2, Delay = 2000 },                  -- Lighter flick sound.
        Inhale   = { File = "smokecrackle.ogg", Volume = 0.06, Loop = true },     -- Quiet crackle while burning.
        Cough = { Volume = 0.2, Delay = 700 }, -- Change sound name in config.lua
        Exhale   = { File = "exhale.ogg", Volume = 0.06 },                        -- Exhale sound.
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
        MaxHoldTime = 4000, -- Should match MaxInhaleTime above
        Duration = 2000,
    },
    -- LightSequence: precise timing of each step in the lighting animation.
    -- Each "At" value is ms into the Lighting animation when that step fires.
    LightSequence = {
        MoveToMouth = true,                                   -- If true, the blunt auto-moves to the mouth as part of lighting.
        LighterBone = 57005,                                  -- Bone to attach the lighter to (57005 = right hand).
        LighterOffset = vector3(0.112,-0.004,-0.041),         -- Fine-tune lighter position on the bone.
        LighterRotation = vector3(-93.8,-19.7,-22.9),         -- Lighter rotation in degrees.
        ItemToMouthAt = 1000,                                 -- ms when the blunt moves to the mouth.
        AttachLighterAt = 3200,                               -- ms when the lighter appears in hand.
        LighterSoundAt = 2300,                                -- ms when the flick sound plays.
        FlameAt = 4700,                                       -- ms when the flame particle starts.
        LitModelAt = 5500,                                    -- ms when the unlit blunt swaps to the lit version.
        FlameOffAt = 7760,                                    -- ms when the flame stops.
        DeleteLighterAt = 8500,                               -- ms when the lighter disappears.
        ItemToHandAt = 11700,                                 -- ms when the lit blunt moves from mouth back to hand.
    },
    -- LightSequenceMouth: overrides for when the player is lighting the blunt while it's already in their mouth (uses the shorter lms_c anim).
    -- Only define fields that differ from LightSequence; anything omitted falls back to the values above.
    -- ItemToMouthAt is skipped automatically when lighting from mouth, so no need to define it here.
    LightSequenceMouth = {
        LighterSoundAt = 1500,                                -- ms when the flick sound plays.
        AttachLighterAt = 1330,                               -- ms when the lighter appears in hand.
        FlameAt = 2400,                                       -- ms when the flame particle starts.
        LitModelAt = 4230,                                    -- ms when the unlit blunt swaps to the lit version.
        FlameOffAt = 5540,                                    -- ms when the flame stops.
        DeleteLighterAt = 7200,                               -- ms when the lighter disappears.
    },
    ItemGroups = {
        {
            ItemInfo = {
                { Name = 'rolled_blunt', Label = 'Blunt' }, -- 1 item, strain will be determined dynamically as metadata
            },
            LitTime = { Min = 50000, Max = 100000 },           -- Overrides DefaultLitTime above for this group.
            Bone = 58866,                                      -- Bone the blunt attaches to in hand (fingertip).
            MouthBone = 47495,                                 -- Bone the blunt attaches to when in the mouth.
            -- FreshModel: the prop used briefly when the blunt is first pulled out.
            FreshModel = {
                Model = "dc_blunt100",
                Offset = vector3(0.105,-0.065,-0.019),
                Rotation = vector3(44.2,26.0,0.9),
                MouthOffset = vector3(0.093,-0.010,0.007),      -- Separate position for when it's in the mouth.
                MouthRotation = vector3(3.0,17.7,83.0),
            },
            -- PropStages: the blunt's model changes as it burns down. Script picks the stage whose Percent matches the current burn amount.
            --   Unlit = models shown before lighting, Lit = models shown after lighting (with embers + smoke particle).
            PropStages = {
                Unlit = {
                    {
                        Percent = 100, Model = "dc_blunt100unlit",
                        Offset = vector3(0.105,-0.065,-0.019),
                        Rotation = vector3(44.2,26.0,0.9),
                        MouthOffset = vector3(0.093,-0.010,0.007),
                        MouthRotation = vector3(3.0,17.7,83.0),
                    },
                    {
                        Percent = 50, Model = "dc_blunt50unlit",
                        Offset = vector3(0.110,-0.050,-0.008),
                        Rotation = vector3(44.2,26.0,0.9),
                        MouthOffset = vector3(0.075,-0.008,0.008),
                        MouthRotation = vector3(3.0,17.7,83.0),
                    },
                    {
                        Percent = 25, Model = "dc_blunt25unlit",
                        Offset = vector3(0.115,-0.037,0.003),
                        Rotation = vector3(44.2,26.0,0.9),
                        MouthOffset = vector3(0.064,-0.006,0.008),
                        MouthRotation = vector3(3.0,17.7,83.0),
                    },
                },
                Lit = {
                    {
                        Percent = 100, Model = "dc_blunt100lit",
                        Offset = vector3(0.105,-0.065,-0.019),
                        Rotation = vector3(44.2,26.0,0.9),
                        MouthOffset = vector3(0.093,-0.010,0.007),
                        MouthRotation = vector3(3.0,17.7,83.0),
                        Particle = { dict = "core", name = "exp_grd_bzgas_smoke", scale = 0.04, offset = vector3(0.0000, -0.0469, 0.0000), rot = vector3(0.0000, -0.0000, 0.0000) },
                    },
                    {
                        Percent = 50, Model = "dc_blunt50lit",
                        Offset = vector3(0.110,-0.050,-0.008),
                        Rotation = vector3(44.2,26.0,0.9),
                        MouthOffset = vector3(0.075,-0.008,0.008),
                        MouthRotation = vector3(3.0,17.7,83.0),
                        Particle = { dict = "core", name = "exp_grd_bzgas_smoke", scale = 0.03, offset = vector3(0.0000, -0.0322, 0.0000), rot = vector3(0.0000, -0.0000, 0.0000) },
                    },
                    {
                        Percent = 25, Model = "dc_blunt25lit",
                        Offset = vector3(0.115,-0.037,0.003),
                        Rotation = vector3(44.2,26.0,0.9),
                        MouthOffset = vector3(0.064,-0.006,0.008),
                        MouthRotation = vector3(3.0,17.7,83.0),
                        Particle = { dict = "core", name = "exp_grd_bzgas_smoke", scale = 0.02, offset = vector3(0.0000, -0.0141, 0.0000), rot = vector3(0.0000, -0.0000, 0.0000) },
                    },
                }
            },
            DegradePerSecond = 3.5,                           -- How much burn progress ticks each second while lit. Higher = burns down faster.
            Roughness = 0.10,                                 -- Tobacco wrap is noticeably rougher than a rolling paper. Multiplier on final cough chance.
        },
    },
    Items = {} -- Don't Touch (auto-filled from ItemGroups)
}
ExpandItemGroups(Config.Blunts)