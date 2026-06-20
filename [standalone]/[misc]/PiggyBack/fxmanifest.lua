server_script '@ElectronAC/src/include/server.lua'
client_script '@ElectronAC/src/include/client.lua'
shared_script '@WaveShield/resource/include.lua'

-- Resource Metadata
fx_version 'bodacious'
games { 'gta5' }

author 'rubbertoe98'
description 'PiggyBack'
version '1.0.0'

client_script "cl_piggyback.lua"
server_script "sv_piggyback.lua"
