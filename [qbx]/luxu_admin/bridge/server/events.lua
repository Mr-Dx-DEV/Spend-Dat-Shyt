---@param source number
local function playerLoaded(source)
      TriggerEvent("luxu_admin:server:playerLoaded", tonumber(source)) -- This is not a networked event, can only be triggered server-side
end

--- Add Or Change Bellow if you need

AddEventHandler('QBCore:Server:PlayerLoaded', function(Player)
      playerLoaded(Player.PlayerData.source)
end)

AddEventHandler('esx:playerLoaded', function(source)
      playerLoaded(source)
end)

AddEventHandler("ox:playerLoaded", function(source)
      playerLoaded(source)
end)
