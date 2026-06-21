fx_version 'adamant'
game 'gta5'
author 'CodeWave, Jamie'
lua54 'yes'
description 'Codewaves Sneakers V4, Props by GKMS'
data_file 'DLC_ITYP_REQUEST' 'stream/gkms_solestreet_props.ytyp'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
    'shared/bridge.lua'
}

client_scripts {
    'client/client.lua',
    'client/client_shoes.lua'
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
    'server/server.lua',
    'server/server_shoes.lua'
}

escrow_ignore {
    'config.lua',
    'server/webhooks.lua',
    'shared/bridge.lua',
  }

dependency '/assetpacks'