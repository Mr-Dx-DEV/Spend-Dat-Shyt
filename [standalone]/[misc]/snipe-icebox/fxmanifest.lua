server_script '@ElectronAC/src/include/server.lua'
client_script '@ElectronAC/src/include/client.lua'
shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'

description 'Ice Box Script'
version '1.5.8'
author 'Snipe'

lua54 'yes'

ui_page "ui/index.html"

shared_scripts{
    '@ox_lib/init.lua',
    'shared/**/*.lua'
}

client_scripts{
    'client/**/*.lua',
} 

server_scripts{
    'server/**/*.lua'
}

escrow_ignore{
    'client/open/*.lua',
    'server/open/*.lua',
    'shared/**/*.lua'
}

data_file 'DLC_ITYP_REQUEST' 'stream/fact_chains.ytyp' -- 10 car garage shell
files {
    'stream/fact_chains.ytyp',
    "ui/*.js",
	"ui/*.html",
	"ui/*.css"
}
dependency '/assetpacks'
