-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
fx_version 'cerulean'
game 'gta5'
lua54 'yes'

description 'Wasabi ESX/QBCore Evidence System'
author 'wasabirobby'
version '1.1.5'

shared_scripts { '@ox_lib/init.lua', '@wasabi_bridge/import.lua', 'configuration/*.lua' }

client_scripts { 'client/*' }

server_scripts { '@oxmysql/lib/MySQL.lua', 'server/*.lua' }

dependencies { 'oxmysql', 'ox_lib', 'wasabi_bridge' }

escrow_ignore {
  'configuration/*.lua',
  'client/client.lua',
  'client/cl_customize.lua'
}

dependency '/assetpacks'