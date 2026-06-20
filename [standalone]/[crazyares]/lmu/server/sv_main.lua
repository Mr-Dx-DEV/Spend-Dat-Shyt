-- -
--  SERVER MAIN  - Grim Development | Love Menu
-- -

local Framework = nil
SelectedPartners = SelectedPartners or {}

-- Whitelist all events that clients are allowed to trigger
RegisterNetEvent('grim_lovemenu:sv:getMyData')
RegisterNetEvent('grim_lovemenu:sv:getChildSupportStatus')
RegisterNetEvent('grim_lovemenu:sv:claimChildSupport')
RegisterNetEvent('grim_lovemenu:sv:buyPharmacyItem')
RegisterNetEvent('grim_lovemenu:sv:useItem')
RegisterNetEvent('grim_lovemenu:sv:useDNATest')
RegisterNetEvent('grim_lovemenu:sv:requestAnim')
RegisterNetEvent('grim_lovemenu:sv:acceptAnim')
RegisterNetEvent('grim_lovemenu:sv:declineAnim')
RegisterNetEvent('grim_lovemenu:sv:animFinished')
RegisterNetEvent('grim_lovemenu:sv:setSelectedPartner')
RegisterNetEvent('grim_lovemenu:sv:registerPartner')
RegisterNetEvent('grim_lovemenu:sv:acceptPartnerReg')
RegisterNetEvent('grim_lovemenu:sv:declinePartnerReg')
RegisterNetEvent('grim_lovemenu:sv:requestUnregister')
RegisterNetEvent('grim_lovemenu:sv:acceptUnregister')
RegisterNetEvent('grim_lovemenu:sv:declineUnregister')
RegisterNetEvent('grim_lovemenu:sv:requestUltrasound')
RegisterNetEvent('grim_lovemenu:sv:giveBirth')
RegisterNetEvent('grim_lovemenu:sv:viewUltrasound')

-- - HELPERS -

-- Global datetime helper: converts oxmysql DATETIME (string, number, or table) to ISO string.
-- oxmysql returns DATETIME columns as Lua tables on modern builds e.g. {year=2026,month=4,...}
function GrimDateTimeToString(value)
    if not value then return nil end
    if type(value) == 'string' and value ~= '' then
        -- Strip ISO T separator and timezone suffix if present
        local s = value:gsub('T', ' '):gsub('%.[0-9]+Z?$', ''):gsub('Z$', '')
        if s:match('^%d%d%d%d%-%d%d%-%d%d') then return s end
        return nil
    end
    if type(value) == 'number' then
        -- oxmysql returns DATETIME as millisecond timestamps (Unix * 1000)
        -- A value > 1e10 is milliseconds; divide by 1000 to get seconds
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
    return nil
end

