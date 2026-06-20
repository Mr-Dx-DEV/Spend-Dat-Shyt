-- -
--  SERVER HEALTH  - STD system  | Grim Development | Love Menu
-- -

-- - STD ROLL -
-- isPartner: registered partners are immune to STDs from each other

local ItemNames = Config.Items or {}

local function ItemName(key, fallback)
    return ItemNames[key] or fallback
end

AddEventHandler('grim_lovemenu:internal:rollSTD', function(src, partnerSID, cid, partnerCID, stdRisk, isPartner)
    -- Partner immunity rule
    if isPartner and Config.PartnerSTDImmunity then return end

    local partnerSTDs = MySQL.query.await('SELECT disease_id FROM grim_lm_std WHERE cid=? AND cured=0', {partnerCID})
    if not partnerSTDs or #partnerSTDs == 0 then return end

    local exposed = false
    for _, row in ipairs(partnerSTDs) do
        local roll = math.random(1, 100)
        if Config.DebugPrint then print(('[grim] STD roll %d vs %d%% for %s'):format(roll, stdRisk, row.disease_id)) end
        if roll <= stdRisk then
            local existing = MySQL.single.await('SELECT id FROM grim_lm_std WHERE cid=? AND disease_id=? AND cured=0', {cid, row.disease_id})
            if not existing then
                MySQL.insert.await('INSERT INTO grim_lm_std (cid, disease_id, contracted_at, cured) VALUES (?,?,NOW(),0)', {cid, row.disease_id})
                exposed = true
            end
        end
    end
    if exposed then
        Notify(src, '- You may have been exposed to an infection. Get tested.', 'error')
    end
end)

-- - ITEM HANDLERS -

