fx_version 'bodacious'
author 'Brown Development'
description 'Love Shop'
game 'gta5'
lua54 'yes'
version '1.0.1'

data_file 'DLC_ITYP_REQUEST' 'stream/bzzz_xmas23_convert_package.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/pata_freevalentinesday.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/ultra_ringcase.ytyp'

shared_scripts {
    '@ox_lib/init.lua',
    'shared/config.lua'
}

client_scripts {
    'client/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua'
}

files {
    'dist/*.png',
    'dist/*.webp',
    'dist/*.jpeg',
    'dist/*.jpg',
    'dist/index.html',
    'dist/assets/*.css',
    'dist/assets/*.js',
}

ui_page 'dist/index.html'

escrow_ignore {
    'shared/config.lua',
    'stream/bzzz_xmas23_convert_package.ytyp',
    'stream/bzzz_xmas23_convert_tree_gift_small.ydr',
    'stream/bzzz_xmas23_convert_tree.ytd',
    'stream/pata_freevalentinesday.ytyp',
    'stream/pata_freevalentinesday3.ydr',
    'stream/ultra_ringcase.ydr',
    'stream/ultra_ringcase.ytyp',
    'stream/ultra@propose.ycd',
}

dependency '/assetpacks'