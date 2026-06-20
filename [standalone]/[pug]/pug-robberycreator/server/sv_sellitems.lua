function getSellItemsSettings()
    local result = MySQL.query.await('SELECT settings FROM pug_sellitems WHERE id = 1 LIMIT 1')
    if result and result[1] then
        return result[1].settings
    else
        return '[]'
    end
end

RegisterNetEvent('Pug:saveSellItemsData', function(NewSellItemsData)
    local src = source

    MySQL.query('SELECT settings FROM pug_sellitems WHERE id = 1', {}, function(results)
        local currentData = {}

        if results and #results > 0 then
            currentData = json.decode(results[1].settings) or {}
        end

        for key, value in pairs(NewSellItemsData) do
            currentData[key] = value
        end

        local updatedData = json.encode(currentData)

        MySQL.query('INSERT INTO pug_sellitems (id, settings) VALUES (1, @settings) ON DUPLICATE KEY UPDATE settings = @settings', {
            ['@settings'] = updatedData,
        }, function(result)
            if result then
                -- refresh server cache immediately
                _RefreshSellItemsCache()

                TriggerClientEvent("Pug:client:UpdateSellItemsData", -1, updatedData)
                TriggerClientEvent('Pug:client:ShowHeistNotify', src, Config.LangT["SellItemsDataSaved"])
            else
                TriggerClientEvent('Pug:client:ShowHeistNotify', src, Config.LangT["ErrorSavingSellItemsData"])
            end
        end)
    end)
end)

-- =========================
-- Sell Items (DB-secure)
-- =========================

local _SellItemsCache = { raw = nil, decoded = nil, fetchedAt = 0 }
local _SellItemsCacheMs = 30 * 1000

local function SVHasItem(playerId, item, amount, returnAmount)
    amount = amount or 1
    local inv = Config.InventoryType

    -- ox_inventory
    if inv == "ox_inventory" then
        local count = exports.ox_inventory:GetItemCount(playerId, item)
        return returnAmount and count or (count >= amount)
    end

    -- ps-inventory / lj-inventory
    if inv == "ps-inventory" or inv == "lj-inventory" then
        if returnAmount then
            local info = exports[inv]:GetItemByName(playerId, item)
            return info and info.amount or 0
        else
            return exports[inv]:HasItem(playerId, item, amount)
        end
    end

    -- qs-inventory 
    if inv == "qs-inventory" then
        local totalAmount = exports[inv]:GetItemTotalAmount(playerId, item)
        return returnAmount and (totalAmount or 0) or (totalAmount and totalAmount >= amount)
    end

    -- core_inventory
    if inv == "core_inventory" then
        if returnAmount then
            local data = exports["core_inventory"]:getItem(playerId, item)
            return data and data.amount or 0
        else
            return exports["core_inventory"]:hasItem(playerId, item, amount)
        end
    end

    -- ak47_inventory
    if inv == "ak47_inventory" then
        local amt = exports[inv]:GetAmount(playerId, item)
        return returnAmount and amt or (amt >= amount)
    end

    -- tgiann-inventory
    if inv == "tgiann-inventory" then
        if returnAmount then
            local data = exports[inv]:GetItem(playerId, item)
            return data and data.amount or 0
        else
            return exports[inv]:HasItem(playerId, item, amount)
        end
    end

    -- codem-inventory
    if inv == "codem-inventory" then
        if returnAmount then
            return exports["codem-inventory"]:GetItemsTotalAmount(playerId, item)
        else
            local itemData = exports["codem-inventory"]:HasItem(playerId, item, amount)
            return itemData ~= nil
        end
    end
    if Config.Debug then
        print("^2NO THIRD PARTY INVENTORY FOUND")
    end

    -- ESX fallback
    if Framework == "ESX" then
        local Player = FWork.GetPlayerFromId(playerId)
        if Player then
            local data = Player.getInventoryItem(item)
            local count = data and data.count or 0
            return returnAmount and count or (count >= amount)
        end
        return returnAmount and 0 or false
    else
        -- QBCore-style fallback
        local data = Config.FrameworkFunctions.GetItemByName(playerId, item, amount)
        local count = data and data.amount or 0
        return returnAmount and count or (count >= amount)
    end

    print("[WARN] SVHasItem: inventory type '"..tostring(inv).."' not recognized, returning false.")
    return returnAmount and 0 or false
