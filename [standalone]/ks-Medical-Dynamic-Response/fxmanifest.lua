fx_version 'cerulean'
game 'gta5'

author 'Kubi Store'
description 'Medical Dynamic Response - Smart revive system for ESX/QBCore/Standalone'
version '1.1.1'

lua54 'yes'

shared_scripts {
    'config.lua',
    'shared/deathscript.lua',
    'custom/*.lua',
    'shared/wasabi.lua',
    'locales/*.lua',
    'shared/locale.lua'
}

escrow_ignore {
    'config.lua',
    'shared/deathscript.lua',
    'custom/*.lua',
    'locales/*.lua'
}

server_scripts {
    'server/functions.lua',
    'server/main.lua'
}

client_scripts {
    'client/functions.lua',
    'client/main.lua',
    'client/npc.lua'
}

dependencies {
    '/onesync'
}

dependency '/assetpacks'