server_script '@ElectronAC/src/include/server.lua'
client_script '@ElectronAC/src/include/client.lua'
shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_experimental_fxv2_oal 'yes'
author 'luthanirgi'
description 'SoS is fun'
version '4.1.0'
ox_lib 'locale'
shared_script {
    '@ox_lib/init.lua',
    -- to do next update
    --'@qbx_core/modules/lib.lua',
}
client_scripts {
    -- to do next update
    --'@qbx_core/modules/playerdata.lua',
    'bridge/client.lua',
    'client/client.lua',
    'client/function.lua',
}
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'bridge/server.lua',
    'server/server.lua',
    'server/function.lua',
}
files {
    'config/shared.lua',
    'locales/*.json'
}
escrow_ignore {
    'install/**/*.sql',
    'install/**/*.png',
    'install/*.txt',
    'locales/*.json',
    'bridge/*.lua',
    'client/function.lua',
    'server/function.lua',
    'config/*.lua',
}
dependency '/assetpacks'
