BridgeServer = {}

if Config.Framework == 'esx' then
    BridgeServer.fw = exports['es_extended']:getSharedObject()
elseif Config.Framework == 'qbcore' then
    BridgeServer.fw = exports['qb-core']:GetCoreObject()
end

--- Is the player an admin? Checks Config.AdminGroups (as `group.<name>` aces) + framework groups.
---@param source number
---@return boolean
function BridgeServer.IsAdmin(source)
    local src = tostring(source)
    for _, group in ipairs(Config.AdminGroups or {}) do
        if IsPlayerAceAllowed(src, 'group.' .. group) then return true end
    end

    -- The exact ace ox_lib's restricted /hoteladmin command is gated by. Being
    -- a *principal* of group.admin (add_principal) doesn't always make
    -- IsPlayerAceAllowed(src, 'group.admin') return true, but ox_lib explicitly
    -- grants the admin groups `command.hoteladmin`, so this check keeps "can
    -- open the panel" and "can edit in the panel" in lock-step regardless of how
    -- a server grants admin (group membership, txAdmin, a direct add_ace, etc.).
    if IsPlayerAceAllowed(src, 'command.hoteladmin') then return true end

    if Config.Framework == 'qbox' then
        local ok, player = pcall(exports.qbx_core.GetPlayer, exports.qbx_core, source)
        if ok and player then
            local group = player.PlayerData and player.PlayerData.group
            if group == 'admin' or group == 'god' then return true end
        end
    elseif Config.Framework == 'qbcore' then
        if BridgeServer.fw and BridgeServer.fw.Functions then
            if BridgeServer.fw.Functions.HasPermission(source, 'admin') then return true end
            if BridgeServer.fw.Functions.HasPermission(source, 'god') then return true end
        end
    elseif Config.Framework == 'esx' then
        local xPlayer = BridgeServer.fw.GetPlayerFromId(source)
        if xPlayer then
            local group = xPlayer.getGroup()
            if group == 'admin' or group == 'superadmin' or group == 'god' then return true end
        end
    end

    return false
end

--- Per-character persistent identifier. Qbox/qbcore use `citizenid`, ESX uses
--- the player identifier (license-based — ESX has no character concept), Ox uses
--- `charid`. **Returns nil** if no character is loaded yet (e.g. on the multichar
--- screen) for any character-based framework. Callers should retry shortly when
--- nil is returned. ESX returns a license-based identifier directly since it has
--- no character concept.
---@param source number
---@return string|nil
function BridgeServer.GetIdentifier(source)
    if Config.Framework == 'qbox' then
        local ok, player = pcall(exports.qbx_core.GetPlayer, exports.qbx_core, source)
        if ok and player and player.PlayerData and player.PlayerData.citizenid then
            return player.PlayerData.citizenid
        end
        return nil  -- character not loaded yet — caller should retry
    elseif Config.Framework == 'qbcore' then
        if BridgeServer.fw and BridgeServer.fw.Functions then
            local player = BridgeServer.fw.Functions.GetPlayer(source)
            if player and player.PlayerData and player.PlayerData.citizenid then
                return player.PlayerData.citizenid
            end
        end
        return nil
    elseif Config.Framework == 'ox' then
        local ok, player = pcall(exports.ox_core.GetPlayer, exports.ox_core, source)
        if ok and player and player.charid then return tostring(player.charid) end
        return nil
    elseif Config.Framework == 'esx' then
        local xPlayer = BridgeServer.fw.GetPlayerFromId(source)
        if xPlayer and xPlayer.identifier then return xPlayer.identifier end
        return nil
    end
    -- Unknown framework: fall back to license. Rentals will be per-account.
    for i = 0, GetNumPlayerIdentifiers(source) - 1 do
        local id = GetPlayerIdentifier(source, i)
        if id and id:sub(1, 8) == 'license:' then return id end
    end
    return GetPlayerIdentifier(source, 0)
end

--- Refund (give) `amount` to the player's `Config.PaymentAccount`.
---@param source number
---@param amount number
---@return boolean ok
function BridgeServer.RefundPlayer(source, amount)
    if amount <= 0 then return true end
    local account = Config.PaymentAccount

    if Config.Framework == 'qbox' then
        local player = exports.qbx_core:GetPlayer(source)
        if not player then return false end
        return player.Functions.AddMoney(account, amount, 'nex_hotels:refund') == true
    elseif Config.Framework == 'qbcore' then
        local player = BridgeServer.fw.Functions.GetPlayer(source)
        if not player then return false end
        return player.Functions.AddMoney(account, amount, 'nex_hotels:refund') == true
    elseif Config.Framework == 'esx' then
        local xPlayer = BridgeServer.fw.GetPlayerFromId(source)
        if not xPlayer then return false end
        if account == 'bank' then xPlayer.addAccountMoney('bank', amount) else xPlayer.addMoney(amount) end
        return true
    end
    return false
