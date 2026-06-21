fx_version 'adamant'
game 'gta5'
version '1.0.0'
author 'uniqersscripts'
script 'uniqers-uipack'
store 'https://uniqers-scripts.tebex.io/'


ui_page 'html/index.html'

files {
  'html/index.html',
  'html/script.js',
  'html/style.css',
  'html/fonts/*.woff',
  'html/fonts/*.ttf',	
  'html/img/*.jpg',
  'html/img/*.png',
}

shared_scripts {
    'config.lua',
}

client_scripts{
    'client/*.lua'
}
server_scripts{
    'server/*.lua'
}

exports {
    'ShowNotify',
    'Progress',
    'displayTextUI',
    'hideTextUI',
	'changeText',
	'create3DTextUI',
	'update3DTextUI',
	'create3DTextUIOnPlayers',
	'delete3DTextUIOnPlayers',
	'delete3DTextUI',
}

lua54 "yes"


dependency '/assetpacks'