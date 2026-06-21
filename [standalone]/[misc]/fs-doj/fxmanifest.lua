fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'fs-doj'
author 'Fantasy Scripts'
version '1.0.0'
description 'Complete DOJ System with MDT, Court, and Multi-Framework Support'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
    'locales.lua',
    'shared/*.lua'
}

client_scripts {
    'src/client/main.lua',
    'src/client/mdt.lua',
    'src/client/companies_finances.lua',
    'src/client/metal_detector.lua',
    'src/client/printer.lua',
    'src/client/tv.lua',
    'src/client/garage.lua',
    'src/client/court.lua',
    'src/client/target.lua',
    'src/client/warrant.lua',
    'src/client/items.lua'  -- Item usage handlers
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'src/server/main.lua',
    'src/server/database.lua',
    'src/server/mdt.lua',
    'src/server/companies.lua',
    'src/server/metal_detector.lua',
    'src/server/printer.lua',
    'src/server/tv.lua',
    'src/server/garage.lua',
    'src/server/court.lua',
    'src/server/finances.lua',
    'src/server/permissions.lua',
    'src/server/warrant.lua'
}

files {
    'adapters/framework/*.lua',
    'adapters/inventory/*.lua',
    'html/*.html',
    'html/*.css',
    'html/*.js',
    'html/img/*.png',
    'html/sounds/*.ogg',
    'html/sounds/*.mp3',
    'html/sounds/*.wav',
    'stream/*.gfx',
    'sql/*.sql'
}

ui_page 'html/index.html'

dependencies {
    'ox_lib',
    'oxmysql'
}

-- Item Usage Exports (for ox_inventory)
exports {
    'useDocument',
    'usePhoto',
    'useWarrantDocument'
}

escrow_ignore {
    'config.lua',
    'locales.lua',
    'shared/*.lua',
    'adapters/*/*.lua',
    'installation/*.*'
}
dependency '/assetpacks'