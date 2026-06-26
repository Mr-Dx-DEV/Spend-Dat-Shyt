fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'

name 'nex_uipack'
author 'NEX Development | Donk'
version '1.0.4'
description 'Redesigned UI pack for ox_lib. Owns the NUI iframe and bridges Lua<->UI traffic through ox_lib.'

dependency 'ox_lib'

ui_page 'web/build/index.html'

files {
    'web/build/index.html',
    'web/build/**/*',
    'locales/*.json',
}

client_scripts {
    'lua/config.lua',
    'lua/client.lua',
}
server_script 'lua/server/version_check.lua'

escrow_ignore {
    'lua/config.lua',
}
dependency '/assetpacks'