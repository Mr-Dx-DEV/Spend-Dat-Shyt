fx_version 'adamant'
game 'gta5'
author 'CanXScript'
lua54 'yes'

server_scripts {
    'config.lua',
    'server/main.lua',

    
}
client_scripts {
    'config.lua',
    'client/main.lua',

}
escrow_ignore {
    'config.lua',
}
ui_page {
  
	'web/index.html'
}
files {
	'web/css/*.css',
    'web/index.html',
    'web/*.js',
    'web/beep.mp3',
    'web/beep2.mp3',
    'web/*.ttf',
    'web/*.svg',
    'web/*.woff',
	'web/img/*.*',
}
dependency '/assetpacks'