server_script '@ElectronAC/src/include/server.lua'
client_script '@ElectronAC/src/include/client.lua'
shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'International Systems'
description 'Weapon Smokes'
version '1.0.2'

shared_script 'config.lua'

client_scripts {
    'client/smoke_logic.lua',
    'client/client.lua'
}

server_scripts {
    'server/server.lua',
    'server/version/version_check.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js',
    'weapons.json',
    'html/img/*.png',
    'html/*.ogg'
}


escrow_ignore {
    'config.lua'
}
dependency '/assetpacks'
