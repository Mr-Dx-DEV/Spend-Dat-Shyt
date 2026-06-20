PropAttachConfig = {}
PropAttachConfig.Framework = "esx" -- "esx", "qb"
PropAttachConfig.OnlyAdmins = true
PropAttachConfig.Command = 'props'

-- UI Appearance & Controls
PropAttachConfig.TrimColor = "#3498db"
PropAttachConfig.MinimizeKey = "F6"

-- Preset Props
PropAttachConfig.Props = {
    -- === CIGARETTES ===
    'dc_cig100',
    'dc_cig100unlit',
    'dc_cig50unlit',
    'dc_cig25unlit',
    'dc_cig100lit',
    'dc_cig50lit',
    'dc_cig25lit',
    -- === BLACK & MILD ===
    'dc_black100',
    'dc_black100unlit',
    'dc_black50unlit',
    'dc_black25unlit',
    'dc_black100lit',
    'dc_black50lit',
    'dc_black25lit',
    'dc_cancerpaper',
    -- === CIGARS ===
    'dc_cigar100',
    'dc_cigar100unlit',
    'dc_cigar50unlit',
    'dc_cigar25unlit',
    'dc_cigar100lit',
    'dc_cigar50lit',
    'dc_cigar25lit',
    'dc_cigarcutter',
    -- === BACKWOODS ===
    'dc_leaf100',
    'dc_leaf100unlit',
    'dc_leaf50unlit',
    'dc_leaf25unlit',
    'dc_leaf100lit',
    'dc_leaf50lit',
    'dc_leaf25lit',
    -- === JOINTS ===
    'dc_joint100',
    'dc_joint100unlit',
    'dc_joint50unlit',
    'dc_joint25unlit',
    'dc_joint100lit',
    'dc_joint50lit',
    'dc_joint25lit',
    'dc_jointunlit',
    -- === BLUNTS ===
    'dc_blunt100',
    'dc_blunt100unlit',
    'dc_blunt50unlit',
    'dc_blunt25unlit',
    'dc_blunt100lit',
    'dc_blunt50lit',
    'dc_blunt25lit',
    'dc_blunt',
    -- === BONGS ===
    'dc_blackbong',
    -- === PIPES ===
    'dc_pipered',
    'prop_cs_crackpipe',
    -- === VAPES ===
    'dc_blackvape',
    -- === OIL CARTRIDGES ===
    'dc_oilcart_green',
    'dc_oilcart_purple',
    'dc_oilcart_white',
    -- === BAGS ===
    'dc_ak47bag',
    'dc_ogkushbag',
    'dc_weedbag_small',
    -- === PACKS ===
    'dc_smackwoodsbanana',
    'dc_bluecigclosed',
    'dc_bluecigopen',
    'dc_cigarbox',
    'dc_cigarbox_closed',
    'prop_cigar_pack_01',
    -- === ROLLING ===
    'dc_rollingpaper',
    -- === LIGHTERS ===
    'dc_lighterblack',
    'p_cs_lighter_01',
    -- === GRINDER ===
    'dc_grinderblack',
    -- === MISC ===
    'prop_cs_burger_01',
    'prop_ld_flow_bottle',
    'prop_amb_beer_bottle',
}

