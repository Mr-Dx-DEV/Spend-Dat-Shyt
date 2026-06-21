---@diagnostic disable: undefined-global
fx_version 'cerulean'
lua54 'yes'
game 'gta5'

author 'spoodyCreations'
description 'FiveM Player Owned Ammunation Business Script'
version '1.4.1' --- Updated @ 6/2/2026

ui_page 'nui/dist/index.html'

files {
    'nui/dist/index.html',
    'nui/dist/assets/*.js',
    'nui/dist/assets/*.css',
    'data/shops.json',
}

client_script {
    'client/*.lua',
    'client/admin/*.lua',
    'client/functions/*.lua',
    'client/job/*.lua',
}

server_script {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua',
    'server/admin/*.lua',
}

shared_script {
    '@ox_lib/init.lua',
    'configuration.lua'
}

--- QB Core: job.lua is open for beta and testing purposes! if you experience issues, you are free to edit it!
escrow_ignore {'configuration.lua', 'server/job.lua', 'client/colors.lua', 'server/admin/creator.lua'}
dependency '/assetpacks'