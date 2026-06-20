if not GetResourceState("qb-inventory"):find('start') or GetResourceState("jaksam_inventory"):find('start') then return end

local config, bridge

local inventory = {}

local isOldInventory = false

local inventoryVersion = GetResourceMetadata('qb-inventory', 'version', 0)
inventoryVersion = inventoryVersion:gsub('%.', '')

if inventoryVersion and tonumber(inventoryVersion) and tonumber(inventoryVersion) < 200 then isOldInventory = true end

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
        if isOldInventory then
            TriggerServerEvent('inventory:server:OpenInventory', 'stash', info.id)
            TriggerEvent('inventory:client:SetCurrentStash', info.id)
            return
        end

        TriggerServerEvent('wasabi_ambulance:Inventory:OpenStash', info)
        return
    elseif invType == 'shop' then
        TriggerServerEvent('wasabi_ambulance:Inventory:OpenShop', info.type)
        return
    else
        TriggerServerEvent('qb-inventory:server:OpenInventory', invType, info)
    end
end

function inventory.getMedicalItems()
    local items = {}
    local Player = exports['qb-core']:GetCoreObject().Functions.GetPlayerData()

    if not Player or not Player.items then
        return items
    end

    for slot, item in pairs(Player.items) do
        if item and config.medicalItems[item.name] then
            local itemData = exports['qb-core']:GetCoreObject().Shared
                and exports['qb-core']:GetCoreObject().Shared.Items
                and exports['qb-core']:GetCoreObject().Shared.Items[item.name]
            table.insert(items, {
                slot = item.slot or slot,
                name = item.name,
                count = item.amount or item.count or 1,
                label = item.label,
                description = item.description or (item.info and item.info.description) or (itemData and itemData.description) or config.medicalItems[item.name].description,
                metadata = item.info or {},
            })
        end
    end

    return items
end

Modules.register('inventory', inventory, {
    dependencies = { 'config', 'bridge' }
})
