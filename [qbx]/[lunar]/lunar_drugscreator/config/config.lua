/*
    THANKS FOR PURCHASING OUR DRUGS CREATOR SCRIPTS! <3
    
    Target, 3D prompts, dispatch, notifications and progress bar can be configured in lunar_bridge/config
    Want to use dirty money item as an account? Configure it in lunar_bridge/config/config.lua

    Need help with the script?
    Join our discord, claim the customer role and open a support ticket:
    https://discord.gg/AAuvQYgyqX
*/

Config = {}

-- The command to open up the menu
Config.command = 'drugscreator'

-- The /drugscreator menu locales are separate from the normal in-game locales
-- You can find them in web/dist/locales
Config.uiLanguage = 'en'

-- You can add a font name here
-- Don't add <font face=""> etc., just add the font name
Config.blipsFont = ''

-- The groups that can use /drugscreator
-- Ignore this if you're on qb-core and use this inside server.cfg: add_ace group.admin drugscreator_admin allow
Config.adminGroups = {
    ['admin'] = true,
    ['god'] = true
}

-- Retail Selling: Ped Model Exclusion List
-- Add ped model hashes here to exclude them from being used as retail selling targets
-- This applies to ALL retail selling zones
-- Useful for excluding NPCs that serve other functions (e.g., shop owners, quest givers, etc.)
-- You can find ped model names at: https://docs.fivem.net/docs/game-references/ped-models/
Config.retailSellingExcludedPeds = {
    -- Example entries (uncomment to use):
    -- `mp_m_shopkeep_01`,  -- Shop keeper
    -- `s_m_y_cop_01`,      -- Male cop
    -- `s_f_y_cop_01`,      -- Female cop
}
-- Instance Placement Restrictions
-- Set to true to prevent placing items in any instance (routing bucket != 0)
-- Set to false (default) to allow placing items anywhere (original behavior)
Config.disableTablePlacingInInstances = false   -- Prevents placing processing tables in instances
Config.disablePlantingInInstances = false       -- Prevents planting in instances
Config.disableLampPlacingInInstances = false    -- Prevents placing lamps in instances