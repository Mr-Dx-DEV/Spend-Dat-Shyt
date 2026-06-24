fx_version 'cerulean'
game 'gta5'
author 'FearX'
description 'Persistent dirty-money laundering — ESX/QBCore/QBox compatible'
version '1.0.0'
lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    'configs/config.lua',
    'locales/*.lua',
}

client_scripts {
    'client/*.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'configs/sv_config.lua',
    'configs/bridges/inventory.lua',
    'server/sv_framework.lua',
    'server/sv_database.lua',
    'server/sv_discord.lua',
    'server/sv_restart.lua',
    'server/sv_main.lua',
    'server/sv_dispatch.lua',
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js',
}

dependencies {
    'ox_lib',
    'ox_target',
    'ox_inventory',
    'oxmysql',
}

escrow_ignore {
    'configs/*.lua',
    'configs/bridges/*.lua',
    'locales/*.lua',
}

dependency '/assetpacks'