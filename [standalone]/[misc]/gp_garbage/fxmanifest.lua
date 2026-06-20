server_script '@ElectronAC/src/include/server.lua'
client_script '@ElectronAC/src/include/client.lua'
shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'G Pochico'
description 'Simple script for persistent dumpster inventories'
client_scripts {
    'client/client.lua'
}
server_scripts {
    'server/server.lua',
    'server/functions.lua',
    '@oxmysql/lib/MySQL.lua'
}
shared_scripts {
    '@es_extended/imports.lua',
    'config.lua',
    '@ox_lib/init.lua'
}
dependencies {
    'ox_inventory'
}