end

local function _ParseVectorString(vecStr)
    if type(vecStr) ~= "string" then return nil end
    local x, y, z = vecStr:match("([^,]+),%s*([^,]+),%s*([^,]+)")
    x, y, z = tonumber(x), tonumber(y), tonumber(z)
    if not x or not y or not z then return nil end
    return vector3(x, y, z)
end

local function _GetPlayerCoords(src)
    local ped = GetPlayerPed(src)
    if not ped or ped == 0 then return nil end
    local c = GetEntityCoords(ped)
    return vector3(c.x, c.y, c.z)
end

local function _GetSellItemsSettingsRaw()
    local result = MySQL.query.await('SELECT settings FROM pug_sellitems WHERE id = 1 LIMIT 1')
    if result and result[1] and result[1].settings then
        return result[1].settings
    end
    return '[]'
end

local function _GetSellItemsSettingsDecoded()
    local now = GetGameTimer()
    if _SellItemsCache.decoded and (now - _SellItemsCache.fetchedAt) < _SellItemsCacheMs then
        return _SellItemsCache.decoded
    end

    local raw = _GetSellItemsSettingsRaw()
    local decoded = json.decode(raw) or {}
    if type(decoded) ~= "table" then decoded = {} end

    _SellItemsCache.raw = raw
    _SellItemsCache.decoded = decoded
    _SellItemsCache.fetchedAt = now
    return decoded
end

function _RefreshSellItemsCache()
    _SellItemsCache.raw = nil
    _SellItemsCache.decoded = nil
    _SellItemsCache.fetchedAt = 0
end

-- Inventory helpers (server-authoritative)
local function _GetPlayer(src)
    if Framework == "QBCore" then
        return Config.FrameworkFunctions.GetPlayer(src)
    end
    return FWork.GetPlayerFromId(src)
end

local function _RemoveItem(src, item, amount)
    item = string.lower(tostring(item or ""))
    amount = math.floor(tonumber(amount) or 0)
    if item == "" or amount <= 0 then return false end

    if GetResourceState("tgiann-inventory") == 'started' then
        exports["tgiann-inventory"]:RemoveItem(src, item, amount)
        return true
    elseif GetResourceState("ox_inventory") == 'started' then
        exports.ox_inventory:RemoveItem(src, item, amount)
        return true
    end

    local Player = _GetPlayer(src)
    if not Player then return false end

    if Framework == "QBCore" then
        Player.RemoveItem(item, amount)
    else
        Player.removeInventoryItem(item, amount)
    end
    return true
end

local function _GiveItem(src, item, amount, info)
    item = string.lower(tostring(item or ""))
    amount = math.floor(tonumber(amount) or 0)
    if item == "" or amount <= 0 then return false end

    if GetResourceState("tgiann-inventory") == 'started' then
        exports["tgiann-inventory"]:AddItem(src, item, amount)
        return true
    elseif GetResourceState("ox_inventory") == 'started' then
        if exports.ox_inventory:CanCarryItem(src, item, amount) then
            exports.ox_inventory:AddItem(src, item, amount, info)
        else
            exports.ox_inventory:CustomDrop('ItemDropOx', { { item, amount } }, GetEntityCoords(GetPlayerPed(src)), 20, 1000000)
            TriggerClientEvent('Pug:client:ShowHeistNotify', src, Config.LangT["ItemsFellOnGround"], "error")
        end
        return true
    end

    local Player = _GetPlayer(src)
    if not Player then return false end

    if Framework == "QBCore" then
        Player.AddItem(item, amount, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, FWork.Shared.Items[item], "add", amount)
    else
        Player.addInventoryItem(item, amount)
    end
    return true
end

