fx_version 'adamant'
game 'gta5'
version '2.1.0'
author 'uniqersscripts'
script 'uniqers-coupleanims'
store 'https://uniqers-scripts.tebex.io/'

shared_scripts {
    'config.lua'
}

client_scripts {
    "client/*.lua",
}

server_scripts {
    "server/*.lua"
}

ui_page "ui/index.html"

files {
    "ui/index.html",
    "ui/*.css",
    "ui/img/*.webp",
	'ui/fonts/*.*',
    "ui/*.js",
	'ui/sounds/*.mp3'
}


data_file 'DLC_ITYP_REQUEST' 'stream/[Custom Emotes]/*ytyp.'

escrow_ignore {
  'config.lua'
}

lua54 'yes'
dependency '/assetpacks'