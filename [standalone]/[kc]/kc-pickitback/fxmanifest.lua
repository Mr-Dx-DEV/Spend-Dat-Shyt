lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'

lua54 'yes'
use_experimental_fxv2_oal 'yes'

author 'Clementinise'
name 'KC Pick It Back'
description 'Never lose your hat or glasses again, always stay in style'
github 'https://github.com/clementinise/kc-pickitback'
version '2.1.4'

shared_script 'locales/*.lua'

client_scripts {
	'config.lua',
  'client/custom_functions.lua',
  'client/custom_export.lua',
  'client/client.lua'
}

server_scripts {
	'config.lua',
  'server/server.lua'
}

escrow_ignore {
  'config.lua',
  'client/custom_export.lua',
  'client/custom_functions.lua',
  'locales/*.lua'
}

fivem_checker 'yes'
dependency '/assetpacks'
