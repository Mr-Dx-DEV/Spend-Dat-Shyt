lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
version '1.1.8'
game 'gta5'
lua54 'yes'
shared_scripts {
    '@ox_lib/init.lua',
    '@qbx_core/modules/lib.lua',
    'config.lua',
    'shared/*.lua'
}

server_scripts {
    'server/framework/**/*.lua',
    'server/inventory/*.lua',
    'server/version.lua'
    
}

client_scripts {
 
    'client/framework/**/*',
    'client/target/*.lua',
    'client/clothing/*.lua'
}

escrow_ignore {
    'config.lua',
    'shared/*'
}
dependency '/assetpacks'
