-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
fx_version "cerulean"
use_experimental_fxv2_oal "yes"
nui_callback_strict_mode "true"
lua54 "yes"
game "gta5"

description 'Advanced Ambulance Job v2 By Wasabi Scripts'
author 'Wasabi Scripts'
version '2.1.9b'

ui_page "ui/build/index.html"

data_file 'DLC_ITYP_REQUEST' 'stream/wasabi_stretcher.ytyp'

shared_scripts {
    "@ox_lib/init.lua",
    "escrow/module_system.lua",
    "config/shared/*.lua",
    "locales/init.lua",
    "**/shared/*.lua",
    "**/shared/modules/*.lua",
}

files {
    "ui/build/index.html",
    "ui/build/assets/**",
    "locales/*.json",
}

client_scripts {
    "config/client/*.lua",
    "bridge/**/client.lua",
    "bridge/interact/*.lua",
    "escrow/common/client/*.lua",
    "**/client/modules/**/*.lua",
    "**/client/main.lua"
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "config/server/*.lua",
    "bridge/**/server.lua",
    "bridge/logger/*.lua",
    "escrow/common/server/*.lua",
    "**/server/modules/**/*.lua",
    "**/server/main.lua"
}

escrow_ignore {
    "_invItems/data.lua",
    "bridge/**/**/*.lua",
    "bridge/**/*.lua",
    "config/**/*.lua",
    "types.lua",
}

provides {
    'wasabi_ambulance'
}

dependencies {
    '/assetpacks',
    'oxmysql',
    'ox_lib'
}

dependency '/assetpacks'