function GetPlayerCID(src)
    src = tonumber(src)
    if not src or src <= 0 then return nil end
    local identifiers = GetPlayerIdentifiers(src)
    if not identifiers then return tostring(src) end
    local preferred = { 'license:', 'fivem:', 'discord:', 'steam:' }
    for _, prefix in ipairs(preferred) do
        for _, id in ipairs(identifiers) do
            if id:sub(1, #prefix) == prefix then
                return id
            end
        end
    end
    return identifiers[1] or tostring(src)
end

function GetCharName(src)
    src = tonumber(src)
    if not src or src <= 0 then return 'Unknown' end
    return GetPlayerName(src) or ('Player ' .. tostring(src))
end

function Notify(src, msg, ntype)
    src = tonumber(src)
    if not src or src <= 0 then return end
    TriggerClientEvent('grim_lovemenu:cl:notify', src, msg, ntype or 'primary')
end

function HasItem(src, item, amount)
    amount = amount or 1
    src = tonumber(src)
    if not src then return false end
    if GetResourceState('ox_inventory') == 'started' then
        local count = exports.ox_inventory:GetItemCount(src, item)
        return (count or 0) >= amount
    end
    return false
end

function RemoveItem(src, item, amount)
    amount = amount or 1
    src = tonumber(src)
    if not src then return false end
    if GetResourceState('ox_inventory') == 'started' then
        return exports.ox_inventory:RemoveItem(src, item, amount) ~= false
    end
    return false
end

function GiveItem(src, item, amount, metadata)
    amount = amount or 1
    src = tonumber(src)
    if not src then return false end
    if GetResourceState('ox_inventory') == 'started' then
        local added = exports.ox_inventory:AddItem(src, item, amount, metadata)
        if not added and Config.DebugPrint then
            print(('^1[grim_lovemenu]^7 GiveItem FAILED: item "%s" not registered in ox_inventory/data/items.lua'):format(item))
        end
        return added ~= false
    end
    return false
end

local function RemoveMoneyFrameworkFallback(src, amount, account)
    account = account or 'cash'

    if Config.Framework == 'qb-core' and GetResourceState('qb-core') == 'started' then
        local ok, core = pcall(function() return exports['qb-core']:GetCoreObject() end)
        if ok and core and core.Functions then
            local player = core.Functions.GetPlayer(src)
            if player and player.Functions and player.Functions.RemoveMoney then
                return player.Functions.RemoveMoney(account == 'bank' and 'bank' or 'cash', amount, 'grim_lovemenu') == true
            end
        end
    elseif Config.Framework == 'qbx' and GetResourceState('qbx_core') == 'started' then
        local ok, qbx = pcall(function() return exports.qbx_core end)
        if ok and qbx and qbx.GetPlayer then
            local player = qbx:GetPlayer(src)
            if player and player.Functions and player.Functions.RemoveMoney then
                return player.Functions.RemoveMoney(account == 'bank' and 'bank' or 'cash', amount, 'grim_lovemenu') == true
            end
            if player and player.RemoveMoney then
                return player:RemoveMoney(account == 'bank' and 'bank' or 'cash', amount, 'grim_lovemenu') == true
            end
        end
    elseif Config.Framework == 'esx' and GetResourceState('es_extended') == 'started' then
        local ok, esx = pcall(function() return exports['es_extended']:getSharedObject() end)
        if ok and esx and esx.GetPlayerFromId then
            local xPlayer = esx.GetPlayerFromId(src)
            if xPlayer then
                if account == 'bank' and xPlayer.removeAccountMoney then
                    local current = xPlayer.getAccount and xPlayer.getAccount('bank')
                    local bal = current and (current.money or current.balance) or 0
                    if bal >= amount then
                        xPlayer.removeAccountMoney('bank', amount)
                        return true
                    end
                elseif account ~= 'bank' and xPlayer.removeMoney then
                    local bal = xPlayer.getMoney and xPlayer.getMoney() or 0
                    if bal >= amount then
                        xPlayer.removeMoney(amount)
                        return true
                    end
                end
            end
        end
    end

    return false
end

function RemoveMoney(src, amount, account)
    account = account or 'cash'
    src = tonumber(src)
    if not src then return false end

    if GetResourceState('ox_inventory') == 'started' then
        if account == 'cash' then
            -- Try 'cash' first (QBCore/QBX), then 'money' fallback
            local cashCount = exports.ox_inventory:GetItemCount(src, 'cash') or 0
            if cashCount >= amount then
                exports.ox_inventory:RemoveItem(src, 'cash', amount)
                return true
            end
            local moneyCount = exports.ox_inventory:GetItemCount(src, 'money') or 0
            if moneyCount >= amount then
                exports.ox_inventory:RemoveItem(src, 'money', amount)
                return true
            end
        else
            local itemName = account == 'bank' and 'bank' or account
            local count = exports.ox_inventory:GetItemCount(src, itemName)
            if (count or 0) >= amount then
                exports.ox_inventory:RemoveItem(src, itemName, amount)
                return true
            end
        end
    end

    return RemoveMoneyFrameworkFallback(src, amount, account)
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
        requireFatherOnline = cfg.RequireFatherOnline ~= false,
        payoutItem = cfg.PayoutItem or 'bank',
        roleLock = cfg.RoleLock or {},
    }
end


local function GetLiquidFunds(src)
    src = tonumber(src)
    if not src then return { cash = 0, bank = 0, dirty = 0, total = 0 } end

    local cash = 0
    local bank = 0
    local dirty = 0
    local cs = GetChildSupportConfig()

    if GetResourceState('ox_inventory') == 'started' then
        if cs.includeCash then
            local cashCount  = exports.ox_inventory:GetItemCount(src, 'cash')  or 0
            local moneyCount = exports.ox_inventory:GetItemCount(src, 'money') or 0
            cash = cashCount + moneyCount
        end
        bank = cs.includeBank and (exports.ox_inventory:GetItemCount(src, 'bank') or 0) or 0
        if cs.includeBlack and cs.blackType == 'item' and cs.blackName and cs.blackName ~= '' then
            dirty = exports.ox_inventory:GetItemCount(src, cs.blackName) or 0
        end
    end

    if cs.includeBlack and cs.blackType == 'account' then
        dirty = GetMoney(src, cs.blackName) or 0
    end

    return { cash = cash, bank = bank, dirty = dirty, total = cash + bank + dirty }
end

local function HasChildSupportRoleAccess(src)
    local cs = GetChildSupportConfig()
    local rl = cs.roleLock or {}
    if not rl.Enabled then return true end

    local pdata = GetPlayerData(src) or {}
    local citizenid = pdata.citizenid or GetPlayerCID(src)
    local jobName = (pdata.job and (pdata.job.name or pdata.job)) or nil
    local gangName = (pdata.gang and (pdata.gang.name or pdata.gang)) or nil

    if rl.UseCitizenIds and citizenid and rl.AllowedCitizenIds and rl.AllowedCitizenIds[citizenid] then
        return true
    end
    if rl.UseJobs and jobName and rl.AllowedJobs and rl.AllowedJobs[jobName] then
        return true
    end
    if rl.UseGangs and gangName and rl.AllowedGangs and rl.AllowedGangs[gangName] then
        return true
    end

    return false
