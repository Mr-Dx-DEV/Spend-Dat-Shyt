local JobManager = require 'bridge.server.job'

---@class SocietyManager
local SocietyManager = {}

local function isResourceStarted(resourceName)
    return GetResourceState(resourceName) == 'started'
end

local function hasStartedResource(resourceNames)
    for _, name in ipairs(resourceNames) do
        if isResourceStarted(name) then return true end
    end
    return false
end

---@param frameworks string[]|nil
local function matchesFramework(frameworks)
    if not frameworks then return true end
    for _, framework in ipairs(frameworks) do
        if framework == Framework.name then return true end
    end
    return false
end

local function tableExists(tableName)
    local ok, count = pcall(function()
        return MySQL.scalar.await(
            'SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = DATABASE() AND table_name = ?',
            { tableName }
        )
    end)
    if not ok then return false end
    return tonumber(count) > 0
end

local function normalizeExportBalance(value)
    if type(value) == 'number' then return value end
    if type(value) ~= 'table' then return nil end

    for _, key in ipairs({ 'balance', 'amount', 'account_balance', 'money', 'newBalance' }) do
        if value[key] ~= nil then return tonumber(value[key]) end
    end

    return nil
end

local function callResourceExport(resourceName, exportName, ...)
    local ok, result = pcall(exports[resourceName][exportName], ...)
    if ok then return result end
    return nil
end

---@param resourceNames string[]
local function getStartedExportResource(resourceNames)
    for _, name in ipairs(resourceNames) do
        if isResourceStarted(name) then return name end
    end
    return nil
end

