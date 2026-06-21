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