end

local function GetBabyProfiles(cid)
    if not cid then return {} end
    local rows = MySQL.query.await([[
        SELECT id, cid, partner_cid, gender, birth_at, dna_confirmed, child_support_paid, child_support_amount
        FROM grim_lm_pregnancy
        WHERE cid=? AND born=1
        ORDER BY birth_at DESC, id DESC
    ]], {cid}) or {}

    local list = {}
    for i, row in ipairs(rows) do
        local profileId = tonumber(row.id or i)
        list[#list+1] = {
            id = profileId,
            childName = ('Baby #%s'):format(profileId),
            birthAt = GrimDateTimeToString(row.birth_at) or 'Unknown',
            motherCid = row.cid,
            fatherCid = row.partner_cid,
            fatherName = row.partner_cid and 'Linked by DNA' or 'Unknown',
            dnaConfirmed = tonumber(row.dna_confirmed or 0) == 1,
            supported = tonumber(row.child_support_paid or 0) == 1,
            supportAmount = tonumber(row.child_support_amount or 0) or 0,
            gender = row.gender or 'unknown'
        }
    end
    return list
end

local function BuildChildSupportStatus(src, cid)
    local row = GetLatestChildSupportCase(cid)
    if not row then
        return {
            hasCase = false,
            eligible = false,
            dnaConfirmed = false,
            reason = 'No child support case found yet.',
            amount = 0,
            paid = false,
            fatherName = 'Unknown',
        }
    end

    local fatherSrc = GetSrcByCID(row.partner_cid)
    local funds = fatherSrc and GetLiquidFunds(fatherSrc) or { cash = 0, bank = 0, dirty = 0, total = 0 }
    local cs = GetChildSupportConfig()
    local amount = math.floor((funds.total or 0) * (cs.percent or 0.25))
    local fatherName = fatherSrc and GetCharName(fatherSrc) or 'Unknown'

    local status = {
        hasCase = true,
        caseId = row.id,
        born = tonumber(row.born or 0) == 1,
        dnaConfirmed = tonumber(row.dna_confirmed or 0) == 1,
        paid = tonumber(row.child_support_paid or 0) == 1,
        amount = amount,
        previousAmount = tonumber(row.child_support_amount or 0) or 0,
        paidAt = GrimDateTimeToString(row.child_support_paid_at),
        fatherName = fatherName,
        fatherOnline = fatherSrc ~= nil,
        cash = funds.cash or 0,
        bank = funds.bank or 0,
        dirty = funds.dirty or 0,
        countDirty = cs.includeBlack == true,
        percent = math.floor((cs.percent or 0.25) * 100),
        eligible = false,
        reason = 'Unavailable',
    }

    if not HasChildSupportRoleAccess(src) then
        status.reason = 'You are not allowed to use child support.'
    elseif cs.requireBirth and not status.born then
        status.reason = 'Birth certificate must exist before child support can be claimed.'
    elseif cs.requireDNA and not status.dnaConfirmed then
        status.reason = 'DNA test required before claiming child support.'
    elseif status.paid then
        status.eligible = false
        status.reason = 'Child support already paid.'
        status.amount = status.previousAmount
    elseif cs.requireFatherOnline and not status.fatherOnline then
        status.reason = 'Father must be online to process payment.'
    elseif amount < 1 then
        status.reason = 'No available funds to collect.'
    else
        status.eligible = true
        status.reason = 'Eligible now.'
    end

    return status
end

function IsPlayerOnline(src)
    src = tonumber(src)
    if not src or src <= 0 then return false end
    for _, s in ipairs(GetPlayers()) do
        if tonumber(s) == src then return true end
    end
    return false
end

function GetSrcByCID(cid)
    for _, src in ipairs(GetPlayers()) do
        if GetPlayerCID(src) == cid then return tonumber(src) end
    end
    return nil
end

local function GetRegisteredPartners(cid)
    local rows = MySQL.query.await([[
        SELECT cid_a, cid_b, registered_at
        FROM grim_lm_partners
        WHERE cid_a=? OR cid_b=?
        ORDER BY registered_at DESC
    ]], {cid, cid}) or {}

    local partners = {}
    for _, row in ipairs(rows) do
        local partnerCID = (row.cid_a == cid) and row.cid_b or row.cid_a
        local partnerSrc = GetSrcByCID(partnerCID)
        partners[#partners+1] = {
            cid = partnerCID,
            serverId = partnerSrc,
            name = partnerSrc and GetCharName(partnerSrc) or 'Offline Partner',
            online = partnerSrc ~= nil,
            registeredAt = row.registered_at,
        }
    end
    return partners
end

