-------------------------------------------------
--        FEARX COINSHOP - SERVER CUSTOM       --
--    Uncomment ONE option per section below    --
--     or add your own using the same format    --
-------------------------------------------------

CustomServer = {}

-------------------------------------------------
--              FRAMEWORK OVERRIDE             --
-- Only needed if auto-detection doesn't work  --
-- Leave 'auto' to detect automatically        --
-------------------------------------------------
CustomServer.Framework = 'auto'
-- CustomServer.Framework = 'esx'
-- CustomServer.Framework = 'qbcore'
-- CustomServer.Framework = 'qbox'

-------------------------------------------------
--             INVENTORY SYSTEM                --
-- Uncomment ONE line to override item giving  --
-- Leave all commented = use built-in default  --
-------------------------------------------------
CustomServer.Inventory = 'default'
-- CustomServer.Inventory = 'ox_inventory'
-- CustomServer.Inventory = 'qs-inventory'
-- CustomServer.Inventory = 'ps-inventory'
-- CustomServer.Inventory = 'codem-inventory'
-- CustomServer.Inventory = 'core_inventory'
-- CustomServer.Inventory = 'origen_inventory'
-- CustomServer.Inventory = 'mf-inventory'
-- CustomServer.Inventory = 'custom'

-------------------------------------------------
--              GARAGE SYSTEM                  --
-- Uncomment ONE line to override vehicle reg  --
-- Leave all commented = use built-in default  --
-------------------------------------------------
CustomServer.Garage = 'default'
-- CustomServer.Garage = 'qs-advancedgarages'
-- CustomServer.Garage = 'jg-advancedgarages'
-- CustomServer.Garage = 'loaf_garage'
-- CustomServer.Garage = 'cd_garage'
-- CustomServer.Garage = 'okokGarage'
-- CustomServer.Garage = 'qb-garage'
-- CustomServer.Garage = 'jg-mechanic'
-- CustomServer.Garage = 'custom'

-------------------------------------------------
--         GARAGE NAME FOR STORAGE             --
-- Which garage purchased vehicles go into     --
-------------------------------------------------
CustomServer.GarageName = 'pillboxgarage'

-------------------------------------------------
--          VEHICLE KEYS SYSTEM                --
-- Uncomment ONE line for key integration      --
-- Leave all commented = use built-in events   --
-------------------------------------------------
CustomServer.VehicleKeys = 'default'
-- CustomServer.VehicleKeys = 'qb-vehiclekeys'
-- CustomServer.VehicleKeys = 'qs-vehiclekeys'
-- CustomServer.VehicleKeys = 'wasabi_carlock'
-- CustomServer.VehicleKeys = 'vehicles_keys'
-- CustomServer.VehicleKeys = 'jaksam-vehicles'
-- CustomServer.VehicleKeys = 'okokVehicleKey'
-- CustomServer.VehicleKeys = 'mk_vehiclekeys'
-- CustomServer.VehicleKeys = 'custom'

-------------------------------------------------
--         NOTIFICATION SYSTEM                 --
-- Uncomment ONE line to override notifs       --
-- Leave all commented = use fearx_bridge      --
-------------------------------------------------
CustomServer.Notification = 'default'
-- CustomServer.Notification = 'ox_lib'
-- CustomServer.Notification = 'okokNotify'
-- CustomServer.Notification = 'wasabi_notify'
-- CustomServer.Notification = 'pNotify'
-- CustomServer.Notification = 'custom'


-------------------------------------------------
--      INVENTORY SYSTEM IMPLEMENTATIONS       --
-------------------------------------------------
function CustomServer.GiveItem(source, itemName, itemCount)
    if CustomServer.Inventory == 'default' then
        return false
    elseif CustomServer.Inventory == 'ox_inventory' then
        return exports.ox_inventory:AddItem(source, itemName, itemCount)
    elseif CustomServer.Inventory == 'qs-inventory' then
        exports['qs-inventory']:AddItem(source, itemName, itemCount)
        return true
    elseif CustomServer.Inventory == 'ps-inventory' then
        exports['ps-inventory']:AddItem(source, itemName, itemCount)
        return true
    elseif CustomServer.Inventory == 'codem-inventory' then
        exports['codem-inventory']:AddItem(source, itemName, itemCount)
        return true
    elseif CustomServer.Inventory == 'core_inventory' then
        exports['core_inventory']:addItem(source, itemName, itemCount)
        return true
    elseif CustomServer.Inventory == 'origen_inventory' then
        exports['origen_inventory']:AddItem(source, itemName, itemCount)
        return true
    elseif CustomServer.Inventory == 'mf-inventory' then
        exports['mf-inventory']:AddItem(source, itemName, itemCount)
        return true
    elseif CustomServer.Inventory == 'custom' then
        -- ADD YOUR OWN INVENTORY EXPORT HERE
        -- exports['your-inventory']:AddItem(source, itemName, itemCount)
        -- return true
        return false
    end
    return false
end

-------------------------------------------------
--       WEAPON GIVING IMPLEMENTATIONS         --
-------------------------------------------------
function CustomServer.GiveWeapon(source, weaponName, ammo)
    if CustomServer.Inventory == 'default' then
        return false
    elseif CustomServer.Inventory == 'ox_inventory' then
        return exports.ox_inventory:AddItem(source, string.lower(weaponName), 1, { ammo = ammo })
    elseif CustomServer.Inventory == 'qs-inventory' then
        exports['qs-inventory']:AddItem(source, string.lower(weaponName), 1)
        return true
    elseif CustomServer.Inventory == 'ps-inventory' then
        exports['ps-inventory']:AddItem(source, string.lower(weaponName), 1)
        return true
    elseif CustomServer.Inventory == 'codem-inventory' then
        exports['codem-inventory']:AddItem(source, string.lower(weaponName), 1)
        return true
    elseif CustomServer.Inventory == 'core_inventory' then
        exports['core_inventory']:addItem(source, string.lower(weaponName), 1)
        return true
    elseif CustomServer.Inventory == 'origen_inventory' then
        exports['origen_inventory']:AddItem(source, string.lower(weaponName), 1)
        return true
    elseif CustomServer.Inventory == 'mf-inventory' then
        exports['mf-inventory']:AddItem(source, string.lower(weaponName), 1)
        return true
    elseif CustomServer.Inventory == 'custom' then
        -- ADD YOUR OWN WEAPON EXPORT HERE
        -- exports['your-inventory']:AddItem(source, string.lower(weaponName), 1)
        -- return true
        return false
    end
    return false
