fx_version 'cerulean'
game 'gta5'

description "Direct Billing/Invoice System For Whitelisted Jobs"
author "LoadedxDiaper"
website "https://partay.tebex.io/"
discord "https://discord.gg/partaystudios"
version "1.0.0"

lua54 'yes'

shared_scripts {
  '@ox_lib/init.lua',
  'config.lua',
  'shared/direct.lua',
  'locales/en.lua',
  'shared/locale.lua',
  'shared/utils.lua',
}

client_scripts {
  'client/main.lua',
}

server_scripts {
  'server/adapters.lua',
  'server/main.lua',
}

escrow_ignore {
	'config.lua',
}

dependencies {
  'ox_lib',
  'ox_target',
  'ox_inventory',
}

dependency '/assetpacks'