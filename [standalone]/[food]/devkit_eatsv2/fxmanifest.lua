fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'Devkit'
description 'Eats v2'


shared_scripts {
    '@ox_lib/init.lua',
    'config/*.lua',
}


client_scripts{
    'client/*.lua',
}

server_scripts{
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua',
}

escrow_ignore {
    'config/*.lua',
}

dependency '/assetpacks'