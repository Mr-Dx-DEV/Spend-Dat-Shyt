---@diagnostic disable: duplicate-set-field
if GetResourceState("es_extended") ~= "started" then
    return;
end
ESX = exports.es_extended:getSharedObject();
G.Server = {};
function G.Server.GetCore()
    return ESX;
end

function G.Server.GetPlayer(src)
    return ESX.GetPlayerFromId(src);
end

function G.Server.GetPlayers()
    return ESX.GetExtendedPlayers();
end

function G.Server.GetPlayerName(src)
    local xPlayer = G.Server.GetPlayer(src)
    return xPlayer and (xPlayer.variables.firstName .. " " .. xPlayer.variables.lastName) or nil
end

function G.Server.GetIdentifier(src)
    local xPlayer = G.Server.GetPlayer(src)
    return xPlayer and xPlayer.identifier or nil
end

function G.Server.PlayerJobinfo(src)
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then
        return nil;
    end
    local j = xPlayer.getJob();
    if not j then
        return nil;
    end
    return {
        name = j.name,
        label = j.label,
        grade = j.grade,
        gradeLabel = j.grade_label,
        isGang = false
    };
end

function G.Server.isOnDuty(src)
    local xPlayer = G.Server.GetPlayer(src)
    local job = xPlayer and xPlayer.getJob()
    return job and job.onDuty == true or false
end

function G.Server.SetDuty(src, onDuty)
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then
        return false
    end

    local job = xPlayer.getJob()
    if not job then
        return false
    end

    local success = pcall(function()
        xPlayer.setJob(job.name, job.grade, onDuty)
    end)

    return success
end

function G.Server.SetPlayerJob(src, jobName, grade, oldJob)
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then
        return false
    end
    local success = pcall(function()
        xPlayer.setJob(jobName, grade, false)
    end)
    return success
end

function G.Server.CommandsAdd(name, help, arguments, arg, callback, permission, ...)
    ESX.RegisterCommand(name, permission, function(xPlayer, args, showError)
        callback(xPlayer.source, args)
    end, false, {
        help = help,
        arguments = arguments
    })
end

function G.Server.IsValidFrameworkJob(jobName)
    if not jobName or jobName == "" then
        return false
    end
    local jobs = ESX.GetJobs()
    return jobs and jobs[jobName:lower()] ~= nil
end

function G.Server.GetJobInfo(jobName, grade)
    if not jobName or jobName == "" then
        return nil
    end
    local jobs = ESX.GetJobs()
    if not jobs then
        return nil
    end
    local job = jobs[jobName:lower()]
    if not job then
        return nil
    end
    grade = grade or 0
    local gradeData = job.grades and (job.grades[tostring(grade)] or job.grades[grade]) or nil
    return {
        job = jobName,
        jobLabel = job.label or jobName,
        grade = grade,
        gradeLabel = gradeData and gradeData.label or ""
    }
end