lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'YNGCeeZ'
description 'Enhanced Beauty Salon & Shop System with Customer-Employee Interactions'
version '2.4.0'

shared_scripts {
    '@ox_lib/init.lua',
    '@oxmysql/lib/MySQL.lua',
    'locales/locale.lua',
    'locales/*.lua',
    'config.lua',
    'hair/hair_tattoos.lua'
}

client_scripts {
    'shopping/cl_shopping.lua',
    'hair/cl_hair.lua',
    'nails/cl_nails.lua',
    'trap/cl_trap.lua',
    'tablet/cl_tablet.lua'
}

server_scripts {
    'shopping/sv_shopping.lua',
    'hair/sv_hair.lua',
    'nails/sv_nails.lua',
    'trap/sv_trap.lua',
    'tablet/sv_tablet.lua'
}

dependencies {
    'oxmysql',
    'ox_lib'
}

escrow_ignore {
    'config.lua',
    'Installables/dc_beauty_alt/alternateconfig.lua',
    'Installables/dc_beauty_alt/ReadMe.txt',
    'locales/locale.lua',
    'locales/en.lua',
    'locales/es.lua',
    'locales/fr.lua',
    'locales/de.lua',
    'locales/pt.lua',
    'locales/zh.lua',
    'locales/ja.lua'
}

files {
    'stream/yngprops.ytyp',
    'Installables/dc_beauty_alt/ReadMe.txt',
    'hair/html/*.html',
    'hair/html/*.js',
    'hair/html/*.css',
    'hair/html/img/*.svg',
    'hair/html/img/*.png'
}

ui_page 'hair/html/index.html'

data_file 'DLC_ITYP_REQUEST' 'stream/yngprops.ytyp'
dependency '/assetpacks'
