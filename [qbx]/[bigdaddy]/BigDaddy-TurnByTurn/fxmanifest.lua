lua54 "yes" -- needed for Reaper

fx_version 'bodacious'
game 'gta5'
clr_disable_task_scheduler 'yes'

name "BigDaddy-TurnByTurn"
description "Turn by Turn directions for your GPS"
author "Big Daddy"
version "1.1"

ui_page 'nui/ui.html'

client_scripts {
	'BigDaddy-TurnByTurn.Client.net.dll',
	 'settings.ini'
}

server_scripts {
	 'BigDaddy-TurnByTurn.Server.net.dll',
	 'Newtonsoft.Json.dll',
	 'settings.ini'
}

 files {
 	'nui/ui.html',
 	'nui/sounds/*.ogg',
	'nui/sounds/streets/*.ogg'
 }
