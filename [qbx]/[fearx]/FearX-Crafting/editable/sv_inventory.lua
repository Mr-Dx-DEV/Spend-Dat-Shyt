local Adapters = {}
local AdapterOrder = {}

local function ResourceStarted(resource)
    return GetResourceState and GetResourceState(resource) == 'started'
end

local function Debug(...)
    if FearXCrafting and FearXCrafting.Debug then
        FearXCrafting.Debug(...)
    end
end

local function OrderedInsert(name, priority)
    for index, adapterName in ipairs(AdapterOrder) do
        if adapterName == name then
            table.remove(AdapterOrder, index)
            break
        end
    end
    if priority == 'first' then
        table.insert(AdapterOrder, 1, name)
    else
        table.insert(AdapterOrder, name)
    end
end

function FearXCrafting.Inventory.RegisterAdapter(name, adapter, priority)
    if type(name) ~= 'string' or name == '' or type(adapter) ~= 'table' then
        return false
    end
    adapter.name = adapter.name or name
    Adapters[name] = adapter
    OrderedInsert(name, priority)
    return true
end

function FearXCrafting.Inventory.SetPreferredAdapter(name)
    FearXCrafting.Inventory.PreferredAdapter = name
end

local function AdapterAvailable(adapter)
    if type(adapter.available) ~= 'function' then
        return true
    end
    local ok, result = pcall(adapter.available)
    return ok and result == true
end

local function GetPreferredAdapterName()
    if FearXCrafting.Inventory.PreferredAdapter then
        return FearXCrafting.Inventory.PreferredAdapter
    end
    if FearXCrafting.GetSetting then
        local configured = FearXCrafting.GetSetting('settings.inventory')
        if configured and configured ~= '' and configured ~= 'auto' then
            return configured
        end
    end
    if FearXCrafting.Defaults and FearXCrafting.Defaults.inventory and FearXCrafting.Defaults.inventory ~= 'auto' then
        return FearXCrafting.Defaults.inventory
    end
    return nil
end

local function GetActiveAdapter()
    local preferred = GetPreferredAdapterName()
    if preferred and Adapters[preferred] and AdapterAvailable(Adapters[preferred]) then
        return Adapters[preferred]
    end
    for _, name in ipairs(AdapterOrder) do
        local adapter = Adapters[name]
        if adapter and AdapterAvailable(adapter) then
            return adapter
        end
    end
    return nil
end

function FearXCrafting.Inventory.GetActiveAdapterName()
    local adapter = GetActiveAdapter()
    return adapter and adapter.name or nil
end

function FearXCrafting.Inventory.IsOxInventory()
    return FearXCrafting.Inventory.GetActiveAdapterName() == 'ox_inventory'
end

local function CallAdapter(adapter, method, ...)
    if not adapter or type(adapter[method]) ~= 'function' then
        return nil
    end
    local ok, result, secondary = pcall(adapter[method], ...)
    if not ok then
        Debug('Inventory adapter error:', adapter.name, method, result)
        return nil
    end
    return result, secondary
end

local function CallActive(method, ...)
    local adapter = GetActiveAdapter()
    return CallAdapter(adapter, method, ...)
end

local function CallFirst(method, ...)
    local active = GetActiveAdapter()
    local result, secondary = CallAdapter(active, method, ...)
    if result ~= nil then
        return result, secondary
    end
    for _, name in ipairs(AdapterOrder) do
        local adapter = Adapters[name]
        if adapter ~= active and adapter and AdapterAvailable(adapter) then
            result, secondary = CallAdapter(adapter, method, ...)
            if result ~= nil then
                return result, secondary
            end
        end
    end
    return nil
end

local function NormalizePlayerItems(items)
    local normalized = {}
    if type(items) ~= 'table' then
        return normalized
    end
    local sourceItems = items.items or items.inventory or items.content or items
    if type(sourceItems) ~= 'table' then
        return normalized
    end
    for slot, item in pairs(sourceItems) do
        if type(item) == 'table' then
            local name = item.name or item.item or item.itemName
            if name and name ~= '' then
                local itemSlot = item.slot or slot
                normalized[itemSlot] = {
                    slot = itemSlot,
                    name = name,
                    label = item.label or name,
                    count = tonumber(item.count or item.amount or item.quantity or item.qty) or 1,
                    weight = tonumber(item.weight) or 0,
                    metadata = item.metadata or item.info or item.data,
                    info = item.info,
                }
            end
        end
    end
    return normalized
