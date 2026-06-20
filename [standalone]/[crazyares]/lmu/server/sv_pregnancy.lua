local PendingPartnerRequests = {}
local ItemNames = Config.Items or {}

local function ItemName(key, fallback)
    return ItemNames[key] or fallback
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
        -- oxmysql uses .minute or .min depending on version
        local minute = tonumber(value.minute or value.min or 0) or 0
        local second = tonumber(value.second or value.sec or 0) or 0
        if year == 0 then return nil end
        return os.time({ year=year, month=month, day=day, hour=hour, min=minute, sec=second })
    end

    if type(value) ~= 'string' or value == '' then return nil end

    local y, m, d, hh, mm, ss = value:match('^(%d%d%d%d)%-(%d%d)%-(%d%d) (%d%d):(%d%d):(%d%d)$')
    if not y then
        y, m, d = value:match('^(%d%d%d%d)%-(%d%d)%-(%d%d)$')
        hh, mm, ss = '00', '00', '00'
    end

    if not y then return nil end

    return os.time({
        year = tonumber(y),
        month = tonumber(m),
        day = tonumber(d),
        hour = tonumber(hh),
        min = tonumber(mm),
        sec = tonumber(ss),
    })
end

local function ResolveRoleName(roleValue)
    if type(roleValue) == 'table' then
        return roleValue.name or roleValue.label
    end

    if type(roleValue) == 'string' and roleValue ~= '' then
        return roleValue
    end

    return nil
end

local function RoleOverrideMatches(override, playerData, citizenid)
    if type(override) ~= 'table' then
        return false
    end

    local matched = false
    local jobName = ResolveRoleName(playerData and playerData.job)
    local gangName = ResolveRoleName(playerData and playerData.gang)

    if override.citizenid and override.citizenid ~= '' then
        matched = true
        if citizenid ~= override.citizenid then
            return false
        end
    end

    if override.job and override.job ~= '' then
        matched = true
        if jobName ~= override.job then
            return false
        end
    end

    if override.gang and override.gang ~= '' then
        matched = true
        if gangName ~= override.gang then
            return false
        end
    end

    return matched
end

local function GetPregnancyRoleDurationOverride(src)
    local pregnancyConfig = Config.Pregnancy or {}
    local overrideConfig = pregnancyConfig.RoleOverrides or Config.PregnancyRoleOverrides or {}
    if overrideConfig.Enabled ~= true or type(overrideConfig.Roles) ~= 'table' then
        return nil
    end

    local playerData = type(GetPlayerData) == 'function' and GetPlayerData(src) or {}
    local citizenid = (playerData and playerData.citizenid) or (type(GetPlayerCID) == 'function' and GetPlayerCID(src)) or nil

    for _, roleEntry in ipairs(overrideConfig.Roles) do
        if RoleOverrideMatches(roleEntry, playerData, citizenid) then
            return {
                days = roleEntry.durationDays,
                hours = roleEntry.durationHours,
            }
        end
    end

    return nil
end

function GrimGetPregnancyDurationForSource(src)
    local override = src and GetPregnancyRoleDurationOverride(src) or nil
    if type(GetPregnancyDurationConfig) == 'function' then
        return GetPregnancyDurationConfig(override)
    end

    local days = math.max(1, math.floor(tonumber(Config.PregnancyDuration or 7) or 7))
    return {
        days = days,
        hours = 0,
        totalHours = days * 24,
        totalSeconds = days * 86400,
        maxDays = 30,
    }
end

local function GetConfiguredPregnancyDuration(src)
    return GrimGetPregnancyDurationForSource(src)
end

local function HasPregnancyRoleAccess(src)
    local pregnancyConfig = Config.Pregnancy or {}
    if type(GrimHasRoleWhitelistAccess) == 'function' then
        return GrimHasRoleWhitelistAccess(src, pregnancyConfig.RoleWhitelist)
    end

    return true
end

-- -
--  SERVER PREGNANCY + PARTNER SYSTEM  - Grim Development | Love Menu
-- -

-- - PROTECTION STATUS -


