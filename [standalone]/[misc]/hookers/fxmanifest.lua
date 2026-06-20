server_script '@ElectronAC/src/include/server.lua'
client_script '@ElectronAC/src/include/client.lua'
shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'Mads'
description 'Hookers'
version '1.1.0'
shared_script 'config.lua'
client_scripts {
    'menu.lua',
    'client.lua'
}
server_script 'server.lua'
dependencies {
	'/gameBuild:2060' -- Needed due to usage of game events.
}
