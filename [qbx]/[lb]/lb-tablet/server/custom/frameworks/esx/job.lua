if Config.Framework ~= "esx" then
    return
end

while not ESX do
    Wait(500)
end

---@param source number
function IsOnDuty(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.onDuty == nil then
        return true
    end

    return xPlayer.job.onDuty == true
end

---@param source number
---@return { name: string, label: string, grade: number, grade_label: string }
function GetJob(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    return xPlayer?.job or {
        name = "unemployed",
        label = "Unemployed",
        grade = 0,
        grade_label = "Unemployed"
    }
end

---@param jobs string | string[]
---@return { grades: { [string]: { grade: number, label: string }[] }, labels: { [string]: string } }
function GetJobGrades(jobs)
    if type(jobs) == "string" then
        jobs = { jobs }
    end

    local esxJobs = ESX.GetJobs()
    local grades = {}
    local labels = {}

    for i = 1, #jobs do
        local job = jobs[i]
        local jobData = esxJobs[job]

        if not jobData then
            debugprint("Job not found", job)
            goto continue
        end

        grades[job] = {}
        labels[job] = jobData.label

        local amountGrades = 0

        for _, grade in pairs(jobData.grades) do
            amountGrades += 1
            grades[job][amountGrades] = {
                grade = grade.grade,
                label = grade.label
            }
        end

        table.sort(grades[job], function(a, b)
            return a.grade < b.grade
        end)

        ::continue::
    end

    return {
        grades = grades,
        labels = labels
    }
end

---@param mdt string
function GetEmployees(mdt)
    local query = [[
        SELECT
            u.identifier AS id,
            e.callsign,
            e.avatar,
            CONCAT(u.firstname, ' ', u.lastname) AS `name`,
            u.job,
            u.job_grade AS `rank`
            {PHONE_SELECT}

        FROM users u

        LEFT JOIN lbtablet_mdt_employees e
            ON e.id = u.identifier {COLLATE} AND e.department = ?

        {PHONE_JOIN}

        WHERE
            u.job IN (?)
    ]]

    if Config.LBPhone then
        local phoneConfig = GetPhoneConfig()

        query = query:gsub("{PHONE_SELECT}", ", p.phone_number AS phoneNumber")

        if phoneConfig?.Item?.Unique then
            query = query:gsub("{PHONE_JOIN}", "LEFT JOIN phone_last_phone p ON u.identifier {COLLATE} = p.id")
        else
            query = query:gsub("{PHONE_JOIN}", "LEFT JOIN phone_phones p ON u.identifier {COLLATE} = p.id")
        end
    else
        query = query:gsub("{PHONE_SELECT}", "")
        query = query:gsub("{PHONE_JOIN}", "")
    end

    query = query:gsub("{COLLATE}", UsersCollate)

    return MySQL.query.await(query, { mdt, MDTs[mdt].jobsArray })
end

---@param jobs { [string]: any }
---@return { source: number, name: string, rank: string, identifier: string }[]
function GetOnDutyEmployees(jobs)
    local jobsArray = {}
    local employees = {}

    for jobName in pairs(jobs) do
        jobsArray[#jobsArray+1] = jobName
    end

    local xPlayers = ESX.GetExtendedPlayers("job", jobsArray)

    for job, players in pairs(xPlayers) do
        for i = 1, #players do
            local xPlayer = players[i]

            employees[#employees+1] = {
                source = xPlayer.source,
                name = xPlayer.name,
                rank = xPlayer.job.grade_label,
                identifier = xPlayer.identifier
            }
        end
    end

    return employees
end

---@param jobs string | string[]
---@return string[]
function GetIdentifiersWithJob(jobs)
    if type(jobs) == "string" then
        jobs = { jobs }
    end

    local identifiers = MySQL.query.await("SELECT identifier FROM users WHERE job IN (?)", { jobs })
    local result = {}

    for i = 1, #identifiers do
        result[i] = identifiers[i].identifier
    end

    return result
end

AddEventHandler("esx:setJob", function(src, job, lastJob)
    Wait(0)
    TriggerEvent("lb-tablet:jobUpdated", src, job.name, IsOnDuty(src))
end)