local function GetProtection(cid, partnerCID, finishMode, consumeCondoms)
    local condom  = MySQL.single.await('SELECT id FROM grim_lm_condoms WHERE cid=? AND expires_at>NOW()',       {cid})
    local pCondom = MySQL.single.await('SELECT id FROM grim_lm_condoms WHERE cid=? AND expires_at>NOW()',       {partnerCID})
    local contra  = MySQL.single.await('SELECT id FROM grim_lm_contraception WHERE cid=? AND expires_at>NOW()', {cid})
    local pContra = MySQL.single.await('SELECT id FROM grim_lm_contraception WHERE cid=? AND expires_at>NOW()', {partnerCID})

    local usedCondoms = (condom ~= nil) or (pCondom ~= nil)
    local usedContra  = (contra ~= nil) or (pContra ~= nil)

    local pregRisk, stdRisk, label
    if usedCondoms and usedContra then
        pregRisk=Config.Risk.pregnancy.both_protected; stdRisk=Config.Risk.std.both_protected; label='Both'
    elseif usedCondoms then
        pregRisk=Config.Risk.pregnancy.condoms_only;   stdRisk=Config.Risk.std.condoms_only;   label='Condoms'
    elseif usedContra then
        pregRisk=Config.Risk.pregnancy.contra_only;    stdRisk=Config.Risk.std.contra_only;    label='Pill'
    elseif finishMode == 'pullout' then
        pregRisk=Config.Risk.pregnancy.pullout_only;   stdRisk=Config.Risk.std.pullout_only;   label='PullOut'
    else
        pregRisk=Config.Risk.pregnancy.unprotected;    stdRisk=Config.Risk.std.unprotected;    label='Unprotected'
    end

    local vit = MySQL.single.await('SELECT id FROM grim_lm_vitamins WHERE cid=? AND expires_at>NOW()', {cid})
    if vit then pregRisk = math.max(0, pregRisk - Config.VitaminRiskReduction) end

    local isPartner = MySQL.single.await(
        'SELECT id FROM grim_lm_partners WHERE (cid_a=? AND cid_b=?) OR (cid_a=? AND cid_b=?)',
        {cid, partnerCID, partnerCID, cid}
    )
    if isPartner then pregRisk = math.max(0, pregRisk - Config.PartnerRiskReduction) end

    if consumeCondoms and usedCondoms then
        MySQL.query.await('DELETE FROM grim_lm_condoms WHERE cid=? OR cid=?', {cid, partnerCID})
    end

    return {
        usedCondoms   = usedCondoms,
        usedContra    = usedContra,
        isPartner     = (isPartner ~= nil),
        pregnancyRisk = pregRisk,
        stdRisk       = stdRisk,
        label         = label,
    }
end

function GrimGetProtectionPreview(cid, partnerCID, finishMode)
    return GetProtection(cid, partnerCID, finishMode, false)
end


local function GetPregnancyStageForRow(row)
    if not row or row.born == 1 then return nil end
    local q = MySQL.scalar.await('SELECT UNIX_TIMESTAMP(conceived_at) FROM grim_lm_pregnancy WHERE id=?', {row.id})
    local nowTs = os.time()
    local conceivedUnix = tonumber(q) or nowTs
    local mins = math.floor((nowTs - conceivedUnix) / 60)
    if mins < 30  then return 'early',          mins end
    if mins < 90  then return 'visible',         mins end
    if mins < 180 then return 'late',            mins end
    return 'delivery_ready', mins
end

local function PregnancyTestPositive(row)
    if not row then return false end
    local stage, mins = GetPregnancyStageForRow(row)
    -- Only apply false negative in the first 10 real-time minutes after conception
    if stage == 'early' and mins < 10 then
        return math.random(100) > 50  -- 50% chance in first 10 mins
    end
    return true  -- always positive once past 10 minutes
end


-- - START PREGNANCY (shared helper) -
-- targetCID = the person who becomes pregnant (always the accepter/female)
-- fatherCID = the requester who initiated

local function StartPregnancy(targetSrc, targetCID, fatherCID)
    if not targetCID then return end

    if targetSrc and not HasPregnancyRoleAccess(targetSrc) then
        if Config.DebugPrint then
        end
        return
    end

    local existing = MySQL.single.await(
        [[SELECT id FROM grim_lm_pregnancy WHERE cid=? AND born=0 ORDER BY conceived_at DESC, id DESC LIMIT 1]], {targetCID}
    )
    if existing then
        if Config.DebugPrint then
        end
        return
    end

    local pregnancyDuration = GetConfiguredPregnancyDuration(targetSrc)
    local birthDate = os.time() + pregnancyDuration.totalSeconds
    local gender    = math.random(2) == 1 and 'boy' or 'girl'

    MySQL.insert.await(
        'INSERT INTO grim_lm_pregnancy (cid, partner_cid, conceived_at, birth_at, gender, born) VALUES (?,?,NOW(),FROM_UNIXTIME(?),?,0)',
        {targetCID, fatherCID, birthDate, gender}
    )

    if targetSrc and IsPlayerOnline(targetSrc) then
        Notify(targetSrc, '- You may be pregnant. Take a test to confirm.', 'primary')
        TriggerEvent('grim_lovemenu:sv:refreshClient', targetSrc)
    end

    if Config.DebugPrint then
    end
