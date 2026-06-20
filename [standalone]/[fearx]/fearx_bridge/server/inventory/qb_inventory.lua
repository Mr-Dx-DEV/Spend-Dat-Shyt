if Bridge.Inventory ~= 'qb-inventory' and Bridge.Inventory ~= 'ps-inventory' and Bridge.Inventory ~= 'lj-inventory' then return end

local QBCore = nil

CreateThread(function()
    if Bridge.Framework == 'qbcore' or Bridge.Framework == 'qbox' then
        while QBCore == nil do
            QBCore = exports['qb-core']:GetCoreObject()
            Wait(100)
        end
    end
end)

function Bridge.AddItem(source, item, amount, info, slot)
    amount = amount or 1
    if QBCore then
        local Player = QBCore.Functions.GetPlayer(source)
        if Player then
            return Player.Functions.AddItem(item, amount, slot, info)
        end
    end
    return false
end

function Bridge.RemoveItem(source, item, amount, slot)
    amount = amount or 1
    if QBCore then
        local Player = QBCore.Functions.GetPlayer(source)
        if Player then
            return Player.Functions.RemoveItem(item, amount, slot)
        end
    end
    return false
end

function Bridge.HasItem(source, item, amount)
    amount = amount or 1
    if QBCore then
        local Player = QBCore.Functions.GetPlayer(source)
        if Player then
            local itemData = Player.Functions.GetItemByName(item)
            return itemData and itemData.amount >= amount
        end
    end
    return false
end

function Bridge.GetItemCount(source, item)
    if QBCore then
        local Player = QBCore.Functions.GetPlayer(source)
        if Player then
            local itemData = Player.Functions.GetItemByName(item)
            return itemData and itemData.amount or 0
        end
    end
    return 0
end

function Bridge.GetItem(source, item)
    if QBCore then
        local Player = QBCore.Functions.GetPlayer(source)
        if Player then
            return Player.Functions.GetItemByName(item)
        end
    end
    return nil
end

function Bridge.GetItems(source)
    if QBCore then
        local Player = QBCore.Functions.GetPlayer(source)
        if Player then
            return Player.PlayerData.items
        end
    end
    return {}
end

function Bridge.CanCarryItem(source, item, amount)
    amount = amount or 1
    if QBCore then
        local Player = QBCore.Functions.GetPlayer(source)
        if Player then
            local totalWeight = exports['qb-inventory']:GetTotalWeight(Player.PlayerData.items)
            local itemInfo = QBCore.Shared.Items[item]
            if itemInfo then
                local itemWeight = itemInfo.weight * amount
                return (totalWeight + itemWeight) <= 120000 -- Default max weight
            end
        end
    end
    return true
end

function Bridge.AddWeapon(source, weapon, ammo)
    ammo = ammo or 100
    return Bridge.AddItem(source, weapon, 1, {ammo = ammo})
end

function Bridge.RemoveWeapon(source, weapon)
    return Bridge.RemoveItem(source, weapon, 1)
end

function Bridge.GetWeapons(source)
    local items = Bridge.GetItems(source)
    local weapons = {}
    if items then
        for _, item in pairs(items) do
            if item.name and item.name:find('weapon_') then
                weapons[#weapons + 1] = item
            end
        end
    end
    return weapons
end

function Bridge.ClearInventory(source)
    if QBCore then
        local Player = QBCore.Functions.GetPlayer(source)
        if Player then
            Player.Functions.ClearInventory()
            return true
        end
    end
    return false
end
