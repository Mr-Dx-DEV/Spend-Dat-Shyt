-- Framework abstraction. Override Framework.notify to plug ESX / QBCore / ox_lib.

Framework = Framework or {}

local Utils = Utils or {}

Framework.framework = Utils.getFramework()

function Framework.notify(message)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(tostring(message))
    EndTextCommandThefeedPostTicker(false, false)
end

return Framework
