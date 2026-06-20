server_script '@ElectronAC/src/include/server.lua'
client_script '@ElectronAC/src/include/client.lua'
shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
description 'qbx_recyclejob'
repository 'https://github.com/Qbox-project/qbx_recyclejob'
version '2.1.0'
ox_lib 'locale'
shared_scripts {
    '@ox_lib/init.lua',
    '@qbx_core/modules/lib.lua',
}
server_scripts {
    'server/*',
}
client_scripts {
    'client/*'
}
files {
    'config/client.lua',
    'locales/*.json',
}
lua54 'yes'
use_experimental_fxv2_oal 'yes'
