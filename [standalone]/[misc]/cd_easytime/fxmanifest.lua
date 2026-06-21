lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
author 'discord.gg/codesign'
description 'Codesign Weather & Time Managment'
version '2.0.1'
lua54 'yes'

shared_scripts {
    'configs/locales.lua',
    'configs/config.lua',
    --'@ox_lib/init.lua', --âš ï¸PLEASE READâš ï¸; Uncomment this line if you use 'ox_lib'.âš ï¸
    --'@qbx_core/modules/lib.lua', --âš ï¸PLEASE READâš ï¸; Uncomment this line if you use 'qbx_core'.âš ï¸
}

client_scripts {
    'configs/client_customise_me.lua',
    'client/*.lua',
    --'@qbx_core/modules/playerdata.lua', --âš ï¸PLEASE READâš ï¸; Uncomment this line if you use 'qbx_core'.âš ï¸
}

server_scripts {
    'configs/server_customise_me.lua',
    'server/*.lua'
}

ui_page 'html/index.html'
files {
    'html/index.html',
    'html/css/*.css',
    'html/js/*.js',
    'html/font/*.svg',
    'html/font/*.ttf',
    'html/font/*.eot',
    'html/font/*.woff',
    'html/font/*.woff2',
    'html/images/**/*.svg',
    'html/sound/*.ogg'
}

exports {
    'GetWeather',
    'GetAllData',
    'GetPauseSyncState'
}

server_exports {
    'GetWeather',
    'GetAllData',
    'GetRealData',
    'SetTime',
    'SetWeather'
}

provide 'vSync'
provide 'qb-weathersync'
provide 'qbx_weathersync'
