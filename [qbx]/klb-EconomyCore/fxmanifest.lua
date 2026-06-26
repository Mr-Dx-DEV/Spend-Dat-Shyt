fx_version 'cerulean'
lua54 'yes'
game 'gta5'

dependency 'qb-core'

server_scripts { '@oxmysql/lib/MySQL.lua', 'server.lua' }

client_scripts { 'client.lua' }

ui_page 'ui/ui.html'

files { 'ui/ui.html' }
escrow_ignore {
    'sql/*.sql',
    'README.md'
}

dependency '/assetpacks'