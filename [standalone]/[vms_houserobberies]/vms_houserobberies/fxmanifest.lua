server_script '@ElectronAC/src/include/server.lua'
client_script '@ElectronAC/src/include/client.lua'
shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'vames™'
description 'vms_houserobberies'
version '1.0.7'
shared_scripts {
	'config/config.lua',
	'config/config.interiors.lua',
	'config/config.houseslist.lua',
	'config/config.items.lua',
	'config/config.configurator.lua',
	'config/config.translation.lua',
}
client_scripts {
	'config/config.client.lua',
	'client/*.lua',
}
server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'config/config.server.lua',
	'server/*.lua',
}
ui_page 'html/ui.html'
files {
	'html/*.*',
	'html/**/*.*',
	'config/*.json',
}
escrow_ignore {
	'config/*.lua',
	'server/version_check.lua'
}
dependency '/assetpacks'
