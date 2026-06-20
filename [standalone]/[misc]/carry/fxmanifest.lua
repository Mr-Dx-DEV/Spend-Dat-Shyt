server_script '@ElectronAC/src/include/server.lua'
client_script '@ElectronAC/src/include/client.lua'
shared_script '@WaveShield/resource/include.lua'

fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'

author 'rubbertoe98'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua'
}

client_script 'cl_carry.lua'
server_script 'sv_carry.lua'