--[[
    FearX-Crafting | Editable Server Inventory Functions
    =====================================================
    This file contains all atomic inventory operations that interact directly
    with your inventory system. Edit these functions to integrate with your
    preferred inventory resource (ox_inventory, qs-inventory, codem-inventory, etc.)

    These functions are loaded BEFORE core files and define the
    FearXCrafting.Inventory namespace that the rest of the script uses.

    IMPORTANT: Do not rename the functions - only change their internal implementation.
    Each function documents its expected inputs/outputs below.
]]

----------------------------------------------------------------
-- Inventory Detection / Initialization
-- By default, this detects ox_inventory. If you use a different
-- inventory system, replace this block with your own init logic.
----------------------------------------------------------------
local ox_inventory = nil
local inventoryReady = false

if GetResourceState('ox_inventory') == 'started' then
    ox_inventory = exports.ox_inventory
    inventoryReady = true
    print('^2[FearX-Crafting]^7 ox_inventory detected and loaded')
else
    print('^3[FearX-Crafting]^7 ox_inventory not found, using bridge fallback')
end

CreateThread(function()
    Wait(2000)
    if not inventoryReady and GetResourceState('ox_inventory') == 'started' then
        ox_inventory = exports.ox_inventory
        inventoryReady = true
        print('^2[FearX-Crafting]^7 ox_inventory detected (delayed)')
    end
end)

----------------------------------------------------------------
-- FearXCrafting.Inventory.IsOxInventory()
-- Returns: boolean - whether ox_inventory is the active inventory
--
-- If using a different inventory, you can make this always return false
-- and implement the functions below with your own inventory calls.
----------------------------------------------------------------
function FearXCrafting.Inventory.IsOxInventory()
    return inventoryReady and ox_inventory ~= nil
end

----------------------------------------------------------------
-- FearXCrafting.Inventory.GetItemCount(source, itemName)
-- @param source: number - the player server ID
-- @param itemName: string - the item name (e.g. 'water', 'bread')
-- @return: number - the count of the item in the player's inventory
--
-- Example for qs-inventory:
--   return exports['qs-inventory']:GetItemTotalAmount(source, itemName) or 0
--
-- Example for codem-inventory:
--   return exports['codem-inventory']:GetItemCount(source, itemName) or 0
----------------------------------------------------------------
function FearXCrafting.Inventory.GetItemCount(source, itemName)
    if FearXCrafting.Inventory.IsOxInventory() then
        local count = ox_inventory:GetItemCount(source, itemName)
        return count or 0
    end
    local Bridge = exports['fearx_bridge']
    return Bridge:GetItemCount(source, itemName) or 0
end

----------------------------------------------------------------
-- FearXCrafting.Inventory.CanCarryItem(source, itemName, amount)
-- @param source: number - the player server ID
-- @param itemName: string - the item name
-- @param amount: number - the amount to check (default 1)
-- @return: boolean - whether the player can carry the item
--
-- Example for qs-inventory:
--   return exports['qs-inventory']:CanCarryItem(source, itemName, amount)
----------------------------------------------------------------
function FearXCrafting.Inventory.CanCarryItem(source, itemName, amount)
    amount = amount or 1
    if FearXCrafting.Inventory.IsOxInventory() then
        local canCarry = ox_inventory:CanCarryItem(source, itemName, amount)
        return canCarry
    end
    local Bridge = exports['fearx_bridge']
    return Bridge:CanCarryItem(source, itemName, amount)
end

----------------------------------------------------------------
-- FearXCrafting.Inventory.AddItem(source, itemName, amount, metadata)
-- @param source: number - the player server ID
-- @param itemName: string - the item name
-- @param amount: number - quantity to add (default 1)
-- @param metadata: table|nil - optional metadata (durability, craftedBy, etc.)
-- @return: boolean - whether the item was successfully added
--
-- Example for qs-inventory:
--   return exports['qs-inventory']:AddItem(source, itemName, amount, nil, metadata)
----------------------------------------------------------------
function FearXCrafting.Inventory.AddItem(source, itemName, amount, metadata)
    amount = amount or 1
    metadata = metadata or nil
    if FearXCrafting.Inventory.IsOxInventory() then
        local success = ox_inventory:AddItem(source, itemName, amount, metadata)
        FearXCrafting.Debug('AddItem:', itemName, 'x', amount, 'success:', success)
        return success
    end
    local Bridge = exports['fearx_bridge']
    return Bridge:AddItem(source, itemName, amount, metadata)
end