end

local function CountFromItems(items, itemName)
    local count = 0
    for _, item in pairs(NormalizePlayerItems(items)) do
        if item.name == itemName then
            count = count + (tonumber(item.count) or 0)
        end
    end
    return count
end

local function GetCountThroughAdapter(adapter, source, itemName)
    if adapter and type(adapter.getItemCount) == 'function' then
        local count = CallAdapter(adapter, 'getItemCount', source, itemName)
        if count ~= nil then
            return tonumber(count) or 0
        end
    end
    if adapter and type(adapter.getItems) == 'function' then
        local items = CallAdapter(adapter, 'getItems', source)
        return CountFromItems(items, itemName)
    end
    return nil
end

local function MutationMatches(before, after, amount, mode)
    if before == nil or after == nil then
        return false
    end
    before = tonumber(before)
    after = tonumber(after)
    amount = tonumber(amount) or 1
    if not before or not after then
        return false
    end
    if mode == 'add' then
        return after >= before + amount
    end
    return after <= before - amount
end

local function TryMutation(adapter, source, itemName, amount, mode, calls)
    amount = tonumber(amount) or 1
    local before = GetCountThroughAdapter(adapter, source, itemName)
    if mode == 'remove' and before ~= nil and before < amount then
        return false
    end
    for _, call in ipairs(calls) do
        local ok, result = pcall(call)
        if ok then
            if result == false then
                return false
            end
            if result == true then
                return true
            end
            local after = GetCountThroughAdapter(adapter, source, itemName)
            if MutationMatches(before, after, amount, mode) then
                return true
            end
            if result ~= nil then
                return true
            end
        end
    end
    return false
end

local function GetQBCore()
    if ResourceStarted('qb-core') then
        local ok, core = pcall(function()
            return exports['qb-core']:GetCoreObject()
        end)
        if ok then return core end
    end
    return nil
end

local function GetESX()
    if ResourceStarted('es_extended') then
        local ok, esx = pcall(function()
            return exports['es_extended']:getSharedObject()
        end)
        if ok then return esx end
    end
    return nil
end

local function FormatItemDefinitions(sourceName, items, nameKey, result)
    local count = 0
    if type(items) ~= 'table' then
        return 0
    end
    for key, item in pairs(items) do
        if type(item) == 'table' then
            local name = item.name or item[nameKey or 'name'] or (type(key) == 'string' and key) or nil
            if name and name ~= '' then
                result[name] = {
                    name = name,
                    label = item.label or item.Label or name,
                    weight = tonumber(item.weight or item.Weight) or 0,
                }
                count = count + 1
            end
        end
    end
    if count > 0 then
        Debug('GetAllItems loaded', count, 'items from', sourceName)
    end
    return count
end

local function RegisterOxAdapter()
    FearXCrafting.Inventory.RegisterAdapter('ox_inventory', {
        available = function()
            return ResourceStarted('ox_inventory')
        end,
        getItemCount = function(source, itemName)
            return exports['ox_inventory']:GetItemCount(source, itemName) or 0
        end,
        canCarryItem = function(source, itemName, amount, metadata)
            return exports['ox_inventory']:CanCarryItem(source, itemName, amount or 1, metadata) ~= false
        end,
        addItem = function(source, itemName, amount, metadata)
            local success = exports['ox_inventory']:AddItem(source, itemName, amount or 1, metadata)
            return success == true
        end,
        removeItem = function(source, itemName, amount, metadata, slot)
            local success = exports['ox_inventory']:RemoveItem(source, itemName, amount or 1, metadata, slot)
            return success == true
        end,
        getItems = function(source)
            local inventory = exports['ox_inventory']:GetInventory(source)
            return NormalizePlayerItems(inventory and inventory.items or {})
        end,
        getSlot = function(source, slot)
            return exports['ox_inventory']:GetSlot(source, slot)
        end,
        getItemData = function(itemName)
            return exports['ox_inventory']:Items(itemName)
        end,
        getAllItems = function()
            return exports['ox_inventory']:Items()
        end,
        setMetadata = function(source, slot, metadata)
            exports['ox_inventory']:SetMetadata(source, slot, metadata)
            return true
        end,
        registerStash = function(benchId, benchName, benchStash)
            local stashId = 'fearx_bench_' .. benchId
            exports['ox_inventory']:RegisterStash(stashId, benchName .. ' Storage', benchStash.slots or 10, benchStash.weight or 50000)
            return true
        end,
        openStash = function(source, benchId)
            exports['ox_inventory']:forceOpenInventory(source, 'stash', 'fearx_bench_' .. benchId)
            return true
        end,
    })
