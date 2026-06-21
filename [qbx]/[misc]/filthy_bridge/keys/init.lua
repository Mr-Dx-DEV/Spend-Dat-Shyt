FLBridge.keys = {}

function FLBridge.keys.GiveKeys(source, plate, vehicleNetId)
    local keys = Config.GetKeys()

    if keys == 'wasabi_carlock' then
        exports.wasabi_carlock:GiveKey(source, plate)

    elseif keys == 'qb-vehiclekeys' then
        TriggerClientEvent('vehiclekeys:client:SetOwner', source, plate)

    elseif keys == 'qbx_vehiclekeys' then
        if vehicleNetId then
            local vehicle = NetworkGetEntityFromNetworkId(vehicleNetId)
            if vehicle and vehicle ~= 0 then
                exports.qbx_vehiclekeys:GiveKeys(source, vehicle, true)
            else
                TriggerClientEvent('vehiclekeys:client:SetOwner', source, plate)
            end
        else
            TriggerClientEvent('vehiclekeys:client:SetOwner', source, plate)
        end

    elseif keys == 'MrNewbVehicleKeys' then
        if vehicleNetId then
            exports.MrNewbVehicleKeys:GiveKeys(source, vehicleNetId)
        else
            exports.MrNewbVehicleKeys:GiveKeysByPlate(source, plate)
        end

    elseif keys == 'renewed-vehiclekeys' then
        exports['Renewed-Vehiclekeys']:addKey(source, plate)

    elseif keys == 'qs-vehiclekeys' then
        TriggerClientEvent('qs-vehiclekeys:client:AddKeys', source, plate)

    elseif keys == 'cd_garage' then
        TriggerClientEvent('cd_garage:AddKeys', source, plate)

    elseif keys == 'tgiann-hotwire' then
        if vehicleNetId then
            local vehicle = NetworkGetEntityFromNetworkId(vehicleNetId)
            if vehicle and vehicle ~= 0 then
                exports['tgiann-hotwire']:GiveKeyVehicle(vehicle)
            else
                exports['tgiann-hotwire']:GiveKeyPlate(plate)
            end
        else
            exports['tgiann-hotwire']:GiveKeyPlate(plate)
        end

    elseif keys == 'mk_vehiclekeys' then
        if vehicleNetId then
            local vehicle = NetworkGetEntityFromNetworkId(vehicleNetId)
            if vehicle and vehicle ~= 0 then
                exports['mk_vehiclekeys']:AddKey(vehicle, source)
            end
        end
    end
end

function FLBridge.keys.RemoveKeys(source, plate, vehicleNetId)
    local keys = Config.GetKeys()

    if keys == 'wasabi_carlock' then
        exports.wasabi_carlock:RemoveKey(source, plate)

    elseif keys == 'qb-vehiclekeys' then
        TriggerClientEvent('vehiclekeys:client:RemoveKey', source, plate)

    elseif keys == 'qbx_vehiclekeys' then
        if vehicleNetId then
            local vehicle = NetworkGetEntityFromNetworkId(vehicleNetId)
            if vehicle and vehicle ~= 0 then
                exports.qbx_vehiclekeys:RemoveKeys(source, vehicle, true)
            end
        end

    elseif keys == 'MrNewbVehicleKeys' then
        exports.MrNewbVehicleKeys:RemoveKeysByPlate(source, plate)

    elseif keys == 'renewed-vehiclekeys' then
        exports['Renewed-Vehiclekeys']:removeKey(source, plate)

    elseif keys == 'qs-vehiclekeys' then
        TriggerClientEvent('qs-vehiclekeys:client:RemoveKey', source, plate)

    elseif keys == 'cd_garage' then
        TriggerClientEvent('cd_garage:RemoveKeys', source, plate)

    elseif keys == 'tgiann-hotwire' then
        if vehicleNetId then
            local vehicle = NetworkGetEntityFromNetworkId(vehicleNetId)
            if vehicle and vehicle ~= 0 then
                exports['tgiann-hotwire']:RemoveKeyVehicle(vehicle)
            else
                exports['tgiann-hotwire']:RemoveKeyPlate(plate)
            end
        else
            exports['tgiann-hotwire']:RemoveKeyPlate(plate)
        end

    elseif keys == 'mk_vehiclekeys' then
        if vehicleNetId then
            local vehicle = NetworkGetEntityFromNetworkId(vehicleNetId)
            if vehicle and vehicle ~= 0 then
                exports['mk_vehiclekeys']:RemoveKey(vehicle)
            end
        end
    end
end

function FLBridge.keys.HasKeys(source, plate, vehicleNetId)
    local keys = Config.GetKeys()

    if keys == 'wasabi_carlock' then
        local ok, result = pcall(function()
            return exports.wasabi_carlock:HasKey(source, plate)
        end)
        return ok and result or false

    elseif keys == 'qb-vehiclekeys' or keys == 'qbx_vehiclekeys' then
        return true

    elseif keys == 'MrNewbVehicleKeys' then
        local ok, result = pcall(function()
            return exports.MrNewbVehicleKeys:HasKeysByPlate(source, plate)
        end)
        return ok and result or false

    elseif keys == 'renewed-vehiclekeys' then
        local ok, result = pcall(function()
            return exports['Renewed-Vehiclekeys']:hasKey(source, plate)
        end)
        return ok and result or false

    elseif keys == 'mk_vehiclekeys' then
        if vehicleNetId then
            local vehicle = NetworkGetEntityFromNetworkId(vehicleNetId)
            if vehicle and vehicle ~= 0 then
                local ok, result = pcall(function()
                    return exports['mk_vehiclekeys']:HasKey(vehicle, source)
                end)
                return ok and result or false
            end
        end
        return false

    elseif keys == 'qs-vehiclekeys' or keys == 'cd_garage' or keys == 'tgiann-hotwire' then
        return true
    end

    return false
end

function FLBridge.keys.Initialize()
    local keys = Config.GetKeys()
    if keys ~= 'none' and Config.Debug then
        print("[FL-BRIDGE] Keys system: " .. keys)
    end
    return true
end