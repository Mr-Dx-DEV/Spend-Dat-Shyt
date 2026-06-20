--- Order is important, the first one that is found will be used
--- ox_inventory, esx_addoninventory and qb-inventory must be last to avoid conflicts
local images = {
    { name = "tgiann-inventory",   path = "https://cfx-nui-inventory_images/images/%s.png" },
    { name = "jaksam_inventory",   path = "https://cfx-nui-jaksam_inventory/_images/%s.png" },
    { name = "ak47_inventory",     path = "https://cfx-nui-ak47_inventory/web/build/images/%s.png" },
    { name = "ak47_qb_inventory",  path = "https://cfx-nui-ak47_qb_inventory/web/build/images/%s.png" },
    { name = "qs-inventory",       path = "https://cfx-nui-qs-inventory/html/images/%s.png" },
    { name = "core_inventory",     path = "https://cfx-nui-core_inventory/html/img/%s.png" },
    { name = "inventory",          path = "https://cfx-nui-inventory/web/dist/assets/items/%s.png" },
    --[[ Standard Inventorys ]]
    { name = "ox_inventory",       path = "https://cfx-nui-ox_inventory/web/images/%s.png" },
    { name = "qb-inventory",       path = "https://cfx-nui-qb-inventory/html/images/%s.png" },
    { name = "esx_addoninventory", path = "https://cfx-nui-esx_addoninventory/web/images/%s.png" },
}

if Config.inventory.auto_detect then
    for _, inv in ipairs(images) do
        if (GetResourceState(inv.name) == 'started') then
            Config.inventory.name = inv.name
            Config.inventory.images_url = inv.path
            break
        end
    end
end

exports("getInventoryConfig", function()
    return Config.inventory
end)

---@class SharedInventoryUtils
local inventory = {}

---@return {name:string, label:string, image:string}[]
function inventory.getItems()
    if Config.inventory.name == "ox_inventory" then
        local result = exports.ox_inventory:Items()
        local list = {}
        for _, v in pairs(result) do
            if v.name then
                list[#list + 1] = {
                    name = v.name,
                    label = v.label or v.name,
                    image = v.client?.image or v.image or nil
                }
            end
        end
        return list
    end

    if Config.inventory.name == "ak47_inventory" then
        local result = exports.ak47_inventory:Items()
        local list = {}
        for _, v in pairs(result) do
            list[#list + 1] = {
                name = v.name,
                label = v.label or v.name,
                image = v.image
            }
        end
        return list
    end

    if Config.inventory.name == "ak47_qb_inventory" then
        local result = exports.ak47_qb_inventory:Items()
        local list = {}
        for _, v in pairs(result) do
            list[#list + 1] = {
                name = v.name,
                label = v.label,
                image = v.image
            }
        end
        return list
    end

    if Config.inventory.name == "tgiann-inventory" then
        local result = exports["tgiann-inventory"]:Items()
        local list = {}
        for _, v in pairs(result) do
            list[#list + 1] = {
                name = v.name,
                label = v.label,
                image = v.image
            }
        end
        return list
    end

    if Framework.name == 'qb' or Framework.name == 'qbx' then
        local items = Framework.object.Shared.Items or {}
        local list = {}
        for _, v in pairs(items) do
            list[#list + 1] = {
                name = v.name,
                label = v.label,
                image = v.image
            }
        end
        return list
    end

    if Framework.name == 'esx' then
        if IsDuplicityVersion() then
            return CachedESXItems
        else
            local result = Luxu.callbackSync("esx:getItems")
            return result or {}
        end
    end

    if Framework.name == "vrp" then
        if IsDuplicityVersion() then
            return Framework.object.adapter.getItems()
        else
            return {}
        end
    end

    return {}
end

if IsDuplicityVersion() then
    if Framework.name == "esx" then
        CachedESXItems = {}
        Luxu.registerServerCallback("esx:getItems", function()
            return CachedESXItems
        end)

        MySQL.ready(function()
            if ESX and ESX.GetItems then
                local rawItems = ESX.GetItems() -- Not available in all versions

                local list = {}
                for name, v in pairs(rawItems) do
                    list[#list + 1] = {
                        name = v.name or name,
                        label = v.label
                    }
                end
                CachedESXItems = list
            else
                local result = MySQL.query.await("SELECT name, label FROM items")
                if result then
                    CachedESXItems = result
                end
            end
        end)
    end
end

return inventory