local function GetSelectedPartnerState(src, cid)
    local sid = SelectedPartners[tonumber(src)]
    if not sid then return false end
    sid = tonumber(sid)
    if not sid or not IsPlayerOnline(sid) then
        SelectedPartners[tonumber(src)] = nil
        return false
    end
    local partnerCID = GetPlayerCID(sid)
    if not partnerCID or partnerCID == cid then
        SelectedPartners[tonumber(src)] = nil
        return false
    end
    return {
        cid = partnerCID,
        serverId = sid,
        name = GetCharName(sid),
        online = true,
        selected = true,
    }
end


local function GetOnlinePlayersFor(src, cid)
    local list = {}
    src = tonumber(src)
    for _, playerSrc in ipairs(GetPlayers()) do
        playerSrc = tonumber(playerSrc)
        if playerSrc and playerSrc ~= src then
            local playerCID = GetPlayerCID(playerSrc)
            if playerCID and playerCID ~= cid then
                list[#list+1] = {
                    cid = playerCID,
                    serverId = playerSrc,
                    name = GetCharName(playerSrc),
                    online = true,
                }
            end
        end
    end
    table.sort(list, function(a, b)
        return tostring(a.name or '') < tostring(b.name or '')
    end)
    return list
end


function GetPlayerCoords(src)
    local ped = GetPlayerPed(src)
    if not ped or ped == 0 then return nil end
    return GetEntityCoords(ped)
end

function ArePlayersClose(srcA, srcB, maxDist)
    srcA = tonumber(srcA)
    srcB = tonumber(srcB)
    if not srcA or not srcB then return false end
    local a = GetPlayerCoords(srcA)
    local b = GetPlayerCoords(srcB)
    if not a or not b then return false end
    return #(a - b) <= (maxDist or Config.MaxDistance or 2.0)
end

-- - REGISTER ox_inventory ITEMS -

-- - ITEM SELF-REGISTRATION -
-- Registers all grim_lovemenu items directly into ox_inventory at runtime.
-- This means items do NOT need to be manually merged into ox_inventory/data/items.lua.
-- Runs when grim_lovemenu starts (if ox_inventory is already up)
-- and also when ox_inventory itself starts (handles restart order edge cases).

local function RegisterGrimItemsWithOxInventory()
    if GetResourceState('ox_inventory') ~= 'started' then return end

    local ok, oxItems = pcall(function()
        return exports.ox_inventory:Items()
    end)

    if not ok or type(oxItems) ~= 'table' then
        -- Older ox_inventory build - fall back to data/items.lua auto-scan only
        if Config.DebugPrint then
            print('[grim_lovemenu] ox_inventory:Items() unavailable - relying on data/items.lua auto-scan.')
        end
        return
    end

    -- Build the items table from GrimItems (defined in shared/items.lua)
    if type(GrimItems) ~= 'table' then return end

    local toRegister = {}
    local count = 0
    for itemName, def in pairs(GrimItems) do
        if not oxItems[itemName] then
            -- Item not yet registered - add it
            toRegister[itemName] = {
                label       = def.label or itemName,
                weight      = def.weight or 100,
                stack       = def.stack ~= false,
                close       = def.close ~= false,
                description = def.description or '',
                client      = def.client or nil,
            }
            count = count + 1
        end
    end

    if count == 0 then
        if Config.DebugPrint then
            print('[grim_lovemenu] All items already registered in ox_inventory.')
        end
        return
    end

    -- RegisterItems is the supported bulk-registration export in ox_inventory 2.x+
    local regOk, regErr = pcall(function()
        exports.ox_inventory:RegisterItems(toRegister)
    end)

    if regOk then
        print(('[grim_lovemenu] Auto-registered %d items with ox_inventory.'):format(count))
    else
        -- RegisterItems not available (older ox_inventory) - just warn, data/items.lua handles it
        print(('[grim_lovemenu] ox_inventory:RegisterItems() unavailable (%s). ' ..
               'Ensure grim_lovemenu/data/items.lua contents are merged into ' ..
               'ox_inventory/data/items.lua if items are not working.'):format(tostring(regErr)))
    end
end

AddEventHandler('onResourceStart', function(res)
    if res == GetCurrentResourceName() then
        if GetResourceState('ox_inventory') ~= 'started' then
            print('^1[grim_lovemenu]^7 ox_inventory is required for this standalone build.')
        else
            -- Small delay so ox_inventory finishes its own startup scan first
            SetTimeout(500, RegisterGrimItemsWithOxInventory)
        end
    end

    -- Also re-register when ox_inventory itself restarts
    if res == 'ox_inventory' then
        SetTimeout(500, RegisterGrimItemsWithOxInventory)
    end
end)

-- - FETCH PLAYER DATA -
-- These handlers only register when sv_tablet_rebuild is NOT loaded.
-- sv_tablet_rebuild sets GrimUseTabletRebuild=true at runtime.
-- These handlers use runtime checks (not load-time) so only one fires.
-- NOTE: sv_main loads before sv_tablet_rebuild sets GrimUseTabletRebuild,
-- so load-time 'if not GrimUseTabletRebuild' blocks would always evaluate true.
-- Runtime early-returns inside the handler are the correct approach.

