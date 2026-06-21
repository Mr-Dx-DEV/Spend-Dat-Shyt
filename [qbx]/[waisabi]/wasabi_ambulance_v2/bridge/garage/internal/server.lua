local config, bridge

local garage = {}

local storedVehicles = {}

function garage.init()
    config = Modules.require('config')
    bridge = Modules.require('bridge')

    if not config.garages or config.garages.type ~= 'internal' then
        return
    end

    CreateThread(function()
        local colInfo = MySQL.single.await(
            'SELECT COLUMN_TYPE as colType, CHARACTER_SET_NAME as charsetName, COLLATION_NAME as collationName FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = ? AND COLUMN_NAME = ?',
            { bridge.charTableInfo[1], bridge.charTableInfo[2] }
        )

        if not colInfo then
            error(('Column `%s`.`%s` not found in database'):format(bridge.charTableInfo[1], bridge.charTableInfo[2]))
        end

        local charColDef = colInfo.colType .. ' CHARACTER SET ' .. colInfo.charsetName .. ' COLLATE ' .. colInfo.collationName .. ' NOT NULL'

        MySQL.query.await(([[
            CREATE TABLE IF NOT EXISTS `wsb_ambulance_vehicles` (
                `charId` %s,
                `plate` VARCHAR(10) NOT NULL,
                `type` ENUM('vehicles', 'helicopters') NOT NULL DEFAULT 'vehicles',
                `data` LONGTEXT NOT NULL DEFAULT (json_object()),
                UNIQUE KEY `unique_plate` (`plate`),
                INDEX `fk_wsb_ambulance_vehicle_char` (`charId`) USING BTREE,
                CONSTRAINT `fk_wsb_ambulance_vehicle_char` FOREIGN KEY (`charId`) REFERENCES `%s` (`%s`) ON UPDATE NO ACTION ON DELETE CASCADE,
                CONSTRAINT `json_data` CHECK (json_valid(`data`))
            ) ENGINE=InnoDB;
        ]]):format(charColDef, bridge.charTableInfo[1], bridge.charTableInfo[2]))

        local result = MySQL.query.await('SELECT * FROM `wsb_ambulance_vehicles`')
        if not result or #result == 0 then return end

        for _, row in ipairs(result) do
            if not storedVehicles[row.charId] then storedVehicles[row.charId] = {} end
            if not storedVehicles[row.charId][row.type] then storedVehicles[row.charId][row.type] = {} end
            storedVehicles[row.charId][row.type][row.plate] = {
                plate = row.plate,
                data = json.decode(row.data),
                stored = true
            }
        end
    end)
end

local function saveVehicleData(charId, plate, data, type)
    if not charId or not plate or not data then return end

    if not storedVehicles[charId] then storedVehicles[charId] = {} end
    if not storedVehicles[charId][type] then storedVehicles[charId][type] = {} end
    if storedVehicles[charId][type][plate] then
        local updated = MySQL.update.await('UPDATE `wsb_ambulance_vehicles` SET `data` = ? WHERE `charId` = ? AND `plate` = ?', {
            json.encode(data),
            charId,
            plate
        })
        if not updated then return false end
        storedVehicles[charId][type][plate].data = data
        return true
    end

    local inserted = MySQL.insert.await('INSERT INTO `wsb_ambulance_vehicles` (`charId`, `plate`, `type`, `data`) VALUES (?, ?, ?, ?)', {
        charId,
        plate,
        type,
        json.encode(data)
    })

    if inserted then
        storedVehicles[charId][type][plate] = {
            plate = plate,
            data = data,
            stored = true
        }
        return true
    end

    return false
end

local function deleteVehicleData(charId, plate, type)
    if not charId or not plate or not type then return end
    local deleted = MySQL.update.await('DELETE FROM `wsb_ambulance_vehicles` WHERE `charId` = ? AND `plate` = ?', {
        charId,
        plate
    })
    if not deleted then return false end
    if storedVehicles[charId] and storedVehicles[charId][type] then
        storedVehicles[charId][type][plate] = nil
    end
    return true
end

local function updateVehicleStatus(charId, plate, type, status)
    if not charId or not plate or not type then return end
    if not storedVehicles[charId] or not storedVehicles[charId][type] or not storedVehicles[charId][type][plate] then return end
    storedVehicles[charId][type][plate].stored = status or 0
    return true
end

local function getAllPlayerVehicles(charId, type)
    if not charId or not storedVehicles[charId] or not storedVehicles[charId][type] then return false end
    return storedVehicles[charId][type]
end

local function plateExists(plate)
    for _, charVehicles in pairs(storedVehicles) do
        for _, typeVehicles in pairs(charVehicles) do
            if typeVehicles[plate] then
                return true
            end
        end
    end
    return false
end

local function generateRandomPlate(plateFormat, onlyNumbers)
    local plate = ''
    for i = 1, #plateFormat do
        local char = plateFormat:sub(i, i)
        if char == '#' then
            if onlyNumbers then
                plate = plate .. tostring(math.random(0, 9))
            else
                local rand = math.random(1, 36)
                if rand <= 10 then
                    plate = plate .. tostring(rand - 1)
                else
                    plate = plate .. string.char(64 + rand - 10)
                end
            end
        else
            plate = plate .. char
        end
    end
    return plate
end

