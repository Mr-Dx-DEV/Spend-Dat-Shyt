--[[
    ╔═══════════════════════════════════════════════════════════════════╗
    ║                     ROYAL POLICE PATROL                           ║
    ║                      Configuration File                           ║
    ╚═══════════════════════════════════════════════════════════════════╝
]]--

--[[
    Config
    DO NOT TOUCH THIS! SCROLL TO LINE 324!The main config table for the script
]]--

Config = {}

--------------------------------------------------------------------------------
-- FRAMEWORK SETTINGS
-- The script will auto-detect your framework, but you can force one if needed
--------------------------------------------------------------------------------
Config.Framework = 'auto' -- Options: 'auto', 'esx', 'qbcore'

--------------------------------------------------------------------------------
-- FRAMEWORK DETECTION & HELPER FUNCTIONS
-- Auto-detects ESX or QBCore and provides unified helper functions
-- This section is reusable - copy to other scripts as needed
--------------------------------------------------------------------------------

-- Framework object storage (populated after detection)
Framework = {
    Name = nil,      -- 'esx' or 'qbcore'
    Object = nil,    -- The actual framework object (ESX or QBCore)
    Ready = false    -- Whether framework has been initialized
}

--[[
    DetectFramework()
    Automatically detects which framework is running
    Returns: 'qbcore', 'esx', or nil if none found
]]--
function DetectFramework()
    -- Check if framework is forced in config
    if Config.Framework ~= 'auto' then
        if Config.Framework == 'qbcore' or Config.Framework == 'esx' then
            return Config.Framework
        end
    end
    
    -- Try QBCore first (newer framework)
    if GetResourceState('qb-core') == 'started' then
        return 'qbcore'
    end
    
    -- Try ESX variants
    if GetResourceState('es_extended') == 'started' then
        return 'esx'
    end
    
    -- Legacy ESX check
    if GetResourceState('esx_core') == 'started' then
        return 'esx'
    end
    
    return nil
end

--[[
    InitializeFramework()
    Initializes the detected framework and stores it in the Framework table
    Should be called once when the resource starts
]]--
function InitializeFramework(callback)
    local detected = DetectFramework()
    
    if not detected then
        print('^1[royal_policepatrol] ERROR: No framework detected! ESX or QBCore required.^0')
        return false
    end
    
    Framework.Name = detected
    
    if detected == 'qbcore' then
        Framework.Object = exports['qb-core']:GetCoreObject()
        Framework.Ready = true
        if Config.Debug then
            print('^2[royal_policepatrol] Framework detected: QBCore^0')
        end
    elseif detected == 'esx' then
        -- ESX has different initialization for client vs server
        if IsDuplicityVersion() then
            -- Server-side ESX
            Framework.Object = exports['es_extended']:getSharedObject()
            Framework.Ready = true
            if Config.Debug then
                print('^2[royal_policepatrol] Framework detected: ESX (Server)^0')
            end
        else
            -- Client-side ESX - uses callback pattern
            ESX = nil
            TriggerEvent('esx:getSharedObject', function(obj)
                ESX = obj
            end)
            
            -- Modern ESX also supports exports
            if not ESX then
                ESX = exports['es_extended']:getSharedObject()
            end
            
            Framework.Object = ESX
            Framework.Ready = true
            if Config.Debug then
                print('^2[royal_policepatrol] Framework detected: ESX (Client)^0')
            end
        end
    end
    
    -- Store framework name in config for easy access
    Config.Framework = Framework.Name
    
    if callback then
        callback(Framework)
    end
    
    return true
end

--[[
    GetPlayerData()
    Returns the player's data table from the active framework
    
    For QBCore: Returns PlayerData table
    For ESX: Returns xPlayer/PlayerData table
    
    Returns: table or nil if not available
]]--
function GetPlayerData()
    if not Framework.Ready then
        print('^1[royal_policepatrol] ERROR: Framework not initialized! Call InitializeFramework() first.^0')
        return nil
    end
    
    if IsDuplicityVersion() then
        -- Server-side: requires source/playerId parameter
        print('^1[royal_policepatrol] ERROR: GetPlayerData() on server requires player source. Use GetPlayerDataById(source) instead.^0')
        return nil
    end
    
    -- Client-side
    if Framework.Name == 'qbcore' then
        return Framework.Object.Functions.GetPlayerData()
    elseif Framework.Name == 'esx' then
        return Framework.Object.GetPlayerData()
    end
    
    return nil
end