RegisterServerEvent('grim_lovemenu:sv:getMyData', function()
    local src = source
    if GrimUseTabletRebuild then return end
    local cid = GetPlayerCID(src)
    if not cid then return end

    local registeredPartners = GetRegisteredPartners(cid)
    local selectedPartnerState = GetSelectedPartnerState(src, cid)

    local data = {
        pregnancy        = GrimGetActivePregnancy(cid),
        std              = MySQL.query.await('SELECT * FROM grim_lm_std WHERE cid=? AND cured=0', {cid}),
        contraception    = MySQL.single.await('SELECT expires_at FROM grim_lm_contraception WHERE cid=? AND expires_at>NOW()', {cid}),
        condom           = MySQL.single.await('SELECT expires_at FROM grim_lm_condoms WHERE cid=? AND expires_at>NOW()', {cid}),
        vitamins         = MySQL.single.await('SELECT expires_at FROM grim_lm_vitamins WHERE cid=? AND expires_at>NOW()', {cid}),
        registeredPartners = registeredPartners,
        onlinePlayers    = GetOnlinePlayersFor(src, cid),
        partnerState     = registeredPartners[1] or nil,
        selectedPartnerState = selectedPartnerState,
        charName         = GetCharName(src),
        childSupport     = BuildChildSupportStatus(src, cid),
        babyProfiles     = GetBabyProfiles(cid),
    }
    TriggerClientEvent('grim_lovemenu:cl:receiveMyData', src, data)
end)


RegisterServerEvent('grim_lovemenu:sv:getChildSupportStatus', function()
    local src = source
    if GrimUseTabletRebuild then return end
    local cid = GetPlayerCID(src)
    if not cid then return end
    TriggerClientEvent('grim_lovemenu:cl:childSupportStatus', src, BuildChildSupportStatus(src, cid))
end)

RegisterServerEvent('grim_lovemenu:sv:claimChildSupport', function(profileId)
    local src = source
    if GrimUseTabletRebuild then return end
    local cid = GetPlayerCID(src)
    if not cid then return end

    local status = BuildChildSupportStatus(src, cid)
    if not status.hasCase or not status.caseId then
        Notify(src, 'No child support case found.', 'error')
        TriggerClientEvent('grim_lovemenu:cl:childSupportStatus', src, status)
        return
    end

    if not HasChildSupportRoleAccess(src) then
        Notify(src, 'You are not allowed to use child support.', 'error')
        TriggerClientEvent('grim_lovemenu:cl:childSupportStatus', src, status)
        return
    end

    if (GetChildSupportConfig().requireDNA) and not status.dnaConfirmed then
        Notify(src, 'DNA test required before claiming child support.', 'error')
        TriggerClientEvent('grim_lovemenu:cl:childSupportStatus', src, status)
        return
    end

    if not status.eligible then
        Notify(src, status.reason or 'Child support cannot be claimed right now.', 'error')
        TriggerClientEvent('grim_lovemenu:cl:childSupportStatus', src, status)
        return
    end

    local fatherSrc = GetSrcByCID(MySQL.scalar.await('SELECT partner_cid FROM grim_lm_pregnancy WHERE id=? LIMIT 1', {status.caseId}))
    if not fatherSrc then
        Notify(src, 'Father must be online to process payment.', 'error')
        TriggerClientEvent('grim_lovemenu:cl:childSupportStatus', src, BuildChildSupportStatus(src, cid))
        return
    end

    local funds = GetLiquidFunds(fatherSrc)
    local cs = GetChildSupportConfig()
    local targetAmount = math.floor((funds.total or 0) * (cs.percent or 0.25))
    if targetAmount < 1 then
        Notify(src, 'No available funds to collect.', 'error')
        TriggerClientEvent('grim_lovemenu:cl:childSupportStatus', src, BuildChildSupportStatus(src, cid))
        return
    end

    local remaining = targetAmount
    local totalTaken = 0

    local function take(itemName, amountAvailable)
        if remaining <= 0 or (amountAvailable or 0) <= 0 then return end
        local takeAmount = math.min(amountAvailable, remaining)
        if takeAmount > 0 and RemoveItem(fatherSrc, itemName, takeAmount) ~= false then
            totalTaken = totalTaken + takeAmount
            remaining = remaining - takeAmount
        end
    end

    take('money', funds.cash or 0)
    -- Also try 'cash' item name in case the server uses that instead of 'money'
    if remaining > 0 then
        take('cash', funds.cash or 0)
    end
    take('bank', funds.bank or 0)
    if cs.includeBlack and cs.blackType == 'item' and cs.blackName and cs.blackName ~= '' then
        take(cs.blackName, funds.dirty or 0)
    elseif cs.includeBlack and cs.blackType == 'account' and (funds.dirty or 0) > 0 and remaining > 0 then
        local takeAmount = math.min(funds.dirty or 0, remaining)
        if RemoveMoneyFrameworkFallback(fatherSrc, takeAmount, cs.blackName) then
            totalTaken = totalTaken + takeAmount
            remaining = remaining - takeAmount
        end
    end

    if totalTaken < 1 then
        Notify(src, 'Payment could not be processed.', 'error')
        TriggerClientEvent('grim_lovemenu:cl:childSupportStatus', src, BuildChildSupportStatus(src, cid))
        return
    end

    GiveItem(src, cs.payoutItem or 'bank', totalTaken)
    MySQL.update.await([[
        UPDATE grim_lm_pregnancy
        SET child_support_paid=1, child_support_amount=?, child_support_paid_at=NOW()
        WHERE id=?
    ]], {totalTaken, status.caseId})

    Notify(src, ('- Child support received: $%s'):format(totalTaken), 'success')
    Notify(fatherSrc, ('- One-time child support deducted: $%s'):format(totalTaken), 'inform')
    TriggerClientEvent('grim_lovemenu:cl:childSupportStatus', src, BuildChildSupportStatus(src, cid))
    TriggerEvent('grim_lovemenu:sv:refreshClient', src)
    TriggerEvent('grim_lovemenu:sv:refreshClient', fatherSrc)
end)

