if Bridge.Inventory ~= 'codem-inventory' then return end

function Bridge.AddItem(source, item, amount, info, slot)
    amount = amount or 1
    return exports['codem-inventory']:AddItem(source, item, amount, info)
end

function Bridge.RemoveItem(source, item, amount, slot)
    amount = amount or 1
    return exports['codem-inventory']:RemoveItem(source, item, amount)
end

function Bridge.HasItem(source, item, amount)
    amount = amount or 1
    local count = exports['codem-inventory']:GetItemCount(source, item)
    return count >= amount
end

function Bridge.GetItemCount(source, item)
    return exports['codem-inventory']:GetItemCount(source, item) or 0
end

function Bridge.GetItem(source, item)
    return exports['codem-inventory']:GetItem(source, item)
end

function Bridge.GetItems(source)
    return exports['codem-inventory']:GetInventory(source)
end

function Bridge.CanCarryItem(source, item, amount)
    amount = amount or 1
    return exports['codem-inventory']:CanCarryItem(source, item, amount)
end

function Bridge.AddWeapon(source, weapon, ammo)
    ammo = ammo or 100
    return exports['codem-inventory']:AddItem(source, weapon, 1, {ammo = ammo})
end

function Bridge.RemoveWeapon(source, weapon)
    return exports['codem-inventory']:RemoveItem(source, weapon, 1)
end

function Bridge.GetWeapons(source)
    local items = exports['codem-inventory']:GetInventory(source)
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
    return exports['codem-inventory']:ClearInventory(source)
end
