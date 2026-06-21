lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
name 'oxide-postaljob'
description 'GoPostal delivery gig job for Oxide Framework'
author 'Oxide Framework'
version '1.1.0'
lua54 'yes'
ui_page 'web/dist/index.html'
shared_scripts {
    '@ox_lib/init.lua',
    'shared/config.lua',
    'shared/config/*.lua',
    'shared/init.lua',
}
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/modules/progression.lua',
    'server/modules/shifts.lua',
    'server/modules/crews.lua',
    'server/modules/deliveries.lua',
    'server/modules/entities.lua',
    'server/modules/postalbuilder.lua',
    'server/main.lua',
}
client_scripts {
    'client/modules/nui.lua',
    'client/modules/tutorial.lua',
    'client/modules/waypoints.lua',
    'client/modules/npc.lua',
    'client/modules/vehicle.lua',
    'client/modules/loading.lua',
    'client/modules/bystander.lua',
    'client/modules/shift.lua',
    'client/modules/delivery.lua',
    'client/modules/postalbuilder.lua',
    'client/main.lua',
}
files {
    'web/dist/index.html',
    'web/dist/assets/*.js',
    'web/dist/assets/*.css',
    'locales/*.json',
}
escrow_ignore {
    'shared/config.lua',
    'shared/config/*.lua',
}
dependencies {
    'ox_lib',
    'oxmysql',
    'o-link',
}
dependency '/assetpacks'
