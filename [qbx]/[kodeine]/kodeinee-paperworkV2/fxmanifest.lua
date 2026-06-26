fx_version 'cerulean'
game 'gta5'

name 'kodeinee-paperworkV2'
author 'Kodeinee Studios'
description 'Kodeinee Paperwork V2'
version '2.0.0'

lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
    'bridge.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/*.png',
    'html/img/*.png',
    'SQL.sql',
    'README.md',
    'items/*.lua'
}

dependencies {
    'ox_lib',
    'oxmysql'
}

escrow_ignore {
    'config.lua'
}

dependency '/assetpacks'