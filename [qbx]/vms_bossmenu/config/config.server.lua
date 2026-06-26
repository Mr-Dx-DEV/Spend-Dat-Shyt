SV = {}

-- ██████╗  █████╗ ████████╗ █████╗ ██████╗  █████╗ ███████╗███████╗
-- ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔════╝
-- ██║  ██║███████║   ██║   ███████║██████╔╝███████║███████╗█████╗  
-- ██║  ██║██╔══██║   ██║   ██╔══██║██╔══██╗██╔══██║╚════██║██╔══╝  
-- ██████╔╝██║  ██║   ██║   ██║  ██║██████╔╝██║  ██║███████║███████╗
-- ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝
SV.Database = {
    ['esx'] = {
        ['table:users'] = 'users',
        ['column-users:identifier'] = 'identifier',
        ['column-users:firstname'] = 'firstname',
        ['column-users:lastname'] = 'lastname',
        ['column-users:badge'] = 'badge',
        ['column-users:job'] = 'job',
        ['column-users:job_grade'] = 'job_grade',
        ['column-users:job2'] = 'job2', -- NOT AVAILABLE IN ESX BY DEFAULT
        ['column-users:job_grade2'] = 'job_grade2', -- NOT AVAILABLE IN ESX BY DEFAULT
        
        ['table:job_grades'] = 'job_grades',
        ['table-job_grades:job_name'] = 'job_name',
        ['table-job_grades:grade'] = 'grade',
        ['table-job_grades:label'] = 'label',
        ['table-job_grades:salary'] = 'salary',
    },

    ['qbcore'] = {
        ['table:players'] = 'players',
        ['column-players:citizenid'] = 'citizenid',
        ['column-players:job'] = 'job',
        ['column-players:gang'] = 'gang',
        ['column-players:badge'] = 'badge',
    },
}


-- ██╗    ██╗███████╗██████╗ ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗
-- ██║    ██║██╔════╝██╔══██╗██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝
-- ██║ █╗ ██║█████╗  ██████╔╝███████║██║   ██║██║   ██║█████╔╝ ███████╗
-- ██║███╗██║██╔══╝  ██╔══██╗██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║
-- ╚███╔███╔╝███████╗██████╔╝██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║
--  ╚══╝╚══╝ ╚══════╝╚═════╝ ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝
SV.Webhooks = {
    ['EMPLOYEE_BONUS'] = "",
    ['EMPLOYEE_CHANGE_GRADE'] = "",
    ['EMPLOYEE_FIRE'] = "",
    ['EMPLOYEE_HIRE'] = "",
    ['UPDATE_GRADE_LABEL'] = "",
    ['UPDATE_GRADE_SALARY'] = "",
    ['UPDATE_GRADE_PERMISSIONS'] = "",
    ['WITHDRAW'] = "",
    ['DEPOSIT'] = "",
    ['TRANSFER'] = "",
    ['ANNOUNCEMENT'] = "",
    ['CREATED_CLOTHING'] = "",
    ['MODIFIED_CLOTHING'] = "",
    ['DELETED_CLOTHING'] = "",

    -- ['police'] = "" -- Config.JobMenusSettings useIndividualWebhooks (config.lua)
}

