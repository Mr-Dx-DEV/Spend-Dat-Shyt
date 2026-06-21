-- =====================================================================
-- BURN RATES (how fast rolled items smoke)
-- Bump these UP to make smoking faster. Bump DOWN to make it slower.
-- =====================================================================
Config.BurnRates = {
    paper = 6.3,        -- Joints rolled with rolling paper
    blunt = 6.0,        -- Blunts rolled with blunt wraps
    leaf  = 5.5,        -- Items rolled with woodleaf / smackaleaf / frontoleaf
    fallback = 6.5,     -- Used if an item somehow has no matching category
    gramsScale = true,  -- Whether heavier rolls take longer to smoke (true = on, false = off)
    idleBurn  = 0.2,    -- Passive burn per second while item is lit but player isn't inhaling. Set to 0 to disable.
}

-- =====================================================================
-- TOBACCO MIX ITEMS
-- Items that can be added to rolls for tobacco-based variations
-- (wraps or loose tobacco to mix in with weed).
--   MixType = 'wrap' -> the item replaces the rolling paper
--   MixType = 'mix'  -> the item is added inside the roll alongside weed
-- =====================================================================
Config.TobaccoMix = {
    Items = {
        ['dc_smackaleaf_s'] = {
            Label = "Smacka Leaf",
            Description = "Smacka leaf for wrapping or mixing",
            MixType = "wrap"
        },
        ['dc_frontoleaf_s'] = {
            Label = "Fronto Leaf Wrap",
            Description = "Fronto leaf for wrapping or mixing",
            MixType = "wrap"
        },
        ['dc_loosetobacco'] = {
            Label = "Loose Tobacco",
            Description = "Loose tobacco for spliffs",
            MixType = "mix"
        }
    }
}

-- =====================================================================
-- GRINDERS
-- Tool used to grind raw weed into ground flower (used for rolling and
-- packing bowls). Grinding also produces small amounts of kief over time.
-- =====================================================================
Config.Grinders = {
    Enabled = true,
    MaxGramsPerGrind = 2,           -- Max grams of weed that can be loaded into the grinder at once.
    GroundFlowerBonus = 1.1,        -- Multiplier on the ground flower's effectiveness vs raw bud. 1.1 = 10% stronger hits.
    KiefCollectionRate = 0.05,      -- Fraction of each grind that accumulates as kief in the bottom chamber. 0.05 = 5%.

    -- Grinder animations. Same Dict/Anim/Duration/Flag/BlendIn/BlendOut fields as everywhere else.
    Animations = {
        GrabItem     = { Dict = "dc@grableft", Anim = "grableft_c", Duration = 1500, AttachPropAt = 800, Flag = 49 },
        Idle         = { Dict = "dc@grinder", Anim = "grinderhold_c", Flag = 49 },
        Grind        = {
            Dict = "dc@grinder", Anim = "grindergrind_c", Duration = 16000, Flag = 49, BlendIn = 2.0, BlendOut = -2.0,
            Prop = {
                Model = "dc_weednug",      
                Bone = 58866,                
                Offset = vector3(0.124,-0.025,0.013),
                Rotation = vector3(-100.9,-0.0,0.0),
                AttachAt = 1134,                 
                DeleteAt = 5800,                
            },
        },
        CollectKief  = { Dict = "dc@grinder", Anim = "grindergrab_c", Duration = 3500, Flag = 49, BlendIn = 2.0, BlendOut = -2.0 },
        PutAway      = { Dict = "dc@grableft", Anim = "grableft_c", Duration = 1500, DeletePropAt = 800, Flag = 49 },
    },

    ItemGroups = {
        {
            ItemInfo = {
                { Name = 'dc_grinderblack',  Prop = 'dc_grinderblack2',  Label = 'Black Grinder' },
                { Name = 'dc_grinderblue',   Prop = 'dc_grinderblue2',   Label = 'Blue Grinder' },
                { Name = 'dc_grindergreen',  Prop = 'dc_grindergreen2',  Label = 'Green Grinder' },
                { Name = 'dc_grinderorange', Prop = 'dc_grinderorange2', Label = 'Orange Grinder' },
                { Name = 'dc_grinderpink',   Prop = 'dc_grinderpink2',   Label = 'Pink Grinder' },
                { Name = 'dc_grinderpurple', Prop = 'dc_grinderpurple2', Label = 'Purple Grinder' },
                { Name = 'dc_grinderred',    Prop = 'dc_grinderred2',    Label = 'Red Grinder' },
                { Name = 'dc_grinderwhite',  Prop = 'dc_grinderwhite2',  Label = 'White Grinder' },
                { Name = 'dc_grinderyellow', Prop = 'dc_grinderyellow2', Label = 'Yellow Grinder' },
            },
            Bone = 18905,                           -- Which bone the grinder attaches to while held.
            Offset = vector3(0.140,0.013,0.054),
            Rotation = vector3(0.0, 0.0, 0.0),
            CollectsKief = true,                    -- true = this grinder model has a kief screen and can collect kief. Set false for basic grinders.
        },
    },
    Items = {} -- Don't Touch (auto-filled from ItemGroups)
}
ExpandItemGroups(Config.Grinders)

