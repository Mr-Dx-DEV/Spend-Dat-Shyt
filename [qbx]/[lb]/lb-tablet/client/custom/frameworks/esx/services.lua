if Config.Framework ~= "esx" then
    return
end

while not ESX do
    Wait(500)
    debugprint("Services: Waiting for ESX to load")
end

---@return string
function GetJob()
    return ESX.PlayerData.job.name
end

---@return boolean
function IsOnDuty()
    local duty = ESX.PlayerData.job.onDuty

    if duty == nil then
        return true
    end

    return duty == true
end

---@return number
function GetJobGrade()
    return ESX.PlayerData?.job?.grade or 0
end

RegisterNetEvent("esx:setJob", function(job)
    local oldJob = ESX.PlayerData.job
    local jobChanged = true

    if oldJob.name == job.name and oldJob.grade == job.grade then
        jobChanged = false
    end

    ESX.PlayerData.job = job

    TriggerEvent("lb-tablet:jobUpdated")

    if jobChanged then
        SendNUIAction("services:setCompany", GetCompanyData())
    else
        SendNUIAction("services:setDuty", job.onDuty)
    end
end)

function GetCompanyData()
    local companyData = {
        job = ESX.PlayerData.job.name,
        jobLabel = ESX.PlayerData.job.label,
        isBoss = ESX.PlayerData.job.grade_name == "boss",
        duty = ESX.PlayerData.job.onDuty,
        receiveCalls = GetCompanyCallsStatus and GetCompanyCallsStatus()
    }

    if not companyData.isBoss then
        return companyData
    end

    ESX.TriggerServerCallback("esx_society:getSocietyMoney", function(money)
        companyData.balance = money
    end, companyData.job)

    ESX.TriggerServerCallback("esx_society:getEmployees", function(employees)
        local onlineIdentifiers = AwaitCallback("services:getOnlineIdentifiers")

        for i = 1, #employees do
            local employee = employees[i]

            employees[i] = {
                name = employee.name,
                id = employee.identifier,

                gradeLabel = employee.job.grade_label,
                grade = employee.job.grade,

                canInteract = employee.job.grade_name ~= "boss",

                online = onlineIdentifiers[employee.identifier]
            }
        end

        companyData.employees = employees
    end, companyData.job)

    ESX.TriggerServerCallback("esx_society:getJob", function(job)
        local grades = {}

        for i = 1, #job.grades do
            local grade = job.grades[i]

            grades[i] = {
                label = grade.label,
                grade = grade.grade
            }
        end

        companyData.grades = grades
    end, companyData.job)

    local timeout = GetGameTimer() + 2000

    while not companyData.balance or not companyData.employees or not companyData.grades do
        Wait(0)

        if GetGameTimer() > timeout then
            infoprint("error", "Failed to get company data (timed out after 2s)")
            print("balance: " .. tostring(companyData.balance))
            print("employees: " .. tostring(companyData.employees))
            print("grades: " .. tostring(companyData.grades))

            companyData.employees = companyData.employees or {}
            companyData.balance = companyData.balance or 0
            companyData.grades = companyData.grades or {}
            break
        end
    end

    return companyData
end

function DepositMoney(amount)
    TriggerServerEvent("esx_society:depositMoney", ESX.PlayerData.job.name, amount)
    Wait(500) -- Wait for the server to update the balance

    local newBalancePromise = promise.new()

    ESX.TriggerServerCallback("esx_society:getSocietyMoney", function(money)
        newBalancePromise:resolve(money)
    end, ESX.PlayerData.job.name)

    return Citizen.Await(newBalancePromise)
end

function WithdrawMoney(amount)
    TriggerServerEvent("esx_society:withdrawMoney", ESX.PlayerData.job.name, amount)
    Wait(500) -- Wait for the server to update the balance

    local newBalancePromise = promise.new()

    ESX.TriggerServerCallback("esx_society:getSocietyMoney", function(money)
        newBalancePromise:resolve(money)
    end, ESX.PlayerData.job.name)

    return Citizen.Await(newBalancePromise)
end

function HireEmployee(source)
    local playersPromise = promise.new()

    ESX.TriggerServerCallback("esx_society:getOnlinePlayers", function(players)
        playersPromise:resolve(players)
    end)

    local players = Citizen.Await(playersPromise)
    local player

    for i = 1, #players do
        if players[i].source == source then
            player = players[i]
            break
        end
    end

    if not player then
        return false
    end

    local hirePromise = promise.new()

    ESX.TriggerServerCallback("esx_society:setJob", function()
        hirePromise:resolve(true)
    end, player.identifier, ESX.PlayerData.job.name, 0, "hire")

    if not Citizen.Await(hirePromise) then
        return
    end

    return {
        id = player.identifier,
        name = player.name,
    }
end

function FireEmployee(identifier)
    local firePomise = promise.new()

    ESX.TriggerServerCallback("esx_society:setJob", function()
        firePomise:resolve(true)
    end, identifier, "unemployed", 0, "fire")

    return Citizen.Await(firePomise)
end

function SetGrade(identifier, newGrade)
    local promotePromise = promise.new()

    ESX.TriggerServerCallback("esx_society:getJob", function(jobData)
        if newGrade > #jobData.grades - 1 then
            return promotePromise:resolve(false)
        end

        ESX.TriggerServerCallback("esx_society:setJob", function()
            promotePromise:resolve(true)
        end, identifier, ESX.PlayerData.job.name, newGrade, "promote")
    end, ESX.PlayerData.job.name)

    return Citizen.Await(promotePromise)
end

function ToggleDuty()
    TriggerServerEvent("tablet:services:toggleDuty")
end
