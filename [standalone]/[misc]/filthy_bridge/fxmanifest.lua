server_script '@ElectronAC/src/include/server.lua'
client_script '@ElectronAC/src/include/client.lua'
fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author "Filthy Development"
description "Bridge library for Filthy Scripts"
version "1.0.2"

shared_script {'config.lua', 'callback/shared.lua', '@ox_lib/init.lua'}

client_scripts {
    'bridge.lua',
    'callback/client.lua',
    'frameworks/**/client.lua',
    'targets/*.lua',
    'inventories/**/client.lua',
    'dispatch/**/client.lua',
    'fuel/*.lua',
    'utils/client/*.lua'
}

server_scripts {
    'bridge.lua',
    'callback/server.lua',
    '@oxmysql/lib/MySQL.lua',
    'frameworks/**/server.lua',
    'inventories/**/server.lua',
    'dispatch/**/server.lua',
    'banking/*.lua',
    'keys/*.lua',
    'fuel/*.lua',
    'utils/server/*.lua'
}

files { 'import.lua' }

dependencies { 'oxmysql', 'ox_lib' }

escrow_ignore {
    'config.lua',
    'bridge.lua',
    'frameworks/**/*.lua',
    'targets/*.lua',
    'inventories/**/*.lua',
    'dispatch/**/*.lua',
    'banking/*.lua',
    'keys/*.lua',
    'fuel/*.lua'
}

dependency '/assetpacks'