fx_version 'adamant'
game 'gta5'
version '9.0.0'
author 'uniqersscripts'
script 'uniqers-marriage'
store 'https://uniqers-scripts.tebex.io/'


ui_page "ui/index.html"


shared_scripts {
    'shared/config.lua',
    'shared/functions.lua', 	
    'shared/translate.lua', 	
	'shared/commands.lua',
    'shared/interaction.lua',
    'shared/loyalty.lua',   
    'shared/outfits.lua',   
    'shared/priestjob.lua',
    'shared/valentines.lua'
}

client_scripts {
	'@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/ComboZone.lua',
    'client/main.lua',
    'client/lovescene.lua',
    'client/loyalty.lua',
    'client/valentines.lua'	
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua',
    'server/commands.lua',
    'server/items.lua',
	'server/priest.lua',
	'server/admin.lua',
    'server/lovescene.lua',
    'server/loyalty.lua',
    'server/valentines.lua',
}

files {
'ui/index.html',
'ui/*.css',
'ui/*.js',
'ui/fonts/*.woff',
'ui/fonts/*.ttf',
'ui/*.mp3',
'ui/img/*.webp',
'ui/img/*.gif', 
'stream/*.ytyp'
 } 


data_file 'DLC_ITYP_REQUEST' 'stream/*.ytyp'

escrow_ignore { 
'shared/*.lua'
} 

lua54 'yes'




dependency '/assetpacks'