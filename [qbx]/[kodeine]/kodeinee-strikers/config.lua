Config = {}

Config.Debug = false

Config.Framework = 'auto' -- auto, qb, qbox, esx, standalone
Config.Inventory = 'auto' -- auto, qb-inventory, ak47_qb_inventory, ox_inventory, framework
Config.Target = 'auto' -- auto, qb-target, ox_target, none

-- =========================
-- ITEMS
-- =========================
Config.Items = {
    StrikerPad = 'strikerpad',
    RequiredStrike = 'keyfob',
    StolenDoor = 'stolendoor',
    StolenRim = 'stolenrim',
    StolenCarPart = 'stolencarpart',
}

Config.StrikerItem = Config.Items.StrikerPad
Config.RequiredStrikeItem = Config.Items.RequiredStrike

-- =========================
-- PAYOUT
-- =========================
Config.Payout = {
    Type = 'item', -- cash, bank, item
    Item = 'black_money', -- examples: blackmoney, black_money, markedbills
    Label = 'Black Money'
}

-- =========================
-- STRIKER PAD HAND PROP
-- =========================
Config.StrikerPadProp = {
    enabled = true,
    model = 'kodeineestrikepad', -- put kodeineestrikepad.ydr/.ytyp/.ybn inside stream folder
    bone = 60309, -- left hand, clipboard-style hold
    position = vector3(0.08, 0.02, -0.02),
    rotation = vector3(10.0, 0.0, 10.0),
    animation = {
        dict = 'missheistdockssetup1clipboard@base',
        clip = 'base',
        flag = 49
    }
}


-- =========================
-- VEHICLE KEY SYSTEM SUPPORT
-- =========================
Config.VehicleKeys = {
    System = 'auto', -- auto, qb, qbox, wasabi_carlock, ak47_qb_vehiclekeys, qs-vehiclekeys, Renewed-Vehiclekeys, mk_vehiclekeys, MrNewbVehicleKeys, custom, none
    GiveOnStrike = true,
    GiveOnGarageSpawn = true,
    FallbackQBEvents = true,
    Debug = false,

    CustomServerGive = function(src, plate, netId)
        -- Add custom server-side key export here if needed.
        return false
    end,

    CustomClientGive = function(plate, vehicle)
        -- Add custom client-side key export here if needed.
        return false
    end
}

-- =========================
-- VEHICLE STRIKE OPTIONS
-- =========================
Config.VehicleStrike = {
    PlayerVehicles = true, -- allow striking owned/player garage vehicles
    PedVehicles = true, -- allow striking regular NPC/ped vehicles
}

-- =========================
-- VEHICLE OWNER TABLE
-- =========================
Config.VehicleTable = {
    -- QB/Qbox default: player_vehicles / plate / citizenid
    -- ESX common default: owned_vehicles / plate / owner
    -- Ped-only servers can set table = 'none'
    table = 'player_vehicles',
    plateColumn = 'plate',
    ownerColumn = 'citizenid',
}

-- =========================
-- STRIKER SETTINGS
-- =========================
Config.LockoutSeconds = 24 * 60 * 60
Config.ThiefAccessSeconds = 24 * 60 * 60

Config.PropadMaxUses = 5
Config.ConsumeKeyfobOnSuccess = true

Config.StrikeLimit = {
    max = 1,
    windowSeconds = 6 * 60 * 60,
}

Config.UseClonePlate = true
Config.ClonePlatePrefix = 'STRK'

Config.GiveThiefKeys = true
Config.UseOpGaragesPatch = true

-- =========================
-- PROGRESS
-- =========================
Config.UseOxLibProgress = true
Config.Progress = {
    duration = 8000,
    label = 'Striking vehicle...',
    canCancel = true,
    disable = { car = true, move = true, combat = true }
}

-- =========================
-- STRIKE STORAGE
-- =========================
Config.StrikeStorage = {
    enable = true,
    coords = vec3(-421.78, -1682.41, 18.35),
    interactDist = 4.0,
    drawDist = 40.0,
    markerType = 36,
    markerScale = vec3(1.5, 1.5, 1.5)
}

-- =========================
-- STRIKE VALET DELIVERY
-- =========================
Config.StrikeValet = {
    enable = true,
    command = 'callstrike',
    driverModel = 's_m_m_valet_01',
    spawnDistance = 90.0,
    handoffDistance = 12.0,
    driveStyle = 786603,
    maxSpeed = 22.0
}

-- =========================
-- CHOP SHOP
-- =========================
Config.ChopShop = {
    enable = true,

    coords = vector3(-450.70516967773, -1681.3909912109, 19.219076156616),
    radius = 18.0,
    interactDist = 3.0,
    drawMarkerDist = 80.0,

    rewards = {
        [Config.Items.StolenDoor] = 4,
        [Config.Items.StolenRim] = 4,
        [Config.Items.StolenCarPart] = 3,
    }
}

-- =========================
-- =========================
-- SUPPLIER PED
-- =========================
Config.SupplierPed = {
    enable = true,
    model = 'g_m_y_lost_01',
    coords = vector4(1548.23, 845.83, 77.47, 63.80),
    interactDist = 2.0,
    serverMaxDistance = 4.0,

    payment = {
        Type = 'cash', -- cash, bank, item
        Item = 'markedbills', -- only used when Type = item. examples: markedbills, blackmoney, black_money, rubies
        Label = 'Cash'
    },

    items = {
        { item = Config.Items.StrikerPad, label = 'Striker Pad', price = 15000, amount = 1 },
        { item = Config.Items.RequiredStrike, label = 'Key Fob', price = 2500, amount = 1 },
    }
}

-- SELL PED
-- =========================
Config.SellPed = {
    enable = true,
    model = 'g_m_y_mexgoon_02',
    coords = vector4(1570.5188, 859.4356, 77.6947, 3.9181),
    interactDist = 2.0,

    cooldownSeconds = 20,
    serverMaxDistance = 4.0,

    prices = {
        [Config.Items.StolenDoor] = { min = 11250, max = 18450 },
        [Config.Items.StolenRim] = { min = 7150, max = 15300 },
        [Config.Items.StolenCarPart] = { min = 5400, max = 10750 },
    }
}

-- =========================
-- NOTIFICATIONS
-- =========================
Config.Notify = function(src, msg, typ)
    if Bridge and Bridge.Notify then
        return Bridge.Notify(src, msg, typ or 'primary')
    end

    TriggerClientEvent('chat:addMessage', src, {
        args = { 'Kodeinee Strikers', msg }
    })
end
