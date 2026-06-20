if Framework.name == "esx" then
    ESXMODELLIST = {} -- A table of all registered vehicles modes <hash, name>
    MySQL.ready(function()
        local models = MySQL.query.await("SELECT model, name FROM vehicles")
        local count = 0
        for _, model in pairs(models) do
            count = count + 1
            ESXMODELLIST[joaat(model.model)] = { model = model.model, label = model.name }
            if count % 50 == 0 then Wait(0) end
        end
    end)
end

---@class GarageUtils
local garage = {}
local VRP = Framework.name == "vrp" and Framework.object.adapter or nil

--- Returns a table, with model and plate, of all owned vehicles for a character
---@param charId number
---@return {model: string, plate: string}[]
function garage.getOwnedVehicles(charId)
    if Framework.name == "esx" then
        local result = MySQL.query.await("SELECT plate, vehicle FROM owned_vehicles WHERE owner = ?", { charId })

        for _, veh in pairs(result) do
            veh.model = json.decode(veh.vehicle)?.model or "NOT_FOUND"
            if veh.model ~= "NOT_FOUND" then
                local info = ESXMODELLIST[veh.model]
                if info then
                    veh.name = info.model
                    veh.label = info.label
                end
            end
        end

        return result
    elseif Framework.name == "qb" or Framework.name == "qbx" then
        local result = MySQL.query.await(
            "SELECT vehicle as model, vehicle as name, vehicle as label, plate FROM player_vehicles WHERE citizenid = ? AND vehicle IS NOT NULL AND vehicle <> ''",
            { charId })
        return result
    elseif Framework.name == "ox" then
        local result = MySQL.query.await("SELECT model, plate, FROM vehicles WHERE owner = ?", { charId })
        return result
    elseif Framework.name == "vrp" then
        return VRP.getOwnedVehicles(charId)
    else
        return {}
    end
end

--- Updates the plate of a vehicle
---@param originalPlate string
---@param newPlate string
function garage.updateVehiclePlate(originalPlate, newPlate)
    if Framework.name == "esx" then
        return MySQL.update.await("UPDATE owned_vehicles SET plate = ? WHERE plate = ?", { newPlate, originalPlate }) ==
            1
    elseif Framework.name == "qb" or Framework.name == "qbx" then
        return MySQL.update.await("UPDATE player_vehicles SET plate = ? WHERE plate = ?", { newPlate, originalPlate }) ==
            1
    elseif Framework.name == "ox" then
        return false
    elseif Framework.name == "vrp" then
        return false
    end
end

--- Gives a vehicle to a character
---@param license string
---@param charId string
---@param plate string
---@param model string
---@param mods table
---@param vehicleType string ("automobile", "bike", "boat", "heli", "plane", ...)
function garage.giveVehicle(license, charId, plate, model, mods, vehicleType)
    if Framework.name == "esx" then
        if GetResourceState("jg-advancedgarages") == "started" then
            return MySQL.insert.await(
                'INSERT INTO owned_vehicles (owner, plate, vehicle, stored, in_garage) VALUES (?,?,?,1,1)',
                { charId, plate, json.encode(mods) }
            )
        end

        return MySQL.insert.await(
            'INSERT INTO owned_vehicles (owner, plate, vehicle, stored) VALUES (?,?,?,1)',
            { charId, plate, json.encode(mods) }
        )
    elseif Framework.name == "qb" or Framework.name == "qbx" then
        if GetResourceState("jg-advancedgarages") == "started" then
            return MySQL.insert.await(
                'INSERT INTO player_vehicles (license, citizenid, plate, vehicle, hash, mods, state, in_garage) VALUES (?,?,?,?,?,?,1,1)',
                { license, charId, plate, model, joaat(model), json.encode(mods) }
            )
        end
        return MySQL.insert.await(
            'INSERT INTO player_vehicles (license, citizenid, plate, vehicle, hash, mods, state) VALUES (?,?,?,?,?,?,1)',
            { license, charId, plate, model, joaat(model), json.encode(mods) }
        )
    elseif Framework.name == "ox" then
    elseif Framework.name == "vrp" then
        return VRP.giveVehicle(charId, model)
    end
end

function garage.getVehicleModels()
    if Framework.name == "vrp" then
        return VRP.getGarageVehicleModels()
    end

    return {}
end

--- Deletes a vehicle from the database
---@param plate string
---@param charId? string
function garage.deleteVehicle(plate, charId)
    if Framework.name == "esx" then
        return MySQL.update.await("DELETE FROM owned_vehicles WHERE plate = ?", { plate }) == 1
    elseif Framework.name == "qb" or Framework.name == "qbx" then
        return MySQL.update.await("DELETE FROM player_vehicles WHERE plate = ?", { plate }) == 1
    elseif Framework.name == "ox" then
        return MySQL.update.await("DELETE FROM vehicles WHERE plate = ?", { plate }) == 1
    elseif Framework.name == "vrp" then
        if not charId then return false end
        return VRP.deleteVehicle(charId, plate)
    end
end

function garage.setVehicleStored(plate, charId)
    if Framework.name == "esx" then
        if GetResourceState("jg-advancedgarages") == "started" then
            exports["jg-advancedgarages"]:deleteOutsideVehicle(plate)
            return MySQL.update.await("UPDATE owned_vehicles SET in_garage = ?, stored = ? WHERE plate = ?",
                { 1, 1, plate }) == 1
        end

        return MySQL.update.await("UPDATE owned_vehicles SET stored = ? WHERE plate = ?", { 1, plate }) == 1
    elseif Framework.name == "qb" or Framework.name == "qbx" then
        if GetResourceState("jg-advancedgarages") == "started" then
            exports["jg-advancedgarages"]:deleteOutsideVehicle(plate)
            return MySQL.update.await("UPDATE player_vehicles SET in_garage = ?, state = ? WHERE plate = ?",
                { 1, 1, plate }) == 1
        end

        return MySQL.update.await("UPDATE player_vehicles SET state = ? WHERE plate = ?", { 1, plate }) == 1
    elseif Framework.name == "ox" then
    elseif Framework.name == "vrp" then
        if not charId then return false end
        return VRP.setVehicleStored(charId, plate)
    end
end

--- Changes the owner of a vehicle
---@param plate string
---@param charId number
---@param oldCharId? number
function garage.changeVehicleOwner(plate, charId, oldCharId)
    if Framework.name == "esx" then
        return MySQL.update.await("UPDATE owned_vehicles SET owner = ? WHERE plate = ?", { charId, plate }) == 1
    elseif Framework.name == "qb" or Framework.name == "qbx" then
        return MySQL.update.await("UPDATE player_vehicles SET citizenid = ? WHERE plate = ?", { charId, plate }) == 1
    elseif Framework.name == "ox" then
        return MySQL.update.await("UPDATE vehicles SET owner = ? WHERE plate = ?", { charId, plate }) == 1
    elseif Framework.name == "vrp" then
        if not oldCharId then return false end
        return VRP.changeVehicleOwner(oldCharId, charId, plate)
    end
end

function garage.cloneVehicle(plate)
    if Framework.name == "esx" then
        local result = MySQL.query.await("SELECT * FROM owned_vehicles WHERE plate = ?", { plate })
    elseif Framework.name == "qb" or Framework.name == "qbx" then

    end
end

return garage
