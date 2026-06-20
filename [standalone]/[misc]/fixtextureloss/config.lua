Config = {}

Config.CommandName = 'fixtextureloss'
Config.Cooldown = 60
Config.NotificationType = 'ox_lib'
Config.Debug = false

-- Global framework/state refresh after texture fix.
-- Disabled by default to prevent side effects like NUI/menu reinitialization
-- in dependent resources that listen to player-loaded style events.
Config.FrameworkReloadEnabled = false

-- ESX-only controls:
-- If true, the script will call ESX reload events after the texture refresh.
-- Set to false to avoid any ESX events that might reopen appearance/multichar menus.
Config.ESXReloadEnabled = false

-- Some ESX servers (illenium-appearance, vms_multichar) open a skin menu when
-- they see esx:playerLoaded. Set to true only if you need that event fired.
Config.ESXTriggerPlayerLoaded = false

function Config.CustomNotify(message, nType)
    print(('[fixtextureloss] %s (%s)'):format(message, nType or 'info'))
end
