server_script '@ElectronAC/src/include/server.lua'
client_script '@ElectronAC/src/include/client.lua'
fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Jimboo Studios & Illu Development'
description 'Phone Chargingstation & Powerbank for LB-Phone [ESX & QBCORE]'
version '3.0.0'

shared_script 'config.lua'

client_script {
    'client/client.lua',
}

server_script {
    'server/server.lua',
    'server/version.lua'
}

dependencies {
    'lb-phone'
}

escrow_ignore{
    'config.lua',
    '/XITEM IMAGES/*',
}

dependency '/assetpacks'