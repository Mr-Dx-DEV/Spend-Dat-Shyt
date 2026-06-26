--- ######################### ---
--- ## DISCORD.GG/CODEWAVE ## ---
--- ######################### ---

Config = {}

Config.Framework = 'QBCore' -- ESX or 'QBCore' (CASE SENSITIVE)

Config.NpcStartLocation = vector3(-702.6689, 57.4965, 44.0587)
Config.NpcHeading = 180.0
Config.ForceFirstPerson = true  -- Change this to false if you don't want to force first-person mode

-- Repair spots (ADD AS MANY AS YOU WANT! THE MORE THE MERRIER!)
Config.RepairPoints = {
    {x = -701.5648, y = 66.7557, z = 44.0587},
    {x = -720.3300, y = 58.6259, z = 44.0587},
    {x = -707.7178, y = 74.8162, z = 44.0587},
    {x = -722.4176, y = 91.3815, z = 44.0864}

}

-- Loot areas 
-- Define search spot locations with props
Config.LootAreas = {
    {x = -725.9214, y = 69.4938, z = 44.0863, prop = "prop_bin_01a", searched = false},
    {x = -727.1409, y = 83.1262, z = 44.086, prop = "prop_bin_02a", searched = false},
    {x = -722.5403, y = 86.3777, z = 44.0864, prop = "prop_bin_03a", searched = false},
    {x = -710.1370, y = 92.2892, z = 44.0864, prop = "prop_bin_04a", searched = false},
    {x = -705.0757, y = 100.0999, z = 44.086, prop = "prop_bin_05a", searched = false},
    {x = -698.0838, y = 78.0752, z = 44.086, prop = "prop_bin_06a", searched = false},
    {x = -691.609, y = 72.2656, z = 44.086, prop = "prop_bin_07a", searched = false}
}


-- Rewards Table: Each item has a chance value (higher = more common)
-- ADD WHATEVER ITEMS YOU WANT HERE
Config.Rewards = {
    { item = "water", amount = 1, chance = 50 }, -- 50% chance to get bread
    { item = "tosti", amount = 1, chance = 50 } -- 50% chance to get water
}

-- Hint locations (you can add as many hints as you want? Just a side feature nothing special)
Config.HintSpots = {
    {x = -709.8845, y = 69.7487, z = 44.0587, hint = 'What happened here?'}
}


-- Range within which we consider a door "close"
Config.DoorInteractionRange = 5.0


-- Escape door coordinates
Config.EscapeDoor = {x = -706.2228, y = 63.4549, z = 44.0587} -- this is where the player has to go to teleport out
Config.EscapePoint = vector3(-700.7775, 51.5521, 44.0587) -- This is where the player is teleported back when escaping

-- Timing and game settings 
Config.RepairTime = 5000  -- 5 seconds for repairs
Config.EscapeTime = 1000  -- 5 seconds to open escape door
Config.InteractionRange = 2.0  -- Range to interact with repair points