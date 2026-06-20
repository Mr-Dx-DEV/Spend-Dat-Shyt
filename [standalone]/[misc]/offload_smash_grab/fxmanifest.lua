server_script '@ElectronAC/src/include/server.lua'
client_script '@ElectronAC/src/include/client.lua'
shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
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