SV.WebhookText = {
    ['TITLE.EMPLOYEE_BONUS'] = "💸 Employee Bonus",
    ['DESCRIPTION.EMPLOYEE_BONUS'] = [[
        Player %s [%s] gave a bonus to employee %s of %s$ in %s
    ]],

    ['TITLE.EMPLOYEE_CHANGE_GRADE'] = "👨‍💼 Employee Change Grade",
    ['DESCRIPTION.EMPLOYEE_CHANGE_GRADE'] = [[
        Player %s [%s] changed the job grade of player %s to %s in %s
    ]],
    
    ['TITLE.CHANGE_BADGE'] = "💼 Employee Change Badge",
    ['DESCRIPTION.CHANGE_BADGE'] = [[
        Player %s [%s] changed the badge number of player %s to %s in %s
    ]],

    ['TITLE.EMPLOYEE_FIRE'] = "❌ Employee Fire",
    ['DESCRIPTION.EMPLOYEE_FIRE'] = [[
        Player %s [%s] fired an employee %s from %s
    ]],

    ['TITLE.EMPLOYEE_HIRE'] = "✅ Employee Hire",
    ['DESCRIPTION.EMPLOYEE_HIRE'] = [[
        Player %s [%s] hired an employee %s (%s) to %s
    ]],

    ['TITLE.UPDATE_GRADE_LABEL'] = "🆕 Update Grade Label",
    ['DESCRIPTION.UPDATE_GRADE_LABEL'] = [[
        Player %s [%s] updated grade label from %s to %s (grade: %s) in %s
    ]],

    ['TITLE.UPDATE_GRADE_SALARY'] = "🆕 Update Grade Salary",
    ['DESCRIPTION.UPDATE_GRADE_SALARY'] = [[
        Player %s [%s] updated grade salary from $%s to $%s (grade: %s) in %s
    ]],

    ['TITLE.UPDATE_GRADE_PERMISSIONS'] = "🆕 Update Grade Permissions",
    ['DESCRIPTION.UPDATE_GRADE_PERMISSIONS'] = [[
        Player %s [%s] made a permissions change for grade %s in %s.

        %s
    ]],

    ['TITLE.WITHDRAW'] = "💲 Withdraw",
    ['DESCRIPTION.WITHDRAW'] = [[
        Player %s [%s] withdrew $%s from %s
    ]],

    ['TITLE.DEPOSIT'] = "💲 Deposit",
    ['DESCRIPTION.DEPOSIT'] = [[
        Player %s [%s] deposit $%s to %s
    ]],

    ['TITLE.TRANSFER'] = "💲 Transfer",
    ['DESCRIPTION.TRANSFER'] = [[
        Player %s [%s] made a $%s transfer from %s to %s.
    ]],
    
    ['TITLE.ANNOUNCEMENT'] = "📰 New Announcement",
    ['DESCRIPTION.ANNOUNCEMENT'] = [[
        %s received an announcement from %s with the content:
        ```%s```
    ]],

    ['TITLE.CREATED_CLOTHING'] = "👕 Created Outfit",
    ['DESCRIPTION.CREATED_CLOTHING'] = [[
        Player %s [%s] created a new outfit **%s** (gender: %s) for %s

        Grades with access:
        ```%s```

        Outfit:
        ```json
        %s
        ```
    ]],

    ['TITLE.MODIFIED_CLOTHING'] = "👕 Modified Outfit",
    ['DESCRIPTION.MODIFIED_CLOTHING'] = [[
        Player %s [%s] modified outfit id %s (gender: %s) in %s

        Grades with access:
        ```%s```

        Outfit:
        ```json
        %s
        ```
    ]],

    ['TITLE.DELETED_CLOTHING'] = "👕 Deleted Outfit",
    ['DESCRIPTION.DELETED_CLOTHING'] = [[
        Player %s [%s] deleted outfit from %s - id %s
    ]],
}

SV.Webhook = function(webhook_id, title, description, color, footer)
    local DiscordWebHook = SV.Webhooks[webhook_id]
    local embeds = {{
        ["title"] = title,
        ["type"] = "rich",
        ["description"] = description,
        ["color"] = color,
        ["footer"] = {
            ["text"] = footer..' - '..os.date(),
        },
    }}
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({embeds = embeds}), {['Content-Type'] = 'application/json'})
end


-- ███████╗██████╗  █████╗ ███╗   ███╗███████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗
-- ██╔════╝██╔══██╗██╔══██╗████╗ ████║██╔════╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝
-- █████╗  ██████╔╝███████║██╔████╔██║█████╗  ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ 
-- ██╔══╝  ██╔══██╗██╔══██║██║╚██╔╝██║██╔══╝  ██║███╗██║██║   ██║██╔══██╗██╔═██╗ 
-- ██║     ██║  ██║██║  ██║██║ ╚═╝ ██║███████╗╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗
-- ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝ ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝
SV.getPlayer = function(src)
    if Config.Core == "ESX" then
        return Core.GetPlayerFromId(src)
    elseif Config.Core == "QB-Core" then
        return Core.Functions.GetPlayer(src)
    end
end

SV.getIdentifier = function(xPlayer)
    if Config.Core == "ESX" then
        return xPlayer.identifier
    elseif Config.Core == "QB-Core" then
        return xPlayer.PlayerData.citizenid
    end
