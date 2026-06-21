local found = GetResourceState('qb-core')
if found ~= 'started' and found ~= 'starting' then return end

QBCore = exports['qb-core']:GetCoreObject()
FLBridge = FLBridge or {}
FLBridge.framework, FLBridge.playerLoaded, FLBridge.playerData = 'qb', nil, {}

function FLBridge.getCore()
    return QBCore
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    SwitchHandler('isLoggedIn', FLBridge.playerData or {})
    TriggerEvent('filthy_bridge:onPlayerSpawn')
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    SwitchHandler('isLoggedOut')
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName or not LocalPlayer.state.isLoggedIn then return end
    SwitchHandler('start')
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
    if not job or not job.name then return end
    SwitchHandler('setJob', job)
end)

RegisterNetEvent('QBCore:Player:SetPlayerData', function(newPlayerData)
    if not source or source == '' or GetInvokingResource() then return end
    SwitchHandler('QBCore:Player:SetPlayerData', newPlayerData)
end)

function FLBridge.serverCallback(name, cb, ...)
    Callback(name, cb, ...)
end

function FLBridge.awaitServerCallback(name, ...)
    local results = { Callback.awaitResponse(name, ...) }
    return table.unpack(results)
end

function FLBridge.registerCallback(name, fn)
    Callback.register(name, function(source, ...)
        local responded = false
        local response = nil
        
        local cb = function(...)
            responded = true
            response = {...}
        end
        
        local ok, ret = pcall(function(...) 
            return table.pack(fn(source, cb, ...)) 
        end, ...)

        if responded then
            return table.unpack(response)
        elseif ret ~= nil then
            return table.unpack(ret, 1, ret.n)
        end

        if not ok then
            print(("[flb] callback %s threw an error: %s"):format(name, ret))
        end
    end)
end

function FLBridge.hasGroup(filter)
    if not FLBridge.playerData then return end
    local groups = { 'job', 'gang' }
    local type = type(filter)

    if type == 'string' then
        for i = 1, #groups do
            local data = FLBridge.playerData[groups[i]]
            if data and data.name == filter then
                return data.name, data.grade.level
            end
        end
    elseif type == 'table' then
        local tabletype = table.type(filter)
        if tabletype == 'hash' then
            for i = 1, #groups do
                local data = FLBridge.playerData[groups[i]]
                if data then
                    local grade = filter[data.name]
                    if grade and grade <= data.grade.level then
                        return data.name, data.grade.level
                    end
                end
            end
        elseif tabletype == 'array' then
            for i = 1, #filter do
                local group = filter[i]
                for j = 1, #groups do
                    local data = FLBridge.playerData[groups[j]]
                    if data and data.name == group then
                        return data.name, data.grade.level
                    end
                end
            end
        end
    end
end

function FLBridge.getGroup()
    if not FLBridge.playerLoaded then return end
    local data = FLBridge.playerData['job']
    return data and data.name, data and data.grade.level
end

function FLBridge.isOnDuty()
    if not FLBridge.playerLoaded then return end
    FLBridge.playerData = QBCore.Functions.GetPlayerData()
    return FLBridge.playerData.job.onduty
end

local qbx = GetResourceState('qbx_management')
local isQbxStarted = qbx == 'started'

function FLBridge.openBossMenu(_job)
    if isQbxStarted then
        exports.qbx_management:OpenBossMenu('job')
    else
        TriggerEvent('qb-bossmenu:client:OpenMenu')
    end
end

function FLBridge.getGender()
    if not FLBridge.playerLoaded then return 0 end
    return (FLBridge.playerData.charinfo.gender or 0)
end

function FLBridge.isPlayerDead()
    if not FLBridge.playerLoaded then return end
    FLBridge.playerData = QBCore.Functions.GetPlayerData()
    return (FLBridge.playerData.metadata.isdead or FLBridge.playerData.metadata.inlaststand)
end

function FLBridge.isPlayerHandcuffed()
    if not FLBridge.playerLoaded then return end
    FLBridge.playerData = QBCore.Functions.GetPlayerData()
    return FLBridge.playerData.metadata.ishandcuffed and true or false
end
