---@diagnostic disable: duplicate-set-field
module 'shared/debug'
module 'shared/resource'

Version = resource.version(Bridge.InventoryName)
Bridge.Debug('Inventory', Bridge.InventoryName, Version)

local one_inventory = exports[Bridge.InventoryName]
local stashes = {}

Framework.OnReady(one_inventory, function()
    local function makeItem(name, def)
        local item = {
            name = def.name,
            label = def.label,
            description = def.description,
            stack = def.stack,
            weight = def.weight or 0,
            close = def.close,
        }

        if def.weapon then
            item.type = 'weapon'
        end

        return item
    end

    Framework.Items = setmetatable({}, {
        __index = function (_, key)
            local def = one_inventory:GetItemDefinition(key)

            if not def then
                error(("^9Item '%s' Does Not Exist.^0"):format(tostring(key)), 0)
            end

            return makeItem(key, def)
        end
    })
end)

Framework.AddItem = function(inventory, item, count, metadata, slot)
    if type(inventory) == "string" then
        if stashes[inventory].owner then
            if type(stashes[inventory].owner) == "boolean" then
                inventory = ('stash:%s:%s'):format(inventory, Framework.Player.Identifier)
            else
                inventory = ('stash:%s:%s'):format(inventory, stashes[inventory].owner)
            end
        else
            inventory = ('stash:%s'):format(inventory)
        end
    end
    if not one_inventory:CanCarryItem(inventory, item, count) then return false end
    local success = one_inventory:AddItem(inventory, item, count, metadata, slot)
    return success
end

Framework.RemoveItem = function(inventory, item, count, metadata, slot)
    if type(inventory) == "string" then
        if stashes[inventory].owner then
            if type(stashes[inventory].owner) == "boolean" then
                inventory = ('stash:%s:%s'):format(inventory, Framework.Player.Identifier)
            else
                inventory = ('stash:%s:%s'):format(inventory, stashes[inventory].owner)
            end
        else
            inventory = ('stash:%s'):format(inventory)
        end
    end
    local success = one_inventory:RemoveItem(inventory, item, count, metadata, slot)
    return success
end

Framework.GetItem = function(inventory, item, metadata, strict)
    local items = {}
    ---@cast items table<number, Item>
    for k, v in pairs(Framework.GetInventory(inventory)) do
        if v.name ~= item then goto skipLoop end
        if metadata and (strict and not table.matches(v.metadata, metadata) or not table.contains(v.metadata, metadata)) then goto skipLoop end
        items[#items + 1] = v
        ::skipLoop::
    end
    return items
end

Framework.GetItemCount = function(inventory, item, metadata, strict)
    local count = 0
    for k, v in pairs(Framework.GetInventory(inventory)) do
        if v.name ~= item then goto skipLoop end
        if metadata and (strict and not table.matches(v.metadata, metadata) or not table.contains(v.metadata, metadata)) then
            goto skipLoop
        end
        count+=v.count
        ::skipLoop::
    end
    return count
end

Framework.HasItem = function(inventory, items, count, metadata, strict)
    if type(items) == "string" then
        local counted = 0
        for _, v in pairs(Framework.GetItem(inventory, items, metadata, strict)) do
            counted+=v.count
        end
        return counted >= (count or 1)
    elseif type(items) == "table" then
        if table.type(items) == 'hash' then
            for item, amount in pairs(items) do
                local counted = 0
                for _, v in pairs(Framework.GetItem(inventory, item, metadata, strict)) do
                    counted+=v.count
                end
                if counted < amount then return false end
            end
            return true
        elseif table.type(items) == 'array' then
            local counted = 0
            for i = 1, #items do
                local item = items[i]
                for _, v in pairs(Framework.GetItem(inventory, item, metadata, strict)) do
                    counted+=v.count
                end
                if counted < (count or 1) then return false end
            end
            return true
        end
    end
end

Framework.GetItemMetadata = function(inventory, slot)
    if type(inventory) == "string" then
        if stashes[inventory].owner then
            if type(stashes[inventory].owner) == "boolean" then
                inventory = ('stash:%s:%s'):format(inventory, Framework.Player.Identifier)
            else
                inventory = ('stash:%s:%s'):format(inventory, stashes[inventory].owner)
            end
        else
            inventory = ('stash:%s'):format(inventory)
        end
    end
    return one_inventory:GetSlot(inventory, slot)?.metadata
end

Framework.SetItemMetadata = function(inventory, slot, metadata)
    if type(inventory) == "string" then
        if stashes[inventory].owner then
            if type(stashes[inventory].owner) == "boolean" then
                inventory = ('stash:%s:%s'):format(inventory, Framework.Player.Identifier)
            else
                inventory = ('stash:%s:%s'):format(inventory, stashes[inventory].owner)
            end
        else
            inventory = ('stash:%s'):format(inventory)
        end
    end
    one_inventory:SetItemMetadata(inventory, slot, metadata)
end

Framework.GetInventory = function(inventory)
    if type(inventory) == "number" then
        return one_inventory:GetInventoryItems(inventory)
    else
        if not stashes[inventory] then return {} end
        if stashes[inventory].owner then
            if type(stashes[inventory].owner) == "boolean" then
                inventory = ('stash:%s:%s'):format(inventory, Framework.Player.Identifier)
            else
                inventory = ('stash:%s:%s'):format(inventory, stashes[inventory].owner)
            end
        else
            inventory = ('stash:%s'):format(inventory)
        end
        return one_inventory:GetInventoryItems(inventory)
    end
end

if not Framework.CreateUseableItem then
    local UsableItems = {}

    Framework.CreateUseableItem = function(name, cb)
        UsableItems[name] = cb
    end

    AddEventHandler('one_inventory:onItemUsed', function(payload)
        if not UsableItems[payload.item] then return end
        UsableItems[payload.item](payload.source, payload.item, one_inventory:GetSlot(payload.source, payload.slot))
    end)
end

Framework.ClearInventory = function(inventory, keep)
    if type(inventory) == "string" then
        if stashes[inventory].owner then
            if type(stashes[inventory].owner) == "boolean" then
                inventory = ('stash:%s:%s'):format(inventory, Framework.Player.Identifier)
            else
                inventory = ('stash:%s:%s'):format(inventory, stashes[inventory].owner)
            end
        else
            inventory = ('stash:%s'):format(inventory)
        end
    end
    one_inventory:ClearInventory(inventory, keep)
end

Framework.RegisterStash = function(name, slots, weight, owner, groups)
    if not stashes[name] then
        stashes[name] = { slots = slots, weight = weight, owner = owner, groups = groups }
    end
end

Framework.CreateCallback(Bridge.Resource .. ':bridge:GetStash', function(source, cb, name)
    cb(stashes[name] and stashes[name] or nil)
end)

Framework.RegisterShop = function(name, data)
    
end

Framework.ConfiscateInventory = function(source)
    one_inventory:ConfiscateInventory(source)
end

Framework.ReturnInventory = function(source)
    one_inventory:RestoreInventory(source)
end