----------------------------------------------------------------
-- FearXCrafting.Inventory.RemoveItem(source, itemName, amount, metadata, slot)
-- @param source: number - the player server ID
-- @param itemName: string - the item name
-- @param amount: number - quantity to remove (default 1)
-- @param metadata: table|nil - optional metadata filter
-- @param slot: number|nil - optional specific slot
-- @return: boolean - whether the item was successfully removed
--
-- Example for qs-inventory:
--   return exports['qs-inventory']:RemoveItem(source, itemName, amount, slot)
----------------------------------------------------------------
function FearXCrafting.Inventory.RemoveItem(source, itemName, amount, metadata, slot)
    amount = amount or 1
    if FearXCrafting.Inventory.IsOxInventory() then
        local success = ox_inventory:RemoveItem(source, itemName, amount, metadata, slot)
        FearXCrafting.Debug('RemoveItem:', itemName, 'x', amount, 'success:', success)
        return success
    end
    local Bridge = exports['fearx_bridge']
    return Bridge:RemoveItem(source, itemName, amount)
end

----------------------------------------------------------------
-- FearXCrafting.Inventory.GetItems(source)
-- @param source: number - the player server ID
-- @return: table - all items in the player's inventory
--
-- Example for qs-inventory:
--   return exports['qs-inventory']:GetInventory(source) or {}
----------------------------------------------------------------
function FearXCrafting.Inventory.GetItems(source)
    if FearXCrafting.Inventory.IsOxInventory() then
        local items = ox_inventory:GetInventoryItems(source)
        return items or {}
    end
    local Bridge = exports['fearx_bridge']
    return Bridge:GetItems(source) or {}
end

----------------------------------------------------------------
-- FearXCrafting.Inventory.GetSlot(source, slot)
-- @param source: number - the player server ID
-- @param slot: number - the inventory slot number
-- @return: table|nil - the item data in that slot, or nil
----------------------------------------------------------------
function FearXCrafting.Inventory.GetSlot(source, slot)
    if FearXCrafting.Inventory.IsOxInventory() then
        local item = ox_inventory:GetSlot(source, slot)
        return item
    end
    return nil
end

----------------------------------------------------------------
-- FearXCrafting.Inventory.GetItemData(itemName)
-- @param itemName: string - the item name
-- @return: table|nil - the item definition/data from the inventory system
--
-- This retrieves the item's registered data (label, weight, durability, etc.)
-- Not player-specific - this is the item template.
----------------------------------------------------------------
function FearXCrafting.Inventory.GetItemData(itemName)
    if FearXCrafting.Inventory.IsOxInventory() then
        local item = ox_inventory:Items(itemName)
        return item
    end
    return nil
end

----------------------------------------------------------------
-- FearXCrafting.Inventory.SetMetadata(source, slot, metadata)
-- @param source: number - the player server ID
-- @param slot: number - the inventory slot number
-- @param metadata: table - the new metadata to set
-- @return: boolean - whether metadata was successfully updated
----------------------------------------------------------------
function FearXCrafting.Inventory.SetMetadata(source, slot, metadata)
    if FearXCrafting.Inventory.IsOxInventory() then
        ox_inventory:SetMetadata(source, slot, metadata)
        return true
    end
    return false
end

----------------------------------------------------------------
-- FearXCrafting.Inventory.GetDamagedItems(source, threshold)
-- @param source: number - the player server ID
-- @param threshold: number - durability threshold (default 100, items below this are "damaged")
-- @return: table - array of damaged items with slot, name, label, durability, metadata, count
--
-- Used by the repair bench system. If your inventory doesn't support
-- durability/metadata, return an empty table.
----------------------------------------------------------------
function FearXCrafting.Inventory.GetDamagedItems(source, threshold)
    threshold = threshold or 100
    local damagedItems = {}
    if FearXCrafting.Inventory.IsOxInventory() then
        local items = ox_inventory:GetInventoryItems(source)
        if items then
            for slot, item in pairs(items) do
                if item and item.metadata and item.metadata.durability then
                    if item.metadata.durability < threshold then
                        table.insert(damagedItems, {
                            slot = slot,
                            name = item.name,
                            label = item.label,
                            durability = item.metadata.durability,
                            metadata = item.metadata,
                            count = item.count
                        })
                    end
                end
            end
        end
    end
    return damagedItems
end

----------------------------------------------------------------
-- FearXCrafting.Inventory.RepairItem(source, slot, restoreAmount)
-- @param source: number - the player server ID
-- @param slot: number - the inventory slot of the item to repair
-- @param restoreAmount: number - how much durability to restore (default 100)
-- @return: boolean, number - success flag and the new durability value
--
-- Used by the repair bench system.
----------------------------------------------------------------
function FearXCrafting.Inventory.RepairItem(source, slot, restoreAmount)
    restoreAmount = restoreAmount or 100
    if FearXCrafting.Inventory.IsOxInventory() then
        local item = ox_inventory:GetSlot(source, slot)
        if item and item.metadata then
            local currentDurability = item.metadata.durability or 100
            local newDurability = math.min(100, currentDurability + restoreAmount)
            local newMetadata = item.metadata
            newMetadata.durability = newDurability
            ox_inventory:SetMetadata(source, slot, newMetadata)
            FearXCrafting.Debug('Repaired item at slot', slot, 'from', currentDurability, 'to', newDurability)
            return true, newDurability
        end
    end
    return false, 0