end


-- - RISK ENTRY POINT -

AddEventHandler('grim_lovemenu:internal:calcRisk', function(src, partnerSID, animIdx, finishMode, opts)
    opts = opts or {}

    local cid        = GetPlayerCID(src)
    local partnerCID = GetPlayerCID(partnerSID)
    if not cid or not partnerCID then return end

    local animDef = Config.Animations[animIdx]
    if not animDef then return end

    local noRisk = {['Standing BJ']=true, ['Car BJ (Driver)']=true}
    if noRisk[animDef.label] then return end

    local prot = GetProtection(cid, partnerCID, finishMode, true)

    local finishChoice = tostring(opts.finishChoice or 'none')

    if Config.DebugPrint then
        print(('[grim] calcRisk: prot=%s finishChoice=%s preg%%=%d std%%=%d'):format(
            prot.label, finishChoice, prot.pregnancyRisk, prot.stdRisk))
    end

    -- - Pregnancy determination -
    -- src = requester (initiator) | partnerSID = accepter (the one who gets pregnant)
    if not opts.skipPregnancy then
        local shouldPregnancy = false

        if prot.label == 'Unprotected' then
            if finishChoice == 'inside' then
                -- E key: finish inside - high chance, configurable via Config.Risk.pregnancy.inside
                local insideChance = Config.Risk.pregnancy.inside or 80
                local roll = math.random(1, 100)
                shouldPregnancy = roll <= insideChance
                if Config.DebugPrint then print(('[grim] preg: E=inside roll=%d vs %d%% - %s'):format(roll, insideChance, tostring(shouldPregnancy))) end

            elseif finishChoice == 'pullout' then
                local roll = math.random(1, 100)
                shouldPregnancy = roll <= 50
                if Config.DebugPrint then print(('[grim] preg: O=pullout roll=%d - %s'):format(roll, tostring(shouldPregnancy))) end

            else
                local roll = math.random(1, 100)
                shouldPregnancy = roll <= prot.pregnancyRisk
                if Config.DebugPrint then print(('[grim] preg: no-choice roll=%d vs %d%% - %s'):format(roll, prot.pregnancyRisk, tostring(shouldPregnancy))) end
            end
        else
            local roll = math.random(1, 100)
            shouldPregnancy = roll <= prot.pregnancyRisk
            if Config.DebugPrint then print(('[grim] preg: protected roll=%d vs %d%% - %s'):format(roll, prot.pregnancyRisk, tostring(shouldPregnancy))) end
        end

        if shouldPregnancy then
            local partnerSrc = tonumber(partnerSID)
            StartPregnancy(partnerSrc, partnerCID, cid)
        end
    end

    -- - STD roll -
    if not opts.skipSTD then
        TriggerEvent('grim_lovemenu:internal:rollSTD', src, partnerSID, cid, partnerCID, prot.stdRisk, prot.isPartner)
    end
end)


-- - ITEM HANDLERS -