end

local function RegisterQsAdapter()
    local adapter = {
        available = function()
            return ResourceStarted('qs-inventory')
        end,
        getItemCount = function(source, itemName)
            return exports['qs-inventory']:GetItemTotalAmount(source, itemName) or 0
        end,
        canCarryItem = function(source, itemName, amount, metadata)
            local result = exports['qs-inventory']:CanCarryItem(source, itemName, amount or 1, metadata)
            return result ~= false
        end,
        getItems = function(source)
            return NormalizePlayerItems(exports['qs-inventory']:GetInventory(source) or {})
        end,
        getAllItems = function()
            return exports['qs-inventory']:GetItemList()
        end,
        getItemData = function(itemName)
            local items = exports['qs-inventory']:GetItemList()
            return type(items) == 'table' and items[itemName] or nil
        end,
        setMetadata = function(source, slot, metadata)
            exports['qs-inventory']:SetItemMetadata(source, slot, metadata)
            return true
        end,
        registerStash = function(benchId, benchName, benchStash)
            return false
        end,
        openStash = function(source, benchId)
            return false
        end,
    }
    adapter.addItem = function(source, itemName, amount, metadata)
        return TryMutation(adapter, source, itemName, amount, 'add', {
            function() return exports['qs-inventory']:AddItem(source, itemName, amount or 1, false, metadata) end,
            function() return exports['qs-inventory']:AddItem(source, itemName, amount or 1, nil, metadata) end,
            function() return exports['qs-inventory']:AddItem(source, itemName, amount or 1, metadata) end,
            function() return exports['qs-inventory']:AddItem(source, itemName, amount or 1) end,
        })
    end
    adapter.removeItem = function(source, itemName, amount, metadata, slot)
        return TryMutation(adapter, source, itemName, amount, 'remove', {
            function() return exports['qs-inventory']:RemoveItem(source, itemName, amount or 1, slot, metadata) end,
            function() return exports['qs-inventory']:RemoveItem(source, itemName, amount or 1, slot) end,
            function() return exports['qs-inventory']:RemoveItem(source, itemName, amount or 1, metadata) end,
            function() return exports['qs-inventory']:RemoveItem(source, itemName, amount or 1) end,
        })
    end
    FearXCrafting.Inventory.RegisterAdapter('qs-inventory', adapter)
end

