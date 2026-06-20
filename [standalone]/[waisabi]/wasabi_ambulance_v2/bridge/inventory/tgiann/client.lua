if not GetResourceState("tgiann-inventory"):find('start') then return end

local config, bridge

local inventory = {}

local tgiann = exports["tgiann-inventory"]

function inventory.init()
    config = Modules.require("config")
    bridge = Modules.require("bridge")
end

function inventory.open(invType, info)
    lib.print.debug('[inventory.open] invType:', invType, 'info:', info)

    if invType == 'stash' then
        if type(info) == 'string' then
            info = { id = info }
        else
            info.id = bridge.player.charId .. '_' .. info.id
            info.label = locale("locker_label")
        end

        TriggerServerEvent('wasabi_ambulance:Inventory:OpenStash', info)
        return
    elseif invType == 'shop' then
        TriggerServerEvent('wasabi_ambulance:Inventory:OpenShop', info.type)
        return
    end

    lib.print.warn('[wasabi_ambulance] inventory.open: unsupported invType for tgiann-inventory: ' .. tostring(invType))
end

function inventory.getMedicalItems()
    local items = {}
    local playerItems = tgiann:GetPlayerItems()
    for slot, item in pairs(playerItems or {}) do
        if item and config.medicalItems[item.name] then
            items[#items + 1] = {
                slot = item.slot or tonumber(slot),
                name = item.name,
                count = item.amount or item.count or 1,
                label = item.label or tgiann:GetItemLabel(item.name),
                description = item.description or (item.info and item.info.description) or (item.metadata and item.metadata.description) or config.medicalItems[item.name].description,
                metadata = item.info or item.metadata or {},
            }
        end
    end

    return items
end

Modules.register('inventory', inventory, {
    dependencies = { 'config', 'bridge' }
})
