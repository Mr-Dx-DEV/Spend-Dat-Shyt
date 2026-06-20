client_script '@ElectronAC/src/include/client.lua'
shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version "cerulean"
game "gta5"
description "Simple text UI library"
version "1.0"
author "JG Scripts"
client_script "client.lua"
ui_page "web/index.html"
files {"web/*"}
escrow_ignore {"**/*"}
lua54 "yes"
dependency '/assetpacks'