end

--- Try to charge `amount` from the player.
--- Tries `Config.PaymentAccount` first; if that account doesn't have enough,
--- falls back to the OTHER account. Only fails if neither bank nor cash can
--- cover the cost.
---@param source number
---@param amount number
---@return boolean ok
function BridgeServer.ChargePlayer(source, amount)
    if amount <= 0 then return true end
    local primary   = Config.PaymentAccount
    local secondary = (primary == 'bank') and 'cash' or 'bank'

    if Config.Framework == 'qbox' then
        local player = exports.qbx_core:GetPlayer(source)
        if not player then return false end
        local money = player.PlayerData.money or {}
        local function take(acct)
            if (money[acct] or 0) < amount then return false end
            return player.Functions.RemoveMoney(acct, amount, 'nex_hotels:rent') == true
        end
        if take(primary) then return true end
        if take(secondary) then return true end
        return false
    elseif Config.Framework == 'qbcore' then
        local player = BridgeServer.fw.Functions.GetPlayer(source)
        if not player then return false end
        local money = player.PlayerData.money or {}
        local function take(acct)
            if (money[acct] or 0) < amount then return false end
            return player.Functions.RemoveMoney(acct, amount, 'nex_hotels:rent') == true
        end
        if take(primary) then return true end
        if take(secondary) then return true end
        return false
    elseif Config.Framework == 'esx' then
        local xPlayer = BridgeServer.fw.GetPlayerFromId(source)
        if not xPlayer then return false end
        local function take(acct)
            if acct == 'bank' then
                if (xPlayer.getAccount('bank').money or 0) < amount then return false end
                xPlayer.removeAccountMoney('bank', amount)
            else
                if (xPlayer.getMoney() or 0) < amount then return false end
                xPlayer.removeMoney(amount)
            end
            return true
        end
        if take(primary) then return true end
        if take(secondary) then return true end
        return false
    end

    return false
end

-- ─── Job helpers (hotel ownership) ──────────────────────────
-- These power /myhotel access checks: a player can manage a hotel if their
-- identifier matches owner_identifier OR they hold the hotel's job_name at
-- the boss grade (a.k.a. isboss=true / grade_name='boss').

--- Returns the player's current job as `{ name, grade, isboss }`, or nil if
--- no job is loaded. `isboss` is true for qbcore/qbox `isboss=1` grades,
--- ESX `grade_name == 'boss'`, or anyone in the framework's admin group.
---@param source number
---@return { name: string, grade: number, isboss: boolean }|nil
function BridgeServer.GetPlayerJob(source)
    if Config.Framework == 'qbox' then
        local ok, player = pcall(exports.qbx_core.GetPlayer, exports.qbx_core, source)
        if ok and player and player.PlayerData and player.PlayerData.job then
            local job = player.PlayerData.job
            return {
                name = job.name,
                grade = (job.grade and job.grade.level) or 0,
                isboss = (job.grade and job.grade.isboss) == true or job.isboss == true,
            }
        end
    elseif Config.Framework == 'qbcore' then
        if BridgeServer.fw and BridgeServer.fw.Functions then
            local player = BridgeServer.fw.Functions.GetPlayer(source)
            if player and player.PlayerData and player.PlayerData.job then
                local job = player.PlayerData.job
                return {
                    name = job.name,
                    grade = (job.grade and job.grade.level) or 0,
                    isboss = (job.grade and job.grade.isboss) == true or job.isboss == true,
                }
            end
        end
    elseif Config.Framework == 'esx' then
        local xPlayer = BridgeServer.fw.GetPlayerFromId(source)
        if xPlayer and xPlayer.job then
            local grade_name = xPlayer.job.grade_name or ''
            return {
                name = xPlayer.job.name,
                grade = xPlayer.job.grade or 0,
                isboss = grade_name == 'boss' or grade_name == 'owner',
            }
        end
    end
    return nil
end

--- Does the player hold `jobName` AND are they at the boss grade for it?
--- This is the gate for hotel manage rights when the hotel is job-locked.
---@param source number
---@param jobName string
---@return boolean
function BridgeServer.IsBossOfJob(source, jobName)
    if not jobName or jobName == '' then return false end
    local job = BridgeServer.GetPlayerJob(source)
    return job ~= nil and job.name == jobName and job.isboss == true
end

