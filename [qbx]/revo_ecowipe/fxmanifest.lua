fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'RevoScripts.com'
description 'Economy Wipe Tool for ESX, QBCore and QBox'
version '1.2'

files {
    'nui/index.html',
    'nui/bundle.js'
}

ui_page 'nui/index.html'

shared_script 'config.lua'
client_script 'client.lua'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}

dependencies {
    'oxmysql'
}

escrow_ignore {
    'config.lua'
}
dependency '/assetpacks'