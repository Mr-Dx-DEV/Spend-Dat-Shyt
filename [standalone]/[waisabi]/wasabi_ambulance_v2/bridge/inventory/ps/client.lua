if not GetResourceState("ps-inventory"):find('start') then return end

local config, bridge

local inventory = {}

function inventory.init()
    config = Modules.require("config")
    bridge = Modules.require("bridge")
end

local isOldInventory = false

local inventoryVersion = GetResourceMetadata('ps-inventory', 'version', 0)
inventoryVersion = inventoryVersion:gsub('%.', '')

if inventoryVersion and tonumber(inventoryVersion) and tonumber(inventoryVersion) < 105 then isOldInventory = true end
local inventoryPrefix = isOldInventory and 'inventory' or 'ps-inventory'


function inventory.open(invType, info)
    lib.print.debug('[inventory.open] invType:', invType, 'info:', info)


    if invType == 'stash' then
        if type(info) == 'string' then
            info = { id = info }
            TriggerServerEvent(inventoryPrefix .. ':server:OpenInventory', 'stash', info.id,
                { maxweight = 30000, slots = #config.medBag.items })
        else
            info.id = bridge.player.charId .. '_' .. info.id
            info.label = locale("locker_label")
            TriggerServerEvent(inventoryPrefix .. ':server:OpenInventory', 'stash', info.id,
                { maxweight = config.personalLocker.weight, slots = config.personalLocker.slots })
        end
        TriggerEvent(inventoryPrefix .. ':client:SetCurrentStash', info.id)
        return
    elseif invType == 'shop' then
        local shopData = lib.callback.await('wasabi_ambulance:getShopDetails', false, info.type)
        TriggerServerEvent(inventoryPrefix .. ":server:OpenInventory", "shop", info.type, shopData)
        return
    else
        TriggerServerEvent(inventoryPrefix .. ':server:OpenInventory', invType, info)
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
