if GetResourceState("qb-core") ~= "started" then
    return
end
---@diagnostic disable: duplicate-set-field
QBCore = exports["qb-core"]:GetCoreObject()
G.Server = {};

function G.Server.GetCore()
    return QBCore
end

function G.Server.GetPlayer(src)
    return QBCore.Functions.GetPlayer(src)
end

function G.Server.GetPlayers()
    return QBCore.Functions.GetPlayers()
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
    local xPlayer = QBCore.Functions.GetPlayer(src)
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
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if not xPlayer then
        return false
    end

    local job = xPlayer.PlayerData.job
    if not job then
        return false
    end

    local success = pcall(function()
        xPlayer.Functions.SetJobDuty(onDuty)
    end)

    return success
end

function G.Server.SetPlayerJob(src, jobName, grade, oldJob)
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if not xPlayer then
        return false
    end
    local success = pcall(function()
        xPlayer.Functions.SetJob(jobName, grade or 0)
    end)
    return success
end

function G.Server.CommandsAdd(name, help, arguments, arg, callback, permission, ...)
    QBCore.Commands.Add(name, help, arguments, arg, function(source, args)
        local namedArgs = {}
        if arguments then
            for i, argDef in ipairs(arguments) do
                if argDef.name and args[i] ~= nil then
                    local value = args[i]
                    if argDef.type == "number" then
                        value = tonumber(value)
                    elseif argDef.type == "boolean" then
                        value = value == "true" or value == true
                    end
                    namedArgs[argDef.name] = value
                end
            end
        end
        callback(source, namedArgs)
    end, permission, ...)
end

function G.Server.IsValidFrameworkJob(jobName)
    if not jobName or jobName == "" then
        return false
    end
    local jobs = QBCore.Shared.Jobs
    return jobs and jobs[jobName:lower()] ~= nil
end

function G.Server.GetJobInfo(jobName, grade)
    if not jobName or jobName == "" then
        return nil
    end
    local jobs = QBCore.Shared.Jobs
    if not jobs then
        return nil
    end
    local job = jobs[jobName:lower()]
    if not job then
        return nil
    end
    grade = grade or 0
    local gradeData = job.grades and job.grades[tostring(grade)] or job.grades[grade] or nil
    return {
        job = jobName,
        jobLabel = job.label or jobName,
        grade = grade,
        gradeLabel = gradeData and gradeData.name or ""
    }
end

