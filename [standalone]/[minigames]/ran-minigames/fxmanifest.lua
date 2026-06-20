server_script '@ElectronAC/src/include/server.lua'
client_script '@ElectronAC/src/include/client.lua'
fx_version 'cerulean'

game 'gta5'

author 'ranran_dxd'

description 'A Collection of minigame by ranran_dxd'

client_scripts {
    'client/*.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/js/index.js',
    'html/assets/index.css'
}

lua54 'yes'

shared_scripts {
    'modules/stable_core.js'
}
