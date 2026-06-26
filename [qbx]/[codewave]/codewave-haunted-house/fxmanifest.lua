fx_version 'adamant'
game 'gta5'
author 'CodeWave, Jamie'
lua54 'yes'
description 'Codewaves Halloween House'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
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
    'server/server.lua'
}

escrow_ignore {
    'config.lua'
  }

dependency '/assetpacks'