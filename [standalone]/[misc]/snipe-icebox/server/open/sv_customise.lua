RegisterNetEvent("snipe-icebox:server:removebuff", function(buff)
    local player = QBCore.Functions.GetPlayer(source)
    local cid = player.PlayerData.citizenid
    exports["ps-buffs"]:RemoveBuff(cid, buff)
end)

function GetName(id)
    if Config.Framework== "qb" then
        local player = QBCore.Functions.GetPlayer(id)
        if player ~= nil then
            return player.PlayerData.charinfo.firstname .. " " .. player.PlayerData.charinfo.lastname
        else
            return "Unknown"
        end
    elseif Config.Framework== "esx" then
        local player = ESX.GetPlayerFromId(id)
        if player ~= nil then
            return player.getName()
        else
            return "Unknown"
        end
    end
end

function ShowNotification(source, msg, type)
    if Config.Notification == "qb" then
        TriggerClientEvent('QBCore:Notify', source, msg, type)
    elseif Config.Notification == "esx" then
        TriggerClientEvent('esx:showNotification', source, msg)
    elseif Config.Notification == "ox" then
        TriggerClientEvent('ox_lib:notify', source, {type = type, description = msg})
    end
end

lib.callback.register("snipe-icebox:stealChain", function(source, otherPlayerID, data)
    local slot = exports.ox_inventory:GetSlotIdWithItem(otherPlayerID, data.name, data.metadata, true)
    if exports.ox_inventory:RemoveItem(otherPlayerID, data.name, 1, data.metadata, slot) then
        if exports.ox_inventory:AddItem(source, data.name, 1, data.metadata) then
        else
            ShowNotification(source, "inventory full", "error")
            exports.ox_inventory:AddItem(otherPlayerID, data.name, 1, data.metadata)
        end
    else
        ShowNotification(source, "Unable to remove chain from other person", "error")
    end
end)


lib.callback.register("snipe-icebox:repairChain", function(source, name, slot)
    local source = source
    local removedItems = {}
    local removedAllItems = true
    local chainSlot, oldMetadata = GetMetadataBasedOnSlot(source, slot)
    for k, v in pairs(Config.ChainRepairCost) do
        if RemoveItem(source, v.item, v.amount) then
            table.insert(removedItems, {name = v.item, amount = v.amount})
            removedAllItems = true
        else
            removedAllItems = false
        end
    end
    if not oldMetadata then
        oldMetadata = {}
    end
    if Config.RemoveAllInfusedItemsOnRepair then
        oldMetadata = {}
    end
    oldMetadata.craftedAt = os.time() + (Config.TimeToRepair * 24 * 60 * 60)
    if removedAllItems then
        ReplaceMetadata(source, name, slot, oldMetadata)
        return true
    else
        for k, v in pairs(removedItems) do
            AddItem(source, v.name, v.amount)
        end
        return false
    end
end)