RegisterServerEvent('grim_lovemenu:sv:setSelectedPartner', function(targetSID)
    local src = source
    local cid = GetPlayerCID(src)
    targetSID = tonumber(targetSID)

    if not cid then return end
    if not targetSID or targetSID == src then
        SelectedPartners[src] = nil
        TriggerEvent('grim_lovemenu:sv:refreshClient', src)
        return
    end
    if not IsPlayerOnline(targetSID) then
        Notify(src, 'That player is not online.', 'error')
        return
    end

    local targetCID = GetPlayerCID(targetSID)
    if not targetCID or targetCID == cid then
        Notify(src, 'Invalid partner target.', 'error')
        return
    end

    local registered = false
    local rows = GetRegisteredPartners(cid)
    for _, row in ipairs(rows) do
        if row.cid == targetCID then registered = true break end
    end

    if not registered and not ArePlayersClose(src, targetSID, 25.0) then
        Notify(src, Config.Strings.TooFar, 'error')
        return
    end

    SelectedPartners[tonumber(src)] = targetSID
    TriggerEvent('grim_lovemenu:sv:refreshClient', src)
end)

local PendingAnimRequests = {}
local AnimRequestCooldown = {}  -- prevents spam: src -> next allowed time

-- - ANIMATION SYNC -

RegisterServerEvent('grim_lovemenu:sv:requestAnim', function(targetSID, animIdx, finishMode)
    local src = source
    targetSID = tonumber(targetSID)
    animIdx = tonumber(animIdx)
    finishMode = finishMode or 'finish'
    if not targetSID or targetSID == src then Notify(src, 'Invalid partner target.', 'error'); return end
    if not IsPlayerOnline(targetSID) then Notify(src, 'Target is not online.', 'error'); return end
    if not ArePlayersClose(src, targetSID, Config.MaxDistance + 0.5) then Notify(src, Config.Strings.TooFar, 'error'); return end
    local animDef = Config.Animations[animIdx]
    if not animDef then Notify(src, 'Invalid animation.', 'error'); return end

    -- Cooldown: prevent the same requester from spamming requests to the same target
    local cooldownKey = tostring(src) .. '_' .. tostring(targetSID)
    local now = GetGameTimer()
    if AnimRequestCooldown[cooldownKey] and now < AnimRequestCooldown[cooldownKey] then
        Notify(src, 'Request already sent. Please wait.', 'error')
        return
    end
    AnimRequestCooldown[cooldownKey] = now + 5000  -- 5s cooldown per requester-target pair

    PendingAnimRequests[targetSID] = {
        requesterSID = src,
        animIdx = animIdx,
        finishMode = finishMode,
        expiresAt = now + 15000,
    }

    local name = GetCharName(src)
    TriggerClientEvent('grim_lovemenu:cl:incomingRequest', targetSID, src, animIdx, finishMode, name)
    Notify(src, Config.Strings.RequestSent, 'primary')
end)


RegisterServerEvent('grim_lovemenu:sv:declineAnim', function(requesterSID, animIdx)
    local accepterSID = source
    requesterSID = tonumber(requesterSID)
    animIdx = tonumber(animIdx)
    local pending = PendingAnimRequests[accepterSID]
    if pending and pending.requesterSID == requesterSID and pending.animIdx == animIdx then
        PendingAnimRequests[accepterSID] = nil
        Notify(requesterSID, 'Your emote request was declined.', 'error')
    end
end)

