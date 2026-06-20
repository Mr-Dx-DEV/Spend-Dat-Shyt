fx_version "cerulean"
game "gta5"
lua54 "yes"

description "Var-PaintBall"
version "2.0.2"

dependency "oxmysql"

ui_page "web/build/index.html"

files {
    "web/build/index.html",
    "web/build/**/*"
}

shared_scripts {
    "shared/config.lua",
    "shared/lang.lua",
    "shared/utils.lua"
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "server/framework/framework.lua",
    "server/medals.lua",
    "server/wager.lua",
    "server/gungame.lua",
    "server/leaderboard.lua",
    "server/discord.lua",
    "server/admin.lua",
    "server/state.lua",
    "server/match.lua",
    "server/lobby.lua",
    "server/combat.lua",
    "server/lock.lua",
    "server/version_check.lua"
}

client_scripts {
    "client/framework/framework.lua",
    "client/state.lua",
    "client/effects.lua",
    "client/match.lua",
    "client/lock.lua",
    "client/ui.lua",
    "client/targets.lua"
}

escrow_ignore {
    "shared/config.lua",
    "server/framework/framework.lua",
    "client/framework/framework.lua",
    "shared/lang.lua",
    "shared/utils.lua",
    "server/version_check.lua"
}

dependency '/assetpacks'