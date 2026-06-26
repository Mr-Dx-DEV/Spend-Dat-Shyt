Config = {}

Config.Framework = 'auto' -- auto, qbcore, qbox, esx, standalone
Config.Inventory = 'auto' -- auto, ox_inventory, qb-inventory, ps-inventory, lj-inventory, qs-inventory, standalone

Config.NotifyTitle = 'Airbags'
Config.Debug = false

-- Auto crash deployment. Simple original-style behavior:
-- If the driver is going above this speed and crashes hard enough to lose speed, airbags deploy.
Config.SpeedUnit = 'mph' -- mph or kmh
Config.DeploySpeed = 30.0 -- 30 MPH by default
Config.SpeedDropRequired = 8.0 -- how much speed must drop from the crash
Config.DamageLevel = 850 -- backup legacy value
Config.BodyDamageDropRequired = 12.0 -- backup deploy if body health drops this much in one impact
Config.EngineDamageDropRequired = 8.0 -- backup deploy if engine health drops this much in one impact
Config.CheckInterval = 50 -- crash check interval, lower = more sensitive
Config.CrashDelay = 50 -- original delay after damage event before checking speed drop
Config.DeployCooldown = 2500
Config.DriverOnly = true

Config.UseCrashEffect = true
Config.CrashEffectTime = 3000

Config.AirbagProp = `prop_carairbag`

-- Cleanup commands only. Install item/manual install has been removed.
Config.EnableRemoveCommand = true
Config.RemoveCommand = 'removeairbag' -- removes airbags from the vehicle you are driving
Config.CleanupCommand = 'clearairbags' -- removes nearby deployed airbag props
Config.CleanupRadius = 10.0

-- Optional sound support. Set false if you do not use InteractSound.
Config.UseInteractSound = false
Config.InteractSoundName = 'airbag'
Config.InteractSoundDistance = 10.0
Config.InteractSoundVolume = 1.0

Config.ExemptVehicles = {
    `sanchez`
}

Config.ExemptClasses = {
    8,  -- Motorcycles
    13, -- Cycles
    14, -- Boats
    15, -- Helicopters
    16  -- Planes
}
