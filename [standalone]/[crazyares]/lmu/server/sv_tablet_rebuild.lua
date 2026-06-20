GrimUseTabletRebuild = true

local Framework = Config.Framework
local BabyProfileTableReady = false

local function DecodeJsonValue(value)
    if type(value) == 'table' then
        return value
    end

    if type(value) ~= 'string' or value == '' then
        return {}
    end

    local ok, decoded = pcall(json.decode, value)
    if ok and type(decoded) == 'table' then
        return decoded
    end

    return {}
end

local function ParseDateTimeToUnix(value)
    if type(value) == 'number' then
        -- oxmysql returns millisecond timestamps; convert to seconds
        return value > 1e10 and math.floor(value / 1000) or math.floor(value)
    end

    -- oxmysql returns DATETIME columns as a Lua table on modern builds
    if type(value) == 'table' then
        local year   = tonumber(value.year   or 0) or 0
        local month  = tonumber(value.month  or 1) or 1
        local day    = tonumber(value.day    or 1) or 1
        local hour   = tonumber(value.hour   or 0) or 0
        local minute = tonumber(value.minute or value.min or 0) or 0
        local second = tonumber(value.second or value.sec or 0) or 0
        if year == 0 then return nil end
        return os.time({ year=year, month=month, day=day, hour=hour, min=minute, sec=second })
    end

    if type(value) ~= 'string' or value == '' then
        return nil
    end

    local year, month, day, hour, minute, second = value:match('^(%d%d%d%d)%-(%d%d)%-(%d%d) (%d%d):(%d%d):(%d%d)$')
    if not year then
        year, month, day = value:match('^(%d%d%d%d)%-(%d%d)%-(%d%d)$')
        hour, minute, second = '00', '00', '00'
    end

    if not year then
        return nil
    end

    return os.time({
        year = tonumber(year),
        month = tonumber(month),
        day = tonumber(day),
        hour = tonumber(hour),
        min = tonumber(minute),
        sec = tonumber(second),
    })
end

-- FiveM's oxmysql returns DATETIME columns as a Lua table {year,month,day,hour,minute,second}
-- not as a string. tostring() on that gives "[table]" which breaks date parsing.
-- This helper converts any MySQL datetime value to a proper ISO string.
local function DateTimeToString(value)
    -- Delegate to the global helper defined in sv_main.lua
    -- Falls back to local implementation if global isn't available yet
    if type(GrimDateTimeToString) == 'function' then
        return GrimDateTimeToString(value)
    end
    if not value then return nil end
    if type(value) == 'string' and value ~= '' then return value end
    if type(value) == 'number' then
        local ts = value > 1e10 and math.floor(value / 1000) or math.floor(value)
        return os.date('%Y-%m-%d %H:%M:%S', ts)
    end
    if type(value) == 'table' then
        local year = tonumber(value.year or value[1])
        if year and year > 0 then
            local minute = tonumber(value.minute or value.min or value[5] or 0) or 0
            local second = tonumber(value.second or value.sec or value[6] or 0) or 0
            return string.format('%04d-%02d-%02d %02d:%02d:%02d',
                year,
                tonumber(value.month or value[2] or 1) or 1,
                tonumber(value.day   or value[3] or 1) or 1,
                tonumber(value.hour  or value[4] or 0) or 0,
                minute, second)
        end
    end
    local s = tostring(value)
    if s == '' or s == 'nil' then return nil end
    s = s:gsub('T', ' '):gsub('%.[0-9]+Z?$', ''):gsub('Z$', '')
    if s:match('^%d%d%d%d%-%d%d%-%d%d') then return s end
    return nil