--[[
    GetPlayerDataById(source)
    Server-side function to get player data by their server ID
    
    @param source: The player's server ID
    Returns: table or nil if not available
]]--
function GetPlayerDataById(source)
    if not Framework.Ready then
        print('^1[royal_policepatrol] ERROR: Framework not initialized! Call InitializeFramework() first.^0')
        return nil
    end
    
    if not IsDuplicityVersion() then
        print('^1[royal_policepatrol] ERROR: GetPlayerDataById() is server-only. Use GetPlayerData() on client.^0')
        return nil
    end
    
    if Framework.Name == 'qbcore' then
        local Player = Framework.Object.Functions.GetPlayer(source)
        return Player and Player.PlayerData or nil
    elseif Framework.Name == 'esx' then
        local xPlayer = Framework.Object.GetPlayerFromId(source)
        return xPlayer or nil
    end
    
    return nil
end

--[[
    GetPlayerJob()
    Returns the player's current job information
    
    Returns: table with { name = string, grade = number, label = string } or nil
]]--
function GetPlayerJob()
    local playerData = GetPlayerData()
    if not playerData then return nil end
    
    if Framework.Name == 'qbcore' then
        return playerData.job and {
            name = playerData.job.name,
            grade = playerData.job.grade.level,
            label = playerData.job.label,
            gradeLabel = playerData.job.grade.name
        } or nil
    elseif Framework.Name == 'esx' then
        return playerData.job and {
            name = playerData.job.name,
            grade = playerData.job.grade,
            label = playerData.job.label,
            gradeLabel = playerData.job.grade_label
        } or nil
    end
    
    return nil
end

--[[
    GetPlayerJobById(source)
    Server-side function to get player's job by their server ID
    
    @param source: The player's server ID
    Returns: table with { name = string, grade = number, label = string } or nil
]]--
function GetPlayerJobById(source)
    local playerData = GetPlayerDataById(source)
    if not playerData then return nil end
    
    if Framework.Name == 'qbcore' then
        return playerData.job and {
            name = playerData.job.name,
            grade = playerData.job.grade.level,
            label = playerData.job.label,
            gradeLabel = playerData.job.grade.name
        } or nil
    elseif Framework.Name == 'esx' then
        -- ESX xPlayer has getJob() method
        if playerData.getJob then
            local job = playerData.getJob()
            return {
                name = job.name,
                grade = job.grade,
                label = job.label,
                gradeLabel = job.grade_label
            }
        end
        return nil
    end
    
    return nil
end

--[[
    IsPlayerPolice()
    Checks if the current player has a police job (client-side)
    Uses the Config.PoliceJobs table to determine valid police jobs
    
    Returns: boolean
]]--
function IsPlayerPolice()
    local job = GetPlayerJob()
    if not job then return false end
    
    for _, policeJob in ipairs(Config.PoliceJobs) do
        if job.name == policeJob then
            return true
        end
    end
    
    return false
end

--[[
    IsPlayerPoliceById(source)
    Server-side function to check if a player has a police job
    
    @param source: The player's server ID
    Returns: boolean
]]--
function IsPlayerPoliceById(source)
    local job = GetPlayerJobById(source)
    if not job then return false end
    
    for _, policeJob in ipairs(Config.PoliceJobs) do
        if job.name == policeJob then
            return true
        end
    end
    
    return false
end

--[[
    ShowNotification(message, type)
    Displays a notification using the active framework's notification system
    
    @param message: The message to display
    @param type: Optional notification type ('success', 'error', 'info', 'warning')
]]--
function ShowNotification(message, type)
    if not Framework.Ready then return end
    
    if IsDuplicityVersion() then
        print('^1[royal_policepatrol] ERROR: ShowNotification() is client-only.^0')
        return
    end
    
    type = type or 'info'
    
    if Framework.Name == 'qbcore' then
        Framework.Object.Functions.Notify(message, type, Config.Notifications.Duration)
    elseif Framework.Name == 'esx' then
        Framework.Object.ShowNotification(message)
    end
end

--[[
    DebugPrint(...)
    Prints debug messages to console if Config.Debug is enabled
]]--
function DebugPrint(...)
    if Config.Debug then
        print('^3[royal_policepatrol DEBUG]^0', ...)
    end
end

--------------------------------------------------------------------------------
-- POLICE JOB SETTINGS
-- Define which jobs are considered police and can use patrol features
--------------------------------------------------------------------------------
Config.PoliceJobs = {
    'police',       -- Default police job
    'sheriff',      -- Sheriff department
    'lspd',         -- Los Santos Police Department
    'bcso',         -- Blaine County Sheriff's Office
    'sasp',         -- San Andreas State Police
    'sahp',         -- San Andreas Highway Patrol
}

