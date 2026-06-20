client_script '@ElectronAC/src/include/client.lua'
shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

-- FX Information --
fx_version   'cerulean'
lua54        'yes'
game         'gta5'

-- Resource Information --
description  'Ultimate Fivem Weapon Pack - V.1.0'
version      '1.0.0'
author       'chunkxxyy'

-- Files --

files {
    'meta/**/*.meta',
}

data_file 'WEAPONCOMPONENTSINFO_FILE' 'meta/**/weaponcomponents.meta'
data_file 'WEAPON_METADATA_FILE' 'meta/**/weaponarchetypes.meta'
data_file 'WEAPON_ANIMATIONS_FILE' 'meta/**/weaponanimations.meta'
data_file 'PED_PERSONALITY_FILE' 'meta/**/pedpersonality.meta'
data_file 'WEAPONINFO_FILE' 'meta/**/weapons.meta'

client_script { 'cl_weaponNames.lua' }

-- Manifest --
dependencies {
  '/server:5181',
  '/onesync'
}
dependency '/assetpacks'
