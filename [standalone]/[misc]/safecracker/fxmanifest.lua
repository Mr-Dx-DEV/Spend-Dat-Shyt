client_script '@ElectronAC/src/include/client.lua'
shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'bodacious'
game 'gta5'
description 'Safecracker Minigame'
version '1.0.0'
client_scripts {
  'config.lua',
  'client.lua'
}
files { 
  'LockPart1.png',
  'LockPart2.png',
}