local function RegisterCodemAdapter()
    local adapter = {
        available = function()
            return ResourceStarted('codem-inventory')
        end,
        getItemCount = function(source, itemName)
            local count = nil
            local ok = pcall(function()
                count = exports['codem-inventory']:GetItemsTotalAmount(source, itemName)
            end)
            if ok and count ~= nil then return count end
            return exports['codem-inventory']:GetItemCount(source, itemName) or 0
        end,
        getItems = function(source)
            return NormalizePlayerItems(exports['codem-inventory']:GetInventory(source) or {})
        end,
        getAllItems = function()
            return exports['codem-inventory']:GetItemList()
        end,
        getItemData = function(itemName)
            local items = exports['codem-inventory']:GetItemList()
            return type(items) == 'table' and items[itemName] or nil
        end,
        getSlot = function(source, slot)
            return exports['codem-inventory']:GetItemBySlot(source, slot)
        end,
        setMetadata = function(source, slot, metadata)
            exports['codem-inventory']:SetItemMetadata(source, slot, metadata)
            return true
        end,
    }
    adapter.canCarryItem = function(source, itemName, amount, metadata)
        local ok, result = pcall(function()
            return exports['codem-inventory']:CanCarryItem(source, itemName, amount or 1, metadata)
        end)
        if ok then return result ~= false end
        return true
    end
    adapter.addItem = function(source, itemName, amount, metadata)
        return TryMutation(adapter, source, itemName, amount, 'add', {
            function() return exports['codem-inventory']:AddItem(source, itemName, amount or 1, nil, metadata) end,
            function() return exports['codem-inventory']:AddItem(source, itemName, amount or 1, metadata) end,
            function() return exports['codem-inventory']:AddItem(source, itemName, amount or 1) end,
        })
    end
    adapter.removeItem = function(source, itemName, amount, metadata, slot)
        return TryMutation(adapter, source, itemName, amount, 'remove', {
            function() return exports['codem-inventory']:RemoveItem(source, itemName, amount or 1, slot) end,
            function() return exports['codem-inventory']:RemoveItem(source, itemName, amount or 1, metadata) end,
            function() return exports['codem-inventory']:RemoveItem(source, itemName, amount or 1) end,
        })
    end
    FearXCrafting.Inventory.RegisterAdapter('codem-inventory', adapter)
end

local function RegisterCoreInventoryAdapter()
    FearXCrafting.Inventory.RegisterAdapter('core_inventory', {
        available = function()
            return ResourceStarted('core_inventory')
        end,
        getItemCount = function(source, itemName)
            return exports['core_inventory']:getItemCount(source, itemName) or 0
        end,
        canCarryItem = function(source, itemName, amount, metadata)
            return exports['core_inventory']:canCarry(source, itemName, amount or 1, metadata) ~= false
        end,
        addItem = function(source, itemName, amount, metadata)
            return exports['core_inventory']:addItem(source, itemName, amount or 1, metadata) ~= false
        end,
        removeItem = function(source, itemName, amount)
            return exports['core_inventory']:removeItem(source, itemName, amount or 1) == true
        end,
        getItems = function(source)
            local inventory = exports['core_inventory']:getInventory(source)
            return NormalizePlayerItems(inventory and (inventory.content or inventory.items or inventory) or {})
        end,
        getSlot = function(source, slot)
            return exports['core_inventory']:getItemBySlot(source, slot)
        end,
        getItemData = function(itemName)
            local items = exports['core_inventory']:getItemsList()
            return type(items) == 'table' and items[itemName] or nil
        end,
        getAllItems = function()
            return exports['core_inventory']:getItemsList()
        end,
    })
end

local function RegisterQbInventoryAdapter(resourceName)
    local adapter = {
        available = function()
            return ResourceStarted(resourceName)
        end,
        getItemCount = function(source, itemName)
            local ok, count = pcall(function()
                return exports[resourceName]:GetItemCount(source, itemName)
            end)
            if ok and count ~= nil then return count end
            local okItem, item = pcall(function()
                return exports[resourceName]:GetItemByName(source, itemName)
            end)
            if okItem and type(item) == 'table' then
                return tonumber(item.amount or item.count) or 0
            end
            return 0
        end,
        canCarryItem = function(source, itemName, amount)
            local ok, result = pcall(function()
                return exports[resourceName]:CanAddItem(source, itemName, amount or 1)
            end)
            if ok then return result == true end
            return true
        end,
        addItem = function(source, itemName, amount, metadata)
            return exports[resourceName]:AddItem(source, itemName, amount or 1, false, metadata, 'fearx-crafting') == true
        end,
        removeItem = function(source, itemName, amount, metadata, slot)
            return exports[resourceName]:RemoveItem(source, itemName, amount or 1, slot or false, 'fearx-crafting') == true
        end,
        getItems = function(source)
            return NormalizePlayerItems(exports[resourceName]:GetInventory(source) or {})
        end,
        getSlot = function(source, slot)
            return exports[resourceName]:GetItemBySlot(source, slot)
        end,
        getItemData = function(itemName)
            local core = GetQBCore()
            return core and core.Shared and core.Shared.Items and core.Shared.Items[itemName] or nil
        end,
        getAllItems = function()
            local core = GetQBCore()
            return core and core.Shared and core.Shared.Items or nil
        end,
    }
    FearXCrafting.Inventory.RegisterAdapter(resourceName, adapter)
