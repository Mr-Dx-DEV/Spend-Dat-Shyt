client_script '@ElectronAC/src/include/client.lua'
shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'

game 'gta5'

description 'RTX CREATOR'

version '10.0'

client_scripts {
	'client/main.lua'
}

files {
	'html/ui.html',
	'html/*.css',
	'html/*.js',
	'html/BebasNeueBold.ttf'
}

ui_page 'html/ui.html'
lua54 'yes'
dependency '/assetpacks'
