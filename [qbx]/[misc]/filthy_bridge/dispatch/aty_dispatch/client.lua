
if GetResourceState('aty_dispatch') ~= 'started' then return end

function FLBridge.dispatch.getStreet(coords)
    if not coords then return 'Unknown' end
    local street, _ = GetStreetNameAtCoord(coords.x, coords.y, coords.z, 0, 0)
    return GetStreetNameFromHashKey(street) or 'Unknown'
end

function FLBridge.dispatch.Alert(coords, jobs, data)
    if not coords or not data then return end
    jobs = jobs or {}
    
    TriggerServerEvent('aty_dispatch:sendAlert', {
        type = data.codeName or 'alert',
        title = data.title or 'Alert',
        message = (data.code or '10-90') .. ' - ' .. (data.message or 'Activity'),
        coords = coords,
        job = jobs,
    })
end
