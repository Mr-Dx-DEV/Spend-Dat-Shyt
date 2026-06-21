if Bridge.Inventory ~= 'core_inventory' then return end

function Bridge.AddItem(source, item, amount, info)
    amount = amount or 1
    return exports['core_inventory']:addItem(source, item, amount, info)
end

function Bridge.RemoveItem(source, item, amount)
    amount = amount or 1
    return exports['core_inventory']:removeItem(source, item, amount)
end

function Bridge.HasItem(source, item, amount)
    amount = amount or 1
    local count = exports['core_inventory']:getItemCount(source, item)
    return count >= amount
end

function Bridge.GetItemCount(source, item)
    return exports['core_inventory']:getItemCount(source, item) or 0
end

function Bridge.GetItem(source, item)
    return exports['core_inventory']:getItem(source, item)
end

function Bridge.GetItems(source)
    return exports['core_inventory']:getInventory(source)
end

function Bridge.CanCarryItem(source, item, amount)
    amount = amount or 1
    return exports['core_inventory']:canCarryItem(source, item, amount)
end

function Bridge.AddWeapon(source, weapon, ammo)
    ammo = ammo or 100
    return exports['core_inventory']:addItem(source, weapon, 1, {ammo = ammo})
end

function Bridge.RemoveWeapon(source, weapon)
    return exports['core_inventory']:removeItem(source, weapon, 1)
end

function Bridge.GetWeapons(source)
    local items = exports['core_inventory']:getInventory(source)
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
    return exports['core_inventory']:clearInventory(source)
end
