
fx_version 'cerulean'
game 'gta5'

version '1.0.0'

author "LoadedxDiaper"
description "Voice Gestures"
website "https://partay.tebex.io/"
discord "https://discord.gg/partaystudios"

shared_script '@ox_lib/init.lua'
client_script 'client.lua'
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}

dependency 'pma-voice'
dependency 'ox_lib'
dependency 'oxmysql'

dependency '/assetpacks'