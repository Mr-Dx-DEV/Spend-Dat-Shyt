server_script '@ElectronAC/src/include/server.lua'
client_script '@ElectronAC/src/include/client.lua'
shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
author 'FearX'
description 'FearX Community Service System'
version '1.0.2'
lua54 'yes'
shared_scripts {
    '@ox_lib/init.lua',
    'config/config.lua',
    'locales/*.lua'
}
client_scripts {
    'editable/cl_notify.lua',
    'editable/cl_progress.lua',
    'editable/cl_ambulance.lua',
    'editable/cl_inventory.lua',
    'client/client.lua'
}
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'config/sv_config.lua',
    'server/discord.lua',
    'server/server.lua'
}
ui_page 'html/index.html'
files {
    'html/index.html',
    'html/script.js',
    'html/style.css'
}
escrow_ignore {
    'config/config.lua',
    'config/sv_config.lua',
    'locales/*.lua',
    'editable/*.lua'
}
dependency '/assetpacks'