-- Preset Animations
PropAttachConfig.Animations = {
    -- === HAND SMOKE (Cigs, Joints, Backwoods, Spliffs) ===
    { label = 'Hand Smoke - Idle Hold',        dict = 'dc@handsmoke',    anim = 'handsmokehold_c',    flags = 49 },
    { label = 'Hand Smoke - Smoking',           dict = 'dc@handsmoke',    anim = 'handsmoke_c',        flags = 49 },
    { label = 'Hand Smoke - Ashing',            dict = 'dc@handsmoke',    anim = 'handsmokeash_c',     flags = 49 },
    { label = 'Hand Smoke - To/From Mouth',     dict = 'dc@handsmoke',    anim = 'handsmokemouth_c',   flags = 0  },
    { label = 'Hand Smoke - Lighting (Hand)',    dict = 'dc@lhs',          anim = 'lhs_c',              flags = 0  },
    { label = 'Hand Smoke - Lighting (Mouth)',   dict = 'dc@lhs',          anim = 'lms_c',              flags = 0  },
    -- === CIGARS ===
    { label = 'Cigar - Idle Hold',              dict = 'dc@cigarsmoke',    anim = 'cigarsmokehold_c',   flags = 49 },
    { label = 'Cigar - Smoking',                dict = 'dc@cigarsmoke',    anim = 'cigarsmoke_c',       flags = 49 },
    { label = 'Cigar - Ashing',                 dict = 'dc@cigarsmoke',    anim = 'cigarsmokeash_c',    flags = 49 },
    { label = 'Cigar - To/From Mouth',          dict = 'dc@cigarsmoke',    anim = 'cigarsmokemouth_c',  flags = 0  },
    { label = 'Cigar - Lighting',               dict = 'dc@cigarlight100', anim = 'cigarlight100_c',    flags = 0  },
    { label = 'Cigar - Lighting (Mouth)',        dict = 'dc@cigarlight100', anim = 'cigarlightmouth_c',  flags = 0  },
    { label = 'Cigar - Clip',                   dict = 'dc@cigarclip',     anim = 'cigarclip_c',        flags = 49 },
    -- === BLACK & MILD FREAK ===
    { label = 'Black & Mild - Freak',          dict = 'dc@freakblack',    anim = 'freakblack_c',       flags = 49 },
    -- === BLUNTS ===
    { label = 'Blunt - Hold',                  dict = 'dc@smokeblunthold', anim = 'smokeblunthold_clip', flags = 49 },
    { label = 'Blunt - Smoke',                 dict = 'dc@smokeblunt',    anim = 'smokeblunt_clip',    flags = 49 },
    { label = 'Blunt - Lighting',              dict = 'dc@lighting',      anim = 'lighting_clip',      flags = 0  },
    -- === BONGS ===
    { label = 'Bong - Idle Hold',              dict = 'dc@bong',          anim = 'bonghold_c',         flags = 49 },
    { label = 'Bong - Use/Smoke',              dict = 'dc@bong',          anim = 'bonguse_c',          flags = 0  },
    { label = 'Bong - Load',                   dict = 'dc@bongload',      anim = 'bongload_c',         flags = 0  },
    { label = 'Bong - Water Fill',             dict = 'dc@bongwater',     anim = 'bongwater_c',        flags = 0  },
    { label = 'Bong - Water Empty',            dict = 'dc@bongwater',     anim = 'bongwaterempty_c',   flags = 0  },
    { label = 'Bong - Hold (Legacy)',          dict = 'dc@bonganimhold',  anim = 'bonganimhold_clip',  flags = 49 },
    { label = 'Bong - Smoke (Legacy)',         dict = 'dc@bonganim',      anim = 'bonganim_clip',      flags = 49 },
    -- === VAPES ===
    { label = 'Vape - Idle Hold',              dict = 'dc@vapesmoke',     anim = 'vapesmokehold_c',    flags = 49 },
    { label = 'Vape - Smoke',                  dict = 'dc@vapesmoke',     anim = 'vapesmoke_c',        flags = 0  },
    { label = 'Vape - Load',                   dict = 'dc@vapeload',      anim = 'vapeload_c',         flags = 0  },
    { label = 'Vape - Smoke (Legacy)',         dict = 'dc@vape',          anim = 'vape_clip',          flags = 0  },
    -- === PIPES ===
    { label = 'Pipe - Idle Hold',              dict = 'dc@pipesmoke',     anim = 'pipesmokehold_c',    flags = 49 },
    { label = 'Pipe - Smoke',                  dict = 'dc@pipesmoke',     anim = 'pipesmoke_c',        flags = 0  },
    { label = 'Pipe - Load',                   dict = 'dc@pipeload',      anim = 'pipeload_c',         flags = 0  },
    -- === PACKS ===
    { label = 'Pack - Grab Item',              dict = 'dc@pack',          anim = 'packgrab_c',         flags = 0  },
    { label = 'Pack - Grab Pack',              dict = 'dc@pack',          anim = 'grabpack_c',         flags = 0  },
    { label = 'Pack - Idle Hold',              dict = 'dc@pack',          anim = 'packhold_c',         flags = 49 },
    { label = 'Pack - Grab From Pack',         dict = 'dc@pack',          anim = 'grabfrompack_c',     flags = 0  },
    -- === CIGAR PACK ===
    { label = 'Cigar Pack - Grab Pack',        dict = 'dc@cigarpack1',    anim = 'grabpack_c',         flags = 0  },
    { label = 'Cigar Pack - Idle Hold',        dict = 'dc@cigarpack1',    anim = 'grabpackhold_c',     flags = 49 },
    { label = 'Cigar Pack - Grab From Pack',   dict = 'dc@cigarpack2',    anim = 'grabcigar_c',        flags = 0  },
    -- === BAGS ===
    { label = 'Bag - Grab Weed',               dict = 'dc@grabweed',      anim = 'grabweed_clip',      flags = 0  },
    -- === ROLLING ===
    { label = 'Rolling - Roll Up',             dict = 'custom@rollingupanim', anim = 'rollingup_clip',  flags = 0  },
    -- === GRINDER ===
    { label = 'Grinder - Grind',               dict = 'anim@heists@fleeca_bank@ig_7_jetski_owner', anim = 'owner_idle', flags = 0 },
    -- === MISC ===
    { label = 'Eat Burger',                    dict = 'mp_player_inteat@burger', anim = 'mp_player_int_eat_burger', flags = 49 },
    { label = 'Drink Cup',                     dict = 'mp_player_intdrink', anim = 'loop_bottle',      flags = 49 },
    { label = 'Vape Charge Idle',              dict = 'amb@code_human_in_bus_passenger_idles@female@tablet@idle_a', anim = 'idle_a', flags = 0 },
}

