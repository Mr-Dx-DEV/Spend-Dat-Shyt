if not GetResourceState("jaksam_inventory"):find('start') then return end

local config

local inventory = {}


function inventory.init()
    config = Modules.require("config")
end

function inventory.open(invType, info)
    lib.print.debug('[inventory.open] invType:', invType, 'info:', info)

    if invType == 'stash' then
        lib.print.debug('[inventory.open] Opening stash with ID:', type(info) == 'string' and info or info.id)
        exports['jaksam_inventory']:openInventory(type(info) == 'string' and info or info.id)
    elseif invType == 'shop' then
        exports['jaksam_inventory']:openInventory(info.type)
    else
        exports['jaksam_inventory']:openInventory(type(info) == 'string' and info or info.id)
    end
end

function inventory.getMedicalItems()
    local items = {}
    local inv = exports['jaksam_inventory']:getInventory()
    local playerItems = inv and inv.items or {}

    for slot, itemData in pairs(playerItems) do
        local medicalItem = config.medicalItems[itemData.name]

        if medicalItem then
            local staticItem = exports['jaksam_inventory']:getStaticItem(itemData.name)

            items[#items + 1] = {
                slot = itemData.slot or slot,
                name = itemData.name,
                count = itemData.amount or itemData.count or 1,
                label = itemData.label or (staticItem and staticItem.label) or itemData.name,
                description = itemData.description
                    or (itemData.metadata and itemData.metadata.description)
                    or (staticItem and staticItem.description)
                    or medicalItem.description,
                metadata = itemData.metadata or {},
            }
        end
    end

    return items
end

Modules.register('inventory', inventory, {
    dependencies = { 'config' }
})
