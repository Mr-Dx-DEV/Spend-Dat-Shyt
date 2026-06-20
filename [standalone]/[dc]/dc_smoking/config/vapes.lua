-- =====================================================================
-- VAPES
-- Rechargeable, refillable electronic smoking devices.
-- Vapes have a battery that drains while smoking and a juice tank that
-- has to be refilled with flavors. Dead battery = can't smoke until
-- charged. Empty tank = won't pull until refilled.
-- =====================================================================
Config.Vapes = {
    MaxInhaleTime = 5000,   -- How long (ms) the player can hold the inhale button before auto-release. 6500 = 6.5 seconds.
    DefaultLitTime = nil,   -- Not used for vapes (vapes don't "burn down" like joints). Leave as nil.

    -- Animations played at different points in the vape flow.
    -- Every animation entry uses:
    --   Dict     = the animation dictionary (a file of animations)
    --   Anim     = the specific clip name inside that dictionary
    --   Duration = how long it plays in ms
    --   Flag     = GTA animation flag. 49 = loop + upper body only, 0 = play once
    --   BlendIn  = how fast it fades in (higher = snappier)
    --   BlendOut = how fast it fades out (negative = smooth fade)
    Animations = {
        GrabItem = { Dict = "dc@pack", Anim = "packgrab_c", Duration = 1500, AttachPropAt = 800, Flag = 0 },           -- Animation for pulling the vape out of pocket. AttachPropAt = when in the anim the prop appears in hand.
        Idle    = { Dict = "dc@vapesmoke", Anim = "vapesmokehold_c",    Flag = 49, BlendIn = 2.0, BlendOut = -2.0 },   -- Plays while holding the vape but not actively hitting it.
        Smoking = { Dict = "dc@vapesmoke",      Anim = "vapesmoke_c",                                      BlendIn = 2.0, BlendOut = -2.0 },  -- Plays during the actual inhale.
        Load    = {   -- Animation for refilling the vape with juice.
            Dict = "dc@vapeload", Anim = "vapeload_c", Duration = 9300, BlendIn = 2.0, BlendOut = -1.0,
            -- Prop is the juice bottle that appears in hand during refill.
            Prop = {
                Model = "dc_vapejuice",                     -- 3D model name
                Bone = 26610,                               -- Which player bone to attach to (26610 = right hand)
                Offset = vector3(0.104,0.005,-0.023),       -- Fine-tune position on the bone (x, y, z)
                Rotation = vector3(-96.7,6.0,-27.2),        -- Rotation of the prop in degrees
                AttachAt = 1800,                            -- When in the anim (ms) the bottle appears
                DeleteAt = 8200,                            -- When in the anim (ms) the bottle disappears
            },
        }
    },
    -- Sounds played during inhale and exhale.
    --   File   = .ogg filename inside the ui/sounds/ folder
    --   Volume = 0.0 (silent) to 1.0 (full)
    --   Loop   = true to keep looping while held
    --   Delay  = ms wait before the sound starts
    Sounds = {
        Inhale = { File = "vapeinhale.ogg", Volume = 0.1, Loop = true, Delay = 500 },
        Exhale   = { File = "exhale.ogg", Volume = 0.06 },
        Cough = { Volume = 0.2, Delay = 700 }, -- Change sound name in config.lua
    },
    CoughChance = { Base = 0.05, Max = 0.15 },   -- Chance the player coughs. Base = normal hit, Max = holding inhale too long. 0.05 = 5%.
    -- Facials change the player's face expression during/after smoking.
    --   Inhale         = facial idle name shown while hitting
    --   Exhale         = facial idle name shown after exhale
    --   ExhaleDuration = how long (ms) the exhale face stays on
    Facials = {
        Inhale     = "mood_Smug_1",
        Exhale     = "mood_Stressed_1",
        ExhaleDuration = 2500,
    },
    -- ExhaleParticle: the cloud of vapor that comes out on exhale.
    --   Dict/Name     = built-in game particle reference
    --   Bone          = which player bone to emit from (47495 = mouth area)
    --   Offset/Rot    = fine-tune position and angle
    --   MinScale      = cloud size on a short hit
    --   MaxScale      = cloud size on the longest possible hit
    --   MaxHoldTime   = hold time (ms) that produces MaxScale; anything past this caps
    --   Duration      = how long (ms) the cloud stays visible
    ExhaleParticle = {
        Dict = "core",
        Name = "exp_grd_bzgas_smoke",
        Bone = 47495,
        Offset = vector3(0.078, 0.003, -0.000),
        Rotation = vector3(0.0, 0.0, 0.0),
        MinScale = 0.1,
        MaxScale = 0.8,
        MaxHoldTime = 5000,
        Duration = 2000,
    },
    -- ItemGroups: share the same settings (bone, stats, particle, etc.) across many vapes.
    -- Every vape in ItemInfo below uses the shared settings under its group.
    ItemGroups = {
        {
            -- The actual vape items. Name/Prop/Label work the same as on lighters.
            ItemInfo = {
                { Name = 'dc_blackvape', Prop = 'dc_blackvape', Label = 'Black Vape' },
                { Name = 'dc_bluevape', Prop = 'dc_bluevape', Label = 'Blue Vape' },
                { Name = 'dc_greenvape', Prop = 'dc_greenvape', Label = 'Green Vape' },
                { Name = 'dc_orangevape', Prop = 'dc_orangevape', Label = 'Orange Vape' },
                { Name = 'dc_pinkvape', Prop = 'dc_pinkvape', Label = 'Pink Vape' },
                { Name = 'dc_redvape', Prop = 'dc_redvape', Label = 'Red Vape' },
                { Name = 'dc_turquoisevape', Prop = 'dc_turquoisevape', Label = 'Turquoise Vape' },
                { Name = 'dc_whitevape', Prop = 'dc_whitevape', Label = 'White Vape' },
                { Name = 'dc_yellowvape', Prop = 'dc_yellowvape', Label = 'Yellow Vape' },
            },
            Bone = 57005,                                           -- Which player bone the vape attaches to (57005 = right hand)
            Offset = vector3(0.147,0.050,-0.036),                   -- Fine-tune where the vape sits in the hand
            Rotation = vector3(40.7,-53.7,-140.5),                  -- Vape rotation in degrees
            RefillType = "vape_juice",                              -- What kind of refill this item accepts (see Config.Refills below)
            Capacity = 1,                                           -- How many "doses" of juice the tank holds at full
            DegradePerSecond = 0.5,                                 -- How fast the juice drains while hitting (higher = empties faster)
            BatteryDrainPerSecond = { Min = 0.8, Max = 1.8 },       -- Random battery drain per second of use. Range adds realism.
            Roughness = -0.10,                                      -- Vapor is the smoothest smokeable. Negative reduces cough chance.
            Particle = { dict = "core", name = "exp_grd_bzgas_smoke", scale = 2.0, offset = vector3(0.0, 0.2, 0.0) },  -- Idle vapor that puffs from the vape tip between hits.
        },
    },
    Items = {} -- Don't Touch (auto-filled from ItemGroups above)
}
ExpandItemGroups(Config.Vapes)

-- =====================================================================
-- VAPE CHARGING
-- Controls how players charge dead vape batteries using a charger item.
-- =====================================================================
Config.VapeCharging = {
    Enabled = true,                 -- Set to false to disable charging entirely (dead vapes stay dead).
    ChargeDuration = 30,            -- Seconds to go from 0% to 100%. Partial charges are proportional (half empty = half time).
    ChargerItem = 'vape_charger',   -- The inventory item name required to charge a vape.
}

-- =====================================================================
-- VAPE JUICE REFILLS
-- The list of juice flavors that can be loaded into a vape.
-- Each entry is one flavor.
--   Item  = inventory item name for that flavor
--   Prop  = 3D model of the juice bottle
--   Label = player-facing name shown in menus
-- Add/remove lines here to control which flavors exist on your server.
-- =====================================================================
-- =====================================================================
-- NICOTINE BUZZ
-- Nicotine juices don't get you "high" (that track is for THC/weed oil).
-- Instead they build up a subtle "buzz" that drives a light camera shake
-- proportional to how much nicotine is in the player's system. Buzz decays
-- over time like highness. Weed oil carts added later should set their
-- juice Stats.High > 0 and BuzzPerPuff = 0 to stay on the pure THC track.
-- =====================================================================
Config.Nicotine = {
    Enabled = true,
    BuzzPerPuff = 5,              -- How much buzz each nicotine puff adds (scaled by hold time).
    MaxBuzz = 50,                 -- Buzz cap (0-100 scale but tops at 50 by default).
    DecayRate = 1,                -- Buzz lost per decay tick (shares Config.Effects.DecayIntervalMs).
    ShakeStartAt = 20,            -- Buzz level where subtle shake starts.
    ShakeMaxAt = 50,              -- Buzz level where shake hits its ceiling.
    ShakeType = 'DRUNK_SHAKE',    -- GTA shake preset. Subtle options: DRUNK_SHAKE, HAND_SHAKE.
    ShakeStrengthMax = 0.03,      -- Maximum shake strength at ShakeMaxAt buzz. Keep very subtle (0.02-0.04).
}

-- =====================================================================
-- VAPE JUICES
-- Each entry is a single refill flavor. Stats drive the per-puff effect.
-- Current juices are NICOTINE profile — small Stress reduction, no High,
-- no Armor. Per-juice BuzzPerPuff overrides Config.Nicotine.BuzzPerPuff.
-- To add weed oil carts later: set Stats.High > 0 and BuzzPerPuff = 0.
-- =====================================================================
Config.Refills['vape_juice'] = {
    { Item = 'dc_arcticvoltage',  Prop = 'dc_arcticvoltage',  Label = 'Arctic Voltage',  Stats = { Stress = 12, Armor = 0, High = 0 } },
    { Item = 'dc_blueballistic',  Prop = 'dc_blueballistic',  Label = 'Blue Ballistic',  Stats = { Stress = 12, Armor = 0, High = 0 } },
    { Item = 'dc_crimsoncrush',   Prop = 'dc_crimsoncrush',   Label = 'Crimson Crush',   Stats = { Stress = 12, Armor = 0, High = 0 } },
    { Item = 'dc_dragonbreath',   Prop = 'dc_dragonbreath',   Label = 'Dragon Breath',   Stats = { Stress = 12, Armor = 0, High = 0 } },
    { Item = 'dc_galaxygrape',    Prop = 'dc_galaxygrape',    Label = 'Galaxy Grape',    Stats = { Stress = 12, Armor = 0, High = 0 } },
    { Item = 'dc_glitchgreen',    Prop = 'dc_glitchgreen',    Label = 'Glitch Green',    Stats = { Stress = 12, Armor = 0, High = 0 } },
    { Item = 'dc_midnightmilk',   Prop = 'dc_midnightmilk',   Label = 'Midnight Milk',   Stats = { Stress = 12, Armor = 0, High = 0 } },
    { Item = 'dc_neonnectar',     Prop = 'dc_neonnectar',     Label = 'Neon Nectar',     Stats = { Stress = 12, Armor = 0, High = 0 } },
    { Item = 'dc_phantomfreeze',  Prop = 'dc_phantomfreeze',  Label = 'Phantom Freeze',  Stats = { Stress = 12, Armor = 0, High = 0 } },
    { Item = 'dc_quantaumcookie', Prop = 'dc_quantaumcookie', Label = 'Quantum Cookie',  Stats = { Stress = 12, Armor = 0, High = 0 } },
    { Item = 'dc_subzerocitrus',  Prop = 'dc_subzerocitrus',  Label = 'Sub Zero Citrus', Stats = { Stress = 12, Armor = 0, High = 0 } },
    { Item = 'dc_toxictaffy',     Prop = 'dc_toxictaffy',     Label = 'Toxic Taffy',     Stats = { Stress = 12, Armor = 0, High = 0 } },
    { Item = 'dc_turbotropical',  Prop = 'dc_turbotropical',  Label = 'Turbo Tropical',  Stats = { Stress = 12, Armor = 0, High = 0 } },
    { Item = 'dc_velvetvoid',     Prop = 'dc_velvetvoid',     Label = 'Velvet Void',     Stats = { Stress = 12, Armor = 0, High = 0 } },
}
