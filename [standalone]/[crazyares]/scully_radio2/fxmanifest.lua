server_script '@ElectronAC/src/include/server.lua'
client_script '@ElectronAC/src/include/client.lua'
fx_version 'cerulean'

game 'gta5'

author 'https://discord.gg/scully'
description 'v2 of very noice radio'
version '2.6'

dependencies {
	'/server:5402',
	'/onesync',
	'pma-voice'
}

lua54 'yes'

shared_scripts {
	'config.lua',
	'functions/*.lua'
}

client_scripts {
	'client/*.lua'
}

server_scripts {
	'server/*.lua'
}

escrow_ignore {
	'config.lua',
	'functions/*.lua',
	'ox_inventory_items.lua',
	'qb-inventory_items.lua',
	'talkover_protection.lua'
}

ui_page 'ui/index.html'

files {
    'ui/index.html',
    'ui/*.css',
	'ui/*.js',
	'ui/images/**/*.png'
}

dependency '/assetpacks'
dependency '/assetpacks'