local function _AddMoney(src, moneyType, amount)
    moneyType = tostring(moneyType or "cash")
    amount = math.floor(tonumber(amount) or 0)
    if amount <= 0 then return false end

    local Player = _GetPlayer(src)
    if not Player then return false end

    if Framework == "ESX" then
        if moneyType == "cash" then
            Player.addMoney(amount)
        else
            Player.addAccountMoney("bank", amount)
        end
        return true
    end

    if moneyType ~= "cash" and moneyType ~= "bank" then
        moneyType = "cash"
    end
    Player.AddMoney(moneyType, amount)
    return true
end

local function _FindSellTargetAndItem(settings, srcCoords, itemName)
    if not settings or type(settings) ~= "table" then return nil end
    local targets = settings.targets
    if type(targets) ~= "table" then return nil end

    itemName = string.lower(tostring(itemName or ""))

    local best = nil
    local bestDist = 999999.0

    for _, t in ipairs(targets) do
        local targetVec = _ParseVectorString(t.targetVector)
        if targetVec then
            local dist = #(srcCoords - targetVec)
            if dist <= 2.0 and dist < bestDist then
                if type(t.sellItems) == "table" then
                    for _, si in ipairs(t.sellItems) do
                        if string.lower(tostring(si.itemName or "")) == itemName then
                            best = { target = t, sellItem = si, targetVec = targetVec }
                            bestDist = dist
                            break
                        end
                    end
                end
            end
        end
    end

    return best
end

-- =========================
-- Pending server-side delivery for delayed rewards
-- =========================

local PendingSellTrades = {} -- [src] = { [tradeKey] = tradeData }

AddEventHandler("playerDropped", function()
    PendingSellTrades[source] = nil
end)

local function _TradeKey(targetVec, itemName)
    return ("%0.2f|%0.2f|%0.2f|%s"):format(targetVec.x, targetVec.y, targetVec.z, string.lower(itemName))
end

local function _ComputeFinalSellAmount(src, targetData, sellItemData, itemName)
    local requiredQty = math.floor(tonumber(sellItemData.quantity) or 0)
    if requiredQty <= 0 then return nil, "invalid_required_qty" end

    local have = SVHasItem(src, itemName, sellItemData.quantity, true)
    if have <= 0 then return nil, "no_items" end

    if targetData.sellAllItems == true then
        if have < requiredQty then return nil, "not_enough" end
        return have
    end

    if have < requiredQty then return nil, "not_enough" end
    return requiredQty
end

local function _GetTradeRewardMultiplier(trade)
    local sellQuantity = math.floor(tonumber(trade.sellQuantity) or 0)
    if sellQuantity <= 0 then return 0 end

    local saleUnit = math.floor(tonumber(trade.saleUnit) or sellQuantity)
    if saleUnit <= 0 then saleUnit = sellQuantity end

    local multiplier = math.floor(sellQuantity / saleUnit)
    if multiplier < 1 then multiplier = 1 end

    return multiplier
end

local function _FulfillTrade(src, trade)
    local have = SVHasItem(src, trade.itemName, trade.sellQuantity, true)
    if have < trade.sellQuantity then
        TriggerClientEvent('Pug:client:ShowHeistNotify', src, Config.T("TradeItemsMissing"), "error")
        return false
    end

    if not _RemoveItem(src, trade.itemName, trade.sellQuantity) then
        TriggerClientEvent('Pug:client:ShowHeistNotify', src, Config.T("TradeRemoveFailed"), "error")
        return false
    end

    local rewardMultiplier = _GetTradeRewardMultiplier(trade)

    if type(trade.rewardItems) == "table" then
        for _, r in ipairs(trade.rewardItems) do
            local chance = tonumber(r.rewardItemChance) or 100
            if math.random(1, 100) <= chance then
                local minA = tonumber(r.rewardItemMin) or 1
                local maxA = tonumber(r.rewardItemMax) or minA
                if maxA < minA then maxA = minA end

                local qty = math.random(minA, maxA) * rewardMultiplier
                _GiveItem(src, r.rewardItemName, qty, nil)
            end
        end
    end

    local minM = tonumber(trade.rewardMoneyMin) or 0
    local maxM = tonumber(trade.rewardMoneyMax) or 0
    if maxM > 0 and maxM >= minM then
        local payout = math.random(minM, maxM) * rewardMultiplier
        _AddMoney(src, trade.rewardMoneyType or "cash", payout)
    end

    return true
