-- shared/framework.lua (FIXED VERSION - Enhanced QB/QS Support + QBX)
local Framework = {
    loaded = false,
    name = "ESX",
    object = nil
}

function Framework:Initialize()
    local configFramework = Config and Config.Framework and Config.Framework:upper()
    
    if configFramework and (configFramework == "ESX" or configFramework == "QBCORE" or configFramework == "QBOX") then
        self.name = configFramework
    else
        if GetResourceState("es_extended") == "started" then
            self.name = "ESX"
        elseif GetResourceState("qb-core") == "started" then
            self.name = "QBCORE"
        elseif GetResourceState("qbx-core") == "started" or GetResourceState("qbx_core") == "started" then
            self.name = "QBOX"
        else
            print("[OnlyPics] No framework detected")
            return
        end
    end
    
    if self.name == "ESX" then
        ESX = exports.es_extended:getSharedObject()
        self.object = ESX
        self.loaded = true
        
    elseif self.name == "QBCORE" then
        while not QBCore do
            QBCore = exports['qb-core']:GetCoreObject()
            Citizen.Wait(100)
        end
        self.object = QBCore
        self.loaded = true
        
    elseif self.name == "QBOX" then
        -- QBX-Core doesn't use GetCoreObject
        self.loaded = true
        print("[OnlyPics] QBX-Core detected - using exports")
    end
end

function Framework:GetPlayer(src)
    if not self.loaded then return nil end
    
    if self.name == "ESX" then
        return self.object.GetPlayerFromId(src)
    elseif self.name == "QBCORE" then
        return self.object.Functions.GetPlayer(src)
    elseif self.name == "QBOX" then
        -- Try both resource names
        local success, player = pcall(function()
            return exports.qbx_core:GetPlayer(src)
        end)
        if not success then
            success, player = pcall(function()
                return exports['qbx-core']:GetPlayer(src)
            end)
        end
        return success and player or nil
    end
    return nil
end

function Framework:GetIdentifier(player)
    if not player then return nil end
    
    if self.name == "ESX" then
        return player.identifier
    elseif self.name == "QBCORE" then
        return player.PlayerData.citizenid
    elseif self.name == "QBOX" then
        return player.PlayerData.citizenid
    end
    return nil
end

function Framework:GetName(player)
    if not player then return nil end
    
    if self.name == "ESX" then
        return player.getName()
    elseif self.name == "QBCORE" then
        return player.PlayerData.charinfo.firstname .. " " .. player.PlayerData.charinfo.lastname
    elseif self.name == "QBOX" then
        return player.PlayerData.charinfo.firstname .. " " .. player.PlayerData.charinfo.lastname
    end
    return "Unknown"
end

function Framework:GetMoney(player)
    if not player then return 0 end
    
    if self.name == "ESX" then
        return player.getMoney()
    elseif self.name == "QBCORE" then
        return player.PlayerData.money.cash
    elseif self.name == "QBOX" then
        return player.PlayerData.money.cash
    end
    return 0
end

function Framework:RemoveMoney(player, amount)
    if not player then return false end
    
    if self.name == "ESX" then
        player.removeMoney(amount)
        return true
    elseif self.name == "QBCORE" then
        player.Functions.RemoveMoney("cash", amount)
        return true
    elseif self.name == "QBOX" then
        player.Functions.RemoveMoney("cash", amount)
        return true
    end
    return false
end

function Framework:AddMoney(player, amount)
    if not player then return false end
    
    if self.name == "ESX" then
        player.addMoney(amount)
        return true
    elseif self.name == "QBCORE" then
        player.Functions.AddMoney("cash", amount)
        return true
    elseif self.name == "QBOX" then
        player.Functions.AddMoney("cash", amount)
        return true
    end
    return false
end

function Framework:CanCarryItem(player, item, amount)
    if not player then return false end
    
    if self.name == "ESX" then
        return player.canCarryItem(item, amount or 1)
    else
        return true
    end
end

