Config.Pipes = {
    MaxInhaleTime = 5000,                           -- Longest a single inhale can be held (ms). After this the bar auto-releases.
    DefaultLitTime = { Min = 10000, Max = 15000 },  -- How long the bowl stays lit after lighting (ms). Random between Min and Max. Higher = longer smoke sessions before it needs relighting.

    -- ExhaleParticle: the smoke cloud that comes out on exhale.
    -- Same fields as the vape ExhaleParticle — see config/vapes.lua for detailed descriptions.
    ExhaleParticle = {
        Dict = "core",
        Name = "exp_grd_bzgas_smoke",
        Bone = 47495,
        Offset = vector3(0.078, 0.003, -0.000),
        Rotation = vector3(0.0, 0.0, 0.0),
        MinScale = 0.05,
        MaxScale = 0.3,
        MaxHoldTime = 5000,
        Duration = 2000,
    },
    -- Animations played at different points in the pipe flow.
    -- Field meanings are the same as on vapes (Dict/Anim/Duration/Flag/BlendIn/BlendOut).
    Animations = {
        GrabItem = { Dict = "dc@grableft", Anim = "grableft_c", Duration = 1500, AttachPropAt = 800, Flag = 0 },   -- Pulling pipe out. AttachPropAt = when in the anim (ms) the pipe appears.
        Idle  = { Dict = "dc@pipesmoke", Anim = "pipesmokehold_c", Flag = 49, BlendIn = 2.0, BlendOut = -1.0 },    -- Holding pipe between hits.
        Smoking = { Dict = "dc@pipesmoke", Anim = "pipesmoke_c",   BlendIn = 2.0, BlendOut = -2.0 },               -- Active inhale.
        Load  = { Dict = "dc@pipeload", Anim = "pipeload_c", Duration = 3000, BlendIn = 2.0, BlendOut = -2.0,      -- Packing the bowl with weed.
            -- Prop = the weed nug that appears in hand during the load animation.
            Prop = {
                Model = "dc_weednug",
                Bone = 57005,                               -- 57005 = right hand
                Offset = vector3(0.145,0.029,-0.033),       -- Position tweak
                Rotation = vector3(-106.8,14.8,61.3),       -- Rotation in degrees
                AttachAt = 0,                               -- ms into the anim when the nug appears (0 = immediately)
                DeleteAt = 4240,                            -- ms into the anim when it disappears
            }
        }
    },
    -- Sounds played during pipe use. Same fields as vapes.
    Sounds = {
        Lighting = { File = "lighterflick.ogg", Volume = 0.2 },
        Inhale   = { File = "smokecrackle.ogg", Volume = 0.06, Loop = true },   -- Subtle crackle while bowl burns.
        Cough = { Volume = 0.2, Delay = 700 }, -- Change sound name in config.lua
        Exhale   = { File = "exhale.ogg", Volume = 0.06 },
    },
    CoughChance = { Base = 0.50, Max = 0.80 },   -- Pipes hit harder than vapes, so cough chances are higher. Base = normal hit (50%), Max = red zone (80%).
    -- Facial expressions during/after smoking. Same as vapes.
    Facials = {
        Inhale     = "mood_Smug_1",
        Exhale     = "mood_Stressed_1",
        ExhaleDuration = 2500,
    },
    -- ItemGroups: share settings across many pipes. Same concept as the vape group.
    ItemGroups = {
        {
            -- The actual pipe items.
            ItemInfo = {
                { Name = 'dc_pipeblack', Prop = 'dc_pipeblack', Label = 'Black Pipe' },
                { Name = 'dc_pipeblue',  Prop = 'dc_pipeblue',  Label = 'Blue Pipe' },
                { Name = 'dc_pipegreen', Prop = 'dc_pipegreen', Label = 'Green Pipe' },
                { Name = 'dc_pipeorange', Prop = 'dc_pipeorange', Label = 'Orange Pipe' },
                { Name = 'dc_pipepink', Prop = 'dc_pipepink', Label = 'Pink Pipe' },
                { Name = 'dc_pipepurple', Prop = 'dc_pipepurple', Label = 'Purple Pipe' },
                { Name = 'dc_pipered', Prop = 'dc_pipered', Label = 'Red Pipe' },
                { Name = 'dc_pipeturquoise', Prop = 'dc_pipeturquoise', Label = 'Turquoise Pipe' },
                { Name = 'dc_pipewhite', Prop = 'dc_pipewhite', Label = 'White Pipe' },
                { Name = 'dc_pipeyellow', Prop = 'dc_pipeyellow', Label = 'Yellow Pipe' },
            },
            Bone = 26610,                                -- 26610 = left hand (pipes are held in the left)
            Offset = vector3(0.083,-0.030,0.026),        -- Fine-tune where the pipe sits in the hand
            Rotation = vector3(48.7,-1.1,91.3),          -- Pipe rotation in degrees
            RefillType = "weed",                         -- What the pipe accepts as a refill (ground weed). Also allows hashish via HashBowlProp below.
            Capacity = 1,                                -- How many doses the bowl holds at once.
            Roughness = 0.05,                            -- Quick direct hit, slight raspiness. Multiplier on final cough chance.
            Particle = { dict = "core", name = "exp_grd_bzgas_smoke", scale = 1.0, offset = vector3(0.0, 0.1, 0.0) },   -- Smoke that wisps off the bowl between hits.
            -- Lighter: where the lighter attaches on the player when lighting the bowl.
            Lighter = {
                Bone = 58866,                            -- Bone to attach the lighter to (thumb-ish on the right hand)
                Offset = vector3(0.080,-0.029,0.002),
                Rotation = vector3(-78.7,-6.2,-81.4)
            },
            -- BowlProp: the weed visible in the bowl while it's packed. Disappears as it burns.
            BowlProp = {
                Model = "dc_pipeweed",
                Offset = vector3(0.0000, -0.0392, 0.0149),
                Rotation = vector3(0.0, 0.0, 0.0),
            },
            -- HashBowlProp: same idea but for when the bowl is packed with hashish instead of flower.
            HashBowlProp = {
                Model = "dc_pipehashish",
                Offset = vector3(0.0, 0.0, 0.0),
                Rotation = vector3(0.0, 0.0, 0.0),
            },
            -- HashLoadProp: the hashish block that appears in hand during the load anim if loading hash instead of weed.
            HashLoadProp = {
                Model = "dc_hashish",
                Bone = 57005,
                Offset = vector3(0.145,0.029,-0.033),
                Rotation = vector3(-106.8,14.8,61.3),
                AttachAt = 0,
                DeleteAt = 4240,
            },
        },
    },
    Items = {} -- Don't Touch (auto-filled from ItemGroups)
}
ExpandItemGroups(Config.Pipes)