end

local function _StartPendingTradeLoop(src, tradeKey)
    CreateThread(function()
        while true do
            Wait(2000)

            local playerTrades = PendingSellTrades[src]
            if not playerTrades then return end
            local trade = playerTrades[tradeKey]
            if not trade then return end

            local now = GetGameTimer()
            if now < trade.readyAt then
                goto continue
            end

            local coords = _GetPlayerCoords(src)
            if not coords then return end

            if #(coords - trade.targetVec) <= (trade.pickupRadius or 3.0) then
                local ok = _FulfillTrade(src, trade)
                playerTrades[tradeKey] = nil
                PendingSellTrades[src] = nil

                if ok then
                    TriggerClientEvent('Pug:client:ShowHeistNotify', src, Config.T("TradeCompletedLong"), "success")
                end
                return
            end

            ::continue::
        end
    end)
end

-- NEW: secure sell event (server-authoritative, supports delayReward without client pickup targets)
RegisterNetEvent("Pug:server:SellItems:Trade", function(itemName)
    local src = source

    itemName = string.lower(tostring(itemName or ""))
    if itemName == "" then return end

    local coords = _GetPlayerCoords(src)
    if not coords then return end

    local settings = _GetSellItemsSettingsDecoded()
    local match = _FindSellTargetAndItem(settings, coords, itemName)
    if not match then
        return
    end

    local t = match.target
    local si = match.sellItem
    local targetVec = match.targetVec
    local tradeKey = _TradeKey(targetVec, itemName)

    if PendingSellTrades[src] and PendingSellTrades[src][tradeKey] then
        TriggerClientEvent('Pug:client:ShowHeistNotify', src, Config.T("OngoingTradeWaiting"), "error")
        return
    end

    local finalAmount, err = _ComputeFinalSellAmount(src, t, si, itemName)
    if not finalAmount then
        if err == "not_enough" then
            TriggerClientEvent('Pug:client:ShowHeistNotify', src, Config.T("NotEnoughItemsToSell"), "error")
        end
        return
    end

    local delayEnabled = (si.delayReward == true)
    local delaySeconds = math.floor(tonumber(si.rewardDelayTime) or 0)
    if delaySeconds < 0 then delaySeconds = 0 end

    if not delayEnabled or delaySeconds == 0 then
        local trade = {
            itemName = itemName,
            sellQuantity = finalAmount,
            saleUnit = si.quantity,
            rewardItems = si.rewardItems,
            rewardMoneyType = si.rewardMoneyType,
            rewardMoneyMin = si.rewardMoneyMin,
            rewardMoneyMax = si.rewardMoneyMax,
        }
        local ok = _FulfillTrade(src, trade)
        if ok then
            TriggerClientEvent('Pug:client:ShowHeistNotify', src, Config.T("TradeCompleted"), "success")
        end
        return
    end

    PendingSellTrades[src] = PendingSellTrades[src] or {}

    PendingSellTrades[src][tradeKey] = {
        itemName = itemName,
        sellQuantity = finalAmount,
        saleUnit = si.quantity,
        targetVec = targetVec,
        pickupRadius = 3.0,
        readyAt = GetGameTimer() + (delaySeconds * 1000),

        rewardItems = si.rewardItems,
        rewardMoneyType = si.rewardMoneyType,
        rewardMoneyMin = si.rewardMoneyMin,
        rewardMoneyMax = si.rewardMoneyMax,
    }

    TriggerClientEvent('Pug:client:ShowHeistNotify', src, Config.T("TradeStartedReturn", delaySeconds), "success")
    _StartPendingTradeLoop(src, tradeKey)
end)