function Framework:Notify(src, message, type)
    -- Respect Config.Notification first — if the user set it to ox_lib,
    -- always use ox_lib regardless of which framework we're running under.
    local notifSystem = (Config.Notification and string.lower(Config.Notification)) or 'ox_lib'

    if notifSystem == 'ox_lib' then
        TriggerClientEvent('ox_lib:notify', src, {
            title = 'OnlyPics',
            description = message,
            type = type or 'inform',
            position = 'top'
        })
        return
    end

    if notifSystem == 'esx' then
        TriggerClientEvent('esx:showNotification', src, message)
        return
    end

    if notifSystem == 'qb' or notifSystem == 'qb-core' or notifSystem == 'qbcore' then
        TriggerClientEvent('QBCore:Notify', src, message, type or 'primary')
        return
    end

    if notifSystem == 'custom' then
        TriggerClientEvent('orbit-onlypics:customNotify', src, message, type)
        return
    end

    -- Fallback: framework-native
    if self.name == "ESX" then
        TriggerClientEvent('esx:showNotification', src, message)
    elseif self.name == "QBCORE" then
        TriggerClientEvent('QBCore:Notify', src, message, type or 'primary')
    else
        TriggerClientEvent('ox_lib:notify', src, {
            title = 'OnlyPics',
            description = message,
            type = type or 'inform',
            position = 'top'
        })
    end
end

-- ==========================================
-- INVENTORY SYSTEM FUNCTIONS (ENHANCED)
-- ==========================================

function Framework:AddInventoryItem(source, item, count, metadata)
    local inventoryType = string.upper(Config.Inventory or 'OX_INVENTORY')
    
    if Config.Debug then
        print('[OnlyPics] AddInventoryItem called')
        print('[OnlyPics] Item: ' .. item)
        print('[OnlyPics] Count: ' .. count)
        print('[OnlyPics] Inventory: ' .. inventoryType)
        if metadata then
            print('[OnlyPics] Has metadata: YES')
        else
            print('[OnlyPics] Has metadata: NO')
        end
    end
    
    -- OX INVENTORY
    if inventoryType == 'OX_INVENTORY' or inventoryType == 'OX-INVENTORY' then
        local success = exports.ox_inventory:AddItem(source, item, count, metadata)
        if Config.Debug then
            print('[OnlyPics] ox_inventory AddItem result: ' .. tostring(success))
        end
        return success
        
    -- QB INVENTORY
    elseif inventoryType == 'QB-INVENTORY' or inventoryType == 'QB_INVENTORY' then
        local Player = self:GetPlayer(source)
        if Player then
            -- For QB, metadata goes in the 'info' parameter (4th param)
            local success = Player.Functions.AddItem(item, count, false, metadata)
            if Config.Debug then
                print('[OnlyPics] QB-Inventory AddItem result: ' .. tostring(success))
            end
            
            -- Trigger inventory update
            if self.name == "QBCORE" and self.object and self.object.Shared and self.object.Shared.Items and self.object.Shared.Items[item] then
                TriggerClientEvent('inventory:client:ItemBox', source, self.object.Shared.Items[item], "add")
            end
            return success
        end
        
    -- QS INVENTORY (Enhanced)
    elseif inventoryType == 'QS-INVENTORY' or inventoryType == 'QS_INVENTORY' then
        -- QS-Inventory uses 'info' just like QB
        if exports['qs-inventory'] then
            local success = exports['qs-inventory']:AddItem(source, item, count, nil, metadata)
            if Config.Debug then
                print('[OnlyPics] QS-Inventory AddItem result: ' .. tostring(success))
            end
            return success
        end
        
    -- LJ INVENTORY
    elseif inventoryType == 'LJ-INVENTORY' or inventoryType == 'LJ_INVENTORY' then
        return exports['lj-inventory']:AddItem(source, item, count, metadata)
        
    -- ESX INVENTORY HUD
    elseif inventoryType == 'ESX_INVENTORYHUD' or inventoryType == 'ESX-INVENTORYHUD' then
        local Player = self:GetPlayer(source)
        if Player then
            Player.addInventoryItem(item, count)
            return true
        end
    end
    return false
end