-- =====================================================================
-- GROUND WEED
-- The item produced by grinding raw weed. Used in rolling and packing.
-- =====================================================================
Config.GroundWeed = {
    Item = 'ground_weed',            -- Inventory item name produced by grinding.
    BonusMult = 1.1,                 -- Effectiveness multiplier vs raw bud.
    Label = "Ground Weed",
    Description = "Finely ground flower, ready to roll"
}

-- =====================================================================
-- HASHISH
-- Compressed weed product. Stronger than flower. Can be mixed into
-- rolls or packed into bongs/pipes.
-- =====================================================================
Config.Hashish = {
    RequiresTobacco = true,          -- true = hash can't be rolled alone, needs tobacco to burn properly.
    BongCompatible = true,           -- true = hash can be packed into bongs (uses HashBowlProp from bongs.lua).
    Items = {
        ['dc_hashish'] = {
            Label = "Hashish Block",
            GramsPerBlock = 3.5,     -- How many grams of hash each block contains.
            Stats = { Stress = 25, Armor = 5, High = 45 }   -- Effects per hit when smoked in a roll.
        },
    },
    BongStats = { Stress = 20, Armor = 10, High = 60 }      -- Override stats when hash is smoked through a bong (bongs hit harder).
}

-- =====================================================================
-- KIEF
-- Super-fine powder collected from the bottom of a grinder over time.
-- Extremely potent — used as an enhancer sprinkled on joints/bowls,
-- or pressed in bulk into hashish.
-- =====================================================================
Config.Kief = {
    Item = 'dc_kief',                -- Inventory item name for kief.
    CanTopBowl = true,               -- true = allow sprinkling kief on top of a packed bowl.
    CanSprinkleJoint = true,         -- true = allow sprinkling kief into a joint/blunt being rolled.
    CanPressToHash = true,           -- true = allow pressing kief into hashish (see KiefPerPress below).
    BonusMultiplier = 1.3,           -- Effect multiplier added to hits boosted with kief. 1.3 = 30% stronger.
    MaxPerSprinkle = 0.5,            -- Max grams of kief consumed per sprinkle action.
    MinimumHarvest = 0.01,           -- Minimum kief required before a grinder can dispense any.
    KiefPerPress = 5,                -- Grams of kief needed to press into one block of hashish.
    Items = {
        ['dc_kief'] = {
            Label = "Kief",
            Description = "Concentrated trichomes"
        }
    }
}

