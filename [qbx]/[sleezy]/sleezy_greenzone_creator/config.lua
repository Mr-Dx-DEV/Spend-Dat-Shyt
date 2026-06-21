Config = {}

Config.Framework = 'auto' -- auto, qbox, qb, esx, standalone
Config.Debug = false

Config.Permission = {
    -- auto = use ACE if present and also try framework admin checks
    -- ace = ACE only
    -- framework = framework only
    mode = 'auto',

    ace = 'sleezy.greenzone.admin',
    allowConsole = true,

    -- Qbox can still use qbx_core permission checks on servers that have them configured,
    -- but ACE is recommended by Qbox and is also supported here.
    qboxPermissions = { 'god', 'admin', 'superadmin' },
    qbPermissions = { 'god', 'admin', 'superadmin' },
    esxGroups = { 'admin', 'superadmin', 'owner' }
}

Config.Commands = {
    create = { 'createsafezone', 'creategreenzone', 'createzone' },
    settings = { 'zonesetting', 'editzone' },
    delete = { 'deletezone', 'removesafezone' },
    list = { 'listzones', 'zonelist' }
}

Config.Creator = {
    editDistance = 25.0,
    defaultLength = 35.0,
    defaultWidth = 35.0,
    defaultHeight = 18.0,
    minLength = 2.0,
    minWidth = 2.0,
    minHeight = 2.0,
    maxLength = 2000.0,
    maxWidth = 2000.0,
    maxHeight = 300.0,
    moveStep = 1.5,
    fineMoveMultiplier = 0.25,
    fastMoveMultiplier = 4.0,
    cameraMoveSpeed = 1.5,
    cameraLookSpeedX = 8.0,
    cameraLookSpeedY = 6.0,
    sizeStep = 1.0,
    headingStep = 5.0,
    heightStep = 1.0,
    drawDistance = 220.0,
    raycastDistance = 180.0,
    snapHeading = true,
    snapSizeToWhole = true,
    freezePlayerWhileEditing = true,
    controls = {
        placePoint = 25, -- RIGHT CLICK
        confirm = 191, -- ENTER
        cancel = 177, -- BACKSPACE
        widthDown = 174, -- ARROW LEFT
        widthUp = 175, -- ARROW RIGHT
        heightUp = 10, -- PAGEUP
        heightDown = 11, -- PAGEDOWN
        heightScrollUp = 15, -- MOUSE WHEEL UP
        heightScrollDown = 14, -- MOUSE WHEEL DOWN
        fine = 21, -- SHIFT
        fast = 36, -- CTRL
        lower = 44 -- Q
    }
}

Config.ZoneDefaults = {
    bypassAdmin = true,
    disableWeapons = true,
    disableMelee = true,
    playerInvincibility = true,
    allowWhitelistedWeapons = false,
    allowWhitelistedJobWeapons = false,
    enableSpeedLimit = false,
    speedLimit = 30,
    antiVDM = false,
    showBlip = false,
    showMarker = false,
    customText = 'You are in a safezone. Do not do any violation here.'
}

Config.WhitelistedWeapons = {
    'WEAPON_STUNGUN',
    'WEAPON_FIREEXTINGUISHER'
}

Config.JobWeaponWhitelist = {
    police = {
        'WEAPON_COMBATPISTOL',
        'WEAPON_STUNGUN',
        'WEAPON_NIGHTSTICK'
    },
    sheriff = {
        'WEAPON_COMBATPISTOL',
        'WEAPON_STUNGUN',
        'WEAPON_NIGHTSTICK'
    },
    ambulance = {
        'WEAPON_STUNGUN',
        'WEAPON_FLASHLIGHT'
    }
}

Config.Visuals = {
    renderNearbyZones = false,
    renderSavedZonesInDebug = true,
    renderInsideOnlyIfMarkerDisabled = false,
    zoneDrawDistance = 120.0,
    previewFill = { r = 72, g = 214, b = 108, a = 55 },
    previewBorder = { r = 255, g = 255, b = 255, a = 190 },
    liveFill = { r = 98, g = 255, b = 136, a = 30 },
    liveBorder = { r = 98, g = 255, b = 136, a = 120 },
    nearestFill = { r = 65, g = 160, b = 255, a = 28 },
    nearestBorder = { r = 65, g = 160, b = 255, a = 150 }
}

Config.Blips = {
    sprite = 161,
    colour = 2,
    alpha = 95,
    shortRange = true,
    text = 'Safezone'
}

Config.Notification = {
    position = 'right-center',
    zoneIcon = 'shield-heart',
    zoneColor = '#2ecc71',
    warnIcon = 'triangle-exclamation',
    warnColor = '#f1c40f',
    zoneDuration = 8000,
    zoneReminderInterval = 12000
}

