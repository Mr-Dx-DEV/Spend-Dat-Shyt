local cachedAccounts = {}
local cachedPlayers = {}
local cachedCreditScores = {}
local cachedLoans = {}
local DAY_IN_SECONDS = 86400

local function decodeJson(value, fallback)
    if not value or value == '' then return fallback end
    local success, decoded = pcall(json.decode, value)
    if success and decoded then return decoded end
    return fallback
end

local function getCreditConfig()
    return Config.creditScore or {}
end

local function clampCreditScore(score)
    local config = getCreditConfig()
    local minScore = tonumber(config.minScore) or 300
    local maxScore = tonumber(config.maxScore) or 800
    score = math.floor(tonumber(score) or tonumber(config.startingScore) or 650)
    if score < minScore then return minScore end
    if score > maxScore then return maxScore end
    return score
end

local function getLoanTermSeconds()
    local config = getCreditConfig()
    return math.floor((tonumber(config.paymentTermDays) or 7) * DAY_IN_SECONDS)
end

local function getOverduePenaltyInterval()
    local config = getCreditConfig()
    return math.floor((tonumber(config.overduePenaltyIntervalHours) or 24) * 3600)
end

local function getLoanDueAt(createdAt)
    return (tonumber(createdAt) or os.time()) + getLoanTermSeconds()
end

local function getOverdueDays(dueAt, now)
    dueAt = tonumber(dueAt)
    now = tonumber(now) or os.time()
    if not dueAt or now <= dueAt then return 0 end
    return math.floor((now - dueAt) / DAY_IN_SECONDS)
end

local function setCreditScore(identifier, score)
    if not identifier then return false end
    score = clampCreditScore(score)
    cachedCreditScores[identifier] = score
    MySQL.query.await("INSERT INTO player_credit_scores (id, score, updated_at) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE score = VALUES(score), updated_at = VALUES(updated_at)", {
        identifier,
        score,
        os.time()
    })
    return score
end

local function getCreditScore(identifier)
    if not identifier then return false end
    if cachedCreditScores[identifier] then return cachedCreditScores[identifier] end

    local result = MySQL.query.await('SELECT score FROM player_credit_scores WHERE id = ?', { identifier })
    if result and result[1] then
        cachedCreditScores[identifier] = clampCreditScore(result[1].score)
        return cachedCreditScores[identifier]
    end

    local config = getCreditConfig()
    return setCreditScore(identifier, tonumber(config.startingScore) or 650)
end
exports('getCreditScore', getCreditScore)
exports('setCreditScore', setCreditScore)

local function adjustCreditScore(identifier, amount)
    local currentScore = getCreditScore(identifier)
    if not currentScore then return false end
    return setCreditScore(identifier, currentScore + (tonumber(amount) or 0))
end
exports('adjustCreditScore', adjustCreditScore)

local function getCreditTier(score)
    local config = getCreditConfig()
    local tiers = config.tiers or {}
    local selectedTier

    for i = 1, #tiers do
        local tier = tiers[i]
        local minimumScore = tonumber(tier.min) or 0
        if score >= minimumScore and (not selectedTier or minimumScore > (tonumber(selectedTier.min) or 0)) then
            selectedTier = tier
        end
    end

    return selectedTier
end

local function processLoanOverdue(identifier, row, now)
    local config = getCreditConfig()
    if config.enabled == false then return row end

    now = now or os.time()
    local remaining = tonumber(row.remaining) or 0
    if remaining <= 0 or row.status == 'paid' then return row end

    local dueAt = tonumber(row.due_at)
    local status = row.status or 'active'
    local overdueDays = tonumber(row.overdue_days) or 0
    local creditLost = tonumber(row.credit_lost) or 0
    local lastPenaltyAt = tonumber(row.last_penalty_at)
    local shouldUpdate = false

    if not dueAt or dueAt <= 0 then
        dueAt = getLoanDueAt(row.created_at)
        row.due_at = dueAt
        shouldUpdate = true
    end

    if not lastPenaltyAt or lastPenaltyAt <= 0 then
        lastPenaltyAt = dueAt
        row.last_penalty_at = lastPenaltyAt
        shouldUpdate = true
    end

    if now > dueAt then
        status = 'overdue'
        overdueDays = getOverdueDays(dueAt, now)

        local interval = getOverduePenaltyInterval()
        local penaltyPoints = tonumber(config.overduePenaltyPoints) or 10
        if interval > 0 and penaltyPoints > 0 then
            if lastPenaltyAt < dueAt then lastPenaltyAt = dueAt end
            local penaltiesDue = math.floor((now - lastPenaltyAt) / interval)

            if penaltiesDue > 0 then
                local lostNow = penaltiesDue * penaltyPoints
                adjustCreditScore(identifier, -lostNow)
                creditLost += lostNow
                lastPenaltyAt += penaltiesDue * interval
            end
        end

        shouldUpdate = true
    elseif status ~= 'active' or overdueDays ~= 0 then
        status = 'active'
        overdueDays = 0
        shouldUpdate = true
    end

    row.status = status
    row.due_at = dueAt
    row.overdue_days = overdueDays
    row.credit_lost = creditLost
    row.last_penalty_at = lastPenaltyAt

    if shouldUpdate then
        MySQL.query.await("UPDATE player_loans SET status = ?, due_at = ?, overdue_days = ?, credit_lost = ?, last_penalty_at = ? WHERE loan_id = ?", {
            status,
            dueAt,
            overdueDays,
            creditLost,
            lastPenaltyAt,
            row.loan_id
        })
    end

    return row
end

