fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'sleezy_greenzone_creator'
author 'Sleezy Development'
description 'Sleezy Development - Advanced Greenzone Creator'
version '1.2.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    'client/main.lua'
}

server_scripts {
    'server/main.lua'
}

files {
    'zones.json',
    'README.md'
}

dependencies {
    'ox_lib',
    'PolyZone'
}

escrow_ignore {
    'config.lua',
    'README.md',
    'zones.json'
}

dependency '/assetpacks'