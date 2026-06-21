Config.ConfiguratorCommand = {
    enabled = true,
    oldESX = false, -- oldESX only for ESX which use essentialmode script.
    commandName = "houseconfigurator",
    helpLabel = "Configure enterPoint, loot, tenants for vms_houserobberies.",
    groups = "admin", -- for ESX examples: 'admin' or {'moderator', 'admin'}   |   for QB-Core examples: 'admin' (* On qb-core you can use only as string)
}

Config.ArrowSpeed = 0.005
Config.UpDownSpeed = 0.005
Config.HeadingSpeed = 10.0

Config.ConfiguratorKeys = {
    ["MENU_FOCUS"] = 205, -- [ Q ]

    ["FORWARD"] = 172, -- [ ARROW UP ]
    ["BACK"] = 173, -- [ ARROW DOWN ]
    ["LEFT"] = 174, -- [ ARROW LEFT ]
    ["RIGHT"] = 175, -- [ ARROW RIGHT ]
    ["UP"] = 83, -- [ - ]
    ["DOWN"] = 84, -- [ + ]
    ["ROTATE_LEFT"] = 15, -- [ SCROLL UP ]
    ["ROTATE_RIGHT"] = 14, -- [ SCROLL DOWN ]
    ["SLOW"] = 178, -- [ LEFT CTRL ]

    ["CANCEL"] = 215, -- [ ESC ]
    ["ACCEPT"] = 215, -- [ ENTER ]
}


Config.PedsList = {
    -- Male
    'g_m_importexport_01',
    'g_m_m_armlieut_01',
    'g_m_y_famfor_01',
    'g_m_y_lost_02',
    'g_m_y_salvaboss_01',
    'g_m_y_salvagoon_02',
    's_m_m_armoured_01',
    's_m_m_armoured_02',
    's_m_m_chemsec_01',
    's_m_m_fiboffice_01',
    's_m_m_fiboffice_02',
    's_m_m_highsec_01',
    's_m_m_highsec_02',
    's_m_y_casino_01',
    's_m_y_westsec_01',
    
    -- Female
    's_f_m_sweatshop_01',
    's_f_y_clubbar_01',
    's_f_y_movprem_01',
    's_f_y_shop_mid',
    'g_f_importexport_01',
    'g_f_y_vagos_01',
    'mp_f_execpa_01',
    'a_f_m_eastsa_02',
    'a_f_y_bevhills_01',
}

Config.WeaponsList = {
    -- Handguns:
    'weapon_pistol',
    'weapon_pistol_mk2',
    'weapon_combatpistol',
    'weapon_appistol',
    'weapon_pistol50',
    'weapon_snspistol',
    'weapon_snspistol_mk2',
    'weapon_heavypistol',
    'weapon_vintagepistol',
    'weapon_ceramicpistol',

    -- Submachine Guns:
    'weapon_microsmg',
    'weapon_smg',
    'weapon_smg_mk2',
    'weapon_combatpdw',
    'weapon_machinepistol',
    'weapon_minismg',
    
    -- Shotguns:
    'weapon_pumpshotgun',
    'weapon_pumpshotgun_mk2',
    'weapon_sawnoffshotgun',
    'weapon_dbshotgun',
    
    -- Assault Rifles:
    'weapon_assaultrifle',
    'weapon_assaultrifle_mk2',
    'weapon_carbinerifle',
    'weapon_carbinerifle_mk2',
    'weapon_specialcarbine',
    'weapon_specialcarbine_mk2',
    'weapon_bullpuprifle',
    'weapon_bullpuprifle_mk2',
    'weapon_compactrifle',
    'weapon_militaryrifle',
    'weapon_heavyrifle',
    'weapon_tacticalrifle',

    -- Light Machine Guns:
    'weapon_gusenberg',
}

Config.AnimationsList = {
    {'timetable@ron@ig_3_couch', 'base'},
    {'anim@amb@nightclub@lazlow@lo_sofa@', 'lowsofa_dlg_fuckedup_laz'}
}