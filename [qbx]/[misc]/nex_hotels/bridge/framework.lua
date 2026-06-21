Bridge = {}

if Config.Framework == 'esx' then
    Bridge.fw = exports['es_extended']:getSharedObject()
elseif Config.Framework == 'qbcore' then
    Bridge.fw = exports['qb-core']:GetCoreObject()
end

--- Show a notification to the player
---@param msg string
---@param type 'success'|'error'|'info'|'warning'|nil
function Bridge.Notify(msg, type)
    lib.notify({ description = msg, type = type or 'inform', duration = 4000 })
end
