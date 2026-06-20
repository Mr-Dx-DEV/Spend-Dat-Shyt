-- oxide-blackmarket: Dirty Money Helpers
-- Abstracts account-based vs item-based dirty money for framework compatibility.
-- Item mode supports two value sources:
--   - stack count (default)
--   - item metadata field (when Config.DirtyMoney.useMetadata = true)

local mode = Config.DirtyMoney.mode
local isItemMode = mode == 'item'
local useMetadata = isItemMode and Config.DirtyMoney.useMetadata == true
local metadataKey = Config.DirtyMoney.metadataKey or 'worth'
local itemName = Config.DirtyMoney.item
local accountName = Config.DirtyMoney.account

local function logEvent(event, source, amount, extra)
    local payload = {
        charId  = olink.character.GetIdentifier(source),
        source  = source,
        amount  = amount,
        mode    = mode,
        account = isItemMode and itemName or accountName,
    }
    if useMetadata then
        payload.useMetadata = true
        payload.metadataKey = metadataKey
    end
    if extra then
        for k, v in pairs(extra) do payload[k] = v end
    end
    olink.logger.Event('oxide-blackmarket', 'money', event, payload)
end

-- Sum every stack of the configured item whose metadata holds a numeric value at metadataKey.
-- Stack count is honored: a stack of N items with metadata.worth=V contributes N*V.
local function sumMetadataValue(source)
    local inventory = olink.inventory.GetPlayerInventory(source) or {}
    local total = 0
    for _, slot in ipairs(inventory) do
        if slot.name == itemName then
            local v = slot.metadata and slot.metadata[metadataKey]
            if type(v) == 'number' and v > 0 then
                total = total + (v * (slot.count or 1))
            end
        end
    end
    return total
end

-- Collect slots until accumulated >= amount, greedy by descending value (fewest bills consumed).
-- Returns: success, accumulated, slotsConsumed[ { slot, count, value } ]
local function collectMetadataSlots(source, amount)
    local inventory = olink.inventory.GetPlayerInventory(source) or {}
    local matches = {}
    for _, slot in ipairs(inventory) do
        if slot.name == itemName then
            local v = slot.metadata and slot.metadata[metadataKey]
            if type(v) == 'number' and v > 0 and slot.slot then
                matches[#matches + 1] = { slot = slot.slot, count = slot.count or 1, value = v }
            end
        end
    end
    table.sort(matches, function(a, b) return a.value > b.value end)

    local accumulated = 0
    local consumed = {}
    for _, m in ipairs(matches) do
        if accumulated >= amount then break end
        local needed = amount - accumulated
        local perItem = m.value
        local takeCount = math.min(m.count, math.ceil(needed / perItem))
        accumulated = accumulated + (perItem * takeCount)
        consumed[#consumed + 1] = { slot = m.slot, count = takeCount, value = perItem }
    end

    if accumulated < amount then return false, accumulated, consumed end
    return true, accumulated, consumed
end

function GetDirtyMoney(source)
    if isItemMode then
        if useMetadata then
            return sumMetadataValue(source)
        end
        return olink.inventory.GetItemCount(source, itemName) or 0
    end
    return olink.money.GetBalance(source, accountName) or 0
end

function AddDirtyMoney(source, amount)
    if amount == nil or amount <= 0 then return false end
    local ok
    if isItemMode then
        if useMetadata then
            ok = olink.inventory.AddItem(source, itemName, 1, nil, { [metadataKey] = amount })
        else
            ok = olink.inventory.AddItem(source, itemName, amount)
        end
    else
        olink.money.Add(source, accountName, amount)
        ok = true
    end
    if ok then logEvent('dirtyMoneyAdded', source, amount) end
    return ok
end

function RemoveDirtyMoney(source, amount)
    if amount == nil or amount <= 0 then return false end
    local ok
    if isItemMode then
        if useMetadata then
            local enough, accumulated, consumed = collectMetadataSlots(source, amount)
            if not enough then return false end

            for _, c in ipairs(consumed) do
                local removed = olink.inventory.RemoveItem(source, itemName, c.count, c.slot)
                if not removed then
                    olink.logger.Warn('oxide-blackmarket', 'money', 'metadata bill removal failed mid-transaction', {
                        source = source,
                        slot   = c.slot,
                        count  = c.count,
                        value  = c.value,
                    })
                    return false
                end
            end

            local change = accumulated - amount
            if change > 0 then
                local added = olink.inventory.AddItem(source, itemName, 1, nil, { [metadataKey] = change })
                if not added then
                    olink.logger.Error('oxide-blackmarket', 'money', 'failed to return change after removing bills', {
                        source = source,
                        change = change,
                    })
                end
            end

            ok = true
            logEvent('dirtyMoneyRemoved', source, amount, { change = change, billsConsumed = #consumed })
            return ok
        end
        ok = olink.inventory.RemoveItem(source, itemName, amount)
    else
        olink.money.Remove(source, accountName, amount)
        ok = true
    end
    if ok then logEvent('dirtyMoneyRemoved', source, amount) end
    return ok
end

DebugPrint(('Money module loaded (mode: %s%s)'):format(mode, useMetadata and ', useMetadata=true' or ''))
