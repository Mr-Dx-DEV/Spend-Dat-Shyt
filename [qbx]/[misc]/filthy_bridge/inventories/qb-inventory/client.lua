---@diagnostic disable: duplicate-set-field

local found = GetResourceState('qb-inventory')
local qsFound = GetResourceState('qs-inventory')
if found ~= 'started' and found ~= 'starting' then return end
if qsFound == 'started' or qsFound == 'starting' then return end

FLBridge.inventorySystem = 'qb-inventory'
FLBridge.inventory = FLBridge.inventory or {}

OldInventory = GetResourceMetadata(FLBridge.inventorySystem, 'version', 0)
OldInventory = OldInventory:gsub('%.', '')
OldInventory = tonumber(OldInventory)
if not OldInventory or OldInventory >= 200 then OldInventory = false end

function FLBridge.inventory.openPlayerInventory(targetId)
    if not OldInventory then
        TriggerServerEvent('filthy_bridge:openPlayerInventory', targetId)
        return
    end

    TriggerServerEvent('inventory:server:OpenInventory', 'otherplayer', targetId)
    TriggerEvent('inventory:server:RobPlayer', targetId)
end

function FLBridge.inventory.openStash(data)
    if data.unique then
        data.name = ('%s_%s'):format(data.name, FLBridge.getIdentifier())
    end

    if not OldInventory then
        TriggerServerEvent('filthy_bridge:openStash', data)
        return
    end

    TriggerServerEvent('inventory:server:OpenInventory', 'stash', data.name)
    TriggerEvent('inventory:client:SetCurrentStash', data.name)
end

function FLBridge.inventory.openShop(data)
    if not OldInventory then
        TriggerServerEvent('filthy_bridge:openShop', data)
        return
    end

    local shopData = FLBridge.awaitServerCallback('filthy_bridge:getShopDetails', data)
    TriggerServerEvent("inventory:server:OpenInventory", "shop", data.identifier, shopData)
end
