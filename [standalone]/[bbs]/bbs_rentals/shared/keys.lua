Keys = {}
-- ░▀█▀░█▄█░█▀█░█▀█░█▀▄░▀█▀░█▀█░█▀█░▀█▀
-- ░░█░░█░█░█▀▀░█░█░█▀▄░░█░░█▀█░█░█░░█░
-- ░▀▀▀░▀░▀░▀░░░▀▀▀░▀░▀░░▀░░▀░▀░▀░▀░░▀░
-- server side is always better | server side will always consider before client

-- ░█▀▀░█▀▀░█▀▄░█░█░█▀▀░█▀▄░░░█▀▀░▀█▀░█▀▄░█▀▀
-- ░▀▀█░█▀▀░█▀▄░▀▄▀░█▀▀░█▀▄░░░▀▀█░░█░░█░█░█▀▀
-- ░▀▀▀░▀▀▀░▀░▀░░▀░░▀▀▀░▀░▀░░░▀▀▀░▀▀▀░▀▀░░▀▀▀
Keys.GiveKeyServer = function(source, PLATE, vehicle) -- if you have keys system giving key on server
    if not Settings.Keys then
        return false
    end
    
    if Settings.Keys == "wasabi_carlock" then
        exports.wasabi_carlock:GiveKey(source, PLATE)
    elseif Settings.Keys == "Renewed-Vehiclekeys" then
        exports['Renewed-Vehiclekeys']:addKey(source, PLATE)
    elseif Settings.Keys == "tgiann-hotwire" then
        exports["tgiann-hotwire"]:GiveKeyPlate(source, PLATE, true)
    elseif Settings.Keys == "qbx_vehiclekeys" then
        exports.qbx_vehiclekeys:GiveKeys(source, vehicle, false)
    elseif Settings.Keys == "fast-vehiclekeys" then
        TriggerEvent("fast-vehiclekeys:GiveTempKey", PLATE)
    elseif Settings.Keys == "qb-vehiclekeys" then
        exports["qb-vehiclekeys"]:GiveKeys(source, PLATE)
    end
end

Keys.RemoveKeyServer = function(source, vehicle) -- if you have keys system giving key on server
    if not Settings.Keys then
        return false
    end

    local PLATE = GetVehicleNumberPlateText(vehicle)
    
    if Settings.Keys == "wasabi_carlock" then
        exports.wasabi_carlock:RemoveKey(source, PLATE)
    elseif Settings.Keys == "Renewed-Vehiclekeys" then
        exports['Renewed-Vehiclekeys']:removeKey(source, PLATE)
    elseif Settings.Keys == "tgiann-hotwire" then
        return false -- no export for removing keys
    elseif Settings.Keys == "qbx_vehiclekeys" then
        exports.qbx_vehiclekeys:RemoveKeys(source, vehicle, false)
    elseif Settings.Keys == "fast-vehiclekeys" then
        TriggerEvent("fast-vehiclekeys:RemoveTempKey", PLATE)
    elseif Settings.Keys == "qb-vehiclekeys" then
        exports["qb-vehiclekeys"]:RemoveKeys(source, PLATE)
    end
end

-- ░█▀▀░█░░░▀█▀░█▀▀░█▀█░▀█▀░░░█▀▀░▀█▀░█▀▄░█▀▀
-- ░█░░░█░░░░█░░█▀▀░█░█░░█░░░░▀▀█░░█░░█░█░█▀▀
-- ░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀░▀░░▀░░░░▀▀▀░▀▀▀░▀▀░░▀▀▀
Keys.GiveKeyClient = function(PLATE) -- if you have keys system giving key on client
    return false -- if doesn't use or you use server side make it like this
end

Keys.RemoveKeyClient = function(vehicle) -- if you have keys system giving key on client
    return false -- if doesn't use or you use server side make it like this
end