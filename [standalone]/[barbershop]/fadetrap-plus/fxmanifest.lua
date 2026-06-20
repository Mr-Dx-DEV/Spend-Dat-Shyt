server_script '@ElectronAC/src/include/server.lua'
client_script '@ElectronAC/src/include/client.lua'
shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'YNGCeeZ'
description 'The Fade Trap Plus - Premium Barbershop & Street Hustle'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
    'hair/hair_tattoos.lua'
}

client_scripts {
    'core/cl_core.lua',
    'hair/cl_hair.lua',
    'trap/cl_trap.lua',
    'tablet/cl_tablet.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'core/sv_core.lua',
    'hair/sv_hair.lua',
    'trap/sv_trap.lua',
    'tablet/sv_tablet.lua'
}

dependencies {
    'ox_lib',
    'oxmysql'
}

escrow_ignore {
    'config.lua',
}

files {
    'stream/yngbarberprops.ytyp',
    'hair/html/index.html',
    'hair/html/style.css',
    'hair/html/script.js',
    'hair/html/img/*.svg',
    'hair/html/img/*.png'
}

ui_page 'hair/html/index.html'

 data_file 'DLC_ITYP_REQUEST' 'stream/yngbarberprops.ytyp'
dependency '/assetpacks'
