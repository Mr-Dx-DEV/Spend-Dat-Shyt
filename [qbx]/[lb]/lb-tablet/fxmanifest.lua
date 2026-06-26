fx_version "cerulean"
game "gta5"
lua54 "yes"

author "LB"
description "Tablet script for FiveM, made by LB"
website "https://store.lbscripts.com/"
version "1.6.1"

shared_scripts {
    "config/**.lua",
    "shared/**.lua",
    "lib/shared/**.lua",
}

client_script {
    "lib/client/**.lua",
    "client/**.lua"
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "lib/server/**.lua",
    "server/**.lua",
}

files {
    "config/**.json",
    "ui/dist/**/*",
    "ui/components.js",
    "sound/data/lbtablet.dat54.rel",
    "sound/dlc_lbtablet/sounds.awc"
}

data_file 'AUDIO_WAVEPACK'  'sound/dlc_lbtablet'
data_file 'AUDIO_SOUNDDATA' 'sound/data/lbtablet.dat'

ui_page "ui/dist/index.html"

dependency "oxmysql"

escrow_ignore {
    "lib/**",
    "config/**",
    "shared/**",
    "client/custom/**",
    "server/custom/**",
    "client/apps/custom/**",
    "server/apps/custom/**",
    "server/apiKeys.lua",
    "server/misc/databaseChecker/**",
    "server/apps/mdt/dutyBlips.lua",
    "client/apps/mdt/dutyBlips.lua",
}

dependency '/assetpacks'