if Bridge.Inventory ~= 'ox_inventory' then return end

function Bridge.AddItem(source, item, amount, metadata)
    amount = amount or 1
    local ok, result = pcall(function() return exports.ox_inventory:AddItem(source, item, amount, metadata) end)
    if not ok then return false end
    return result
end

function Bridge.RemoveItem(source, item, amount, metadata, slot)
    amount = amount or 1
    return exports.ox_inventory:RemoveItem(source, item, amount, metadata, slot)
end

function Bridge.HasItem(source, item, amount)
    amount = amount or 1
    local count = exports.ox_inventory:GetItemCount(source, item)
    return count >= amount
end

function Bridge.GetItemCount(source, item)
    return exports.ox_inventory:GetItemCount(source, item) or 0
end

function Bridge.GetItem(source, item)
    return exports.ox_inventory:GetItem(source, item)
end

function Bridge.GetItems(source)
    return exports.ox_inventory:GetInventoryItems(source)
end

function Bridge.CanCarryItem(source, item, amount)
    amount = amount or 1
    return exports.ox_inventory:CanCarryItem(source, item, amount)
end

function Bridge.AddWeapon(source, weapon, ammo)
    ammo = ammo or 100
    return exports.ox_inventory:AddItem(source, weapon, 1, {ammo = ammo})
end

function Bridge.RemoveWeapon(source, weapon)
    return exports.ox_inventory:RemoveItem(source, weapon, 1)
end

function Bridge.GetWeapons(source)
    local items = exports.ox_inventory:GetInventoryItems(source)
    local weapons = {}
    if items then
        for _, item in pairs(items) do
            if item.name:find('WEAPON_') then
                weapons[#weapons + 1] = item
            end
        end
    end
    return weapons
end

function Bridge.SetMetadata(source, slot, metadata)
    return exports.ox_inventory:SetMetadata(source, slot, metadata)
end

function Bridge.ClearInventory(source)
    return exports.ox_inventory:ClearInventory(source)
end
