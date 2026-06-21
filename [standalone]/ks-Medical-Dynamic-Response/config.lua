Config = {}

-- ==================================================
-- Language
-- ==================================================

-- Available by default: 'en', 'fr'
Config.Locale = 'en'
Config.FallbackLocale = 'en' -- if you want to add your own language, set this to a default (en) for missing keys

-- ==================================================
-- Framework
-- ==================================================

-- Options: 'auto', 'esx', 'qbcore', 'standalone'
Config.Framework = 'auto'

-- External death script resource names accepted by the compatibility layer. Use only on standalone
Config.DeathScriptResourceNames = {
    'DeathScript',
    'deathscript'
}

-- Jobs treated as EMS roles.
-- Edit this list here, not in `custom/custom.lua`.
Config.EMSJobs = {
    'ambulance',
    'doctor'
}

-- ==================================================
-- Medical System
-- ==================================================

-- System is enabled only when online EMS count is below this value.
Config.MinEMSOnline = 1 -- Set to 0 to always enable, or a high number to disable when any EMS are online.

Config.RevivePrice = 5000
Config.ReviveHealth = 150
Config.ReviveCooldown = 300 -- seconds

-- Automatically request medical dispatch when the player dies.
Config.AutoCallOnDeath = true

-- Manual command to request medical dispatch.
Config.EnableReviveCommand = true
Config.ReviveCommandName = 'callems'

-- Delay before spawning the ambulance vehicle after request validation (ms).
Config.AmbulanceSpawnDelayMs = 4000

-- Free revive when player is in a SafeZoneManager zone.
Config.SafeZoneFreeRevive = true

-- Zones where the system is disabled.
Config.BlacklistZones = {
    -- { x = 0.0, y = 0.0, z = 0.0, radius = 50.0, name = 'Restricted Area 1' }
}

-- ==================================================
-- Ambulance Vehicle
-- ==================================================

-- Edit ambulance models here, not in `custom/custom.lua`.
-- Keep only vehicles that are actually installed on your server.
-- If a model is missing, dispatch can fail before the ambulance reaches the player.
Config.AmbulanceModels = {
    { model = 'ambulance', els = false },
    -- Uncomment only if this model exists in your server files:
    -- {
    --     model = 'roadrunnerambulance',
    --     els = false,
    --     lights = {
    --         useExtras = true,
    --         extrasOn = { 1, 2, 3, 4 },
    --         extrasOff = {},
    --         useNativeSiren = true,
    --         useNativeLights = true
    --     }
    -- },
    -- Non-ELS example:
    -- {
    --     model = 'bmt_ambulance',
    --     els = false,
    --     lights = {
    --         useExtras = true,
    --         extrasOn = { 1, 2, 3, 4 },
    --         extrasOff = { 5, 6 },
    --         useNativeSiren = true,
    --         useNativeLights = true
    --     }
    -- },
    -- ELS vehicle example:{ model = 'popo25', els = true },
    -- { model = 'popo25', els = true },
}

-- ELS resource installed on the server (for vehicles with els = true)
Config.ELSResource = 'lvc'

-- Spawn tuning.
Config.SpawnDistance = 60.0
Config.SpawnMinDistance = 80.0
Config.SpawnDistanceTolerance = 10.0

-- Driving behavior.
Config.DriveStyle = 786495 -- https://vespura.com/fivem/drivingstyle/
Config.VehicleSpeed = 25.0 -- 25 is fast, 20 is normal, 15 is cautious

-- ==================================================
-- NPC
-- ==================================================

Config.NPCModel = 's_m_m_paramedic_01'
Config.WalkDistance = 3.0
Config.WalkSpeed = 1.0

-- ==================================================
-- Discord Logs
-- ==================================================

Config.EnableDiscordLogs = true
Config.DiscordWebhook = 'YOUR_WEBHOOK_URL_HERE'
Config.DiscordColor = 3066993
Config.DiscordBotName = 'Kubi Medical Logs'
Config.DiscordAvatar = 'https://i.imgur.com/YourImage.png'

-- ==================================================
-- Advanced / Sensitive Settings

-- It is recommended not to edit these values unless needed.
-- ==================================================

-- Dispatch controls arrival logic and stuck handling.
Config.Dispatch = {
    JourneyCheckInterval = 500,
    WalkCheckInterval = 250,
    ArrivalBufferDistance = 20.0,
    ArrivalTargetDistance = 22.0,
    MaxArrivalTargetDistance = 30.0,
    ArrivalNodeSearchRadius = 45.0,
    MinArrivalDistance = 25.0,
    PatientArrivalSlack = 8.0,
    WalkTimeout = 18000,
    VehicleStuckGrace = 18000,
    VehicleStuckCheckInterval = 7000,
    VehicleStuckMinMoveDistance = 5.0,
    StuckMinDistanceFromPatient = 45.0,
    StuckRecoveryMaxAttempts = 2,
    StuckRecoveryTargetDistance = 35.0,
    RecoveryEnterDelay = 800,
    EnterVehicleTimeout = 7000,
    MaxFallbackAttempts = 3,
    -- Behavior when medical dispatch cannot reach the player after repeated fallbacks:
    -- 'revive' = force revive
    -- 'fail'   = do not revive, notify failure
    UnreachableAction = 'fail'
}

