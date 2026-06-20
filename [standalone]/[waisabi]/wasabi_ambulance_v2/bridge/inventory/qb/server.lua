if not GetResourceState("qb-inventory"):find('start') or GetResourceState("jaksam_inventory"):find('start') then return end

local QBCore = exports['qb-core']:GetCoreObject()
local config, bridge, notify

local inventory = {}

local isOldInventory = false

local inventoryVersion = GetResourceMetadata('qb-inventory', 'version', 0)
inventoryVersion = inventoryVersion:gsub('%.', '')

if inventoryVersion and tonumber(inventoryVersion) and tonumber(inventoryVersion) < 200 then isOldInventory = true end

local registeredShops = {}

function inventory.init()
    config = Modules.require('config')
    bridge = Modules.require('bridge')
    notify = Modules.require('notify')
end

RegisterNetEvent('wasabi_ambulance:Inventory:OpenStash', function(data)
    local src = source
    local identifier = bridge.getIdentifier(src)
    if not identifier then return end

    if not bridge.hasGroup(src, config.ambulanceJobs) then
        if data.label then
            lib.print.warn('[wasabi_ambulance:Inventory:OpenStash] Player does not have a job from config.ambulanceJobs to open stash and attempted to. ID: ' .. data.id .. ' Identifier: ' .. identifier)
        else
            notify(src, { title = locale("medbag_label"), description = locale("no_access_to_this"), type = "error" })
        end
        return
    end

    if not data.label then
        return exports['qb-inventory']:OpenInventory(src, data.id)
    end

    exports['qb-inventory']:OpenInventory(src, data.id, { label = data.label, slots = config.personalLocker.slots, weight = config.personalLocker.weight })
end)

RegisterNetEvent('wasabi_ambulance:Inventory:OpenShop', function(shopType)
    local src = source
    local identifier = bridge.getIdentifier(src)
    if not identifier then return end

    if not bridge.hasGroup(src, config.ambulanceJobs) then
        lib.print.warn('[wasabi_ambulance:Inventory:OpenShop] Player does not have a job from config.ambulanceJobs to open shop and attempted to. Server ID: ' .. src .. ' Identifier: ' .. identifier)
        return
    end

    local shopData = registeredShops[shopType]
    if not shopData then
        lib.print.warn('[wasabi_ambulance:Inventory:OpenShop] Shop type not found: ' .. shopType .. ' Identifier attempting to open: ' .. identifier)
        return
    end

    exports['qb-inventory']:OpenShop(src, shopType)
end)

function inventory.registerStash(id, cfg, groups, coords)
    return id
end

function inventory.registerShop(shopType, shopDetails)
    local items = {}
    if shopDetails.inventory then
        for i, item in ipairs(shopDetails.inventory) do
            items[#items + 1] = {
                name = item.name,
                price = item.price or 0,
                amount = item.count or 999,
            }
        end
    elseif shopDetails.items then
        for i, item in ipairs(shopDetails.items) do
            items[#items + 1] = {
                name = item.name,
                price = item.price or 0,
                amount = item.count or 999,
            }
        end
    end

    local shopData = {
        name = shopType,
        label = shopDetails.name or shopType,
        coords = shopDetails.coords,
        slots = #items,
        items = items
    }

    registeredShops[shopType] = shopData

    exports['qb-inventory']:CreateShop(shopData)
    return shopType
end

function inventory.removeItem(inv, item, count, metadata, slot)
    local source = tonumber(inv)
    if not source then
        lib.print.warn('[qb-inventory] removeItem: inventory must be a player source')
        return false
    end
    return exports['qb-inventory']:RemoveItem(source, item, count, slot or false, 'wasabi_ambulance_v2')
end

function inventory.addItem(src, item, count, metadata)
    return exports['qb-inventory']:AddItem(src, item, count, false, metadata or false, 'wasabi_ambulance_v2')
end

function inventory.getSlot(inv, slot)
    local source = tonumber(inv)
    if not source then
        lib.print.warn('[qb-inventory] getSlot: inv must be a player source')
        return nil
    end
    return exports['qb-inventory']:GetItemBySlot(source, slot)
end

function inventory.setMetadata(inv, slot, metadata)
    local source = tonumber(inv)
    if not source then
        lib.print.warn('[qb-inventory] setMetadata: inv must be a player source')
        return false
    end
    local item = exports['qb-inventory']:GetItemBySlot(source, slot)
    if not item then return false end

    return exports['qb-inventory']:SetItemData(source, item.name, 'info', metadata, slot)
end

function inventory.createTemporaryStash(props)
    local id = props.stashId or ('temp_stash_' .. math.random(100000, 999999))
    local stashData = {
        label = props.label or 'Stash',
        maxweight = props.weight or 100000,
        slots = props.slots or 50,
    }

    exports['qb-inventory']:CreateInventory(id, stashData)

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
                exports['qb-inventory']:AddItem(id, itemName, amount)
            end
        end
    end

    return id
end

function inventory.removeInventory(inv)
    exports['qb-inventory']:RemoveInventory(inv)
end

function inventory.wipePlayer(src)
    local itemsToKeep = config.respawn.itemsToKeep
    if itemsToKeep and #itemsToKeep > 0 then
        exports['qb-inventory']:ClearInventory(src, itemsToKeep)
    else
        exports['qb-inventory']:ClearInventory(src)
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
    local invData = exports['qb-inventory']:GetInventory(inv)
    if invData and invData.items then
        return invData.items
    end
    return {}
end

function inventory.hasItem(src, item, amount, meta)
    return exports['qb-inventory']:HasItem(src, item, amount)
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

Modules.register('inventory', inventory, {
    dependencies = { 'config', 'bridge', 'notify' }
})
