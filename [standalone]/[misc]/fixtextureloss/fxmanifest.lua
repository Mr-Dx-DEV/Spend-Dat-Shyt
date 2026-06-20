fx_version 'cerulean'
game 'gta5'

name 'fixtextureloss'
author 'LoadedXDiaper'
version '1.1.6'
description 'Aggressive texture refresh'
website "https://partay.tebex.io/"
discord "https://discord.gg/partaystudios"

lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua', -- make sure ox_lib is started before this resource
    'config.lua'
}

client_scripts {
    'client/client.lua'
}

server_scripts {
    'server/server.lua'
}

escrow_ignore {
	'config.lua',
}

dependency '/assetpacks'