-- =====================================================================
-- MIXING RECIPES
-- Named recipes used by a few specific rolling flows (spliff, grabba,
-- hash spliff). The generic "mixing engine" (see mixing_engine.lua)
-- handles most rolls dynamically based on components; this table only
-- defines the hardcoded special combos.
--
-- Each recipe:
--   Label               = shown to player in menus
--   Description         = menu tooltip
--   Ingredients         = required inventory items and amounts
--   Result              = the inventory item produced
--   MinGrams/MaxGrams   = the range of weed grams the result can hold
--   RequiresHashAmount  = (optional) grams of hash required per use
--   ResultAmount        = (optional) how many of Result are produced
-- =====================================================================
Config.Mixing = {
    Enabled = true,

    Recipes = {
        ['spliff'] = {
            Label = "Roll Spliff",
            Description = "Joint with tobacco mixed in",
            Ingredients = {
                { item = 'dc_rollingpaper', amount = 1 },
                { item = 'dc_loosetobacco', amount = 1 }
            },
            Result = 'rolled_spliff',
            MinGrams = 0.5,
            MaxGrams = 1.5
        },
        ['grabba_blunt'] = {
            Label = "Roll Grabba Blunt",
            Description = "Weed wrapped in grabba leaf",
            Ingredients = {
                { item = 'dc_grabba', amount = 1 }
            },
            Result = 'rolled_woodleaf',
            MinGrams = 1.0,
            MaxGrams = 3.0
        },
        ['hash_spliff'] = {
            Label = "Roll Hash Spliff",
            Description = "Hashish mixed with tobacco",
            Ingredients = {
                { item = 'dc_rollingpaper', amount = 1 },
                { item = 'dc_loosetobacco', amount = 1 },
                { item = 'dc_hashish', amount = 1 }
            },
            Result = 'rolled_hash_spliff',
            RequiresHashAmount = 0.5
        },
        ['press_kief'] = {
            Label = "Press Kief to Hash",
            Description = "Compress kief into hashish",
            Ingredients = {
                { item = 'dc_kief', amount = 5 }
            },
            Result = 'dc_hashish',
            ResultAmount = 1
        }
    }
}

-- =====================================================================
-- MIXING COMPONENTS
-- Registry of every item that can be loaded into the mixing engine,
-- with its role and properties. The mixing engine uses Role to decide
-- what any combination of components produces.
--   Role: 'weed' | 'tobacco' | 'wrapper' | 'enhancer' | 'additive'
--   Harshness       = how rough the smoke feels (0-1)
--   BurnStability   = how evenly it burns (0-1)
--   CanWrap         = true if this component can serve as a wrapper
--   OutputCategory  = which wrapper category it produces when used as a wrap
--   BonusMult       = effect multiplier when this component is in the mix
--   ConsumeGrams    = grams consumed per use (for metadata-tracked items)
--   FromMeta        = which metadata field to read amount from ('amount', etc.)
--   Stats           = per-hit effect values (for additives)
--   NeedsCarrier    = true if this can't burn alone (hash needs tobacco/weed)
-- =====================================================================
Config.Components = {
    ['ground_weed']          = { Role = 'weed', Label = 'Ground Flower',      Strain = 'fromMeta',        GramsPerUnit = 1.0, BonusMult = 1.1 },
    ['dc_loosetobacco']  = { Role = 'tobacco', Label = 'Loose Tobacco',    Harshness = 0.3, BurnStability = 0.2 },
    ['dc_smackaleaf_s']  = { Role = 'tobacco', Label = 'Smacka Leaf',      Harshness = 0.25, BurnStability = 0.25, CanWrap = true, OutputCategory = 'smackaleaf' },
    ['dc_frontoleaf_s']  = { Role = 'tobacco', Label = 'Fronto Leaf Wrap', Harshness = 0.25, BurnStability = 0.25, CanWrap = true, OutputCategory = 'frontoleaf' },
    ['dc_kief'] = { Role = 'enhancer', Label = 'Kief', BonusMult = 1.3, ConsumeGrams = 0.5, FromMeta = 'amount' },
    ['dc_hashish']      = { Role = 'additive', Label = 'Hashish',       Stats = { Stress = 25, Armor = 5, High = 45 }, NeedsCarrier = true },
}

