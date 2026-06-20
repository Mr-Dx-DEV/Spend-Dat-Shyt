Config.Bags = {
    Animations = {
        GrabItem  = { Dict = "dc@pack", Anim = "packgrab_c", Duration = 1500, AttachPropAt = 800, Flag = 0 },   -- Pulling the bag out.
        Idle      = { Dict = "dc@pack", Anim = "packhold_c", Flag = 49 },                                       -- Holding the bag.
        -- GrabWeed: the two-handed animation of pulling a weed nug OUT of the bag, then transferring it to the other hand.
        GrabWeed  = {
            Dict = "dc@pack", Anim = "grabfrompack_c", Duration = 6900,
            DeleteBagAt = 3940,                                   -- ms into the anim when the bag disappears (player pocketed it).
            -- GrabProp: the weed nug that appears during the grab.
            GrabProp = {
                Model = "dc_weednug",
                Bone = 26610,                                     -- Starting bone (left hand — holding the bag).
                Offset = vector3(0.114,-0.021,-0.011),
                Rotation = vector3(-42.8,-0.0,0.0),
                AttachAt = 1309,                                  -- ms when the nug first appears in hand.
                TransferAt = 5320,                                -- ms when it moves from the grabbing hand to the display hand.
                TransferBone = 58866,                             -- Bone to move the nug to (right hand fingertip).
                TransferOffset = vector3(0.116,-0.036,0.008),
                TransferRotation = vector3(-125.6,41.4,28.1),
            },
            HoldAnim = { Dict = "dc@pack", Anim = "packhold_c", Flag = 49 },   -- Anim played after the grab completes.
        },
        -- TakeOut: anim used when the player takes weed out of the bag INTO their inventory (not rolling).
        -- Any field omitted here falls back to GrabWeed's value. Bag stays visible the whole time (no DeleteBagAt).
        TakeOut = {
            Duration = 2300,             -- Total anim length in ms. Shorter than GrabWeed since no pocketing step.
            AttachAt = 1309,             -- ms when the nug first appears in grabbing hand.
            --TransferAt = 3500,           -- ms when the nug moves to display hand.
        },
        -- PutIn: anim used when the player puts weed INTO the bag. No prop is spawned.
        -- Only Duration matters here — it's just the reach-in motion length.
        PutIn = {
            Duration = 1700,             -- ms. Short reach-in motion.
        },
    },
    -- ItemGroups: share settings (bone, offset, capacity) across all the different bag skins.
    -- ItemInfo fields:
    --   Name        = inventory item name
    --   Prop        = 3D model of the bag
    --   Label       = player-facing name
    --   StartItem   = the strain item name preloaded inside a fresh bag (e.g. 'ak47' = 7g of AK-47). Leave off for empty bags.
    --   StartAmount = how many grams are inside when the bag is first created.
    ItemGroups = {
        {
            ItemInfo = {
                { Name = 'dc_ak47bag', Prop = 'dc_ak47bag', Label = 'AK-47 Bag', StartItem = 'ak47', StartAmount = 7.0 },
                { Name = 'dc_ogkushbag', Prop = 'dc_ogkushbag', Label = 'OG Kush Bag', StartItem = 'ogkush', StartAmount = 7.0 },
                { Name = 'dc_applefritterbag', Prop = 'dc_applefritterbag', Label = 'Apple Fritter Bag', StartItem = 'applefritter', StartAmount = 7.0 },
                { Name = 'dc_applegelatobag', Prop = 'dc_applegelatobag', Label = 'Apple Gelato Bag', StartItem = 'applegelato', StartAmount = 7.0 },
                { Name = 'dc_appleruntzbag', Prop = 'dc_appleruntzbag', Label = 'Apple Runtz Bag', StartItem = 'appleruntz', StartAmount = 7.0 },
                { Name = 'dc_backpackbag', Prop = 'dc_backpackbag', Label = 'Backpack Bag' },
                { Name = 'dc_bananakushbag', Prop = 'dc_bananakushbag', Label = 'Banana Kush Bag', StartItem = 'bananakush', StartAmount = 7.0 },
                { Name = 'dc_biscottibag', Prop = 'dc_biscottibag', Label = 'Biscotti Bag', StartItem = 'biscotti', StartAmount = 7.0 },
                { Name = 'dc_blackicebag', Prop = 'dc_blackicebag', Label = 'Black Ice Bag', StartItem = 'blackice', StartAmount = 7.0 },
                { Name = 'dc_blueberrycruffbag', Prop = 'dc_blueberrycruffbag', Label = 'Blueberry Cruff Bag', StartItem = 'blueberrycruff', StartAmount = 7.0 },
                { Name = 'dc_bluedreambag', Prop = 'dc_bluedreambag', Label = 'Blue Dream Bag', StartItem = 'bluedream', StartAmount = 7.0 },
                { Name = 'dc_bluetomyzbag', Prop = 'dc_bluetomyzbag', Label = 'Blue Tomyz Bag', StartItem = 'bluetomyz', StartAmount = 7.0 },
                { Name = 'dc_bluezlushiebag', Prop = 'dc_bluezlushiebag', Label = 'Blue Zlushie Bag', StartItem = 'bluezlushie', StartAmount = 7.0 },
                { Name = 'dc_bomptonberriesbag', Prop = 'dc_bomptonberriesbag', Label = 'Bompton Berries Bag', StartItem = 'bomptonberries', StartAmount = 7.0 },
                { Name = 'dc_bubbakushbag', Prop = 'dc_bubbakushbag', Label = 'Bubba Kush Bag', StartItem = 'bubbakush', StartAmount = 7.0 },
                { Name = 'dc_cakemixbag', Prop = 'dc_cakemixbag', Label = 'Cake Mix Bag', StartItem = 'cakemix', StartAmount = 7.0 },
                { Name = 'dc_cerealmilkbag', Prop = 'dc_cerealmilkbag', Label = 'Cereal Milk Bag', StartItem = 'cerealmilk', StartAmount = 7.0 },
                { Name = 'dc_cheetahpissbag', Prop = 'dc_cheetahpissbag', Label = 'Cheetah Piss Bag', StartItem = 'cheetahpiss', StartAmount = 7.0 },
                { Name = 'dc_cherryfritterbag', Prop = 'dc_cherryfritterbag', Label = 'Cherry Fritter Bag', StartItem = 'cherryfritter', StartAmount = 7.0 },
                { Name = 'dc_cherrygumbobag', Prop = 'dc_cherrygumbobag', Label = 'Cherry Gumbo Bag', StartItem = 'cherrygumbo', StartAmount = 7.0 },
                { Name = 'dc_collinsavebag', Prop = 'dc_collinsavebag', Label = 'Collins Ave Bag', StartItem = 'collinsave', StartAmount = 7.0 },
                { Name = 'dc_dankdoughbag', Prop = 'dc_dankdoughbag', Label = 'Dank Dough Bag', StartItem = 'dankdough', StartAmount = 7.0 },
                { Name = 'dc_etherbag', Prop = 'dc_etherbag', Label = 'Ether Bag', StartItem = 'ether', StartAmount = 7.0 },
                { Name = 'dc_finechinabag', Prop = 'dc_finechinabag', Label = 'Fine China Bag', StartItem = 'finechina', StartAmount = 7.0 },
                { Name = 'dc_fishscalebag', Prop = 'dc_fishscalebag', Label = 'Fish Scale Bag', StartItem = 'fishscale', StartAmount = 7.0 },
                { Name = 'dc_flowerpowerbag', Prop = 'dc_flowerpowerbag', Label = 'Flower Power Bag', StartItem = 'flowerpower', StartAmount = 7.0 },
                { Name = 'dc_frostiesbag', Prop = 'dc_frostiesbag', Label = 'Frosties Bag', StartItem = 'frosties', StartAmount = 7.0 },
                { Name = 'dc_garypaytonsbag', Prop = 'dc_garypaytonsbag', Label = 'Gary Payton Bag', StartItem = 'garypaytons', StartAmount = 7.0 },
                { Name = 'dc_gelatobag', Prop = 'dc_gelatobag', Label = 'Gelato Bag', StartItem = 'gelato', StartAmount = 7.0 },
                { Name = 'dc_gelattibag', Prop = 'dc_gelattibag', Label = 'Gelatti Bag', StartItem = 'gelatti', StartAmount = 7.0 },
                { Name = 'dc_georgiabag', Prop = 'dc_georgiabag', Label = 'Georgia Bag', StartItem = 'georgia', StartAmount = 7.0 },
                { Name = 'dc_girlscoutbag', Prop = 'dc_girlscoutbag', Label = 'Girl Scout Bag', StartItem = 'girlscout', StartAmount = 7.0 },
                { Name = 'dc_gmocookiesbag', Prop = 'dc_gmocookiesbag', Label = 'GMO Cookies Bag', StartItem = 'gmocookies', StartAmount = 7.0 },
                { Name = 'dc_gorillagluebag', Prop = 'dc_gorillagluebag', Label = 'Gorilla Glue Bag', StartItem = 'gorillaglue', StartAmount = 7.0 },
                { Name = 'dc_gumbobag', Prop = 'dc_gumbobag', Label = 'Gumbo Bag', StartItem = 'gumbo', StartAmount = 7.0 },
                { Name = 'dc_gushmintzbag', Prop = 'dc_gushmintzbag', Label = 'Gush Mintz Bag', StartItem = 'gushmintz', StartAmount = 7.0 },
                { Name = 'dc_icecreamcakebag', Prop = 'dc_icecreamcakebag', Label = 'Ice Cream Cake Bag', StartItem = 'icecreamcake', StartAmount = 7.0 },
                { Name = 'dc_jefebag', Prop = 'dc_jefebag', Label = 'Jefe Bag', StartItem = 'jefe', StartAmount = 7.0 },
                { Name = 'dc_khalifakushbag', Prop = 'dc_khalifakushbag', Label = 'Khalifa Kush Bag', StartItem = 'khalifakush', StartAmount = 7.0 },
                { Name = 'dc_laconfidentialbag', Prop = 'dc_laconfidentialbag', Label = 'LA Confidential Bag', StartItem = 'laconfidential', StartAmount = 7.0 },
                { Name = 'dc_lemonchellobag', Prop = 'dc_lemonchellobag', Label = 'Lemonchello Bag', StartItem = 'lemonchello', StartAmount = 7.0 },
                { Name = 'dc_lemoncherrybag', Prop = 'dc_lemoncherrybag', Label = 'Lemon Cherry Bag', StartItem = 'lemoncherry', StartAmount = 7.0 },
                { Name = 'dc_loundoncakebag', Prop = 'dc_loundoncakebag', Label = 'Loudon Cake Bag', StartItem = 'loundoncake', StartAmount = 7.0 },
                { Name = 'dc_marathonogbag', Prop = 'dc_marathonogbag', Label = 'Marathon OG Bag', StartItem = 'marathonog', StartAmount = 7.0 },
                { Name = 'dc_marshmallowogbag', Prop = 'dc_marshmallowogbag', Label = 'Marshmallow OG Bag', StartItem = 'marshmallowog', StartAmount = 7.0 },
                { Name = 'dc_mochibag', Prop = 'dc_mochibag', Label = 'Mochi Bag', StartItem = 'mochi', StartAmount = 7.0 },
                { Name = 'dc_moonrocksbag', Prop = 'dc_moonrocksbag', Label = 'Moon Rocks Bag', StartItem = 'moonrocks', StartAmount = 7.0 },
                { Name = 'dc_naterobinsonbag', Prop = 'dc_naterobinsonbag', Label = 'Nate Robinson Bag', StartItem = 'naterobinson', StartAmount = 7.0 },
                { Name = 'dc_northenlightsbag', Prop = 'dc_northenlightsbag', Label = 'Northern Lights Bag', StartItem = 'northenlights', StartAmount = 7.0 },
                { Name = 'dc_oreozbag', Prop = 'dc_oreozbag', Label = 'Oreoz Bag', StartItem = 'oreoz', StartAmount = 7.0 },
                { Name = 'dc_papplexpressbag', Prop = 'dc_papplexpressbag', Label = 'Pineapple Express Bag', StartItem = 'papplexpress', StartAmount = 7.0 },
                { Name = 'dc_pircklypearbag', Prop = 'dc_pircklypearbag', Label = 'Prickly Pear Bag', StartItem = 'pircklypear', StartAmount = 7.0 },
                { Name = 'dc_purplehazebag', Prop = 'dc_purplehazebag', Label = 'Purple Haze Bag', StartItem = 'purplehaze', StartAmount = 7.0 },
                { Name = 'dc_runtzogbag', Prop = 'dc_runtzogbag', Label = 'Runtz OG Bag', StartItem = 'runtzog', StartAmount = 7.0 },
                { Name = 'dc_snowmanbag', Prop = 'dc_snowmanbag', Label = 'Snowman Bag', StartItem = 'snowman', StartAmount = 7.0 },
                { Name = 'dc_sourdieselbag', Prop = 'dc_sourdieselbag', Label = 'Sour Diesel Bag', StartItem = 'sourdiesel', StartAmount = 7.0 },
                { Name = 'dc_tahoeogbag', Prop = 'dc_tahoeogbag', Label = 'Tahoe OG Bag', StartItem = 'tahoeog', StartAmount = 7.0 },
                { Name = 'dc_trainwreckbag', Prop = 'dc_trainwreckbag', Label = 'Trainwreck Bag', StartItem = 'trainwreck', StartAmount = 7.0 },
                { Name = 'dc_whitecherrygelbag', Prop = 'dc_whitecherrygelbag', Label = 'White Cherry Gelato Bag', StartItem = 'whitecherrygel', StartAmount = 7.0 },
                { Name = 'dc_whiteruntzbag', Prop = 'dc_whiteruntzbag', Label = 'White Runtz Bag', StartItem = 'whiteruntz', StartAmount = 7.0 },
                { Name = 'dc_whitwidowbag', Prop = 'dc_whitwidowbag', Label = 'White Widow Bag', StartItem = 'whitewidow', StartAmount = 7.0 },
                { Name = 'dc_ygogbag', Prop = 'dc_ygogbag', Label = 'YG OG Bag', StartItem = 'ygog', StartAmount = 7.0 },
                { Name = 'dc_zazitosbag', Prop = 'dc_zazitosbag', Label = 'Zazitos Bag', StartItem = 'zazitos', StartAmount = 7.0 },
                { Name = 'dc_zushibag', Prop = 'dc_zushibag', Label = 'Zushi Bag', StartItem = 'zushi', StartAmount = 7.0 },
            },
            Bone = 57005,                                -- Right hand — where the bag attaches while held.
            Offset = vector3(0.158,0.033,-0.052),        -- Fine-tune position in hand.
            Rotation = vector3(-43.1,56.9,39.6),         -- Rotation in degrees.
            MaxCapacity = 7.0,                           -- Grams the bag can hold. 7g = a standard eighth + change.
        },
        {
            -- Second group: the empty "generic" bag that can be filled with any strain.
            ItemInfo = {
                { Name = 'dc_empty_bag', Prop = 'dc_emptybagblack', Label = 'Empty Bag', StartItem = nil, StartAmount = 0.0, MaxCapacity = 7.0 },
            },
            Bone = 57005,
            Offset = vector3(0.158,0.033,-0.052),
            Rotation = vector3(-43.1,56.9,39.6),
        },
        {
            -- Third group: see-through clear bags. Nugs are spawned as dynamic content
            -- props attached to the bag, one per gram. Slot 1 = topmost nug (removed
            -- first), Slot 28 = bottommost nug (removed last).
            ItemInfo = {
                {
                    Name = 'dc_clearbag28', Prop = 'dc_clearbag28', Label = 'Clear Bag (28g)',
                    StartItem = nil, StartAmount = 0.0, MaxCapacity = 28.0,
                    ContentModel = 'dc_bagnug',
                    ContentProps = {
                        { Offset = vector3(-0.0502, 0.0056, 0.0289), Rotation = vector3(0.0000, -0.0000, 0.0000) },   -- Slot 1  (top of bag — removed first)
                        { Offset = vector3(-0.0159, 0.0049, 0.0293), Rotation = vector3(0.0000, -0.0000, 0.0000) },   -- Slot 2
                        { Offset = vector3(0.0005, -0.0109, 0.0306), Rotation = vector3(0.0000, -0.0000, 0.0000) },   -- Slot 3
                        { Offset = vector3(0.0198, 0.0112, 0.0338), Rotation = vector3(0.0000, -0.0000, 0.0000) },   -- Slot 4
                        { Offset = vector3(0.0542, -0.0009, 0.0339), Rotation = vector3(0.0000, -0.0000, 0.0000) },   -- Slot 5
                        { Offset = vector3(0.0165, -0.0141, 0.0339), Rotation = vector3(0.0000, -0.0000, 0.0000) },   -- Slot 6
                        { Offset = vector3(-0.0502, -0.0071, 0.0139), Rotation = vector3(0.0000, -0.0000, 0.0000) },   -- Slot 7
                        { Offset = vector3(-0.0159, 0.0049, 0.0143), Rotation = vector3(0.0000, -0.0000, 0.0000) },   -- Slot 8
                        { Offset = vector3(0.0005, -0.0109, 0.0156), Rotation = vector3(0.0000, -0.0000, 0.0000) },   -- Slot 9
                        { Offset = vector3(0.0345, 0.0049, 0.0143), Rotation = vector3(0.0000, -0.0000, 0.0000) },   -- Slot 10
                        { Offset = vector3(0.0509, -0.0109, 0.0156), Rotation = vector3(0.0000, -0.0000, 0.0000) },   -- Slot 11
                        { Offset = vector3(0.0542, -0.0009, -0.0024), Rotation = vector3(0.0000, -0.0000, 0.0000) },   -- Slot 12
                        { Offset = vector3(0.0165, -0.0141, -0.0024), Rotation = vector3(0.0000, -0.0000, 0.0000) },   -- Slot 13
                        { Offset = vector3(0.0165, 0.0102, -0.0024), Rotation = vector3(0.0000, -0.0000, 0.0000) },   -- Slot 14
                        { Offset = vector3(-0.0229, -0.0141, -0.0024), Rotation = vector3(0.0000, -0.0000, 0.0000) },   -- Slot 15
                        { Offset = vector3(-0.0229, 0.0102, -0.0024), Rotation = vector3(0.0000, -0.0000, 0.0000) },   -- Slot 16
                        { Offset = vector3(-0.0623, -0.0009, -0.0024), Rotation = vector3(0.0000, -0.0000, 0.0000) },   -- Slot 17
                        { Offset = vector3(-0.0502, -0.0071, -0.0233), Rotation = vector3(0.0000, -0.0000, 0.0000) },   -- Slot 18
                        { Offset = vector3(-0.0159, 0.0049, -0.0229), Rotation = vector3(0.0000, -0.0000, 0.0000) },   -- Slot 19
                        { Offset = vector3(0.0005, -0.0109, -0.0216), Rotation = vector3(0.0000, -0.0000, 0.0000) },   -- Slot 20
                        { Offset = vector3(0.0345, 0.0049, -0.0229), Rotation = vector3(0.0000, -0.0000, 0.0000) },   -- Slot 21
                        { Offset = vector3(0.0509, -0.0109, -0.0216), Rotation = vector3(0.0000, -0.0000, 0.0000) },   -- Slot 22
                        { Offset = vector3(0.0542, -0.0009, -0.0396), Rotation = vector3(0.0000, -0.0000, 0.0000) },   -- Slot 23
                        { Offset = vector3(0.0165, -0.0141, -0.0396), Rotation = vector3(0.0000, -0.0000, 0.0000) },   -- Slot 24
                        { Offset = vector3(0.0165, 0.0102, -0.0396), Rotation = vector3(0.0000, -0.0000, 0.0000) },   -- Slot 25
                        { Offset = vector3(-0.0229, -0.0141, -0.0396), Rotation = vector3(0.0000, -0.0000, 0.0000) },   -- Slot 26
                        { Offset = vector3(-0.0229, 0.0102, -0.0396), Rotation = vector3(0.0000, -0.0000, 0.0000) },   -- Slot 27
                        { Offset = vector3(-0.0623, -0.0009, -0.0396), Rotation = vector3(0.0000, -0.0000, 0.0000) },   -- Slot 28 (bottom of bag — removed last)
                    },
                },
            },
            Bone = 57005,
            Offset = vector3(0.172,0.035,-0.066),
            Rotation = vector3(-44.5,37.9,30.1),
        },
        {
            ItemInfo = {
                {
                    Name = 'dc_clearbag7', Prop = 'dc_clearbag7', Label = 'Clear Bag (7g)',
                    StartItem = nil, StartAmount = 0.0, MaxCapacity = 7.0,
                    ContentModel = 'dc_bagnug',
                    ContentProps = {
                        { Offset = vector3(0.0007, -0.0009, 0.0299), Rotation = vector3(0.0000, -0.0000, 7.2029) },   -- Slot 1
                        { Offset = vector3(0.0166, -0.0009, 0.0113), Rotation = vector3(0.0000, -0.0000, 7.2029) },   -- Slot 2
                        { Offset = vector3(-0.0130, -0.0009, 0.0113), Rotation = vector3(0.0000, -0.0000, 7.2029) },   -- Slot 3
                        { Offset = vector3(-0.0144, -0.0009, -0.0075), Rotation = vector3(0.0000, -0.0000, 7.2029) },   -- Slot 4
                        { Offset = vector3(0.0150, -0.0009, -0.0075), Rotation = vector3(0.0000, -0.0000, 7.2029) },   -- Slot 5
                        { Offset = vector3(0.0174, -0.0009, -0.0298), Rotation = vector3(0.0000, -0.0000, 0.0000) },   -- Slot 6
                        { Offset = vector3(-0.0195, -0.0009, -0.0298), Rotation = vector3(0.0000, -0.0000, 0.0000) },   -- Slot 7
                    },
                },
            },
            Bone = 57005,
            Offset = vector3(0.166,0.033,-0.051),
            Rotation = vector3(-52.2,30.6,17.8),
        },
    },
    Items = {} -- Don't Touch (auto-filled from ItemGroups)
}
ExpandItemGroups(Config.Bags)