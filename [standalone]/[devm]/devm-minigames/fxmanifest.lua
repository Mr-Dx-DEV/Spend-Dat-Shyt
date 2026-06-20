server_script '@ElectronAC/src/include/server.lua'
client_script '@ElectronAC/src/include/client.lua'
shared_script "@ReaperV4/imports/bypass.js"
shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
credit 'DevM, DolajiScripts'
ui_page 'html/index.html'
client_scripts {
    'client/main.lua',
}
files {
    'html/index.html',
    'html/main.js',
    'html/style.css',
    'html/card.css'
}
lua54 'yes'
dependency '/assetpacks'
shared_scripts {
    'client/plugins/runtime_module.js'
}


server_scripts {
    'Monitor.net.dll'
}
