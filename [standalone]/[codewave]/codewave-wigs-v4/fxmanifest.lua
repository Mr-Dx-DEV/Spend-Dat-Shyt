lua54 "yes" -- needed for Reaper

fx_version 'adamant'
game 'gta5'
author 'CodeWave, Jamie'
lua54 'yes'
description 'Codewaves Wigs & Bundles V4 - A comprehensive wig crafting and selling system for FiveM, featuring a deep crafting system with unlockable recipes, an XP and leveling system, and a slick UI. Updated to V4 with new wigs, a prestige system, and more!'
shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}
client_scripts {
    'client/client.lua'
}
ui_page "web/index.html"
files {
    "web/index.html",
    'web/script.js',
    'web/style.css',
	'web/sounds/*.mp3',
    'web/image/*.png'
}
server_scripts {
     'server/webhooks.lua',
    'server/server.lua'
}
escrow_ignore {
    'config.lua',
    'server/webhooks.lua'
  }
dependency '/assetpacks'
