-------------------------------------------------------------------------------------------------------------------------------------------------
--  🛠️  Admins or players with the job specified in Config.JobName can use the command /setbattery [ID] [1-100] to set a player's battery level.
-------------------------------------------------------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------------------------------------------------------
--  🛠️  ChargingStation START
-------------------------------------------------------------------------------------------------------------------------------------------------

Config = {}

Config.Framework = "qbcore" -- "esx", "qbcore"

--Config.JobName = "nia" -- job that can use /setbattery

Config.Language = "en"

Config.Locales = {
    ["en"] = {
        startCharging = "Your phone is now charging...",
        fullyCharged = "Your phone is fully charged!",
        alreadyFull = "Your phone is already fully charged!",
        needCharger = "You need a charging cable to charge your phone!",
        chargingStopped = "Charging stopped! Stay near the station.",
        pressToCharge = "Press ~INPUT_CONTEXT~ to charge your phone",
        batterySet = "Battery level set to {battery}%.",
        noPermission = "You do not have permission to use this command!",
        usageSetBattery = "Usage: /setbattery [ID] [Battery%]",
        invalidBatteryValue = "The battery level must be between 1 and 100.",
        playerNotFound = "Player with the given ID does not exist."
    },
    ["de"] = {
        startCharging = "Dein Handy wird jetzt geladen...",
        fullyCharged = "Dein Handy ist vollständig geladen!",
        alreadyFull = "Dein Handy ist bereits vollständig geladen!",
        needCharger = "Du brauchst ein Ladekabel, um dein Handy zu laden!",
        chargingStopped = "Laden abgebrochen! Bleibe in der Nähe der Station.",
        pressToCharge = "Drücke ~INPUT_CONTEXT~, um dein Handy zu laden",
        batterySet = "Der Batteriestand wurde auf {battery}% gesetzt.",
        noPermission = "Du hast keine Berechtigung, diesen Befehl zu nutzen!",
        usageSetBattery = "Verwendung: /setbattery [ID] [Batterie%]",
        invalidBatteryValue = "Der Wert muss zwischen 1 und 100 liegen.",
        playerNotFound = "Spieler mit der angegebenen ID existiert nicht."
    }
}

Config.ChargingStations = {
    {pos = vector3(327.38, -590.76, 43.18), enableBlip = true},  -- PillBox Hospital
    {pos = vector3(441.3598, -994.2085, 31.0262), enableBlip = true}, -- Police MRPD
    {pos = vector3(293.50, -1164.05, 29.28), enableBlip = true}, -- Rim Shop
    {pos = vector3(-200.4317, -1335.2408, 31.9190), enableBlip = true}, -- Clothing Store
    {pos = vector3(128.27, -212.43, 54.55), enableBlip = true},  -- Clothing Store 2
    {pos = vector3(-703.81, -159.15, 37.40), enableBlip = true},  -- Clothing Store 3
    {pos = vector3(-42.78, -1755.05, 29.43), enableBlip = true},  -- Gas Station 2
}

Config.RequireItem = true

Config.ItemCharger = "chargingcable" -- Name of item / ONLY WORKS IF Config.RequireItem = true

Config.ChargeTime = 180000 -- Charging time in Milliseconds (3 Min)

Config.ChargeRadius = 3.0 -- Radius

Config.BlipSettings = {
    sprite = 354,
    color = 3,
    scale = 0.6,
    name = "Charging Station"
}

-------------------------------------------------------------------------------------------------------------------------------------------------
--  🛠️  Powerbank Start
-------------------------------------------------------------------------------------------------------------------------------------------------

Config.ItemName = "powerbank" -- Name of Item form the Powerbank

Config.ChargingTime = 180000 -- Charging time in Milliseconds (3 Min)

