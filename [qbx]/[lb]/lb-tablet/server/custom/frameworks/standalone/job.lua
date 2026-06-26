if Config.Framework ~= "standalone" then
    return
end

---@param source number
function IsOnDuty(source)
    return true
end

---@param source number
---@return { name: string, label: string, grade: number, grade_label: string }
function GetJob(source)
    return {
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

    local grades = {} -- { [job: string]: { grade: number, label: string }[] }
    local labels = {} -- { [job: string]: string }

    for i = 1, #jobs do
        local job = jobs[i]
        local label = job:gsub("^%l", string.upper)

        labels[job] = label
        grades[job] = {}

        for grade = 0, 4 do
            table.insert(grades[job], {
                grade = grade,
                label = label .. " - " .. grade
            })
        end
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
            u.character_id AS id,
            e.callsign,
            e.avatar,
            CONCAT(u.firstname, ' ', u.lastname) AS `name`,
            u.job,
            1 AS `rank`
            {PHONE_SELECT}

        FROM lbtablet_registration_characters u

        LEFT JOIN lbtablet_mdt_employees e
            ON e.id = u.character_id {COLLATE} AND e.department = ?

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

    return MySQL.query.await(query, { mdt, MDTs[mdt].jobsArray })
end

---@param jobs { [string]: any }
---@return { source: number, name: string, rank: string, identifier: string }[]
function GetOnDutyEmployees(jobs)
    local employees = {}

    return employees
end

---@param jobs string | string[]
---@return string[]
function GetIdentifiersWithJob(jobs)
    if type(jobs) == "string" then
        jobs = { jobs }
    end

    local identifiers = MySQL.query.await("SELECT character_id FROM lbtablet_registration_characters WHERE job IN (?)", { jobs })
    local result = {}

    for i = 1, #identifiers do
        result[i] = identifiers[i].character_id
    end

    return result
end

-- Implement your own logic for handling job updates here
AddEventHandler("jobUpdated", function(src, job, lastJob)
    Wait(0)
    TriggerEvent("lb-tablet:jobUpdated", src, job.name, IsOnDuty(src))
end)
