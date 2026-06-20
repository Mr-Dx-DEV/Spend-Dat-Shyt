server_script '@ElectronAC/src/include/server.lua'
client_script '@ElectronAC/src/include/client.lua'
shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version  'cerulean'
game        'gta5'
lua54       'yes'
name        'vehiclehandler'
description 'Collision/damage handling for FiveM.'
author      'QuantumMalice'
repository  'https://github.com/QuantumMalice/vehiclehandler'
version '1.4.3'
files {
    'data/progress.lua',
    'data/vehicle.lua',
    'modules/handler.lua',
    'locales/*.json'
}
shared_script '@ox_lib/init.lua'
client_script 'client.lua'
server_script 'server.lua'
dependencies {
    'ox_lib',
}
