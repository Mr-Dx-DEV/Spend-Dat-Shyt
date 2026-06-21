Fuel = {}

Fuel.SetFuel = function(vehicle)
    if Settings.Fuel == "ox_fuel" then
        Entity(vehicle).state.fuel = 100.0
    elseif Settings.Fuel == "x-fuel" then
        exports['x-fuel']:SetFuel(vehicle, 100.0)
    elseif Settings.Fuel == "LegacyFuel" then
        exports["LegacyFuel"]:SetFuel(vehicle, 100.0)
    elseif Settings.Fuel == "cdn-fuel" then
        exports["cdn-fuel"]:SetFuel(vehicle, 100.0)
    elseif Settings.Fuel == "Renewed-Fuel" then
        exports['Renewed-Fuel']:SetFuel(vehicle, 100.0) 
    elseif Settings.Fuel == "qb-fuel" then
        exports['qb-fuel']:SetFuel(vehicle, 100.0)
    elseif Settings.Fuel == "lc_fuel" then
        exports["lc_fuel"]:SetFuel(vehicle, 100)
    elseif Settings.Fuel == "ps-fuel" then
        exports["ps-fuel"]:SetFuel(vehicle, 100)
    elseif Settings.Fuel == "rcore_fuel" then
        exports["rcore_fuel"]:SetVehicleFuel(vehicle, 100.0)
    elseif Settings.Fuel == "lj-fuel" then
        exports['lj-fuel']:SetFuel(vehicle, 100.0)
    elseif Settings.Fuel == "native" then
        SetVehicleFuelLevel(vehicle, 100.0)
    end
end