if not GetResourceState("ps-inventory"):find('start') then return end

local QBCore = exports['qb-core']:GetCoreObject()
local config

local inventory = {}

function inventory.init()
    config = Modules.require('config')
end

local registeredShops = {}

function inventory.registerStash(id, cfg, groups, coords)
    return id
end

function inventory.registerShop(shopType, shopDetails)
    local slot = 0

    local shopData = {
        name = shopType,
        label = shopDetails.name or shopType,
        coords = shopDetails.coords,
        items = {}
    }

    for _, item in ipairs(shopDetails.inventory or shopDetails.items) do
        slot = slot + 1
        shopData.items[#shopData.items + 1] = {
            name = item.name,
            price = item.price or 0,
            slot = slot,
            amount = item.count or 999,
            info = {},
        }
    end

    registeredShops[shopType] = {
        name = 'itemshop-' .. shopType,
        label = shopDetails.name or shopType,
        maxweight = 5000000,
        slots = #shopData.items,
        items = shopData.items
    }

    exports['ps-inventory']:CreateShop(shopData)

    return shopType
end

function inventory.removeItem(inv, item, count, metadata, slot)
    local source = tonumber(inv)
    if not source then
        lib.print.warn('[ps-inventory] removeItem: inventory must be a player source')
        return false
    end
    return exports['ps-inventory']:RemoveItem(source, item, count, slot or false, 'wasabi_ambulance_v2')
end

function inventory.addItem(src, item, count, metadata)
    return exports['ps-inventory']:AddItem(src, item, count, false, metadata or false, 'wasabi_ambulance_v2')
end

function inventory.getSlot(inv, slot)
    local source = tonumber(inv)
    if not source then
        lib.print.warn('[ps-inventory] getSlot: inv must be a player source')
        return nil
    end
    return exports['ps-inventory']:GetItemBySlot(source, slot)
end

function inventory.setMetadata(inv, slot, metadata)
    local source = tonumber(inv)
    if not source then
        lib.print.warn('[ps-inventory] setMetadata: inv must be a player source')
        return false
    end
    local item = exports['ps-inventory']:GetItemBySlot(source, slot)
    if not item then return false end

    return exports['ps-inventory']:SetItemData(source, item.name, 'info', metadata, slot)
end

function inventory.createTemporaryStash(props)
    local id = props.stashId or ('temp_stash_' .. math.random(100000, 999999))
    local stashData = {
        label = props.label or 'Stash',
        maxweight = props.weight or 100000,
        slots = props.slots or 50,
    }

    exports['ps-inventory']:CreateInventory(id, stashData)

    if props.items and type(props.items) == 'table' then
        for _, entry in ipairs(props.items) do
            local itemName, amount
            if type(entry) == 'table' then
                if entry.name and entry.count then
                    itemName, amount = entry.name, entry.count
                elseif entry[1] and entry[2] then
                    itemName, amount = entry[1], entry[2]
                end
            end
            if itemName and amount then
                exports['ps-inventory']:AddItem(id, itemName, amount)
            end
        end
    end

    return id
end

function inventory.removeInventory(inv)
    exports['ps-inventory']:RemoveInventory(inv)
end

function inventory.wipePlayer(src)
    local itemsToKeep = config.respawn.itemsToKeep
    if itemsToKeep and #itemsToKeep > 0 then
        exports['ps-inventory']:ClearInventory(src, itemsToKeep)
    else
        exports['ps-inventory']:ClearInventory(src)
    end
end

function inventory.getItems(inv)
    local source = tonumber(inv)
    if source then
        local Player = QBCore.Functions.GetPlayer(source)
        if Player then
            return Player.PlayerData.items
        end
    end
    local invData = exports['ps-inventory']:GetInventory(inv)
    if invData and invData.items then
        return invData.items
    end
    return {}
end

function inventory.hasItem(src, item, amount, meta)
    return exports['ps-inventory']:HasItem(src, item, amount)
end

function inventory.getItemLabel(item)
    local itemData = QBCore.Shared and QBCore.Shared.Items and QBCore.Shared.Items[item]
    return itemData and itemData.label or item
end

function inventory.registerUsableItem(itemName, afterUse, beforeUse)
    QBCore.Functions.CreateUseableItem(itemName, function(source, item)
        if beforeUse and type(beforeUse) == 'function' then
            local beforeUseResult = beforeUse(source, item)
            if beforeUseResult == false then
                return
            end
        end
        if afterUse and type(afterUse) == 'function' then
            afterUse(source, item)
        end
    end)
end

lib.callback.register('wasabi_ambulance:getShopDetails', function(source, shopType)
    return registeredShops[shopType] or false
end)

Modules.register('inventory', inventory, {
    dependencies = { 'config', 'bridge', 'notify' }
})
