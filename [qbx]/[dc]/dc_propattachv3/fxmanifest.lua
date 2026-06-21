fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'DCCustomz'
description 'DC Prop Attach v3'
version '3.0.0'

ui_page 'ui/index.html'

files {
    'ui/index.html',
    'ui/style.css',
    'ui/script.js',
}

shared_scripts {
    'config.lua',
}

client_scripts {
    'client/main.lua',
}

server_scripts {
    'server/main.lua',
}

escrow_ignore {
    'config.lua',
    'server/main.lua',
}
dependency '/assetpacks'