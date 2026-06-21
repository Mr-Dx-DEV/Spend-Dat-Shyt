fx_version 'cerulean'
game 'gta5'

name 'wavy_blipcreator'
author 'wavy'
description 'Blip Creator'
version '1.0.1'

lua54 'yes'

escrow_ignore {
    'config.lua',
    'sv_config.lua'
}

shared_scripts {
    'config.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    'sv_config.lua',
    'server/main.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/app.js',
    'data/blips.json',
    'html/img/*.png'
}

dependency '/assetpacks'