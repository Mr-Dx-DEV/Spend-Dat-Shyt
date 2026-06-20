fx_version 'adamant'
game 'gta5'
version '3.6.0'
author 'uniqersscripts'
script 'uniqers-investments'
store 'https://uniqers-scripts.tebex.io/'

shared_scripts {
	'config.lua',
}

client_scripts {
	'client/main.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	-- '@mysql-async/lib/MySQL.lua', -- if you are use mysql async this you can delete > -- < this. 
	'server/main.lua'
}

ui_page {
	'html/ui.html'
}

files {
	'html/ui.html',
	'html/font/*.ttf',
	'html/font/*.otf',
	'html/font/*.woff',	
	'html/css/*.css',
	'html/images/*.jpg',
	'html/images/*.png',
	'html/js/*.js',
}

escrow_ignore {
  'config.lua'
}


lua54 'yes'

dependency '/assetpacks'