RegisterServerEvent('grim_lovemenu:sv:acceptAnim', function(requesterSID, animIdx, finishMode)
    local accepterSID = source
    requesterSID = tonumber(requesterSID)
    animIdx = tonumber(animIdx)
    local pending = PendingAnimRequests[accepterSID]
    if not pending then Notify(accepterSID, 'This request expired.', 'error'); return end
    if pending.requesterSID ~= requesterSID or pending.animIdx ~= animIdx then Notify(accepterSID, 'This request no longer matches.', 'error'); return end
    if pending.expiresAt < GetGameTimer() then
        PendingAnimRequests[accepterSID] = nil
        Notify(accepterSID, 'This request expired.', 'error')
        return
    end
    if not IsPlayerOnline(requesterSID) then
        PendingAnimRequests[accepterSID] = nil
        Notify(accepterSID, 'Requester went offline.', 'error')
        return
    end
    if not ArePlayersClose(requesterSID, accepterSID, Config.MaxDistance + 0.5) then
        PendingAnimRequests[accepterSID] = nil
        Notify(accepterSID, Config.Strings.TooFar, 'error')
        Notify(requesterSID, Config.Strings.TooFar, 'error')
        return
    end

    local requesterCID = GetPlayerCID(requesterSID)
    local accepterCID  = GetPlayerCID(accepterSID)

    -- Always show the E/O/X finish prompt when finishMode == 'finish'.
    -- Protection level is handled by the risk roll server-side.
    -- The prompt is how the requester signals their intent (inside/pullout/cancel).
    local allowFinishPrompt = (finishMode == 'finish')

    -- Determine who is female so pregnancy always lands on the right person
    -- regardless of who sent the animation request.
    local requesterPed   = GetPlayerPed(requesterSID)
    local accepterPed    = GetPlayerPed(accepterSID)
    local femaleModel    = joaat('mp_f_freemode_01')
    local femaleSID, maleSID
    if accepterPed and GetEntityModel(accepterPed) == femaleModel then
        femaleSID = accepterSID; maleSID = requesterSID
    elseif requesterPed and GetEntityModel(requesterPed) == femaleModel then
        femaleSID = requesterSID; maleSID = accepterSID
    else
        femaleSID = accepterSID; maleSID = requesterSID  -- fallback
    end

    local requesterMeta = {
        allowFinishPrompt = allowFinishPrompt,
        femaleSID         = femaleSID,
        maleSID           = maleSID,
    }
    local accepterMeta = {
        allowFinishPrompt = false,
        femaleSID         = femaleSID,
        maleSID           = maleSID,
    }

    PendingAnimRequests[accepterSID] = nil
    TriggerClientEvent('grim_lovemenu:cl:playSynced', accepterSID, requesterSID, animIdx, 'Accepter', finishMode, accepterMeta)
    TriggerClientEvent('grim_lovemenu:cl:playSynced', requesterSID, accepterSID, animIdx, 'Requester', finishMode, requesterMeta)
end)

-- - ANIM FINISHED -
-- finishChoice: 'inside' | 'pullout' | 'none'
--   'inside'  - guaranteed pregnancy on the accepter (female partner)
--   'pullout' - 50/50 server-side roll
--   'none'    - scene ended with no input (use normal config risk roll)

RegisterServerEvent('grim_lovemenu:sv:animFinished', function(partnerSID, animIdx, finishMode, finishChoice, femaleSID)
    local src = source
    partnerSID   = tonumber(partnerSID)
    animIdx      = tonumber(animIdx)
    finishChoice = tostring(finishChoice or 'none')
    femaleSID    = tonumber(femaleSID) or partnerSID   -- fallback to original behaviour

    if not partnerSID or not IsPlayerOnline(partnerSID) then return end
    if not ArePlayersClose(src, partnerSID, Config.MaxDistance + 3.0) then return end

    -- Always target the female for pregnancy regardless of who sent the request.
    -- fatherSID is whichever player is NOT the female.
    local pregnancyTargetSID = femaleSID
    local fatherSID          = (femaleSID == partnerSID) and src or partnerSID

    TriggerEvent('grim_lovemenu:internal:calcRisk', fatherSID, pregnancyTargetSID, animIdx, finishMode, {
        finishChoice = finishChoice
    })
end)

-- - ITEM USE ROUTER -

RegisterServerEvent('grim_lovemenu:sv:useItem', function(item)
    local src = source
    local itemDef = GrimItems[item]
    if not itemDef then Notify(src,'Unknown item.','error'); return end
    -- Non-consumables never get removed by this handler
    if not itemDef.consumable then
        TriggerEvent('grim_lovemenu:internal:useItem', src, item)
        return
    end
    if not HasItem(src, item) then
        local noItemMsg = ("- You don't have a %s."):format(itemDef.label or item)
        Notify(src, noItemMsg, 'error')
        TriggerClientEvent('grim_lovemenu:cl:nuiMsg', src, {
            action  = 'toast',
            message = noItemMsg,
            ntype   = 'error'
        })
        return
    end
    TriggerEvent('grim_lovemenu:internal:useItem', src, item)
end)

