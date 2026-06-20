server_script '@ElectronAC/src/include/server.lua'
client_script '@ElectronAC/src/include/client.lua'
shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper


author 'ilv-scripts'
version '1.0'


fx_version 'cerulean'
game 'gta5'

lua54 'yes'



client_script {
    'client.lua'
}

server_script {
	'server.lua'

}







