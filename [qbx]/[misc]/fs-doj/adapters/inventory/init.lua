-- MIT License
-- fs-doj Inventory Adapter
-- Universal inventory system adapter

Inventory = {}
local inventorySystem = nil

-- Detect inventory system
local function DetectInventory()
    if Config.Use.inventory ~= 'auto' then
        return Config.Use.inventory
    end

    -- Auto-detect (only ox_inventory and qb-inventory)
    if GetResourceState('ox_inventory') == 'started' then return 'ox_inventory'
    elseif GetResourceState('qb-inventory') == 'started' then return 'qb-inventory'
    end

    return 'framework' -- Fallback to framework inventory
end

-- Initialize
function Inventory.Init()
    inventorySystem = DetectInventory()
    print("^2[fs-doj] Inventory system: " .. inventorySystem .. "^0")
    return inventorySystem
end

-- Add item
function Inventory.AddItem(source, item, count, slot, metadata)
    count = count or 1
    metadata = metadata or {}

    if inventorySystem == 'ox_inventory' then
        -- Debug: Print what we're sending to ox_inventory
        if Config.Debug then
            print('[fs-doj] Adding item to ox_inventory:')
            print('  item:', item)
            print('  count:', count)
            print('  metadata:', json.encode(metadata))
        end

        local success, result = pcall(function()
            return exports.ox_inventory:AddItem(source, item, count, metadata, slot)
        end)
        if success then
            if Config.Debug then
                print('[fs-doj] ✓ ox_inventory AddItem success:', result)
            end
            return result
        else
            if Config.Debug then
                print('[fs-doj] ❌ ox_inventory AddItem error:', result)
            end
            return false
        end
    elseif inventorySystem == 'qb-inventory' then
        local Player = FrameworkAdapter.GetPlayer(source)
        if Player then
            -- QBCore/QBox: metadata is stored in 'info' field
            local success, result = pcall(function()
                return Player.Functions.AddItem(item, count, slot, metadata)
            end)
            if success and result then
                -- Try to trigger inventory notification (may not exist in all QB versions)
                pcall(function()
                    -- Get QBCore object safely
                    local QBCore = nil
                    if GetResourceState('qb-core') == 'started' then
                        QBCore = exports['qb-core']:GetCoreObject()
                    elseif GetResourceState('qbx_core') == 'started' then
                        QBCore = exports.qbx_core
                    end

                    if QBCore and QBCore.Shared and QBCore.Shared.Items and QBCore.Shared.Items[item] then
                        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[item], 'add', count)
                    end
                end)
                return result
            else
                if Config.Debug then
                    print('[fs-doj] ❌ qb-inventory AddItem error:', result)
                end
                return false
            end
        end
    elseif inventorySystem == 'framework' then
        return FrameworkAdapter.AddItem(source, item, count, metadata)
    end

    return false
end

-- Remove item
function Inventory.RemoveItem(source, item, count, slot, metadata)
    count = count or 1

    if inventorySystem == 'ox_inventory' then
        return exports.ox_inventory:RemoveItem(source, item, count, metadata, slot)
    elseif inventorySystem == 'qb-inventory' then
        local Player = FrameworkAdapter.GetPlayer(source)
        if Player then
            return Player.Functions.RemoveItem(item, count, slot)
        end
    elseif inventorySystem == 'framework' then
        return FrameworkAdapter.RemoveItem(source, item, count)
    end

    return false
end

-- Get item
function Inventory.GetItem(source, item, metadata)
    if inventorySystem == 'ox_inventory' then
        return exports.ox_inventory:GetItem(source, item, metadata, true)
    elseif inventorySystem == 'qb-inventory' then
        local Player = FrameworkAdapter.GetPlayer(source)
        if Player then
            return Player.Functions.GetItemByName(item)
        end
    elseif inventorySystem == 'framework' then
        return {name = item, count = FrameworkAdapter.GetItemCount(source, item)}
    end

    return nil
end

-- Get item count
function Inventory.GetItemCount(source, item, metadata)
    if inventorySystem == 'ox_inventory' then
        return exports.ox_inventory:GetItemCount(source, item, metadata, true)
    elseif inventorySystem == 'framework' then
        return FrameworkAdapter.GetItemCount(source, item)
    else
        local itemData = Inventory.GetItem(source, item, metadata)
        return itemData and (itemData.amount or itemData.count or 0) or 0
    end
end

-- Has item
function Inventory.HasItem(source, item, count, metadata)
    count = count or 1
    return Inventory.GetItemCount(source, item, metadata) >= count
end

-- Get all items
function Inventory.GetInventory(source)
    if inventorySystem == 'ox_inventory' then
        return exports.ox_inventory:GetInventoryItems(source)
    elseif inventorySystem == 'framework' then
        return FrameworkAdapter.GetInventory(source)
    elseif inventorySystem == 'qb-inventory' then
        local Player = FrameworkAdapter.GetPlayer(source)
        if Player then
            return Player.PlayerData.items
        end
    end

    return {}
end

-- Can carry item
function Inventory.CanCarryItem(source, item, count)
    if inventorySystem == 'ox_inventory' then
        return exports.ox_inventory:CanCarryItem(source, item, count)
    end
    -- For other systems, assume they can carry (each system has its own weight management)
    return true
end

-- Search inventory for pattern (for metal detectors)
function Inventory.SearchItems(source, pattern)
    local items = Inventory.GetInventory(source)
    local found = {}

    for _, item in pairs(items) do
        local itemName = item.name or item.item
        if itemName and string.find(string.lower(itemName), string.lower(pattern)) then
            table.insert(found, {
                name = itemName,
                label = item.label or itemName,
                count = item.count or item.amount or 1
            })
        end
    end

    return found
end

-- Register usable item
function Inventory.RegisterUsableItem(item, callback)
    if inventorySystem == 'ox_inventory' then
        exports.ox_inventory:registerHook('createItem', function(item, metadata)
            callback(item, metadata)
        end)
    elseif inventorySystem == 'qb-inventory' then
        -- Get QBCore object safely
        local QBCore = nil
        if GetResourceState('qb-core') == 'started' then
            QBCore = exports['qb-core']:GetCoreObject()
        elseif GetResourceState('qbx_core') == 'started' then
            QBCore = exports.qbx_core:GetCoreObject()
        end
        if QBCore then
            QBCore.Functions.CreateUseableItem(item, callback)
        end
    end
end

return Inventory
