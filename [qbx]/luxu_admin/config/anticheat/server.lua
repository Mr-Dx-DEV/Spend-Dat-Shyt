--[[

Add your anticheat compatibility here

]]


--- luxu_admin Hooks
---@class LuxuBan
---@field id number -- Ban id
---@field player_name string -- Player name
---@field player_id string -- Player id
---@field staff_id number -- Staff id
---@field reason string -- Ban reason
---@field identifiers string[] -- Player identifiers
---@field tokens string[] -- Player hardware tokens
---@field created_at number -- Ban created at
---@field expires_at number -- Ban expires at

---@param data LuxuBan
AddEventHandler("luxu_admin:server:playerBanned", function(data)
    ---Add your logic here
end)

---@param data LuxuBan
AddEventHandler("luxu_admin:server:playerUnbanned", function(data)

end)

--- WaveShield

---@class WaveShieldData
---@field id string -- ban id
---@field name string
---@field reason string
---@field extended string
---@field screenshot string -- (url)
---@field identifiers string[] -- all player identifiers
---@field expires number -- when the ban expires (timestamp)

AddEventHandler("__WaveShield_internal:playerBanned", function(source, data)
    local info = {
        player_name = data.name,
        identifiers = data.identifiers,
        tokens = {},
        expires_at = data.expires,
        reason = data.reason,
        label = "WaveShield",
    }

    -- exports.luxu_admin:createBan(info)
end)

---@param banId string -- Ban id
---@param data WaveShieldData
AddEventHandler("__WaveShield_internal:playerUnbanned", function(banId, data, unbanReason, from)
    --  exports.luxu_admin:removeBan(banId)
end)

---This function is used to avoid your anticheat from banning players when teleporting or performing some other bannable action.
---@param source number
---@param duration number --- in seconds
function RequestAnticheatBypass(source, duration)
    if GetResourceState("WaveShield") == "started" then
        exports["WaveShield"]:tempBypass(source, duration)
    else
    end
end

---Don't touch this line please
exports('AnticheatBypass', RequestAnticheatBypass)
