lua54 "yes" -- needed for Reaper

fx_version 'cerulean'

game 'gta5'
author 'DevM | Created by sizzledevss'
lua54 'yes'
version '2.1.4'
discord 'discord.gg/devm'


shared_scripts {
    '@ox_lib/init.lua',
    'locales/*.lua',
    'configs/config.lua',
    'configs/crypto_config.lua',
    'configs/dumps_config.lua',
    'configs/props_config.lua',
    'configs/sims_config.lua',
    'configs/wifi_config.lua',
    'configs/shop_config.lua',
    'configs/cheque_config.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'configs/permission_config.lua',
    'configs/payout_config.lua',
    'configs/gecko_config.lua',
    'server/*'
}

client_scripts {
    'client/*'
}

ui_page 'web/dist/index.html'
files {
    'web/dist/index.html',
    'web/dist/assets/*.js',
    'web/dist/assets/*.css',
    
    'web/dist/index.html',
    'web/dist/Group_24.png',
    'web/dist/vite.svg',


    'web/dist/assets/*',
    'web/dist/flags/*'
}

dependencies {
    '/server:9515'
}

file 'stream/msi_cardreader.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/msi_cardreader.ytyp'

escrow_ignore {
    'configs/*.lua',
    'client/open.lua',
    'locales/*.lua'
}
dependency '/assetpacks'
