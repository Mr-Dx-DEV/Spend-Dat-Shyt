local vehicleKeys = {}

local wasabiCarlock = GetResourceState("wasabi_carlock"):find('start') and true or false
local qbKeys = GetResourceState("qb-vehiclekeys"):find('start') and true or false

function vehicleKeys.addKey(plate, _model, _vehicle)
    -- Using wasabi_carlock
    if wasabiCarlock then -- If using wasabi_carlock: https://www.wasabiscripts.com/product/5057933
        return exports.wasabi_carlock:GiveKey(plate)
    elseif qbKeys then
        return TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', plate)
    else
        -- Add your own key system here
    end
end

function vehicleKeys.removeKey(plate, _model, _vehicle)
    -- Using wasabi_carlock
    if wasabiCarlock then
        return exports.wasabi_carlock:RemoveKey(plate) -- If using wasabi_carlock: https://www.wasabiscripts.com/product/5057933
    else
        -- Add your own key system here
    end
end

Modules.register('vehicleKeys', vehicleKeys)
