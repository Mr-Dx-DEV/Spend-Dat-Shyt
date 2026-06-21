fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author "G3DEV - justgroot"
description "Fivem Multi Job System"
version '1.3.0'

shared_scripts {
	"src/shared/Config.lua",
	"locales/locale.lua",
	"src/shared/nui_localizations.lua",
	"locales/translations/*.lua",
	'@ox_lib/init.lua', -- comment this out if you're not using qbox
}

client_script{
	"bridge/**/client.lua",
	"src/client/**.lua",
	"src/theme/theme.lua",
}

server_scripts{
	"@oxmysql/lib/MySQL.lua",
	"bridge/**/server.lua",
	"src/server/*.lua",
}


-- ui_page 'http://localhost:3000/' -- (for local dev)
ui_page 'web/build/index.html'

files {
  'web/build/index.html',
  'web/build/**/*'
}

use_experimental_fxv2_oal "yes"


escrow_ignore {
	"src/shared/*.lua",
	"src/client/cl_edit.lua",
	"src/server/sv_edit.lua",
	"src/server/DB.lua",
	"src/theme/theme.lua",
	"bridge/**/server.lua",
	"bridge/**/client.lua",
	"locales/translations/*.lua",
}

dependency '/assetpacks'