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
description 'Adds basic events for developers to use in their scripts. Some third party resources may depend on this resource.'
repository 'https://github.com/citizenfx/cfx-server-data'
client_script 'deathevents.lua'
client_script 'vehiclechecker.lua'
server_script 'server.lua'
fx_version 'adamant'
game 'gta5'
