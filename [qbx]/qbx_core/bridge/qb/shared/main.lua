local qbShared = require 'shared.main'

qbShared.Items = {}

-- Safe loading for ox_inventory items
local success, oxItems = pcall(require, '@ox_inventory.data.items')
if success and type(oxItems) == 'table' then
    for item, data in pairs(oxItems) do
        qbShared.Items[item] = {
            name = item,
            label = data.label or item,
            weight = data.weight or 0,
            type = 'item',
            image = data.client and data.client.image or (item .. '.png'),
            unique = false,
            useable = true,
            shouldClose = data.close or true,
            combinable = nil,
            description = data.description or nil
        }
    end
else
    print('^3[WARNING] Could not load ox_inventory items data. Items bridge may be incomplete.^7')
end

-- Safe loading for ox_inventory weapons
local successW, oxWeapons = pcall(require, '@ox_inventory.data.weapons')
if successW and type(oxWeapons) == 'table' and type(oxWeapons.Weapons) == 'table' then
    for weapon, data in pairs(oxWeapons.Weapons) do
        local lowerWeapon = string.lower(weapon)
        qbShared.Items[lowerWeapon] = {
            name = lowerWeapon,
            label = data.label or weapon,
            weight = data.weight or 0,
            type = 'weapon',
            ammotype = data.ammoname or nil,
            image = data.client and data.client.image or (lowerWeapon .. '.png'),
            unique = true,
            useable = false,
            shouldClose = true,
            combinable = nil,
            description = nil
        }
    end

    -- Components
    if type(oxWeapons.Components) == 'table' then
        for component, data in pairs(oxWeapons.Components) do
            local lowerComp = string.lower(component)
            qbShared.Items[lowerComp] = {
                name = lowerComp,
                label = data.label or component,
                weight = data.weight or 0,
                type = 'component',
                image = data.client and data.client.image or (lowerComp .. '.png'),
                unique = true,
                useable = false,
                shouldClose = true,
                combinable = nil,
                description = data.description or nil
            }
        end
    end

    -- Ammo
    if type(oxWeapons.Ammo) == 'table' then
        for ammo, data in pairs(oxWeapons.Ammo) do
            local lowerAmmo = string.lower(ammo)
            qbShared.Items[lowerAmmo] = {
                name = lowerAmmo,
                label = data.label or ammo,
                weight = data.weight or 0,
                type = 'ammo',
                image = data.client and data.client.image or (lowerAmmo .. '.png'),
                unique = true,
                useable = false,
                shouldClose = true,
                combinable = nil,
                description = data.description or nil
            }
        end
    end
else
    print('^3[WARNING] Could not load ox_inventory weapons data.^7')
end

-- Starter Items (unchanged but safer)
local starterItems = require 'config.shared'.starterItems or {}
---@deprecated use starterItems in config/shared.lua
qbShared.StarterItems = {}

if type(starterItems) == 'table' then
    for i = 1, #starterItems do
        local item = starterItems[i]
        if type(item) == 'table' and item.name then
            ---@diagnostic disable-next-line: deprecated
            qbShared.StarterItems[item.name] = {
                amount = item.amount or 1,
                item = item.name,
            }
        end
    end
end

-- Deprecated functions (unchanged)
---@deprecated use lib.math.groupdigits from ox_lib
qbShared.CommaValue = lib.math.groupdigits

---@deprecated use lib.string.random from ox_lib
qbShared.RandomStr = function(length)
    if length <= 0 then return '' end
    local pattern = math.random(2) == 1 and 'a' or 'A'
    ---@diagnostic disable-next-line: deprecated
    return qbShared.RandomStr(length - 1) .. lib.string.random(pattern)
end

---@deprecated use lib.string.random from ox_lib
qbShared.RandomInt = function(length)
    if length <= 0 then return '' end
    ---@diagnostic disable-next-line: deprecated
    return qbShared.RandomInt(length - 1) .. lib.string.random('1')
end

---@deprecated use string.strsplit with CfxLua 5.4
qbShared.SplitStr = function(str, delimiter)
    local result = table.pack(string.strsplit(delimiter, str))
    result.n = nil
    return result
end

---@deprecated use qbx.string.trim from modules/lib.lua
qbShared.Trim = function(str)
    if not str then return nil end
    return qbx.string.trim(str)
end

---@deprecated use qbx.string.capitalize from modules/lib.lua
qbShared.FirstToUpper = function(str)
    if not str then return nil end
    return qbx.string.capitalize(str)
end

---@deprecated use qbx.math.round from modules/lib.lua
qbShared.Round = qbx.math.round

---@deprecated use qbx.setVehicleExtra from modules/lib.lua
qbShared.ChangeVehicleExtra = qbx.setVehicleExtras

---@deprecated use qbx.setVehicleExtra from modules/lib.lua
qbShared.SetDefaultVehicleExtras = qbx.setVehicleExtras

---@deprecated use qbx.armsWithoutGloves.male from modules/lib.lua
qbShared.MaleNoGloves = qbx.armsWithoutGloves.male

---@deprecated use qbx.armsWithoutGloves.female from modules/lib.lua
qbShared.FemaleNoGloves = qbx.armsWithoutGloves.female

return qbShared