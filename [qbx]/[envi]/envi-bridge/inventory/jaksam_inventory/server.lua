---@diagnostic disable: duplicate-set-field
module 'shared/debug'
module 'shared/resource'

Version = resource.version(Bridge.InventoryName)
Bridge.Debug('Inventory', Bridge.InventoryName, Version)

local jaksam_inventory = exports[Bridge.InventoryName]
local stashes = {}

Framework.OnReady(jaksam_inventory, function() 
    Framework.Items = {}
    for k, v in pairs(jaksam_inventory:getStaticItemsList()) do
        local item = {}
        item.name = k
        item.label = v.label
        item.description = v.description
        item.stack = v.stackable
        item.weight = v.weight or 0
        item.close = v.close
        item.type = v.type
        Framework.Items[k] = item
    end

    setmetatable(Framework.Items, {
        __index = function(table, key)
            error(('^9Item \'%s\' Does Not Exist.^0'):format(tostring(key)), 0)
        end
    })
end)

Framework.AddItem = function(inventory, item, count, metadata, slot)
    if type(inventory) == "string" then inventory = inventory:gsub("%-", "_") end
    if not jaksam_inventory:canCarryItem(inventory, item, count) then return false end
    local success = jaksam_inventory:addItem(inventory, item, count, metadata, slot)
    return success
end

Framework.RemoveItem = function(inventory, item, count, metadata, slot)
    if type(inventory) == "string" then inventory = inventory:gsub("%-", "_") end
    local success = jaksam_inventory:removeItem(inventory, item, count, metadata, slot)
    return success
end

Framework.GetItem = function(inventory, item, metadata, strict)
    local items = {}
    if type(inventory) == "string" then inventory = inventory:gsub("%-", "_") end
    for k, v in pairs(jaksam_inventory:getItemsByName(inventory, item, metadata, strict)) do
        items[#items+1] = {
            name = v.name,
            count = tonumber(v.amount),
            label = Framework.Items[v.name].label,
            description = Framework.Items[v.name].description,
            metadata = v.metadata,
            stack = Framework.Items[v.name].stack,
            weight = Framework.Items[v.name].weight,
            close = Framework.Items[v.name].close,
            image = Framework.Items[v.name].image,
            type = v.type,
            slot = v.slot,
        }
    end
    return items
end

Framework.GetItemCount = function(inventory, item, metadata, strict)
    if type(inventory) == "string" then inventory = inventory:gsub("%-", "_") end
    local amount = 0
    for _, v in pairs(Framework.GetItem(inventory, item, metadata, strict)) do
        amount = amount + v.count
    end
    return amount
end

Framework.HasItem = function(inventory, items, count, metadata, strict)
    if type(inventory) == "string" then inventory = inventory:gsub("%-", "_") end
    if type(items) == "table" then
        if table.type(items) == 'hash' then
            for item, amount in pairs(items) do
                if Framework.GetItemCount(inventory, item, metadata, strict) < amount then
                    return false
                end
            end
            return true
        elseif table.type(items) == 'array' then
            for i = 1, #items do
                local item = items[i]
                if Framework.GetItemCount(inventory, item, metadata, strict) < count then
                    return false
                end
            end
            return true
        end
    else
        return Framework.GetItemCount(inventory, items, metadata, strict) >= count
    end
end

Framework.GetItemMetadata = function(inventory, slot)
    if type(inventory) == "string" then inventory = inventory:gsub("%-", "_") end
    return jaksam_inventory:getItemFromSlot(inventory, slot)?.metadata
end

Framework.SetItemMetadata = function(inventory, slot, metadata)
    if type(inventory) == "string" then inventory = inventory:gsub("%-", "_") end
    jaksam_inventory:setItemMetadataInSlot(inventory, slot, metadata)
end

Framework.GetInventory = function(inventory)
    local items = {}
    if type(inventory) == "string" then inventory = inventory:gsub("%-", "_") end
    for k, v in pairs(jaksam_inventory:getInventory(src).items) do
        items[#items+1] = {
            name = v.name,
            count = tonumber(v.amount),
            label = Framework.Items[v.name].label,
            description = Framework.Items[v.name].description,
            metadata = v.metadata,
            stack = Framework.Items[v.name].stack,
            weight = Framework.Items[v.name].weight,
            close = Framework.Items[v.name].close,
            image = Framework.Items[v.name].image,
            type = Framework.Items[v.name].type,
            slot = v.slot,
        }
    end
    return items
end

if not Framework.CreateUseableItem then
    Framework.CreateUseableItem = function(name, cb)
        jaksam_inventory:registerUsableItem(name, function(source, data)
            cb(source, data.name, { weight = data.weight, count = data.amount or data.count, slot = data.slot, name = data.name, metadata = data.info or data.metadata or {}, label = data.label })
        end)
    end
end

Framework.ClearInventory = function(inventory, keep)
    jaksam_inventory:clearInventory(inventory, keep)
end

Framework.RegisterStash = function(name, slots, weight, owner, groups)
    if not stashes[name] then
        stashes[name] = { slots = slots, weight = weight, owner = owner, groups = groups }
        jaksam_inventory:registerStash({
            id = name,
            label = name,
            maxWeight = weight,
            maxSlots = slots
        })
    end
end

Framework.CreateCallback(Bridge.Resource .. ':bridge:GetStash', function(source, cb, name)
    cb(stashes[name] and stashes[name] or nil)
end)

Framework.RegisterShop = function(name, data)
    jaksam_inventory:RegisterShop(name, {
        name = data.name,
        inventory = data.items,
        groups = data.groups
    })
end

Framework.ConfiscateInventory = function(source)
    local src = source
    local Player = Framework.GetPlayer(src)
    local inventory = jaksam_inventory:getInventory(src)
    Framework.RegisterStash('Confiscated_' .. Player.Identifier, 41, 120000, true)
    Framework.ClearInventory('Confiscated_' .. Player.Identifier)
    for slotname, item in pairs(inventory.items) do
        Framework.AddItem('Confiscated_' .. Player.Identifier, item.name, item.amount, item.metadata, item.slot)
    end
    Framework.ClearInventory(src)
end

Framework.ReturnInventory = function(source)
    local src = source
    local Player = Framework.GetPlayer(src)
    local confiscated = jaksam_inventory:getInventory('Confiscated_' .. Player.Identifier)
    for slotname, item in pairs(confiscated.items) do
        jaksam_inventory:addItem(src, item.name, item.amount, item.metadata, item.slot)
    end
    Framework.ClearInventory('Confiscated_' .. Player.Identifier)
end