end

SV.getPlayerByIdentifier = function(identifier)
    if Config.Core == "ESX" then
        return Core.GetPlayerFromIdentifier(identifier)
    elseif Config.Core == "QB-Core" then
        return Core.Functions.GetPlayerByCitizenId(identifier)
    end
end

SV.getPlayerByIdentifierOffline = function(identifier)
    if Config.Core == "QB-Core" then
        return Core.Functions.GetOfflinePlayerByCitizenId(identifier)
    end
end

SV.getCharacterName = function(xPlayer)
    if Config.Core == "ESX" then
        return xPlayer.getName()
    elseif Config.Core == "QB-Core" then
        return xPlayer.PlayerData.charinfo.firstname .. ' ' .. xPlayer.PlayerData.charinfo.lastname
    end
end


--      ██╗ ██████╗ ██████╗ 
--      ██║██╔═══██╗██╔══██╗
--      ██║██║   ██║██████╔╝
-- ██   ██║██║   ██║██╔══██╗
-- ╚█████╔╝╚██████╔╝██████╔╝
--  ╚════╝  ╚═════╝ ╚═════╝ 
SV.getPlayerJob = function(xPlayer)
    if Config.Core == "ESX" then
        return xPlayer.job.name
    elseif Config.Core == "QB-Core" then
        return xPlayer.PlayerData.job.name
    end
end

SV.getPlayerJobGrade = function(xPlayer)
    if Config.Core == "ESX" then
        return xPlayer.job.grade
    elseif Config.Core == "QB-Core" then
        return xPlayer.PlayerData.job.grade.level
    end
end

SV.setPlayerJob = function(xPlayer, previousJob, newJob, previousJobGrade, newJobGrade)
    if newJob then
        if Config.Core == "ESX" then
            xPlayer.setJob(newJob, newJobGrade)
            
            MySQL.Async.execute(('UPDATE `%s` SET `%s` = @job, `%s` = @job_grade WHERE `%s` = @identifier'):format(
                SV.Database['esx']['table:users'],
                SV.Database['esx']['column-users:job'],
                SV.Database['esx']['column-users:job_grade'],
                SV.Database['esx']['column-users:identifier']
            ), {
                ['@job'] = newJob,
                ['@job_grade'] = newJobGrade,
                ['@identifier'] = SV.getIdentifier(xPlayer)
            })

            if GetResourceState('wasabi_mulitjob') == 'started' or GetResourceState('wasabi_multijob') == 'started' then
                if previousJob == newJob then
                    MySQL.Async.execute('UPDATE `wasabi_multijob` SET `grade` = @grade WHERE `job` = @job AND `identifier` = @identifier', {
                        ['@job'] = newJob,
                        ['@grade'] = newJobGrade,
                        ['@identifier'] = SV.getIdentifier(xPlayer)
                    })
                end
            end

        elseif Config.Core == "QB-Core" then
            xPlayer.Functions.SetJob(newJob, newJobGrade)
            Core.Player.Save(xPlayer.PlayerData.source)

        end
    else
        if Config.Core == "ESX" then
            xPlayer.setJob('unemployed', 0)

            if GetResourceState('wasabi_mulitjob') == 'started' or GetResourceState('wasabi_multijob') == 'started' then
                MySQL.Async.execute('DELETE FROM `wasabi_multijob` WHERE `identifier` = @identifier AND `job` = @job AND `grade` = @job_grade', {
                    ['@identifier'] = SV.getIdentifier(xPlayer),
                    ['@job'] = previousJob,
                    ['@job_grade'] = previousJobGrade
                })
            end

        elseif Config.Core == "QB-Core" then
            xPlayer.Functions.SetJob('unemployed', 0)
            Core.Player.Save(xPlayer.PlayerData.source)

            if GetResourceState('ps-multijob') == 'started' then
                
            end

        end
    end
end

