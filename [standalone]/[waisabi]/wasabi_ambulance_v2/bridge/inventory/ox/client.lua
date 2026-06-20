if not GetResourceState("ox_inventory"):find('start') or GetResourceState("jaksam_inventory"):find('start') then return end

local config

local inventory = {}

function inventory.init()
    config = Modules.require("config")
end

function inventory.open(invType, info)
    lib.print.debug('[inventory.open] invType:', invType, 'info:', info)

    if invType == 'stash' then
        local stashId = type(info) == 'table' and info.id or info
        lib.print.debug('[inventory.open] Opening stash with ID:', stashId)
        exports.ox_inventory:openInventory(invType, { id = stashId })
    elseif invType == 'shop' then
        exports.ox_inventory:openInventory(invType, { type = info.type, id = info.id })
    else
        exports.ox_inventory:openInventory(invType, info)
    end
end

function inventory.getMedicalItems()
    local items = {}
    for item in pairs(config.medicalItems) do
        local itemData = exports.ox_inventory:Items(item)
        local slots = exports.ox_inventory:Search('slots', item)
        if slots and #slots > 0 then
            for _, v in pairs(slots) do
                v.description = v.description or (v.metadata and v.metadata.description) or (itemData and itemData.description) or config.medicalItems[item].description
                table.insert(items, v)
            end
        end
    end
    return items
end

Modules.register('inventory', inventory, {
    dependencies = { 'config' }
})
