local found = GetResourceState('es_extended')
if found ~= 'started' and found ~= 'starting' then return end

ESX = exports["es_extended"]:getSharedObject()
FLBridge = FLBridge or {}
FLBridge.framework, FLBridge.playerLoaded, FLBridge.playerData = 'esx', nil, {}

function FLBridge.getCore()
    return ESX
end

local function NormalizeJob(job)
    if not job then return job end
  
    if not job.type or job.type == '' then
        job.type = job.name
    end
    
    if job.onduty == nil then
        job.onduty = true
    end
    return job
end

RegisterNetEvent('esx:playerLoaded', function(xPlayer)
    if xPlayer and xPlayer.job then
        xPlayer.job = NormalizeJob(xPlayer.job)
    end
    FLBridge.playerData = xPlayer
    FLBridge.playerLoaded = true
    SwitchHandler('isLoggedIn', xPlayer)
    TriggerEvent('filthy_bridge:onPlayerSpawn')
end)

RegisterNetEvent('esx:onPlayerLogout', function()
    table.wipe(FLBridge.playerData)
    FLBridge.playerLoaded = false
    SwitchHandler('isLoggedOut')
end)

RegisterNetEvent('esx:setJob', function(job)
    if not FLBridge.playerData then return end
    job = NormalizeJob(job)
    FLBridge.playerData.job = job
    SwitchHandler('setJob', job)
end)

RegisterNetEvent('flb:updateDuty', function(isOnDuty)
    if not FLBridge.playerData or not FLBridge.playerData.job then return end
    FLBridge.playerData.job.onduty = isOnDuty
    SwitchHandler('dutyChange', isOnDuty)
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    if ESX.IsPlayerLoaded() then
        local data = ESX.GetPlayerData()
        if data and data.job then
            data.job = NormalizeJob(data.job)
        end
        FLBridge.playerData = data
        FLBridge.playerLoaded = true
    end
end)

function FLBridge.serverCallback(name, cb, ...)
    ESX.TriggerServerCallback(name, cb, ...)
end

function FLBridge.awaitServerCallback(name, ...)
    local args = {...}
    local promise = promise.new()
    ESX.TriggerServerCallback(name, function(...)
        promise:resolve(table.pack(...))
    end, table.unpack(args))
    local result = Citizen.Await(promise)
    return table.unpack(result, 1, result.n)
end

function FLBridge.registerCallback(name, fn)
    RegisterNetEvent(name)
    AddEventHandler(name, function(...)
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
            return
        elseif ret ~= nil then
           
        end

        if not ok then
            print(('[flb] callback %s threw an error: %s'):format(name, ret))
        end
    end)
end

function FLBridge.hasGroup(filter)
    if not FLBridge.playerData then return end
    local type = type(filter)

    if type == 'string' then
        if FLBridge.playerData.job and FLBridge.playerData.job.name == filter then
            return FLBridge.playerData.job.name, FLBridge.playerData.job.grade
        end
    elseif type == 'table' then
        local tabletype = table.type(filter)
        if tabletype == 'hash' then
            local grade = filter[FLBridge.playerData.job.name]
            if grade and grade <= FLBridge.playerData.job.grade then
                return FLBridge.playerData.job.name, FLBridge.playerData.job.grade
            end
        elseif tabletype == 'array' then
            for i = 1, #filter do
                local group = filter[i]
                if FLBridge.playerData.job and FLBridge.playerData.job.name == group then
                    return FLBridge.playerData.job.name, FLBridge.playerData.job.grade
                end
            end
        end
    end
end

function FLBridge.getGroup()
    if not FLBridge.playerLoaded then return end
    return FLBridge.playerData.job.name, FLBridge.playerData.job.grade
end

function FLBridge.isOnDuty()
    if not FLBridge.playerLoaded then return end
    return FLBridge.playerData.job.onduty
end

function FLBridge.toggleDuty()
    local job = ESX.GetPlayerData().job
    job.onduty = not job.onduty
    ESX.SetPlayerData("job", job)
    TriggerServerEvent('flb:setDutyStatus', job.onduty)
    TriggerEvent('flb:onDutyToggle', job.onduty)
end

function FLBridge.openBossMenu(_job)
    if FLBridge.playerData and FLBridge.playerData.job then
        TriggerEvent('esx_society:openBossMenu', FLBridge.playerData.job.name, function(menu)
        end)
    end
end

function FLBridge.getGender()
    if not FLBridge.playerLoaded then return 0 end
    return (FLBridge.playerData.charinfo and FLBridge.playerData.charinfo.gender or 0)
end

function FLBridge.isPlayerDead()
    if not FLBridge.playerLoaded then return end
    return IsEntityDead(PlayerPedId())
end

function FLBridge.isPlayerHandcuffed()
    if not FLBridge.playerLoaded then return end
    return IsPedCuffed(PlayerPedId())
end
