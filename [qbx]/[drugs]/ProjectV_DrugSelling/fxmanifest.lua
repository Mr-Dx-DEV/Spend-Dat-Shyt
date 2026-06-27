fx_version 'cerulean'
game 'gta5'
lua54 'yes'

version '1.0.0'

author 'ProjectV - GM'
description 'ProjectV Drug Selling'

shared_script {
    '@ox_lib/init.lua',
    'config.lua'
}

server_script {
    '@mysql-async/lib/MySQL.lua',
	'server/*.lua',
}

client_script {
	'client/*.lua',
}

escrow_ignore {
    'config.lua'
}

dependency 'ox_inventory'
dependency '/assetpacks'

dependency '/assetpacks'