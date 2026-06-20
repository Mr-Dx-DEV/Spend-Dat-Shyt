---@diagnostic disable: duplicate-set-field, undefined-field, missing-fields
if GetResourceState("qbx_core") ~= "started" then
    return
end

QBox = exports.qbx_core
G.Server = {};

function G.Server.GetCore()
    return QBox
end

function G.Server.GetPlayer(src)
    return QBox:GetPlayer(src)
end

function G.Server.GetPlayers()
    local players = QBox:GetQBPlayers()
    local playerList = {}
    for src, _ in pairs(players) do
        table.insert(playerList, src)
    end
    return playerList
end

function G.Server.GetPlayerName(src)
    local xPlayer = G.Server.GetPlayer(src)
    if not xPlayer or not xPlayer.PlayerData or not xPlayer.PlayerData.charinfo then
        return nil
    end
    return xPlayer.PlayerData.charinfo.firstname .. " " .. xPlayer.PlayerData.charinfo.lastname
end

function G.Server.GetIdentifier(src)
    local xPlayer = G.Server.GetPlayer(src)
    return xPlayer and xPlayer.PlayerData.citizenid or nil
end

function G.Server.PlayerJobinfo(src)
    local xPlayer = QBox:GetPlayer(src)
    if not xPlayer then
        return nil
    end
    local j = xPlayer.PlayerData.job
    if not j then
        return nil
    end
    local grade = j.grade or {}
    return {
        name = j.name,
        label = j.label,
        grade = grade.level or 0,
        gradeLabel = grade.name or "",
        isGang = false
    }
end

function G.Server.isOnDuty(src)
    local xPlayer = G.Server.GetPlayer(src)
    local job = xPlayer and xPlayer.PlayerData.job
    return job and job.onduty == true or false
end

function G.Server.SetDuty(src, onDuty)
    local xPlayer = QBox:GetPlayer(src)
    if not xPlayer then
        return false
    end

    local job = xPlayer.PlayerData.job
    if not job then
        return false
    end

    local success = pcall(function()
        QBox:SetJobDuty(xPlayer.PlayerData.citizenid, onDuty)
    end)

    return success
end

function G.Server.SetPlayerJob(src, jobName, grade, oldJob)
    local xPlayer = QBox:GetPlayer(src)
    if not xPlayer then
        return false
    end
    local success = pcall(function()
        xPlayer.Functions.SetJob(jobName, grade or 0)
    end)
    return success
end

function G.Server.CommandsAdd(name, help, arguments, arg, callback, permission, ...)
    lib.addCommand(name, {
        help = help,
        params = arguments,
        restricted = permission
    }, function(source, args, raw)
        callback(source, args, raw)
    end)
end


function G.Server.IsValidFrameworkJob(jobName)
    if not jobName or jobName == "" then
        return false
    end
    local jobs = QBox.GetJobs()
    if not jobs then
        return false
    end
    return jobs[jobName:lower()] ~= nil or jobs[jobName] ~= nil
end

function G.Server.GetJobInfo(jobName, grade)
    if not jobName or jobName == "" then
        return nil
    end
    local jobs = QBox.GetJobs()
    if not jobs then
        return nil
    end
    local job = jobs[jobName:lower()] or jobs[jobName]
    if not job then
        return nil
    end
    grade = grade or 0
    local gradeData = job.grades and (job.grades[tostring(grade)] or job.grades[grade]) or nil
    return {
        job = jobName,
        jobLabel = job.label or jobName,
        grade = grade,
        gradeLabel = gradeData and gradeData.name or ""
    }
end