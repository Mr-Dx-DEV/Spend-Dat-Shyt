Config = Config or {}

-- ─── Arenas ─────────────────────────────────────────────────────────────────
-- Each arena defines its own spawns, boundaries, and atmosphere.
-- Server owners can add as many arenas as they want.
Config.Arenas = {
    boardwalk = {
        name = "Classic Arena",
        description = "Compact indoor arena with inflatable cover",
        image = "default",
        maxTeamSize = 4,  -- Compact map: 4v4 max (8 players total in TEAM/ELIM)
        center = vec3(141.0, -2927.0, 3.9),
        radius = 35.0,
        spawns = {
            RED = {
                vec4(135.637360, -2941.835205, 3.904053, 0.0),
                vec4(140.637360, -2941.861572, 3.904053, 0.0),
                vec4(146.665939, -2941.175781, 3.904053, 0.0),
                vec4(138.000000, -2942.500000, 3.904053, 355.0),
                vec4(143.500000, -2942.500000, 3.904053, 5.0),
                vec4(133.500000, -2940.500000, 3.904053, 10.0),
            },
            BLUE = {
                vec4(141.718689, -2912.993408, 3.904053, 175.748032),
                vec4(146.652756, -2913.202148, 3.904053, 172.913391),
                vec4(135.000000, -2913.320801, 3.904053, 170.078735),
                vec4(138.000000, -2912.000000, 3.904053, 175.0),
                vec4(143.500000, -2912.300000, 3.904053, 185.0),
                vec4(148.000000, -2914.000000, 3.904053, 165.0),
            },
        },
        spawnZones = {
            RED = { radius = 7.0 },
            BLUE = { radius = 7.0 },
        },
    },

    skyscraper = {
        name = "Big Map",
        description = "Large indoor arena with open lanes and barriers",
        image = "big_map",
        maxTeamSize = 6,  -- Large map: 6v6 max (12 players total in TEAM/ELIM)
        center = vec3(165.34, -3015.89, 829.95),
        radius = 35.0,
        loadCollisions = true,
        spawns = {
            RED = {
                vec4(155.0, -3030.0, 829.95, 0.0),
                vec4(165.0, -3032.0, 829.95, 350.0),
                vec4(175.0, -3030.0, 829.95, 10.0),
                vec4(160.0, -3033.5, 829.95, 355.0),
                vec4(170.0, -3033.0, 829.95, 5.0),
                vec4(150.0, -3031.0, 829.95, 15.0),
            },
            BLUE = {
                vec4(155.0, -3002.0, 829.95, 180.0),
                vec4(165.0, -3000.0, 829.95, 170.0),
                vec4(175.0, -3002.0, 829.95, 190.0),
                vec4(160.0, -2998.5, 829.95, 175.0),
                vec4(170.0, -2999.0, 829.95, 185.0),
                vec4(150.0, -3001.0, 829.95, 195.0),
            },
        },
        spawnZones = {
            RED = { radius = 7.0 },
            BLUE = { radius = 7.0 },
        },
    },
}

Config.DefaultArena = "boardwalk"

-- ─── Gameplay ───────────────────────────────────────────────────────────────
Config.Gameplay = {
    Weapon = `WEAPON_PAINTBALL`,
    MaxHitDistance = 65.0,
    HitCooldownMs = 1200,
    SpawnProtectionMs = 3000,
    MaxTeamSize = 6,
    MatchEndDelaySec = 15,
}

-- ─── Weapons ───────────────────────────────────────────────────────────────
-- Available weapons for lobby creation. Key is the identifier used in lobby data.
Config.Weapons = {
    { key = "paintball", hash = `WEAPON_PAINTBALL`,     ammo = 9999, name = "Paintball" },
    { key = "pistol",    hash = `WEAPON_PISTOL`,        ammo = 9999, name = "Pistol" },
    { key = "combat",    hash = `WEAPON_COMBATPISTOL`,  ammo = 9999, name = "Combat Pistol" },
    { key = "smg",       hash = `WEAPON_SMG`,           ammo = 9999, name = "SMG" },
    { key = "ar",        hash = `WEAPON_ASSAULTRIFLE`,  ammo = 9999, name = "Assault Rifle" },
    { key = "carbine",   hash = `WEAPON_CARBINERIFLE`,  ammo = 9999, name = "Carbine Rifle" },
    { key = "shotgun",   hash = `WEAPON_PUMPSHOTGUN`,   ammo = 9999, name = "Pump Shotgun" },
    { key = "sniper",    hash = `WEAPON_SNIPERRIFLE`,   ammo = 9999, name = "Sniper Rifle" },
}