AddEventHandler('grim_lovemenu:internal:useItem', function(src, item)
    if item == ItemName('STDTestKit', 'std_test_kit') then
        local cid = GetPlayerCID(src)
        RemoveItem(src, ItemName('STDTestKit', 'std_test_kit'), 1)
        local rows = MySQL.query.await('SELECT disease_id FROM grim_lm_std WHERE cid=? AND cured=0', {cid})
        if not rows or #rows == 0 then
            Notify(src, Config.Strings.STDNegative, 'success')
        else
            local labels = {}
            for _, r in ipairs(rows) do
                for _, d in ipairs(Config.Diseases) do
                    if d.id == r.disease_id then labels[#labels+1] = d.label; break end
                end
            end
            Notify(src, Config.Strings.STDPositive:format(table.concat(labels, ', ')), 'error')
        end
        -- Push fresh STD data to UI
        TriggerClientEvent('grim_lovemenu:cl:updateData', src, {std = rows or {}})

    elseif item == ItemName('PrescriptionMeds', 'prescription_meds') then
        local cid = GetPlayerCID(src)
        RemoveItem(src, ItemName('PrescriptionMeds', 'prescription_meds'), 1)
        local cured = 0
        for _, d in ipairs(Config.Diseases) do
            if d.curable and d.treatDays <= 3 then
                local r = MySQL.update.await('UPDATE grim_lm_std SET cured=1 WHERE cid=? AND disease_id=? AND cured=0', {cid, d.id})
                if r and r > 0 then cured = cured + r end
            end
        end
        if cured > 0 then
            Notify(src, ('- Cleared %d curable condition(s).'):format(cured), 'success')
        else
            Notify(src, '- Medication taken. No curable conditions found.', 'inform')
        end
        TriggerEvent('grim_lovemenu:sv:refreshClient', src)

    elseif item == ItemName('RhinoPill', 'rhino_pill') then
        if not RemoveItem(src, ItemName('RhinoPill', 'rhino_pill'), 1) then
            Notify(src, 'You do not have a Rhino Pill to use.', 'error')
            return
        end

        Notify(src, 'Rhino Pill used.', 'success')
        TriggerClientEvent('grim_lovemenu:cl:nuiMsg', src, {
            action = 'toast',
            message = 'Rhino Pill used.',
            ntype = 'success'
        })
        TriggerEvent('grim_lovemenu:sv:refreshClient', src)

    elseif item == ItemName('Lubricant', 'lubricant') then
        if not RemoveItem(src, ItemName('Lubricant', 'lubricant'), 1) then
            Notify(src, 'You do not have any Lubricant to use.', 'error')
            return
        end

        Notify(src, 'Lubricant used.', 'success')
        TriggerClientEvent('grim_lovemenu:cl:nuiMsg', src, {
            action = 'toast',
            message = 'Lubricant used.',
            ntype = 'success'
        })
        TriggerEvent('grim_lovemenu:sv:refreshClient', src)

    elseif item == ItemName('DNATest', 'dna_test') then
        -- Handled by sv_health:useDNATest event
    end
end)

-- - DNA TEST -

RegisterServerEvent('grim_lovemenu:sv:useDNATest', function(targetSID)
    local src       = source
    targetSID       = tonumber(targetSID)
    local cid       = GetPlayerCID(src)
    local targetCID = GetPlayerCID(targetSID)

    if not cid then Notify(src,'Error: could not identify you.','error'); return end
    if not targetCID then Notify(src,'Target player not found or offline.','error'); return end
    if not HasItem(src, ItemName('DNATest', 'dna_test')) then Notify(src,"You don't have a DNA Test Kit.",'error'); return end
    if not ArePlayersClose(src, targetSID, 5.0) then Notify(src, Config.Strings.TooFar, 'error'); return end

    if not RemoveItem(src, ItemName('DNATest', 'dna_test'), 1) then
        Notify(src, 'DNA Test Kit could not be removed.', 'error')
        return
    end

    local preg = MySQL.single.await([[
        SELECT id, cid, partner_cid, born
        FROM grim_lm_pregnancy
        WHERE ((cid=? AND partner_cid=?) OR (cid=? AND partner_cid=?))
        ORDER BY conceived_at DESC
        LIMIT 1
    ]], {cid, targetCID, targetCID, cid})

    local match
    if preg then
        match = math.random(92, 99)
        if preg.id then
            MySQL.update.await('UPDATE grim_lm_pregnancy SET dna_confirmed=1 WHERE id=?', { preg.id })
            GrimUpsertBabyProfileFromPregnancyId(preg.id)
        end
    else
        match = math.random(0, 5)
    end

    local targetName = GetCharName(targetSID)
    local resultMsg  = Config.Strings.DNAMatch:format(match)
    Notify(src, ('- DNA vs %s: %d%% match.'):format(targetName, match), match >= 90 and 'success' or 'error')

    -- Give result item
    GiveItem(src, ItemName('DNAResult', 'dna_result'), 1)
    -- Store result in DB for viewing later
    MySQL.query.await('REPLACE INTO grim_lm_dna_results (cid, target_cid, match_pct, tested_at) VALUES (?,?,?,NOW())', {cid, targetCID, match})

    -- Immediately show result in the tablet/UI — don't wait for the player to manually use the item
    TriggerClientEvent('grim_lovemenu:cl:showDNAResult', src, {
        targetName = targetName,
        matchPct   = match,
        testedAt   = os.date('%Y-%m-%d %H:%M:%S'),
    })

    TriggerEvent('grim_lovemenu:sv:refreshClient', src)
end)

-- - PASSIVE SYMPTOM TICK (batched) -

CreateThread(function()
    while true do
        Wait(Config.STDCheckCooldown * 1000)
        local players = GetPlayers()
        if #players == 0 then goto continue end

        local cidMap = {}
        for _, src in ipairs(players) do
            local c = GetPlayerCID(src)
            if c then cidMap[c] = tonumber(src) end
        end

        local cids = {}
        for c, _ in pairs(cidMap) do cids[#cids+1] = c end
        if #cids == 0 then goto continue end

        local ph = table.concat((function() local t={} for i=1,#cids do t[i]='?' end return t end)(), ',')
        local rows = MySQL.query.await(
            ('SELECT cid, disease_id FROM grim_lm_std WHERE cured=0 AND cid IN (%s)'):format(ph),
            cids
        )
        if rows and #rows > 0 then
            local byCid = {}
            for _, r in ipairs(rows) do
                if not byCid[r.cid] then byCid[r.cid] = {} end
                byCid[r.cid][#byCid[r.cid]+1] = r.disease_id
            end
            for cid, ids in pairs(byCid) do
                local src = cidMap[cid]
                if src then
                    local picked = ids[math.random(#ids)]
                    for _, d in ipairs(Config.Diseases) do
                        if d.id == picked then
                            TriggerClientEvent('grim_lovemenu:cl:stdSymptom', src, d.label)
                            break
                        end
                    end
                end
            end
        end
        ::continue::
    end
end)

-- - DNA RESULT ITEM USE -
-- When player uses dna_result from inventory, open the result UI

AddEventHandler('grim_lovemenu:internal:useItem', function(src, item)
    if item ~= ItemName('DNAResult', 'dna_result') then return end
    local cid = GetPlayerCID(src)

    -- Fetch most recent result for this player
    local row = MySQL.single.await(
        'SELECT target_cid, match_pct, tested_at FROM grim_lm_dna_results WHERE cid=? ORDER BY tested_at DESC LIMIT 1',
        { cid }
    )
    if not row then
        Notify(src, 'No DNA result data found.', 'error'); return
    end

    -- Resolve target name (may no longer be online)
    local targetName = 'Unknown'
    local targetSrc  = GetSrcByCID(row.target_cid)
    if targetSrc then
        targetName = GetCharName(targetSrc)
    elseif type(GetCitizenName) == 'function' then
        targetName = GetCitizenName(row.target_cid) or row.target_cid or 'Unknown'
    else
        targetName = row.target_cid or 'Unknown'
    end

    TriggerClientEvent('grim_lovemenu:cl:showDNAResult', src, {
        targetName = targetName,
        matchPct   = row.match_pct,
        testedAt   = GrimDateTimeToString(row.tested_at) or 'Unknown',
    })
end)

-- - BIRTH CERTIFICATE ITEM USE -

AddEventHandler('grim_lovemenu:internal:useItem', function(src, item)
    if item ~= ItemName('BirthCertBoy', 'birth_cert_boy') and item ~= ItemName('BirthCertGirl', 'birth_cert_girl') then return end
    local cid    = GetPlayerCID(src)
    local gender = (item == ItemName('BirthCertBoy', 'birth_cert_boy')) and 'boy' or 'girl'

    -- Fetch most recent born child
    local row = MySQL.single.await(
        'SELECT partner_cid, conceived_at, birth_at FROM grim_lm_pregnancy WHERE cid=? AND born=1 AND gender=? ORDER BY birth_at DESC LIMIT 1',
        { cid, gender }
    )

    local partnerName = 'Unknown'
    if row and row.partner_cid then
        local partnerSrc = GetSrcByCID(row.partner_cid)
        if partnerSrc then
            partnerName = GetCharName(partnerSrc)
        elseif type(GetCitizenName) == 'function' then
            -- Try to resolve offline player name via sv_tablet_rebuild helper
            partnerName = GetCitizenName(row.partner_cid) or row.partner_cid or 'Unknown'
        else
            partnerName = row.partner_cid or 'Unknown'
        end
    end

    TriggerClientEvent('grim_lovemenu:cl:showBirthCert', src, {
        gender      = gender,
        partnerName = partnerName,
        birthAt     = GrimDateTimeToString(row and row.birth_at) or 'Unknown',
        conceivedAt = GrimDateTimeToString(row and row.conceived_at) or 'Unknown',
    })
end)
