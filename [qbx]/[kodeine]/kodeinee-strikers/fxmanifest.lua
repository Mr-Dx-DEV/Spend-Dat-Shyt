fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'Kodeinee Development'
description 'kodeinee-strikers - striker pad, chop shop, and vehicle strike system'
version '2.1.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
    'bridge.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}

client_scripts {
    'client.lua'
}

files {
    'stream/kodeineestrikepad.ydr',
    'stream/kodeineestrikepad.ytyp',
    'stream/kodeineestrikepad.ybn'
}

data_file 'DLC_ITYP_REQUEST' 'stream/kodeineestrikepad.ytyp'

escrow_ignore {
    'config.lua',
    'bridge.lua'
}

dependency 'ox_lib'
dependency '/assetpacks'