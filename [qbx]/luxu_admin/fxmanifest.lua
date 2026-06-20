
fx_version 'cerulean'
node_version '22'
lua54 'yes'
games { 'gta5', 'rdr3' }
use_experimental_fxv2_oal 'yes'

author 'luxu-gg'
description 'Admin menu for FiveM'
version '1.14.7'

dependencies {
    'oxmysql',
    '/server:28009'
}

server_script "@oxmysql/lib/MySQL.lua"

shared_scripts {
    '@ox_lib/init.lua',
    'shared/functions.lua',
    'shared/utils.lua',
    'shared/init.lua',
}

client_scripts { 'client/utils/*.lua', 'client/modules/*.lua', 'client/cl_main.lua' }

server_scripts { "config/hooks/server.lua", "server/utils/*.lua", 'server/modules/*.lua', 'server/sv_main.lua', 'server/index.js', 'config/anticheat/server.lua' }

files { 'config/config.json', 'config/themes.css', 'config/permissions.json', 'config/sounds/*', 'config/help.lua', 'config/constants/*.json', 'config/logging/cl_logs.lua', 'config/teleports.lua', 'config/commands/cl_commands.lua', 'config/custom_functions/client.lua', 'locales/*.json', "web/index.html", 'web/**/*', "bridge/framework.lua", "bridge/shared/**/*.lua", "bridge/client/**/*.lua", "bridge/vrp2/**/*.lua" }


escrow_ignore { 'config/**/*', 'bridge/**/*' }
ui_page "web/index.html"

dependency '/assetpacks'
dependency '/assetpacks-redm'