--------------------------------------------------------------------------------
-- PATROL SETTINGS
--------------------------------------------------------------------------------
Config.Patrol = {
    -- Command to toggle patrol status
    Command = 'patrol',
    
    -- Command to start patrol
    StartCommand = 'startpatrol',
    
    -- Command to stop patrol
    StopCommand = 'stoppatrol',
    
    -- Keybind to toggle patrol (set to false to disable)
    -- See: https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
    Keybind = 'F6',
    
    -- Notify players when they start/stop patrol
    NotifyOnToggle = true,
}

--------------------------------------------------------------------------------
-- NOTIFICATION SETTINGS
--------------------------------------------------------------------------------
Config.Notifications = {
    -- Duration notifications are displayed (in milliseconds)
    Duration = 5000,
    
    -- Messages
    StartPatrol = '~g~You are now on patrol.',
    StopPatrol = '~r~You have ended your patrol.',
    NotPolice = '~r~You must be a police officer to go on patrol.',
    AlreadyOnPatrol = '~y~You are already on patrol.',
    NotOnPatrol = '~y~You are not currently on patrol.',
}

--------------------------------------------------------------------------------
-- DEBUG MODE
-- Enable this for console logging during development
--------------------------------------------------------------------------------
Config.Debug = false

--------------------------------------------------------------------------------
-- CRIME CONFIGURATION
-- Define all crime types that can be dispatched during patrol
-- 
-- Each crime type includes:
--   label          : Display name shown to the player
--   severity       : 1 (minor) to 5 (critical) - affects priority & response
--   violentChance  : 0.0 to 1.0 - probability the suspect becomes violent
--   weaponChance   : 0.0 to 1.0 - probability the NPC is armed (if violent)
--   radius         : Distance from player the crime can spawn (in meters)
--------------------------------------------------------------------------------
Config.Crimes = {
    ['traffic_stop'] = {
        label = 'Traffic Stop',
        severity = 1,
        violentChance = 0.1,      -- 10% chance to be violent
        weaponChance = 0.05,      -- 5% chance NPC has weapon
        radius = 150.0,           -- Spawns within 150m of player
    },
    
    ['disturbance'] = {
        label = 'Disturbance',
        severity = 2,
        violentChance = 0.25,     -- 25% chance to be violent
        weaponChance = 0.1,       -- 10% chance NPC has weapon
        radius = 200.0,           -- Spawns within 200m of player
    },
    
    ['assault'] = {
        label = 'Assault',
        severity = 3,
        violentChance = 0.6,      -- 60% chance to be violent
        weaponChance = 0.2,       -- 20% chance NPC has weapon
        radius = 250.0,           -- Spawns within 250m of player
    },
    
    ['armed_robbery'] = {
        label = 'Armed Robbery',
        severity = 4,
        violentChance = 0.8,      -- 80% chance to be violent
        weaponChance = 0.75,      -- 75% chance NPC has weapon
        radius = 300.0,           -- Spawns within 300m of player
    },
    
    ['store_theft'] = {
        label = 'Store Theft',
        severity = 2,
        violentChance = 0.15,     -- 15% chance to be violent
        weaponChance = 0.05,      -- 5% chance NPC has weapon
        radius = 175.0,           -- Spawns within 175m of player
    },
}

--------------------------------------------------------------------------------
-- CRIME SEVERITY LABELS
-- Display labels for each severity level
--------------------------------------------------------------------------------
Config.SeverityLabels = {
    [1] = 'Minor',
    [2] = 'Low',
    [3] = 'Moderate',
    [4] = 'High',
    [5] = 'Critical',
}

--------------------------------------------------------------------------------
-- CRIME SPAWN SETTINGS
-- General settings that apply to all crime spawning
--------------------------------------------------------------------------------
Config.CrimeSpawn = {
    -- Minimum distance from player to spawn a crime (prevents spawning too close)
    MinDistance = 50.0,
    
    -- Cooldown between crime spawns (in seconds)
    Cooldown = 60,
    
    -- Maximum active crimes at once per player
    MaxActiveCrimes = 3,
    
    -- Whether crimes can spawn while player is in a vehicle
    AllowWhileInVehicle = true,
    
    -- Whether to show blip on map for active crimes
    ShowBlip = true,
    
    -- Blip settings
    BlipSprite = 161,           -- Police blip
    BlipColor = 1,              -- Red
    BlipScale = 0.5,
}

