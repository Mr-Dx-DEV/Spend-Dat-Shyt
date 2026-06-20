server_script '@ElectronAC/src/include/server.lua'
client_script '@ElectronAC/src/include/client.lua'
shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
games { 'gta5' }

author 'HoboDevCo'
description 'SDC | Core Resource'
version '1.1.4'

shared_script {
    "@ox_lib/init.lua",
    "config/config.lua"
}

client_scripts {
    "src/client/client.lua"
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "config/server_config.lua",  
    "src/server/server.lua",  
}

escrow_ignore {
    "config/config.lua",
    "config/server_config.lua",  
    "src/client/client.lua",
    "src/server/server.lua"
}

lua54 'yes'
dependency '/assetpacks'