end
local function BuildDisplayName(playerData, fallback)
    if type(playerData) ~= 'table' then
        return fallback
    end

    local charinfo = DecodeJsonValue(playerData.charinfo or playerData.charInfo)
    local firstName = charinfo.firstname or charinfo.firstName or playerData.firstname or playerData.firstName
    local lastName = charinfo.lastname or charinfo.lastName or playerData.lastname or playerData.lastName
    local pieces = {}

    if firstName and firstName ~= '' then
        pieces[#pieces + 1] = tostring(firstName)
    end

    if lastName and lastName ~= '' then
        pieces[#pieces + 1] = tostring(lastName)
    end

    if #pieces > 0 then
        return table.concat(pieces, ' ')
    end

    return playerData.name or playerData.charname or fallback
end

local function GetQBPlayer(src)
    if Framework ~= 'qb-core' or GetResourceState('qb-core') ~= 'started' then
        return nil
    end

    local ok, core = pcall(function()
        return exports['qb-core']:GetCoreObject()
    end)

    if ok and core and core.Functions then
        return core.Functions.GetPlayer(src)
    end

    return nil
end

local function GetQBXPlayer(src)
    if Framework ~= 'qbx' or GetResourceState('qbx_core') ~= 'started' then
        return nil
    end

    local ok, player = pcall(function()
        return exports['qbx_core']:GetPlayer(src)
    end)

    if ok and player then
        return player
    end

    ok, player = pcall(function()
        return exports.qbx_core:GetPlayer(src)
    end)

    if ok and player then
        return player
    end

    return nil
end

local function GetESXPlayer(src)
    if Framework ~= 'esx' or GetResourceState('es_extended') ~= 'started' then
        return nil
    end

    local ok, esx = pcall(function()
        return exports['es_extended']:getSharedObject()
    end)

    if ok and esx and esx.GetPlayerFromId then
        return esx.GetPlayerFromId(src)
    end

    return nil
end

function GetPlayerData(src)
    src = tonumber(src)
    if not src or src <= 0 then
        return nil
    end

    local qbPlayer = GetQBPlayer(src)
    if qbPlayer and qbPlayer.PlayerData then
        return qbPlayer.PlayerData
    end

    local qbxPlayer = GetQBXPlayer(src)
    if qbxPlayer then
        return qbxPlayer.PlayerData or qbxPlayer
    end

    local esxPlayer = GetESXPlayer(src)
    if esxPlayer then
        return {
            citizenid = esxPlayer.identifier,
            charinfo = {
                firstname = esxPlayer.get and esxPlayer.get('firstName') or nil,
                lastname = esxPlayer.get and esxPlayer.get('lastName') or nil,
            },
            job = esxPlayer.job,
            gang = esxPlayer.gang,
        }
    end

    return nil
end

function GetPlayerCID(src)
    src = tonumber(src)
    if not src or src <= 0 then
        return nil
    end

    local playerData = GetPlayerData(src)
    if playerData and playerData.citizenid and playerData.citizenid ~= '' then
        return playerData.citizenid
    end

    if playerData and playerData.identifier and playerData.identifier ~= '' then
        return playerData.identifier
    end

    local identifiers = GetPlayerIdentifiers(src)
    if not identifiers then
        return tostring(src)
    end

    local preferred = { 'license:', 'fivem:', 'discord:', 'steam:' }
    for _, prefix in ipairs(preferred) do
        for _, identifier in ipairs(identifiers) do
            if identifier:sub(1, #prefix) == prefix then
                return identifier
            end
        end
    end

    return identifiers[1] or tostring(src)
end

function GetCharName(src)
    src = tonumber(src)
    if not src or src <= 0 then
        return 'Unknown'
    end

    local playerData = GetPlayerData(src)
    local name = BuildDisplayName(playerData, nil)
    if name and name ~= '' then
        return name
    end

    return GetPlayerName(src) or ('Player ' .. tostring(src))
end

function Notify(src, msg, ntype)
    src = tonumber(src)
    if not src or src <= 0 then
        return
    end

    TriggerClientEvent('grim_lovemenu:cl:notify', src, msg, ntype or 'primary')
end

function HasItem(src, item, amount)
    amount = amount or 1
    src = tonumber(src)
    if not src or GetResourceState('ox_inventory') ~= 'started' then
        return false
    end

    return (exports.ox_inventory:GetItemCount(src, item) or 0) >= amount
end

function RemoveItem(src, item, amount)
    amount = amount or 1
    src = tonumber(src)
    if not src or GetResourceState('ox_inventory') ~= 'started' then
        return false
    end

    return exports.ox_inventory:RemoveItem(src, item, amount) ~= false
end

function GiveItem(src, item, amount, metadata)
    amount = amount or 1
    src = tonumber(src)
    if not src or GetResourceState('ox_inventory') ~= 'started' then
        return false
    end

    local added = exports.ox_inventory:AddItem(src, item, amount, metadata)
    if not added and Config.DebugPrint then
        print(('^1[grim_lovemenu]^7 GiveItem FAILED: item "%s" not registered in ox_inventory/data/items.lua'):format(item))
    end

    return added ~= false
end

local function GetOfflineQBRecord(citizenid)
    if not citizenid or citizenid == '' then
        return nil
    end

    if Framework ~= 'qb-core' and Framework ~= 'qbx' then
        return nil
    end

    return MySQL.single.await('SELECT citizenid, charinfo, money, job, gang FROM players WHERE citizenid = ? LIMIT 1', { citizenid })
end

local function GetRoleName(roleValue)
    local role = DecodeJsonValue(roleValue)
    if role.name then
        return role.name
    end

    if type(roleValue) == 'table' then
        return roleValue.name or roleValue.label
    end

    if type(roleValue) == 'string' and roleValue ~= '' then
        return roleValue
    end

    return nil
end

local function AllowListContains(container, value)
    if not value or type(container) ~= 'table' then
        return false
    end

    if container[value] ~= nil then
        return container[value] == true or container[value] == 1 or container[value] == value
    end

    for _, entry in pairs(container) do
        if entry == value then
            return true
        end
    end

    return false
end

function GetMoney(src, account)
    src = tonumber(src)
    if not src or src <= 0 then
        return 0
    end

    account = account or 'cash'

    local playerData = GetPlayerData(src)
    local money = playerData and DecodeJsonValue(playerData.money) or {}
    if money[account] ~= nil then
        return tonumber(money[account]) or 0
    end

    local esxPlayer = GetESXPlayer(src)
    if esxPlayer then
        if account == 'bank' and esxPlayer.getAccount then
            local bankAccount = esxPlayer.getAccount('bank')
            return tonumber(bankAccount and (bankAccount.money or bankAccount.balance) or 0) or 0
        elseif account ~= 'bank' and esxPlayer.getMoney then
            return tonumber(esxPlayer.getMoney()) or 0
        end
    end

    if GetResourceState('ox_inventory') == 'started' then
        if account == 'cash' then
            -- Servers differ: QBCore uses 'cash', some use 'money'. Try both and return the larger.
            local cashCount  = tonumber(exports.ox_inventory:GetItemCount(src, 'cash')  or 0) or 0
            local moneyCount = tonumber(exports.ox_inventory:GetItemCount(src, 'money') or 0) or 0
            return math.max(cashCount, moneyCount)
        end
        local itemName = account == 'bank' and 'bank' or account
        return tonumber(exports.ox_inventory:GetItemCount(src, itemName) or 0) or 0
    end

    return 0
end

local function RemoveMoneyFrameworkFallback(src, amount, account)
    account = account or 'cash'

    local qbPlayer = GetQBPlayer(src)
    if qbPlayer and qbPlayer.Functions and qbPlayer.Functions.RemoveMoney then
        return qbPlayer.Functions.RemoveMoney(account, amount, 'grim_lovemenu') ~= false
    end

    local qbxPlayer = GetQBXPlayer(src)
    if qbxPlayer then
        if qbxPlayer.Functions and qbxPlayer.Functions.RemoveMoney then
            return qbxPlayer.Functions.RemoveMoney(account, amount, 'grim_lovemenu') ~= false
        end

        if qbxPlayer.RemoveMoney then
            return qbxPlayer:RemoveMoney(account, amount, 'grim_lovemenu') ~= false
        end
    end

    local esxPlayer = GetESXPlayer(src)
    if esxPlayer then
        if account == 'bank' and esxPlayer.removeAccountMoney and esxPlayer.getAccount then
            local bankAccount = esxPlayer.getAccount('bank')
            local balance = tonumber(bankAccount and (bankAccount.money or bankAccount.balance) or 0) or 0
            if balance >= amount then
                esxPlayer.removeAccountMoney('bank', amount)
                return true
            end
        elseif account ~= 'bank' and esxPlayer.removeMoney then
            local cash = tonumber(esxPlayer.getMoney and esxPlayer.getMoney() or 0) or 0
            if cash >= amount then
                esxPlayer.removeMoney(amount)
                return true
            end
        end
    end

    return false
end

local function AddMoneyFrameworkFallback(src, amount, account)
    account = account or 'cash'

    local qbPlayer = GetQBPlayer(src)
    if qbPlayer and qbPlayer.Functions and qbPlayer.Functions.AddMoney then
        return qbPlayer.Functions.AddMoney(account, amount, 'grim_lovemenu') ~= false
    end

    local qbxPlayer = GetQBXPlayer(src)
    if qbxPlayer then
        if qbxPlayer.Functions and qbxPlayer.Functions.AddMoney then
            return qbxPlayer.Functions.AddMoney(account, amount, 'grim_lovemenu') ~= false
        end

        if qbxPlayer.AddMoney then
            return qbxPlayer:AddMoney(account, amount, 'grim_lovemenu') ~= false
        end
    end

    local esxPlayer = GetESXPlayer(src)
    if esxPlayer then
        if account == 'bank' and esxPlayer.addAccountMoney then
            esxPlayer.addAccountMoney('bank', amount)
            return true
        elseif account ~= 'bank' and esxPlayer.addMoney then
            esxPlayer.addMoney(amount)
            return true
        end
    end

    return false
end

function RemoveMoney(src, amount, account)
    src = tonumber(src)
    amount = math.floor(tonumber(amount) or 0)
    account = account or 'cash'

    if not src or amount <= 0 then
        return false
    end

    if RemoveMoneyFrameworkFallback(src, amount, account) then
        return true
    end

    if GetResourceState('ox_inventory') == 'started' then
        if account == 'cash' then
            -- Try 'cash' first (QBCore/QBX default), then fall back to 'money' (some frameworks)
            local cashCount = tonumber(exports.ox_inventory:GetItemCount(src, 'cash') or 0) or 0
            if cashCount >= amount then
                return exports.ox_inventory:RemoveItem(src, 'cash', amount) ~= false
            end
            local moneyCount = tonumber(exports.ox_inventory:GetItemCount(src, 'money') or 0) or 0
            if moneyCount >= amount then
                return exports.ox_inventory:RemoveItem(src, 'money', amount) ~= false
            end
            return false
        end
        local itemName = account == 'bank' and 'bank' or account
        local count = tonumber(exports.ox_inventory:GetItemCount(src, itemName) or 0) or 0
        if count >= amount then
            return exports.ox_inventory:RemoveItem(src, itemName, amount) ~= false
        end
    end

    return false
end

function AddMoney(src, amount, account)
    src = tonumber(src)
    amount = math.floor(tonumber(amount) or 0)
    account = account or 'cash'

    if not src or amount <= 0 then
        return false
    end

    if AddMoneyFrameworkFallback(src, amount, account) then
        return true
    end

    if GetResourceState('ox_inventory') == 'started' then
        if account == 'cash' then
            -- Mirror RemoveMoney: prefer 'cash' item name, fall back to 'money'
            -- Check which item the player already has to decide which name to credit
            local cashCount = tonumber(exports.ox_inventory:GetItemCount(src, 'cash') or 0) or 0
            local itemName = cashCount > 0 and 'cash' or 'money'
            return exports.ox_inventory:AddItem(src, itemName, amount) ~= false
        end
        local itemName = account == 'bank' and 'bank' or account
        return exports.ox_inventory:AddItem(src, itemName, amount) ~= false
    end

    return false
end

function IsPlayerOnline(src)
    src = tonumber(src)
    if not src or src <= 0 then
        return false
    end

    for _, playerSrc in ipairs(GetPlayers()) do
        if tonumber(playerSrc) == src then
            return true
        end
    end

    return false
end

function GetSrcByCID(citizenid)
    if not citizenid then
        return nil
    end

    for _, playerSrc in ipairs(GetPlayers()) do
        if GetPlayerCID(playerSrc) == citizenid then
            return tonumber(playerSrc)
        end
    end

    return nil
end

function GetCitizenName(citizenid)
    if not citizenid or citizenid == '' then
        return 'Unknown'
    end

    local onlineSrc = GetSrcByCID(citizenid)
    if onlineSrc then
        return GetCharName(onlineSrc)
    end

    local offlineRecord = GetOfflineQBRecord(citizenid)
    if offlineRecord then
        return BuildDisplayName(offlineRecord, citizenid)
    end

    return citizenid
end

function GrimGetActivePregnancy(citizenid)
    if not citizenid then
        return nil
    end

    return MySQL.single.await([[
        SELECT *
        FROM grim_lm_pregnancy
        WHERE cid=? AND born=0
        ORDER BY conceived_at DESC, id DESC
        LIMIT 1
    ]], { citizenid })
end

function GrimGetActivePregnancyConceivedUnix(citizenid)
    if not citizenid then
        return nil
    end

    return tonumber(MySQL.scalar.await([[
        SELECT UNIX_TIMESTAMP(conceived_at)
        FROM grim_lm_pregnancy
        WHERE cid=? AND born=0
        ORDER BY conceived_at DESC, id DESC
        LIMIT 1
    ]], { citizenid }))
end

function GetPlayerCoords(src)
    local ped = GetPlayerPed(src)
    if not ped or ped == 0 then
        return nil
    end

    return GetEntityCoords(ped)
end

function ArePlayersClose(srcA, srcB, maxDist)
    srcA = tonumber(srcA)
    srcB = tonumber(srcB)
    if not srcA or not srcB then
        return false
    end

    local coordsA = GetPlayerCoords(srcA)
    local coordsB = GetPlayerCoords(srcB)
    if not coordsA or not coordsB then
        return false
    end

    return #(coordsA - coordsB) <= (maxDist or Config.MaxDistance or 2.0)
end

local function GetChildSupportConfig()
    local cfg = Config.ChildSupport or {}
    return {
        enabled = cfg.Enabled ~= false,
        percent = tonumber(cfg.Percent or Config.ChildSupportPercent or 0.25) or 0.25,
        requireDNA = cfg.RequireDNA ~= false,
        requireBirth = cfg.RequireBirth ~= false,
        oneTimeOnly = cfg.OneTimeOnly ~= false,
        includeCash = cfg.IncludeCash ~= false,
        includeBank = cfg.IncludeBank ~= false,
        includeBlack = cfg.IncludeBlackMoney == true or Config.CountDirtyMoneyForChildSupport == true,
        blackType = cfg.BlackMoneyType or 'item',
        blackName = cfg.BlackMoneyName or Config.DirtyMoneyItem or 'black_money',
        requireFatherOnline = cfg.RequireFatherOnline == true,
        payToAccount = cfg.PayToAccount or cfg.PayoutItem or 'bank',
        roleLock = cfg.RoleLock or {},
    }
end

local function UsesRoleList(roleConfig, useField, listField)
    if type(roleConfig) ~= 'table' then
        return false
    end

    if roleConfig[useField] ~= nil then
        return roleConfig[useField] == true
    end

    local allowList = roleConfig[listField]
    return type(allowList) == 'table' and next(allowList) ~= nil
end

function GrimHasRoleWhitelistAccess(src, roleConfig)
    if type(roleConfig) ~= 'table' or roleConfig.Enabled ~= true then
        return true
    end

    local playerData = GetPlayerData(src) or {}
    local citizenid = playerData.citizenid or GetPlayerCID(src)
    local jobName = GetRoleName(playerData.job)
    local gangName = GetRoleName(playerData.gang)

    if UsesRoleList(roleConfig, 'UseCitizenIds', 'AllowedCitizenIds') and AllowListContains(roleConfig.AllowedCitizenIds, citizenid) then
        return true
    end

    if UsesRoleList(roleConfig, 'UseJobs', 'AllowedJobs') and AllowListContains(roleConfig.AllowedJobs, jobName) then
        return true
    end

    if UsesRoleList(roleConfig, 'UseGangs', 'AllowedGangs') and AllowListContains(roleConfig.AllowedGangs, gangName) then
        return true
    end

    return false
end

local function HasChildSupportRoleAccess(src)
    return GrimHasRoleWhitelistAccess(src, GetChildSupportConfig().roleLock)
end

function GrimEnsureBabyProfileTable()
    if BabyProfileTableReady then
        return
    end

    MySQL.query.await([[
        CREATE TABLE IF NOT EXISTS `grim_lm_baby_profiles` (
            `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
            `pregnancy_id` INT UNSIGNED NULL,
            `child_id` VARCHAR(64) NOT NULL,
            `mother_citizenid` VARCHAR(64) NOT NULL,
            `father_citizenid` VARCHAR(64) NOT NULL DEFAULT '',
            `mother_name` VARCHAR(128) NOT NULL DEFAULT '',
            `father_name` VARCHAR(128) NOT NULL DEFAULT '',
            `birth_timestamp` DATETIME NOT NULL,
            `dna_confirmed` TINYINT(1) NOT NULL DEFAULT 0,
            `child_support_claimed` TINYINT(1) NOT NULL DEFAULT 0,
            `child_support_amount` INT NOT NULL DEFAULT 0,
            `child_support_claimed_at` DATETIME NULL,
            `gender` VARCHAR(32) NOT NULL DEFAULT 'unknown',
            `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
            PRIMARY KEY (`id`),
            UNIQUE KEY `uniq_pregnancy_id` (`pregnancy_id`),
            UNIQUE KEY `uniq_child_id` (`child_id`),
            INDEX `idx_mother_citizenid` (`mother_citizenid`),
            INDEX `idx_father_citizenid` (`father_citizenid`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    ]])

    BabyProfileTableReady = true
end

function GrimUpsertBabyProfileFromPregnancyRow(row)
    GrimEnsureBabyProfileTable()

    if type(row) ~= 'table' or tonumber(row.born or 0) ~= 1 then
        return nil
    end

    local pregnancyId = tonumber(row.id)
    local childId = ('GLM-%06d'):format(pregnancyId or os.time())
    local motherName = GetCitizenName(row.cid)
    local fatherName = GetCitizenName(row.partner_cid)
    local existing = pregnancyId and MySQL.single.await('SELECT id FROM grim_lm_baby_profiles WHERE pregnancy_id = ? LIMIT 1', { pregnancyId }) or nil

    local params = {
        childId,
        row.cid or '',
        row.partner_cid or '',
        motherName,
        fatherName,
        row.birth_at or os.date('%Y-%m-%d %H:%M:%S'),
        tonumber(row.dna_confirmed or 0) == 1 and 1 or 0,
        tonumber(row.child_support_paid or 0) == 1 and 1 or 0,
        tonumber(row.child_support_amount or 0) or 0,
        row.child_support_paid_at or nil,
        row.gender or 'unknown',
    }

    if existing and existing.id then
        params[#params + 1] = tonumber(existing.id)
        MySQL.update.await([[
            UPDATE grim_lm_baby_profiles
            SET child_id=?, mother_citizenid=?, father_citizenid=?, mother_name=?, father_name=?,
                birth_timestamp=?, dna_confirmed=?, child_support_claimed=?, child_support_amount=?,
                child_support_claimed_at=?, gender=?
            WHERE id=?
        ]], params)
        return tonumber(existing.id)
    end

    table.insert(params, 1, pregnancyId)
    return MySQL.insert.await([[
        INSERT INTO grim_lm_baby_profiles (
            pregnancy_id, child_id, mother_citizenid, father_citizenid, mother_name, father_name,
            birth_timestamp, dna_confirmed, child_support_claimed, child_support_amount,
            child_support_claimed_at, gender
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    ]], params)
end

function GrimUpsertBabyProfileFromPregnancyId(pregnancyId)
    if not pregnancyId then
        return nil
    end

    local row = MySQL.single.await('SELECT * FROM grim_lm_pregnancy WHERE id = ? LIMIT 1', { pregnancyId })
    if not row then
        return nil
    end

    return GrimUpsertBabyProfileFromPregnancyRow(row)
end

local function BackfillLegacyBabyProfiles(citizenid)
    local rows = MySQL.query.await([[
        SELECT *
        FROM grim_lm_pregnancy
        WHERE born=1 AND (cid=? OR partner_cid=?)
        ORDER BY birth_at DESC, id DESC
    ]], { citizenid, citizenid }) or {}

    for _, row in ipairs(rows) do
        GrimUpsertBabyProfileFromPregnancyRow(row)
    end
end

local function GetBabyProfiles(citizenid)
    GrimEnsureBabyProfileTable()

    if not citizenid then
        return {}
    end

    local rows = MySQL.query.await([[
        SELECT *
        FROM grim_lm_baby_profiles
        WHERE mother_citizenid=? OR father_citizenid=?
        ORDER BY birth_timestamp DESC, id DESC
    ]], { citizenid, citizenid }) or {}

    if #rows == 0 then
        BackfillLegacyBabyProfiles(citizenid)
        rows = MySQL.query.await([[
            SELECT *
            FROM grim_lm_baby_profiles
            WHERE mother_citizenid=? OR father_citizenid=?
            ORDER BY birth_timestamp DESC, id DESC
        ]], { citizenid, citizenid }) or {}
    end

    local profiles = {}
    for _, row in ipairs(rows) do
        profiles[#profiles + 1] = {
            id = tonumber(row.id),
            pregnancyId = tonumber(row.pregnancy_id),
            childId = row.child_id,
            childName = ('Baby %s'):format(row.child_id or row.id),
            gender = row.gender or 'unknown',
            motherCitizenId = row.mother_citizenid,
            fatherCitizenId = row.father_citizenid,
            motherName = row.mother_name ~= '' and row.mother_name or GetCitizenName(row.mother_citizenid),
            fatherName = row.father_name ~= '' and row.father_name or GetCitizenName(row.father_citizenid),
            birthTimestamp = GrimDateTimeToString(row.birth_timestamp),
            dnaConfirmed = tonumber(row.dna_confirmed or 0) == 1,
            childSupportClaimed = tonumber(row.child_support_claimed or 0) == 1,
            childSupportAmount = tonumber(row.child_support_amount or 0) or 0,
            childSupportClaimedAt = GrimDateTimeToString(row.child_support_claimed_at),
        }
    end

    return profiles
end

local function GetPlayerFundsByCitizenId(citizenid, childSupportConfig)
    local cfg = childSupportConfig or GetChildSupportConfig()
    local onlineSrc = GetSrcByCID(citizenid)
    if onlineSrc then
        local cash = cfg.includeCash and GetMoney(onlineSrc, 'cash') or 0
        local bank = cfg.includeBank and GetMoney(onlineSrc, 'bank') or 0
        local dirty = 0

        if cfg.includeBlack then
            if cfg.blackType == 'account' then
                dirty = GetMoney(onlineSrc, cfg.blackName)
            elseif GetResourceState('ox_inventory') == 'started' and cfg.blackName and cfg.blackName ~= '' then
                dirty = tonumber(exports.ox_inventory:GetItemCount(onlineSrc, cfg.blackName) or 0) or 0
            end
        end

        return {
            online = true,
            serverId = onlineSrc,
            cash = cash,
            bank = bank,
            dirty = dirty,
            total = cash + bank + dirty,
        }
    end

    local record = GetOfflineQBRecord(citizenid)
    if not record then
        return {
            online = false,
            serverId = nil,
            cash = 0,
            bank = 0,
            dirty = 0,
            total = 0,
        }
    end

    local money = DecodeJsonValue(record.money)
    local cash = cfg.includeCash and (tonumber(money.cash) or 0) or 0
    local bank = cfg.includeBank and (tonumber(money.bank) or 0) or 0
    local dirty = 0

    if cfg.includeBlack and cfg.blackType == 'account' then
        dirty = tonumber(money[cfg.blackName]) or 0
    end

    return {
        online = false,
        serverId = nil,
        cash = cash,
        bank = bank,
        dirty = dirty,
        total = cash + bank + dirty,
    }
end

local function RefundOnlineDeductions(serverId, refunds)
    for _, refund in ipairs(refunds) do
        if refund.kind == 'item' then
            GiveItem(serverId, refund.name, refund.amount)
        else
            AddMoney(serverId, refund.amount, refund.name)
        end
    end
end

local function DeductFundsFromCitizenId(citizenid, amount, childSupportConfig)
    local cfg = childSupportConfig or GetChildSupportConfig()
    local targetAmount = math.floor(tonumber(amount) or 0)
    if targetAmount <= 0 then
        return false, 0
    end

    local funds = GetPlayerFundsByCitizenId(citizenid, cfg)
    if funds.total < targetAmount then
        return false, 0
    end

    if funds.online and funds.serverId then
        local refunds = {}
        local remaining = targetAmount

        local function takeAccount(accountName, availableAmount)
            if remaining <= 0 or availableAmount <= 0 then
                return true
            end

            local takeAmount = math.min(availableAmount, remaining)
            if not RemoveMoney(funds.serverId, takeAmount, accountName) then
                return false
            end

            refunds[#refunds + 1] = { kind = 'account', name = accountName, amount = takeAmount }
            remaining = remaining - takeAmount
            return true
        end

        local function takeItem(itemName, availableAmount)
            if remaining <= 0 or availableAmount <= 0 then
                return true
            end

            local takeAmount = math.min(availableAmount, remaining)
            if not RemoveItem(funds.serverId, itemName, takeAmount) then
                return false
            end

            refunds[#refunds + 1] = { kind = 'item', name = itemName, amount = takeAmount }
            remaining = remaining - takeAmount
            return true
        end

        if cfg.includeCash and not takeAccount('cash', funds.cash or 0) then
            RefundOnlineDeductions(funds.serverId, refunds)
            return false, 0
        end

        if cfg.includeBank and not takeAccount('bank', funds.bank or 0) then
            RefundOnlineDeductions(funds.serverId, refunds)
            return false, 0
        end

        if cfg.includeBlack then
            local ok = true
            if cfg.blackType == 'account' then
                ok = takeAccount(cfg.blackName, funds.dirty or 0)
            elseif cfg.blackName and cfg.blackName ~= '' then
                ok = takeItem(cfg.blackName, funds.dirty or 0)
            end

            if not ok then
                RefundOnlineDeductions(funds.serverId, refunds)
                return false, 0
            end
        end

        if remaining > 0 then
            RefundOnlineDeductions(funds.serverId, refunds)
            return false, 0
        end

        return true, targetAmount
    end

    local record = GetOfflineQBRecord(citizenid)
    if not record then
        return false, 0
    end

    local money = DecodeJsonValue(record.money)
    local remaining = targetAmount

    local function takeOffline(fieldName)
        if remaining <= 0 then
            return
        end

        local available = tonumber(money[fieldName]) or 0
        if available <= 0 then
            return
        end

        local takeAmount = math.min(available, remaining)
        money[fieldName] = available - takeAmount
        remaining = remaining - takeAmount
    end

    if cfg.includeCash then
        takeOffline('cash')
    end

    if cfg.includeBank then
        takeOffline('bank')
    end

    if cfg.includeBlack and cfg.blackType == 'account' then
        takeOffline(cfg.blackName)
    end

    if remaining > 0 then
        return false, 0
    end

    MySQL.update.await('UPDATE players SET money = ? WHERE citizenid = ?', {
        json.encode(money),
        citizenid,
    })

    return true, targetAmount
end

local function NormalisePregnancyRow(row, src)
    if type(row) ~= 'table' then
        return false
    end

    local pregnancyDuration = type(GrimGetPregnancyDurationForSource) == 'function'
        and GrimGetPregnancyDurationForSource(src)
        or (type(GetPregnancyDurationConfig) == 'function' and GetPregnancyDurationConfig() or nil)
    local totalSeconds = (pregnancyDuration and pregnancyDuration.totalSeconds) or (7 * 86400)

    local birthAt   = DateTimeToString(row.birth_at)
    local birthUnix = birthAt and ParseDateTimeToUnix(birthAt) or nil

    local conceivedAt   = DateTimeToString(row.conceived_at)
    local conceivedUnix = conceivedAt and ParseDateTimeToUnix(conceivedAt) or nil

    -- Recover conceived_at from birth_at when missing
    if not conceivedUnix and birthUnix then
        conceivedUnix = birthUnix - totalSeconds
        conceivedAt   = os.date('%Y-%m-%d %H:%M:%S', conceivedUnix)
    end

    -- Recover birth_at from conceived_at when missing
    if not birthUnix and conceivedUnix then
        birthUnix = conceivedUnix + totalSeconds
        birthAt   = os.date('%Y-%m-%d %H:%M:%S', birthUnix)
    end

    local birthReady = birthUnix ~= nil and os.time() >= birthUnix

    return {
        id              = tonumber(row.id),
        citizenId       = row.cid,
        fatherCitizenId = row.partner_cid,
        gender          = row.gender,
        conceivedAt     = conceivedAt,
        birthAt         = birthAt,
        born            = tonumber(row.born or 0) == 1,
        birthReady      = birthReady,
        dnaConfirmed    = tonumber(row.dna_confirmed or 0) == 1,
    }
end

local function GetRegisteredPartners(citizenid)
    local rows = MySQL.query.await([[
        SELECT cid_a, cid_b, registered_at
        FROM grim_lm_partners
        WHERE cid_a=? OR cid_b=?
        ORDER BY registered_at DESC
    ]], { citizenid, citizenid }) or {}

    local partners = {}
    for _, row in ipairs(rows) do
        local partnerCitizenId = row.cid_a == citizenid and row.cid_b or row.cid_a
        local partnerSrc = GetSrcByCID(partnerCitizenId)
        partners[#partners + 1] = {
            cid = partnerCitizenId,
            serverId = partnerSrc,
            name = partnerSrc and GetCharName(partnerSrc) or GetCitizenName(partnerCitizenId),
            online = partnerSrc ~= nil,
            registeredAt = GrimDateTimeToString(row.registered_at),
        }
    end

    return partners
end

local function GetSelectedPartnerState(src, citizenid)
    local selectedServerId = SelectedPartners[tonumber(src)]
    if not selectedServerId then
        return false
    end

    selectedServerId = tonumber(selectedServerId)
    if not selectedServerId or not IsPlayerOnline(selectedServerId) then
        SelectedPartners[tonumber(src)] = nil
        return false
    end

    local partnerCitizenId = GetPlayerCID(selectedServerId)
    if not partnerCitizenId or partnerCitizenId == citizenid then
        SelectedPartners[tonumber(src)] = nil
        return false
    end

    return {
        cid = partnerCitizenId,
        serverId = selectedServerId,
        name = GetCharName(selectedServerId),
        online = true,
        selected = true,
    }
end

local function GetOnlinePlayersFor(src, citizenid)
    local players = {}
    src = tonumber(src)
    for _, playerSrc in ipairs(GetPlayers()) do
        playerSrc = tonumber(playerSrc)
        if playerSrc and playerSrc ~= src then
            local playerCitizenId = GetPlayerCID(playerSrc)
            if playerCitizenId and playerCitizenId ~= citizenid then
                players[#players + 1] = {
                    cid = playerCitizenId,
                    serverId = playerSrc,
                    name = GetCharName(playerSrc),
                    online = true,
                }
            end
        end
    end

    table.sort(players, function(left, right)
        return tostring(left.name or '') < tostring(right.name or '')
    end)

    return players
end

local function BuildChildSupportCases(src, citizenid)
    local profiles = GetBabyProfiles(citizenid)
    local cfg = GetChildSupportConfig()
    local cases = {}
    local readyCount = 0
    local completedCount = 0

    for _, profile in ipairs(profiles) do
        local playerIsMother = profile.motherCitizenId == citizenid
        local funds = GetPlayerFundsByCitizenId(profile.fatherCitizenId, cfg)
        local amount = math.floor((funds.total or 0) * cfg.percent)
        local claimed = profile.childSupportClaimed == true
        local birthConfirmed = profile.birthTimestamp ~= nil
        local eligible = false
        local reason = 'Unavailable'
        local state = 'locked'

        if not cfg.enabled then
            reason = 'Child support is disabled.'
        elseif not playerIsMother then
            reason = 'Only the mother can claim child support.'
        elseif not HasChildSupportRoleAccess(src) then
            reason = 'You are not allowed to use child support.'
        elseif cfg.requireBirth and not birthConfirmed then
            reason = 'Birth confirmation is required first.'
        elseif cfg.requireDNA and not profile.dnaConfirmed then
            reason = 'DNA confirmation is required first.'
        elseif cfg.oneTimeOnly and claimed then
            reason = 'Child support already claimed.'
            state = 'completed'
        elseif cfg.requireFatherOnline and not funds.online then
            reason = 'Father must be online to process payment.'
        elseif amount < 1 then
            reason = 'No eligible funds are available.'
        else
            eligible = true
            reason = 'Ready to claim.'
            state = 'ready'
        end

        if eligible then
            readyCount = readyCount + 1
        end

        if claimed then
            completedCount = completedCount + 1
        end

        cases[#cases + 1] = {
            id = profile.id,
            pregnancyId = profile.pregnancyId,
            childId = profile.childId,
            childName = profile.childName,
            gender = profile.gender,
            motherCitizenId = profile.motherCitizenId,
            fatherCitizenId = profile.fatherCitizenId,
            motherName = profile.motherName,
            fatherName = profile.fatherName,
            birthTimestamp = profile.birthTimestamp,
            dnaConfirmed = profile.dnaConfirmed,
            birthConfirmed = birthConfirmed,
            childSupportClaimed = claimed,
            childSupportAmount = profile.childSupportAmount,
            childSupportClaimedAt = profile.childSupportClaimedAt,
            amount = claimed and (profile.childSupportAmount or 0) or amount,
            eligible = eligible,
            state = state,
            reason = reason,
            fatherOnline = funds.online,
            fatherServerId = funds.serverId,
            cash = funds.cash or 0,
            bank = funds.bank or 0,
            dirty = funds.dirty or 0,
            percent = math.floor(cfg.percent * 100),
            includeDirty = cfg.includeBlack == true,
        }
    end

    return cases, {
        total = #cases,
        ready = readyCount,
        completed = completedCount,
        percent = math.floor(cfg.percent * 100),
    }
end

local function BuildTabletSettingsPayload(src)
    local pregnancyConfig = Config.Pregnancy or {}
    local pharmacyConfig = Config.Pharmacy or {}
    local pregnancyDuration = type(GrimGetPregnancyDurationForSource) == 'function'
        and GrimGetPregnancyDurationForSource(src)
        or (type(GetPregnancyDurationConfig) == 'function' and GetPregnancyDurationConfig() or {
            days = tonumber(Config.PregnancyDuration or 7) or 7,
            hours = tonumber(Config.PregnancyDurationHours or 0) or 0,
            maxDays = tonumber(Config.PregnancyMaxDuration or 30) or 30,
        })

    return {
        pregnancy = {
            allowed = GrimHasRoleWhitelistAccess(src, pregnancyConfig.RoleWhitelist),
            durationDays = pregnancyDuration.days or 7,
            durationHours = pregnancyDuration.hours or 0,
            maxDurationDays = pregnancyDuration.maxDays or tonumber(pregnancyConfig.MaxDurationDays or Config.PregnancyMaxDuration or 30) or 30,
            vitaminDoseHours = tonumber(pregnancyConfig.VitaminDoseHours or Config.VitaminDoseHours or 3) or 3,
            vitaminReminderHours = tonumber(pregnancyConfig.VitaminReminderHours or Config.VitaminReminderHours or 3) or 3,
            vitaminRiskReduction = tonumber(pregnancyConfig.VitaminRiskReduction or Config.VitaminRiskReduction or 5) or 5,
        },
        pharmacy = {
            enabled = pharmacyConfig.Enabled ~= false,
            allowed = GrimHasRoleWhitelistAccess(src, pharmacyConfig.RoleWhitelist),
        },
    }
end

local function BuildAppStatePayload(data)
    local pregnancyState = 'ready'
    local pregnancySubtitle = 'Track your cycle, DNA, and delivery.'
    local pregnancySettings = data.settings and data.settings.pregnancy or {}
    local pharmacySettings = data.settings and data.settings.pharmacy or {}

    if not data.pregnancy and pregnancySettings.allowed == false then
        pregnancyState = 'locked'
        pregnancySubtitle = 'Pregnancy access is locked for your current role.'
    elseif data.pregnancy and data.pregnancy.birthReady then
        pregnancyState = 'completed'
        pregnancySubtitle = 'Birth is ready now.'
    elseif data.pregnancy then
        pregnancyState = 'ready'
        pregnancySubtitle = 'Pregnancy is active.'
    end

    local childSupportState = 'locked'
    local childSupportSubtitle = 'DNA and birth records are required.'
    local childSupportSummary = data.childSupportSummary or {}
    if (childSupportSummary.ready or 0) > 0 then
        childSupportState = 'ready'
        childSupportSubtitle = ('%s claim%s ready.'):format(childSupportSummary.ready, childSupportSummary.ready == 1 and '' or 's')
    elseif (childSupportSummary.total or 0) > 0 and (childSupportSummary.completed or 0) == (childSupportSummary.total or 0) then
        childSupportState = 'completed'
        childSupportSubtitle = 'All child support has been claimed.'
    elseif (childSupportSummary.total or 0) > 0 then
        childSupportState = 'locked'
        childSupportSubtitle = 'Cases exist but are still locked.'
    end

    local babyProfiles = data.babyProfiles or {}
    local babyState = 'locked'
    local babySubtitle = 'Baby profiles unlock after birth.'
    if #babyProfiles > 0 then
        local fullyProcessed = true
        for _, profile in ipairs(babyProfiles) do
            if not profile.dnaConfirmed or not profile.childSupportClaimed then
                fullyProcessed = false
                break
            end
        end

        babyState = fullyProcessed and 'completed' or 'ready'
        babySubtitle = ('%s baby profile%s synced.'):format(#babyProfiles, #babyProfiles == 1 and '' or 's')
    end

    return {
        pregnancy = {
            state = pregnancyState,
            subtitle = pregnancySubtitle,
        },
        pharmacy = {
            state = pharmacySettings.enabled == false and 'locked' or (pharmacySettings.allowed == false and 'locked' or 'ready'),
            subtitle = pharmacySettings.enabled == false and 'Pharmacy access is disabled in config.' or (pharmacySettings.allowed == false and 'Pharmacy access is locked for your current role.' or 'Medication, tests, and supplies are ready.'),
        },
        brocode = {
            state = 'ready',
            subtitle = 'Live posts, replies, and media.',
        },
        childSupport = {
            state = childSupportState,
            subtitle = childSupportSubtitle,
        },
        babyProfiles = {
            state = babyState,
            subtitle = babySubtitle,
        },
    }
end

local function BuildTabletPayload(src)
    local citizenid = GetPlayerCID(src)
    if not citizenid then
        return nil
    end

        local registeredPartners = GetRegisteredPartners(citizenid)
    local payload = {
        charName = GetCharName(src),
        tablet = {
            soundDebounceMs = Config.Tablet and Config.Tablet.SoundDebounceMs or 90,
            themeOrder = Config.ThemeOrder or { 'dark', 'pink', 'green', 'purple', 'teal' },
        },
        settings = BuildTabletSettingsPayload(src),
        pregnancy = NormalisePregnancyRow(GrimGetActivePregnancy(citizenid), src),
        std = (function()
            local rows = MySQL.query.await('SELECT * FROM grim_lm_std WHERE cid=? AND cured=0', { citizenid }) or {}
            -- Enrich with human-readable label from Config.Diseases
            for _, row in ipairs(rows) do
                if not row.label then
                    for _, d in ipairs(Config.Diseases or {}) do
                        if d.id == row.disease_id then
                            row.label = d.label
                            row.curable = d.curable
                            break
                        end
                    end
                end
            end
            return rows
        end)(),
        contraception = (function()
            local v = MySQL.single.await('SELECT expires_at FROM grim_lm_contraception WHERE cid=? AND expires_at>NOW()', { citizenid })
            if not v then return nil end
            return { expires_at = DateTimeToString(v.expires_at) }
        end)(),
        condom = (function()
            local v = MySQL.single.await('SELECT expires_at FROM grim_lm_condoms WHERE cid=? AND expires_at>NOW()', { citizenid })
            if not v then return nil end
            return { expires_at = DateTimeToString(v.expires_at) }
        end)(),
        vitamins = (function()
            local v = MySQL.single.await('SELECT expires_at FROM grim_lm_vitamins WHERE cid=? AND expires_at>NOW()', { citizenid })
            if not v then return nil end
            local converted = DateTimeToString(v.expires_at)
            return { expires_at = converted }
        end)(),
        registeredPartners = registeredPartners,
        onlinePlayers = GetOnlinePlayersFor(src, citizenid),
        partnerState = registeredPartners[1] or nil,
        selectedPartnerState = GetSelectedPartnerState(src, citizenid),
        babyProfiles = GetBabyProfiles(citizenid),
    }

    payload.childSupportCases, payload.childSupportSummary = BuildChildSupportCases(src, citizenid)
    payload.apps = BuildAppStatePayload(payload)
    return payload
end

function GrimSendTabletData(src)
    local payload = BuildTabletPayload(src)
    if payload then
        TriggerClientEvent('grim_lovemenu:cl:receiveMyData', src, payload)
    end
end

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then
        return
    end

    CreateThread(function()
        GrimEnsureBabyProfileTable()
        pcall(function()
            MySQL.query.await([[
                ALTER TABLE `grim_lm_pregnancy`
                    ADD COLUMN IF NOT EXISTS `dna_confirmed` TINYINT(1) NOT NULL DEFAULT 0,
                    ADD COLUMN IF NOT EXISTS `child_support_paid` TINYINT(1) NOT NULL DEFAULT 0,
                    ADD COLUMN IF NOT EXISTS `child_support_amount` INT NOT NULL DEFAULT 0,
                    ADD COLUMN IF NOT EXISTS `child_support_paid_at` DATETIME NULL;
            ]])
        end)
    end)
end)

-- Explicitly whitelist all client-triggered events
RegisterNetEvent('grim_lovemenu:sv:getMyData')
RegisterNetEvent('grim_lovemenu:sv:getChildSupportStatus')
RegisterNetEvent('grim_lovemenu:sv:claimChildSupport')
RegisterNetEvent('grim_lovemenu:sv:buyPharmacyItem')

RegisterServerEvent('grim_lovemenu:sv:getMyData', function()
    GrimSendTabletData(source)
end)

RegisterServerEvent('grim_lovemenu:sv:getChildSupportStatus', function()
    GrimSendTabletData(source)
end)

RegisterServerEvent('grim_lovemenu:sv:claimChildSupport', function(profileId)
    local src = source
    local citizenid = GetPlayerCID(src)
    if not citizenid then
        return
    end

    profileId = tonumber(profileId)
    local cases = BuildChildSupportCases(src, citizenid)
    local selectedCase

    for _, caseData in ipairs(cases) do
        if profileId and caseData.id == profileId then
            selectedCase = caseData
            break
        end

        if not profileId and not selectedCase and caseData.eligible then
            selectedCase = caseData
        end
    end

    if not selectedCase then
        Notify(src, 'No child support case was found.', 'error')
        GrimSendTabletData(src)
        return
    end

    if not selectedCase.eligible then
        Notify(src, selectedCase.reason or 'Child support is still locked.', 'error')
        GrimSendTabletData(src)
        return
    end

    local cfg = GetChildSupportConfig()
    local success, payoutAmount = DeductFundsFromCitizenId(selectedCase.fatherCitizenId, selectedCase.amount, cfg)
    if not success or payoutAmount < 1 then
        Notify(src, 'Payment could not be processed.', 'error')
        GrimSendTabletData(src)
        return
    end

    if not AddMoney(src, payoutAmount, cfg.payToAccount) then
        Notify(src, 'Payment failed to reach your account.', 'error')
        GrimSendTabletData(src)
        return
    end

    MySQL.update.await([[
        UPDATE grim_lm_baby_profiles
        SET child_support_claimed=1, child_support_amount=?, child_support_claimed_at=NOW()
        WHERE id=?
    ]], {
        payoutAmount,
        selectedCase.id,
    })

    if selectedCase.pregnancyId then
        MySQL.update.await([[
            UPDATE grim_lm_pregnancy
            SET child_support_paid=1, child_support_amount=?, child_support_paid_at=NOW()
            WHERE id=?
        ]], {
            payoutAmount,
            selectedCase.pregnancyId,
        })
    end

    Notify(src, ('Child support deposited: $%s'):format(payoutAmount), 'success')
    if selectedCase.fatherServerId then
        Notify(selectedCase.fatherServerId, ('Child support deducted: $%s'):format(payoutAmount), 'inform')
    end

    GrimSendTabletData(src)
    if selectedCase.fatherServerId then
        GrimSendTabletData(selectedCase.fatherServerId)
    end
end)

RegisterServerEvent('grim_lovemenu:sv:buyPharmacyItem', function(itemKey, paymentMethod)
    local src = source
    local citizenid = GetPlayerCID(src)
    if not citizenid then return end

    local pharmacyConfig = Config.Pharmacy or {}
    if pharmacyConfig.Enabled == false then
        Notify(src, 'Pharmacy access is disabled in config.', 'error'); return
    end
    if not GrimHasRoleWhitelistAccess(src, pharmacyConfig.RoleWhitelist) then
        Notify(src, 'You are not allowed to use this pharmacy.', 'error'); return
    end

    local entry
    for _, p in ipairs(Config.PharmacyItems) do
        if p.item == itemKey then entry = p; break end
    end
    if not entry then
        Notify(src, 'Invalid item.', 'error'); return
    end

    local account = paymentMethod == 'bank' and 'bank' or 'cash'
    if not RemoveMoney(src, entry.price, account) then
        Notify(src, ('Not enough %s. Need $%d.'):format(account, entry.price), 'error'); return
    end

    if not GiveItem(src, entry.item, entry.amount) then
        AddMoney(src, entry.price, account)
        print(('[grim_lovemenu] GiveItem failed for item=%s - check ox_inventory registration'):format(tostring(entry.item)))
        Notify(src, ('Purchase failed. %s is not set up in ox_inventory.'):format(entry.label), 'error'); return
    end

    Notify(src, ('Purchased %s for $%d.'):format(entry.label, entry.price), 'success')
    GrimSendTabletData(src)
end)
AddEventHandler('grim_lovemenu:sv:refreshClient', function(src)
    GrimSendTabletData(src)
end)