SV.setPlayerJobOffline = function(identifier, previousJob, name, grade, jobData)
    if Config.Core == "ESX" then
        if name then
            MySQL.Async.execute(('UPDATE `%s` SET `%s` = @job, `%s` = @job_grade WHERE `%s` = @identifier'):format(
                SV.Database['esx']['table:users'],
                SV.Database['esx']['column-users:job'],
                SV.Database['esx']['column-users:job_grade'],
                SV.Database['esx']['column-users:identifier']
            ), {
                ['@job'] = name,
                ['@job_grade'] = grade,
                ['@identifier'] = identifier
            })

            if GetResourceState('wasabi_mulitjob') == 'started' or GetResourceState('wasabi_multijob') == 'started' then
                MySQL.Async.execute('UPDATE `wasabi_multijob` SET `grade` = @grade WHERE `job` = @job AND `identifier` = @identifier', {
                    ['@job'] = name,
                    ['@grade'] = grade,
                    ['@identifier'] = identifier
                })
            end

            return true
        else
            MySQL.Async.execute(('UPDATE `%s` SET `%s` = @job, `%s` = @job_grade WHERE `%s` = @identifier'):format(
                SV.Database['esx']['table:users'],
                SV.Database['esx']['column-users:job'],
                SV.Database['esx']['column-users:job_grade'],
                SV.Database['esx']['column-users:identifier']
            ), {
                ['@job'] = 'unemployed',
                ['@job_grade'] = '0',
                ['@identifier'] = identifier
            })

            if GetResourceState('wasabi_mulitjob') == 'started' or GetResourceState('wasabi_multijob') == 'started' then
                MySQL.Async.execute('DELETE FROM `wasabi_multijob` WHERE `identifier` = @identifier AND `job` = @job', {
                    ['@identifier'] = identifier,
                    ['@job'] = previousJob,
                })
            end

            return true
        end
    elseif Config.Core == "QB-Core" then
        local data = MySQL.query.await(("SELECT `%s` FROM `%s` WHERE `%s` = @citizenid"):format(
            SV.Database['qbcore']['column-players:job'],
            SV.Database['qbcore']['table:players'],
            SV.Database['qbcore']['column-players:citizenid']
        ), {
            ['@citizenid'] = identifier
        })
        if not data or not data[1] then
            return false
        end

        local playerJob = json.decode(data[1][SV.Database['qbcore']['column-players:job']])
        if not playerJob then
            return false
        end
        
        if name then
            local selectedGrade = jobData.grades[tostring(grade)] or jobData.grades[tonumber(grade)]
            if not selectedGrade then
                return
            end

            playerJob.onduty = jobData.defaultDuty
            playerJob.type = jobData.type or 'none'
            playerJob.label = jobData.label
            playerJob.payment = selectedGrade.payment
            playerJob.name = name
            playerJob.grade = {
                level = tonumber(grade),
                name = selectedGrade.name
            }
            playerJob.isboss = selectedGrade.isboss or false
        else
            if not jobData['unemployed'] then
                return
            end
            
            playerJob.onduty = jobData['unemployed'].defaultDuty
            playerJob.type = jobData['unemployed'].type or 'none'
            playerJob.label = jobData['unemployed'].label
            playerJob.payment = jobData['unemployed'].grades['0'].payment
            playerJob.name = 'unemployed'
            playerJob.grade = {
                level = 0,
                name = jobData['unemployed'].grades['0'].name
            }
            playerJob.isboss = false
        end

        playerJob = json.encode(playerJob)

        MySQL.Async.execute(('UPDATE `%s` SET `%s` = @job WHERE `%s` = @citizenid'):format(
            SV.Database['qbcore']['table:players'],
            SV.Database['qbcore']['column-players:job'],
            SV.Database['qbcore']['column-players:citizenid']
        ), {
            ['@job'] = playerJob,
            ['@citizenid'] = identifier
        })
        
        return true
    end
    return false
end


--  ██████╗  █████╗ ███╗   ██╗ ██████╗ 
-- ██╔════╝ ██╔══██╗████╗  ██║██╔════╝ 
-- ██║  ███╗███████║██╔██╗ ██║██║  ███╗
-- ██║   ██║██╔══██║██║╚██╗██║██║   ██║
-- ╚██████╔╝██║  ██║██║ ╚████║╚██████╔╝
--  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ 
SV.getPlayerGang = function(xPlayer)
    if Config.Core == "ESX" then
        return xPlayer.job2.name

    elseif Config.Core == "QB-Core" then
        return xPlayer.PlayerData.gang.name
        
    end
