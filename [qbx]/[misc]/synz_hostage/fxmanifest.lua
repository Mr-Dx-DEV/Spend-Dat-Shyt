lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
name 'synz_hostage'
author 'Synz Labs'
description 'Advanced NPC Hostage & Robbery System'
version '2.0.1'
lua54 'yes'
ui_page 'html/index.html'
files {
    'html/index.html',
    'html/app.js',
    'html/style.css'
}
shared_scripts {    
    -- Uncomment the next line if you use ox_lib (recommended)
    --'@ox_lib/init.lua',
    'config.lua',
    'locales.lua',
    'bridge/shared.lua',
}
server_scripts {
    'bridge/sv_framework.lua',
    'server/webhook.lua',
    'server/main.lua',
}
client_scripts {
    'bridge/cl_framework.lua',
    'client/main.lua',
    'client/dispatch.lua',
}
escrow_ignore {
    'config.lua',
    'locales.lua',
    'bridge/*.lua',
    'client/dispatch.lua',
    'server/webhook.lua',
}
dependency '/assetpacks'
