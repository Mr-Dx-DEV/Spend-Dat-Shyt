---@diagnostic disable: duplicate-set-field
module 'shared/debug'
module 'shared/resource'

Version = resource.version(Bridge.InventoryName)
Bridge.Debug('Inventory', Bridge.InventoryName, Version)

local jaksam_inventory = exports[Bridge.InventoryName]
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
        item.image = v.image and v.image or k .. '.png'
        item.type = v.type
        Framework.Items[k] = item
    end

    setmetatable(Framework.Items, {
        __index = function(table, key)
            error(('^9Item \'%s\' Does Not Exist.^0'):format(tostring(key)), 0)
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
        if stash.owner and type(stash.owner) == 'string' and Framework.Player.Identifier ~= stash.owner then return end
        if stash.owner and type(stash.owner) == 'boolean' then name = name .. ":" .. Framework.Player.Identifier end
        jaksam_inventory:openInventory(name)
    end, name)
end

Framework.OpenShop = function(name)
    jaksam_inventory:openInventoryOX('shop', { type = name, id = 1 })
end

Framework.CloseInventory = function()
    jaksam_inventory:closeInventory()
end

Framework.GetItem = function(item, metadata, strict)
    local items = {}
    ---@cast items table<number, Item>
    for k, v in pairs(jaksam_inventory:getItemsByName(item)) do
        if metadata and (strict and not table.matches(v.metadata, metadata) or not table.contains(v.metadata, metadata)) then goto skipLoop end
        items[#items + 1] = {
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
        ::skipLoop::
    end
    return items
end

Framework.HasItem = function(items, count, metadata, strict)
    if type(items) == "string" then
        local counted = 0
        for _, v in pairs(Framework.GetItem(items, metadata, strict)) do
            counted+=v.count
        end
        return counted >= (count or 1)
    elseif type(items) == "table" then
        if table.type(items) == 'hash' then
            for item, amount in pairs(items) do
                local counted = 0
                for _, v in pairs(Framework.GetItem(item, metadata, strict)) do
                    counted+=v.count
                end
                if counted < amount then return false end
            end
            return true
        elseif table.type(items) == 'array' then
            local counted = 0
            for i = 1, #items do
                local item = items[i]
                for _, v in pairs(Framework.GetItem(item, metadata, strict)) do
                    counted+=v.count
                end
                if counted < (count or 1) then return false end
            end
            return true
        end
    end
end

Framework.LockInventory = function()
    jaksam_inventory:setInventoryDisabled(true)
end

Framework.UnlockInventory = function()
    jaksam_inventory:setInventoryDisabled(false)
end