AddEventHandler('grim_lovemenu:internal:useItem', function(src, item)

    if item == ItemName('PregnancyTest', 'pregnancy_test') then
        local cid = GetPlayerCID(src)

        local hasTestItem = HasItem(src, ItemName('PregnancyTest', 'pregnancy_test'))
        if not hasTestItem then
            Notify(src, '- No pregnancy test kit found. Buy one at the Pharmacy.', 'error')
            TriggerClientEvent('grim_lovemenu:cl:nuiMsg', src, {
                action  = 'toast',
                message = '- No pregnancy test found. Buy one at the Pharmacy.',
                ntype   = 'error'
            })
            return
        end

        RemoveItem(src, ItemName('PregnancyTest', 'pregnancy_test'), 1)

        local row = GrimGetActivePregnancy(cid)
        local positive = PregnancyTestPositive(row)

        local resultMsg, resultType
        if positive and row then
            local stage  = select(1, GetPregnancyStageForRow(row)) or 'early'
            local gender = row.gender or 'unknown'
            local stageLabel = stage == 'early' and 'Early' or stage == 'visible' and 'Visible' or stage == 'late' and 'Late' or 'Delivery Ready'
            local genderLine = gender == 'boy' and "It's a BOY!" or gender == 'girl' and "It's a GIRL!" or ''
            resultMsg  = ('- POSITIVE - %s. %s'):format(stageLabel, genderLine)
            resultType = 'success'
        else
            resultMsg  = '- NEGATIVE - Not pregnant.'
            resultType = 'inform'
        end

        Notify(src, resultMsg, resultType)
        TriggerClientEvent('grim_lovemenu:cl:nuiMsg', src, {
            action  = 'toast',
            message = resultMsg,
            ntype   = resultType
        })
        -- Use refreshClient only — it goes through NormalisePregnancyRow which
        -- adds birthReady, converts dates correctly, and keeps tablet in sync.
        -- Sending raw row via cl:updateData bypasses normalisation and causes
        -- the tablet to show "Not Pregnant" even when she is pregnant.
        TriggerEvent('grim_lovemenu:sv:refreshClient', src)

    elseif item == ItemName('PrenatalVitamins', 'prenatal_vitamins') then
        local cid = GetPlayerCID(src)
        RemoveItem(src, ItemName('PrenatalVitamins', 'prenatal_vitamins'), 1)
        MySQL.query.await('REPLACE INTO grim_lm_vitamins (cid, expires_at) VALUES (?, DATE_ADD(NOW(), INTERVAL ? HOUR))', {cid, Config.VitaminDoseHours or 3})
        Notify(src, Config.Strings.VitaminsActive, 'success')
        TriggerEvent('grim_lovemenu:sv:refreshClient', src)

    elseif item == ItemName('Condoms', 'condoms') then
        local cid = GetPlayerCID(src)
        RemoveItem(src, ItemName('Condoms', 'condoms'), 1)
        -- Store condom as a single-use token with a 30-minute fallback cleanup window.
        -- The token is ALWAYS deleted by calcRisk (consumeCondoms=true) on the FIRST
        -- animation that completes, making it truly one-time use per item.
        -- The 30-minute window only matters if the player never starts an animation.
        MySQL.query.await('REPLACE INTO grim_lm_condoms (cid, expires_at) VALUES (?, DATE_ADD(NOW(), INTERVAL 30 MINUTE))', {cid})
        Notify(src, Config.Strings.CondomsActive, 'success')
        TriggerEvent('grim_lovemenu:sv:refreshClient', src)

    elseif item == ItemName('Contraception', 'contraception') then
        local cid = GetPlayerCID(src)
        RemoveItem(src, ItemName('Contraception', 'contraception'), 1)
        MySQL.query.await('REPLACE INTO grim_lm_contraception (cid, expires_at) VALUES (?, DATE_ADD(NOW(), INTERVAL ? HOUR))', {cid, Config.ContraceptionDuration})
        Notify(src, Config.Strings.ContraceptionActive:format(Config.ContraceptionDuration), 'success')
        TriggerEvent('grim_lovemenu:sv:refreshClient', src)

    elseif item == ItemName('PlanC', 'plan_c') then
        local planCConfig = Config.PlanC or {}
        local enabled = planCConfig.Enabled
        if enabled == nil then
            enabled = Config.PlanCEnabled == true
        end

        if enabled ~= true then
            Notify(src, 'Plan C is not available on this server.', 'error')
            return
        end

        local cid = GetPlayerCID(src)
        local row = GrimGetActivePregnancy(cid)
        if not row then
            Notify(src, 'No active pregnancy was found.', 'error')
            TriggerClientEvent('grim_lovemenu:cl:nuiMsg', src, {
                action  = 'toast',
                message = 'No active pregnancy was found.',
                ntype   = 'error'
            })
            return
        end

        if not RemoveItem(src, ItemName('PlanC', 'plan_c'), 1) then
            Notify(src, 'Plan C could not be used right now.', 'error')
            return
        end

        local conceivedUnix = ParseDateTimeToUnix(row.conceived_at) or GrimGetActivePregnancyConceivedUnix(cid) or os.time()
        local windowHours = tonumber(planCConfig.WindowHours or Config.PlanCWindowHours or 24) or 24
        local deadlineUnix = conceivedUnix + math.floor(windowHours * 3600)
        if os.time() > deadlineUnix then
            local tooLateMessage = ('Plan C failed. It must be used within %d hour(s) of conception.'):format(windowHours)
            Notify(src, tooLateMessage, 'error')
            TriggerClientEvent('grim_lovemenu:cl:nuiMsg', src, {
                action  = 'toast',
                message = tooLateMessage,
                ntype   = 'error'
            })
            TriggerEvent('grim_lovemenu:sv:refreshClient', src)
            return
        end

        local failureChance = tonumber(planCConfig.FailureChance or (100 - (Config.PlanCSuccessChance or 90)) or 10) or 10
        local roll = math.random(1, 100)
        if roll <= failureChance then
            Notify(src, 'Plan C failed. The pregnancy remains active.', 'error')
            TriggerClientEvent('grim_lovemenu:cl:nuiMsg', src, {
                action  = 'toast',
                message = 'Plan C failed. The pregnancy remains active.',
                ntype   = 'error'
            })
            TriggerEvent('grim_lovemenu:sv:refreshClient', src)
            return
        end

        MySQL.query.await('DELETE FROM grim_lm_pregnancy WHERE id=?', {row.id})
        Notify(src, 'Plan C succeeded. Pregnancy terminated.', 'success')
        TriggerClientEvent('grim_lovemenu:cl:nuiMsg', src, {
            action  = 'toast',
            message = 'Plan C succeeded. Pregnancy terminated.',
            ntype   = 'success'
        })
        TriggerEvent('grim_lovemenu:sv:refreshClient', src)
    end
end)