end

SV.getPlayerGangGrade = function(xPlayer)
    if Config.Core == "ESX" then
        return xPlayer.job2.grade
    elseif Config.Core == "QB-Core" then
        return xPlayer.PlayerData.gang.grade and xPlayer.PlayerData.gang.grade.level
    end
end

SV.setPlayerGang = function(xPlayer, previousGang, newGang, previousGangGrade, newGangGrade)
    if newGang then
        if Config.Core == "ESX" then
            if xPlayer.setJob2 then
                xPlayer.setJob2(newGang, newGangGrade)
                MySQL.Async.execute(('UPDATE `%s` SET `%s` = @job2, `%s` = @job_grade2 WHERE `%s` = @identifier'):format(
                    SV.Database['esx']['table:users'],
                    SV.Database['esx']['column-users:job2'],
                    SV.Database['esx']['column-users:job_grade2'],
                    SV.Database['esx']['column-users:identifier']
                ), {
                    ['@job2'] = newGang,
                    ['@job_grade2'] = newGangGrade,
                    ['@identifier'] = SV.getIdentifier(xPlayer)
                })
            end

        elseif Config.Core == "QB-Core" then
            xPlayer.Functions.SetGang(newGang, newGangGrade)
            Core.Player.Save(xPlayer.PlayerData.source)

        end
    else
        if Config.Core == "ESX" then
            if xPlayer.setJob2 then
                xPlayer.setJob2('unemployed', 0)
            end

        elseif Config.Core == "QB-Core" then
            xPlayer.Functions.SetGang('none', 0)
            Core.Player.Save(xPlayer.PlayerData.source)

        end
    end
end

SV.setPlayerGangOffline = function(identifier, name, grade, gangData)
    if Config.Core == "ESX" then
        if name then
            MySQL.Async.execute(('UPDATE `%s` SET `%s` = @job2, `%s` = @job_grade2 WHERE `%s` = @identifier'):format(
                SV.Database['esx']['table:users'],
                SV.Database['esx']['column-users:job2'],
                SV.Database['esx']['column-users:job_grade2'],
                SV.Database['esx']['column-users:identifier']
            ), {
                ['@job2'] = name,
                ['@job_grade2'] = grade,
                ['@identifier'] = identifier
            })
            return true
        else
            MySQL.Async.execute(('UPDATE `%s` SET `%s` = @job2, `%s` = @job_grade2 WHERE `%s` = @identifier'):format(
                SV.Database['esx']['table:users'],
                SV.Database['esx']['column-users:job2'],
                SV.Database['esx']['column-users:job_grade2'],
                SV.Database['esx']['column-users:identifier']
            ), {
                ['@job2'] = 'unemployed',
                ['@job_grade2'] = '0',
                ['@identifier'] = identifier
            })
            return true
        end
    elseif Config.Core == "QB-Core" then
        local data = MySQL.query.await(("SELECT `%s` FROM `%s` WHERE `%s` = @citizenid"):format(
            SV.Database['qbcore']['column-players:gang'],
            SV.Database['qbcore']['table:players'],
            SV.Database['qbcore']['column-players:citizenid']
        ), {
            ['@citizenid'] = identifier
        })
        if not data or not data[1] then
            return false
        end

        local playerGang = json.decode(data[1][SV.Database['qbcore']['column-players:gang']])
        if not playerGang then
            return false
        end
        
        if name then
            local selectedGrade = gangData.grades[tostring(grade)] or gangData.grades[tonumber(grade)]
            if not selectedGrade then
                return
            end

            playerGang.label = gangData.label
            playerGang.name = name
            playerGang.grade = {
                level = tonumber(grade),
                name = selectedGrade.name
            }
            playerGang.isboss = selectedGrade.isboss or false
        else
            if not gangData['none'] then
                return
            end
            
            playerGang.label = gangData['none'].label
            playerGang.name = 'none'
            playerGang.grade = {
                level = 0,
                name = gangData['none'].grades['0'].name
            }
            playerGang.isboss = false
        end

        playerGang = json.encode(playerGang)

        MySQL.Async.execute(('UPDATE `%s` SET `%s` = @gang WHERE `%s` = @citizenid'):format(
            SV.Database['qbcore']['table:players'],
            SV.Database['qbcore']['column-players:gang'],
            SV.Database['qbcore']['column-players:citizenid']
        ), {
            ['@gang'] = playerGang,
            ['@citizenid'] = identifier
        })
        
        return true
        
    end
    return false
