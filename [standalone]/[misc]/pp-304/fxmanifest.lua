server_script '@ElectronAC/src/include/server.lua'
client_script '@ElectronAC/src/include/client.lua'
fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'pp-304'
author 'PP'
description 'Companion/date side job with laundering using ox_inventory, ox_lib, and ox_target'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}

escrow_ignore {
    'config.lua'
}

dependencies {
    'ox_lib',
    'ox_inventory',
    'ox_target'
}

dependency '/assetpacks'