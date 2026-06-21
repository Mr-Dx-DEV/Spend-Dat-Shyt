-- -
--  CLIENT BRIDGE  - framework abstraction | Grim Development | Love Menu
-- -

Bridge = {}

if Config.Framework == 'qbx' then
    local QBX = exports['qbx_core']

    Bridge.GetPlayerData = function() return QBX:GetPlayerData() end
    Bridge.Notify = function(msg, ntype, duration)
        lib.notify({ title='Love Menu', description=msg, type=ntype or 'inform', duration=duration or 4500 })
    end
    Bridge.IsLoggedIn    = function() return LocalPlayer.state.isLoggedIn end
    Bridge.GetMeta       = function(key) local pd=QBX:GetPlayerData(); return pd.metadata and pd.metadata[key] or false end
    Bridge.OnLoaded      = function(cb) RegisterNetEvent('QBXCore:Client:OnPlayerLoaded',cb); AddEventHandler('QBXCore:Client:OnPlayerLoaded',cb) end
    Bridge.OnUnloaded    = function(cb) RegisterNetEvent('QBXCore:Client:OnPlayerUnload',cb); AddEventHandler('QBXCore:Client:OnPlayerUnload',cb) end
    Bridge.HasItem       = function(item) local inv=exports.ox_inventory; return inv and inv:Search('count',item)>0 or false end

elseif Config.Framework == 'qb-core' then
    local QBCore = exports['qb-core']:GetCoreObject()

    Bridge.GetPlayerData = function() return QBCore.Functions.GetPlayerData() end
    Bridge.Notify = function(msg, ntype, duration)
        QBCore.Functions.Notify(msg, ntype or 'primary', duration or 4500)
    end
    Bridge.IsLoggedIn    = function() return LocalPlayer.state.isLoggedIn end
    Bridge.GetMeta       = function(key) local pd=QBCore.Functions.GetPlayerData(); return pd.metadata and pd.metadata[key] or false end
    Bridge.OnLoaded      = function(cb) RegisterNetEvent('QBCore:Client:OnPlayerLoaded',cb); AddEventHandler('QBCore:Client:OnPlayerLoaded',cb) end
    Bridge.OnUnloaded    = function(cb) RegisterNetEvent('QBCore:Client:OnPlayerUnload',cb); AddEventHandler('QBCore:Client:OnPlayerUnload',cb) end
    Bridge.HasItem       = function(item)
        if GetResourceState('ox_inventory')=='started' then return exports.ox_inventory:Search('count',item)>0 end
        local pd=QBCore.Functions.GetPlayerData(); if not pd.items then return false end
        for _,v in pairs(pd.items) do if v and v.name==item then return true end end
        return false
    end

elseif Config.Framework == 'esx' then
    local ESX = exports['es_extended']:getSharedObject()

    Bridge.GetPlayerData = function() return ESX.GetPlayerData() end
    Bridge.Notify = function(msg, ntype, duration) ESX.ShowNotification(msg) end
    Bridge.IsLoggedIn    = function() return ESX.IsPlayerLoaded() end
    Bridge.GetMeta       = function(key)
        local pd=ESX.GetPlayerData()
        local map={ishandcuffed=pd.isHandcuffed,inlaststand=pd.inLastStand,isdead=pd.isDead}
        return map[key] or false
    end
    Bridge.OnLoaded      = function(cb) RegisterNetEvent('esx:playerLoaded',cb); AddEventHandler('esx:playerLoaded',cb) end
    Bridge.OnUnloaded    = function(cb) RegisterNetEvent('esx:onPlayerLogout',cb); AddEventHandler('esx:onPlayerLogout',cb) end
    Bridge.HasItem       = function(item)
        local pd=ESX.GetPlayerData(); if not pd.inventory then return false end
        for _,v in pairs(pd.inventory) do if v.name==item and v.count>0 then return true end end
        return false
    end

else
    -- Standalone / fallback
    Bridge.GetPlayerData = function() return {} end
    Bridge.Notify        = function(msg, ntype, duration) lib.notify({ title='Love Menu', description=tostring(msg), type=ntype or 'inform', duration=duration or 4500 }) end
    Bridge.IsLoggedIn    = function() return true end
    Bridge.GetMeta       = function() return false end
    Bridge.OnLoaded      = function(cb) cb() end
    Bridge.OnUnloaded    = function() end
    Bridge.HasItem       = function() return true end
end
