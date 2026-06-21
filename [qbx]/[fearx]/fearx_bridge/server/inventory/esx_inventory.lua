if Bridge.Inventory ~= 'esx_inventory' and Bridge.Framework ~= 'esx' then return end
if Bridge.Inventory == 'ox_inventory' then return end -- ox_inventory takes priority

local ESX = nil

CreateThread(function()
    if Bridge.Framework == 'esx' then
        while ESX == nil do
            ESX = exports['es_extended']:getSharedObject()
            Wait(100)
        end
    end
end)

function Bridge.AddItem(source, item, amount, info)
    amount = amount or 1
    if ESX then
        local ok, xPlayer = pcall(ESX.GetPlayerFromId, ESX, source)
        if ok and xPlayer then
            local success = pcall(function() xPlayer.addInventoryItem(item, amount) end)
            return success
        end
    end
    return false
end

function Bridge.RemoveItem(source, item, amount)
    amount = amount or 1
    if ESX then
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer then
            xPlayer.removeInventoryItem(item, amount)
            return true
        end
    end
    return false
end

function Bridge.HasItem(source, item, amount)
    amount = amount or 1
    if ESX then
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer then
            local itemData = xPlayer.getInventoryItem(item)
            return itemData and itemData.count >= amount
        end
    end
    return false
end

function Bridge.GetItemCount(source, item)
    if ESX then
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer then
            local itemData = xPlayer.getInventoryItem(item)
            return itemData and itemData.count or 0
        end
    end
    return 0
end

function Bridge.GetItem(source, item)
    if ESX then
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer then
            return xPlayer.getInventoryItem(item)
        end
    end
    return nil
end

function Bridge.GetItems(source)
    if ESX then
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer then
            return xPlayer.getInventory()
        end
    end
    return {}
end

function Bridge.CanCarryItem(source, item, amount)
    amount = amount or 1
    if ESX then
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer then
            return xPlayer.canCarryItem(item, amount)
        end
    end
    return true
end

function Bridge.AddWeapon(source, weapon, ammo)
    ammo = ammo or 100
    if ESX then
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer then
            xPlayer.addWeapon(weapon, ammo)
            return true
        end
    end
    return false
end

function Bridge.RemoveWeapon(source, weapon)
    if ESX then
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer then
            xPlayer.removeWeapon(weapon)
            return true
        end
    end
    return false
end

function Bridge.GetWeapons(source)
    if ESX then
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer then
            return xPlayer.getLoadout()
        end
    end
    return {}
end

function Bridge.ClearInventory(source)
    if ESX then
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer then
            local inventory = xPlayer.getInventory()
            for _, item in pairs(inventory) do
                if item.count > 0 then
                    xPlayer.removeInventoryItem(item.name, item.count)
                end
            end
            return true
        end
    end
    return false
end
