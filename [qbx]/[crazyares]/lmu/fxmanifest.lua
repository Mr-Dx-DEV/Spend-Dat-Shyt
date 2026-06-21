fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'grim_lovemenu'
author 'Grim Development'
description 'Grims Love Menu'
version '2.0.1'
provide 'grim_lovemenu'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/assets/css/tablet.css',
    'html/assets/grim_logo.png',
    'html/assets/js/app.js',
    'html/assets/js/tablet.js',
    'html/assets/sfx/click.wav',
    'html/assets/sfx/open.wav',
    'html/assets/sfx/success.wav',
    'html/assets/sfx/error.wav',
    'inventory_images/*.png',
    'data/items.lua'
}

exports {
    'useLoveTablet',
    'usePregnancyTest',
    'usePrenatalVitamins',
    'useContraception',
    'useCondoms',
    'useSTDTest',
    'usePrescriptionMeds',
    'usePlanC',
    'useDNATest',
    'useDNAResult',
    'useBirthCertBoy',
    'useBirthCertGirl',
    'useUltrasoundReport',
    'useRhinoPill',
    'useLubricant'
}

shared_scripts {
    '@ox_lib/init.lua',
    'shared/config.lua',
    'shared/items.lua'
}

client_scripts {
    'client/cl_bridge.lua',
    'client/cl_main.lua',
    'client/cl_tablet.lua',
    'client/cl_animations.lua',
    'client/cl_pregnancy.lua',
    'client/cl_health.lua',
    'client/cl_pharmacy_zone.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/sv_main.lua',
    'server/sv_tablet_rebuild.lua',
    'server/sv_pregnancy.lua',
    'server/sv_health.lua',
    'server/sv_coffee.lua',
    'server/sv_brocode.lua'
}

dependencies {
    'ox_lib',
    'oxmysql'
}
