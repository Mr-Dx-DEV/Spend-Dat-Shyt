fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'FearX Scripts'
description 'Advanced Crafting & Repair Bench Creator System'
version '1.1.4'


shared_scripts {
    'helpers/index.js',
    '@ox_lib/init.lua',
    'locales/*.lua',
    'config/config.lua',
    'shared/*.lua'
}

client_scripts {
    'editable/cl_functions.lua',
    'client/cl_main.lua',
    'client/cl_ui.lua',
    'client/cl_benches.lua',
    'client/cl_propplacer.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'config/sv_config.lua',
    'editable/sv_inventory.lua',
    'editable/sv_functions.lua',
    'server/sv_configmanager.lua',
    'server/sv_inventory.lua',
    'server/sv_main.lua',
    'server/sv_crafting.lua',
    'server/sv_commands.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js'
}

dependencies {
    'oxmysql',
    'fearx_bridge',
    'object_gizmo',
    'ox_inventory'
}

escrow_ignore {
    'config/*.lua',
    'locales/*.lua',
    'editable/*.lua',
}

provides {
    'fearx-crafting'
}

dependency '/assetpacks'