-- - ULTRASOUND -

RegisterServerEvent('grim_lovemenu:sv:requestUltrasound', function()
    local src = source
    local cid = GetPlayerCID(src)
    local row = GrimGetActivePregnancy(cid)
    if not row then Notify(src, Config.Strings.NotPregnant, 'error'); return end

    local now = os.time()
    local gender = row.gender or (math.random(2) == 1 and 'boy' or 'girl')
    local birthAt = row.birth_at
    if not birthAt or tostring(birthAt) == '' or tostring(birthAt) == 'nil' then
        birthAt = os.date('%Y-%m-%d %H:%M:%S', now + GetConfiguredPregnancyDuration(src).totalSeconds)
    end

    local added = GiveItem(src, ItemName('UltrasoundReport', 'ultrasound_report'), 1)
    if not added then
        Notify(src, 'Ultrasound report item is not registered in ox_inventory.', 'error')
        return
    end

    MySQL.query.await(
        'INSERT INTO grim_lm_ultrasounds (cid, gender, birth_at, scanned_at) VALUES (?,?,?,NOW())',
        { cid, gender, birthAt }
    )

    Notify(src, Config.Strings.UltrasoundReady, 'success')

    local weeksPregnant = 0
    if row.conceived_at then
        local q = GrimGetActivePregnancyConceivedUnix(cid)
        local conceivedUnix = tonumber(q) or now
        local secondsPregnant = now - conceivedUnix
        weeksPregnant = math.min(math.floor(secondsPregnant / 604800), 40)
    end

    TriggerClientEvent('grim_lovemenu:cl:showUltrasound', src, {
        gender        = gender,
        birthAt       = tostring(birthAt),
        weeksPregnant = weeksPregnant,
        scannedAt     = os.date('%Y-%m-%d %H:%M:%S', now),
    })

    -- Refresh tablet data so the new ultrasound report appears in the UI
    TriggerEvent('grim_lovemenu:sv:refreshClient', src)
end)

-- - GIVE BIRTH -

RegisterServerEvent('grim_lovemenu:sv:giveBirth', function()
    local src = source
    local cid = GetPlayerCID(src)
    local row = GrimGetActivePregnancy(cid)
    if not row then Notify(src, Config.Strings.NotPregnant, 'error'); return end

    local now = os.time()
    local birthAtUnix = ParseDateTimeToUnix(row.birth_at) or 0
    if now < birthAtUnix then
        local hrs = math.max(1, math.floor((birthAtUnix - now) / 3600))
        Notify(src, ('Not ready - ~%dh remaining.'):format(hrs), 'error'); return
    end

    MySQL.update.await('UPDATE grim_lm_pregnancy SET born=1 WHERE id=?', {row.id})
    GrimUpsertBabyProfileFromPregnancyId(row.id)

    -- Give birth certificate - check if it worked
    local certItem = row.gender == 'boy'
        and ItemName('BirthCertBoy', 'birth_cert_boy')
        or  ItemName('BirthCertGirl', 'birth_cert_girl')
    local certGiven = GiveItem(src, certItem, 1)
    if not certGiven then
        Notify(src, ('- Baby %s born! (Birth certificate could not be given - contact admin)'):format(row.gender), 'error')
    else
        local genderEmoji = row.gender == 'boy' and '💙' or '🩷'
        Notify(src, ('- Congratulations! You gave birth to a %s %s!'):format(genderEmoji, row.gender), 'success')
    end

    -- Clear vitamins - no longer needed after birth
    MySQL.query.await('DELETE FROM grim_lm_vitamins WHERE cid=?', {cid})

    -- Notify and refresh the father's tablet if he is online
    if row.partner_cid and row.partner_cid ~= '' then
        local fatherSrc = GetSrcByCID(row.partner_cid)
        if fatherSrc and IsPlayerOnline(fatherSrc) then
            local genderEmoji = row.gender == 'boy' and '💙' or '🩷'
            Notify(fatherSrc, ('- %s gave birth to a %s %s!'):format(
                GetCharName(src), genderEmoji, row.gender), 'success')
            TriggerEvent('grim_lovemenu:sv:refreshClient', fatherSrc)
        end
    end

    TriggerEvent('grim_lovemenu:sv:refreshClient', src)
end)

