client_script '@ElectronAC/src/include/client.lua'
shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
version '1.0.1'
name 'qbx_density'
description 'Population management'
repository 'https://github.com/Qbox-project/qbx_density'
version '1.0.1'
client_scripts {
    '@ox_lib/init.lua',
    'client/main.lua'
}
files {
    'config/client.lua'
}
lua54 'yes'
use_experimental_fxv2_oal 'yes'
