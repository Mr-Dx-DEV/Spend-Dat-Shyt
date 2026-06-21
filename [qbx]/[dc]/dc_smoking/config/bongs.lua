Config.BongLiquids = {
    Enabled = true,
    RequireLiquid = true,      -- true = player must have the liquid item in inventory to fill. false = liquid is free/infinite.
    DrainPerSecond = 2.0,      -- How fast (per second of use) the water level drops. Higher = refill more often.
    Items = {
        -- Each entry is one liquid.
        --   Label         = name shown in menus
        --   Description   = menu tooltip
        --   TasteText     = flavor text shown to the player while using it
        --   EffectModifier = multiplier on the bong's hit strength. 1.0 = normal, 1.2 = 20% stronger hit, 0.8 = weaker.
        --   SmokeColor    = tint the smoke cloud (r/g/b 0-255). nil = no tint (normal white smoke).
        ['water'] = {
            Label = "Water",
            Description = "Clean, pure water. Standard smooth hit.",
            TasteText = "Cool and clean.",
            EffectModifier = 1.0,
            SmokeColor = nil   -- Example of a tint: SmokeColor = { r = 255, g = 200, b = 100 }
        },
        -- Add More here (copy the water block, rename the key, tweak values)
    }
}

Config.Bongs = {
    MaxInhaleTime = 5500,   -- Longest (ms) one inhale can be held.

    -- ExhaleParticle: exhale smoke cloud. Same fields as vapes (see config/vapes.lua).
    ExhaleParticle = {
        Dict = "core",
        Name = "exp_grd_bzgas_smoke",
        Bone = 47495,
        Offset = vector3(0.078, 0.003, -0.000),
        Rotation = vector3(0.0, 0.0, 0.0),
        MinScale = 0.08,
        MaxScale = 0.7,
        MaxHoldTime = 5500,
        Duration = 2000,
    },
    DefaultLitTime = {      -- How long (ms) the bowl stays lit after lighting, before it burns out. Random between Min and Max.
        Min = 5000,
        Max = 10000
    },
    -- Animations for each step of the bong flow.
    -- Dict/Anim/Duration/Flag/BlendIn/BlendOut fields work the same as on vapes/pipes.
    Animations = {
        GrabItem = { Dict = "dc@pack", Anim = "packgrab_c", Duration = 1500, AttachPropAt = 800, Flag = 0 },   -- Pulling the bong out.
        Idle = {                                                                                                -- Holding the bong between hits.
            Dict = "dc@bong",
            Anim = "bonghold_c",
            Flag = 49,
            BlendIn = 2.0,
            BlendOut = -2.0
        },
        Smoking = {                                                                                             -- Active bong rip.
            Dict = "dc@bong",
            Anim = "bonguse_c",
            BlendIn = 2.0,
            BlendOut = -2.0
        },
        Load = {                                                                                                -- Packing the bowl with weed.
            Dict = "dc@bongload",
            Anim = "bongload_c",
            Duration = 3000,
            BlendIn = 2.0,
            BlendOut = -2.0,
            Prop = {
                Model = "dc_weednug",
                Bone = 26610,
                Offset = vector3(0.112,-0.025,-0.008),
                Rotation = vector3(-82.0,-25.7,123.5),
                AttachAt = 0,
                DeleteAt = 3068,
            },
        },
        WaterFill = {                                                                                           -- Pouring water into the chamber.
            Dict = "dc@bongwater",
            Anim = "bongwater_c",
            Duration = 8000,
            BlendIn = 2.0,
            BlendOut = -2.0,
            Prop = {
                Model = "prop_ld_flow_bottle",
                Bone = 18905,                            -- Bone to attach bottle to.
                Offset = vector3(0.118,0.015,0.046),
                Rotation = vector3(-108.5,-0.0,0.0)
            }
        },
        WaterEmpty = {                                                                                          -- Emptying the chamber.
            Dict = "dc@bongwater",
            Anim = "bongwaterempty_c",
            Duration = 5100,
            BlendIn = 2.0,
            BlendOut = -1.0
        }
    },
    Sounds = {
        Lighting = { File = "lighterflick.ogg", Volume = 0.2 },                       -- Plays while the lighter is held to the bowl.
        Inhale   = { File = "bong_rip.ogg", Volume = 0.25, Loop = true },              -- The iconic bong rip sound while inhaling.
        Cough = { Volume = 0.2, Delay = 700 }, -- Change sound name in config.lua
        WaterFill  = { File = "pourwater.ogg", Volume = 0.05 },  
        Exhale   = { File = "exhale.ogg", Volume = 0.06 },-- Water pouring sound during WaterFill.
    },
    CoughChance = { Base = 0.35, Max = 0.65 },   -- Bongs hit the hardest = highest cough chance in the script.
    Facials = {
        Inhale     = "mood_Smug_1",
        Exhale     = "mood_Stressed_1",
        ExhaleDuration = 2500,
    },
    ItemGroups = {
        {
            ItemInfo = {
                { Name = 'dc_blackbong', Prop = 'dc_blackbong', Label = 'Black Bong' },
                { Name = 'dc_bluebong', Prop = 'dc_bluebong', Label = 'Blue Bong' },
                { Name = 'dc_greenbong', Prop = 'dc_greenbong', Label = 'Green Bong' },
                { Name = 'dc_orangebong', Prop = 'dc_orangebong', Label = 'Orange Bong' },
                { Name = 'dc_pinkbong', Prop = 'dc_pinkbong', Label = 'Pink Bong' },
                { Name = 'dc_purplebong', Prop = 'dc_purplebong', Label = 'Purple Bong' },
                { Name = 'dc_redbong', Prop = 'dc_redbong', Label = 'Red Bong' },
                { Name = 'dc_turquoisebong', Prop = 'dc_turquoisebong', Label = 'Turquoise Bong' },
                { Name = 'dc_whitebong', Prop = 'dc_whitebong', Label = 'White Bong' },
                { Name = 'dc_yellowbong', Prop = 'dc_yellowbong', Label = 'Yellow Bong' },
            },
            Bone = 57005,                                      -- Right hand.
            Offset = vector3(0.128,-0.001,-0.033),
            Rotation = vector3(27.9,65.1,117.8),
            RefillType = "weed",                               -- Bongs accept ground weed (or hashish via HashBowlProp).
            Capacity = 1,                                      -- Doses the bowl holds.
            InhaleDelay = 2000,                                -- ms the player must hold the lighter on the bowl before the rip can begin.
            LighterDuration = 5000,                            -- ms the lighter stays lit while prepping the rip.
            Roughness = -0.05,                                 -- Water filtration smooths the hit. Negative reduces cough chance.
            Particle = { dict = "core", name = "exp_grd_bzgas_smoke", scale = 3.0, offset = vector3(0.0, 0.3, 0.0) },   -- Idle smoke wisping from the bowl. Larger scale = bigger cloud.
            -- Where the lighter attaches while lighting the bowl.
            Lighter = {
                Bone = 18905,
                Offset = vector3(0.120,0.038,0.012),
                Rotation = vector3(160.4,-57.6,74.7)
            },
            -- BowlProp: weed visible in the bowl.
            BowlProp = {
                Model = "dc_bongweed",
                Offset = vector3(0.0007, -0.0537, -0.0677),
                Rotation = vector3(0.0, 0.0, 0.0),
            },
            -- HashBowlProp: visible in the bowl when packed with hash.
            HashBowlProp = {
                Model = "dc_bonghashish",
                Offset = vector3(0.0, 0.0, 0.0),
                Rotation = vector3(0.0, 0.0, 0.0),
            },
            -- HashLoadProp: block in hand during the load anim when loading hash.
            HashLoadProp = {
                Model = "dc_hashish",
                Bone = 26610,
                Offset = vector3(0.112,-0.025,-0.008),
                Rotation = vector3(-82.0,-25.7,123.5),
                AttachAt = 0,
                DeleteAt = 3068,
            },
        },
    },
    Items = {} -- Don't Touch (auto-filled from ItemGroups)
}
ExpandItemGroups(Config.Bongs)

-- Storage slot for weed refills. Filled in by packs.lua and bags.lua — don't edit this line.
Config.Refills['weed'] = {}