-- ─── Lobby Defaults ─────────────────────────────────────────────────────────
Config.Defaults = {
    arena = Config.DefaultArena,
    mode = "TEAM",
    weapon = "paintball",
    teamSize = 3,
    target = 35,
    timeLimit = 600,
    nightMode = false,
    hardcore  = false,
    friendly  = false,
    autoStart = true,
}

-- ─── Gun Game ───────────────────────────────────────────────────────────────
Config.GunGame = {
    Weapons = {
        { hash = `WEAPON_KNIFE`,          ammo = 1,  name = "Knife" },
        { hash = `WEAPON_PISTOL`,         ammo = 12, name = "Pistol" },
        { hash = `WEAPON_COMBATPISTOL`,   ammo = 12, name = "Combat Pistol" },
        { hash = `WEAPON_SMG`,            ammo = 30, name = "SMG" },
        { hash = `WEAPON_ASSAULTRIFLE`,   ammo = 30, name = "Assault Rifle" },
        { hash = `WEAPON_CARBINERIFLE`,   ammo = 30, name = "Carbine Rifle" },
        { hash = `WEAPON_SNIPERRIFLE`,    ammo = 5,  name = "Sniper Rifle" },
        { hash = `WEAPON_PUMPSHOTGUN`,    ammo = 8,  name = "Pump Shotgun" },
        { hash = `WEAPON_KNIFE`,          ammo = 1,  name = "Final Knife" },
    },
}

-- ─── Wager / Economy ────────────────────────────────────────────────────────
Config.Wager = {
    enabled = true,
    min = 100,
    max = 50000,
}

-- ─── Medal / Streak System ──────────────────────────────────────────────────
Config.Medals = {
    multiKillWindow = 4000,  -- ms window for double/triple/multi kill
    streakLevels = { 3, 5, 7 },
}

-- ─── Interaction Point ──────────────────────────────────────────────────────
Config.InteractPoint = vec4(135.006592, -2956.377930, 6.189697, 269.291351)

-- ─── Blip ──────────────────────────────────────────────────────────────────
Config.Blip = {
    enabled = true,
    coords = vec3(146.04, -2955.03, 6.19),  -- same as join interact point
    sprite = 311,       -- paintball / target sprite
    color = 27,         -- purple
    scale = 0.5,
    name = "Paintball",
    shortRange = true,
}

-- ─── Target System Priority ─────────────────────────────────────────────────
-- Auto-detects in order. First found running resource wins.
Config.TargetPriority = { "ox_target", "qb-target", "Var-Interact", "fallback" }

-- ─── Team Uniforms ──────────────────────────────────────────────────────────
Config.TeamUniforms = {
    RED = {
        male = {
            components = {
                { component = 1,  drawable = 28, texture = 0 },
                { component = 3,  drawable = 17, texture = 0 },
                { component = 4,  drawable = 38, texture = 0 },
                { component = 6,  drawable = 27, texture = 0 },
                { component = 11, drawable = 65, texture = 0 },
            },
        },
        female = {
            components = {
                { component = 1,  drawable = 28, texture = 0 },
                { component = 3,  drawable = 17, texture = 0 },
                { component = 4,  drawable = 38, texture = 0 },
                { component = 6,  drawable = 27, texture = 0 },
                { component = 11, drawable = 65, texture = 0 },
            },
        },
    },
    BLUE = {
        male = {
            components = {
                { component = 1,  drawable = 28, texture = 0 },
                { component = 3,  drawable = 17, texture = 1 },
                { component = 4,  drawable = 38, texture = 1 },
                { component = 6,  drawable = 27, texture = 1 },
                { component = 11, drawable = 65, texture = 1 },
            },
        },
        female = {
            components = {
                { component = 1,  drawable = 28, texture = 0 },
                { component = 3,  drawable = 17, texture = 1 },
                { component = 4,  drawable = 38, texture = 1 },
                { component = 6,  drawable = 27, texture = 1 },
                { component = 11, drawable = 65, texture = 1 },
            },
        },
    },
}

-- ─── Discord Webhook ────────────────────────────────────────────────────────
Config.Discord = {
    enabled = false,
    webhook = "",  -- Paste your Discord webhook URL here
    botName = "Paintball",
    avatarUrl = "",
    color = 3447003,
}

return Config