local function loadPlayerLoans(identifier, force)
    if not identifier then return {} end
    if cachedLoans[identifier] and not force then return cachedLoans[identifier] end

    local rows = MySQL.query.await("SELECT * FROM player_loans WHERE citizenid = ? AND status IN ('active', 'overdue') ORDER BY created_at ASC", { identifier }) or {}
    local loans = {}
    local now = os.time()

    for i = 1, #rows do
        local row = processLoanOverdue(identifier, rows[i], now)
        local remaining = tonumber(row.remaining) or 0
        if remaining > 0 then
            loans[#loans + 1] = {
                loan_id = row.loan_id,
                amount = tonumber(row.amount) or 0,
                total_owed = tonumber(row.total_owed) or 0,
                remaining = remaining,
                interest_rate = tonumber(row.interest_rate) or 0,
                status = row.status or 'active',
                created_at = tonumber(row.created_at) or os.time(),
                due_at = tonumber(row.due_at) or getLoanDueAt(row.created_at),
                max_eligibility_amount = tonumber(row.max_eligibility_amount) or 0,
                overdue_days = tonumber(row.overdue_days) or 0,
                credit_lost = tonumber(row.credit_lost) or 0,
                last_penalty_at = tonumber(row.last_penalty_at) or tonumber(row.due_at) or getLoanDueAt(row.created_at),
                is_overdue = row.status == 'overdue',
                payments = decodeJson(row.payments, {})
            }
        end
    end

    cachedLoans[identifier] = loans
    return loans
end
exports('getActiveLoans', loadPlayerLoans)

local function getLoanOverview(identifier)
    local config = getCreditConfig()
    if config.enabled == false then
        return { enabled = false, loans = {} }
    end

    local score = getCreditScore(identifier)
    local tier = getCreditTier(score)
    local loans = loadPlayerLoans(identifier, true)
    local totalRemaining = 0
    local hasOverdue = false
    local overdueCreditLoss = 0
    local nextDueAt
    local minimumLoan = tonumber(config.minimumLoan) or 10000

    for i = 1, #loans do
        totalRemaining += loans[i].remaining
        if loans[i].is_overdue then
            hasOverdue = true
            overdueCreditLoss += loans[i].credit_lost
        end
        if loans[i].status ~= 'paid' and (not nextDueAt or loans[i].due_at < nextDueAt) then
            nextDueAt = loans[i].due_at
        end
    end

    local maxLoan = tier and tonumber(tier.maxLoan) or 0
    local availableLoan = maxLoan - totalRemaining
    if availableLoan < 0 then availableLoan = 0 end
    local canBorrow = tier ~= nil and availableLoan >= minimumLoan and #loans < (tonumber(config.maxActiveLoans) or 3)
    local denialReason
    if not tier then
        denialReason = 'Credit score too low'
    elseif #loans >= (tonumber(config.maxActiveLoans) or 3) then
        denialReason = 'Too many active loans'
    elseif availableLoan < minimumLoan then
        denialReason = 'No loan limit available'
    end

    return {
        enabled = true,
        score = score,
        minScore = tonumber(config.minScore) or 300,
        maxScore = tonumber(config.maxScore) or 800,
        minimumLoan = minimumLoan,
        maxLoan = maxLoan,
        availableLoan = availableLoan,
        interestRate = tier and tonumber(tier.interest) or 0,
        activeLoans = #loans,
        maxActiveLoans = tonumber(config.maxActiveLoans) or 3,
        totalRemaining = totalRemaining,
        tier = tier and tonumber(tier.min) or nil,
        canBorrow = canBorrow,
        denialReason = denialReason,
        nextDueAt = nextDueAt,
        hasOverdue = hasOverdue,
        overdueCreditLoss = overdueCreditLoss,
        overduePenaltyPoints = tonumber(config.overduePenaltyPoints) or 10,
        overduePenaltyIntervalHours = tonumber(config.overduePenaltyIntervalHours) or 24,
        loans = loans
    }
end
exports('getLoanOverview', getLoanOverview)

