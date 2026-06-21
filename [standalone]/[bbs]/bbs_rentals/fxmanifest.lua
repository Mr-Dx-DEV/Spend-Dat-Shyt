lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Big Bang Studios'
description 'Rental script by BBS'

client_scripts {
	'client/functions.lua',
	'client/main.lua',
	'client/nui.lua'
}

server_scripts {
	'server/functions.lua',
	'server/framework.lua',
	'server/main.lua',
	'server/callbacks.lua'
}

shared_scripts {
	'shared/*.lua',
	'@ox_lib/init.lua'
}

ui_page 'nui/dist/index.html'

files {
	'dui/dist/**/**',
	'dui/dist/**',
	'nui/dist/**/**',
	'nui/dist/**',
	'assets/**'
}

escrow_ignore {
  'shared/**',
  'server/framework.lua',
}

dependency 'ox_lib'
dependency '/assetpacks'
