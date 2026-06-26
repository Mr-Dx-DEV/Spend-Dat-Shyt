if Config.Framework ~= "standalone" then
    return
end

---@return string
function GetJob()
    return "unemployed"
end

---@return boolean
function IsOnDuty()
    return true
end

---@return number
function GetJobGrade()
    return 0
end

-- Trigger the following event when the player's job is updated: TriggerEvent("lb-tablet:jobUpdated")

function GetCompanyData()
    local companyData = {
        job = "unemployed",
        jobLabel = "Unemployed",
        isBoss = false,
        duty = true,
        receiveCalls = GetCompanyCallsStatus and GetCompanyCallsStatus()
    }

    -- If the player is boss, also return: balance, employees, grades
    -- see the esx.lua/qb.lua files for examples

    return companyData
end

---@param amount number
---@return number newBalance
function DepositMoney(amount)
    return 0
end

---@param amount number
---@return number newBalance
function WithdrawMoney(amount)
    return 0
end

---@param source number
---@return boolean success
function HireEmployee(source)
    return false
end

---@param identifier string
---@return boolean success
function FireEmployee(identifier)
    return false
end

---@param identifier string
---@param newGrade number
---@return boolean success
function SetGrade(identifier, newGrade)
    return false
end

function ToggleDuty()
    TriggerServerEvent("tablet:services:toggleDuty")
end
