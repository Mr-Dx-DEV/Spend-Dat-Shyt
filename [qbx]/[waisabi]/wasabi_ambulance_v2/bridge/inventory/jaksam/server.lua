if not GetResourceState("jaksam_inventory"):find('start') then return end

local config
local inventory = {}

function inventory.init()
    config = Modules.require('config')

    local hookId = exports['jaksam_inventory']:registerHook('onItemTransferred', function(payload)
        if payload.item == 'medbag' then
            return false
        end
    end, {
        itemFilter = { medbag = true },
        inventoryFilter = { '^temp-[%w]+' },
    }, 1)

    AddEventHandler('onResourceStop', function(resourceName)
        if resourceName == GetCurrentResourceName() then
            exports['jaksam_inventory']:unregisterHook(hookId)
        end
    end)
end

function inventory.registerStash(id, cfg, groups, coords)
    return exports['jaksam_inventory']:registerStash({
        id = id,
        label = locale("locker_label"),
        maxSlots = cfg.slots,
        maxWeight = cfg.weight,
        allowedJobs = groups,
        coords = coords
    })
end

function inventory.registerShop(shopType, shopDetails)
    if shopDetails.groups then
        local jaksamGroups = {}
        for _, group in ipairs(shopDetails.groups) do
            jaksamGroups[group] = 0
        end
        shopDetails.groups = jaksamGroups
    end

    return exports['jaksam_inventory']:RegisterShop(shopType, {
        name = shopDetails.name,
        inventory = shopDetails.inventory,
        groups = shopDetails.groups,
    })
end

function inventory.removeItem(inv, item, count, _metadata, slot)
    return exports['jaksam_inventory']:removeItem(inv, item, count, nil, slot)
end

function inventory.addItem(src, item, count, metadata)
    return exports['jaksam_inventory']:addItem(src, item, count, metadata)
end

function inventory.getSlot(inv, slot)
    return exports['jaksam_inventory']:getItemFromSlot(inv, slot)
end

function inventory.setMetadata(inv, slot, metadata)
    return exports['jaksam_inventory']:setItemMetadataInSlot(inv, slot, metadata)
end

function inventory.createTemporaryStash(props)
    if props.items and type(props.items) == 'table' then
        for index, item in ipairs(props.items) do
            props.items[index] = { item[1], item[2] }
        end
    end
    props.temporary = true
    props.startingItems = props.items
    props.items = nil
    return exports['jaksam_inventory']:registerStash(props)
end

function inventory.removeInventory(inv)
    return exports['jaksam_inventory']:clearInventory(inv)
end

function inventory.wipePlayer(src)
    return exports['jaksam_inventory']:clearInventory(src, config.respawn.itemsToKeep)
end

function inventory.getItems(inv)
    return exports['jaksam_inventory']:GetInventoryItems(inv)
end

function inventory.hasItem(src, item, amount, meta)
    local count = exports['jaksam_inventory']:getTotalItemAmount(src, item, meta)
    return amount and count >= amount or count > 0
end

function inventory.getItemLabel(item)
    local label

    local success = pcall(function()
        label = exports['jaksam_inventory']:getItemLabel(item)
    end)
    if success and label then return label end

    local itemData
    success = pcall(function()
        itemData = exports['jaksam_inventory']:getItem(item)
    end)
    if success and itemData and itemData.label then return itemData.label end

    return item
end

function inventory.registerUsableItem(itemName, afterUse, beforeUse)
    if beforeUse and type(beforeUse) == 'function' then
        local hookId = exports['jaksam_inventory']:registerHook('onPreUseItem', function(payload)
            local itemData = {
                name = payload.itemName,
                metadata = payload.metadata,
                slot = payload.slotId,
            }
            local context = {
                provider = 'jaksam_inventory',
                event = 'usingItem',
                slot = payload.slotId,
            }
            if beforeUse(payload.inventoryId, itemData, context) == false then
                return false
            end
        end, {
            itemFilter = { [itemName] = true },
        })

        AddEventHandler('onResourceStop', function(resourceName)
            if resourceName == GetCurrentResourceName() then
                exports['jaksam_inventory']:unregisterHook(hookId)
            end
        end)
    end

    -- ESX callback: cb(playerId, itemName, inventoryItem)
    -- QB callback:  cb(playerId, elaboratedItemQB)
    exports['jaksam_inventory']:registerUsableItem(itemName, function(playerId, nameOrItem, item)
        if not afterUse or type(afterUse) ~= 'function' then return end

        local itemData
        if type(item) == 'table' then
            itemData = item
        elseif type(nameOrItem) == 'table' then
            itemData = nameOrItem
        end

        local slotData = {
            amount = itemData.amount or itemData.count,
            metadata = itemData.metadata or itemData.info,
            name = itemData.name,
            slot = itemData.slot
        }

        local context = {
            provider = 'jaksam_inventory',
            event = 'usingItem',
            slot = itemData.slot,
        }
        return afterUse(playerId, slotData, context)
    end, GetInvokingResource())
end

Modules.register('inventory', inventory, {
    dependencies = { 'config' }
})
