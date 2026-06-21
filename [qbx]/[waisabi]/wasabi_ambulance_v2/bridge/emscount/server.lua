local config, bridge

---@type number|nil
local lastEMSCount

local function getEMSCount()
    local count = 0
    for _, playerId in ipairs(GetPlayers()) do
        local id = tonumber(playerId)
        if bridge.hasGroup(id, config.ambulanceJobs) and bridge.getDuty(id) then
            count = count + 1
        end
    end
    return count
end

local function broadcastEMSCountIfChanged()
    local count = getEMSCount()
    if lastEMSCount ~= nil and count == lastEMSCount then
        return
    end
    lastEMSCount = count
    TriggerClientEvent('wasabi_ambulance:EMSCountUpdated', -1, count)
end

local emscount = {}

function emscount.init()
    config = Modules.require('config')
    bridge = Modules.require('bridge')
end

lib.callback.register('wasabi_ambulance:GetEMSCount', function()
    local count = getEMSCount()
    lastEMSCount = count
    return count
end)

AddEventHandler('wasabi_ambulance:PlayerLoaded', function()
    broadcastEMSCountIfChanged()
end)

AddEventHandler('playerDropped', function()
    broadcastEMSCountIfChanged()
end)

AddEventHandler('wasabi_ambulance:ToggleDuty', function()
    CreateThread(function()
        Wait(0)
        broadcastEMSCountIfChanged()
    end)
end)

RegisterNetEvent('wasabi_ambulance:setJob', function()
    broadcastEMSCountIfChanged()
end)

Modules.register('emscount', emscount, {
    dependencies = { 'config', 'bridge' }
})