Config.StatusOverlay = {
    x = 0.50,      -- center
    y = 0.93,      -- near bottom
    width = 0.185,
    minHeight = 0.072,
    badgeWidth = 0.055,
    badgeHeight = 0.013,
    lineHeight = 0.0135,
    background = { r = 11, g = 15, b = 20, a = 228 },
    shadow = { r = 0, g = 0, b = 0, a = 135 },
    accent = { r = 63, g = 222, b = 118, a = 255 },
    accentSoft = { r = 63, g = 222, b = 118, a = 78 },
    border = { r = 255, g = 255, b = 255, a = 16 },
    text = { r = 248, g = 249, b = 250, a = 245 },
    textSoft = { r = 212, g = 218, b = 224, a = 228 },
    title = 'SAFEZONE'
}

Config.Strings = {
    creatorTitle = 'Greenzone Creator',
    creatorSubtitle = 'Freecam polygon builder with unlimited point placement and live Z height control.',
    creatorHelp = '[RIGHT CLICK] Add point\n[WASD] Move camera\n[E/Q] Up/Down\n[MOUSE] Look\n[SCROLL or PAGE UP/DOWN] Height +/-\n[ENTER] Finish zone\n[BACKSPACE] Undo / cancel\n[SHIFT] Fine mode\n[CTRL] Fast mode',
    saveTitle = 'Safezone Info',
    nameLabel = 'Safezone Name',
    nameDescription = 'Choose a clear name for staff.',
    bypassAdmin = 'Bypass Admin',
    disableWeaponMelee = 'Disable Weapon/Melee',
    playerInvincibility = 'Player Invincibility',
    allowWhitelistedWeapons = 'Allow Whitelisted Weapons',
    allowWhitelistedJobWeapons = 'Allow Whitelisted Job Weapons',
    enableSpeedLimit = 'Enable Speed Limit',
    speedLimit = 'Speed Limit (MPH)',
    zoneHeight = 'Zone Height',
    zoneHeightDescription = 'How tall this zone should be from the ground up.',
    antiVDM = 'Anti VDM Protection',
    safezoneText = 'Safezone Text',
    showBlip = 'Show Blip',
    showMarker = 'Show Nearby Marker',
    save = 'Save Zone',
    update = 'Update Zone',
    cancel = 'Cancel',
    zoneEntered = 'You entered a safezone.',
    zoneLeft = 'You left a safezone.',
    zoneCreated = 'Safezone created successfully.',
    zoneUpdated = 'Safezone updated successfully.',
    zoneDeleted = 'Safezone deleted successfully.',
    noPermission = 'You do not have permission to manage safezones.',
    noNearbyZone = 'No nearby safezone found.',
    deleteConfirm = 'Delete closest safezone?',
    deleteDescription = 'This will permanently remove the closest saved zone.',
    deleteTitle = 'Delete Safezone',
    listTitle = 'Saved Safezones',
    listMenuTitle = 'Greenzone Manager',
    manageTitle = 'Zone Settings',
    manageDescription = 'Edit, reshape, or remove the closest zone.',
    editSettings = 'Edit safezone info',
    reshapeZone = 'Reshape zone box',
    removeZone = 'Delete closest zone',
    closestZone = 'Closest zone',
    copiedId = 'Zone id copied to clipboard.',
    copyId = 'Copy zone id',
    noName = 'Untitled Safezone',
    saveFailed = 'Zone could not be saved.',
    invalidData = 'Invalid zone data received.',
    exitEditor = 'Greenzone creator closed.',
    insideMessageTitle = 'Safezone',
    listEmpty = 'No safezones have been created yet.',
    zoneNearest = 'Nearest zone',
    currentZone = 'Current zone',
    speedLimitApplied = 'Vehicle speed limited inside safezone.',
    creatorStageOne = 'Freecam active. Right click to place point 1.',
    creatorStageTwo = 'Right click to place the next point.',
    creatorStageThree = 'Keep adding points to shape the zone.',
    creatorStageFour = 'Press Enter when your zone shape is complete.',
    creatorStageFive = 'Adjust zone height with scroll wheel, then press Enter to save.',
    creatorHeightLabel = 'Height',
    creatorPointPlaced = 'Point placed.',
    creatorSecondPointPlaced = 'Corner placed.',
    creatorThirdPointPlaced = 'Third corner placed.',
    creatorFourthPointPlaced = 'Fourth corner placed.',
    antiVDMApplied = 'Vehicle ramming damage blocked inside safezone.'
}
