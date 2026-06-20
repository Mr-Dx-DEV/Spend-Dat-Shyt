Config = {}

Config.Debug        = false
Config.Locale       = 'en'

---@type "auto"|"lb-phone"|"lb-tablet"|"gksphone"|"yseries"|"yflip-phone"|"17mov_phone"|"codem-phone"|"custom"
Config.Phone = 'auto'
--[[
    Supported phones (Config.Phone):
    > "auto"         - Auto-detect started phone/tablet resources
    > "lb-phone"     - https://lbscripts.com/
    > "lb-tablet"    - https://lbscripts.com/ (can run alongside a phone)
    > "gksphone"     - https://gkshop.org/
    > "yseries"      - https://yflip-phone.com/
    > "yflip-phone"  - https://yflip-phone.com/
    > "17mov_phone"  - https://17movement.net/products/17mov_phone
    > "codem-phone"  - https://codem.tebex.io/
    > "custom"       - Adapter block in client/cl_phone_bridge.lua
]]

Config.SocialPost    = true
Config.SocialMessage = true

---@type ""|"money"|"bank"
Config.Currency = 'money'

Config.EventTypes = {
    { id = 'house_party', label = 'House party', icon = 'house',     discover = true,  discoverLabel = 'Parties' },
    { id = 'club_night',  label = 'Club night',  icon = 'music',     discover = true,  discoverLabel = 'Clubs' },
    { id = 'car_meet',    label = 'Car meet',    icon = 'car',       discover = true,  discoverLabel = 'Meets' },
    { id = 'business',    label = 'Business',    icon = 'briefcase', discover = true,  discoverLabel = 'Business' },
    { id = 'wedding',     label = 'Wedding',     icon = 'rings',     discover = true,  discoverLabel = 'Weddings' },
    { id = 'race',        label = 'Race',        icon = 'flag',      discover = true,  discoverLabel = 'Races' },
    { id = 'other',       label = 'Other',       icon = 'generic',   discover = false },
}

Config.GeofenceDefaults = {
    radius = 100,
}

Config.CheckIn = {
    dwellSeconds     = 3,
    movementSpeedCap = 1.0,
    vehicleAllowed   = false,
    selfPayBlocked   = true,
}

Config.AutoCheckoutSeconds = 300

Config.Lifecycle = {
    tickerIntervalMs       = 30000,
    startingNotifyMinutes  = 10,
}

Config.RetentionDays = 30

Config.Heartbeat = {
    intervalMs  = 5000,
    dbTouchMs   = 30000,
}

Config.RateLimits = {
    createEvent   = { max = 3,  windowMs = 60000  },
    cancelEvent   = { max = 3,  windowMs = 60000  },
    updateEvent   = { max = 10, windowMs = 60000  },
    respondInvite = { max = 10, windowMs = 60000  },
    inviteToEvent       = { max = 20, windowMs = 60000  },
    listAttendingEvents = { max = 10, windowMs = 60000  },
    checkIn             = { max = 5,  windowMs = 10000  },
    heartbeat     = { max = 30, windowMs = 60000  },
}

Config.Limits = {
    maxActiveEventsPerCharacter = 3,
    coverChargeMax              = 1000000,
    guestCapMin                 = 1,
    guestCapMax                 = 200,
    radiusMin                   = 5,
    radiusMax                   = 200,
    nameMinLen                  = 1,
    nameMaxLen                  = 80,
    descriptionMaxLen           = 500,
    scheduleMinSeconds          = 60,
    scheduleMaxDaysAhead        = 30,
}
