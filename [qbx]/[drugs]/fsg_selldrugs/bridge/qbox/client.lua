if GetResourceState('qbx_core') ~= 'started' then return end

-- Qbox uses the qb-core compatibility layer
local QBCore = exports['qb-core']:GetCoreObject()

function GetPlayerData()
    return QBCore.Functions.GetPlayerData()
end

function setInvBusy(boolean)
    LocalPlayer.state:set("invBusy", boolean, true)
end