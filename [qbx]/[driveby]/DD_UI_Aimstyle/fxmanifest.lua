--[[ ====================================================================================================================================

	Project: "Delta Enhanced Aimstyles - Selector UI (DEA UI)"
	Copyright � 2020-2025 Delta District (deltadistrict.com)

]]-- ====================================================================================================================================

game 'gta5'
fx_version 'cerulean'
lua54 'yes'

version '1.0.5'
author 'Delta District - Cosmo'
description 'Style Selector UI for Enhanced Native Driveby Animations (ENDA) & Delta Custom Aiming Styles (DCAS)'

files {
	'html/images/dea_ui_logo.png',
    'html/images/*.jpg',
    'html/dea_ui.html',
    'html/dea_ui_script.js',
    'html/dea_ui_style.css',
}

ui_page 'html/dea_ui.html'
shared_script '@ox_lib/init.lua'
client_scripts {'config.lua','DEA_UI.lua'}
server_script 'DEA_Version.lua'

escrow_ignore {
    'config.lua',
	'DEA_Version.lua',
	'html/dea_ui.html',
    'html/dea_ui_script.js',
    'html/dea_ui_style.css',
}

dependency '/assetpacks'