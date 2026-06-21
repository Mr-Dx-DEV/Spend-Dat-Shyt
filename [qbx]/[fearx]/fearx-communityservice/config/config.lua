Config = {}

Config.Locale = 'en' -- Supported: 'en', 'es', 'de', 'fr', 'pt', 'it', 'nl', 'pl'

-- Framework Detection: 'auto', 'ESX', 'QB', 'QBX'
-- 'auto' will automatically detect which framework is running on your server
-- Supports: ESX (es_extended), QB-Core (qb-core), QBox (qbx_core)
Config.Framework = 'QB'

-- Admin groups that can use community service commands
-- These are checked via the framework's group/permission system
Config.AdminGroups = {
    'admin',
    'superadmin',
    'mod'
}

-- Community Service Locations
Config.ComServLocations = {
    {
        name = 'Military Boat',
        label = 'Military Boat',
        image = 'https://r2.fivemanage.com/reN0iza3vc4oGjJ0nDgay/image_2025-11-14_221249957.png',
        spawnPoint = vector3(3084.375488, -4719.055176, 15.262276),
        zoneRadius = 40.0,
        markerLocations = {
            vector3(3079.334961, -4734.686523, 15.262367),
            vector3(3072.769531, -4722.313477, 15.262246),
            vector3(3063.713867, -4735.427734, 15.261639),
            vector3(3082.999756, -4728.151367, 15.262296),
            vector3(3078.020508, -4708.569824, 15.262259)
        }
    },
    {
        name = 'Airport Hanger',
        label = 'Airport Hanger',
        image = 'https://r2.fivemanage.com/reN0iza3vc4oGjJ0nDgay/image_2025-11-14_221554635.png',
        spawnPoint = vector3(-1292.773926, -3409.834473, 13.940158),
        zoneRadius = 40.0,
        markerLocations = {
           vector3(-1299.283203, -3394.817139, 13.940157),
            vector3(-1286.642456, -3385.947266, 13.940156),
            vector3(-1290.453857, -3370.274414, 13.940156),
            vector3(-1274.541138, -3396.652588, 13.940156),
            vector3(-1274.680786, -3417.113770, 13.940155)
        }
    },
    {
        name = 'Prison',
        label = 'Prison',
        image = 'https://r2.fivemanage.com/reN0iza3vc4oGjJ0nDgay/image_2025-11-14_222351698.png',
        spawnPoint = vector3(1725.300903, 2535.867920, 45.564850),
        zoneRadius = 40.0,
        markerLocations = {
            vector3(1749.347412, 2527.505127, 45.564972),
            vector3(1752.563354, 2550.512695, 45.564976),
            vector3(1725.299438, 2560.044189, 45.564903),
            vector3(1702.573486, 2544.953613, 45.564899),
            vector3(1717.409058, 2508.019775, 45.564899)
        }
    }
}

-- Default location index for /comserv command (1 = first location)
Config.DefaultLocationIndex = 1

Config.EscapePenalty = 10

Config.MarkerSettings = {
    type = 1,
    size = {x = 1.5, y = 1.5, z = 1.0},
    color = {r = 255, g = 165, b = 0, a = 200},
    bob = true
}

Config.AnimDict = 'anim@amb@drug_field_workers@rake@male_a@base'
Config.AnimName = 'base'

Config.ProgressBarTime = 10000

Config.Notifications = {
    title = 'Community Service',
    success = 'success',
    error = 'error',
    info = 'info'
}

-- Map blip settings
Config.ShowZoneOnMap = false
Config.ZoneBlipSprite = 9
Config.ZoneBlipColor = 5
Config.ZoneBlipScale = 1.0
Config.ZoneBlipName = 'Community Service Zone'

Config.ZoneRadiusBlipSprite = 1
Config.ZoneRadiusBlipColor = 5
Config.ZoneRadiusBlipAlpha = 128

-- Gameplay settings
Config.DisableCombatInZone = true
Config.AutoReviveInZone = true

Config.CheckForUpdates = true
