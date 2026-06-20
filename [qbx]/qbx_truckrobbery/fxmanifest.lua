server_script '@ElectronAC/src/include/server.lua'
client_script '@ElectronAC/src/include/client.lua'
shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
version '1.1.1'
description 'qbx_truckrobbery'
repository 'https://github.com/Qbox-project/qbx_truckrobbery'
version '1.1.1'
ox_lib 'locale'
shared_scripts {
    '@ox_lib/init.lua',
    '@qbx_core/modules/lib.lua',
    'shared/types.lua',
}
client_scripts {
    '@qbx_core/modules/playerdata.lua',
    'client/main.lua',
}
server_script 'server/main.lua'
files {
    'config/client.lua',
    'config/shared.lua',
    'locales/*.json',
}
lua54 'yes'
use_experimental_fxv2_oal 'yes'
