fx_version 'cerulean'
game 'gta5'

author 'RoyalT Customz'
description 'Sugar Hustle System - relationship roleplay system'
version '1.0.0'

lua54 'yes'

shared_script '@ox_lib/init.lua'

client_scripts {
    'config.lua',
    'client.lua',
}

server_scripts {
    'config.lua',
    'server.lua',
}

files {
    'locales/en.lua',
    'html/index.html',
    'html/style.css',
    'html/script.js',
    'html/profiles.json',
    'html/images/alexander.jpg',
    'html/images/charlotte.jpg',
    'html/images/dante.jpg',
    'html/images/isabella.jpg',
    'html/images/marcus.jpg',
    'html/images/olivia.jpg',
    'html/images/sebastian.jpg',
    'html/images/sophia.jpg',
    'html/images/vanessa.jpg',
    'html/images/vincent.jpg'
}

ui_page 'html/index.html'

dependencies {
    'ox_lib'
}


-- ════════════════════════════════════════════════════════════════
-- Tebex: buyers can edit config and locale files only
-- ════════════════════════════════════════════════════════════════
escrow_ignore {
    'config.lua',
    'locales/*.lua',
}


dependency '/assetpacks'