end


--      ██╗ ██████╗ ██████╗ ███████╗
--      ██║██╔═══██╗██╔══██╗██╔════╝
--      ██║██║   ██║██████╔╝███████╗
-- ██   ██║██║   ██║██╔══██╗╚════██║
-- ╚█████╔╝╚██████╔╝██████╔╝███████║
--  ╚════╝  ╚═════╝ ╚═════╝ ╚══════╝
SV.getFrameworkJobs = function(cb)
    if Config.Core == "ESX" then
        cb(Core.GetJobs())

    elseif Config.Core == "QB-Core" then
        cb(Core.Shared.Jobs)

    end
end

SV.updateFrameworkJob = function(type, name, grade, value)
    if Config.Core == "ESX" then
        if type == 'label' then
            Core.Jobs[name].grades[tostring(grade)].label = value
            if Core.RefreshJobs then
                Core.RefreshJobs()
            end

        elseif type == 'salary' then
            Core.Jobs[name].grades[tostring(grade)].salary = value
            if Core.RefreshJobs then
                Core.RefreshJobs()
            end
            
        end
    end
end


--  ██████╗  █████╗ ███╗   ██╗ ██████╗ ███████╗
-- ██╔════╝ ██╔══██╗████╗  ██║██╔════╝ ██╔════╝
-- ██║  ███╗███████║██╔██╗ ██║██║  ███╗███████╗
-- ██║   ██║██╔══██║██║╚██╗██║██║   ██║╚════██║
-- ╚██████╔╝██║  ██║██║ ╚████║╚██████╔╝███████║
--  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝
SV.getFrameworkGangs = function(cb)
    if Config.Core == "ESX" then
        cb(Core.GetJobs())

    elseif Config.Core == "QB-Core" then
        cb(Core.Shared.Gangs)

    end
end

SV.updateFrameworkGang = function(type, name, grade, value)
    if Config.Core == "ESX" then
        if type == 'label' then
            Core.Jobs[name].grades[tostring(grade)].label = value
            if Core.RefreshJobs then
                Core.RefreshJobs()
            end
            
        elseif type == 'salary' then
            Core.Jobs[name].grades[tostring(grade)].salary = value
            if Core.RefreshJobs then
                Core.RefreshJobs()
            end

        end
    end
end


-- ███╗   ███╗ ██████╗ ███╗   ██╗███████╗██╗   ██╗
-- ████╗ ████║██╔═══██╗████╗  ██║██╔════╝╚██╗ ██╔╝
-- ██╔████╔██║██║   ██║██╔██╗ ██║█████╗   ╚████╔╝ 
-- ██║╚██╔╝██║██║   ██║██║╚██╗██║██╔══╝    ╚██╔╝  
-- ██║ ╚═╝ ██║╚██████╔╝██║ ╚████║███████╗   ██║   
-- ╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝   ╚═╝   
SV.getMoney = function(xPlayer, moneyType)
    if Config.Core == "ESX" then
        local moneyType = moneyType == 'cash' and 'money' or moneyType
        return xPlayer.getAccount(moneyType).money
    elseif Config.Core == "QB-Core" then
        return xPlayer.Functions.GetMoney(moneyType)
    end
end

SV.addMoney = function(xPlayer, moneyType, count)
    if Config.Core == "ESX" then
        local moneyType = moneyType == 'cash' and 'money' or moneyType == 'dirty' and 'black_money' or moneyType
        xPlayer.addAccountMoney(moneyType, count)
    elseif Config.Core == "QB-Core" then
        xPlayer.Functions.AddMoney(moneyType, count)
    end
end

SV.removeMoney = function(xPlayer, moneyType, count)
    if Config.Core == "ESX" then
        local moneyType = moneyType == 'cash' and 'money' or moneyType
        xPlayer.removeAccountMoney(moneyType, count)
    elseif Config.Core == "QB-Core" then
        xPlayer.Functions.RemoveMoney(moneyType, count)
    end
end

