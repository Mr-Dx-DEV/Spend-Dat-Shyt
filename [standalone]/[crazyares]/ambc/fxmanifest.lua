shared_script '@WaveShield/resource/include.lua'

description 'ammo boxes'
author 'donk'
version '1.0.0'

fx_version 'cerulean'
game 'gta5'
lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    'shared/config.lua',
    'locales/*.lua',
}

client_scripts {
    'client/*.lua',
}

server_scripts {
    'server/*.lua',
}

dependencies {
    'ox_lib',
    'ox_inventory',
    'qbx_core',
}