local function generatePlate(source)
    local job, _ = bridge.getJob(source)
    if not job then return false end

    local garageConfig = config.garages.options[job]
    if not garageConfig then return false end

    local plateFormat = garageConfig.plateFormat or '########'
    local onlyNumbers = garageConfig.onlyNumbers

    if not garageConfig.ownedVehicles then
        return generateRandomPlate(plateFormat, onlyNumbers)
    end

    local maxAttempts = 100
    for _ = 1, maxAttempts do
        local plate = generateRandomPlate(plateFormat, onlyNumbers)
        if not plateExists(plate) then
            return plate
        end
    end

    return false
end

local function trimPlate(str)
    if not str then return nil end
    return (string.gsub(str, "^%s*(.-)%s*$", "%1"))
end

lib.callback.register('wasabi_ambulance:Garage:GetStoredVehicles', function(source, type)
    local charId = bridge.getIdentifier(source)
    if not charId then return end

    local vehicles = getAllPlayerVehicles(charId, type)
    return vehicles or false
end)

lib.callback.register('wasabi_ambulance:Garage:WithdrawVehicle', function(source, plate, type)
    local charId = bridge.getIdentifier(source)
    if not charId then return end
    plate = plate and trimPlate(plate)
    if not storedVehicles[charId] or not storedVehicles[charId][type] or not storedVehicles[charId][type][plate] then return false end
    if not storedVehicles[charId][type][plate] then return false end

    storedVehicles[charId][type][plate].stored = false
    return true
end)

lib.callback.register('wasabi_ambulance:Garage:StoreVehicle', function(source, plate, vehicleData, type)
    local charId = bridge.getIdentifier(source)
    if not charId then return end

    plate = plate and trimPlate(plate)
    if not plate then return false end

    if not storedVehicles[charId] or not storedVehicles[charId][type] or not storedVehicles[charId][type][plate] then return false end

    if vehicleData then
        local success = saveVehicleData(charId, plate, vehicleData, type)
        if not success then return false end
        storedVehicles[charId][type][plate].data = vehicleData
    end

    storedVehicles[charId][type][plate].stored = true
    return true
end)

lib.callback.register('wasabi_ambulance:Garage:RecoverVehicle', function(source, plate, garageType, recoveryCost)
    local charId = bridge.getIdentifier(source)
    if not charId then return false end

    plate = plate and trimPlate(plate)
    if not plate then return false end

    if not storedVehicles[charId] or not storedVehicles[charId][garageType] or not storedVehicles[charId][garageType][plate] then return false end

    if storedVehicles[charId][garageType][plate].stored then return true end

    local accountFunds = bridge.getAccountFunds(source, config.garages.account) or 0
    if accountFunds < recoveryCost then return 'no_funds' end

    local removedFunds = bridge.removeAccountFunds(source, config.garages.account, recoveryCost)
    if not removedFunds then return false end

    local vehicles = GetAllVehicles()
    if type(vehicles) == 'table' then
        for _, vehicle in ipairs(vehicles) do
            if DoesEntityExist(vehicle) then
                local vehPlate = trimPlate(GetVehicleNumberPlateText(vehicle))
                if vehPlate == plate then
                    DeleteEntity(vehicle)
                    break
                end
            end
        end
    end

    storedVehicles[charId][garageType][plate].stored = true
    return true
end)

lib.callback.register('wasabi_ambulance:Garage:PurchaseVehicle', function(source, vehicleProperties, price, type)
    local charId = bridge.getIdentifier(source)
    if not charId then return false end

    if price then
        local accountFunds = bridge.getAccountFunds(source, config.garages.account) or 0
        if accountFunds < price then return 'no_funds' end
    end

    local removedFunds = bridge.removeAccountFunds(source, config.garages.account, price)
    if not removedFunds then return false end

    local plate = generatePlate(source)
    if not plate then return false end
    local savedVehicle = saveVehicleData(charId, plate, vehicleProperties, type)
    if not savedVehicle then return false end

    if not storedVehicles[charId] then storedVehicles[charId] = {} end
    if not storedVehicles[charId][type] then storedVehicles[charId][type] = {} end
    storedVehicles[charId][type][plate] = {
        plate = plate,
        data = vehicleProperties,
        stored = false
    }

    return plate
end)

lib.callback.register('wasabi_ambulance:Garage:SpawnVehicle', function(source, model, coords, heading, vehicleType)
    local charId = bridge.getIdentifier(source)
    if not charId then return false end
    if not model or not coords then return false end

    local modelHash = type(model) == 'string' and joaat(model) or model
    if not modelHash or modelHash == 0 then
        return false
    end

    heading = heading or 0.0

    local retries = 0
    local setterType = vehicleType or 'automobile'
    local vehicle = CreateVehicleServerSetter(modelHash, setterType, coords.x, coords.y, coords.z, heading)

    while not DoesEntityExist(vehicle) do
        Wait(100)
        retries = retries + 1
        if retries > 100 then return false end
    end

    SetEntityOrphanMode(vehicle, 2)

    retries = 0

    local netId = NetworkGetNetworkIdFromEntity(vehicle)
    while not netId do
        netId = NetworkGetNetworkIdFromEntity(vehicle)
        Wait(100)
        retries = retries + 1
        if retries > 100 then return false end
    end

    return netId
end)

Modules.register("garage", garage, {
    dependencies = { 'config', 'bridge' }
})
