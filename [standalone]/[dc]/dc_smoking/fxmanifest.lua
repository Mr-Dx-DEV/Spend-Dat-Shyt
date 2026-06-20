fx_version 'cerulean'
games { 'rdr3', 'gta5' }
lua54 'yes'

author 'DCCustomz'
description 'Realistic & Immersive Smoking System'
version '1.0.1'

ui_page 'ui/index.html'

files {
    'ui/index.html',
    'ui/style.css',
    'ui/script.js',
    'ui/wizard.css',
    'ui/wizard.js',
    'ui/sounds/*.ogg',
    'ui/overlays/*.webm',
    'ui/overlays/*.mp4',
    'stream/props/smokerprops2.ytyp',
}

data_file 'DLC_ITYP_REQUEST' 'stream/props/smokerprops2.ytyp'

shared_scripts {
    'shared/utils.lua',
    'config.lua',
    'config/*.lua',
    'shared/mixing_engine.lua',
    'shared/locale.lua',
    'locales/*.lua',
}

client_scripts {
    'client/bridge/cl_notify.lua',
    'client/bridge/cl_progress.lua',
    'client/bridge/cl_inventory.lua',
    'client/init.lua',
    'client/nui.lua',
    'client/interaction.lua',
    'client/smoking.lua',
    'client/rolling.lua',
    'client/mixing_client.lua',
    'client/wizard.lua',
}

server_scripts {
    'server/bridge/sv_status.lua',
    'server/bridge/sv_inventory.lua',
    'server/bridge/sv_usableitems.lua',
    'server/main.lua',
    'server/mixing_server.lua',
    'server/wizard.lua',
}

dependencies {
    'dc_weedpackone',
    'dc_propattachv3'
}

escrow_ignore {
    'config.lua',
    'config/*.lua',
    'client/bridge/*.lua',
    'locales/*.lua',
    'server/bridge/sv_status.lua',
    'install/items/*.lua',
}
dependency '/assetpacks'