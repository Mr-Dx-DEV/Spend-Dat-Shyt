fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'nex_hotels'
author 'NEX Development | Donk'
version '1.0.5'
description 'Hotel system with in-game admin setup | Multi-Framework'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
    'locale.lua',
}

client_scripts {
    'bridge/framework.lua',
    'client/*.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'bridge/sv_framework.lua',
    'server/*.lua',
}

ui_page 'web/build/index.html'

files {
    'web/build/index.html',
    'web/build/assets/*.js',
    'web/build/assets/*.css',
    'locales/*.json',
}

dependencies {
    'oxmysql',
    'ox_lib',
}

escrow_ignore {
    'config.lua',
    'locale.lua',
    'locales/*.json',
    'bridge/framework.lua',
    'bridge/sv_framework.lua',
}
dependency '/assetpacks'