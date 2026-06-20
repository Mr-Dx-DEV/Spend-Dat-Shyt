server_script '@ElectronAC/src/include/server.lua'
client_script '@ElectronAC/src/include/client.lua'
shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

-- This resource is part of the default Cfx.re asset pack (cfx-server-data)
-- Altering or recreating for local use only is strongly discouraged.
version '1.0.0'
author 'Cfx.re <root@cfx.re>'
description 'Handles the "host lock" for non-OneSync servers. Do not disable.'
repository 'https://github.com/citizenfx/cfx-server-data'
fx_version 'cerulean'
games { 'gta4', 'gta5' }
server_script 'server/host_lock.lua'
client_script 'client/empty.lua'
