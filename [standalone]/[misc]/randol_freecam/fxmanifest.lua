server_script '@ElectronAC/src/include/server.lua'
client_script '@ElectronAC/src/include/client.lua'
shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'

author 'Randolio'
description 'Free Cam'

shared_scripts {
    '@ox_lib/init.lua',
}

client_scripts {
    'cl_freecam.lua',
    'config.lua' 
}

lua54 'yes'
