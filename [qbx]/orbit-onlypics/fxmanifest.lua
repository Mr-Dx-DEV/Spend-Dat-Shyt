fx_version 'cerulean'
game 'gta5'
author 'Orbit Scripts'
description 'Orbit Scripts - OnlyPics V2 Exclusive Female Job'
version '2.0.3'

shared_scripts {
    '@ox_lib/init.lua',
    '@oxmysql/lib/MySQL.lua',
    'shared/config.lua',
    'shared/framework.lua',
    'shared/ui.lua'
}

server_scripts {
    'server/server.lua'
}

client_scripts {
    'client/client.lua'
}

dependencies {
    'oxmysql',
    'screenshot-basic'
}

ui_page 'html/index.html'

files {
    'html/index.html'
}

-- Escrow Ignore
escrow_ignore {
    'shared/config.lua',
    'shared/framework.lua',
    'shared/ui.lua',
    'install/*.lua'
}
dependency '/assetpacks'