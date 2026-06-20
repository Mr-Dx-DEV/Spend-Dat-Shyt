server_script '@ElectronAC/src/include/server.lua'
client_script '@ElectronAC/src/include/client.lua'
shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
games { 'gta5' }

author 'HoboDevCo'
description 'SDC | Car Builder Script'
version '1.1.7'

shared_script {
    "@ox_lib/init.lua",
    "config/config.lua",
    "config/lang.lua"
}

client_scripts {
    "src/client/client_customize_me.lua",
    "src/client/client.lua"
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "src/server/server_customize_me.lua",
    "src/server/server.lua",   
}

escrow_ignore {
    "config/config.lua",
    "config/lang.lua",
    "src/client/client_customize_me.lua",
    "src/server/server_customize_me.lua",
    "FRAMEWORK-FILES/*/*.lua"
}


lua54 'yes'

dependencies {
    'SDC_Core',
    '/onesync'
}
dependency '/assetpacks'
