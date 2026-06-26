-------------------------------------------------
--        FEARX COINSHOP - CLIENT CUSTOM       --
--    Uncomment ONE option per section below    --
--     or add your own using the same format    --
-------------------------------------------------

CustomClient = {}

-------------------------------------------------
--          VEHICLE KEYS SYSTEM                --
-- Uncomment ONE line for key integration      --
-- Leave all commented = use built-in events   --
-------------------------------------------------
CustomClient.VehicleKeys = 'wasabi_carlock'
-- CustomClient.VehicleKeys = 'qb-vehiclekeys'
-- CustomClient.VehicleKeys = 'qs-vehiclekeys'
-- CustomClient.VehicleKeys = 'wasabi_carlock'
-- CustomClient.VehicleKeys = 'vehicles_keys'
-- CustomClient.VehicleKeys = 'jaksam-vehicles'
-- CustomClient.VehicleKeys = 'okokVehicleKey'
-- CustomClient.VehicleKeys = 'mk_vehiclekeys'
-- CustomClient.VehicleKeys = 'T1GER_keys'
-- CustomClient.VehicleKeys = 'custom'

-------------------------------------------------
--         NOTIFICATION SYSTEM                 --
-- Uncomment ONE line to override notifs       --
-- Leave all commented = use fearx_bridge      --
-------------------------------------------------
CustomClient.Notification = 'ox_lib'
-- CustomClient.Notification = 'ox_lib'
-- CustomClient.Notification = 'okokNotify'
-- CustomClient.Notification = 'wasabi_notify'
-- CustomClient.Notification = 'pNotify'
-- CustomClient.Notification = 'mythic_notify'
-- CustomClient.Notification = 'custom'

-------------------------------------------------
--         FUEL SYSTEM                         --
-- Set purchased vehicles to full fuel         --
-- Uncomment ONE line for your fuel script     --
-------------------------------------------------
CustomClient.Fuel = 'ox_fuel'
-- CustomClient.Fuel = 'ox_fuel'
-- CustomClient.Fuel = 'LegacyFuel'
-- CustomClient.Fuel = 'ps-fuel'
-- CustomClient.Fuel = 'cdn-fuel'
-- CustomClient.Fuel = 'okokGasStation'
-- CustomClient.Fuel = 'lj-fuel'
-- CustomClient.Fuel = 'custom'


-------------------------------------------------
--     VEHICLE KEYS IMPLEMENTATIONS            --
-------------------------------------------------
function CustomClient.GiveKeys(vehicle, plate)
    if CustomClient.VehicleKeys == 'default' then
        return
    elseif CustomClient.VehicleKeys == 'qb-vehiclekeys' then
        TriggerEvent('qb-vehiclekeys:client:AddKeys', plate)
    elseif CustomClient.VehicleKeys == 'qs-vehiclekeys' then
        exports['qs-vehiclekeys']:GiveKeys(plate, plate)
    elseif CustomClient.VehicleKeys == 'wasabi_carlock' then
        exports['wasabi_carlock']:GiveKey(plate)
    elseif CustomClient.VehicleKeys == 'vehicles_keys' then
        exports['vehicles_keys']:addKey(plate)
    elseif CustomClient.VehicleKeys == 'jaksam-vehicles' then
        TriggerEvent('jaksam-vehicles:client:setVehicleOwned', plate)
    elseif CustomClient.VehicleKeys == 'okokVehicleKey' then
        TriggerEvent('okokVehicleKey:AddKey', plate)
    elseif CustomClient.VehicleKeys == 'mk_vehiclekeys' then
        exports['mk_vehiclekeys']:AddKey(plate)
    elseif CustomClient.VehicleKeys == 'T1GER_keys' then
        exports['T1GER_keys']:GiveKey(plate)
    elseif CustomClient.VehicleKeys == 'custom' then
        -- ADD YOUR OWN KEY SYSTEM HERE
        -- exports['your-keys']:GiveKey(plate)
    end
end

-------------------------------------------------
--     NOTIFICATION IMPLEMENTATIONS            --
-------------------------------------------------
function CustomClient.SendNotify(msg, type)
    if CustomClient.Notification == 'default' then
        return false
    elseif CustomClient.Notification == 'ox_lib' then
        lib.notify({ title = 'Coin Shop', description = msg, type = type or 'info' })
        return true
    elseif CustomClient.Notification == 'okokNotify' then
        exports['okokNotify']:Alert('Coin Shop', msg, 5000, type or 'info')
        return true
    elseif CustomClient.Notification == 'wasabi_notify' then
        exports['wasabi_notify']:notify('Coin Shop', msg, 5000, type or 'info')
        return true
    elseif CustomClient.Notification == 'pNotify' then
        exports['pNotify']:SendNotification({ text = msg, type = type or 'info', timeout = 5000 })
        return true
    elseif CustomClient.Notification == 'mythic_notify' then
        exports['mythic_notify']:SendAlert(type or 'inform', msg, 5000)
        return true
    elseif CustomClient.Notification == 'custom' then
        -- ADD YOUR OWN NOTIFICATION EXPORT HERE
        -- exports['your-notify']:Notify(msg, type)
        -- return true
        return false
    end
    return false
end

-------------------------------------------------
--         FUEL IMPLEMENTATIONS                --
-------------------------------------------------
function CustomClient.SetFuel(vehicle, level)
    if CustomClient.Fuel == 'default' then
        return
    elseif CustomClient.Fuel == 'ox_fuel' then
        Entity(vehicle).state.fuel = level
    elseif CustomClient.Fuel == 'LegacyFuel' then
        exports['LegacyFuel']:SetFuel(vehicle, level)
    elseif CustomClient.Fuel == 'ps-fuel' then
        exports['ps-fuel']:SetFuel(vehicle, level)
    elseif CustomClient.Fuel == 'cdn-fuel' then
        exports['cdn-fuel']:SetFuel(vehicle, level)
    elseif CustomClient.Fuel == 'okokGasStation' then
        exports['okokGasStation']:SetFuel(vehicle, level)
    elseif CustomClient.Fuel == 'lj-fuel' then
        exports['lj-fuel']:SetFuel(vehicle, level)
    elseif CustomClient.Fuel == 'custom' then
        -- ADD YOUR OWN FUEL EXPORT HERE
        -- exports['your-fuel']:SetFuel(vehicle, level)
    end
end

-------------------------------------------------
--              EVENT HOOKS                    --
--  Add your own logic below each function     --
--  These fire AFTER the action completes      --
-------------------------------------------------

function CustomClient.OnVehiclePurchased(vehicle, plate, spawnName)
    CustomClient.GiveKeys(vehicle, plate)
    CustomClient.SetFuel(vehicle, 100.0)
end

function CustomClient.OnItemPurchased(itemId, itemName, itemCount, category)
end

function CustomClient.OnDealPurchased(dealId, dealName, dealItems)
end

function CustomClient.OnCoinsRedeemed(amount, wasGift)
end

function CustomClient.OnShopOpened()
end

function CustomClient.OnShopClosed()
end

function CustomClient.OnTestDriveStart(spawnName, duration)
end

function CustomClient.OnTestDriveEnd()
end
