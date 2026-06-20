QBCore, ESX = nil, nil
PlayerJob = {}

if Config.Framework == "qb" then
    QBCore = exports[Config.FrameworkTriggers["qb"].ResourceName]:GetCoreObject()
elseif Config.Framework == "esx" then
    local status, errorMsg = pcall(function() ESX = exports[Config.FrameworkTriggers["esx"].ResourceName]:getSharedObject() end)
    if (ESX == nil) then
        while ESX == nil do
            Wait(100)
            TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
        end
    end
end

local function UpdatePlayerJob()
    if Config.Framework== "qb" then
        PlayerJob = QBCore.Functions.GetPlayerData().job
    elseif Config.Framework== "esx" then
        while ESX.GetPlayerData() == nil do
            Wait(100)
        end
        while ESX.GetPlayerData().job == nil do
            Wait(100)
        end
        PlayerJob = ESX.GetPlayerData().job
    end
end

RegisterNetEvent(Config.FrameworkTriggers[Config.Framework].PlayerLoaded)
AddEventHandler(Config.FrameworkTriggers[Config.Framework].PlayerLoaded, function()
    CreateThread(function()
        for k, v in pairs(Config.InfuseItems) do
            RequestNamedPtfxAsset(v.particleDict)
            while not HasNamedPtfxAssetLoaded(v.particleDict) do
                Citizen.Wait(0)
            end
        end
    end)
    UpdatePlayerJob()
    Initialize()
    StartRemovingChainsAndWatchThread()
end)

RegisterNetEvent(Config.FrameworkTriggers[Config.Framework].PlayerUnload)
AddEventHandler(Config.FrameworkTriggers[Config.Framework].PlayerUnload, function()
    PlayerJob = nil
end)

RegisterNetEvent(Config.FrameworkTriggers[Config.Framework].OnJobUpdate)
AddEventHandler(Config.FrameworkTriggers[Config.Framework].OnJobUpdate, function(jobInfo)
    PlayerJob = jobInfo
end)

AddEventHandler('onResourceStart', function(resourceName)
    Wait(1000)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    CreateThread(function()
        for k, v in pairs(Config.InfuseItems) do
            RequestNamedPtfxAsset(v.particleDict)
            while not HasNamedPtfxAssetLoaded(v.particleDict) do
                Citizen.Wait(0)
            end
        end
    end)
    UpdatePlayerJob()
    Initialize()
    StartRemovingChainsAndWatchThread()
end)

AddEventHandler("onResourceStop", function (name)
    if name ~= GetCurrentResourceName() then
        return
    end
    RemoveChains()
end)
