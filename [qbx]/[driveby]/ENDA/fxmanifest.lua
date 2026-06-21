--[[ =============================================================================

		Project: "Enhanced Native Driveby Animations (ENDA)"
		Copyright © 2020-2025 Delta District (DeltaDistrict.com)

]]-- =============================================================================

game 'gta5'
fx_version 'cerulean'
lua54 'yes'

version '2.1.5'
author 'Delta District - Cosmo'
description 'Enhanced Native Driveby Animations - Base Script'

dependencies {'DD_UI_Aimstyle'}
client_scripts {
	'_Config.lua',
	'ENDA_Locales.lua',
	'ENDA_Bridge.lua',
	'ENDA_Client.lua',
}
server_scripts {'ENDA_Server.lua', 'ENDA_Version.lua'}
escrow_ignore {
	'_Config.lua',
	'ENDA_Locales.lua',
	'ENDA_Bridge.lua',
	'ENDA_Server.lua',
	'ENDA_Version.lua',
}


dependency '/assetpacks'
