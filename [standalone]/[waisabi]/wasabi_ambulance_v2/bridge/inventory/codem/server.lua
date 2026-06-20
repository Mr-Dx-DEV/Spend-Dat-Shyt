if not GetResourceState("codem-inventory"):find('start') then return end

local inventory = {}
local bridge

function inventory.init()
    bridge = Modules.require('bridge')
end

local registeredShops = {}

function inventory.registerStash(id, cfg, groups, coords)
    return id
end

function inventory.registerShop(shopType, shopDetails)
    local items = {}
    for _, item in ipairs(shopDetails.inventory or shopDetails.items) do
        items[#items + 1] = {
            name = item.name,
            price = item.price or 0
        }
    end

    registeredShops[shopType] = items

    return shopType
end

function inventory.removeItem(inv, item, count, metadata, slot)
    local source = tonumber(inv)
    if not source then
        lib.print.warn('[codem-inventory] removeItem: inventory must be a player source')
        return false
    end
    return exports['codem-inventory']:RemoveItem(source, item, count, slot)
end

function inventory.addItem(src, item, count, metadata)
    return exports['codem-inventory']:AddItem(src, item, count, false, metadata or false)
end

function inventory.getSlot(inv, slot)
    local source = tonumber(inv)
    if not source then
        lib.print.warn('[codem-inventory] getSlot: inv must be a player source')
        return nil
    end
    return exports['codem-inventory']:GetItemBySlot(source, slot)
end

function inventory.setMetadata(inv, slot, metadata)
    local source = tonumber(inv)
    if not source then
        lib.print.warn('[codem-inventory] setMetadata: inv must be a player source')
        return false
    end
    local item = exports['codem-inventory']:GetItemBySlot(source, slot)
    if not item then return false end

    return exports['codem-inventory']:SetItemMetadata(source, slot, metadata)
end

function inventory.createTemporaryStash(props)
    local id = props.stashId or ('temp_stash_' .. math.random(100000, 999999))

    local stashItems = {}
    local slot = 1

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
                local itemList = exports['codem-inventory']:GetItemList()
                stashItems[tostring(slot)] = {
                    name = itemName,
                    amount = amount,
                    usable = itemList[itemName] and itemList[itemName].useable,
                    shouldClose = itemList[itemName] and itemList[itemName].shouldClose,
                    description = itemList[itemName] and itemList[itemName].description,
                    unique = itemList[itemName] and itemList[itemName].unique,
                    weight = itemList[itemName] and itemList[itemName].weight,
                    image = itemList[itemName] and itemList[itemName].image,
                    label = itemList[itemName] and itemList[itemName].label,
                    type = itemList[itemName] and itemList[itemName].type,
                    info = {},
                    slot = tostring(slot),

                }
                slot = slot + 1
            end
        end
    end
    exports['codem-inventory']:UpdateStash(id, stashItems)
    return id
end

function inventory.removeInventory(inv)
    exports['codem-inventory']:UpdateStash(inv, {})
end

function inventory.wipePlayer(src)
    exports['codem-inventory']:ClearInventory(src) -- Items to keep are configured within this inventory
end

function inventory.getItems(inv)
    local source = tonumber(inv)
    if source then
        return exports['codem-inventory']:GetInventory(nil, source)
    end
    local invData = exports['codem-inventory']:GetStashItems(inv)
    if invData then return invData end
    return {}
end

function inventory.hasItem(src, item, amount, meta)
    return exports['codem-inventory']:HasItem(src, item, amount)
end

function inventory.getItemLabel(item)
    local itemList = exports['codem-inventory']:GetItemList()
    local itemData = itemList and itemList[item]
    return itemData and itemData.label or item
end

lib.callback.register('wasabi_ambulance:getShopDetails', function(source, shopType)
    return registeredShops[shopType] or false
end)

lib.callback.register('codem-inventory:server:GetUserInventory', function(source)
    local identifier = bridge.getIdentifier(source)
    return exports['codem-inventory']:GetInventory(identifier, source)
end)

Modules.register('inventory', inventory, {
    dependencies = { 'config', 'bridge', 'notify' }
})
