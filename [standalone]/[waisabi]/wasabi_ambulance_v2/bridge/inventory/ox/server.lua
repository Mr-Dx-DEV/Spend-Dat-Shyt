if not GetResourceState("ox_inventory"):find('start') or GetResourceState("jaksam_inventory"):find('start') then return end

local config

local inventory = {}

function inventory.init()
    config = Modules.require('config')

    local hookId = exports.ox_inventory:registerHook('swapItems', function(payload)
        return false
    end, {
        print = true,
        itemFilter = {
            medbag = true,
        },
        inventoryFilter = {
            '^temp-[%w]+'
        }
    })

    AddEventHandler('onResourceStop', function(resourceName)
        if resourceName == GetCurrentResourceName() then
            exports.ox_inventory:removeHooks(hookId)
        end
    end)
end

function inventory.registerStash(id, cfg, groups, coords)
    local oxGroups = {}
    if groups then
        for _, group in ipairs(groups) do
            oxGroups[group] = 0
        end
    end

    return exports.ox_inventory:RegisterStash(id, locale("locker_label"), cfg.slots, cfg.weight, true, groups and oxGroups or nil, coords)
end

function inventory.registerShop(shopType, shopDetails)
    if shopDetails.groups then
        local oxGroups = {}
        for _, group in ipairs(shopDetails.groups) do
            oxGroups[group] = 0
        end
        shopDetails.groups = oxGroups
    end

    return exports.ox_inventory:RegisterShop(shopType, shopDetails)
end

function inventory.removeItem(inv, item, count, _metadata, slot)
    return exports.ox_inventory:RemoveItem(inv, item, count, nil, slot)
end

function inventory.addItem(src, item, count, metadata)
    return exports.ox_inventory:AddItem(src, item, count, metadata)
end

function inventory.getSlot(inv, slot)
    return exports.ox_inventory:GetSlot(inv, slot)
end

function inventory.setMetadata(inv, slot, metadata)
    return exports.ox_inventory:SetMetadata(inv, slot, metadata)
end

function inventory.createTemporaryStash(props)
    if props.items and type(props.items) == 'table' then
        for index, item in ipairs(props.items) do
            props.items[index] = { item[1], item[2] }
        end
    end

    return exports.ox_inventory:CreateTemporaryStash(props)
end

function inventory.removeInventory(inv)
    return exports.ox_inventory:RemoveInventory(inv)
end

function inventory.wipePlayer(src)
    return exports.ox_inventory:ClearInventory(src, config.respawn.itemsToKeep)
end

function inventory.getItems(inv)
    return exports.ox_inventory:GetInventoryItems(inv) or {}
end

function inventory.hasItem(src, item, amount, meta)
    local count = exports.ox_inventory:GetItem(src, item, meta, true)
    return amount and count >= amount or count > 0
end

function inventory.getItemLabel(item)
    local itemData = exports.ox_inventory:Items(item)
    return itemData and itemData.label or item
end

local function handleUsableItem(event, item, inv, slot, data, afterUse, beforeUse)
    if event == 'usingItem' then
        local itemData = inv and inv.items and inv.items[slot] or item
        local context = {
            provider = 'ox_inventory',
            event = event,
            slot = slot,
            consume = data and data.consume
        }

        if beforeUse and type(beforeUse) == 'function' then
            local beforeUseResult = beforeUse(inv.id, itemData, context)
            if beforeUseResult == false then
                return false
            end
        end
        if afterUse and type(afterUse) == 'function' then
            return afterUse(inv.id, itemData, context)
        end
        return
    end
end

function inventory.registerUsableItem(itemName, afterUse, beforeUse)
    exports(itemName, function(event, item, inv, slot, data)
        return handleUsableItem(event, item, inv, slot, data, afterUse, beforeUse)
    end)
end

Modules.register('inventory', inventory, {
    dependencies = { 'config' }
})
