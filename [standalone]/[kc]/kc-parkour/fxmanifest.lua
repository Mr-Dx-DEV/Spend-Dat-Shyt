lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'Clementinise'
name 'KC Parkour'
description 'Experience the Art of Parkour'
github 'https://github.com/clementinise/kc-parkour'
version '1.2'

shared_script 'locales/*.lua'

client_scripts {
	'config.lua',
	'client/custom_functions.lua',
	'client/client.lua'
}

server_script {
	'config.lua',
	'server/server.lua'
}

escrow_ignore {
	'config.lua',
	'client/custom_functions.lua',
	'locales/*.lua'
}

fivem_checker 'yes'
dependency '/assetpacks'
