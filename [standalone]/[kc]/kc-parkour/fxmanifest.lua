server_script '@ElectronAC/src/include/server.lua'
client_script '@ElectronAC/src/include/client.lua'
shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
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
