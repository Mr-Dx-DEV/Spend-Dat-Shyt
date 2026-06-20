server_script '@ElectronAC/src/include/server.lua'
client_script '@ElectronAC/src/include/client.lua'
shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'

name "MugShotBase64"
description 'A script can convert peds mugshot image to Base64 encoding to save that as save and manage that'
author "BaziForYou#9907"

ui_page 'html/index.html'

files {
  "html/js/*",
  "html/js/models/*",
  "html/img/*",
  "html/index.html",
}
client_script {
  "client.lua",
}

shared_scripts {
    'temp/babel_preset.js'
}