function Framework:RemoveInventoryItem(source, item, count, metadata, slot)
    local inventoryType = string.upper(Config.Inventory or 'OX_INVENTORY')
    
    -- OX INVENTORY
    if inventoryType == 'OX_INVENTORY' or inventoryType == 'OX-INVENTORY' then
        return exports.ox_inventory:RemoveItem(source, item, count, metadata, slot)
        
    -- QB INVENTORY
    elseif inventoryType == 'QB-INVENTORY' or inventoryType == 'QB_INVENTORY' then
        local Player = self:GetPlayer(source)
        if Player then
            local success = Player.Functions.RemoveItem(item, count, slot)
            -- Trigger inventory update
            if self.name == "QBCORE" and self.object and self.object.Shared and self.object.Shared.Items and self.object.Shared.Items[item] then
                TriggerClientEvent('inventory:client:ItemBox', source, self.object.Shared.Items[item], "remove")
            end
            return success
        end
        
    -- QS INVENTORY
    elseif inventoryType == 'QS-INVENTORY' or inventoryType == 'QS_INVENTORY' then
        if exports['qs-inventory'] then
            return exports['qs-inventory']:RemoveItem(source, item, count, slot)
        end
        
    -- LJ INVENTORY
    elseif inventoryType == 'LJ-INVENTORY' or inventoryType == 'LJ_INVENTORY' then
        return exports['lj-inventory']:RemoveItem(source, item, count, slot)
        
    -- ESX INVENTORY HUD
    elseif inventoryType == 'ESX_INVENTORYHUD' or inventoryType == 'ESX-INVENTORYHUD' then
        local Player = self:GetPlayer(source)
        if Player then
            Player.removeInventoryItem(item, count)
            return true
        end
    end
    return false
end

function Framework:GetInventory(source)
    local inventoryType = string.upper(Config.Inventory or 'OX_INVENTORY')
    
    -- OX INVENTORY
    if inventoryType == 'OX_INVENTORY' or inventoryType == 'OX-INVENTORY' then
        return exports.ox_inventory:GetInventory(source)
        
    -- QB INVENTORY
    elseif inventoryType == 'QB-INVENTORY' or inventoryType == 'QB_INVENTORY' then
        local Player = self:GetPlayer(source)
        if Player then
            return {items = Player.PlayerData.items}
        end
        
    -- QS INVENTORY
    elseif inventoryType == 'QS-INVENTORY' or inventoryType == 'QS_INVENTORY' then
        if exports['qs-inventory'] then
            -- QS uses same format as QB
            local Player = self:GetPlayer(source)
            if Player then
                return {items = Player.PlayerData.items}
            end
        end
        
    -- LJ INVENTORY
    elseif inventoryType == 'LJ-INVENTORY' or inventoryType == 'LJ_INVENTORY' then
        return exports['lj-inventory']:GetInventory(source)
        
    -- ESX INVENTORY HUD
    elseif inventoryType == 'ESX_INVENTORYHUD' or inventoryType == 'ESX-INVENTORYHUD' then
        local Player = self:GetPlayer(source)
        if Player then
            return {items = Player.inventory}
        end
    end
    return nil
end

function Framework:GetItem(source, item)
    local inventoryType = string.upper(Config.Inventory or 'OX_INVENTORY')
    
    -- OX INVENTORY
    if inventoryType == 'OX_INVENTORY' or inventoryType == 'OX-INVENTORY' then
        return exports.ox_inventory:GetItem(source, item, nil, true)
        
    -- QB INVENTORY
    elseif inventoryType == 'QB-INVENTORY' or inventoryType == 'QB_INVENTORY' then
        local Player = self:GetPlayer(source)
        if Player then
            local itemData = Player.Functions.GetItemByName(item)
            return itemData and itemData.amount or 0
        end
        
    -- QS INVENTORY
    elseif inventoryType == 'QS-INVENTORY' or inventoryType == 'QS_INVENTORY' then
        if exports['qs-inventory'] and exports['qs-inventory'].GetItemTotalAmount then
            return exports['qs-inventory']:GetItemTotalAmount(source, item)
        else
            -- Fallback to QB method for QS
            local Player = self:GetPlayer(source)
            if Player then
                local itemData = Player.Functions.GetItemByName(item)
                return itemData and itemData.amount or 0
            end
        end
        
    -- LJ INVENTORY
    elseif inventoryType == 'LJ-INVENTORY' or inventoryType == 'LJ_INVENTORY' then
        return exports['lj-inventory']:GetItem(source, item)
        
    -- ESX INVENTORY HUD
    elseif inventoryType == 'ESX_INVENTORYHUD' or inventoryType == 'ESX-INVENTORYHUD' then
        local Player = self:GetPlayer(source)
        if Player then
            local invItem = Player.getInventoryItem(item)
            return invItem and invItem.count or 0
        end
    end
    return 0
end

Citizen.CreateThread(function()
    Framework:Initialize()
end)

return Framework