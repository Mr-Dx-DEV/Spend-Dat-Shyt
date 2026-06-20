local function createLog(value, type)
    exports[Luxu.resourceName]:addLog(type, value)
end

-- =============
-- INVENTORY LOGS
-- =============
AddEventHandler('ox_inventory:openedInventory',

    function(playerId, inventoryId)
        local inventory = exports.ox_inventory:GetInventory(inventoryId, false)

        if inventory.type == 'stash' then
            createLog(("player %s opened stash %s"):format(playerId, inventoryId), "inventory")
        elseif inventory.type == 'player' then
            createLog(("player %s opened player inventory %s"):format(playerId, inventoryId), "inventory")
        end
    end)
AddEventHandler('ox_inventory:usedItem', function(playerId, name, slotId, metadata)
    createLog(("player %s used item %s in slot %s with metadata %s"):format(playerId, name, slotId, metadata),
        "inventory")
end)