-- - PHARMACY + REFRESH CLIENT -
-- Runtime guards prevent double-execution when sv_tablet_rebuild is active.

RegisterServerEvent('grim_lovemenu:sv:buyPharmacyItem', function(itemKey, paymentMethod)
    local src = source
    if GrimUseTabletRebuild then return end
    local cid = GetPlayerCID(src)
    if not cid then return end

    local entry = nil
    for _, v in ipairs(Config.PharmacyItems) do
        if v.item == itemKey then entry = v; break end
    end
    if not entry then Notify(src, 'Invalid item.', 'error'); return end

    local account = (paymentMethod == 'bank') and 'bank' or 'cash'
    local success = RemoveMoney(src, entry.price, account)
    if not success then
        Notify(src, ('Not enough %s. Need $%d.'):format(account, entry.price), 'error')
        return
    end

    local gave = GiveItem(src, entry.item, entry.amount)
    if gave == false then
        -- ox_inventory rejected the item (not registered) - refund the player
        if GetResourceState('ox_inventory') == 'started' then
            local refundItem = account == 'bank' and 'bank' or 'cash'
            -- Check if player uses 'cash' or 'money' item name
            if refundItem == 'cash' then
                local hasCash = (exports.ox_inventory:GetItemCount(src, 'cash') or 0) > 0
                refundItem = hasCash and 'cash' or 'money'
            end
            exports.ox_inventory:AddItem(src, refundItem, entry.price)
        end
        Notify(src, ('- Purchase failed - %s is not set up in ox_inventory. Contact an admin.'):format(entry.label), 'error')
        print(('^1[grim_lovemenu]^7 PURCHASE FAILED: item "%s" not in ox_inventory/data/items.lua - player refunded.'):format(entry.item))
        return
    end

    Notify(src, ('- Purchased %s for $%d.'):format(entry.label, entry.price), 'success')
    TriggerEvent('grim_lovemenu:sv:refreshClient', src)
end)

AddEventHandler('grim_lovemenu:sv:refreshClient', function(src)
    if GrimUseTabletRebuild then return end
    local cid = GetPlayerCID(src)
    if not cid then return end
    local registeredPartners = GetRegisteredPartners(cid)
    local data = {
        pregnancy        = GrimGetActivePregnancy(cid),
        std              = MySQL.query.await('SELECT * FROM grim_lm_std WHERE cid=? AND cured=0', {cid}),
        contraception    = MySQL.single.await('SELECT expires_at FROM grim_lm_contraception WHERE cid=? AND expires_at>NOW()', {cid}),
        condom           = MySQL.single.await('SELECT expires_at FROM grim_lm_condoms WHERE cid=? AND expires_at>NOW()', {cid}),
        vitamins         = MySQL.single.await('SELECT expires_at FROM grim_lm_vitamins WHERE cid=? AND expires_at>NOW()', {cid}),
        registeredPartners = registeredPartners,
        onlinePlayers    = GetOnlinePlayersFor(src, cid),
        partnerState     = registeredPartners[1] or nil,
        selectedPartnerState = GetSelectedPartnerState(src, cid),
        charName         = GetCharName(src),
        childSupport     = BuildChildSupportStatus(src, cid),
        babyProfiles     = GetBabyProfiles(cid),
    }
    TriggerClientEvent('grim_lovemenu:cl:receiveMyData', src, data)
end)

AddEventHandler('playerDropped', function()
    local dropped = tonumber(source)
    SelectedPartners[dropped] = nil
    for src, sid in pairs(SelectedPartners) do
        if tonumber(sid) == dropped then
            SelectedPartners[src] = nil
            TriggerEvent('grim_lovemenu:sv:refreshClient', tonumber(src))
        end
    end
    -- Clean up cooldown entries for the dropped player
    for k in pairs(AnimRequestCooldown) do
        if k:find('^' .. dropped .. '_') or k:find('_' .. dropped .. '$') then
            AnimRequestCooldown[k] = nil
        end
    end
end)


CreateThread(function()
    Wait(3000)
    if GetResourceState('ox_inventory') ~= 'started' or type(GrimItems) ~= 'table' then return end

    local ok, items = pcall(function()
        if exports.ox_inventory.Items then
            return exports.ox_inventory:Items()
        end
    end)

    if ok and type(items) == 'table' then
        local missing = {}
        for itemName in pairs(GrimItems) do
            if not items[itemName] then
                missing[#missing + 1] = itemName
            end
        end
        if #missing > 0 then
            print(('^1[grim_lovemenu]^7 Items still missing after auto-registration: %s'):format(table.concat(missing, ', ')))
            print('^1[grim_lovemenu]^7 Manually merge grim_lovemenu/data/items.lua into ox_inventory/data/items.lua to fix.')
        else
            print('^2[grim_lovemenu]^7 All items confirmed registered in ox_inventory.')
        end
    end
end)