--- Validates a job exists in the framework's job registry. Used at purchase
--- time so admins can't lock a hotel to a typo'd / nonexistent job.
---@param jobName string
---@return boolean
function BridgeServer.JobExists(jobName)
    if not jobName or jobName == '' then return false end
    if Config.Framework == 'qbox' then
        local ok, jobs = pcall(exports.qbx_core.GetJobs, exports.qbx_core)
        return ok and type(jobs) == 'table' and jobs[jobName] ~= nil
    elseif Config.Framework == 'qbcore' then
        if BridgeServer.fw and BridgeServer.fw.Shared and BridgeServer.fw.Shared.Jobs then
            return BridgeServer.fw.Shared.Jobs[jobName] ~= nil
        end
    elseif Config.Framework == 'esx' then
        if not BridgeServer.fw then return false end
        local jobs = BridgeServer.fw.GetJobs and BridgeServer.fw.GetJobs() or nil
        if type(jobs) == 'table' and jobs[jobName] then return true end
        -- ESX legacy fallback: ask the DB directly
        local row = MySQL.scalar.await('SELECT name FROM jobs WHERE name = ?', { jobName })
        return row ~= nil
    end
    return false
end

--- Returns the player's IN-GAME character name (e.g. "John Smith" from
--- charinfo/firstName+lastName), NOT their FiveM Steam/Discord display
--- name. Falls back to GetPlayerName when the character data isn't
--- accessible (no character loaded, framework export missing, etc.) so
--- the caller always gets a non-nil string for display purposes.
---@param source number
---@return string
function BridgeServer.GetCharacterName(source)
    local fivemName = GetPlayerName(source) or tostring(source)

    if Config.Framework == 'qbox' then
        local ok, player = pcall(exports.qbx_core.GetPlayer, exports.qbx_core, source)
        if ok and player and player.PlayerData and player.PlayerData.charinfo then
            local ci = player.PlayerData.charinfo
            local first = ci.firstname or ''
            local last  = ci.lastname  or ''
            local full = (first .. ' ' .. last):gsub('^%s+', ''):gsub('%s+$', '')
            if full ~= '' then return full end
        end
    elseif Config.Framework == 'qbcore' then
        if BridgeServer.fw and BridgeServer.fw.Functions then
            local player = BridgeServer.fw.Functions.GetPlayer(source)
            if player and player.PlayerData and player.PlayerData.charinfo then
                local ci = player.PlayerData.charinfo
                local first = ci.firstname or ''
                local last  = ci.lastname  or ''
                local full = (first .. ' ' .. last):gsub('^%s+', ''):gsub('%s+$', '')
                if full ~= '' then return full end
            end
        end
    elseif Config.Framework == 'esx' then
        local xPlayer = BridgeServer.fw.GetPlayerFromId(source)
        if xPlayer then
            -- ESX legacy: getName() returns "First Last"; ESX 1.10+ keeps it on the player table
            if type(xPlayer.getName) == 'function' then
                local n = xPlayer.getName()
                if type(n) == 'string' and n ~= '' then return n end
            end
            local first = (xPlayer.get and xPlayer.get('firstName')) or xPlayer.firstName or ''
            local last  = (xPlayer.get and xPlayer.get('lastName'))  or xPlayer.lastName  or ''
            local full = (first .. ' ' .. last):gsub('^%s+', ''):gsub('%s+$', '')
            if full ~= '' then return full end
        end
    elseif Config.Framework == 'ox' then
        local ok, player = pcall(exports.ox_core.GetPlayer, exports.ox_core, source)
        if ok and player and player.firstName then
            local first = player.firstName or ''
            local last  = player.lastName  or ''
            local full = (first .. ' ' .. last):gsub('^%s+', ''):gsub('%s+$', '')
            if full ~= '' then return full end
        end
    end

    return fivemName
end

--- Looks up a player's source by their persistent identifier (citizenid/license).
--- Returns nil if they're offline.
---@param identifier string
---@return number|nil
function BridgeServer.FindSourceByIdentifier(identifier)
    if not identifier or identifier == '' then return nil end
    for _, src in ipairs(GetPlayers()) do
        local s = tonumber(src)
        if s and BridgeServer.GetIdentifier(s) == identifier then return s end
    end
    return nil
end

