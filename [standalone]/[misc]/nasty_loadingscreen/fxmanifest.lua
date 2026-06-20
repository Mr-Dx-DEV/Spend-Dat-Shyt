fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Nasty Developments'
description 'Nasty Loading Screen'
version '1.0.0'

-- This sets the loading screen UI page
loadscreen        'ui/index.html'
loadscreen_manual_shutdown 'yes'
loadscreen_cursor 'yes'          -- enables mouse cursor during loading

-- Register all UI files so FiveM serves them
files {
  'ui/index.html',
  'ui/style.css',
  'ui/script.js',
  'ui/config.js',
  'ui/images/*.png',
  'ui/images/*.jpg',
  'ui/images/*.jpeg',
  'ui/images/*.webp',
  'ui/images/*.mp4',
  'ui/music/*.mp3',
  'ui/music/*.ogg',
}

escrow_ignore {
  'ui/style.css',
  'ui/config.js'
}

client_scripts {
  'client/main.lua',
}

dependency '/assetpacks'