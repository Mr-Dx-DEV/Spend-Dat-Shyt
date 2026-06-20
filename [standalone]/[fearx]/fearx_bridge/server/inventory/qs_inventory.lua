if Bridge.Inventory ~= 'qs-inventory' then return end

function Bridge.AddItem(source, item, amount, info, slot)
    amount = amount or 1
    return exports['qs-inventory']:AddItem(source, item, amount, slot, info)
end

function Bridge.RemoveItem(source, item, amount, slot)
    amount = amount or 1
    return exports['qs-inventory']:RemoveItem(source, item, amount, slot)
end

function Bridge.HasItem(source, item, amount)
    amount = amount or 1
    local itemData = exports['qs-inventory']:GetItemByName(source, item)
    return itemData and itemData.amount >= amount
end

function Bridge.GetItemCount(source, item)
    local itemData = exports['qs-inventory']:GetItemByName(source, item)
    return itemData and itemData.amount or 0
end

function Bridge.GetItem(source, item)
    return exports['qs-inventory']:GetItemByName(source, item)
end

function Bridge.GetItems(source)
    return exports['qs-inventory']:GetInventory(source)
end

function Bridge.CanCarryItem(source, item, amount)
    amount = amount or 1
    return exports['qs-inventory']:CanCarryItem(source, item, amount)
end

function Bridge.AddWeapon(source, weapon, ammo)
    ammo = ammo or 100
    return exports['qs-inventory']:AddItem(source, weapon, 1, nil, {ammo = ammo})
end

function Bridge.RemoveWeapon(source, weapon)
    return exports['qs-inventory']:RemoveItem(source, weapon, 1)
end

function Bridge.GetWeapons(source)
    local items = exports['qs-inventory']:GetInventory(source)
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
    return exports['qs-inventory']:ClearInventory(source)
end