-- - BIRTH-READY TICKER -
-- Server-side dedup: notifies at most once per 10 minutes per player.
-- Also pushes refreshClient so tablet shows correct birth-ready state.
local birthReadyNotified = {}

CreateThread(function()
    while true do
        Wait(300000)
        local rows = MySQL.query.await('SELECT cid FROM grim_lm_pregnancy WHERE born=0 AND birth_at<=NOW()', {})
        if rows and #rows > 0 then
            local cidMap = {}
            for _, src in ipairs(GetPlayers()) do
                local c = GetPlayerCID(src)
                if c then cidMap[c] = tonumber(src) end
            end
            local now = os.time()
            for _, row in ipairs(rows) do
                local src = cidMap[row.cid]
                if src then
                    local lastNotified = birthReadyNotified[row.cid] or 0
                    if (now - lastNotified) >= 600 then
                        birthReadyNotified[row.cid] = now
                        TriggerClientEvent('grim_lovemenu:cl:birthReady', src)
                        TriggerEvent('grim_lovemenu:sv:refreshClient', src)
                    end
                end
            end
        end
    end
end)

AddEventHandler('playerDropped', function()
    local cid = GetPlayerCID(source)
    if cid then birthReadyNotified[cid] = nil end
end)

-- - VITAMIN REMINDER TICKER -
-- Checks every VitaminReminderHours for pregnant players whose vitamins expired

CreateThread(function()
    local reminderIntervalMs = ((Config.VitaminReminderHours or 3) * 3600 * 1000)
    while true do
        Wait(reminderIntervalMs)
        local cidMap = {}
        for _, src in ipairs(GetPlayers()) do
            local c = GetPlayerCID(src)
            if c then cidMap[c] = tonumber(src) end
        end
        for cid, src in pairs(cidMap) do
            local pregnant = MySQL.single.await(
                [[SELECT id FROM grim_lm_pregnancy WHERE cid=? AND born=0 ORDER BY conceived_at DESC, id DESC LIMIT 1]],
                {cid}
            )
            if pregnant then
                local vitActive = MySQL.single.await(
                    'SELECT id FROM grim_lm_vitamins WHERE cid=? AND expires_at>NOW()',
                    {cid}
                )
                if not vitActive then
                    TriggerClientEvent('grim_lovemenu:cl:vitaminReminder', src)
                end
            end
        end
    end
end)

-- -
--  PARTNER SYSTEM  - mutual consent register/unregister
-- -

local pendingUnreg  = {}
local unregCooldown = {}

-- - REGISTER -

RegisterServerEvent('grim_lovemenu:sv:registerPartner', function(targetSID)
    local src       = source
    targetSID       = tonumber(targetSID)
    local cid       = GetPlayerCID(src)
    local targetCID = GetPlayerCID(targetSID)

    if not cid or not targetCID then Notify(src,'Player not found.','error'); return end
    if cid == targetCID then Notify(src,'You cannot register yourself.','error'); return end
    if not IsPlayerOnline(targetSID) then Notify(src,'That player is not online.','error'); return end
    if not ArePlayersClose(src, targetSID, 5.0) then Notify(src, Config.Strings.TooFar, 'error'); return end

    local existing = MySQL.single.await(
        'SELECT id FROM grim_lm_partners WHERE (cid_a=? AND cid_b=?) OR (cid_a=? AND cid_b=?)',
        {cid,targetCID,targetCID,cid}
    )
    if existing then Notify(src,'Already registered as partners.','inform'); return end

    PendingPartnerRequests[targetCID] = PendingPartnerRequests[targetCID] or {}
    PendingPartnerRequests[targetCID][cid] = { requesterSID = src, requesterCID = cid, expiresAt = GetGameTimer() + 20000 }

    local srcName = GetCharName(src)
    TriggerClientEvent('grim_lovemenu:cl:partnerRegRequest', targetSID, src, srcName)
    Notify(src, ('- Partner request sent to %s.'):format(GetCharName(targetSID)), 'primary')
end)

