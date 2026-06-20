local sharedObject = GetSharedObject()
local playerData = {}

if Config.Framework.Active == Framework.ESX then
    CreateThread(function()
        if sharedObject.IsPlayerLoaded() then
            playerData = sharedObject.GetPlayerData()
        end
    end, "ESX fetching player data from start")

    RegisterNetEvent('esx:playerLoaded', function(xPlayer)
        playerData = xPlayer
    end)

    RegisterNetEvent('esx:setJob', function(job)
        playerData.job = job
    end)
end

if Config.Framework.Active == Framework.QBCORE then
    function UpdatePlayerDataForQBCore()
        local pData = sharedObject.Functions.GetPlayerData()

        local jobName = "none"
        local gradeName = "none"

        if pData.job then
            jobName = pData.job.name or "none"

            if pData.job.grade then
                gradeName = pData.job.grade.name
            end
        end

        playerData = {
            job = {
                name = jobName,
                grade_name = gradeName,
            }
        }
    end

    CreateThread(function()
        if sharedObject and sharedObject.Functions.GetPlayerData() then
            UpdatePlayerDataForQBCore()
        end
    end, "QBCore fetching player data from start")

    RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
        UpdatePlayerDataForQBCore()
    end)

    RegisterNetEvent("QBCore:Client:OnJobUpdate", function()
        UpdatePlayerDataForQBCore()
    end)
end

function IsPlayerAtJob(job)
    local convertedJobArray = {}
    if type(job) == "table" then
        for k, v in pairs(job) do
            convertedJobArray[v] = true
        end
    else
        convertedJobArray[job] = true
    end

    if Config.Framework.Active == Framework.ESX or Config.Framework.Active == Framework.QBCORE then
        return convertedJobArray[playerData.job.name] ~= nil
    end

    if Config.Framework.Active == Framework.CUSTOM then
        return true
    end
end