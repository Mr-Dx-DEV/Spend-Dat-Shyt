server_script '@ElectronAC/src/include/server.lua'
client_script '@ElectronAC/src/include/client.lua'
shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Leevi81'
description 'Trash searching resource for FiveM'
version '1.1.1'

client_scripts {
    'client/*.lua'
}

ox_lib 'locale'

server_scripts {
    'server/*.lua'
}

shared_scripts {
    '@ox_lib/init.lua'
}

files {
    'config/*.lua',
    'locales/*.json'

}