-- Preset Bones
PropAttachConfig.Bones = {
    -- === HEAD & BODY ===
    { name = "Head",                id = 31086 },
    { name = "Neck",                id = 39317 },
    { name = "Mouth",              id = 47495 },
    { name = "Chest (Spine 3)",     id = 24818 },
    { name = "Stomach (Spine 2)",   id = 24817 },
    { name = "Pelvis",              id = 11816 },

    -- === RIGHT ARM & HAND ===
    { name = "Right Clavicle",      id = 10706 },
    { name = "Right Upper Arm",     id = 40269 },
    { name = "Right Forearm",       id = 28252 },
    { name = "Right Hand",          id = 57005 },

    -- === RIGHT FINGERS (Corrected IDs) ===
    { name = "R Thumb Base (00)",   id = 58866 },
    { name = "R Thumb Mid (01)",    id = 64016 },
    { name = "R Thumb Tip (02)",    id = 64017 },

    { name = "R Index Base (10)",   id = 58867 },
    { name = "R Index Mid (11)",    id = 64096 },
    { name = "R Index Tip (12)",    id = 64097 },

    { name = "R Middle Base (20)",  id = 58868 },
    { name = "R Middle Mid (21)",   id = 64112 },
    { name = "R Middle Tip (22)",   id = 64113 },

    { name = "R Ring Base (30)",    id = 58869 },
    { name = "R Ring Mid (31)",     id = 64064 },
    { name = "R Ring Tip (32)",     id = 64065 },

    { name = "R Pinky Base (40)",   id = 58870 },
    { name = "R Pinky Mid (41)",    id = 64080 },
    { name = "R Pinky Tip (42)",    id = 64081 },

    -- === LEFT ARM & HAND ===
    { name = "Left Clavicle",       id = 64729 },
    { name = "Left Upper Arm",      id = 45509 },
    { name = "Left Forearm",        id = 61163 },
    { name = "Left Hand",           id = 18905 },

    -- === LEFT FINGERS (Corrected IDs) ===
    { name = "L Thumb Base (00)",   id = 26610 },
    { name = "L Thumb Mid (01)",    id = 4089 },
    { name = "L Thumb Tip (02)",    id = 4090 },

    { name = "L Index Base (10)",   id = 26611 },
    { name = "L Index Mid (11)",    id = 4169 },
    { name = "L Index Tip (12)",    id = 4170 },

    { name = "L Middle Base (20)",  id = 26612 },
    { name = "L Middle Mid (21)",   id = 4185 },
    { name = "L Middle Tip (22)",   id = 4186 },

    { name = "L Ring Base (30)",    id = 26613 },
    { name = "L Ring Mid (31)",     id = 4137 },
    { name = "L Ring Tip (32)",     id = 4138 },

    { name = "L Pinky Base (40)",   id = 26614 },
    { name = "L Pinky Mid (41)",    id = 4153 },
    { name = "L Pinky Tip (42)",    id = 4154 },

    -- === LEGS & FEET ===
    { name = "Right Thigh",         id = 51826 },
    { name = "Right Calf",          id = 36864 },
    { name = "Right Foot",          id = 52301 },
    { name = "Right Toe",           id = 20781 },

    { name = "Left Thigh",          id = 58271 },
    { name = "Left Calf",           id = 63931 },
    { name = "Left Foot",           id = 14201 },
    { name = "Left Toe",            id = 2108 },
}
