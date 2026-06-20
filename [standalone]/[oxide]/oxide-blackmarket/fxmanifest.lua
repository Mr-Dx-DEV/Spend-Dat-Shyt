fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Oxide'
description 'Dynamic black market dealer system with reputation-based inventory'
version '1.4.2'

escrow_ignore {
    'shared/config.lua',
    'shared/items.lua',
    'server/money.lua',
    'html/**/*',
    'locales/*.json',
}

shared_scripts {
    '@ox_lib/init.lua',
    'shared/init.lua',
    'shared/config.lua',
    'shared/items.lua',
}

client_scripts {
    'client/main.lua',
    'client/dealers.lua',
    'client/ui.lua',
    'client/blips.lua',
    'client/pager.lua',
}

server_scripts {
    'server/main.lua',
    'server/money.lua',
    'server/dealers.lua',
    'server/shop.lua',
    'server/reputation.lua',
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/css/style.css',
    'html/js/app.js',
    'locales/*.json',
}

dependencies {
    'ox_lib',
    'o-link',
}

dependency '/assetpacks'