--- Deposit `amount` to the hotel's owner. Tries, in order:
---   1. The job's society/boss account (qb-management / qb-banking / esx_addonaccount)
---   2. The owner's personal bank if they're online
---   3. Returns false (caller logs it; rent payment still completes for the renter)
---
--- Society deposits are the right call for a job-locked hotel because boss-grade
--- staff can withdraw from the management UI just like any other business.
---@param ownerIdentifier string|nil
---@param jobName         string|nil
---@param amount          number
---@param reason          string
---@return boolean ok, string? channel  -- channel ∈ 'society' | 'bank' | nil
function BridgeServer.DepositToOwner(ownerIdentifier, jobName, amount, reason)
    if not amount or amount <= 0 then return true, nil end
    reason = reason or 'nex_hotels:rent'

    -- ── 1. Job society account ──────────────────────────────
    -- IMPORTANT: pcall returns true whenever the inner function didn't raise a
    -- Lua error — that's separate from whether the deposit actually succeeded.
    -- Each banking export here returns false (no error) when the society
    -- account doesn't exist, so we must inspect the inner return value too.
    -- Otherwise a missing/misnamed society silently swallows the rent and the
    -- owner-bank fallback never fires.
    if jobName and jobName ~= '' then
        -- qb-banking (qbox + modern qbcore): exports['qb-banking']:AddMoney(account, amount, reason)
        if GetResourceState('qb-banking') == 'started' then
            local ok, result = pcall(function()
                return exports['qb-banking']:AddMoney(jobName, amount, reason)
            end)
            if ok and result == true then return true, 'society' end
            if not ok then
                print(('[nex_hotels] qb-banking deposit errored for "%s": %s'):format(jobName, tostring(result)))
            else
                print(('[nex_hotels] qb-banking refused deposit for "%s" — society account likely not registered.'):format(jobName))
            end
        end
        -- qb-management (legacy qbcore): exports['qb-management']:AddMoney(jobName, amount)
        if GetResourceState('qb-management') == 'started' then
            local ok, result = pcall(function()
                return exports['qb-management']:AddMoney(jobName, amount)
            end)
            if ok and result then return true, 'society' end
            if not ok then
                print(('[nex_hotels] qb-management deposit errored for "%s": %s'):format(jobName, tostring(result)))
            else
                print(('[nex_hotels] qb-management refused deposit for "%s" — society account likely not registered.'):format(jobName))
            end
        end
        -- esx_addonaccount: society accounts are stored as ('society_<job>', shared=1)
        -- with an empty owner. Forks differ on whether the owner is nil or '' and
        -- whether GetSharedAccount exists, so try the common signatures in order.
        if Config.Framework == 'esx' and GetResourceState('esx_addonaccount') == 'started' then
            local accountName = 'society_' .. jobName
            local account
            local getters = {
                function() return exports['esx_addonaccount']:GetSharedAccount(accountName) end,
                function() return exports['esx_addonaccount']:GetAccount(accountName, '') end,
                function() return exports['esx_addonaccount']:GetAccount(accountName, nil) end,
            }
            for _, getter in ipairs(getters) do
                local ok, result = pcall(getter)
                if ok and result then account = result; break end
            end
            if account then
                local ok, err = pcall(function() account.addMoney(amount) end)
                if ok then
                    if Config.Debug then
                        print(('[nex_hotels] ESX society deposit: %s += $%d'):format(accountName, amount))
                    end
                    return true, 'society'
                end
                print(('[nex_hotels] ESX society "%s" addMoney errored: %s'):format(accountName, tostring(err)))
            else
                print(('[nex_hotels] ESX society "%s" not found in esx_addonaccount. ')
                    :format(accountName)
                    .. 'Register it: INSERT INTO addon_account (name, label, shared) VALUES (\''
                    .. accountName .. '\', \'' .. jobName .. '\', 1); '
                    .. 'then INSERT INTO addon_account_data (account_name, money, owner) VALUES (\''
                    .. accountName .. '\', 0, NULL); and restart esx_addonaccount.')
            end
        end
    end

    -- ── 2. Owner's personal bank (online only) ──────────────
    if ownerIdentifier and ownerIdentifier ~= '' then
        local src = BridgeServer.FindSourceByIdentifier(ownerIdentifier)
        if src then
            if Config.Framework == 'qbox' then
                local p = exports.qbx_core:GetPlayer(src)
                if p and p.Functions.AddMoney('bank', amount, reason or 'nex_hotels:rent') then
                    return true, 'bank'
                end
            elseif Config.Framework == 'qbcore' then
                local p = BridgeServer.fw.Functions.GetPlayer(src)
                if p and p.Functions.AddMoney('bank', amount, reason or 'nex_hotels:rent') then
                    return true, 'bank'
                end
            elseif Config.Framework == 'esx' then
                local xPlayer = BridgeServer.fw.GetPlayerFromId(src)
                if xPlayer then xPlayer.addAccountMoney('bank', amount); return true, 'bank' end
            end
        end
    end

    return false, nil
end
