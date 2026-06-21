FLBridge.fuel = {}

function FLBridge.fuel.GetVehicleFuel(vehicle)
    local fuel = Config.GetFuel()
    
    if fuel == 'ox_fuel' then
        return exports.ox_fuel:GetVehicleFuel(vehicle)
    elseif fuel == 'lc_fuel' then
        return exports.lc_fuel:GetFuel(vehicle)
    elseif fuel == 'qb-fuel' then
        return exports['qb-fuel']:GetFuel(vehicle)
    elseif fuel == 'ps-fuel' then
        return exports['ps-fuel']:GetFuel(vehicle)
    elseif fuel == 'cdn-fuel' then
        return exports['cdn-fuel']:GetFuel(vehicle)
    elseif fuel == 'LegacyFuel' then
        return exports.LegacyFuel:GetFuel(vehicle)
    else
        return GetVehicleFuelLevel(vehicle) / GetVehicleMaxFuelLevel(vehicle) * 100
    end
end

function FLBridge.fuel.SetVehicleFuel(vehicle, amount)
    local fuel = Config.GetFuel()
    
    if fuel == 'ox_fuel' then
        exports.ox_fuel:SetVehicleFuel(vehicle, amount)
    elseif fuel == 'lc_fuel' then
        exports.lc_fuel:SetFuel(vehicle, amount)
    elseif fuel == 'qb-fuel' then
        exports['qb-fuel']:SetFuel(vehicle, amount)
    elseif fuel == 'ps-fuel' then
        exports['ps-fuel']:SetFuel(vehicle, amount)
    elseif fuel == 'cdn-fuel' then
        exports['cdn-fuel']:SetFuel(vehicle, amount)
    elseif fuel == 'LegacyFuel' then
        exports.LegacyFuel:SetFuel(vehicle, amount)
    else
        SetVehicleFuelLevel(vehicle, amount)
    end
end

function FLBridge.fuel.IsVehicleNear(vehicle, coords, radius)
    local vehicleCoords = GetEntityCoords(vehicle)
    return #(vehicleCoords - coords) <= (radius or 5.0)
end

function FLBridge.fuel.Initialize()
    local fuel = Config.GetFuel()
    if Config.Debug then
        print("[FL-BRIDGE] Fuel system: " .. fuel)
    end
    return true
end
