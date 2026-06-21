lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
lua54 'yes'
description 'DevX Lust Shop'
version '1.0'
shared_scripts { 
    'config.lua',
    '@ox_lib/init.lua',
}
client_scripts {
    'client/*.lua'
}
server_scripts {
    'server/*.lua'
}
escrow_ignore {
    'config.lua',
}
ui_page 'html/index.html'
files {
    'html/index.html',
    'html/images/*.png'
}
dependency '/assetpacks'
