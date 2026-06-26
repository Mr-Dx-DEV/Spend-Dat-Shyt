if Config.Core ~= "ESX" then
    return
end

library.RegisterCallback('esx_society:getEmployees', function(source, cb, society)
    local employees = {}

    local xPlayers = Core.GetExtendedPlayers('job', society)
    for i = 1, #(xPlayers) do
        local xPlayer = xPlayers[i]
        local name = xPlayer.get('firstName') .. ' ' .. xPlayer.get('lastName')
        table.insert(employees, {
            name = name,
            identifier = xPlayer.identifier,
            job = {
                name = society,
                label = xPlayer.job.label,
                grade = xPlayer.job.grade,
                grade_name = xPlayer.job.grade_name,
                grade_label = xPlayer.job.grade_label
            }
        })
    end

    MySQL.query("SELECT identifier, job_grade, firstname, lastname FROM `users` WHERE `job`= ? ORDER BY job_grade DESC", {society}, function(result)
        for k, row in pairs(result) do
            local alreadyInTable
            local identifier = row.identifier

            for k, v in pairs(employees) do
                if v.identifier == identifier then
                    alreadyInTable = true
                end
            end

            if not alreadyInTable then
                table.insert(employees, {
                    name = row.firstname .. ' ' .. row.lastname,
                    identifier = identifier,
                    job = {
                        name = society,
                        label = Core.Jobs[society].label,
                        grade = row.job_grade,
                        grade_name = Core.Jobs[society].grades[tostring(row.job_grade)].name,
                        grade_label = Core.Jobs[society].grades[tostring(row.job_grade)].label
                    }
                })
            end
        end

        cb(employees)
    end)

end)
