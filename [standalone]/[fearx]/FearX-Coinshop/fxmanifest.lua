fx_version 'cerulean'
game 'gta5'

author 'FearX Scripts'
description 'FearX Coin Shop - Premium in-game shop with coin currency'
version '1.1.2'

lua54 'yes'

dependencies {
    'ox_lib',
    'oxmysql',
    'fearx_bridge',
}

shared_scripts {
    '@ox_lib/init.lua',
    'configs/config.lua',
    'locales/_init.lua',
    'locales/en.lua',
    'locales/de.lua',
    'locales/es.lua',
    'locales/fr.lua',
    'locales/it.lua',
    'locales/nl.lua',
    'locales/pl.lua',
    'locales/pt.lua',
}

client_scripts {
    'editable/cl_custom.lua',
    'client/cl_main.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'configs/sv_config.lua',
    'editable/sv_custom.lua',
    'server/sv_main.lua',
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/globals.css',
}

escrow_ignore {
    'configs/config.lua',
    'configs/sv_config.lua',
    'locales/*.lua',
    'editable/*.lua',
}

dependency '/assetpacks'