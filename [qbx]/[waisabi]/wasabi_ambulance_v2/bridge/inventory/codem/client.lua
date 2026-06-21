if not GetResourceState("codem-inventory"):find('start') then return end

local config, bridge, itemList


local inventory = {}

function inventory.init()
    config = Modules.require("config")
    bridge = Modules.require("bridge")
    itemList = exports['codem-inventory']:GetItemList()
end

function inventory.open(invType, info)
    lib.print.debug('[inventory.open] invType:', invType, 'info:', info)

    if invType == 'stash' then
        if type(info) == 'string' then
            info = { id = info }
            TriggerServerEvent('inventory:server:OpenInventory', "stash", info.id, { name = locale("medbag_label"), slots = #config.medBag.items })
        else
            info.id = bridge.player.charId .. '_' .. info.id
            TriggerServerEvent('inventory:server:OpenInventory', 'stash', info.id, { name = locale("locker_label"), slots = config.personalLocker.slots })
        end
        TriggerEvent('inventory:client:SetCurrentStash', info.id)
    elseif invType == 'shop' then
        local shopData = lib.callback.await('wasabi_ambulance:getShopDetails', false, info.type)
        TriggerEvent('codem-inventory:OpenPlayerShop', shopData)
    else
        TriggerServerEvent('codem-inventory:server:OpenInventory', invType, info)
    end
end

function inventory.getMedicalItems()
    local items = {}
    local playerItems = lib.callback.await('codem-inventory:server:GetUserInventory', false)

    if not playerItems then return items end

    for slot, item in pairs(playerItems) do
        if item and config.medicalItems[item.name] and itemList[item.name] then
            table.insert(items, {
                slot = slot,
                name = item.name,
                count = item.amount or item.count or 1,
                label = itemList[item.name].label,
                description = item.description or (item.info and item.info.description) or itemList[item.name].description or config.medicalItems[item.name].description,
                metadata = item.info or {},
            })
        end
    end

    return items
end

Modules.register('inventory', inventory, {
    dependencies = { 'config', 'bridge' }
})
