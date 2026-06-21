lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
author 'TuKeh_'
description 'Graffiti System'
version '1.0.7'
lua54 'yes'
ui_page 'web/build/index.html'
files {
    'web/build/index.html',
    'web/build/**/*',
}
shared_scripts {
    'shared/*.lua',
	'locales/*.lua',
	'config.lua',
    '@ox_lib/init.lua',
}
client_scripts {
    'client/frameworks/*.lua',
    'client/main_editable.lua',
    'client/main.lua',
}
server_scripts {
    'server/frameworks/*.lua',
    'server/main_editable.lua',
    'server/main.lua',
}
escrow_ignore {
    'locales/*.lua',
    'config.lua',
    'client/frameworks/*.lua',
    'server/frameworks/*.lua',
    'client/main_editable.lua',
    'server/main_editable.lua',
}
dependency '/assetpacks'
