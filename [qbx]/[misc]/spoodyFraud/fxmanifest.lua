fx_version 'cerulean'
author 'spoodyCreations'
version '4.0.4'
game 'gta5'
lua54 'yes'

ui_page 'dist/index.html'

files {
    'stream/spoody_leansy_laptop.ytyp',
    'dist/**/*',
    'dist/*',
}

shared_scripts  {
    'config/configuration.lua',
    'config/locales.lua',
    '@ox_lib/init.lua',
}

client_scripts {
    'config/tutorial.lua',
    'game/client/functions/*.lua',
    'game/client/world/*.lua',
    'game/client/*.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'game/server/*.lua',
    'config/discord.lua'
}

data_file 'DLC_ITYP_REQUEST' 'stream/spoody_leansy_laptop.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/leansy_reader.ytyp'

escrow_ignore {"config/configuration.lua", "config/discord.lua", "config/locales.lua", "config/tutorial.lua", "game/server/alert.lua", "game/server/discord.lua"}
dependency '/assetpacks'