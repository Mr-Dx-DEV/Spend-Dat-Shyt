--[[
Configuration for Permissions
This script manages permission settings for a system with optional integration
for Discord, licensing, and ACE permissions.
]]

permissionConfig = {}

--[[
requirePermission:
If set to `true`, permission checks will be enforced. Set to `false` to disable 
permission requirements entirely.
]]
permissionConfig.requirePermission = true

--[[
Discord Configuration:
Handles integration with a Discord server to manage permissions.
- enabled: Enable or disable Discord-based permission management.
- serverId: The Discord server's unique identifier.
- token: The bot token for connecting to the Discord server (keep this secure).
- roles: A list of Discord role IDs that are granted permissions.
- users: A list of specific Discord user IDs granted permissions.
]]
permissionConfig.discord = {
    enabled = false, -- Set to `true` to enable Discord integration
    serverId = '', -- Replace with your Discord server ID
    token = '', -- Replace with your bot token (do not share publicly!)
    roles = {123456789101112}, -- Replace with Discord role IDs allowed access
    users = {} -- Add specific Discord user IDs if needed
}

--[[
License Configuration:
Handles permissions based on predefined license keys.
- enabled: Enable or disable license-based permission management.
- licenses: A list of valid license keys allowed access.
]]
permissionConfig.license = {
    enabled = true, -- Set to `true` to enable license-based permissions
    licenses = {"license:b374825af27db3c5eec096fb9be72245f23a3327"} -- Replace with valid license keys
}

--[[ 
Job Configuration:
Controls access to features based on the player's in-game job.
- enabled: Enable or disable job-based permission management.
- job: The specific job name required to access the features (e.g., 'fraudster').
]]
permissionConfig.job = {
    enabled = true,
    job = 'fraudster'
}

--[[
ACE Permission Configuration:
Handles permissions using ACE (Access Control Entry) identifiers in FiveM.
- enabled: Enable or disable ACE-based permission management.
- ace: The ACE permission string to be used in the system.

Example:
To grant access to a specific license:
    add_ace identifier.license:licensehere "devm-fraud.laptopAccess" allow
]]
permissionConfig.ace = {
    enabled = true, -- Set to `true` to enable ACE permissions
    ace = 'devm-fraud.laptopAccess' -- Replace with your ACE permission string
}