end

----------------------------------------------------------------
-- FearXCrafting.Inventory.CreateCraftedItem(source, itemName, amount, recipe)
-- @param source: number - the player server ID
-- @param itemName: string - the item to create
-- @param amount: number - quantity (default 1)
-- @param recipe: table|nil - the recipe data (used to tag metadata)
-- @return: boolean - whether the item was successfully created
--
-- Creates an item with crafting metadata (craftedBy, craftedAt, recipe, durability).
-- Internally calls AddItem with the generated metadata.
----------------------------------------------------------------
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

----------------------------------------------------------------
-- FearXCrafting.Inventory.GetInventoryForUI(source)
-- @param source: number - the player server ID
-- @return: table - formatted inventory items for the NUI/UI
--
-- Returns items formatted for the crafting bench UI display.
-- Each entry has: slot, name, label, count, weight, durability, metadata, image
----------------------------------------------------------------
function FearXCrafting.Inventory.GetInventoryForUI(source)
    local items = FearXCrafting.Inventory.GetItems(source)
    local formattedItems = {}
    local oxSettings = FearXCrafting.Config and FearXCrafting.Config.Get('settings.oxInventory') or {}
    local imagePath = FearXCrafting.ItemImagePath or oxSettings.imagePath or 'nui://ox_inventory/web/images/'
    for slot, item in pairs(items) do
        if item then
            local itemData = FearXCrafting.Inventory.GetItemData(item.name)
            table.insert(formattedItems, {
                slot = slot,
                name = item.name,
                label = item.label or (itemData and itemData.label) or item.name,
                count = item.count or 1,
                weight = item.weight or (itemData and itemData.weight) or 0,
                durability = item.metadata and item.metadata.durability or nil,
                metadata = item.metadata,
                image = imagePath .. (item.name) .. '.png'
            })
        end
    end
    return formattedItems
end