end

local function RegisterQbCoreAdapter()
    FearXCrafting.Inventory.RegisterAdapter('qb-core', {
        available = function()
            return ResourceStarted('qb-core') and GetQBCore() ~= nil
        end,
        getItemCount = function(source, itemName)
            local core = GetQBCore()
            local player = core and core.Functions and core.Functions.GetPlayer(source)
            local item = player and player.Functions and player.Functions.GetItemByName(itemName)
            return item and (tonumber(item.amount or item.count) or 0) or 0
        end,
        canCarryItem = function()
            return true
        end,
        addItem = function(source, itemName, amount, metadata)
            local core = GetQBCore()
            local player = core and core.Functions and core.Functions.GetPlayer(source)
            if not player or not player.Functions then return false end
            return player.Functions.AddItem(itemName, amount or 1, false, metadata) == true
        end,
        removeItem = function(source, itemName, amount, metadata, slot)
            local core = GetQBCore()
            local player = core and core.Functions and core.Functions.GetPlayer(source)
            if not player or not player.Functions then return false end
            return player.Functions.RemoveItem(itemName, amount or 1, slot or false) == true
        end,
        getItems = function(source)
            local core = GetQBCore()
            local player = core and core.Functions and core.Functions.GetPlayer(source)
            return NormalizePlayerItems(player and player.PlayerData and player.PlayerData.items or {})
        end,
        getItemData = function(itemName)
            local core = GetQBCore()
            return core and core.Shared and core.Shared.Items and core.Shared.Items[itemName] or nil
        end,
        getAllItems = function()
            local core = GetQBCore()
            return core and core.Shared and core.Shared.Items or nil
        end,
    })
end

local function RegisterEsxAdapter()
    local adapter = {
        available = function()
            local esx = GetESX()
            return esx ~= nil
        end,
        getPlayer = function(source)
            local esx = GetESX()
            return esx and esx.GetPlayerFromId(source) or nil
        end,
    }
    adapter.getItemCount = function(source, itemName)
        local player = adapter.getPlayer(source)
        local item = player and player.getInventoryItem and player.getInventoryItem(itemName)
        return item and tonumber(item.count or item.amount) or 0
    end
    adapter.canCarryItem = function(source, itemName, amount)
        local player = adapter.getPlayer(source)
        if player and player.canCarryItem then
            return player.canCarryItem(itemName, amount or 1) ~= false
        end
        return true
    end
    adapter.addItem = function(source, itemName, amount)
        amount = amount or 1
        local player = adapter.getPlayer(source)
        if not player or not player.addInventoryItem then return false end
        return TryMutation(adapter, source, itemName, amount, 'add', {
            function()
                player.addInventoryItem(itemName, amount)
            end,
        })
    end
    adapter.removeItem = function(source, itemName, amount)
        amount = amount or 1
        local player = adapter.getPlayer(source)
        if not player or not player.removeInventoryItem then return false end
        return TryMutation(adapter, source, itemName, amount, 'remove', {
            function()
                player.removeInventoryItem(itemName, amount)
            end,
        })
    end
    adapter.getItems = function(source)
        local player = adapter.getPlayer(source)
        if player and player.getInventory then
            return NormalizePlayerItems(player.getInventory())
        end
        return {}
    end
    adapter.getItemData = function(itemName)
        local esx = GetESX()
        if not esx then return nil end
        if type(esx.GetItems) == 'function' then
            local items = esx.GetItems()
            if type(items) == 'table' then
                return items[itemName]
            end
        end
        return esx.Items and esx.Items[itemName] or nil
    end
    adapter.getAllItems = function()
        local esx = GetESX()
        if not esx then return nil end
        if type(esx.GetItems) == 'function' then
            local items = esx.GetItems()
            if items then return items end
        end
        return esx.Items
    end
    FearXCrafting.Inventory.RegisterAdapter('es_extended', adapter)
