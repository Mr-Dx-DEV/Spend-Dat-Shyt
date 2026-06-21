lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
name 'cosmic_carmenu'
author 'cosmic crafts store'
description 'Vehicle Interaction Menu with multi-framework support'
version '1.0.0'
client_scripts {
    'client.lua'
}
shared_scripts {
    'config.lua'
}
ui_page 'html/index.html'
files {
    'html/index.html',
    'html/style.css',
    'html/script.js',
    'html/img/*.png'
}
lua54 'yes' 
escrow_ignore {
    'config.lua',
}
dependency '/assetpacks'