----------------------------------------------------------------
-- FearXCrafting.Inventory.GetAllItems()
-- @return: table - a map of all registered items { [itemName] = { name, label, weight } }
--
-- Returns all item definitions from the active inventory system.
-- Tries sources in order: ox_inventory, QBCore/QBox, ESX, qs-inventory,
-- codem-inventory, core_inventory, then falls back to the database items table.
-- Each source is wrapped in pcall so failures silently move to the next.
----------------------------------------------------------------
function FearXCrafting.Inventory.GetAllItems()
    local result = {}

    local function formatItems(source, items, nameKey)
        local count = 0
        if not items then return 0 end
        for k, item in pairs(items) do
            if type(item) == 'table' then
                local name = item.name or item[nameKey or 'name'] or (type(k) == 'string' and k) or nil
                if name then
                    result[name] = {
                        name = name,
                        label = item.label or name,
                        weight = tonumber(item.weight) or 0,
                    }
                    count = count + 1
                end
            end
        end
        if count > 0 then
            FearXCrafting.Debug('GetAllItems: Loaded', count, 'items from', source)
        end
        return count
    end

    ----------------------------------------------------------------
    -- 1. ox_inventory: exports.ox_inventory:Items()
    ----------------------------------------------------------------
    if FearXCrafting.Inventory.IsOxInventory() then
        local ok, items = pcall(function() return ox_inventory:Items() end)
        if ok and formatItems('ox_inventory', items) > 0 then return result end
    end

    ----------------------------------------------------------------
    -- 2. QBCore / QBox: QBCore.Shared.Items
    --    Used by qb-inventory, ps-inventory, lj-inventory, qs-inventory (on QB)
    ----------------------------------------------------------------
    local qbOk, QBCore = pcall(function()
        if GetResourceState('qb-core') == 'started' then
            return exports['qb-core']:GetCoreObject()
        elseif GetResourceState('qbx_core') == 'started' then
            return exports['qbx_core']:GetCoreObject()
        end
        return nil
    end)
    if qbOk and QBCore and QBCore.Shared and QBCore.Shared.Items then
        if formatItems('QBCore.Shared.Items', QBCore.Shared.Items) > 0 then return result end
    end

    ----------------------------------------------------------------
    -- 3. ESX: ESX.GetItems() or ESX.Items
    --    Works for ESX Legacy default inventory and most ESX-based inventories
    ----------------------------------------------------------------
    local esxOk, ESX = pcall(function()
        if GetResourceState('es_extended') == 'started' then
            return exports['es_extended']:getSharedObject()
        end
        return nil
    end)
    if esxOk and ESX then
        local esxItems = nil
        if type(ESX.GetItems) == 'function' then
            local ok, items = pcall(function() return ESX.GetItems() end)
            if ok and items then esxItems = items end
        end
        if not esxItems and ESX.Items then
            esxItems = ESX.Items
        end
        if esxItems and formatItems('ESX', esxItems, 'item_name') > 0 then return result end
    end

    ----------------------------------------------------------------
    -- 4. qs-inventory: exports['qs-inventory']:GetItemList()
    ----------------------------------------------------------------
    if GetResourceState('qs-inventory') == 'started' then
        local ok, items = pcall(function() return exports['qs-inventory']:GetItemList() end)
        if ok and formatItems('qs-inventory', items) > 0 then return result end
    end

    ----------------------------------------------------------------
    -- 5. codem-inventory: exports['codem-inventory']:GetItemList()
    ----------------------------------------------------------------
    if GetResourceState('codem-inventory') == 'started' then
        local ok, items = pcall(function() return exports['codem-inventory']:GetItemList() end)
        if ok and formatItems('codem-inventory', items) > 0 then return result end
    end

    ----------------------------------------------------------------
    -- 6. core_inventory: exports['core_inventory']:getAllItems()
    ----------------------------------------------------------------
    if GetResourceState('core_inventory') == 'started' then
        local ok, items = pcall(function() return exports['core_inventory']:getAllItems() end)
        if ok and formatItems('core_inventory', items) > 0 then return result end
    end

    ----------------------------------------------------------------
    -- 7. Database fallback: query the items table directly
    --    Works for any framework that stores items in MySQL
    ----------------------------------------------------------------
    local dbOk, dbItems = pcall(function()
        if MySQL and MySQL.query and MySQL.query.await then
            return MySQL.query.await('SELECT `name`, `label`, `weight` FROM `items`')
        elseif GetResourceState('oxmysql') == 'started' then
            return exports.oxmysql:executeSync('SELECT `name`, `label`, `weight` FROM `items`')
        elseif GetResourceState('mysql-async') == 'started' then
            return exports['mysql-async']:mysql_sync_fetchAll('SELECT `name`, `label`, `weight` FROM `items`')
        elseif GetResourceState('ghmattimysql') == 'started' then
            return exports['ghmattimysql']:executeSync('SELECT `name`, `label`, `weight` FROM `items`')
        end
        return nil
    end)
    if dbOk and dbItems and type(dbItems) == 'table' and #dbItems > 0 then
        for _, item in ipairs(dbItems) do
            local name = item.name
            if name then
                result[name] = {
                    name = name,
                    label = item.label or name,
                    weight = tonumber(item.weight) or 0,
                }
            end
        end
        FearXCrafting.Debug('GetAllItems: Loaded', FearXCrafting.TableLength(result), 'items from database')
        return result
    end

    FearXCrafting.Debug('GetAllItems: No items found from any source')
    return result
end

----------------------------------------------------------------
-- FearXCrafting.Inventory.RegisterBenchStash(benchId, benchName)
-- @param benchId: string - unique bench identifier
-- @param benchName: string - display name for the stash
--
-- Registers a stash inventory for a crafting bench (ox_inventory only).
-- If your inventory doesn't support stashes, this can be a no-op.
----------------------------------------------------------------
function FearXCrafting.Inventory.RegisterBenchStash(benchId, benchName)
    local oxSettings = FearXCrafting.Config and FearXCrafting.Config.Get('settings.oxInventory') or {}
    local benchStash = oxSettings.benchStash or {}
    if not benchStash.enabled then return end
    if not FearXCrafting.Inventory.IsOxInventory() then return end
    local stashId = 'fearx_bench_' .. benchId
    ox_inventory:RegisterStash(stashId, benchName .. ' Storage', benchStash.slots or 10, benchStash.weight or 50000)
    FearXCrafting.Debug('Registered stash for bench:', benchId)
end

----------------------------------------------------------------
-- FearXCrafting.Inventory.OpenBenchStash(source, benchId)
-- @param source: number - the player server ID
-- @param benchId: string - unique bench identifier
-- @return: boolean - whether the stash was opened
--
-- Opens the bench stash for a player (ox_inventory only).
----------------------------------------------------------------
function FearXCrafting.Inventory.OpenBenchStash(source, benchId)
    local oxSettings = FearXCrafting.Config and FearXCrafting.Config.Get('settings.oxInventory') or {}
    local benchStash = oxSettings.benchStash or {}
    if not benchStash.enabled then return false end
    if not FearXCrafting.Inventory.IsOxInventory() then return false end
    local stashId = 'fearx_bench_' .. benchId
    ox_inventory:forceOpenInventory(source, 'stash', stashId)
    return true
end
