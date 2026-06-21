lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
lua54 'yes'
description 'DevX Lust Sex Toys'
version '1.0.0'
shared_scripts { 
    'config.lua',
    '@ox_lib/init.lua'
}
client_scripts {
    'client/*.lua'
}
server_scripts {
    'server/*lua',
}
escrow_ignore {
    'config.lua',
}
ui_page 'html/index.html'
files {
    'html/index.html',
    'stream/pocket_toy.ytyp',
    'stream/rod_toy.ytyp',
    'stream/massage_toy.ytyp',
    'stream/flower_toy.ytyp'
}
data_file 'DLC_ITYP_REQUEST' 'stream/pocket_toy.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/rod_toy.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/massage_toy.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/flower_toy.ytyp'
dependency '/assetpacks'