SV.addMoneyOffline = function(identifier, moneyType, count, cb)
    if Config.Core == "ESX" then
        local moneyType = moneyType == 'cash' and 'money' or moneyType == 'dirty' and 'black_money' or moneyType

        local data = MySQL.query.await(("SELECT accounts FROM `%s` WHERE `%s` = @identifier"):format(
            SV.Database['esx']['table:users'],
            SV.Database['esx']['column-users:identifier']
        ), {
            ['@identifier'] = identifier
        })
        if not data or not data[1] then
            if cb then
                cb(false)
            end
            return
        end

        local accounts = json.decode(data[1].accounts)
        if not accounts or not accounts[moneyType] then
            if cb then
                cb(false)
            end
            return
        end

        accounts[moneyType] = tonumber(accounts[moneyType]) + tonumber(count)
        local updatedAccountsJson = json.encode(accounts)
        MySQL.Async.execute(('UPDATE `%s` SET accounts = @accounts WHERE `%s` = @identifier'):format(
            SV.Database['esx']['table:users'],
            SV.Database['esx']['column-users:identifier']
        ), {
            ['@accounts'] = updatedAccountsJson,
            ['@identifier'] = identifier
        })
        if cb then
            cb(true)
        end

    elseif Config.Core == "QB-Core" then
        local data = MySQL.query.await(("SELECT money FROM `%s` WHERE `%s` = @citizenid"):format(
            SV.Database['qbcore']['table:players'],
            SV.Database['qbcore']['column-players:citizenid']
        ), {
            ['@citizenid'] = identifier
        })
        if not data or not data[1] then
            if cb then
                cb(false)
            end
            return
        end

        local accounts = json.decode(data[1].money)
        if not accounts or not accounts[moneyType] then
            if cb then
                cb(false)
            end
            return
        end

        accounts[moneyType] = tonumber(accounts[moneyType]) + tonumber(count)
        local updatedAccountsJson = json.encode(accounts)
        MySQL.Async.execute(('UPDATE `%s` SET money = @money WHERE `%s` = @citizenid'):format(
            SV.Database['qbcore']['table:players'],
            SV.Database['qbcore']['column-players:citizenid']
        ), {
            ['@money'] = updatedAccountsJson,
            ['@citizenid'] = identifier
        })
        if cb then
            cb(true)
        end
    end
end


-- ██████╗ ███████╗ ██████╗ ██╗███████╗████████╗███████╗██████╗     ███████╗████████╗ █████╗ ███████╗██╗  ██╗
-- ██╔══██╗██╔════╝██╔════╝ ██║██╔════╝╚══██╔══╝██╔════╝██╔══██╗    ██╔════╝╚══██╔══╝██╔══██╗██╔════╝██║  ██║
-- ██████╔╝█████╗  ██║  ███╗██║███████╗   ██║   █████╗  ██████╔╝    ███████╗   ██║   ███████║███████╗███████║
-- ██╔══██╗██╔══╝  ██║   ██║██║╚════██║   ██║   ██╔══╝  ██╔══██╗    ╚════██║   ██║   ██╔══██║╚════██║██╔══██║
-- ██║  ██║███████╗╚██████╔╝██║███████║   ██║   ███████╗██║  ██║    ███████║   ██║   ██║  ██║███████║██║  ██║
-- ╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚═╝╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝    ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
SV.registerAllStashes = function()
    if not Config.Inventory or Config.Inventory == 'none' then
        return
    end
    
    for jobName, v in pairs(Config.JobMenusSettings) do
        if v.allowStash and v.stashSettings then
            if Config.Inventory == "ox_inventory" then
                exports['ox_inventory']:RegisterStash(v.stashSettings.id, v.stashSettings.label, v.stashSettings.slots, v.stashSettings.weight, false, jobName)

            elseif Config.Inventory == "origen_inventory" then
                exports['origen_inventory']:registerStash(v.stashSettings.id, v.stashSettings.label, v.stashSettings.slots, v.stashSettings.weight, false, jobName)

            elseif Config.Inventory == "tgiann-inventory" then
                exports['tgiann-inventory']:RegisterStash(v.stashSettings.id, v.stashSettings.label, v.stashSettings.slots, v.stashSettings.weight)

            end
        end
    end
