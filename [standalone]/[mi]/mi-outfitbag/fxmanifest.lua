lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'

author 'Minovic'
description 'Outfit Bag Script'
version '1.0.4'
lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
    'locales/*.lua',
}

client_scripts {
    'client/client.lua'
}

server_scripts {
    'server/server.lua'
}

ui_page 'web/index.html'

files {
    'web/**/*'
}

escrow_ignore {
    'config.lua',
    'locales/*.lua',
}
dependency '/assetpacks'