-- =====================================================================
-- MIX RULES
-- Tells the mixing engine what combinations are valid and what they
-- produce. Most players never need to edit this — only touch it if
-- you're adding brand new component types or output items.
-- =====================================================================
Config.MixRules = {
    -- Compatibility: which role can be paired with which. If a combo's roles aren't listed here, the engine rejects the mix.
    Compatibility = {
        weed       = { 'wrapper', 'tobacco', 'enhancer', 'additive' },
        additive   = { 'wrapper', 'tobacco', 'weed' },
        tobacco    = { 'wrapper', 'weed', 'additive' },
        wrapper    = { 'weed', 'tobacco', 'additive', 'enhancer' },
        enhancer   = { 'wrapper', 'weed' },
    },

    -- Requirements: named rules the mix must pass, with custom error messages shown to the player on failure.
    Requirements = {
        { rule = 'needsWrapper',       message = 'You need a wrapper to roll!' },
        { rule = 'needsFillable',      message = 'You need something to put inside!' },
        { rule = 'additiveNeedsCarrier', message = 'Hash burns poorly alone — add weed or tobacco!' },
        { rule = 'withinCapacity',     message = 'Too much material for this wrapper!' },
    },

    -- OutputItems: which inventory item is produced by each wrapper category.
    OutputItems = {
        joint      = 'rolled_joint',
        blunt      = 'rolled_blunt',
        leaf       = 'rolled_woodleaf',
        smackaleaf = 'rolled_smackaleaf',
        frontoleaf = 'rolled_frontoleaf',
    },

    -- OutputLabels: player-facing name for each output item.
    OutputLabels = {
        rolled_joint       = 'Rolled Joint',
        rolled_blunt       = 'Rolled Blunt',
        rolled_woodleaf    = 'Rolled Woodleaf',
        rolled_smackaleaf  = 'Rolled Smacka Leaf',
        rolled_frontoleaf  = 'Rolled Fronto Leaf',
        rolled_spliff      = 'Rolled Spliff',
        rolled_hash_spliff = 'Rolled Hash Spliff',
    },

    -- OutputOverrides: specific role/wrapper combinations that produce a special output item instead of the default.
    -- Evaluated top-to-bottom; the first match wins.
    OutputOverrides = {
        { roles = { 'weed', 'additive', 'tobacco', 'wrapper' }, wrapperCat = 'joint', output = 'rolled_hash_spliff' },
        { roles = { 'additive', 'tobacco', 'wrapper' },         wrapperCat = 'joint', output = 'rolled_hash_spliff' },
        { roles = { 'weed', 'tobacco', 'wrapper' },             wrapperCat = 'joint', output = 'rolled_spliff' },
    },

    -- Formulas: numeric tuning for the mixing engine.
    Formulas = {
        AdditiveSoloFailureChance = 0.15,   -- Chance a "solo" additive (hash without carrier) fails even if allowed. 0.15 = 15%.
        TobaccoHighReduction = 0.7,         -- Multiplier on the High stat when tobacco is in the mix. 0.7 = 30% less high.
        TobaccoStressBonus = 15,            -- Extra flat stress reduction added per hit when tobacco is in the mix.
    },
}

-- =====================================================================
-- MOISTURE
-- Weed dries out over time. Fresh weed burns slow and smooth; old weed
-- burns faster and harsher.
-- =====================================================================
Config.Moisture = {
    Enabled = true,
    FreshWindowSeconds = 300,       -- Seconds after a roll is made where it's considered "fresh" with no penalty. 300 = 5 minutes.
    MaxAgeSeconds = 7200,           -- Seconds after which the weed is fully dried out (maximum dryness penalty). 7200 = 2 hours.
    DryBurnRateMultiplier = 1.4,    -- Burn rate multiplier when fully dried. 1.4 = burns 40% faster than fresh.
    DryHarshnessBonus = 0.15,       -- Extra harshness added when fully dried (0-1 scale).
}

-- =====================================================================
-- GRIND QUALITY
-- Grinders can produce different grind textures. Finer grinds burn
-- better and yield more kief but feel less "raw."
-- =====================================================================
Config.GrindQuality = {
    Enabled = true,
    -- Each tier:
    --   BonusMult     = effectiveness multiplier vs base ground weed
    --   HarshnessAdd  = flat harshness change (negative = smoother)
    --   KiefYieldMult = multiplier on kief collected while grinding
    Tiers = {
        ['coarse'] = { BonusMult = 1.0,  HarshnessAdd = 0.1,  KiefYieldMult = 0.7, Label = 'Coarse Grind' },
        ['medium'] = { BonusMult = 1.1,  HarshnessAdd = 0.0,  KiefYieldMult = 1.0, Label = 'Medium Grind' },
        ['fine']   = { BonusMult = 1.15, HarshnessAdd = -0.05, KiefYieldMult = 1.3, Label = 'Fine Grind' },
    },
    DefaultTier = 'medium',   -- Which tier new grinds default to.
}
