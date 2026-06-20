server_script '@ElectronAC/src/include/server.lua'
client_script '@ElectronAC/src/include/client.lua'
shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version "cerulean"
game "gta5"
lua54 "yes"
author "JG Scripts"
description "Tracks vehicle mileage with UI"
version "v2.1.1"
shared_scripts {
  "@ox_lib/init.lua",
  "config.lua",
  "main.lua"
}
client_script "client/*.lua"
server_scripts {
  "@oxmysql/lib/MySQL.lua",
  "server/*.lua"
}
ui_page "web/index.html"
files {"web/*"}
escrow_ignore {"**/*"}
dependency '/assetpacks'
