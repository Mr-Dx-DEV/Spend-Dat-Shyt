lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
games {'gta5'}
lua54 'yes'
author '147 & Fully'
version '7.0.0'
description 'Made By 147 & Fully | https://discord.gg/xwfzfvnsK8 | https://discord.gg/7UfjrRJ6'
dependencies { 
    'Fully_weapon_pack_v1', 
}
files{
	'**/weaponcomponents.meta',
	'**/weaponarchetypes.meta',
	'**/weaponanimations.meta',
	'**/pedpersonality.meta',
	'**/weapons.meta',
}
data_file 'WEAPONCOMPONENTSINFO_FILE' '**/weaponcomponents.meta'
data_file 'WEAPON_METADATA_FILE' '**/weaponarchetypes.meta'
data_file 'WEAPON_ANIMATIONS_FILE' '**/weaponanimations.meta'
data_file 'PED_PERSONALITY_FILE' '**/pedpersonality.meta'
data_file 'WEAPONINFO_FILE' '**/weapons.meta'
client_script 'cl_weaponNames.lua'
escrow_ignore {
  'cl_weaponNames.lua'
}
dependency '/assetpacks'
