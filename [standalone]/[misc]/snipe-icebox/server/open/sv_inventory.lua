local function useChain(_, data, inv, x, y)
    if not Config.Chains[data.name] then
        print(data.name.." is not a valid chain")
        return
    end
    if not Config.AllowRepair or (inv.items[x].metadata.craftedAt and inv.items[x].metadata.craftedAt > os.time()) then
        local returnData = lib.callback.await("snipe-icebox:useChain", inv.id, data.name, inv.items[x].metadata)
        if returnData and returnData[1] and returnData[2] then
            BuffStuff(inv.id, data.name, inv.items[x].metadata, x)
        end
    else
        ShowNotification(inv.id, Locales["requires_repair_notify"], "error")
        return
    end
    
end

exports("useChain", useChain)

local function useWatch(_, data, inv, x, y)

    if not Config.Watches[data.name] then
        print(data.name.." is not a valid watch")
        return
    end
    if not Config.AllowRepair or (inv.items[x].metadata.craftedAt and inv.items[x].metadata.craftedAt > os.time()) then
        local returnData = lib.callback.await("snipe-icebox:useWatch", inv.id, data.name, inv.items[x].metadata)
        if returnData and returnData[1] and returnData[2] then
            BuffStuff(inv.id, data.name, inv.items[x].metadata, x)
        end
    else
        ShowNotification(inv.id, Locales["requires_repair_notify"], "error")
        return
    end
end

exports("useWatch", useWatch)

CreateThread(function()
    if Config.Inventory == "qb" then
        for k, v in pairs(Config.Chains) do
            QBCore.Functions.CreateUseableItem(k, function(source, item)
                if not Config.AllowRepair or (item.info.craftedAt and item.info.craftedAt > os.time()) then
                    TriggerClientEvent("snipe-icebox:useChain", source, item.name, item.info)
                    BuffStuff(source, item.name, item.info, item.slot)
                else
                    ShowNotification(source, Locales["requires_repair_notify"], "error")
                end
            end)
        end

        for k, v in pairs(Config.Watches) do
            QBCore.Functions.CreateUseableItem(k, function(source, item)
                if not Config.AllowRepair or (item.info.craftedAt and item.info.craftedAt > os.time()) then
                    local returnData = lib.callback.await("snipe-icebox:useWatch", source, item.name, item.info)
                    if returnData[1] and returnData[2] then
                        BuffStuff(source, item.name, item.info, item.slot)
                    end
                else
                    ShowNotification(source, Locales["requires_repair_notify"], "error")
                end
            end)
        end
    elseif Config.Inventory == "qsv2" then
        for k, v in pairs(Config.Chains) do
            exports['qs-inventory']:CreateUsableItem(k, function(source, item)
                if not Config.AllowRepair or (item.info.craftedAt and item.info.craftedAt > os.time()) then
                    TriggerClientEvent("snipe-icebox:useChain", source, item.name, item.info)
                    BuffStuff(source, item.name, item.info, item.slot)
                else
                    ShowNotification(source, Locales["requires_repair_notify"], "error")
                end
            end)
        end

        for k, v in pairs(Config.Watches) do
            exports['qs-inventory']:CreateUsableItem(k, function(source, item)
                if not Config.AllowRepair or (item.info.craftedAt and item.info.craftedAt > os.time()) then
                    local returnData = lib.callback.await("snipe-icebox:useWatch", source, item.name, item.info)
                    if returnData[1] and returnData[2] then
                        BuffStuff(source, item.name, item.info, item.slot)
                    end
                else
                    ShowNotification(source, Locales["requires_repair_notify"], "error")
                end
            end)
        end
    end
end)

function GetMetadataBasedOnSlot(source, slot)
    if Config.Inventory == "ox" then
        local slotInfo = exports.ox_inventory:GetSlot(source, slot)
        return slotInfo, slotInfo.metadata
    elseif Config.Inventory == "qsv2" then
        local slotInfo = exports['qs-inventory']:GetItemBySlot(source, slot)
        return slotInfo,slotInfo.info
    elseif Config.Inventory == "qb" then
        local Player = QBCore.Functions.GetPlayer(source)
        local slotInfo = Player.Functions.GetItemBySlot(slot)
        return slotInfo, slotInfo.info
    end
end

function RemoveItem(source, item, amount)
    if Config.Inventory == "ox" then
        local remove = exports.ox_inventory:RemoveItem(source, item, amount)
        return remove
    elseif Config.Inventory == "qsv2" then
        local remove = exports['qs-inventory']:RemoveItem(source, item, amount)
        return remove
    elseif Config.Inventory == "qb" then
        local Player = QBCore.Functions.GetPlayer(source)
        local remove = Player.Functions.RemoveItem(item, amount)
        return remove
    end
end

function AddItem(source, item, amount, metadata)
    if Config.Inventory == "ox" then
        local add = exports.ox_inventory:AddItem(source, item, amount, metadata)
        return add
    elseif Config.Inventory == "qsv2" then
        local add = exports['qs-inventory']:AddItem(source, item, amount, nil, metadata)
        return add
    elseif Config.Inventory == "qb" then
        local Player = QBCore.Functions.GetPlayer(source)
        local add = Player.Functions.AddItem(item, amount, false, metadata)
        TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[item], "add")
        return add
    end
end

function ReplaceMetadata(source, name, slot, metadata)
    if Config.Inventory == "ox" then
        local replace = exports.ox_inventory:SetMetadata(source, slot, metadata)
    elseif Config.Inventory == "qsv2" then
        exports['qs-inventory']:SetItemMetadata(source, slot, metadata)
    elseif Config.Inventory == "qb" then
        local Player = QBCore.Functions.GetPlayer(source)
        Player.Functions.RemoveItem(name, 1, slot)
        Player.Functions.AddItem(name, 1, slot, metadata)
    end
end

function HasItem(source, item, amount)
    if Config.Inventory == "ox" then
        -- local count = exports.ox_inventory:GetItemCount(source, item)
        local count = exports.ox_inventory:Search(source, 'count', item)
        return count >= amount
    elseif Config.Inventory == "qsv2" then
        local count = exports['qs-inventory']:GetItemTotalAmount(source, item)
        return count >= amount
    elseif Config.Inventory == "qb" then
        local Player = QBCore.Functions.GetPlayer(source)
        local hasItem = Player.Functions.GetItemByName(item)
        if hasItem ~= nil then
            if hasItem.amount >= amount then
                return true
            else
                return false
            end
        else
            return false
        end
    end
end

CreateThread(function()
    if Config.Inventory == "ox" then
        for k, v in pairs(Config.Zones) do
            if v.type == "safe" then
                exports.ox_inventory:RegisterStash(v.stashName, v.stashLabel, v.stashslots, v.stashsize)
            end
        end
    end
end)