end

local function RegisterBridgeAdapter()
    FearXCrafting.Inventory.RegisterAdapter('fearx_bridge', {
        available = function()
            return ResourceStarted('fearx_bridge')
        end,
        getItemCount = function(source, itemName)
            return exports['fearx_bridge']:GetItemCount(source, itemName) or 0
        end,
        canCarryItem = function(source, itemName, amount)
            return exports['fearx_bridge']:CanCarryItem(source, itemName, amount or 1) ~= false
        end,
        addItem = function(source, itemName, amount, metadata)
            return exports['fearx_bridge']:AddItem(source, itemName, amount or 1, metadata) == true
        end,
        removeItem = function(source, itemName, amount)
            return exports['fearx_bridge']:RemoveItem(source, itemName, amount or 1) == true
        end,
        getItems = function(source)
            return NormalizePlayerItems(exports['fearx_bridge']:GetItems(source) or {})
        end,
    })
end

RegisterOxAdapter()
RegisterQsAdapter()
RegisterCodemAdapter()
RegisterCoreInventoryAdapter()
RegisterQbInventoryAdapter('qb-inventory')
RegisterQbInventoryAdapter('ps-inventory')
RegisterQbInventoryAdapter('lj-inventory')
RegisterQbCoreAdapter()
RegisterEsxAdapter()
RegisterBridgeAdapter()

function FearXCrafting.Inventory.GetItemCount(source, itemName)
    local count = CallFirst('getItemCount', source, itemName)
    return tonumber(count) or 0
end

function FearXCrafting.Inventory.CanCarryItem(source, itemName, amount, metadata)
    local result = CallFirst('canCarryItem', source, itemName, amount or 1, metadata)
    if result == nil then
        return true
    end
    return result ~= false
end

function FearXCrafting.Inventory.AddItem(source, itemName, amount, metadata)
    local result = CallFirst('addItem', source, itemName, amount or 1, metadata)
    return result == true
end

function FearXCrafting.Inventory.RemoveItem(source, itemName, amount, metadata, slot)
    local result = CallFirst('removeItem', source, itemName, amount or 1, metadata, slot)
    return result == true
end

function FearXCrafting.Inventory.GetItems(source)
    local items = CallFirst('getItems', source)
    return NormalizePlayerItems(items)
end

function FearXCrafting.Inventory.GetSlot(source, slot)
    local item = CallFirst('getSlot', source, slot)
    return item
end

function FearXCrafting.Inventory.GetItemData(itemName)
    local active = GetActiveAdapter()
    local data = CallAdapter(active, 'getItemData', itemName)
    if data then return data end
    for _, name in ipairs(AdapterOrder) do
        local adapter = Adapters[name]
        if adapter ~= active and adapter and AdapterAvailable(adapter) then
            data = CallAdapter(adapter, 'getItemData', itemName)
            if data then return data end
        end
    end
    return nil
end

function FearXCrafting.Inventory.SetMetadata(source, slot, metadata)
    local result = CallFirst('setMetadata', source, slot, metadata)
    return result == true
end

function FearXCrafting.Inventory.GetDamagedItems(source, threshold)
    threshold = threshold or 100
    local damagedItems = {}
    local items = FearXCrafting.Inventory.GetItems(source)
    for slot, item in pairs(items) do
        local metadata = item.metadata or item.info
        local durability = metadata and metadata.durability
        if durability and durability < threshold then
            damagedItems[#damagedItems + 1] = {
                slot = slot,
                name = item.name,
                label = item.label,
                durability = durability,
                metadata = metadata,
                count = item.count
            }
        end
    end
    return damagedItems
end