-- CPR animation settings.
Config.NPCAnimation = {
    dict = 'mini@cpr@char_a@cpr_str',
    anim = 'cpr_pumpchest',
    flag = 1
}

Config.PlayerAnimation = {
    dict = 'mini@cpr@char_b@cpr_str',
    anim = 'cpr_pumpchest_idle',
    flag = 1
}

Config.CPRSettings = {
    StartDistance = 2.75,
    ForceTeleportDistance = 8.0,
    MinimumOffsetDistance = 0.75,
    PositionSnapDistance = 1.25,
    ApproachSpeed = 1.5,
    ApproachTimeout = 3000,
    MaxCPRStartDistance = 3.25,
    TurnDuration = 1000,
    SetupDelay = 250,
    VerifyAnimDelay = 600,
    KeepAliveCheckInterval = 1000,
    MuteSirenDuringCPR = false,
    DoctorAnimDict = 'mini@cpr@char_a@cpr_str',
    DoctorAnimName = 'cpr_pumpchest',
    BlendInSpeed = 8.0,
    BlendOutSpeed = -8.0,
    ScenarioFallback = true,
    FallbackScenario = 'WORLD_HUMAN_CPR'
}

-- Positional alignment for CPR setup.
Config.CPRAnchor = {
    DefaultXOffset = 0.25,
    DefaultYOffset = -1.60,
    DefaultHeadingOffset = -5.0,
    DefaultZOffset = 0.0,
    ChestForwardCompensation = 0.9,

    WasabiNPCDict = 'mini@cpr@char_a@cpr_def',
    WasabiNPCAnim = 'cpr_pumpchest',
    WasabiHeadingOffset = -5.0,
    WasabiXOffset = 0.25,
    WasabiYOffset = -1.60,
    WasabiZOffset = 0.0,
    WasabiChestForwardCompensation = 0.9,

    FallbackMinSpawnDistance = 6.0,
    FallbackStartAngles = { 160.0, -160.0, 110.0, -110.0, 180.0 },
    FallbackApproachSpeed = 3.0,
    FallbackApproachTimeout = 12000
}

Config.AnimationDuration = 8000 -- ms

-- Fallback behavior.
Config.FallbackTimeout = 90
Config.FallbackType = 'teleport'
Config.FallbackTeleportDistance = 6.0

-- Departure controls only the post-revive return flow.
Config.Departure = {
    StandUpDelay = 1200,
    WalkAwayDistance = 24.0,
    DespawnMinDistance = 45.0,
    CheckInterval = 1000,
    MaxWait = 45000,
    RequireOffscreen = true,
    VehicleDriveSpeed = 20.0,
    DrivingStyle = 786571,
    PreferVehicleDeparture = true,
    EnterVehicleRetries = 3,
    EnterStabilizeDelay = 500,
    GoToDoorDelay = 900,
    EnterStartDistance = 2.8,
    GoToDoorTimeout = 3500,
    RetryDelay = 900,
    FootDepartureLightsOffDelay = 5000
}

-- Performance.
Config.ThreadRefreshRate = 1000
Config.MaxRenderDistance = 200.0
Config.EntityCleanupTime = 60

-- Compatibility / debug.
Config.Debug = false
Config.WasabiCompatibility = true
Config.VehicleDeleteDelay = 5000
Config.NPCDeleteDelay = 3000
Config.CheckDeathState = true
Config.DisableIfAdminOnline = false
Config.MinAdminRank = 'admin'

-- Native death detection.
Config.UseNativeDeathDetection = true
Config.DeathCheckInterval = 500 -- do not change unless you know what you're doing

-- ==================================================
-- Custom Integration Hooks (client-side)
-- ==================================================
--
-- These hooks let you integrate third-party resources (death screens,
-- injury systems, crawl scripts, HUDs, etc.) without touching the
-- escrowed client files.
--
-- You can also listen to the public events from any external resource:
--   AddEventHandler('kubi_medical:onDeath',  function(coords) end)
--   AddEventHandler('kubi_medical:onRevive', function(coords) end)
--
-- ---------- Example: pinkFrog_deathScreen ----------
--Config.OnRevive = function(coords)
--     if GetResourceState('pinkFrog_deathScreen') == 'started' then
--         -- Fully resets the death screen after an external revive
--         -- (hides UI, clears injuries, stops death/crawl animations,
--         --  restores player control).
--         exports['pinkFrog_deathScreen']:HardReset()
--     end
-- end
--
-- Config.OnDeath = function(coords)
--     if GetResourceState('pinkFrog_deathScreen') == 'started' then
--         -- Optional: force-start the death screen if you want to sync it.
--         -- exports['pinkFrog_deathScreen']:startDeathScreen(60)
--     end
-- end
-- ---------------------------------------------------


-- Called when the player is detected dead. `coords` is a vector3 (may be nil).
Config.OnDeath = function(coords)
    -- Add your custom logic here (e.g. start a custom death screen).
end

-- Called right after the player is revived (our revive or an external one).
-- `coords` is a vector3 where the player was revived (may be nil).
Config.OnRevive = function(coords)
    -- Add your custom logic here (e.g. reset a custom death screen).
end