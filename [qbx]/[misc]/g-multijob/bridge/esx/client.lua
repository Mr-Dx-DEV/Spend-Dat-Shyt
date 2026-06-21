---@diagnostic disable: duplicate-set-field, missing-fields
if GetResourceState("es_extended") ~= "started" then
    return
end

ESX = exports.es_extended:getSharedObject()

G.Client = {
    playerData = {}
}

RegisterNetEvent('esx:setJob', function(job, lastJob)
	local data = {
		name = job.name,
		label = job.label,
		onDuty = job.onDuty,
		grade = job.grade,
		gradeName = job.grade_name,
	}
    TriggerServerEvent('justgroot:g-multijob:server:jobchanged', data)
    ESX.SetPlayerData('job', data)
end)

function G.Client.GetCore()
    return ESX
end

function G.Client.GetPlayerData()
    return G.Client.playerData
end

function G.Client.GetPlayerJob()
    local playerData = ESX.GetPlayerData()
    if not playerData or not playerData.job then
        return nil
    end
    return {
        name = playerData.job.name,
        label = playerData.job.label,
        grade_name = playerData.job.grade_name,
        grade_label = playerData.job.grade_label,
        grade_salary = playerData.job.grade_salary,
        grade = playerData.job.grade,
        isboss = playerData.job.grade_name == "boss" or false,
        onduty = (playerData.job and playerData.job.onDuty ~= nil) and playerData.job.onDuty or true,
        isGang = false
    }
end

function G.Client.GetIdentifier()
    return ESX.GetPlayerData().identifier
end

function G.Client.GetPlayerName()
    local playerData = ESX.GetPlayerData()
    if not playerData then
        return "Unknown"
    end

    if playerData.firstName and playerData.lastName then
        return playerData.firstName .. " " .. playerData.lastName
    end

    if playerData.name then
        return playerData.name
    end

    return "Unknown"
end
