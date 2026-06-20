Config = {}

-- 'auto', 'esx', 'qb', 'standalone'
Config.Framework = 'auto'

-- /blipcreator
Config.Command = 'blipcreator'

-- Who can open it
Config.Permissions = {
    UseAce = true,
    AcePermission = 'wavy_blipcreator.use', 

    ESXGroups = { 'admin', 'superadmin', 'mod' },

    QBPermissions = { 'god', 'admin', 'mod' }
}

Config.Storage = {
    FileName = 'data/blips.json'
}

Config.Defaults = {
    Scale = 1.0,
    Sprite = 1,
    Radius = 0.0,
    ColorIdFallback = 1 -- red fallback if unknown
}

Config.Radius = {
    MaxMeters = 250.0, 
    Alpha = 90         
}

-- NOTE: GTA supports only color IDs, not true HEX, so we map your palette to closest usable IDs.
Config.ColorMap = {
    -- neutrals
    ["#FFFFFF"] = 0,  
    ["#AAAAAA"] = 0,
    ["#666666"] = 0,
    ["#000000"] = 1,   
    ["#FF0000"] = 1,
    ["#8B0000"] = 1,
    ["#FF6347"] = 1,
    ["#FF4500"] = 1,
    ["#FF69B4"] = 7,
    ["#FFB6C1"] = 7,
    ["#00FF00"] = 2,
    ["#7CFC00"] = 2,
    ["#ADFF2F"] = 2,
    ["#00FA9A"] = 2,
    ["#0000FF"] = 3,
    ["#1E90FF"] = 3,
    ["#4169E1"] = 3,
    ["#00BFFF"] = 3,
    ["#00FFFF"] = 3,
    ["#40E0D0"] = 3,
    ["#7FFFD4"] = 3,
    ["#B0E0E6"] = 3,
    ["#87CEFA"] = 3,
    ["#FFFF00"] = 5,
    ["#FFD700"] = 5,
    ["#FFA500"] = 5,
    ["#FF7F50"] = 5,
    ["#FF00FF"] = 7,
    ["#8A2BE2"] = 7,
    ["#6A5ACD"] = 7,
    ["#BA55D3"] = 7,
    ["#9400D3"] = 7,
    ["#4B0082"] = 7,
    ["#EE82EE"] = 7,
    ["#DDA0DD"] = 7,
    ["#800080"] = 7,
    ["#008080"] = 3,
    ["#000080"] = 3,
    ["#808000"] = 5,
    ["#008000"] = 2,
}