function FearXCrafting.Inventory.RepairItem(source, slot, restoreAmount)
    restoreAmount = restoreAmount or 100
    local item = FearXCrafting.Inventory.GetSlot(source, slot)
    if item and item.metadata then
        local currentDurability = item.metadata.durability or 100
        local newDurability = math.min(100, currentDurability + restoreAmount)
        local metadata = item.metadata
        metadata.durability = newDurability
        if FearXCrafting.Inventory.SetMetadata(source, slot, metadata) then
            return true, newDurability
        end
    end
    return false, 0
end

function FearXCrafting.Inventory.CreateCraftedItem(source, itemName, amount, recipe)
    amount = amount or 1
    local metadata = nil
    local itemData = FearXCrafting.Inventory.GetItemData(itemName)
    if itemData and itemData.durability then
        metadata = {
            durability = 100,
            craftedBy = GetPlayerName(source),
            craftedAt = os.time(),
        }
        if recipe and recipe.name then
            metadata.recipe = recipe.name
        end
    end
    return FearXCrafting.Inventory.AddItem(source, itemName, amount, metadata)
end

function FearXCrafting.Inventory.GetInventoryForUI(source)
    local items = FearXCrafting.Inventory.GetItems(source)
    local formattedItems = {}
    local oxSettings = FearXCrafting.Config and FearXCrafting.Config.Get('settings.oxInventory') or {}
    local imagePath = FearXCrafting.ItemImagePath or oxSettings.imagePath or 'nui://ox_inventory/web/images/'
    for slot, item in pairs(items) do
        if item then
            local itemData = FearXCrafting.Inventory.GetItemData(item.name)
            formattedItems[#formattedItems + 1] = {
                slot = slot,
                name = item.name,
                label = item.label or (itemData and itemData.label) or item.name,
                count = item.count or 1,
                weight = item.weight or (itemData and itemData.weight) or 0,
                durability = item.metadata and item.metadata.durability or nil,
                metadata = item.metadata,
                image = imagePath .. item.name .. '.png'
            }
        end
    end
    return formattedItems
end

function FearXCrafting.Inventory.GetAllItems()
    local result = {}
    local active = GetActiveAdapter()
    local items = CallAdapter(active, 'getAllItems')
    if FormatItemDefinitions(active and active.name or 'active', items, nil, result) > 0 then
        return result
    end
    for _, name in ipairs(AdapterOrder) do
        local adapter = Adapters[name]
        if adapter ~= active and adapter and AdapterAvailable(adapter) then
            items = CallAdapter(adapter, 'getAllItems')
            if FormatItemDefinitions(name, items, nil, result) > 0 then
                return result
            end
        end
    end
    local dbOk, dbItems = pcall(function()
        if MySQL and MySQL.query and MySQL.query.await then
            return MySQL.query.await('SELECT `name`, `label`, `weight` FROM `items`')
        elseif ResourceStarted('oxmysql') then
            return exports.oxmysql:executeSync('SELECT `name`, `label`, `weight` FROM `items`')
        elseif ResourceStarted('mysql-async') then
            return exports['mysql-async']:mysql_sync_fetchAll('SELECT `name`, `label`, `weight` FROM `items`')
        elseif ResourceStarted('ghmattimysql') then
            return exports['ghmattimysql']:executeSync('SELECT `name`, `label`, `weight` FROM `items`')
        end
        return nil
    end)
    if dbOk and type(dbItems) == 'table' then
        FormatItemDefinitions('database', dbItems, nil, result)
    end
    return result
end

function FearXCrafting.Inventory.RegisterBenchStash(benchId, benchName)
    local oxSettings = FearXCrafting.Config and FearXCrafting.Config.Get('settings.oxInventory') or {}
    local benchStash = oxSettings.benchStash or {}
    if not benchStash.enabled then return end
    local result = CallFirst('registerStash', benchId, benchName, benchStash)
    return result == true
end

function FearXCrafting.Inventory.OpenBenchStash(source, benchId)
    local oxSettings = FearXCrafting.Config and FearXCrafting.Config.Get('settings.oxInventory') or {}
    local benchStash = oxSettings.benchStash or {}
    if not benchStash.enabled then return false end
    local result = CallFirst('openStash', source, benchId)
    return result == true
end
