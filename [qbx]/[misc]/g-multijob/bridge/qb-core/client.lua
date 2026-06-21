---@diagnostic disable: duplicate-set-field, missing-fields
if GetResourceState("qb-core") ~= "started" then
    return
end

QBCore = exports["qb-core"]:GetCoreObject()

G.Client = {
    playerLoaded = false,
    playerData = {}
}

RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function(playerData)
    G.Client.playerData = playerData
    G.Client.playerLoaded = true
end)

RegisterNetEvent("QBCore:Client:OnJobUpdate")
AddEventHandler("QBCore:Client:OnJobUpdate", function(job)
    if G.Client.playerData and G.Client.playerData.job then
        G.Client.playerData.job = job
    end
    QBCore.Functions.GetPlayerData().job = job
    
    local data = {
        name = job.name,
        label = job.label,
        onDuty = job.onduty,
        grade = job.grade and job.grade.level or 0,
        gradeName = job.grade and job.grade.name or nil,
    }
    TriggerServerEvent('justgroot:g-multijob:server:jobchanged', data)
end)

RegisterNetEvent("QBCore:Player:SetPlayerData", function(PlayerData)
    G.Client.playerData = PlayerData
end)

function G.Client.GetCore()
    return QBCore
end

function G.Client.GetPlayerData()
    return G.Client.playerData
end

function G.Client.GetPlayerJob()
    local playerData = QBCore.Functions.GetPlayerData()
    if not playerData or not playerData.job then
        return nil
    end
    
    local job = playerData.job
    local grade = job.grade or {}
    
    return {
        name = job.name,
        label = job.label,
        grade_name = grade.name,
        grade_label = grade.name,
        grade_salary = grade.payment or 0,
        grade = grade.level or 0,
        isboss = job.isboss or false,
        onduty = job.onduty ~= nil and job.onduty or true,
        isGang = false
    }
end

function G.Client.GetIdentifier()
    local playerData = QBCore.Functions.GetPlayerData()
    if not playerData or not playerData.citizenid then
        return nil
    end
    return playerData.citizenid
end

function G.Client.GetPlayerName()
    local playerData = QBCore.Functions.GetPlayerData()
    if not playerData or not playerData.charinfo then
        return "Unknown"
    end

    if playerData.charinfo.firstname and playerData.charinfo.lastname then
        return playerData.charinfo.firstname .. " " .. playerData.charinfo.lastname
    end

    return "Unknown"
end
