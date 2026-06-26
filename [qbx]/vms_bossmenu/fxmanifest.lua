fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'vames™'
description 'vms_bossmenu'
version '1.0.6'

shared_scripts {
	'config/config.lua',
	'config/config.translation.lua',
}

client_scripts {
	'config/config.client.lua',
	
	'client/lib.lua',
	'client/functions.lua',
	'client/main.lua',
	'client/nui.lua',
	'client/bridge/**/*.lua',
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',

	'config/config.server.lua',
	
	'server/lib.lua',
	'server/main.lua',
	'server/version_check.lua',
	'server/bridge/**/*.lua',
}

ui_page 'html/ui.html'

files {
	'html/*.*',
	'html/**/*.*',
	'html/**/**/*.*',
	'config/*.js',
	'config/translation.json',
}

escrow_ignore {
	'config/*.lua',
	'client/bridge/**/*.lua',
	'server/bridge/**/*.lua',
	'server/version_check.lua',
}
dependency '/assetpacks'