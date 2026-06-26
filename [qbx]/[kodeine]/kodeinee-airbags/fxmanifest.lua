fx_version 'cerulean'
games { 'gta5' }

lua54 'yes'

author 'Kodeinee Studios'
description 'Kodeinee Airbags - Advanced Vehicle Airbag System'
version '1.0.1'

shared_scripts {
    'config.lua',
    'bridge.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}

files {
    'stream/prop_carairbag.ydr',
    'stream/prop_carairbag.ytd',
    'stream/prop_carairbag.ytyp'
}

data_file 'DLC_ITYP_REQUEST' 'stream/prop_carairbag.ytyp'

escrow_ignore {
    'config.lua'
}

dependency '/assetpacks'