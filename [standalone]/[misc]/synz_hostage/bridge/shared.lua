Bridge = Bridge or {}

-- Auto-detect framework if set to 'auto'
if Config.Framework == 'auto' or Config.Framework == 'AUTO' then
    if GetResourceState('qb-core') == 'started' or GetResourceState('qbx_core') == 'started' then
        Config.Framework = 'QBCORE'
    elseif GetResourceState('es_extended') == 'started' then
        Config.Framework = 'ESX'
    else
        Config.Framework = 'STANDALONE'
        print('[synz_hostage] ^3WARNING: No framework detected, running standalone^0')
    end
end

-- Normalize framework name
local fw = Config.Framework:upper()
if fw == 'QB' or fw == 'QBCORE' or fw == 'QBX' or fw == 'QBOX' then
    Config.Framework = 'QBCORE'
elseif fw == 'ESX' or fw == 'ES_EXTENDED' then
    Config.Framework = 'ESX'
end

-- Check if ox_lib is available AND its global 'lib' is loaded
Bridge.hasOxLib = false
if GetResourceState('ox_lib') == 'started' then
    local ok, val = pcall(function() return lib end)
    Bridge.hasOxLib = ok and val ~= nil
end

-- Check resource availability helper
function Bridge.IsStarted(resource)
    local s = GetResourceState(resource)
    return s == 'started' or s == 'starting'
end

-- Safe export call
function Bridge.SafeExport(resource, exportName, ...)
    if not Bridge.IsStarted(resource) then return false, nil end
    local ok, result = pcall(function(...)
        return exports[resource][exportName](exports[resource], ...)
    end, ...)
    return ok, result
end
