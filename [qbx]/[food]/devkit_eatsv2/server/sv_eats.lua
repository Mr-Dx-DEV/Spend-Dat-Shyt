local ESX = nil
local QBCore = nil

-- Framework detection
local function InitializeFramework()
    -- Check for ESX
    if GetResourceState(Config.ESXgetSharedObject) == 'started' then
        ESX = exports[Config.ESXgetSharedObject]:getSharedObject()
        return 'esx'
    -- Check for QBCore
    elseif GetResourceState(Config.QBCoreGetCoreObject) == 'started' then
        QBCore = exports[Config.QBCoreGetCoreObject]:GetCoreObject()
        return 'qb'
    end
    return nil
end

-- ESX item usage handler
local function RegisterESXItem(itemName, itemData)
    ESX.RegisterUsableItem(itemName, function(source)
        local xPlayer = ESX.GetPlayerFromId(source)
        if not xPlayer then return end

        local item = xPlayer.getInventoryItem(itemName)
        if not item or item.count <= 0 then return end

        -- Remove item
        xPlayer.removeInventoryItem(itemName, 1)

        -- Trigger client effects
        TriggerClientEvent("devkit_eatsv2:onEat", source, itemName)
        
        -- Apply status effect
        TriggerClientEvent("esx_status:add", source, itemData.effect, itemData.amount * 10000)
    end)
end

-- QBCore item usage handler
local function RegisterQBCoreItem(itemName, itemData)
    QBCore.Functions.CreateUseableItem(itemName, function(source, item)
        local Player = QBCore.Functions.GetPlayer(source)
        if not Player then return end

        -- Remove item
        Player.Functions.RemoveItem(itemName, 1)
        
        -- Update inventory
        TriggerClientEvent('inventory:client:ItemBox', source, 
            QBCore.Shared.Items[itemName], "remove")
        
        -- Trigger client effects
        TriggerClientEvent("devkit_eatsv2:onEat", source, itemName)
        
        -- Update hunger
        local currentHunger = Player.PlayerData.metadata.hunger or 0
        local newHunger = math.min(100, currentHunger + itemData.amount)
        
        Player.Functions.SetMetaData('hunger', newHunger)
        TriggerClientEvent(Config.QBUpdateNeeds, source, newHunger, Player.PlayerData.metadata.thirst)
    end)
end

-- Main initialization
CreateThread(function()
    local framework = InitializeFramework()
    if not framework then
        print('^1[ERROR] No supported framework (ESX/QBCore) detected!^7')
        return
    end

    -- Register all food items
    for itemName, itemData in pairs(Config.Food) do
        if framework == 'esx' then
            RegisterESXItem(itemName, itemData)
        else -- QBCore
            RegisterQBCoreItem(itemName, itemData)
        end
    end
end)