end

-------------------------------------------------
--       GARAGE SYSTEM IMPLEMENTATIONS         --
-------------------------------------------------
function CustomServer.GiveVehicle(source, spawnName, plate)
    local garage = CustomServer.GarageName or 'pillboxgarage'

    if CustomServer.Garage == 'default' then
        return nil
    elseif CustomServer.Garage == 'qs-advancedgarages' then
        exports['qs-advancedgarages']:AddVehicleToGarage(source, spawnName, plate, garage)
        return plate
    elseif CustomServer.Garage == 'jg-advancedgarages' then
        exports['jg-advancedgarages']:AddVehicle(source, spawnName, { plate = plate, garage = garage })
        return plate
    elseif CustomServer.Garage == 'loaf_garage' then
        exports['loaf_garage']:AddVehicle(source, spawnName, plate)
        return plate
    elseif CustomServer.Garage == 'cd_garage' then
        exports['cd_garage']:AddVehicleBySpawnName(source, spawnName, plate)
        return plate
    elseif CustomServer.Garage == 'okokGarage' then
        exports['okokGarage']:AddVehicle(source, spawnName, plate, garage)
        return plate
    elseif CustomServer.Garage == 'qb-garage' then
        return nil
    elseif CustomServer.Garage == 'jg-mechanic' then
        exports['jg-mechanic']:AddVehicle(source, spawnName, plate)
        return plate
    elseif CustomServer.Garage == 'custom' then
        -- ADD YOUR OWN GARAGE EXPORT HERE
        -- exports['your-garage']:AddVehicle(source, spawnName, plate, garage)
        -- return plate
        return nil
    end
    return nil
end

-------------------------------------------------
--     VEHICLE KEYS IMPLEMENTATIONS            --
-------------------------------------------------
function CustomServer.GiveKeys(source, plate)
    if CustomServer.VehicleKeys == 'default' then
        return
    elseif CustomServer.VehicleKeys == 'qb-vehiclekeys' then
        TriggerClientEvent('qb-vehiclekeys:client:AddKeys', source, plate)
    elseif CustomServer.VehicleKeys == 'qs-vehiclekeys' then
        exports['qs-vehiclekeys']:GiveKeys(source, plate)
    elseif CustomServer.VehicleKeys == 'wasabi_carlock' then
        exports['wasabi_carlock']:GiveKey(source, plate)
    elseif CustomServer.VehicleKeys == 'vehicles_keys' then
        exports['vehicles_keys']:GiveKey(source, plate)
    elseif CustomServer.VehicleKeys == 'jaksam-vehicles' then
        TriggerClientEvent('jaksam-vehicles:client:setVehicleOwned', source, plate)
    elseif CustomServer.VehicleKeys == 'okokVehicleKey' then
        exports['okokVehicleKey']:GiveKey(source, plate)
    elseif CustomServer.VehicleKeys == 'mk_vehiclekeys' then
        exports['mk_vehiclekeys']:AddKey(source, plate)
    elseif CustomServer.VehicleKeys == 'custom' then
        -- ADD YOUR OWN KEY SYSTEM HERE
        -- exports['your-keys']:GiveKey(source, plate)
    end
end

-------------------------------------------------
--     NOTIFICATION IMPLEMENTATIONS            --
-------------------------------------------------
function CustomServer.SendNotify(source, msg, type)
    if CustomServer.Notification == 'default' then
        return false
    elseif CustomServer.Notification == 'ox_lib' then
        TriggerClientEvent('ox_lib:notify', source, { title = 'Coin Shop', description = msg, type = type or 'info' })
        return true
    elseif CustomServer.Notification == 'okokNotify' then
        TriggerClientEvent('okokNotify:Alert', source, 'Coin Shop', msg, 5000, type or 'info')
        return true
    elseif CustomServer.Notification == 'wasabi_notify' then
        TriggerClientEvent('wasabi:notify', source, 'Coin Shop', msg, 5000, type or 'info')
        return true
    elseif CustomServer.Notification == 'pNotify' then
        TriggerClientEvent('pNotify:SendNotification', source, { text = msg, type = type or 'info', timeout = 5000 })
        return true
    elseif CustomServer.Notification == 'custom' then
        -- ADD YOUR OWN NOTIFICATION EXPORT HERE
        -- TriggerClientEvent('your-notify:send', source, msg, type)
        -- return true
        return false
    end
    return false
end

-------------------------------------------------
--              EVENT HOOKS                    --
--  Add your own logic below each function     --
--  These fire AFTER the action completes      --
-------------------------------------------------

function CustomServer.OnPurchaseComplete(source, identifier, item, coinsSpent, newBalance)
end

function CustomServer.OnDealPurchaseComplete(source, identifier, dealName, dealItems, coinsSpent, newBalance)
end

function CustomServer.OnCoinsRedeemed(source, identifier, redeemKey, coinsAdded, newBalance, targetSource, wasGift)
end

function CustomServer.OnCoinsChanged(source, identifier, oldBalance, newBalance, reason)
end
