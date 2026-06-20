server_script '@ElectronAC/src/include/server.lua'
client_script '@ElectronAC/src/include/client.lua'
fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Kodeinee Studios'
description 'Kodeinee Starter Pack - Multi Framework Starter Pack System'
version '2.0.0'

shared_scripts {
    'config.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'bridge.lua',
    'server.lua'
}

client_script 'client.lua'

escrow_ignore {
    'config.lua'
}

dependency '/assetpacks'