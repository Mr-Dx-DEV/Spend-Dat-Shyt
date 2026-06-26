fx_version 'adamant'
game 'gta5'
author 'CodeWave, Jamie'
lua54 'yes'
description 'CodeWave TechWorkz V2'
data_file 'DLC_ITYP_REQUEST' 'stream/gkms_techworkz_props.ytyp'
version '2.0.3'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
    'shared/bridge.lua'
}

client_scripts {
    'client/client.lua'
}

ui_page "web/index.html"

files {
    "web/index.html",
    'web/script.js',
    'web/style.css',
    'web/sounds/*.mp3',
    'web/image/*.png'
}

server_scripts {
    'server/webhooks.lua',
    'server/server.lua'
}

escrow_ignore {
    'config.lua',
    'server/webhooks.lua',
    'shared/bridge.lua',
}

dependency '/assetpacks'