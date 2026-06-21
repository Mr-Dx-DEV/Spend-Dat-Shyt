lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
lua54 'yes'
game 'gta5'
name '0r-illegalpack'
author '0resmon & alikoc.dev'
version '1.1.3'
description 'Illegal Job Pack | alikoc.dev'

shared_scripts {
	'@ox_lib/init.lua',
	'config.lua',
	'shared/init.lua',
}

files {
	'locales/*.json',
	'modules/**/client.lua',
	'modules/bridge/init.lua',
	'escrow/**/config.lua',
	'ui/build/index.html',
	'ui/build/**/*',
	'stream/horoz_cage.ytyp',
}

client_scripts {
	'escrow/jobs/client_index.lua',
	'escrow/**/client.lua',
	'client.lua',
	'shared/client_debug.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'escrow/jobs/server_index.lua',
	'escrow/**/server.lua',
	'server.lua',
}

ui_page 'ui/build/index.html'

data_file 'DLC_ITYP_REQUEST' 'stream/horoz_cage.ytyp'

dependencies { 'ox_lib', 'oxmysql', '0r_lib' }

escrow_ignore {
	'config.lua',
	'shared/**/*.lua',
	'modules/**/*.lua',
	'escrow/**/config.lua',
}
dependency '/assetpacks'