RegisterServerEvent('grim_lovemenu:sv:acceptPartnerReg', function(requesterSID)
    local src       = source
    requesterSID    = tonumber(requesterSID)
    local cid       = GetPlayerCID(src)
    local reqCID    = GetPlayerCID(requesterSID)

    if not cid or not reqCID then return end
    if not IsPlayerOnline(requesterSID) then Notify(src,'Requester went offline.','error'); return end
    local pending = PendingPartnerRequests[cid] and PendingPartnerRequests[cid][reqCID]
    if not pending or pending.requesterSID ~= requesterSID or pending.requesterCID ~= reqCID or pending.expiresAt < GetGameTimer() then
        if PendingPartnerRequests[cid] then PendingPartnerRequests[cid][reqCID] = nil end
        Notify(src, 'This partner request expired.', 'error')
        return
    end
    if not ArePlayersClose(src, requesterSID, 5.0) then
        if PendingPartnerRequests[cid] then PendingPartnerRequests[cid][reqCID] = nil end
        Notify(src, Config.Strings.TooFar, 'error')
        Notify(requesterSID, Config.Strings.TooFar, 'error')
        return
    end

    local existing = MySQL.single.await(
        'SELECT id FROM grim_lm_partners WHERE (cid_a=? AND cid_b=?) OR (cid_a=? AND cid_b=?)',
        {cid,reqCID,reqCID,cid}
    )
    if existing then Notify(src,'Already partners.','inform'); return end

    if PendingPartnerRequests[cid] then PendingPartnerRequests[cid][reqCID] = nil end
    MySQL.insert.await('INSERT INTO grim_lm_partners (cid_a, cid_b, registered_at) VALUES (?,?,NOW())', {reqCID, cid})
    Notify(src,          '- Partner registered! Risk reduction active.', 'success')
    Notify(requesterSID, ('- %s accepted your partner request!'):format(GetCharName(src)), 'success')
    TriggerEvent('grim_lovemenu:sv:refreshClient', src)
    TriggerEvent('grim_lovemenu:sv:refreshClient', requesterSID)
end)

RegisterServerEvent('grim_lovemenu:sv:declinePartnerReg', function(requesterSID)
    local src = source
    local cid = GetPlayerCID(src)
    requesterSID = tonumber(requesterSID)
    local reqCID = GetPlayerCID(requesterSID)
    if cid and PendingPartnerRequests[cid] and reqCID then PendingPartnerRequests[cid][reqCID] = nil end
    if IsPlayerOnline(requesterSID) then
        Notify(requesterSID, ('- %s declined your partner request.'):format(GetCharName(src)), 'error')
    end
end)

-- - UNREGISTER (MUTUAL CONSENT) -
-- FIX: requestUnregister now sends a consent request to the partner instead of
-- immediately deleting. The DELETE only happens in acceptUnregister.

RegisterServerEvent('grim_lovemenu:sv:requestUnregister', function(targetSID)
    local src = source
    local cid = GetPlayerCID(src)
    if not cid then return end

    targetSID = tonumber(targetSID)
    local partnerCID = targetSID and GetPlayerCID(targetSID) or nil

    -- Resolve partner CID from DB if not passed directly
    if not partnerCID then
        local first = MySQL.single.await(
            'SELECT cid_a, cid_b FROM grim_lm_partners WHERE cid_a=? OR cid_b=? ORDER BY registered_at DESC LIMIT 1',
            {cid, cid}
        )
        if not first then Notify(src, 'You are not in a registered partnership.', 'error'); return end
        partnerCID = (first.cid_a == cid) and first.cid_b or first.cid_a
    end

    local linked = MySQL.single.await(
        'SELECT id FROM grim_lm_partners WHERE (cid_a=? AND cid_b=?) OR (cid_a=? AND cid_b=?)',
        {cid, partnerCID, partnerCID, cid}
    )
    if not linked then Notify(src, 'That partner is not registered to you.', 'error'); return end

    local partnerSrc = GetSrcByCID(partnerCID)

    -- If partner is offline, allow solo unregister (no one to consent)
    if not partnerSrc or not IsPlayerOnline(partnerSrc) then
        MySQL.query.await(
            'DELETE FROM grim_lm_partners WHERE (cid_a=? AND cid_b=?) OR (cid_a=? AND cid_b=?)',
            {cid, partnerCID, partnerCID, cid}
        )
        Notify(src, '- Partner unregistered (partner was offline).', 'inform')
        TriggerEvent('grim_lovemenu:sv:refreshClient', src)
        return
    end

    -- Partner is online - store pending and ask for their consent
    local timeout = 30
    pendingUnreg[cid] = {
        partnerCID = partnerCID,
        partnerSrc = partnerSrc,
        expiresAt  = GetGameTimer() + (timeout * 1000),
    }

    TriggerClientEvent('grim_lovemenu:cl:unregRequest', partnerSrc, src, GetCharName(src), timeout)
    Notify(src, ('- Unregister request sent to %s. Waiting for their response.'):format(GetCharName(partnerSrc)), 'inform')

    -- Auto-expire: if partner doesn't respond, cancel the request
    SetTimeout(timeout * 1000 + 500, function()
        if pendingUnreg[cid] then
            pendingUnreg[cid] = nil
            if IsPlayerOnline(src) then
                Notify(src, '- Unregister request expired - partner did not respond.', 'error')
            end
        end
    end)
end)