CreateThread(function()
    Wait(500)
    if not LoadResourceFile("Renewed-Banking", 'web/public/build/bundle.js') or GetCurrentResourceName() ~= "Renewed-Banking" then
        error(locale("ui_not_built"))
        return StopResource("Renewed-Banking")
    end
    local accounts = MySQL.query.await('SELECT * FROM bank_accounts_new', {})
    if accounts then
        for _,v in pairs (accounts) do
            local job = v.id
            v.auth = json.decode(v.auth)
            cachedAccounts[job] = { --  cachedAccounts[#cachedAccounts+1]
                id = job,
                type = locale("org"),
                name = GetSocietyLabel(job),
                frozen = v.isFrozen == 1,
                amount = v.amount,
                transactions = json.decode(v.transactions),
                auth = {},
                creator = v.creator
            }
            if #v.auth >= 1 then
                for k=1, #v.auth do
                    cachedAccounts[job].auth[v.auth[k]] = true
                end
            end
        end
    end
    local jobs, gangs = GetFrameworkGroups()
    local query = {}
    local function addCachedAccount(group)
        cachedAccounts[group] = {
            id = group,
            type = locale('org'),
            name = GetSocietyLabel(group),
            frozen = 0,
            amount = 0,
            transactions = {},
            auth = {},
            creator = nil
        }
        query[#query + 1] = {"INSERT INTO bank_accounts_new (id, amount, transactions, auth, isFrozen, creator) VALUES (?, ?, ?, ?, ?, NULL) ",
        { group, cachedAccounts[group].amount, json.encode(cachedAccounts[group].transactions), json.encode({}), cachedAccounts[group].frozen }}
    end
    for job in pairs(jobs) do
        if not cachedAccounts[job] then
            addCachedAccount(job)
        end
    end
    for gang in pairs(gangs) do
        if not cachedAccounts[gang] then
            addCachedAccount(gang)
        end
    end
    if #query >= 1 then
        MySQL.transaction.await(query)
    end
end)

function UpdatePlayerAccount(cid)
    local p = promise.new()
    MySQL.query('SELECT * FROM player_transactions WHERE id = ?', {cid}, function(account)
        local query = '%' .. cid .. '%'
        MySQL.query("SELECT * FROM bank_accounts_new WHERE auth LIKE ? ", {query}, function(shared)
            cachedPlayers[cid] = {
                isFrozen = 0,
                transactions = #account > 0 and json.decode(account[1].transactions) or {},
                accounts = {}
            }

            if #shared >= 1 then
                for k=1, #shared do
                    cachedPlayers[cid].accounts[#cachedPlayers[cid].accounts+1] = shared[k].id
                end
            end
            p:resolve(true)
        end)
    end)
	return Citizen.Await(p)
end

local function getBankData(source)
    local Player = GetPlayerObject(source)
    local bankData = {}
    local cid = GetIdentifier(Player)
    if not cachedPlayers[cid] then UpdatePlayerAccount(cid) end
    local funds = GetFunds(Player)
    local loanOverview = getLoanOverview(cid)
    bankData[#bankData+1] = {
        id = cid,
        type = locale("personal"),
        name = GetCharacterName(Player),
        frozen = cachedPlayers[cid].isFrozen,
        amount = funds.bank,
        cash = funds.cash,
        transactions = cachedPlayers[cid].transactions,
        credit = loanOverview,
        loans = loanOverview.loans,
    }

    local jobs = GetJobs(Player)
    if #jobs > 0 then
        for k=1, #jobs do
            if cachedAccounts[jobs[k].name] and IsJobAuth(jobs[k].name, jobs[k].grade) then
                bankData[#bankData+1] = cachedAccounts[jobs[k].name]
            end
        end
    else
        local job = cachedAccounts[jobs.name]
        if job and IsJobAuth(jobs.name, jobs.grade) then
            bankData[#bankData+1] = job
        end
    end

    local gang = GetGang(Player)
    if gang and gang ~= 'none' then
        local gangData = cachedAccounts[gang]
        if gangData and IsGangAuth(Player, gang) then
            bankData[#bankData+1] = gangData
        end
    end

    local sharedAccounts = cachedPlayers[cid].accounts
    for k=1, #sharedAccounts do
        local sAccount = cachedAccounts[sharedAccounts[k]]
        bankData[#bankData+1] = sAccount
    end

    return bankData
end

lib.callback.register('renewed-banking:server:initalizeBanking', function(source)
    local bankData = getBankData(source)
    return bankData
end)

-- Events
local function genTransactionID()
    local template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return string.gsub(template, '[xy]', function (c)
        local v = (c == 'x') and math.random(0, 0xf) or math.random(8, 0xb)
        return string.format('%x', v)
    end)
end

local function sanitizeMessage(message)
    if type(message) ~= "string" then
        message = tostring(message)
    end
    message = message:gsub("'", "''"):gsub("\\", "\\\\")
    return message
end

local Type = type
local function handleTransaction(account, title, amount, message, issuer, receiver, transType, transID)
    if not account or Type(account) ~= 'string' then return print(locale("err_trans_account", account)) end
    if not title or Type(title) ~= 'string' then return print(locale("err_trans_title", title)) end
    if not amount or Type(amount) ~= 'number' then return print(locale("err_trans_amount", amount)) end
    if not message or Type(message) ~= 'string' then return print(locale("err_trans_message", message)) end
    if not issuer or Type(issuer) ~= 'string' then return print(locale("err_trans_issuer", issuer)) end
    if not receiver or Type(receiver) ~= 'string' then return print(locale("err_trans_receiver", receiver)) end
    if not transType or Type(transType) ~= 'string' then return print(locale("err_trans_type", transType)) end
    if transID and Type(transID) ~= 'string' then return print(locale("err_trans_transID", transID)) end

    local transaction = {
        trans_id = transID or genTransactionID(),
        title = title,
        amount = amount,
        trans_type = transType,
        receiver = receiver,
        message = sanitizeMessage(message),
        issuer = issuer,
        time = os.time()
    }
    if cachedAccounts[account] then
        table.insert(cachedAccounts[account].transactions, 1, transaction)
        local transactions = json.encode(cachedAccounts[account].transactions)
        MySQL.prepare("INSERT INTO bank_accounts_new (id, transactions) VALUES (?, ?) ON DUPLICATE KEY UPDATE transactions = ?",{
            account, transactions, transactions
        })
    elseif cachedPlayers[account] then
        table.insert(cachedPlayers[account].transactions, 1, transaction)
        local transactions = json.encode(cachedPlayers[account].transactions)
        MySQL.prepare("INSERT INTO player_transactions (id, transactions) VALUES (?, ?) ON DUPLICATE KEY UPDATE transactions = ?", {
            account, transactions, transactions
        })
    else
        print(locale("invalid_account", account))
    end
    return transaction
end exports("handleTransaction", handleTransaction)

function GetAccountMoney(account)
    if not cachedAccounts[account] then
        locale("invalid_account", account)
        return false
    end
    return cachedAccounts[account].amount
end
exports('getAccountMoney', GetAccountMoney)

local function updateBalance(account)
    MySQL.prepare("UPDATE bank_accounts_new SET amount = ? WHERE id = ?",{ cachedAccounts[account].amount, account })
end

function AddAccountMoney(account, amount)
    if not cachedAccounts[account] then
        locale("invalid_account", account)
        return false
    end
    cachedAccounts[account].amount += amount
    updateBalance(account)
    return true
end
exports('addAccountMoney', AddAccountMoney)

local function getPlayerData(source, id)
    local Player = source and GetPlayerObject(source)
    if not Player then Player = GetPlayerObjectFromID(id) end
    if not Player then
        local msg = ("Cannot Find Account(%s)"):format(id)
        print(locale("invalid_account", id))
        if source then
            Notify(source, {title = locale("bank_name"), description = msg, type = "error"})
        end
    end
    return Player
end

lib.callback.register('Renewed-Banking:server:deposit', function(source, data)
    local Player = GetPlayerObject(source)
    local amount = tonumber(data.amount)
    if not amount or amount < 1 then
        Notify(source, {title = locale("bank_name"), description = locale("invalid_amount", "deposit"), type = "error"})
        return false
    end
    local name = GetCharacterName(Player)
    if not data.comment or data.comment == "" then data.comment = locale("comp_transaction", name, "deposited", amount) else sanitizeMessage(data.comment) end
    if RemoveMoney(Player, amount, 'cash', data.comment) then
        if cachedAccounts[data.fromAccount] then
            AddAccountMoney(data.fromAccount, amount)
        else
            AddMoney(Player, amount, 'bank', data.comment)
        end
        local Player2 = getPlayerData(source, data.fromAccount)
        Player2 = Player2 and GetCharacterName(Player2) or data.fromAccount
        handleTransaction(data.fromAccount, locale("personal_acc") .. data.fromAccount, amount, data.comment, name, Player2, "deposit")
        local bankData = getBankData(source)
        return bankData
    else
        TriggerClientEvent('Renewed-Banking:client:sendNotification', source, locale("not_enough_money"))
        return false
    end
end)

function RemoveAccountMoney(account, amount)
    if not cachedAccounts[account] then
        print(locale("invalid_account", account))
        return false
    end
    if cachedAccounts[account].amount < amount then
        print(locale("broke_account", account, amount))
        return false
    end

    cachedAccounts[account].amount -= amount
    updateBalance(account)
    return true
end
exports('removeAccountMoney', RemoveAccountMoney)

lib.callback.register('Renewed-Banking:server:withdraw', function(source, data)
    local Player = GetPlayerObject(source)
    local amount = tonumber(data.amount)
    if not amount or amount < 1 then
        Notify(source, {title = locale("bank_name"), description = locale("invalid_amount", "withdraw"), type = "error"})
        return false
    end
    local name = GetCharacterName(Player)
    local funds = GetFunds(Player)
    if not data.comment or data.comment == "" then data.comment = locale("comp_transaction", name, "withdrawed", amount) else sanitizeMessage(data.comment) end

    local canWithdraw
    if cachedAccounts[data.fromAccount] then
        canWithdraw = RemoveAccountMoney(data.fromAccount, amount)
    else
        canWithdraw = funds.bank >= amount and RemoveMoney(Player, amount, 'bank', data.comment) or false
    end
    if canWithdraw then
        local Player2 = getPlayerData(source, data.fromAccount)
        Player2 = Player2 and GetCharacterName(Player2) or data.fromAccount
        AddMoney(Player, amount, 'cash', data.comment)
        handleTransaction(data.fromAccount,locale("personal_acc") .. data.fromAccount, amount, data.comment, Player2, name, "withdraw")
        local bankData = getBankData(source)
        return bankData
    else
        TriggerClientEvent('Renewed-Banking:client:sendNotification', source, locale("not_enough_money"))
        return false
    end
end)

lib.callback.register('Renewed-Banking:server:transfer', function(source, data)
    local Player = GetPlayerObject(source)
    local amount = tonumber(data.amount)
    if not amount or amount < 1 then
        Notify(source, {title = locale("bank_name"), description = locale("invalid_amount", "transfer"), type = "error"})
        return false
    end
    local name = GetCharacterName(Player)
    if not data.comment or data.comment == "" then data.comment = locale("comp_transaction", name, "transfered", amount) else sanitizeMessage(data.comment) end
    if cachedAccounts[data.fromAccount] then
        if cachedAccounts[data.stateid] then
            local canTransfer = RemoveAccountMoney(data.fromAccount, amount)
            if canTransfer then
                AddAccountMoney(data.stateid, amount)
                local title = ("%s / %s"):format(cachedAccounts[data.fromAccount].name, data.fromAccount)
                local transaction = handleTransaction(data.fromAccount, title, amount, data.comment, cachedAccounts[data.fromAccount].name, cachedAccounts[data.stateid].name, "withdraw")
                handleTransaction(data.stateid, title, amount, data.comment, cachedAccounts[data.fromAccount].name, cachedAccounts[data.stateid].name, "deposit", transaction.trans_id)
            else
                TriggerClientEvent('Renewed-Banking:client:sendNotification', source, locale("not_enough_money"))
                return false
            end
        else
            local Player2 = getPlayerData(source, data.stateid)
            if not Player2 then
                TriggerClientEvent('Renewed-Banking:client:sendNotification', source, locale("fail_transfer"))
                return false
            end
            local canTransfer = RemoveAccountMoney(data.fromAccount, amount)
            if canTransfer then
                AddMoney(Player2, amount, 'bank', data.comment)
                local plyName = GetCharacterName(Player2)
                local transaction = handleTransaction(data.fromAccount, ("%s / %s"):format(cachedAccounts[data.fromAccount].name, data.fromAccount), amount, data.comment, cachedAccounts[data.fromAccount].name, plyName, "withdraw")
                handleTransaction(data.stateid, ("%s / %s"):format(cachedAccounts[data.fromAccount].name, data.fromAccount), amount, data.comment, cachedAccounts[data.fromAccount].name, plyName, "deposit", transaction.trans_id)
            else
                TriggerClientEvent('Renewed-Banking:client:sendNotification', source, locale("not_enough_money"))
                return false
            end
        end
    else
        local funds = GetFunds(Player)
        if cachedAccounts[data.stateid] then
            if funds.bank >= amount and RemoveMoney(Player, amount, 'bank', data.comment) then
                AddAccountMoney(data.stateid, amount)
                local transaction = handleTransaction(data.fromAccount, locale("personal_acc") .. data.fromAccount, amount, data.comment, name, cachedAccounts[data.stateid].name, "withdraw")
                handleTransaction(data.stateid, locale("personal_acc") .. data.fromAccount, amount, data.comment, name, cachedAccounts[data.stateid].name, "deposit", transaction.trans_id)
            else
                TriggerClientEvent('Renewed-Banking:client:sendNotification', source, locale("not_enough_money"))
                return false
            end
        else
            local Player2 = getPlayerData(source, data.stateid)
            if not Player2 then
                TriggerClientEvent('Renewed-Banking:client:sendNotification', source, locale("fail_transfer"))
                return false
            end

            if funds.bank >= amount and RemoveMoney(Player, amount, 'bank', data.comment) then
                AddMoney(Player2, amount, 'bank', data.comment)
                local name2 = GetCharacterName(Player2)
                local transaction = handleTransaction(data.fromAccount, locale("personal_acc") .. data.fromAccount, amount, data.comment, name, name2, "withdraw")
                handleTransaction(data.stateid, locale("personal_acc") .. data.fromAccount, amount, data.comment, name, name2, "deposit", transaction.trans_id)
            else
                TriggerClientEvent('Renewed-Banking:client:sendNotification', source, locale("not_enough_money"))
                return false
            end
        end
    end
    local bankData = getBankData(source)
    return bankData
end)

lib.callback.register('Renewed-Banking:server:applyLoan', function(source, data)
    local config = getCreditConfig()
    if config.enabled == false then
        Notify(source, {title = locale("bank_name"), description = "Loans are disabled.", type = "error"})
        return false
    end

    local Player = GetPlayerObject(source)
    if not Player then return false end

    local amount = math.floor(tonumber(data.amount) or 0)
    local minimumLoan = tonumber(config.minimumLoan) or 10000
    if amount < minimumLoan then
        Notify(source, {title = locale("bank_name"), description = ("Minimum loan amount is $%s."):format(minimumLoan), type = "error"})
        return false
    end

    local cid = GetIdentifier(Player)
    local name = GetCharacterName(Player)
    local overview = getLoanOverview(cid)

    if not overview.canBorrow then
        Notify(source, {title = locale("bank_name"), description = overview.denialReason or "You do not qualify for a loan.", type = "error"})
        return false
    end

    if overview.activeLoans >= overview.maxActiveLoans then
        Notify(source, {title = locale("bank_name"), description = "You already have too many active loans.", type = "error"})
        return false
    end

    if amount > overview.availableLoan then
        Notify(source, {title = locale("bank_name"), description = ("Your current credit line allows up to $%s."):format(overview.availableLoan), type = "error"})
        return false
    end

    local interest = tonumber(overview.interestRate) or 0
    local totalOwed = math.ceil(amount * (1 + (interest / 100)))
    local loanId = genTransactionID()
    local now = os.time()
    local dueAt = now + getLoanTermSeconds()
    local comment = data.comment
    if not comment or comment == "" then
        comment = ("Bank loan approved for $%s at %s%% interest."):format(amount, interest)
    else
        comment = sanitizeMessage(comment)
    end

    MySQL.insert.await("INSERT INTO player_loans (loan_id, citizenid, amount, total_owed, remaining, interest_rate, status, created_at, due_at, last_penalty_at, max_eligibility_amount, overdue_days, credit_lost, payments) VALUES (?, ?, ?, ?, ?, ?, 'active', ?, ?, ?, ?, 0, 0, ?)", {
        loanId,
        cid,
        amount,
        totalOwed,
        totalOwed,
        interest,
        now,
        dueAt,
        dueAt,
        overview.maxLoan,
        json.encode({})
    })

    AddMoney(Player, amount, 'bank', comment)
    handleTransaction(cid, "Bank Loan", amount, comment, locale("bank_name"), name, "deposit", loanId)
    adjustCreditScore(cid, -(tonumber(config.loanTakenScoreCost) or 0))
    loadPlayerLoans(cid, true)

    Notify(source, {title = locale("bank_name"), description = ("Loan approved. $%s was deposited into your bank account."):format(amount), type = "success"})
    return getBankData(source)
end)

lib.callback.register('Renewed-Banking:server:repayLoan', function(source, data)
    local config = getCreditConfig()
    if config.enabled == false then
        Notify(source, {title = locale("bank_name"), description = "Loans are disabled.", type = "error"})
        return false
    end

    local Player = GetPlayerObject(source)
    if not Player then return false end

    local amount = math.floor(tonumber(data.amount) or 0)
    if amount < 1 then
        Notify(source, {title = locale("bank_name"), description = locale("invalid_amount", "repay"), type = "error"})
        return false
    end

    local cid = GetIdentifier(Player)
    local loans = loadPlayerLoans(cid, true)
    if #loans < 1 then
        Notify(source, {title = locale("bank_name"), description = "You do not have any active loans.", type = "error"})
        return false
    end

    local totalRemaining = 0
    for i = 1, #loans do
        totalRemaining += loans[i].remaining
    end

    local repayAmount = amount
    if repayAmount > totalRemaining then repayAmount = totalRemaining end

    local funds = GetFunds(Player)
    if funds.bank < repayAmount or not RemoveMoney(Player, repayAmount, 'bank', 'Loan repayment') then
        Notify(source, {title = locale("bank_name"), description = locale("not_enough_money"), type = "error"})
        return false
    end

    local remainingPayment = repayAmount
    local paidOffLoans = 0
    local now = os.time()

    for i = 1, #loans do
        if remainingPayment <= 0 then break end
        local loan = loans[i]
        local applied = math.min(remainingPayment, loan.remaining)
        loan.remaining -= applied
        remainingPayment -= applied
        loan.payments[#loan.payments + 1] = {
            amount = applied,
            time = now
        }

        if loan.remaining <= 0 then
            paidOffLoans += 1
            local restoreLostScore = config.restoreLostScoreOnPayoff == true and (tonumber(loan.credit_lost) or 0) or 0
            MySQL.query.await("UPDATE player_loans SET remaining = 0, status = 'paid', paid_at = ?, payments = ? WHERE loan_id = ?", {
                now,
                json.encode(loan.payments),
                loan.loan_id
            })
            if restoreLostScore > 0 then
                adjustCreditScore(cid, restoreLostScore)
            end
        else
            MySQL.query.await("UPDATE player_loans SET remaining = ?, payments = ?, status = ?, overdue_days = ?, credit_lost = ?, last_penalty_at = ? WHERE loan_id = ?", {
                loan.remaining,
                json.encode(loan.payments),
                loan.status,
                loan.overdue_days,
                loan.credit_lost,
                loan.last_penalty_at,
                loan.loan_id
            })
        end
    end

    local scoreGain = (tonumber(config.paymentScoreGain) or 0) + (paidOffLoans * (tonumber(config.payoffScoreGain) or 0))
    if scoreGain > 0 then adjustCreditScore(cid, scoreGain) end
    cachedLoans[cid] = nil
    loadPlayerLoans(cid, true)

    local name = GetCharacterName(Player)
    local comment = data.comment
    if not comment or comment == "" then
        comment = ("Loan payment of $%s."):format(repayAmount)
    else
        comment = sanitizeMessage(comment)
    end
    handleTransaction(cid, "Loan Payment", repayAmount, comment, name, locale("bank_name"), "withdraw")

    Notify(source, {title = locale("bank_name"), description = ("Paid $%s toward your loans."):format(repayAmount), type = "success"})
    return getBankData(source)
end)

RegisterNetEvent('Renewed-Banking:server:createNewAccount', function(accountid)
    local Player = GetPlayerObject(source)
    if cachedAccounts[accountid] then return Notify(source, {title = locale("bank_name"), description = locale("account_taken"), type = "error"}) end
    local cid = GetIdentifier(Player)
    cachedAccounts[accountid] = {
        id = accountid,
        type = locale("org"),
        name = accountid,
        frozen = 0,
        amount = 0,
        transactions = {},
        auth = { [cid] = true },
        creator = cid

    }
    cachedPlayers[cid].accounts[#cachedPlayers[cid].accounts+1] = accountid
    MySQL.insert("INSERT INTO bank_accounts_new (id, amount, transactions, auth, isFrozen, creator) VALUES (?, ?, ?, ?, ?, ?) ",{
        accountid, cachedAccounts[accountid].amount, json.encode(cachedAccounts[accountid].transactions), json.encode({cid}), cachedAccounts[accountid].frozen, cid
    })
end)

RegisterNetEvent("Renewed-Banking:server:getPlayerAccounts", function()
    local Player = GetPlayerObject(source)
    local cid = GetIdentifier(Player)
    local accounts = cachedPlayers[cid].accounts
    local data = {}
    if #accounts >= 1 then
        for k=1, #accounts do
            if cachedAccounts[accounts[k]].creator == cid then
                data[#data+1] = accounts[k]
            end
        end
    end
    TriggerClientEvent("Renewed-Banking:client:accountsMenu", source, data)
end)

RegisterNetEvent("Renewed-Banking:server:viewMemberManagement", function(data)
    local Player = GetPlayerObject(source)

    local account = data.account
    local retData = {
        account = account,
        members = {}
    }
    local cid = GetIdentifier(Player)

    for k,_ in pairs(cachedAccounts[account].auth) do
        local Player2 = getPlayerData(source, k)
        if cid ~= GetIdentifier(Player2) then
            retData.members[k] = GetCharacterName(Player2)
        end
    end

    TriggerClientEvent("Renewed-Banking:client:viewMemberManagement", source, retData)
end)

RegisterNetEvent('Renewed-Banking:server:addAccountMember', function(account, member)
    local Player = GetPlayerObject(source)

    if GetIdentifier(Player) ~= cachedAccounts[account].creator then print(locale("illegal_action", GetPlayerName(source))) return end
    local Player2 = getPlayerData(source, member)
    if not Player2 then return end

    local targetCID = GetIdentifier(Player2)
    if cachedPlayers[targetCID] then
        cachedPlayers[targetCID].accounts[#cachedPlayers[targetCID].accounts+1] = account
    end

    local auth = {}
    for k in pairs(cachedAccounts[account].auth) do auth[#auth+1] = k end
    auth[#auth+1] = targetCID
    cachedAccounts[account].auth[targetCID] = true
    MySQL.update('UPDATE bank_accounts_new SET auth = ? WHERE id = ?',{json.encode(auth), account})
end)

RegisterNetEvent('Renewed-Banking:server:removeAccountMember', function(data)
    local Player = GetPlayerObject(source)
    if GetIdentifier(Player) ~= cachedAccounts[data.account].creator then print(locale("illegal_action", GetPlayerName(source))) return end
    local Player2 = getPlayerData(source, data.cid)
    if not Player2 then return end

    local targetCID = GetIdentifier(Player2)
    local tmp = {}
    for k in pairs(cachedAccounts[data.account].auth) do
        if targetCID ~= k then
            tmp[#tmp+1] = k
        end
    end

    if cachedPlayers[targetCID] then
        local newAccount = {}
        if #cachedPlayers[targetCID].accounts >= 1 then
            for k=1, #cachedPlayers[targetCID].accounts do
                if cachedPlayers[targetCID].accounts[k] ~= data.account then
                    newAccount[#newAccount+1] = cachedPlayers[targetCID].accounts[k]
                end
            end
        end
        cachedPlayers[targetCID].accounts = newAccount
    end
    cachedAccounts[data.account].auth[targetCID] = nil
    MySQL.update('UPDATE bank_accounts_new SET auth = ? WHERE id = ?',{json.encode(tmp), data.account})
end)

RegisterNetEvent('Renewed-Banking:server:deleteAccount', function(data)
    local account = data.account
    local Player = GetPlayerObject(source)
    local cid = GetIdentifier(Player)

    cachedAccounts[account] = nil

    for k=1, #cachedPlayers[cid].accounts do
        if cachedPlayers[cid].accounts[k] == account then
            cachedPlayers[cid].accounts[k] = nil
        end
    end

    MySQL.update("DELETE FROM `bank_accounts_new` WHERE id=:id", { id = account })
end)

local find = string.find
local sub = string.sub
local function split(str, delimiter)
    local result = {}
    local from = 1
    local delim_from, delim_to = find(str, delimiter, from)
    while delim_from do
        result[#result + 1] = sub(str, from, delim_from - 1)
        from = delim_to + 1
        delim_from, delim_to = find(str, delimiter, from)
    end
    result[#result + 1] = sub(str, from)
    return result
end


local function updateAccountName(account, newName, src)
    if not account or not newName then return false end
    if not cachedAccounts[account] then
        local getTranslation = locale("invalid_account", account)
        print(getTranslation)
        if src then Notify(src, {title = locale("bank_name"), description = split(getTranslation, '0')[2], type = "error"}) end
        return false
    end
    if cachedAccounts[newName] then
        local getTranslation = locale("existing_account", account)
        print(getTranslation)
        if src then Notify(src, {title = locale("bank_name"), description = split(getTranslation, '0')[2], type = "error"}) end
        return false
    end
    if src then
        local Player = GetPlayerObject(src)
        if GetIdentifier(Player) ~= cachedAccounts[account].creator then
            local getTranslation = locale("illegal_action", GetPlayerName(src))
            print(getTranslation)
            Notify(src, {title = locale("bank_name"), description = split(getTranslation, '0')[2], type = "error"})
            return false
        end
    end

    cachedAccounts[newName] = json.decode(json.encode(cachedAccounts[account]))
    cachedAccounts[newName].id = newName
    cachedAccounts[newName].name = newName
    cachedAccounts[account] = nil
    for _, id in ipairs(GetPlayers()) do
        local Player2 = GetPlayerObject(id)
        if not Player2 then goto Skip end
        local cid = GetIdentifier(Player2)
        if #cachedPlayers[cid].accounts >= 1 then
            for k=1, #cachedPlayers[cid].accounts do
                if cachedPlayers[cid].accounts[k] == account then
                    table.remove(cachedPlayers[cid].accounts, k)
                    cachedPlayers[cid].accounts[#cachedPlayers[cid].accounts+1] = newName
                end
            end
        end
        ::Skip::
    end
    MySQL.update('UPDATE bank_accounts_new SET id = ? WHERE id = ?',{newName, account})
    return true
end

RegisterNetEvent('Renewed-Banking:server:changeAccountName', function(account, newName)
    updateAccountName(account, newName, source)
end) exports("changeAccountName", updateAccountName)-- Should only use this on very secure backends to avoid anyone using this as this is a server side ONLY export --

--- Retrieves a cached job account if it exists.
---@param jobName string The name of the job whose account is being retrieved.
---@return table|nil account Returns the job account if it exists, otherwise `nil`.
function GetJobAccount(jobName)
    if type(jobName) ~= "string" or jobName == "" then
        error(("^5[%s]^7-^1[ERROR]^7 %s"):format(GetInvokingResource(), "Invalid job name: expected a non-empty string"))
    end
    return cachedAccounts[jobName] or nil -- Returns account if found, otherwise nil
end
exports('GetJobAccount', GetJobAccount)

--- Creates a shared job account for an organization/society.
--- @param job table A table containing job account details:
---        job.name string - The unique identifier for the job (e.g., "mechanic", "police").
---        job.label string - The display name/label for the job (e.g., "Mechanic", "Police Department").
--- @param initialBalance number? The starting balance of the account. Default is 0.
--- @return table Returns the account table if found or successfully created. This function may raise an error if validation or database insertion fails.
local function CreateJobAccount(job, initialBalance)
    local currentResourceName = GetInvokingResource()

    -- Validate input parameters
    if type(job) ~= "table" then
        error(("^5[%s]^7-^1[ERROR]^7 %s"):format(currentResourceName, "Invalid parameter: expected a table (job)"))
    end


    if type(job.name) ~= "string" or job.name == "" then
        error(("^5[%s]^7-^1[ERROR]^7 %s"):format(currentResourceName, "Invalid job name: expected a non-empty string"))
    end

    if type(job.label) ~= "string" or job.label == "" then
        error(("^5[%s]^7-^1[ERROR]^7 %s"):format(currentResourceName, "Invalid job label: expected a non-empty string"))
    end
    
    -- Check if account already exists
    if cachedAccounts[job.name] then
        return cachedAccounts[job.name]
    end

    -- Create the job account in cache
    cachedAccounts[job.name] = {
        id = job.name,
        type = locale("org"),
        name = job.label,
        frozen = 0,
        amount = tonumber(initialBalance) or 0,
        transactions = {},
        auth = {},
        creator = nil
    }

    local insertId = MySQL.insert.await("INSERT INTO bank_accounts_new (id, amount, transactions, auth, isFrozen, creator) VALUES (?, ?, ?, ?, ?, NULL)", {
        job.name,
        cachedAccounts[job.name].amount,
        json.encode(cachedAccounts[job.name].transactions), -- Convert transactions to JSON
        json.encode(cachedAccounts[job.name].auth), -- Convert auth list to JSON
        cachedAccounts[job.name].frozen
    })

    -- Handle potential database errors
    if not insertId then
	cachedAccounts[job.name] = nil
        error(("^5[%s]^7-^1[ERROR]^7 %s"):format(currentResourceName, "Database error"))
    end

    return cachedAccounts[job.name]
end
exports("CreateJobAccount", CreateJobAccount)

local function addAccountMember(account, member)
    if not account or not member then return end

    if not cachedAccounts[account] then print(locale("invalid_account", account)) return end

    local Player2 = getPlayerData(false, member)
    if not Player2 then return end

    local targetCID = GetIdentifier(Player2)
    if cachedPlayers[targetCID] then
        cachedPlayers[targetCID].accounts[#cachedPlayers[targetCID].accounts+1] = account
    end

    local auth = {}
    for k, _ in pairs(cachedAccounts[account].auth) do auth[#auth+1] = k end
    auth[#auth+1] = targetCID
    cachedAccounts[account].auth[targetCID] = true
    MySQL.update('UPDATE bank_accounts_new SET auth = ? WHERE id = ?',{json.encode(auth), account})

end
exports("addAccountMember", addAccountMember)

local function removeAccountMember(account, member)
    local Player2 = getPlayerData(false, member)

    if not Player2 then return end
    if not cachedAccounts[account] then print(locale("invalid_account", account)) return end

    local targetCID = GetIdentifier(Player2)

    local tmp = {}
    for k in pairs(cachedAccounts[account].auth) do
        if targetCID ~= k then
            tmp[#tmp+1] = k
        end
    end

    if cachedPlayers[targetCID] then
        local newAccount = {}
        if #cachedPlayers[targetCID].accounts >= 1 then
            for k=1, #cachedPlayers[targetCID].accounts do
                if cachedPlayers[targetCID].accounts[k] ~= account then
                    newAccount[#newAccount+1] = cachedPlayers[targetCID].accounts[k]
                end
            end
        end
        cachedPlayers[targetCID].accounts = newAccount
    end

    cachedAccounts[account].auth[targetCID] = nil

    MySQL.update('UPDATE bank_accounts_new SET auth = ? WHERE id = ?',{json.encode(tmp), account})
end
exports("removeAccountMember", removeAccountMember)

local function getAccountTransactions(account)
    if cachedAccounts[account] then
        return cachedAccounts[account].transactions
    elseif cachedPlayers[account] then
        return cachedPlayers[account].transactions
    end
    print(locale("invalid_account", account))
    return false
end
exports("getAccountTransactions", getAccountTransactions)

lib.addCommand('givecash', {
    help = 'Gives an item to a player',
    params = {
        {
            name = 'target',
            type = 'playerId',
            help = locale("cmd_plyr_id"),
        },
        {
            name = 'amount',
            type = 'number',
            help = locale("cmd_amount"),
        }
    }
}, function(source, args)
    local Player = GetPlayerObject(source)
    if not Player then return end

    local iPlayer = GetPlayerObject(args.target)
    if not iPlayer then return Notify(source, {title = locale("bank_name"), description = locale('unknown_player', args.target), type = "error"}) end

    if IsDead(Player) then return Notify(source, {title = locale("bank_name"), description = locale('dead'), type = "error"}) end
    if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(args.target))) > 10.0 then return Notify(source, {title = locale("bank_name"), description = locale('too_far_away'), type = "error"}) end
    if args.amount < 0 then return Notify(source, {title = locale("bank_name"), description = locale('invalid_amount', "give"), type = "error"}) end

    if RemoveMoney(Player, args.amount, 'cash') then
        AddMoney(iPlayer, args.amount, 'cash')
        local nameA = GetCharacterName(Player)
        local nameB = GetCharacterName(iPlayer)
        Notify(source, {title = locale("bank_name"), description = locale('give_cash', nameB, tostring(args.amount)), type = "error"})
        Notify(args.target, {title = locale("bank_name"), description = locale('received_cash', nameA, tostring(args.amount)), type = "success"})
    else
        Notify(args.target, {title = locale("bank_name"), description = locale('not_enough_money'), type = "error"})
    end
end)

function ExportHandler(resource, name, cb)
    AddEventHandler(('__cfx_export_%s_%s'):format(resource, name), function(setCB)
        setCB(cb)
    end)
end

local createTables = {
    { query = "CREATE TABLE IF NOT EXISTS `bank_accounts_new` (`id` varchar(50) NOT NULL, `amount` int(11) DEFAULT 0, `transactions` longtext DEFAULT '[]', `auth` longtext DEFAULT '[]', `isFrozen` int(11) DEFAULT 0, `creator` varchar(50) DEFAULT NULL, PRIMARY KEY (`id`));", values = nil },
    { query = "CREATE TABLE IF NOT EXISTS `player_transactions` (`id` varchar(50) NOT NULL, `isFrozen` int(11) DEFAULT 0, `transactions` longtext DEFAULT '[]', PRIMARY KEY (`id`));", values = nil },
    { query = "CREATE TABLE IF NOT EXISTS `player_credit_scores` (`id` varchar(50) NOT NULL, `score` int(11) NOT NULL DEFAULT 650, `updated_at` int(11) DEFAULT NULL, PRIMARY KEY (`id`));", values = nil },
    { query = "CREATE TABLE IF NOT EXISTS `player_loans` (`loan_id` varchar(64) NOT NULL, `citizenid` varchar(50) NOT NULL, `amount` int(11) NOT NULL, `total_owed` int(11) NOT NULL, `remaining` int(11) NOT NULL, `interest_rate` int(11) NOT NULL DEFAULT 0, `status` varchar(20) NOT NULL DEFAULT 'active', `created_at` int(11) NOT NULL, `due_at` int(11) DEFAULT NULL, `paid_at` int(11) DEFAULT NULL, `max_eligibility_amount` int(11) NOT NULL DEFAULT 0, `overdue_days` int(11) NOT NULL DEFAULT 0, `credit_lost` int(11) NOT NULL DEFAULT 0, `last_penalty_at` int(11) DEFAULT NULL, `payments` longtext DEFAULT '[]', PRIMARY KEY (`loan_id`), KEY `citizenid_status` (`citizenid`, `status`));", values = nil }
}

assert(MySQL.transaction.await(createTables), "Failed to create tables")

local function ensureColumn(tableName, columnName, definition)
    local column = MySQL.query.await(("SHOW COLUMNS FROM `%s` LIKE ?"):format(tableName), { columnName })
    if not column or not column[1] then
        MySQL.query.await(("ALTER TABLE `%s` ADD COLUMN `%s` %s"):format(tableName, columnName, definition))
    end
end

ensureColumn('player_loans', 'due_at', 'int(11) DEFAULT NULL')
ensureColumn('player_loans', 'max_eligibility_amount', 'int(11) NOT NULL DEFAULT 0')
ensureColumn('player_loans', 'overdue_days', 'int(11) NOT NULL DEFAULT 0')
ensureColumn('player_loans', 'credit_lost', 'int(11) NOT NULL DEFAULT 0')
ensureColumn('player_loans', 'last_penalty_at', 'int(11) DEFAULT NULL')

CreateThread(function()
    Wait(5000)
    while true do
        local config = getCreditConfig()
        if config.enabled ~= false then
            local now = os.time()
            local overduePlayers = MySQL.query.await("SELECT DISTINCT citizenid FROM player_loans WHERE status IN ('active', 'overdue') AND remaining > 0 AND (due_at IS NULL OR due_at < ?)", { now }) or {}
            for i = 1, #overduePlayers do
                loadPlayerLoans(overduePlayers[i].citizenid, true)
            end
        end

        Wait(math.floor((tonumber(config.overdueCheckMinutes) or 30) * 60000))
    end
end)
