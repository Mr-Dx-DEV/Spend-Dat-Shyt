lua54 "yes" -- needed for Reaper



fx_version 'cerulean'
game 'gta5'

description 'Offload Studio Smash Grab'
version '1.0.2'
author 'Filip'
lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
}

client_scripts {
    'client/*.lua',
}

server_scripts {
    'server/*.lua',
}

files {
    'config/*.lua',
}

escrow_ignore {
  'client/cl_open.lua',
  'server/sv_open.lua',
  'config/shared.lua',
  'config/client.lua',
}

dependencies {
    'community_bridge',
}
dependency '/assetpacks'
