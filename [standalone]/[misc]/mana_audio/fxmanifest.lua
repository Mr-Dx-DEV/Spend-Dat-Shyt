server_script '@ElectronAC/src/include/server.lua'
client_script '@ElectronAC/src/include/client.lua'
shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
author 'Manason'
description 'API for playing native audio'
version '1.1.1'
server_scripts {
	'server/*'
}
client_scripts {
	'client/*'
}
lua54 'yes'
use_experimental_fxv2_oal 'yes'
