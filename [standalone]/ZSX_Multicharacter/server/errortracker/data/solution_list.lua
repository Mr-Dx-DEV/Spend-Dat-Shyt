local list = {
    ['framework'] = {
        header = "Framework not detected",
        text = "That error happens when your framework either throws an error so the framework\n    object is not created or that you start Multicharacter before the framework.\n\n    ^2Fixing^7 (possibilities): \n      - check if your framework throws an error in ^3txAdmin > Live Console^7;\n      - change startup order in server.cfg so Multicharacter starts after \n            - ^2ensure [core]^7 (^2ESX^7)\n            - ^2ensure [qb]^7   (^2QBCore^7)\n            - ^2ensure [qbx]^7  (^2QBOX^7) ",
        docs = ""
    }, 
    ['is_config_multichar_enabled'] = {
        header = "Config.Multichar properly set",
        text = 'While ^1Config.Multichar^7 variable is not set to true it will automatically \n    create new character without proper data and identifier prefix. \n\n    ^2Fixing^7 (follow steps): \n      1. If you are on ESX Legacy 1.12 and above find ^3es_extended/shared/config/main.lua^7, \n         or if other version, go to ^3es_extended/config.lua^7\n      2. Find line ^1Config.Multichar = GetResourceState("esx_multicharacter") ~= "missing"^7\n      3. Change it to ^2Config.Multichar = true^7\n      4. Restart server',
        docs = ""
    },
    ['other_multichar_running'] = {
        header = "Other Multicharacter is running",
        text = "If other instance of Multicharacter is running it needs to be either removed or stopped from starting at all.",
        docs = ""
    },
    ['user_prefix_proper'] = {
        header = "Identifier prefix correct",
        text = "Multicharacter detected that one/some of your characters list in users table \n    does not follow the required template. \n\n    ^2Fixing^7 (choose one): \n      - use ^2multicharacter_esx_remove_users^7 command in ^3txAdmin > Live Console^7;\n      - manually remove characters without "..(Config.Prefix).." prefix in identifier column from ^2users^7 table \n        in database;",
        docs = ""
    },
}

return list