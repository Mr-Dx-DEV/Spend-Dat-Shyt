if not GetResourceState("tgiann-inventory"):find('start') then return end

local config, bridge, notify

local inventory = {}

local tgiann = exports["tgiann-inventory"]

function inventory.init()
    config = Modules.require('config')
    bridge = Modules.require('bridge')
    notify = Modules.require('notify')

    -- Block moving medbag into/out of temporary stashes (same behaviour as ox_inventory bridge)
    local hookId = tgiann:RegisterHook('swapItems', function(_payload)
        return false
    end, {
        print = false,
        itemFilter = {
            medbag = true,
        },
        inventoryFilter = {
            '^temp%-[%w]+',
            '^temp_stash_[%w]+',
        },
    })

    AddEventHandler('onResourceStop', function(resourceName)
        if resourceName == GetCurrentResourceName() then
            tgiann:RemoveHooks(hookId)
        end
    end)
end

local registeredShops = {}

local registeredStashes = {}

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
        return tgiann:OpenInventory(src, "stash", data.id)
    end

    if not registeredStashes[data.id] then
        local function identifierInId(id, playerIdentifier)
            return type(id) == "string" and id:find(playerIdentifier, 1, true) ~= nil
        end

        if identifierInId(data.id, identifier) then
            tgiann:RegisterStash({
                stashName = data.id,
                label = data.label,
                slots = config.personalLocker.slots,
                maxWeight = config.personalLocker.weight,
                jobs = config.ambulanceJobs,
                coords = data.coords,
            })
            registeredStashes[data.id] = true
        end
    end

    tgiann:OpenInventory(src, "stash", data.id, {
        maxWeight = config.personalLocker.weight,
        slots = config.personalLocker.slots,
        label = data.label,
    })
end)

RegisterNetEvent('wasabi_ambulance:Inventory:OpenShop', function(shopType)
    local src = source
    local identifier = bridge.getIdentifier(src)
    if not identifier then return end

    if not bridge.hasGroup(src, config.ambulanceJobs) then
        lib.print.warn('[wasabi_ambulance:Inventory:OpenShop] Player does not have a job from config.ambulanceJobs to open shop and attempted to. Shop: ' .. tostring(shopType) .. ' Server ID: ' .. src .. ' Identifier: ' .. identifier)
        return
    end

    if not registeredShops[shopType] then
        lib.print.warn('[wasabi_ambulance:Inventory:OpenShop] Shop type not found: ' .. tostring(shopType) .. ' Identifier attempting to open: ' .. identifier)
        return
    end

    tgiann:OpenShop(src, shopType)
end)

function inventory.registerStash(id, cfg, groups, coords)
    tgiann:RegisterStash({
        stashName = id,
        label = locale("locker_label"),
        slots = cfg.slots,
        maxWeight = cfg.weight,
        jobs = groups,
        coords = coords
    })
    return id
end

function inventory.registerShop(shopType, shopDetails)
    local items = {}
    for _, item in ipairs(shopDetails.inventory) do
        items[#items + 1] = {
            name = item.name,
            price = item.price or 0,
            amount = item.count or 999,
            type = 'item',
        }
    end
    shopDetails.inventory = items
    tgiann:RegisterShop(shopType, shopDetails.inventory)
    registeredShops[shopType] = true
    return shopType
end

function inventory.removeItem(inv, item, count, metadata, slot)
    local source = tonumber(inv)
    if not source then
        lib.print.warn('[tgiann-inventory] removeItem: inventory must be a player source')
        return false
    end
    return tgiann:RemoveItem(source, item, count, slot, nil)
end

function inventory.addItem(src, item, count, metadata)
    return tgiann:AddItem(src, item, count, nil, metadata, nil)
end

function inventory.getSlot(inv, slot)
    local source = tonumber(inv)
    if not source then
        lib.print.warn('[tgiann-inventory] getSlot: inv must be a player source')
        return nil
    end
    return tgiann:GetItemBySlot(source, slot)
end

function inventory.setMetadata(inv, slot, metadata)
    local source = tonumber(inv)
    if not source then
        lib.print.warn('[tgiann-inventory] setMetadata: inv must be a player source')
        return false
    end

    local item = inventory.getSlot(source, slot)
    if not item then return false end

    return tgiann:UpdateItemMetadata(source, item.name, slot, metadata)
end

function inventory.createTemporaryStash(props)
    local id = props.stashId or ('temp_stash_' .. math.random(100000, 999999))
    local items = {}

    if props and type(props.items) == 'table' then
        for _, item in ipairs(props.items) do
            if type(item) == 'table' then
                if item.name and (item.count or item.amount) then
                    items[#items + 1] = {
                        name = item.name,
                        amount = item.count or item.amount,
                    }
                elseif item[1] and item[2] then
                    items[#items + 1] = { name = item[1], amount = item[2] }
                end
            end
        end
    end

    tgiann:CreateCustomStashWithItem(id, items)

    return id
end

function inventory.removeInventory(inv)
    tgiann:DeleteInventory('stash', inv)
end

function inventory.wipePlayer(src)
    local itemsToKeep = config.respawn.itemsToKeep
    if itemsToKeep and #itemsToKeep > 0 then
        tgiann:ClearInventory(src, itemsToKeep)
    else
        tgiann:ClearInventory(src)
    end
end

function inventory.getItems(inv)
    local source = tonumber(inv)
    if source then
        return tgiann:GetPlayerItems(inv)
    end
    local invData = tgiann:GetSecondaryInventoryItems('stash', inv)
    if invData and invData.items then
        return invData.items
    end
    return tgiann:GetSecondaryInventoryItems('stash', inv) or {}
end

function inventory.hasItem(src, item, amount, meta)
    return tgiann:HasItem(src, item, amount)
end

function inventory.getItemLabel(item)
    return tgiann:GetItemLabel(item) or item
end

Modules.register('inventory', inventory, {
    dependencies = { 'config', 'bridge', 'notify' }
})
