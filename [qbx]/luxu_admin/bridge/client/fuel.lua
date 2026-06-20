local fuel = {}

function fuel.setFuel(vehicle, fuel)
    if GetResourceState("ti_fuel") == "started" then
        exports["ti_fuel"]:setFuel(vehicle, fuel, "RON91")
    elseif GetResourceState("lc_fuel") == "started" then
        exports["lc_fuel"]:SetFuel(vehicle, 100.0)
    end
    SetVehicleFuelLevel(vehicle, fuel)
end

function fuel.getFuel(vehicle)
    return GetVehicleFuelLevel(vehicle)
end

return fuel