RegisterServerEvent('grim_lovemenu:sv:acceptUnregister', function(requesterSID)
    local src       = source
    requesterSID    = tonumber(requesterSID)
    local cid       = GetPlayerCID(src)
    local reqCID    = GetPlayerCID(requesterSID)

    if not cid or not reqCID then return end
    if not pendingUnreg[reqCID] then
        Notify(src, 'This request has expired.', 'error'); return
    end

    -- Verify the pending request matches
    if pendingUnreg[reqCID].partnerCID ~= cid then
        Notify(src, 'This request does not match your partnership.', 'error'); return
    end

    pendingUnreg[reqCID] = nil
    MySQL.query.await(
        'DELETE FROM grim_lm_partners WHERE (cid_a=? AND cid_b=?) OR (cid_a=? AND cid_b=?)',
        {reqCID, cid, cid, reqCID}
    )
    Notify(src,          Config.Strings.UnregAccepted, 'inform')
    Notify(requesterSID, Config.Strings.UnregAccepted, 'inform')
    TriggerEvent('grim_lovemenu:sv:refreshClient', src)
    TriggerEvent('grim_lovemenu:sv:refreshClient', requesterSID)
end)

RegisterServerEvent('grim_lovemenu:sv:declineUnregister', function(requesterSID)
    local src    = source
    requesterSID = tonumber(requesterSID)
    local reqCID = GetPlayerCID(requesterSID)
    if reqCID then pendingUnreg[reqCID] = nil end
    Notify(src,          Config.Strings.UnregDeclined, 'success')
    if IsPlayerOnline(requesterSID) then
        Notify(requesterSID, Config.Strings.UnregDeclined, 'error')
    end
end)

AddEventHandler('playerDropped', function()
    local src = source
    local cid = GetPlayerCID(src)
    if cid then
        if pendingUnreg[cid] then
            local ps = pendingUnreg[cid].partnerSrc
            pendingUnreg[cid] = nil
            if ps and IsPlayerOnline(ps) then
                TriggerClientEvent('grim_lovemenu:cl:unregTimeout', ps)
            end
        end
        for k, v in pairs(pendingUnreg) do
            if v.partnerCID == cid then
                local origSrc = GetSrcByCID(k)
                pendingUnreg[k] = nil
                if origSrc and IsPlayerOnline(origSrc) then
                    Notify(origSrc, 'Unregister request cancelled - partner disconnected.', 'error')
                end
            end
        end
        unregCooldown[cid] = nil
    end
end)

-- - VIEW STORED ULTRASOUND -

RegisterServerEvent('grim_lovemenu:sv:viewUltrasound', function()
    local src = source
    local cid = GetPlayerCID(src)
    local row = MySQL.single.await(
        'SELECT gender, birth_at, scanned_at FROM grim_lm_ultrasounds WHERE cid=? ORDER BY scanned_at DESC LIMIT 1',
        { cid }
    )
    if not row then
        Notify(src, 'No ultrasound data found. Request one at a hospital.', 'error'); return
    end

    local now = os.time()
    local birthAtUnix = ParseDateTimeToUnix(row.birth_at)
    local scanTs = ParseDateTimeToUnix(row.scanned_at) or now
    local daysSinceScan = math.max(0, math.floor((now - scanTs) / 86400))

    -- Use the same DateTimeToString helper approach manually here
    -- since sv_pregnancy has its own local helpers
    local function dtStr(v)
        if type(v) == 'string' and v ~= '' then return v end
        if type(v) == 'table' and (v.year or v[1]) then
            local yr = tonumber(v.year or v[1]) or 0
            local mo = tonumber(v.month or v[2]) or 1
            local dy = tonumber(v.day or v[3]) or 1
            local hr = tonumber(v.hour or v[4]) or 0
            local mi = tonumber(v.minute or v.min or v[5]) or 0
            local sc = tonumber(v.second or v.sec or v[6]) or 0
            return string.format('%04d-%02d-%02d %02d:%02d:%02d', yr, mo, dy, hr, mi, sc)
        end
        return nil
    end

    TriggerClientEvent('grim_lovemenu:cl:showUltrasound', src, {
        gender        = row.gender,
        birthAt       = dtStr(row.birth_at),
        birthAtUnix   = birthAtUnix,
        scannedAt     = dtStr(row.scanned_at),
        scannedAtUnix = scanTs,
        daysSinceScan = daysSinceScan,
        weeksPregnant = nil,
    })
end)
