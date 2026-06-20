Config = {}
Config.Version = "1.2.6" -- Don't change this, it is used for version checking and update notifications.

Config.DefaultVoice        = 'Normal'
Config.ShowStress          = true
Config.StressThreshold     = 5
Config.UpdateInterval      = 100
Config.MenuCommand            = 'hud'

-- ps-buffs integration
Config.UsePSBuffs            = false

-- Hide Minimap on foot
Config.HideMapAndStreetOnFoot = false

-- Redline threshold (percentage)
Config.RedlineThreshold = 85

-- jg-vehiclemileage integration
Config.JGMileage = false

-- Seatbelt settings
Config.EnableSeatbelt    = true -- do u even want to use our seatbelt? if not set it to false
Config.SeatbeltEject      = true
Config.SeatbeltEjectSpeed = 60.0
Config.SeatbeltBodyThresh = 500.0

-- Warning thresholds
Config.WarnHealth  = 20
Config.WarnHunger  = 15
Config.WarnThirst  = 15
Config.WarnFuel    = 10
Config.WarnEngine  = 20
Config.WarnAmmoClip = 5 -- ammo clip count below which the counter turns red

Config.Logo = {
    url            = 'https://r2.fivemanage.com/OsADTE00yxV0TMDjU6MqZ/logo.png',
    width          = 120,
    height         = 80,
    transparentBg  = true,
}

-- Weapon item images (don't touch unless you know what you're doing)
Config.InventoryImages = {
    autoDetect = true,
    inventories = {
        { resource = 'ox_inventory',   path = 'nui://ox_inventory/web/images/%s' },
        { resource = 'qb-inventory',   path = 'nui://qb-inventory/html/images/%s' },
        { resource = 'ps-inventory',   path = 'nui://ps-inventory/html/images/%s' },
        { resource = 'core_inventory', path = 'nui://core_inventory/html/img/%s' },
    }
}

-- Default component visibility for new players
Config.DefaultVisible = {
    portrait    = true,
    charname    = true,
    voice       = true,
    playerid    = true,
    job         = true,
    cash        = true,
    bank        = false,
    minimap       = true,
    minimapBorder = true,
    streetPill    = true,
    streetclock   = true,
    streetCompass = true,
    statusRow     = true,
    psBuffRow     = true,
    health      = true,
    armor       = true,
    hunger      = true,
    thirst      = true,
    vehicle     = true,
    lights      = true,
    cinebars    = false,
    logo        = true,
    weapon      = true,
}

-- Set a key to false to lock it server-side (players cannot toggle it via /hud).
-- Keys must match those in Config.DefaultVisible above.
Config.MenuOptions = {
    portrait    = true,
    charname    = true,
    voice       = true,
    playerid    = true,
    job         = true,
    cash        = true,
    bank        = false,
    minimap       = true,
    minimapBorder = true,
    streetPill    = true,
    streetclock   = true,
    streetCompass = true,
    statusRow     = true,
    psBuffRow     = true,
    health      = true,
    armor       = true,
    hunger      = true,
    thirst      = true,
    vehicle     = true,
    lights      = true,
    cinebars    = true,
    logo        = true,
    weapon      = true,
}

-- UI colours, injected into CSS as custom properties
Config.Colors = {
    -- Backgrounds (Black)
    panel          = 'rgba(12, 10, 16, 0.92)',
    panel2         = 'rgba(18, 14, 22, 0.96)',

    -- Borders
    border         = 'rgba(255, 255, 255, 0.08)',
    border2        = 'rgba(255, 255, 255, 0.15)',

    -- Text
    text           = '#FFFFFF',
    muted          = '#C8A2C8',

    -- Main Accent (Pink)
    accent         = '#FF1493',

    -- Money
    cash           = '#FF69B4',
    bank           = '#FF8DC7',

    -- Status Rings (Pink themed)
    ringHealth     = '#FF5577',
    ringArmor      = '#C77DFF',
    ringHunger     = '#FF8DC7',
    ringThirst     = '#FF69B4',
    ringStress     = '#FF2D95',
    ringStamina    = '#E070C0',
    ringOxygen     = '#FF8DC7',

    -- Vehicle
    arcFuel        = '#FF1493',
    arcEngine      = '#FF69B4',

    -- Lights
    lightIndicator = '#FF8DC7',
    lightHeadlight = '#FFFFFF',
    lightHighbeam  = '#FF69B4',

    -- Warnings
    beltWarn       = '#FF4466',
    warnGlow       = 'rgba(255, 40, 120, 0.6)',

    -- Weapon
    ringWeapon     = '#FF8DC7',
    ringWeaponLow  = '#FF4466',
}
