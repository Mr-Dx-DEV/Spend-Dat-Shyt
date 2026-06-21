---@diagnostic disable: duplicate-set-field, undefined-field, missing-fields
if GetResourceState("qbx_core") ~= "started" then
    return
end

QBox = exports.qbx_core

G.Client = {
    playerLoaded = false,
    playerData = {}
}

RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function(playerData)
    Wait(1500)
    G.Client.playerData = QBox.GetPlayerData()
    G.Client.playerLoaded = LocalPlayer.state.isLoggedIn or false
end)

RegisterNetEvent("QBCore:Client:OnJobUpdate")
AddEventHandler("QBCore:Client:OnJobUpdate", function(job)
    local playerData = QBox.GetPlayerData()
    if playerData and playerData.job then
        playerData.job = job
    end
    G.Client.playerData = playerData
    
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
    return QBox
end

function G.Client.GetPlayerData()
    local playerData = QBox.GetPlayerData()
    if playerData then
        G.Client.playerData = playerData
    end
    return G.Client.playerData
end

function G.Client.GetPlayerJob()
    local playerData = QBox.GetPlayerData()
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
    local playerData = QBox.GetPlayerData()
    if not playerData or not playerData.citizenid then
        return nil
    end
    return playerData.citizenid
end

function G.Client.GetPlayerName()
    local playerData = QBox.GetPlayerData()
    if not playerData or not playerData.charinfo then
        return "Unknown"
    end

    if playerData.charinfo.firstname and playerData.charinfo.lastname then
        return playerData.charinfo.firstname .. " " .. playerData.charinfo.lastname
    end

    return "Unknown"
end