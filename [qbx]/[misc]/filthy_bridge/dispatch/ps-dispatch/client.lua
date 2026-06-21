
if GetResourceState('ps-dispatch') ~= 'started' then return end

function FLBridge.dispatch.getStreet(coords)
    if not coords then return 'Unknown' end
    local street, _ = GetStreetNameAtCoord(coords.x, coords.y, coords.z, 0, 0)
    return GetStreetNameFromHashKey(street) or 'Unknown'
end

function FLBridge.dispatch.Alert(coords, jobs, data)
    if not coords or not data then return end
    jobs = jobs or {}
    
    exports['ps-dispatch']:CustomAlert({
        message = data.message or 'Alert',
        codeName = data.codeName or 'alert',
        code = data.code or '10-90',
        icon = data.icon or 'fas fa-exclamation-triangle',
        priority = 2,
        coords = coords,
        gender = IsPedMale(PlayerPedId()) and 'Male' or 'Female',
        street = FLBridge.dispatch.getStreet(coords),
        camId = nil,
        jobs = jobs,
    })
end
