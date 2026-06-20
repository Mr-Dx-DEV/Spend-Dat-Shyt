fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'fsg_cooking'
author 'fsg-scripts'
description 'An advanced cooking script that allows you to cook food and create drinks also.'
version '1.0.6'

shared_scripts {
    '@ox_lib/init.lua',
    'config/config.lua',
    'config/appliances.lua',
    'config/recipes.lua',
    'config/decorations.lua',
    'config/stores.lua',
    'config/consumables.lua',
    'locales/localesManager.lua',
}

client_scripts {
    '@qbx_core/modules/playerdata.lua', -- UNCOMMENT IF YOU ARE USING QBOX FRAMEWORK
    'bridge/**/client.lua',
    'client/*.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'bridge/**/server.lua',
    'server/*.lua'
}

files {
    'build/assets/*',
    'build/*',
    'stream/props_fsg_cooking.ytyp',
    'locales/json/*.json',
}

ui_page 'build/index.html'

dependencies {
    'ox_lib',
}

escrow_ignore {
    'config/*.lua',
    '[installation]/**/*.lua',
    'bridge/**/*.lua',
}

data_file 'DLC_ITYP_REQUEST' 'stream/props_fsg_cooking.ytyp'
dependency '/assetpacks'