---@class Transaction
---@field origin string -- Arbitrary string to identify the origin of the transaction | Name whatever you want
---@field senderName string
---@field senderId string Character Id
---@field senderType string[]
---@field receiverName string
---@field receiverId string Character Id
---@field receiverType string[]
---@field amount number
---@field description string?

local function formatDateOKOK2(dateStr)
    if not dateStr then return os.date('%Y-%m-%d %H:%M:%S') end
    local formatted = dateStr:gsub("/", "-"):gsub(" %- ", " ")
    return formatted
end


---@param charId string
---@return Transaction[] | nil
function GetPlayerTransactions(charId)
    local transactions = {}

    if GetResourceState("okokBanking") == "started" then
        if HasExports("okokBanking", "GetPlayerTransactions") then
            ---@type {sender_identifier:string, sender_name:string, receiver_identifier:string, receiver_name:string, value:number, type: string, reason:string,date:string}[]
            local txs = exports.okokBanking:GetPlayerTransactions(charId, 100)
            for index, tx in ipairs(txs) do
                table.insert(transactions, {
                    id = index,
                    origin = "okokbanking",
                    date = formatDateOKOK2(tx.date),
                    sender = tx.sender_name,
                    senderCharId = tx.sender_identifier,
                    receiver = tx.receiver_name,
                    receiverCharId = tx.receiver_identifier,
                    amount = tx.value,
                    description = tx.reason
                })
            end
            return transactions
        end

        local result = MySQL.rawExecute.await(
            'SELECT * FROM okokbanking_transactions WHERE sender_identifier = ? LIMIT 100', {
                charId,
            })

        if result then
            for _, transaction in ipairs(result) do
                transactions[#transactions + 1] = {
                    id = transaction.id,
                    origin = 'okokbanking',
                    date = transaction.date,
                    sender = transaction.sender_name,
                    senderCharId = transaction.sender_identifier,
                    receiver = transaction.receiver_name,
                    receiverCharId = transaction.receiver_identifier,
                    amount = transaction.value,
                    description = transaction.type or 'Banking Transaction',
                }
            end
        end
    end

    if GetResourceState("wasabi_banking") == "started" then
        local result = MySQL.rawExecute.await('SELECT * FROM wasabibanking_transactions', {})

        if result then
            local charIds = {}
            for _, r in ipairs(result) do
                charIds[# charIds + 1] = r.citizenid
            end

            local charIdToName = {}

            if Framework.name == 'esx' then
                if #charIds > 0 then
                    local placeholders = string.rep('?,', #charIds):sub(1, -2)
                    local nameResult = MySQL.rawExecute.await(
                        'SELECT identifier, CONCAT(firstname, " ", lastname) AS name FROM users WHERE identifier IN (' ..
                        placeholders .. ')', charIds)
                    if nameResult then
                        for _, r in ipairs(nameResult) do
                            charIdToName[r.identifier] = r.name
                        end
                    end
                end
            else
                if #charIds > 0 then
                    local placeholders = string.rep('?,', #charIds):sub(1, -2)
                    local nameResult = MySQL.rawExecute.await(
                        'SELECT citizenid, charinfo FROM players WHERE citizenid IN (' .. placeholders .. ')', charIds)
                    if nameResult then
                        for _, r in ipairs(nameResult) do
                            local charinfo = json.decode(r.charinfo)
                            charIdToName[r.citizenid] = charinfo.firstname .. " " .. charinfo.lastname
                        end
                    end
                end
            end

            for _, transaction in ipairs(result) do
                transactions[#transactions + 1] = {
                    id = transaction.id,
                    origin = 'wasabi',
                    date = transaction.date,
                    sender = charIdToName[transaction.citizenid] or transaction.citizenid,
                    senderCharId = transaction.citizenid,
                    receiver = transaction.account,
                    receiverCharId = transaction.account,
                    amount = transaction.amount,
                    description = transaction.reason or 'Wasabi Banking Transaction',
                }
            end
        end
    end

    if Framework.name == "qbx" then
        local success, result = pcall(MySQL.prepare.await, "SELECT * FROM player_transactions WHERE id = ?", { charId }) --[[ @as {citizenid:string, isFrozen:boolean, transactions:string} ]]
        if not success or not result or not result?.transactions then return end

        local qbxTransactions = json.decode(result.transactions)
        if not qbxTransactions or type(qbxTransactions) ~= 'table' then return end

        for _, transaction in ipairs(qbxTransactions) do
            transactions[#transactions + 1] = {
                id = transaction.trans_id,
                origin = 'qbx',
                date = transaction.time,
                sender = transaction.issuer,
                senderCharId = charId,
                receiver = transaction.receiver,
                receiverCharId = charId,
                amount = transaction.amount,
                description = transaction.message or 'QBX Transaction',
            }
        end
    end

    if Framework.name == 'qb' then
        local result = MySQL.rawExecute.await('SELECT * FROM bank_statements WHERE citizenid = ?', {
            charId,
        })

        if result then
            for _, transaction in ipairs(result) do
                transactions[#transactions + 1] = {
                    id = transaction.id,
                    origin = 'qb-banking',
                    date = transaction.date,
                    sender = transaction.citizenid,
                    senderCharId = transaction.citizenid,
                    receiver = transaction.account_name,
                    receiverCharId = transaction.account_name,
                    amount = transaction.amount,
                    description = transaction.reason or 'QB Banking Transaction',
                }
            end
        end
    end


    return transactions
end

exports('GetPlayerTransactions', GetPlayerTransactions)
