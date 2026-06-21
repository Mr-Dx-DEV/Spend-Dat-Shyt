FLBridge.banking = {}

function FLBridge.banking.GetSocietyBalance(societyName, societyType)
    societyType = societyType or 'job'
    local banking = Config.GetBanking()
    
    if banking == 'wasabi_banking' then
        local ok, bal = pcall(function() return exports['wasabi_banking']:GetAccountBalance(societyName, 'society') end)
        return ok and bal or 0

    elseif banking == 'okokBanking' then
        local ok, bal = pcall(function() return exports['okokBanking']:GetAccount(societyName) end)
        return ok and bal or 0

    elseif banking == 'fd_banking' then
        local ok, bal = pcall(function() return exports.fd_banking:GetAccount(societyName) end)
        return ok and bal or 0

    elseif banking == 'tgg-banking' then
        local ok, bal = pcall(function() return exports['tgg-banking']:GetSocietyAccountMoney(societyName) end)
        return ok and bal or 0

    elseif banking == 'qb-banking' then
        local ok, bal = pcall(function() return exports['qb-banking']:GetAccountBalance(societyName) end)
        return ok and bal or 0

    elseif banking == 'qb-management' then
        local ok, bal = pcall(function()
            if societyType == 'job' then
                return exports['qb-management']:GetAccount(societyName)
            elseif societyType == 'gang' then
                return exports['qb-management']:GetGangAccount(societyName)
            end
        end)
        return ok and bal or 0

    elseif banking == 'Renewed-Banking' then
        local ok, bal = pcall(function() return exports['Renewed-Banking']:getAccountMoney(societyName) end)
        return ok and bal or 0

    elseif banking == 'esx_society' then
        local accountName = 'society_' .. societyName
        local ok, bal = pcall(function()
            local account = exports['esx_addonaccount']:GetSharedAccount(accountName)
            return account and account.money or 0
        end)
        return ok and bal or 0
    end

    return 0
end

function FLBridge.banking.AddSocietyMoney(societyName, amount, societyType)
    societyType = societyType or 'job'
    amount = math.floor(amount)
    if amount <= 0 then return false end

    local success = false
    local banking = Config.GetBanking()

    if banking == 'wasabi_banking' then
        success = pcall(function()
            local result = exports['wasabi_banking']:AddMoney('society', societyName, amount)
            if not result then exports['wasabi_banking']:CreateJobAccount(societyName, amount) end
        end)

    elseif banking == 'okokBanking' then
        success = pcall(function() exports['okokBanking']:AddMoney(societyName, amount) end)

    elseif banking == 'fd_banking' then
        success = pcall(function() exports.fd_banking:AddMoney(societyName, amount) end)

    elseif banking == 'tgg-banking' then
        success = pcall(function() exports['tgg-banking']:AddSocietyMoney(societyName, amount) end)

    elseif banking == 'qb-banking' then
        success = pcall(function() exports['qb-banking']:AddMoney(societyName, amount) end)

    elseif banking == 'qb-management' then
        success = pcall(function()
            if societyType == 'job' then
                exports['qb-management']:AddMoney(societyName, amount)
            elseif societyType == 'gang' then
                exports['qb-management']:AddGangMoney(societyName, amount)
            end
        end)

    elseif banking == 'Renewed-Banking' then
        success = pcall(function() exports['Renewed-Banking']:addAccountMoney(societyName, amount) end)

    elseif banking == 'esx_society' then
        success = pcall(function()
            local accountName = 'society_' .. societyName
            local account = exports['esx_addonaccount']:GetSharedAccount(accountName)
            if account then
                account.addMoney(amount)
            end
        end)
    end

    return success
end

function FLBridge.banking.RemoveSocietyMoney(societyName, amount, societyType)
    societyType = societyType or 'job'
    amount = math.floor(amount)
    if amount <= 0 then return false end

    local currentBalance = FLBridge.banking.GetSocietyBalance(societyName, societyType)
    if Config.Debug then
        print('[FL-BRIDGE] DEBUG RemoveSocietyMoney: Society=' .. tostring(societyName) .. ', Amount=' .. amount .. ', Balance=' .. currentBalance)
    end

    if currentBalance < amount then
        if Config.Debug then print('[FL-BRIDGE] DEBUG: Insufficient balance') end
        return false
    end

    local success = false
    local banking = Config.GetBanking()
    if Config.Debug then
        print('[FL-BRIDGE] DEBUG: Banking system = ' .. tostring(banking))
    end

    if banking == 'wasabi_banking' then
        success = pcall(function() exports['wasabi_banking']:RemoveMoney('society', societyName, amount) end)

    elseif banking == 'okokBanking' then
        success = pcall(function() exports['okokBanking']:RemoveMoney(societyName, amount) end)

    elseif banking == 'fd_banking' then
        success = pcall(function() exports.fd_banking:RemoveMoney(societyName, amount) end)

    elseif banking == 'tgg-banking' then
        success = pcall(function() exports['tgg-banking']:RemoveSocietyMoney(societyName, amount) end)

    elseif banking == 'qb-banking' then
        if Config.Debug then print('[FL-BRIDGE] DEBUG: Calling qb-banking RemoveMoney') end
        success = pcall(function() exports['qb-banking']:RemoveMoney(societyName, amount) end)
        if Config.Debug then print('[FL-BRIDGE] DEBUG: qb-banking success=' .. tostring(success)) end

    elseif banking == 'qb-management' then
        success = pcall(function()
            if societyType == 'job' then
                exports['qb-management']:RemoveMoney(societyName, amount)
            elseif societyType == 'gang' then
                exports['qb-management']:RemoveGangMoney(societyName, amount)
            end
        end)

    elseif banking == 'Renewed-Banking' then
        success = pcall(function() exports['Renewed-Banking']:removeAccountMoney(societyName, amount) end)

    elseif banking == 'esx_society' then
        success = pcall(function()
            local accountName = 'society_' .. societyName
            local account = exports['esx_addonaccount']:GetSharedAccount(accountName)
            if account then
                account.removeMoney(amount)
            end
        end)
    end

    return success
end

function FLBridge.banking.CanAfford(societyName, amount, societyType)
    return FLBridge.banking.GetSocietyBalance(societyName, societyType) >= amount
end

function FLBridge.banking.Initialize()
    local banking = Config.GetBanking()
    if banking and Config.Debug then
        print("[FL-BRIDGE] Banking system: " .. banking)
    end
    return true
end
