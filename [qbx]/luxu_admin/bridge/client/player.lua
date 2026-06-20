---@class PlayerClient
local player = {}
--- Unequip player's weapon
---@param ped number
function player.disarm(ped)
    SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
    TriggerEvent("ox_inventory:disarm")
end

RegisterNetEvent('luxu_admin:client:giveVehicleKeys', function(plate, modelHash)
    if source ~= 65535 and source ~= 0 then return end

    if GetResourceState('dusa_vehiclekeys') == 'started' then
        exports['dusa_vehiclekeys']:AddKey(plate)
    end

    if GetResourceState('qs-vehiclekeys') == 'started' then
        local model = ""
        for _, entity in ipairs(GetGamePool('CVehicle')) do
            if GetVehicleNumberPlateText(entity) == plate then
                model = GetEntityArchetypeName(entity)
                break
            end
        end

        if model == '' then
            return
        end

        exports['qs-vehiclekeys']:GiveKeys(plate, model, true)
    end
end)

return player
