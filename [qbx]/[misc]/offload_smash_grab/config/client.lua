--=============================================================================
-- SMASH & GRAB - CLIENT CONFIGURATION
--=============================================================================
-- This file controls how the script behaves for players
-- Customize gameplay settings, visuals, and interactions here
--=============================================================================

return {
    
    --=============================================================================
    -- DEBUG SETTINGS
    --=============================================================================
    -- Only enable these when testing or troubleshooting issues
    -- Show debug blips on map to locate loot vehicles easily
    DebugBlips = false,
    
    -- How debug blips appear on the map (only matters if DebugBlips is true)
    DebugBlipSprite = 225,     -- Icon type (225 = dollar sign)
    DebugBlipColour = 47,      -- Color of the blip
    DebugBlipScale = 0.5,     -- Size of the blip
    DebugBlipName = 'Smash&Grab Loot', -- Text shown when hovering blip
    
    
    --=============================================================================
    -- DETECTION SETTINGS
    --=============================================================================
    -- How the script finds vehicles with loot
    
    -- How far to scan for loot vehicles (in game units)
    -- Default: 45.0 (larger = more CPU usage)
    ScanRadius = 45.0,
    
    -- How often to scan for vehicles (in milliseconds)
    -- Default: 5000 (5 seconds) - lower = more responsive but more CPU usage
    ScanIntervalMs = 5000,
    
    -- How close players need to be to interact with vehicle
    -- Default: 1.8 (game units)
    TargetDistance = 2.0,
    
    
    --=============================================================================
    -- TIMING SETTINGS
    --=============================================================================
    -- How long different actions take
    
    -- Time to smash a window (in milliseconds)
    -- Default: 2500 (2.5 seconds)
    SmashDurationMs = 2500,
    
    -- Time to grab loot from vehicle (in milliseconds)
    -- Default: 10000 (10 seconds)
    LootDurationMs = 10000,
    
    
    --=============================================================================
    -- POLICE/DISPATCH SETTINGS
    --=============================================================================
    -- Alert system when players smash windows
    
    -- Enable police dispatch alerts when windows are smashed
    -- Default: true
    Dispatch = true,
    DispatchChance = 0.5, -- Chance of dispatch alert (0.0 to 1.0)
    
    
    --=============================================================================
    -- VEHICLE RESTRICTIONS
    --=============================================================================
    -- Which vehicle types cannot have loot
    
    -- Vehicle classes that won't spawn loot (blacklist)
    -- 8 = Motorcycles, 13 = Cycles, 14 = Boats, 15 = Helicopters, 16 = Planes
    blacklistClasses = {8, 13, 14, 15, 16},
    
    
    --=============================================================================
    -- POSITIONING SETTINGS
    --=============================================================================
    -- Where loot bags appear in vehicles
    
    -- Which part of the vehicle to attach the loot bag
    -- 'seat_pside_f' = passenger seat
    AttachBone = 'seat_pside_f',
    
    -- Position offset for the loot bag (fine-tune placement)
    AttachOffset = vec3(0.0, 0.05, 0.1),
    
    -- Rotation of the loot bag (fine-tune orientation)
    AttachRot = vec3(0.0, 0.0, 90.0),
    
    
    --=============================================================================
    -- ANIMATION SETTINGS
    --=============================================================================
    -- How players look when performing actions
    
    -- Animation for smashing windows
    SmashAnim = { 
        dict = 'missheist_jewel',  -- Animation dictionary
        clip = 'smash_case',       -- Animation name
        flag = 49                  -- Animation flags
    },
    
    -- Animation for grabbing loot
    LootAnim = { 
        dict = 'anim@heists@ornate_bank@grab_cash',  -- Animation dictionary
        clip = 'grab',                                  -- Animation name
        flag = 49                                      -- Animation flags
    },
    
    
    --=============================================================================
    -- REQUIREMENTS SETTINGS
    --=============================================================================
    -- What players need to interact
    
    -- Item required to smash windows (false = no item needed)
    -- Examples: 'WEAPON_CROWBAR', 'lockpick', false
    RequiredItem = false, -- e.g. 'WEAPON_CROWBAR'
    RequiredHoldOnHands = false, -- set true if above is a weapon and must be held to interact
    
    -- Which window to smash (1 = front passenger window)
    -- Default: 1
    WindowIndex = 1,
    
    
    --=============================================================================
    -- TEXT/LABEL SETTINGS
    --=============================================================================
    -- What players see in-game
    
    -- Text shown when looking at vehicle (before smashing)
    SmashLabel = 'Smash window',
    
    -- Text shown when looking at smashed vehicle (to grab loot)
    LootLabel = 'Grab bag',
    
    -- Police dispatch alert title
    DispatchTitle = 'Vehicle Theft',
    
    -- Police dispatch alert code
    DispatchCode = '10-31',
    
    -- Progress bar text while smashing
    SmashProgressLabel = 'Smashing window...',
    
    -- Progress bar text while grabbing loot
    LootProgressLabel = 'Grabbing bag...',
    
    
    --=============================================================================
    -- CUSTOMIZATION GUIDE
    --=============================================================================
    -- 
    -- CHANGING TIMES:
    -- - SmashDurationMs: Make window smashing faster/slower
    -- - LootDurationMs: Make looting faster/slower
    --
    -- CHANGING DIFFICULTY:
    -- - Set RequiredItem to 'weapon_crowbar' or another item name
    -- - Increase ScanRadius to make loot vehicles easier to find
    -- - Decrease TargetDistance to require players to be closer
    --
    -- CHANGING POLICE RESPONSE:
    -- - Set Dispatch to false to disable police alerts
    -- - Change DispatchTitle and DispatchCode for different alert types
    --
    -- CHANGING ANIMATIONS:
    -- - Modify SmashAnim or LootAnim to change how players look
    --
    -- CHANGING TEXT:
    -- - Update any Label settings to change in-game text
    -- - Supports any text you want to show players
    --
    --=============================================================================
}
