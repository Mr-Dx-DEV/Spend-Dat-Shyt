fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'portis-afterhours'
description 'AFTERHOURS — events app for FiveM phones (lb-phone, gksphone, yseries, 17mov_phone, codem-phone, lb-tablet)'
author 'Portis'
version '1.0.0'

dependencies {
    'oxmysql',
    'ox_lib',
}

shared_scripts {
    '@ox_lib/init.lua',
    'config/config.lua',
    'shared/sh_enums.lua',
    'shared/sh_event_types.lua',
    'shared/sh_utils.lua',
    'config/locale_loader.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'config/config.server.lua',
    'server/sv_version.lua',
    'server/sv_main.lua',
    'server/sv_schema.lua',
    'server/sv_discord.lua',
    'server/sv_database.lua',
    'server/sv_anticheat.lua',
    'server/sv_geofence.lua',
    'server/sv_events.lua',
    'server/sv_invitations.lua',
    'server/sv_rsvp.lua',
    'server/sv_checkin.lua',
    'server/sv_lifecycle.lua',
    'server/sv_payouts.lua',
}

client_scripts {
    'client/cl_phone_bridge.lua',
    'client/cl_nui.lua',
    'client/cl_geofence.lua',
    'client/cl_main.lua',
}

ui_page 'ui/dist/index.html'

files {
    'ui/dist/index.html',
    'ui/dist/**/*',
    'locales/*.json',
    'sql/install.sql',
}

escrow_ignore {
    'config/*',
    'server/sv_main.lua',
}

dependency '/assetpacks'