---@param societyName string
---@return string[]
local function getSocietyNameVariants(societyName)
    local rawName = tostring(societyName or ''):match('^%s*(.-)%s*$') or ''
    local normalizedName = rawName:gsub('^society_', ''):match('^%s*(.-)%s*$') or ''
    if normalizedName == '' then return {} end

    local seen = {}
    local names = {}

    local function add(name)
        if name ~= '' and not seen[name] then
            seen[name] = true
            names[#names + 1] = name
        end
    end

    add(normalizedName)
    add(rawName)
    if not normalizedName:find('^society_') then add('society_' .. normalizedName) end

    return names
end

---@param accountName string
---@param prefixed boolean|nil
---@return string[]
local function getAccountNameVariants(accountName, prefixed)
    local names = { accountName }
    if prefixed then
        if not accountName:find('^society_') then names[#names + 1] = 'society_' .. accountName end
        if not accountName:find('^B') then names[#names + 1] = 'B' .. accountName:upper() end
    end
    return names
end

---@return table[]|nil
local function getSocietyBalanceRowsFromTables()
    local sources = {
        {
            resources = { 'okokBanking' },
            table = 'okokbanking_societies',
            query =
            'SELECT society as name, society_name as label, value as balance FROM okokbanking_societies ORDER BY value DESC',
        },
        {
            resources = { 'tgg-banking' },
            table = 'tgg_banking_accounts',
            query =
            "SELECT ownerId as name, name as label, balance FROM tgg_banking_accounts WHERE type = 'business' ORDER BY balance DESC",
        },
        {
            resources = { 'vms_bossmenu' },
            table = 'bossmenu',
            query =
            "SELECT job as name, account_name as label, balance FROM bossmenu WHERE type IN ('job', 'gang') ORDER BY balance DESC",
        },
        {
            resources = { 'Renewed-Banking', 'renewed-banking', 'renewed_banking', 'qbx_management', 'qbx_core' },
            frameworks = { 'qb', 'qbx' },
            table = 'bank_accounts_new',
            query = 'SELECT id as name, amount as balance FROM bank_accounts_new ORDER BY amount DESC',
        },
        {
            resources = { 'wasabi_banking' },
            frameworks = { 'qbx' },
            table = 'bank_accounts_new',
            query = 'SELECT id as name, amount as balance FROM bank_accounts_new ORDER BY amount DESC',
        },
        {
            resources = { 'qb-banking', 'qb-management', 'wasabi_banking' },
            frameworks = { 'qb' },
            table = 'bank_accounts',
            query =
            "SELECT account_name as name, account_balance as balance FROM bank_accounts WHERE account_type IN ('job', 'gang') ORDER BY account_balance DESC",
        },
        {
            resources = { 'qb-management', 'dw-bossmenu', 'dw_bossmenu', 'fd_banking', 'fd-banking', 'wasabi_banking' },
            table = 'management_funds',
            query =
            "SELECT job_name as name, amount as balance FROM management_funds WHERE type IN ('boss', 'gang', 'job') ORDER BY amount DESC",
        },
        {
            resources = { 'esx_management', 'esx_society', 'm-Banking', 'm-banking', 'mBanking', 'm_banking' },
            table = 'addon_account_data',
            query = [[SELECT REPLACE(account_name, 'society_', '') as name, money as balance
                FROM addon_account_data
                WHERE account_name LIKE 'society_%'
                  AND (owner IS NULL OR owner = '')
                ORDER BY money DESC
                LIMIT 100]],
        },
        {
            resources = { 'wasabi_banking' },
            frameworks = { 'esx' },
            table = 'addon_account_data',
            query = [[SELECT REPLACE(account_name, 'society_', '') as name, money as balance
                FROM addon_account_data
                WHERE account_name LIKE 'society_%'
                  AND (owner IS NULL OR owner = '')
                ORDER BY money DESC
                LIMIT 100]],
        },
    }

    for _, source in ipairs(sources) do
        if not matchesFramework(source.frameworks) then goto continue end
        if not hasStartedResource(source.resources) then goto continue end
        if not tableExists(source.table) then goto continue end

        local ok, rows = pcall(function()
            return MySQL.query.await(source.query)
        end)
        if ok and rows then return rows end

        ::continue::
    end

    return nil
end

---@param accounts { name: string, label: string }[]
---@return table[]|nil
local function getSocietyBalanceRowsFromExports(accounts)
    local sources = {
        {
            resources = { 'prism_banking', 'prism-banking' },
            exportResource = 'prism_banking',
            methods = { 'GetSocietyBalance' },
        },
        {
            resources = { 'kartik-banking' },
            exportResource = 'kartik-banking',
            methods = { 'GetAccountMoney' },
        },
        {
            resources = { 'g-bossmenu', 'g-management', 'g-banking', 'g-billing' },
            exportResource = 'g-bossmenu',
            methods = { 'GetSocietyMoney' },
        },
        {
            resources = { 'bablo-banking' },
            exportResource = 'bablo-banking',
            methods = { 'GetSocietyBalance' },
            prefixed = true,
        },
        {
            resources = { 'tgg-banking' },
            exportResource = 'tgg-banking',
            methods = { 'GetSocietyAccountMoney' },
        },
        {
            resources = { 'fd_banking' },
            exportResource = 'fd_banking',
            methods = { 'GetAccount', 'GetGangAccount', 'getBusinessAccount' },
        },
    }

    for _, source in ipairs(sources) do
        local activeResource = getStartedExportResource(source.resources)
        if not activeResource then goto continue end

        local exportResource = isResourceStarted(source.exportResource) and source.exportResource or activeResource
        local rows = {}

        for _, account in ipairs(accounts) do
            local balance = nil

            for _, accountName in ipairs(getAccountNameVariants(account.name, source.prefixed)) do
                for _, method in ipairs(source.methods) do
                    balance = normalizeExportBalance(callResourceExport(exportResource, method, accountName))
                    if balance ~= nil then break end
                end
                if balance ~= nil then break end
            end

            if balance ~= nil then
                rows[#rows + 1] = { name = account.name, label = account.label, balance = balance }
            end
        end

        if #rows > 0 then
            table.sort(rows, function(a, b) return a.balance > b.balance end)
            return rows
        end

        ::continue::
    end

    return nil
end

---@param societyName string
---@param value number
---@return boolean
local function updateSocietyBalanceInTables(societyName, value)
    local balance = tonumber(value)
    local names = getSocietyNameVariants(societyName)
    if balance == nil or #names == 0 then return false end

    local placeholders = string.rep('?,', #names):sub(1, -2)
    local sources = {
        {
            resources = { 'okokBanking' },
            table = 'okokbanking_societies',
            query = ('UPDATE okokbanking_societies SET value = ? WHERE society IN (%s)'):format(placeholders),
        },
        {
            resources = { 'tgg-banking', 'tgg_banking' },
            table = 'tgg_banking_accounts',
            query = ("UPDATE tgg_banking_accounts SET balance = ? WHERE type = 'business' AND ownerId IN (%s)"):format(
                placeholders),
        },
        {
            resources = { 'vms_bossmenu' },
            table = 'bossmenu',
            query = ("UPDATE bossmenu SET balance = ? WHERE type IN ('job', 'gang') AND job IN (%s)"):format(
                placeholders),
        },
        {
            resources = { 'Renewed-Banking', 'renewed-banking', 'renewed_banking', 'qbx_management', 'qbx_core' },
            frameworks = { 'qb', 'qbx' },
            table = 'bank_accounts_new',
            query = ('UPDATE bank_accounts_new SET amount = ? WHERE id IN (%s)'):format(placeholders),
        },
        {
            resources = { 'wasabi_banking' },
            frameworks = { 'qbx' },
            table = 'bank_accounts_new',
            query = ('UPDATE bank_accounts_new SET amount = ? WHERE id IN (%s)'):format(placeholders),
        },
        {
            resources = { 'qb-banking', 'qb-management', 'wasabi_banking' },
            frameworks = { 'qb' },
            table = 'bank_accounts',
            query = ("UPDATE bank_accounts SET account_balance = ? WHERE account_type IN ('job', 'gang') AND account_name IN (%s)")
            :format(
                placeholders),
        },
        {
            resources = { 'qb-management', 'dw-bossmenu', 'dw_bossmenu', 'fd_banking', 'fd-banking', 'wasabi_banking' },
            table = 'management_funds',
            query = ("UPDATE management_funds SET amount = ? WHERE type IN ('boss', 'gang', 'job') AND job_name IN (%s)")
            :format(
                placeholders),
        },
        {
            resources = { 'esx_management', 'esx_society', 'm-Banking', 'm-banking', 'mBanking', 'm_banking' },
            table = 'addon_account_data',
            query = ([[UPDATE addon_account_data
                SET money = ?
                WHERE account_name IN (%s)
                  AND (owner IS NULL OR owner = '')]]):format(placeholders),
        },
        {
            resources = { 'wasabi_banking' },
            frameworks = { 'esx' },
            table = 'addon_account_data',
            query = ([[UPDATE addon_account_data
                SET money = ?
                WHERE account_name IN (%s)
                  AND (owner IS NULL OR owner = '')]]):format(placeholders),
        },
    }

    local params = { balance }
    for _, name in ipairs(names) do
        params[#params + 1] = name
    end

    for _, source in ipairs(sources) do
        if not matchesFramework(source.frameworks) then goto continue end
        if not hasStartedResource(source.resources) then goto continue end
        if not tableExists(source.table) then goto continue end

        local ok, affected = pcall(function()
            return MySQL.update.await(source.query, params)
        end)
        if ok and tonumber(affected) > 0 then return true end

        ::continue::
    end

    return false
end

--- Returns job/gang society balances from supported banking and boss menu resources.
---@return { name: string, label: string, balance: number }[]
function SocietyManager.getJobSocietyBalances()
    local societyLabels = {}
    local accounts = {}

    local function addAccount(account)
        if not account or not account.name or societyLabels[account.name] then return end
        societyLabels[account.name] = account.label or account.name
        accounts[#accounts + 1] = { name = account.name, label = societyLabels[account.name] }
    end

    local ok, jobs = pcall(JobManager.getJobs)
    if ok and jobs then
        for _, job in ipairs(jobs) do addAccount(job) end
    end

    ok, jobs = pcall(JobManager.getGangs)
    if ok and jobs then
        for _, gang in ipairs(jobs) do addAccount(gang) end
    end

    local result = getSocietyBalanceRowsFromTables()
    if not result then result = getSocietyBalanceRowsFromExports(accounts) end
    if not result then return {} end

    local balances = {}

    for _, row in ipairs(result) do
        local rawName = row.name or row.job or row.society or row.account_name or row.job_name
        if not rawName then goto continue end

        local name = tostring(rawName):gsub('^society_', ''):match('^%s*(.-)%s*$') or ''
        if name == '' then goto continue end

        local balance = tonumber(row.balance)
        local item = {
            name = name,
            label = row.label or societyLabels[name] or name,
            balance = balance or 0,
        }

        local existing = balances[name]
        if not existing or item.balance > existing.balance then
            balances[name] = item
        end

        ::continue::
    end

    local sorted = {}
    for _, item in pairs(balances) do
        sorted[#sorted + 1] = item
    end

    table.sort(sorted, function(a, b) return a.balance > b.balance end)
    return sorted
end

--- Sets a job/gang society balance in supported banking and boss menu tables.
---@param societyName string
---@param value number
---@return boolean
function SocietyManager.updateSocietyBalance(societyName, value)
    return updateSocietyBalanceInTables(societyName, value)
end

return SocietyManager
