---@type { [number]: boolean }
local hasItemCache = {}

---@param source number
function HasTabletItem(source)
    if hasItemCache[source] ~= nil then
        return hasItemCache[source]
    end

    local hasItem = HasItem(source, Config.Item.Name)

    hasItemCache[source] = hasItem

    return hasItem
end

RegisterNetEvent("tablet:server:hasItemChanged", function()
    local src = source
    local hadItem = hasItemCache[src]

    hasItemCache[src] = HasItem(src, Config.Item.Name)

    if hadItem ~= hasItemCache[src] then
        TriggerEvent("lb-tablet:hasItemChanged", src, hasItemCache[src])
    end
end)

OnPlayerDisconnect(function(source)
    hasItemCache[source] = nil
end)

---@param source number
---@param item string
---@param metadata { [string]: any }
---@return boolean success
function GiveItemWithMetadata(source, item, metadata)
    if GetResourceState("ox_inventory") == "started" then
        local success = exports.ox_inventory:AddItem(source, item, 1, metadata)

        return success
    elseif GetResourceState("qb-inventory") == "started" then
        if not QB then
            infoprint("error", "GiveItemWithMetadata: QB object not found. Make sure to set up your inventory in lb-tablet/server/custom/functions/items.lua")

            return false
        end

        local player = QB.Functions.GetPlayer(source)

        if player then
            local success = player.Functions.AddItem(item, 1, false, metadata)

            return success
        end
    end

    infoprint("warning", "GiveItemWithMetadata: unknown inventory. Set up your inventory in lb-tablet/server/custom/functions/items.lua")

    return false
end

AddEventHandler("ox_inventory:usedItem", function(source, item, _, metadata)
    TriggerEvent("lb-tablet:usedItem", source, item, metadata)
end)

RegisterNetEvent("qb-inventory:server:useItem", function(item)
    local src = source

    if not QB then
        return
    end

    local player = QB.Functions.GetPlayer(src)

    if not player then
        return debugprint("qb-inventory:server:useItem - player not found for source " .. src)
    end

    local itemData = player.Functions.GetItemBySlot(item.slot)

    if not itemData then
        return debugprint("qb-inventory:server:useItem - item data not found for source " .. src .. " and slot " .. item.slot)
    end

    TriggerEvent("lb-tablet:usedItem", source, itemData.name, itemData.info)
end)
