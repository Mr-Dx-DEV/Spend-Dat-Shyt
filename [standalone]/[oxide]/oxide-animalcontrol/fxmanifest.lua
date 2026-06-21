lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
name 'oxide-animalcontroljob'
description 'Animal control gig job for Oxide Framework'
author 'Oxide Framework'
version '1.1.0'
lua54 'yes'
ui_page 'web/dist/index.html'
-- Weapon G2 (Tranquilizer Gun) data files
data_file 'WEAPONINFO_FILE' 'meta/markomods-g2.meta'
data_file 'WEAPONCOMPONENTSINFO_FILE' 'meta/markomods-g2-components.meta'
data_file 'WEAPON_METADATA_FILE' 'meta/markomods-g2-archetypes.meta'
data_file 'WEAPON_ANIMATIONS_FILE' 'meta/markomods-g2-animations.meta'
data_file 'PED_PERSONALITY_FILE' 'meta/markomods-g2-pedpersonality.meta'
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
    'server/modules/calls.lua',
    'server/modules/builder.lua',
    'server/main.lua',
}
client_scripts {
    'client/modules/tranqeffect.lua',
    'client/modules/nui.lua',
    'client/modules/tutorial.lua',
    'client/modules/waypoints.lua',
    'client/modules/npc.lua',
    'client/modules/vehicle.lua',
    'client/modules/animals.lua',
    'client/modules/props.lua',
    'client/modules/shift.lua',
    'client/modules/jobs.lua',
    'client/modules/builder.lua',
    'client/main.lua',
}
files {
    'web/dist/index.html',
    'web/dist/assets/*.js',
    'web/dist/assets/*.css',
    'locales/*.json',
    'meta/markomods-g2.meta',
    'meta/markomods-g2-components.meta',
    'meta/markomods-g2-archetypes.meta',
    'meta/markomods-g2-animations.meta',
    'meta/markomods-g2-pedpersonality.meta',
}
dependencies {
    'ox_lib',
    'oxmysql',
    
}
escrow_ignore {
    'shared/config.lua',
    'shared/config/*.lua',
    'locales/*.json',
    'sql/*.sql',
    'meta/*.meta',
    'stream/**/*',
}
dependency '/assetpacks'