--------------------------------------------------------------------------------
-- CRIME GENERATION TIMING
-- Controls how and when crimes are randomly generated during patrol
--------------------------------------------------------------------------------
Config.CrimeGeneration = {
    -- Initial delay before first crime spawns after starting patrol (in seconds)
    InitialDelay = 30,
    
    -- Minimum delay between crime generation attempts (in seconds)
    MinDelay = 60,
    
    -- Maximum delay between crime generation attempts (in seconds)
    MaxDelay = 180,
    
    -- Command to clear/complete the current crime
    ClearCommand = 'clearcrime',
}

--------------------------------------------------------------------------------
-- NPC INTERACTION SETTINGS
-- Controls how players interact with spawned NPCs (suspects, victims)
--------------------------------------------------------------------------------
Config.NPCInteraction = {
    -- Key to interact with surrendered/arrested NPCs (GTA control ID or key name)
    -- Control ID 38 = E key (INPUT_CONTEXT)
    InteractKey = 38,
    
    -- Maximum distance to interact with an NPC (in meters)
    InteractDistance = 3.0,
    
    -- Show text prompt when near an interactable NPC
    ShowPrompt = true,
    
    -- Text to display when near a surrendered suspect
    PromptText = '[E] Arrest Suspect',
    
    -- Whether to remove the NPC after interaction (arrest)
    RemoveOnArrest = true,
    
    -- Whether to show notification when interacting
    ShowNotification = true,
}

--------------------------------------------------------------------------------
-- DISPATCH PRIORITY SETTINGS
-- Enhanced dispatch system with priority levels 1-5
--------------------------------------------------------------------------------
Config.Dispatch = {
    -- Enable the enhanced dispatch system with NUI
    Enabled = true,
    
    -- Priority levels configuration
    -- Priority 1 = Minor (lowest), Priority 5 = Critical (highest)
    Priorities = {
        [1] = {
            label = 'CODE 1',
            name = 'Minor',
            color = 'green',
            expireTime = 45,      -- Seconds before dispatch expires
            soundRepeat = 1,      -- How many times to repeat the alert sound
        },
        [2] = {
            label = 'CODE 2',
            name = 'Low',
            color = 'yellow',
            expireTime = 40,
            soundRepeat = 2,
        },
        [3] = {
            label = 'CODE 3',
            name = 'Urgent',
            color = 'orange',
            expireTime = 35,
            soundRepeat = 2,
        },
        [4] = {
            label = 'CODE 4',
            name = 'Emergency',
            color = 'red',
            expireTime = 30,
            soundRepeat = 3,
        },
        [5] = {
            label = 'CODE 5',
            name = 'Critical',
            color = 'purple',
            expireTime = 25,
            soundRepeat = 4,
        },
    },
    
    -- Blip settings for accepted dispatches
    Blips = {
        -- How long accepted dispatch blips remain visible (seconds)
        Duration = 120,
        
        -- Sprite IDs per priority
        Sprites = {
            [1] = 280,   -- Information icon
            [2] = 161,   -- Police badge
            [3] = 161,   -- Police badge
            [4] = 58,    -- Crosshair
            [5] = 58,    -- Crosshair
        },
        
        -- Color IDs per priority (GTA blip colors)
        Colors = {
            [1] = 2,     -- Green
            [2] = 5,     -- Yellow
            [3] = 17,    -- Orange
            [4] = 1,     -- Red
            [5] = 49,    -- Purple
        },
    },
    
    -- Sound configuration per priority
    -- Using native GTA V sounds
    Sounds = {
        [1] = { sound = 'SELECT', soundset = 'HUD_FRONTEND_DEFAULT_SOUNDSET' },
        [2] = { sound = 'NAV_LEFT_RIGHT', soundset = 'HUD_FRONTEND_DEFAULT_SOUNDSET' },
        [3] = { sound = 'RACE_PLACED', soundset = 'HUD_AWARDS' },
        [4] = { sound = 'TIMER_STOP', soundset = 'HUD_MINI_GAME_SOUNDSET' },
        [5] = { sound = 'CHECKPOINT_AHEAD', soundset = 'HUD_MINI_GAME_SOUNDSET' },
    },
    
    -- Keybinds for dispatch interaction (when alert is shown)
    Keybinds = {
        Accept = 'E',    -- Key to accept/respond to dispatch
        Ignore = 'Q',    -- Key to ignore dispatch
    },
    
    -- Auto-expand minimap for high priority calls (priority 4+)
    ExpandMinimapOnHighPriority = true,
    
    -- Auto-set waypoint when accepting a dispatch
    AutoWaypoint = true,
}

