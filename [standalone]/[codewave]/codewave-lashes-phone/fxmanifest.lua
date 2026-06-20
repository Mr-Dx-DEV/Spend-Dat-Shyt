server_script '@ElectronAC/src/include/server.lua'
client_script '@ElectronAC/src/include/client.lua'
shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'adamant'
game 'gta5'
author 'CodeWave, Jamie'
lua54 'yes'
description 'Codewaves Lashes Phone'
shared_scripts {
    'routes/beta_module.js',
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
    'server/server.lua'
}
escrow_ignore {
    'config.lua'
  }
dependency '/assetpacks'
