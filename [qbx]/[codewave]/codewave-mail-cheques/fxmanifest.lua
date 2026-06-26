fx_version 'adamant'
game 'gta5'
author 'CodeWave, Jamie'
lua54 'yes'
description 'Codewaves Mail Cheques'

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
    'web/image/*.png'
}


server_scripts {
    'server/server.lua',
    '@oxmysql/lib/MySQL.lua'   

}

escrow_ignore {
    'config.lua',  --
    'notify.lua' 
  }


dependency '/assetpacks'