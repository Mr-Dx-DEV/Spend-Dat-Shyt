fx_version 'cerulean'
game 'gta5'

author 'Syringe Sisters'
description 'Illegal BBL Shot crafting system'
version '1.0.0'

escrow_ignore {
    'config.lua'
}

shared_scripts {
    'config.lua',
    'shared/items.lua',
}

client_scripts {
    'client/main.lua',
    'client/gangs.lua',
    'client/robbery.lua',
    'client/blackmarket.lua',
    'client/streetselling.lua',
    'client/delivery.lua',
}

server_scripts {
    'server/main.lua',
    'server/gangs.lua',
    'server/robbery.lua',
    'server/blackmarket.lua',
    'server/streetselling.lua',
    'server/delivery.lua',
}

server_exports {
    'useBBLShot',
}

ui_page 'html/index.html'

files {
    'html/index.html',
}

lua54 'yes'

dependency '/assetpacks'