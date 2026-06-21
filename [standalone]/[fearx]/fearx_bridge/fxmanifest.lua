fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'FearX Scripts'
description 'FearX Bridge - Universal Framework Bridge'
version '1.1.8'

ui_page 'web/index.html'

shared_scripts {
    'config.lua',
    'shared/main.lua'
}

server_scripts {
    'server/main.lua',
    'server/frameworks/*.lua',
    'server/inventory/*.lua'
}

client_scripts {
    'client/main.lua',
    'client/frameworks/*.lua',
    'client/notify/*.lua',
    'client/target/*.lua',
    'client/ambulance/*.lua'
}

files {
    'web/index.html'
}

escrow_ignore {
    'config.lua',
    'locales/*.lua',
    'client/frameworks/*.lua',
    'client/notify/*.lua',
    'client/target/*.lua',
    'client/ambulance/*.lua',
    'server/frameworks/*.lua',
    'server/inventory/*.lua'
}


dependency '/assetpacks'