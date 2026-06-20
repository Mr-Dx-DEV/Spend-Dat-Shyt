---@diagnostic disable: duplicate-set-field
module 'shared/debug'
module 'shared/resource'

Version = resource.version(Bridge.InventoryName)
Bridge.Debug('Inventory', Bridge.InventoryName, Version)

local one_inventory = exports[Bridge.InventoryName]
Framework.OnReady(one_inventory, function()
    local function makeItem(name, def)
        local item = {
            name = def.name,
            label = def.label,
            description = def.description,
            stack = def.stack,
            weight = def.weight or 0,
            close = def.close,
            image = name .. '.png',
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

Framework.OpenStash = function(name)
    Framework.TriggerCallback(Bridge.Resource .. ':bridge:GetStash', function(stash)
        if not stash then return end
        local isAllowed = false
        if stash.groups and Framework.HasJob(stash.groups, Framework.Player) then isAllowed = true end
        if stash.groups and Framework.HasGang(stash.groups, Framework.Player) then isAllowed = true end
        if stash.groups and not isAllowed then return end
        if stash.owner then
            one_inventory:OpenInventory('stash', { id = name, owner = Framework.Player.Identifier })
        else
            one_inventory:OpenInventory('stash', name)
        end
    end, name)
end

Framework.OpenShop = function(name)
    one_inventory:OpenInventory('shop', name)
end

Framework.CloseInventory = function()
    one_inventory:CloseInventory()
end

Framework.GetItem = function(item, metadata, strict)
    local items = {}
    ---@cast items table<number, Item>
    for k, v in pairs(one_inventory:GetInventoryItems()) do
        if v.name ~= item then goto skipLoop end
        if metadata and (strict and not table.matches(v.metadata, metadata) or not table.contains(v.metadata, metadata)) then goto skipLoop end
        items[#items + 1] = {
            name = v.name,
            count = tonumber(v.count),
            label = v.label,
            description = v.description,
            metadata = v.metadata,
            stack = not v.unique and true,
            weight = v.weight or 0,
            close = v.shouldClose == nil and true or v.shouldClose,
            image = v.image,
            type = v.type,
            slot = tonumber(v.slot),
        }
        ::skipLoop::
    end
    return items
end

Framework.HasItem = function(items, count, metadata, strict)
    if type(items) == "string" then
        local counted = 0
        for _, v in pairs(Framework.GetItem(items, metadata, strict)) do
            counted += v.count
        end
        return counted >= (count or 1)
    elseif type(items) == "table" then
        if table.type(items) == 'hash' then
            for item, amount in pairs(items) do
                local counted = 0
                for _, v in pairs(Framework.GetItem(item, metadata, strict)) do
                    counted += v.count
                end
                if counted < amount then return false end
            end
            return true
        elseif table.type(items) == 'array' then
            local counted = 0
            for i = 1, #items do
                local item = items[i]
                for _, v in pairs(Framework.GetItem(item, metadata, strict)) do
                    counted += v.count
                end
                if counted < (count or 1) then return false end
            end
            return true
        end
    end
end

Framework.LockInventory = function()
    LocalPlayer.state:set('inv_busy', true, false)
end

Framework.UnlockInventory = function()
    LocalPlayer.state:set('inv_busy', false, false)
end
