-- =====================================================================
-- PACKS
-- Multi-item containers that hold a fixed number of singles (cigarettes,
-- leaf wraps, rolling papers, etc.). Players open a pack to take one
-- out; the pack tracks how many are left until empty.
-- =====================================================================
Config.Packs = {
    -- DefaultAnim: fallback animations used when opening/pulling from a pack.
    -- Each pack group can override these in its own block if needed.
    DefaultAnim = {
        GrabPack     = { Dict = "dc@pack", Anim = "packgrab_c",     Duration = 2000 },  -- Taking the pack out of a pocket.
        Idle         = { Dict = "dc@pack", Anim = "packhold_c",     Flag = 49 },        -- Holding the pack.
        GrabFromPack = { Dict = "dc@pack", Anim = "grabfrompack_c", Duration = 6900 },  -- Pulling a single item out of the pack.
    },
    -- ItemGroups: groups of packs that share settings.
    -- ItemInfo fields:
    --   Name     = inventory item name of the pack
    --   Prop     = 3D model of the pack
    --   Label    = player-facing name
    --   GiveItem = the item name handed to the player when they pull one out (e.g. 'dc_leaf' = a blank leaf wrap)
    ItemGroups = {
        {
            ItemInfo = {
                { Name = 'dc_woodleafaroma', Prop = 'dc_woodleafaroma', Label = 'Woodleaf Aromatic', GiveItem = 'dc_leaf' },
                { Name = 'dc_woodleafcream', Prop = 'dc_woodleafcream', Label = 'Woodleaf Cream', GiveItem = 'dc_leaf' },
                { Name = 'dc_woodleafdark', Prop = 'dc_woodleafdark', Label = 'Woodleaf Dark', GiveItem = 'dc_leaf' },
                { Name = 'dc_woodleafdarksweet', Prop = 'dc_woodleafdarksweet', Label = 'Woodleaf Dark Sweet', GiveItem = 'dc_leaf' },
                { Name = 'dc_woodleafhoney', Prop = 'dc_woodleafhoney', Label = 'Woodleaf Honey', GiveItem = 'dc_leaf' },
                { Name = 'dc_woodleaforiginal', Prop = 'dc_woodleaforiginal', Label = 'Woodleaf Original', GiveItem = 'dc_leaf' },
                { Name = 'dc_woodleafsweetberry', Prop = 'dc_woodleafsweetberry', Label = 'Woodleaf Sweet Berry', GiveItem = 'dc_leaf' },
                { Name = 'dc_woodleafsweethoney', Prop = 'dc_woodleafsweethoney', Label = 'Woodleaf Sweet Honey', GiveItem = 'dc_leaf' },
                { Name = 'dc_woodleafvanilla', Prop = 'dc_woodleafvanilla', Label = 'Woodleaf Vanilla', GiveItem = 'dc_leaf' },
            },
            Capacity = 5,               -- Max singles the pack can hold.
            StartAmount = 5,            -- How many singles a fresh pack starts with.
            Smokeable = false,          -- true if the pack itself is smokable (e.g. pre-rolled pack). false = the pack only gives you its singles.
            WrapperType = "leaf",       -- What type of wrap the singles count as (used by rolling.lua to pick the right recipe).
            Bone = 57005,
            Offset = vector3(0.162, 0.035, -0.039),
            Rotation = vector3(-66.3, 45.9, 20.8),
            OpenSequence = {
                AttachPackAt = 1300,
            },
            GrabSequence = {
                AttachSingleAt = 1820,
                DeletePackAt = 3940,
                SingleProp = {
                    Model = "dc_leaf_empty",
                    Bone = 26610,
                    Offset = vector3(0.115, -0.020, -0.011),
                    Rotation = vector3(64.1, 5.6, -176.9),
                    TransferAt = 5320,
                    TransferBone = 58866,
                    TransferOffset = vector3(0.116, -0.036, 0.008),
                    TransferRotation = vector3(-125.6, 41.4, 28.1),
                },
                HoldAnim = { Dict = "dc@handsmoke", Anim = "handsmokehold_c", Flag = 49 },
            },
        },
        {
            ItemInfo = {
                { Name = 'dc_frontoleaf', Prop = 'dc_naturalfronto', Label = 'Fronto Leaf', GiveItem = 'dc_frontoleaf_s' },
            },
            Capacity = 5,               -- Max singles the pack can hold.
            StartAmount = 5,            -- How many singles a fresh pack starts with.
            Smokeable = false,          -- true if the pack itself is smokable (e.g. pre-rolled pack). false = the pack only gives you its singles.
            WrapperType = "leaf",       -- What type of wrap the singles count as (used by rolling.lua to pick the right recipe).
            Bone = 57005,
            Offset = vector3(0.162, 0.035, -0.039),
            Rotation = vector3(-66.3, 45.9, 20.8),
            OpenSequence = {
                AttachPackAt = 1300,
            },
            GrabSequence = {
                AttachSingleAt = 1820,
                DeletePackAt = 3940,
                SingleProp = {
                    Model = "dc_frontoleaf_s",
                    Bone = 26610,
                    Offset = vector3(0.117,-0.028,-0.006),
                    Rotation = vector3(-141.5,-10.3,28.6),
                    TransferAt = 5320,
                    TransferBone = 58866,
                    TransferOffset = vector3(0.112,-0.040,0.002),
                    TransferRotation = vector3(-53.5,48.6,19.2),
                },
                HoldAnim = { Dict = "dc@handsmoke", Anim = "handsmokehold_c", Flag = 49 },
            },
        },
        {
            ItemInfo = {
                { Name = 'dc_smackaleaf', Prop = 'dc_smackaleaf', Label = 'Smacka Leaf', GiveItem = 'dc_smackaleaf_s' },
            },
            Capacity = 5,               -- Max singles the pack can hold.
            StartAmount = 5,            -- How many singles a fresh pack starts with.
            Smokeable = false,          -- true if the pack itself is smokable (e.g. pre-rolled pack). false = the pack only gives you its singles.
            WrapperType = "leaf",       -- What type of wrap the singles count as (used by rolling.lua to pick the right recipe).
            Bone = 57005,
            Offset = vector3(0.162, 0.035, -0.039),
            Rotation = vector3(-66.3, 45.9, 20.8),
            OpenSequence = {
                AttachPackAt = 1300,
            },
            GrabSequence = {
                AttachSingleAt = 1820,
                DeletePackAt = 3940,
                SingleProp = {
                    Model = "dc_smackaleaf_s",
                    Bone = 26610,
                    Offset = vector3(0.117,-0.028,-0.006),
                    Rotation = vector3(-141.5,-10.3,28.6),
                    TransferAt = 5320,
                    TransferBone = 58866,
                    TransferOffset = vector3(0.112,-0.040,0.002),
                    TransferRotation = vector3(-53.5,48.6,19.2),
                },
                HoldAnim = { Dict = "dc@handsmoke", Anim = "handsmokehold_c", Flag = 49 },
            },
        },
        {
            ItemInfo = {
                { Name = 'dc_smacknwildpack', Prop = 'dc_wildmildspack', Label = 'Smack n Wilds', GiveItem = 'dc_smacknwild' },
            },
            Capacity = 5,
            StartAmount = 5,
            Smokeable = true,
            Bone = 57005,
            Offset = vector3(0.162, 0.035, -0.039),
            Rotation = vector3(-66.3, 45.9, 20.8),
            OpenSequence = {
                AttachPackAt = 1300,
            },
            GrabSequence = {
                AttachSingleAt = 1350,
                DeletePackAt = 3940,
                RemoveContentPropAt = 1350,
                SingleProp = {
                    Model = "dc_black100",
                    Bone = 26610,
                    Offset = vector3(0.118, -0.033, 0.004),
                    Rotation = vector3(-45.0, -17.9, -19.1),
                    TransferAt = 5320,
                    TransferBone = 58866,
                    TransferOffset = vector3(0.125, -0.033, -0.001),
                    TransferRotation = vector3(16.1, 18.9, 4.5),
                },
                HoldAnim = { Dict = "dc@handsmoke", Anim = "handsmokehold_c", Flag = 49 },
            },
        },
        {
            ItemInfo = {
                { Name = 'dc_bluecigpack', Label = 'Menthol Blue', Image = 'dc_bluecigpack', GiveItem = 'dc_bluecig', ClosedProp = 'dc_bluecigclosed', OpenProp = 'dc_bluecigopen' },
                { Name = 'dc_goldcigpack', Label = 'Gold', Image = 'dc_goldcigpack', GiveItem = 'dc_goldcig', ClosedProp = 'dc_goldcigclosed', OpenProp = 'dc_goldcigopen' },
                { Name = 'dc_greencigpack', Label = 'Menthol Green', Image = 'dc_greencigpack', GiveItem = 'dc_greencig', ClosedProp = 'dc_greencigclosed', OpenProp = 'dc_greencigopen' },
                { Name = 'dc_redcigpack', Label = 'Red', Image = 'dc_redcigpack', GiveItem = 'dc_redcig', ClosedProp = 'dc_redcigclosed', OpenProp = 'dc_redcigopen' },
                { Name = 'dc_silvercigpack', Label = 'Silver', Image = 'dc_silvercigpack', GiveItem = 'dc_silvercig', ClosedProp = 'dc_silvercigclosed', OpenProp = 'dc_silvercigopen' },
            },
            Capacity = 20,
            StartAmount = 20,
            Smokeable = true,
            Bone = 58866,
            Offset = { Closed = vector3(0.122, 0.002, 0.026), Open = vector3(0.120, -0.006, 0.040) },
            Rotation = { Closed = vector3(57.6, -15.3, -178.3), Open = vector3(57.6, -15.3, -178.3) },
            OpenSequence = {
                AttachPackAt = 1500,
                SwapToOpenAt = 2000,
            },
            ContentModel = "dc_cig100",
            ContentProps = {
                { Offset = vector3(-0.0240, -0.0252, 0.0031), Rotation = vector3(90.0000, 0.0, 0.0) },   
                { Offset = vector3(-0.0240, -0.0170, 0.0031), Rotation = vector3(90.0, 0.0, 0.0) },  
                { Offset = vector3(-0.0204, -0.0085, 0.0031), Rotation = vector3(90.0, 0.0, 0.0) },   
                { Offset = vector3(-0.0169, -0.0252, 0.0031), Rotation = vector3(90.0, 0.0, 0.0) },   
                { Offset = vector3(-0.0169, -0.0170, 0.0031), Rotation = vector3(90.0, 0.0, 0.0) },   
                { Offset = vector3(-0.0133, -0.0085, 0.0031), Rotation = vector3(90.0, 0.0, 0.0) },   
                { Offset = vector3(-0.0089, -0.0252, 0.0031), Rotation = vector3(90.0, 0.0, 0.0) },  
                { Offset = vector3(-0.0089, -0.0170, 0.0031), Rotation = vector3(90.0, 0.0, 0.0) },  
                { Offset = vector3(-0.0053, -0.0085, 0.0031), Rotation = vector3(90.0, 0.0, 0.0) },
                { Offset = vector3(-0.0012, -0.0252, 0.0031), Rotation = vector3(90.0, 0.0, 0.0) }, 
                { Offset = vector3(-0.0012, -0.0170, 0.0031), Rotation = vector3(90.0, 0.0, 0.0) },
                { Offset = vector3(0.0024, -0.0085, 0.0031), Rotation = vector3(90.0, 0.0, 0.0) },
                { Offset = vector3(0.0067, -0.0252, 0.0031), Rotation = vector3(90.0, 0.0, 0.0) },
                { Offset = vector3(0.0067, -0.0170, 0.0031), Rotation = vector3(90.0, 0.0, 0.0) }, 
                { Offset = vector3(0.0103, -0.0085, 0.0031), Rotation = vector3(90.0, 0.0, 0.0) },
                { Offset = vector3(0.0153, -0.0252, 0.0031), Rotation = vector3(90.0, 0.0, 0.0) }, 
                { Offset = vector3(0.0153, -0.0170, 0.0031), Rotation = vector3(90.0, 0.0, 0.0) }, 
                { Offset = vector3(0.0189, -0.0085, 0.0031), Rotation = vector3(90.0, 0.0, 0.0) },
                { Offset = vector3(0.0239, -0.0252, 0.0031), Rotation = vector3(90.0, 0.0, 0.0) }, 
                { Offset = vector3(0.0239, -0.0170, 0.0031), Rotation = vector3(90.0, 0.0, 0.0) }, 
            },
            GrabSequence = {
                AttachSingleAt = 1350,
                DeletePackAt = 3940,
                RemoveContentPropAt = 1350,
                SingleProp = {
                    Model = "dc_cig100",
                    Bone = 26610,
                    Offset = vector3(0.118, -0.033, 0.004),
                    Rotation = vector3(-45.0, -17.9, -19.1),
                    TransferAt = 5320,
                    TransferBone = 58866,
                    TransferOffset = vector3(0.125, -0.033, -0.001),
                    TransferRotation = vector3(16.1, 18.9, 4.5),
                },
                HoldAnim = { Dict = "dc@handsmoke", Anim = "handsmokehold_c", Flag = 49 },
            },
        },
        {
            ItemInfo = {
                { Name = 'dc_cigarbox', Label = 'Cigar Box', Image = 'dc_cigarbox', GiveItem = 'dc_cigar', ClosedProp = 'dc_cigarbox_closed', OpenProp = 'dc_cigarbox' },
            },
            Capacity = 7,
            StartAmount = 7,
            Smokeable = true,
            Bone = 18905,
            Offset = { Closed = vector3(0.0, 0.0, 0.0), Open = vector3(0.218, -0.006, 0.096) },
            Rotation = { Closed = vector3(0.0, 0.0, 0.0), Open = vector3(7.2, -14.4, -95.5) },
            Animations = {
                GrabPack     = { Dict = "dc@cigarpack1", Anim = "grabpack_c",  Duration = 3000, BlendIn = 2.0, BlendOut = -1.0 },
                Idle         = { Dict = "dc@cigarpack1", Anim = "grabpackhold_c", Flag = 49, BlendIn = 2.0, BlendOut = -1.0 },
                GrabFromPack = { Dict = "dc@cigarpack2", Anim = "grabcigar_c", Duration = 3800, BlendIn = 2.0, BlendOut = -1.0 },
            },
            OpenSequence = {
                AttachPackAt = 2000,
                SwapToOpenAt = 2300,
            },
            ContentModel = "dc_cigar100",
            ContentProps = {
                { Offset = vector3(-0.0762, -0.0521, -0.0559), Rotation = vector3(0.0000, -0.0000, 0.0000) },
                { Offset = vector3(-0.0512, -0.0521, -0.0559), Rotation = vector3(0.0000, -0.0000, 0.0000) },
                { Offset = vector3(-0.0262, -0.0521, -0.0559), Rotation = vector3(0.0000, -0.0000, 0.0000) },
                { Offset = vector3(-0.0012, -0.0521, -0.0559), Rotation = vector3(0.0000, -0.0000, 0.0000) },
                { Offset = vector3(0.0238, -0.0521, -0.0559), Rotation = vector3(0.0000, -0.0000, 0.0000) },
                { Offset = vector3(0.0488, -0.0521, -0.0559), Rotation = vector3(0.0000, -0.0000, 0.0000) },
                { Offset = vector3(0.0738, -0.0521, -0.0559), Rotation = vector3(0.0000, -0.0000, 0.0000) },
            },
            GrabSequence = {
                AttachSingleAt = 1900,
                DeletePackAt = 3700,
                RemoveContentPropAt = 1900,
                SingleProp = {
                    Model = "dc_cigar100",
                    Bone = 58866,
                    Offset = vector3(0.114, -0.031, 0.014),
                    Rotation = vector3(33.2, 11.2, -16.5),
                },
                HoldAnim = { Dict = "dc@cigarsmoke", Anim = "cigarsmokehold_c", Flag = 49, BlendIn = 1.0, BlendOut = -1.0 },
            },
        },
        {
            ItemInfo = {
                { Name = 'dc_dootchberry', Prop = 'dc_dootchberry', Label = 'Dootch Berry', GiveItem = 'dc_blunt' },
                { Name = 'dc_dootchdream', Prop = 'dc_dootchdream', Label = 'Dootch Dream', GiveItem = 'dc_blunt' },
                { Name = 'dc_dootchgreen', Prop = 'dc_dootchgreen', Label = 'Dootch Green', GiveItem = 'dc_blunt' },
                { Name = 'dc_dootchhoney', Prop = 'dc_dootchhoney', Label = 'Dootch Honey', GiveItem = 'dc_blunt' },
                { Name = 'dc_dootchirish', Prop = 'dc_dootchirish', Label = 'Dootch Irish', GiveItem = 'dc_blunt' },
                { Name = 'dc_dootchjava', Prop = 'dc_dootchjava', Label = 'Dootch Java', GiveItem = 'dc_blunt' },
                { Name = 'dc_dootchmint', Prop = 'dc_dootchmint', Label = 'Dootch Mint', GiveItem = 'dc_blunt' },
                { Name = 'dc_dootchpurple', Prop = 'dc_dootchpurple', Label = 'Dootch Purple', GiveItem = 'dc_blunt' },
                { Name = 'dc_dootchred', Prop = 'dc_dootchred', Label = 'Dootch Red', GiveItem = 'dc_blunt' },
                { Name = 'dc_dootchsilver', Prop = 'dc_dootchsilver', Label = 'Dootch Silver', GiveItem = 'dc_blunt' },
            },
            Capacity = 2,
            StartAmount = 2,
            Smokeable = false,
            WrapperType = "blunt",
            Bone = 57005,
            Offset = vector3(0.162, 0.035, -0.039),
            Rotation = vector3(-66.3, 45.9, 20.8),
            OpenSequence = {
                AttachPackAt = 1300,
            },
            GrabSequence = {
                AttachSingleAt = 1820,
                DeletePackAt = 3940,
                SingleProp = {
                    Model = "dc_bluntempty",
                    Bone = 26610,
                    Offset = vector3(0.115, -0.020, -0.011),
                    Rotation = vector3(64.1, 5.6, -176.9),
                    TransferAt = 5320,
                    TransferBone = 58866,
                    TransferOffset = vector3(0.116, -0.036, 0.008),
                    TransferRotation = vector3(-125.6, 41.4, 28.1),
                },
                HoldAnim = { Dict = "dc@handsmoke", Anim = "handsmokehold_c", Flag = 49 },
            },
        },
        {
            ItemInfo = {
                { Name = 'dc_gameblackcherry', Prop = 'dc_gameblackcherry', Label = 'GameTime Black Cherry', GiveItem = 'dc_blunt' },
                { Name = 'dc_gameblue', Prop = 'dc_gameblue', Label = 'GameTime Blue', GiveItem = 'dc_blunt' },
                { Name = 'dc_gamediamond', Prop = 'dc_gamediamond', Label = 'GameTime Diamond', GiveItem = 'dc_blunt' },
                { Name = 'dc_gamegrape', Prop = 'dc_gamegrape', Label = 'GameTime Grape', GiveItem = 'dc_blunt' },
                { Name = 'dc_gamegreen', Prop = 'dc_gamegreen', Label = 'GameTime Green', GiveItem = 'dc_blunt' },
                { Name = 'dc_gamehoney', Prop = 'dc_gamehoney', Label = 'GameTime Honey', GiveItem = 'dc_blunt' },
                { Name = 'dc_gamemango', Prop = 'dc_gamemango', Label = 'GameTime Mango', GiveItem = 'dc_blunt' },
                { Name = 'dc_gamepineapple', Prop = 'dc_gamepineapple', Label = 'GameTime Pineapple', GiveItem = 'dc_blunt' },
                { Name = 'dc_gameredsweet', Prop = 'dc_gameredsweet', Label = 'GameTime Red Sweet', GiveItem = 'dc_blunt' },
                { Name = 'dc_gamesilver', Prop = 'dc_gamesilver', Label = 'GameTime Silver', GiveItem = 'dc_blunt' },
                { Name = 'dc_gamewhitegrape', Prop = 'dc_gamewhitegrape', Label = 'GameTime White Grape', GiveItem = 'dc_blunt' },
                { Name = 'dc_gamewhitepeach', Prop = 'dc_gamewhitepeach', Label = 'GameTime White Peach', GiveItem = 'dc_blunt' },
            },
            Capacity = 2,
            StartAmount = 2,
            Smokeable = false,
            WrapperType = "blunt",
            Bone = 57005,
            Offset = vector3(0.162, 0.035, -0.039),
            Rotation = vector3(-66.3, 45.9, 20.8),
            OpenSequence = {
                AttachPackAt = 1300,
            },
            GrabSequence = {
                AttachSingleAt = 1820,
                DeletePackAt = 3940,
                SingleProp = {
                    Model = "dc_bluntempty",
                    Bone = 26610,
                    Offset = vector3(0.115, -0.020, -0.011),
                    Rotation = vector3(64.1, 5.6, -176.9),
                    TransferAt = 5320,
                    TransferBone = 58866,
                    TransferOffset = vector3(0.116, -0.036, 0.008),
                    TransferRotation = vector3(-125.6, 41.4, 28.1),
                },
                HoldAnim = { Dict = "dc@handsmoke", Anim = "handsmokehold_c", Flag = 49 },
            },
        },
        {
            ItemInfo = {
                { Name = 'dc_paperisland', Prop = 'dc_paperisland', Label = 'Island Papers', GiveItem = 'dc_rollingpaper' },
                { Name = 'dc_papersogslim', Prop = 'dc_papersogslim', Label = 'OG Slim Papers', GiveItem = 'dc_rollingpaper' },
                { Name = 'dc_papersorganic', Prop = 'dc_papersorganic', Label = 'Organic Papers', GiveItem = 'dc_rollingpaper' },
                { Name = 'dc_papersorganicblack', Prop = 'dc_papersorganicblack', Label = 'Organic Black Papers', GiveItem = 'dc_rollingpaper' },
                { Name = 'dc_papersorganichemp', Prop = 'dc_papersorganichemp', Label = 'Organic Hemp Papers', GiveItem = 'dc_rollingpaper' },
            },
            Capacity = 32,
            StartAmount = 32,
            Smokeable = false,
            WrapperType = "joint",
            Bone = 57005,
            Offset = vector3(0.162, 0.035, -0.039),
            Rotation = vector3(-66.3, 45.9, 20.8),
            OpenSequence = {
                AttachPackAt = 1300,
            },
            GrabSequence = {
                AttachSingleAt = 1820,
                DeletePackAt = 3940,
                SingleProp = {
                    Model = "dc_joint_empty",
                    Bone = 26610,
                    Offset = vector3(0.115, -0.020, -0.011),
                    Rotation = vector3(64.1, 5.6, -176.9),
                    TransferAt = 5320,
                    TransferBone = 58866,
                    TransferOffset = vector3(0.116, -0.036, 0.008),
                    TransferRotation = vector3(-125.6, 41.4, 28.1),
                },
                HoldAnim = { Dict = "dc@handsmoke", Anim = "handsmokehold_c", Flag = 49 },
            },
        },
    },
    Items = {} -- Don't Touch (auto-filled from ItemGroups)
}
ExpandItemGroups(Config.Packs)