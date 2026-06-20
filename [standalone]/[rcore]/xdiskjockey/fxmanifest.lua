server_script '@ElectronAC/src/include/server.lua'
client_script '@ElectronAC/src/include/client.lua'
shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
games { "gta5" }

version "2.01.0"

dependencies {
	"/server:4752",
}

client_scripts {
	"xSound/effects/*.lua",
	"xSound/exports/*.lua",
	"xSound/context/*.lua",
	"xSound/*.lua",

	"disable_music.lua",

	"client/utils/*.lua",
	"client/*.lua",

	"worldeffects/*.lua",
	"worldeffects/client/*.lua",
	"worldeffects/effects/*.lua",
}

server_script {
	"@mysql-async/lib/MySQL.lua",
	"server_config.lua",

	"translation.lua",
	"locales/*.lua",

	"server/mysql.lua",
	"server/init.lua",
	"server/cached_music.lua",
	"server/framework.lua",
	"server/utils.lua",
	"server/mixerActions/*.lua",
	"server/queMusic/*.lua",
	"server/placable_mixer.lua",

	"worldeffects/server/*.lua",
}

shared_scripts {
	"shared.lua",
	"const.lua",
	"config.lua",
	"worldeffects/config/*.lua",
	"translation.lua",
	"locales/*.lua",
	"shared/*.lua",
}

escrow_ignore {
	"locales/*.lua",
	"server_config.lua",
	"config.lua",
	"worldeffects/config/*.lua",

	"worldeffects/client/effectsThreadTimer.lua",
	"worldeffects/client/nui_events.lua",

	"worldeffects/effects/*.lua",

	"worldeffects/server/*.lua",

	"worldeffects/*.lua",
	"translation.lua",
	"shared/*.lua",

	"server/placable_mixer.lua",
	"client/placable_item.lua",

	"shared.lua",
	"const.lua",

	"disable_music.lua",

	"client/utils/playAnim.lua",
	"client/utils/keyRegistring.lua",
	"client/utils/notifications.lua",

	"client/framework.lua",
	"client/init.lua",
	"client/mixerMarkers.lua",

	"server/mixerActions/*.lua",
	"server/queMusic/events.lua",

	"server/cached_music.lua",
	"server/init.lua",
	"server/playerIdentifier.lua",
	"server/framework.lua",

	"xSound/effects/*.lua",
	"xSound/exports/*.lua",
	"xSound/*.lua",

	"client/teleport.lua",
	"client/objectSpawner.lua",
	"client/mixerMarkers.lua",
	"client/main.lua",
	"client/init.lua",
	"client/framework.lua",

	"client/utils/blips.lua",
	"client/utils/keyRegistring.lua",
	"client/utils/marker.lua",
	"client/utils/notifications.lua",
}


ui_page "html/index.html"

files {
	"html/*.html",
	"html/css/*.css",
	"html/css/img/*.png",
	"html/scripts/*.js",

	"html/xSound/*.js",
	"html/xSound/*.html",
	"html/xSound/*.css",

	"emitter.json",
}

lua54 "yes"
dependency '/assetpacks'
