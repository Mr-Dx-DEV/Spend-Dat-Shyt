server_script '@ElectronAC/src/include/server.lua'
client_script '@ElectronAC/src/include/client.lua'
shared_script '@WaveShield/resource/include.lua'

fx_version 'bodacious'
lua54 'yes' 
game 'gta5' 

author 'R1CKY®#2220'
description 'Vinewood Sign'
version '1.0'


client_scripts {
    'client.lua'
}

shared_scripts {
    'config.lua'
}

server_scripts {
    'server.lua'
}

ui_page 'web/index.html'

files {
    'web/*.html',
    'web/css/*.css',
    'web/js/*.js',
    'web/fonts/*.ttf',
    'web/img/*.png',
}


data_file 'DLC_ITYP_REQUEST' 'stream/**/*.ytyp'

files {
    'stream/**/*.ytyp'
}
