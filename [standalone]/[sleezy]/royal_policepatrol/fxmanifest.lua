--[[
    ╔═══════════════════════════════════════════════════════════════════╗
    ║                     ROYAL POLICE PATROL                           ║
    ║                   Created by RoyalT Customz                       ║
    ║              Supports ESX & QBCore Automatically                  ║
    ╚═══════════════════════════════════════════════════════════════════╝
]]--

fx_version 'cerulean'
game 'gta5'

name 'Royal Police Patrol'
author 'RoyalT Customz'
description 'Police Patrol System with Enhanced Dispatch'
version '1.1.0'

-- Shared configuration (loaded first)
shared_scripts {
    'shared/config.lua'
}

-- Tebex: buyers can edit config only
escrow_ignore {
    'shared/config.lua',
}

-- Client-side scripts
client_scripts {
    'client/patrol.lua',
    'client/crimes.lua',
    'client/dispatch.lua',
    'client/mdt.lua'
}

-- Server-side scripts
server_scripts {
    'server/patrol.lua',
    'server/dispatch.lua'
}

-- NUI for enhanced dispatch alerts
ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js'
}

-- Lua 5.4 for better performance
lua54 'yes'

dependency '/assetpacks'