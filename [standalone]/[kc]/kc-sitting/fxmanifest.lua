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
name 'KC Sit Anywhere'
description 'Sit anywhere, as simple as it sounds'
github 'https://github.com/clementinise/kc-sitting'
version '1.3.1'

shared_scripts {
	'locales/*.lua',
	'config.lua'
}

client_script 'client/client.lua'

server_script 'server/server.lua'

escrow_ignore {
  'config.lua',
  'locales/*.lua'
}

fivem_checker 'yes'
dependency '/assetpacks'