end

SV.openStash = function(src, jobName, stashSettings)
    if Config.Inventory == "qb-inventory" then
        exports['qb-inventory']:OpenInventory(src, stashSettings.id, {
            label = stashSettings.label,
            maxweight = stashSettings.weight,
            slots = stashSettings.slots
        })

    elseif Config.Inventory == "origen_inventory" then
        exports['origen_inventory']:OpenInventory(src, 'stash', stashSettings.id)
        
    elseif Config.Inventory == "tgiann-inventory" then
        exports['tgiann-inventory']:OpenInventory(src, 'stash', stashSettings.id, {
            maxweight = stashSettings.weight,
            slots =  stashSettings.slots,
        })

    end
end




--  ██████╗██╗   ██╗███████╗████████╗ ██████╗ ███╗   ███╗    ███████╗ ██████╗  ██████╗██╗███████╗████████╗██╗   ██╗     █████╗  ██████╗ ██████╗   
-- ██╔════╝██║   ██║██╔════╝╚══██╔══╝██╔═══██╗████╗ ████║    ██╔════╝██╔═══██╗██╔════╝██║██╔════╝╚══██╔══╝╚██╗ ██╔╝    ██╔══██╗██╔════╝██╔════╝   
-- ██║     ██║   ██║███████╗   ██║   ██║   ██║██╔████╔██║    ███████╗██║   ██║██║     ██║█████╗     ██║    ╚████╔╝     ███████║██║     ██║        
-- ██║     ██║   ██║╚════██║   ██║   ██║   ██║██║╚██╔╝██║    ╚════██║██║   ██║██║     ██║██╔══╝     ██║     ╚██╔╝      ██╔══██║██║     ██║        
-- ╚██████╗╚██████╔╝███████║   ██║   ╚██████╔╝██║ ╚═╝ ██║    ███████║╚██████╔╝╚██████╗██║███████╗   ██║      ██║       ██║  ██║╚██████╗╚██████╗██╗
--  ╚═════╝ ╚═════╝ ╚══════╝   ╚═╝    ╚═════╝ ╚═╝     ╚═╝    ╚══════╝ ╚═════╝  ╚═════╝╚═╝╚══════╝   ╚═╝      ╚═╝       ╚═╝  ╚═╝ ╚═════╝ ╚═════╝╚═╝
---@param name string: this will be the accountName from Config.JobMenusSettings
SV.getSocietyMoney = function(name, cb)
    if Config.Banking == 'qb-banking' then
        local society = exports['qb-banking']:GetAccountBalance(name)
        cb(society)

    elseif Config.Banking == 'okokBanking' then
        local society = exports['okokBanking']:GetAccount(name)
        cb(society)

    elseif Config.Banking == 'Renewed-Banking' then
        local society = exports['Renewed-Banking']:getAccountMoney(name)
        cb(society)

    elseif Config.Banking == 'tgg-banking' then
        local society = exports['tgg-banking']:GetSocietyAccountMoney(name)
        cb(society)

    end
end

---@param name string: this will be the accountName from Config.JobMenusSettings
SV.addSocietyMoney = function(name, amount)
    if Config.Banking == 'qb-banking' then
        exports['qb-banking']:AddMoney(name, amount)

    elseif Config.Banking == 'okokBanking' then
        exports['okokBanking']:AddMoney(name, amount)
        
    elseif Config.Banking == 'Renewed-Banking' then
        exports['Renewed-Banking']:addAccountMoney(name, amount)

    elseif Config.Banking == 'tgg-banking' then
        exports['tgg-banking']:AddSocietyMoney(name, amount)

    end
end

---@param name string: this will be the accountName from Config.JobMenusSettings
SV.removeSocietyMoney = function(name, amount)
    if Config.Banking == 'qb-banking' then
        exports['qb-banking']:RemoveMoney(name, amount)

    elseif Config.Banking == 'okokBanking' then
        exports['okokBanking']:RemoveMoney(name, amount)

    elseif Config.Banking == 'Renewed-Banking' then
        exports['Renewed-Banking']:removeAccountMoney(name, amount)

    elseif Config.Banking == 'tgg-banking' then
        exports['tgg-banking']:RemoveSocietyMoney(name, amount)

    end
end