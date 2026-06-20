Config = {}
Config.Debug = true
Config.CheckForUpdates = true
Config.Framework = 'auto'
Config.Target = 'auto'
Config.Inventory = 'auto'
Config.SocietyBanking = 'auto'
Config.VehicleKeys = 'auto'
Config.FuelScript = 'auto'
Config.Dispatch = 'auto'

function Config.GetFramework()
    if Config.Framework ~= 'auto' then return Config.Framework end
    
    if GetResourceState('qb-core') == 'started' then
        return 'QBCore'
    elseif GetResourceState('qbx_core') == 'started' then
        return 'Qbox'
    elseif GetResourceState('es_extended') == 'started' then
        return 'ESX'
    end
    
    return 'QBCore'
end

function Config.GetTarget()
    if Config.Target ~= 'auto' then return Config.Target end
    
    if GetResourceState('ox_target') == 'started' then
        return 'ox_target'
    elseif GetResourceState('qb-target') == 'started' then
        return 'qb-target'
    end
    
    return 'ox_target'
end

function Config.GetInventory()
    if Config.Inventory ~= 'auto' then return Config.Inventory end
    
    if GetResourceState('ox_inventory') == 'started' then
        return 'ox_inventory'
    elseif GetResourceState('qs-inventory') == 'started' then
        return 'qs-inventory'
    elseif GetResourceState('qb-inventory') == 'started' then
        return 'qb-inventory'
    elseif GetResourceState('origen_inventory') == 'started' then
        return 'origen_inventory'
    elseif GetResourceState('codem-inventory') == 'started' then
        return 'codem-inventory'
    elseif GetResourceState('tgiann-inventory') == 'started' then
        return 'tgiann-inventory'
    end
    
    return 'ox_inventory'
end

function Config.GetBanking()
    if Config.SocietyBanking ~= 'auto' then return Config.SocietyBanking end
    local fw = Config.GetFramework()
    
    if GetResourceState('wasabi_banking') == 'started' then
        return 'wasabi_banking'
    elseif GetResourceState('okokBanking') == 'started' then
        return 'okokBanking'
    elseif GetResourceState('fd_banking') == 'started' then
        return 'fd_banking'
    elseif GetResourceState('tgg-banking') == 'started' then
        return 'tgg-banking'
    elseif (fw == 'Qbox') and GetResourceState('Renewed-Banking') == 'started' then
        return 'Renewed-Banking'
    elseif fw == 'QBCore' then
        if GetResourceState('qb-banking') == 'started' then
            return 'qb-banking'
        elseif GetResourceState('qb-management') == 'started' then
            return 'qb-management'
        end
    elseif fw == 'ESX' then
        if GetResourceState('esx_society') == 'started' then
            return 'esx_society'
        end
    end
    
    return nil
end

function Config.GetKeys()
    if Config.VehicleKeys ~= 'auto' then return Config.VehicleKeys end

    if GetResourceState('wasabi_carlock') == 'started' then
        return 'wasabi_carlock'
    elseif GetResourceState('MrNewbVehicleKeys') == 'started' then
        return 'MrNewbVehicleKeys'
    elseif GetResourceState('qbx_vehiclekeys') == 'started' then
        return 'qbx_vehiclekeys'
    elseif GetResourceState('qb-vehiclekeys') == 'started' then
        return 'qb-vehiclekeys'
    elseif GetResourceState('Renewed-Vehiclekeys') == 'started' then
        return 'renewed-vehiclekeys'
    elseif GetResourceState('tgiann-hotwire') == 'started' then
        return 'tgiann-hotwire'
    elseif GetResourceState('mk_vehiclekeys') == 'started' then
        return 'mk_vehiclekeys'
    elseif GetResourceState('qs-vehiclekeys') == 'started' then
        return 'qs-vehiclekeys'
    elseif GetResourceState('cd_garage') == 'started' then
        return 'cd_garage'
    end

    return 'none'
end

function Config.GetFuel()
    if Config.FuelScript ~= 'auto' then return Config.FuelScript end
    
    if GetResourceState('ox_fuel') == 'started' then
        return 'ox_fuel'
    elseif GetResourceState('lc_fuel') == 'started' then
        return 'lc_fuel'
    elseif GetResourceState('qb-fuel') == 'started' then
        return 'qb-fuel'
    elseif GetResourceState('ps-fuel') == 'started' then
        return 'ps-fuel'
    elseif GetResourceState('cdn-fuel') == 'started' then
        return 'cdn-fuel'
    elseif GetResourceState('LegacyFuel') == 'started' or GetResourceState('legacy-fuel') == 'started' then
        return 'LegacyFuel'
    end
    
    return 'native'
end

function Config.GetDispatch()
    if Config.Dispatch ~= 'auto' then return Config.Dispatch end
    
    if GetResourceState('cd_dispatch') == 'started' then
        return 'cd_dispatch'
    elseif GetResourceState('qs-dispatch') == 'started' then
        return 'qs-dispatch'
    elseif GetResourceState('ps-dispatch') == 'started' then
        return 'ps-dispatch'
    elseif GetResourceState('rcore_dispatch') == 'started' then
        return 'rcore_dispatch'
    elseif GetResourceState('core_dispatch') == 'started' then
        return 'core_dispatch'
    elseif GetResourceState('aty_dispatch') == 'started' then
        return 'aty_dispatch'
    elseif GetResourceState('linden_outlawalert') == 'started' then
        return 'linden_outlawalert'
    end
    
    return 'filthy_bridge'
end
