
if GetResourceState('rcore_dispatch') ~= 'started' then return end

function FLBridge.dispatch.getStreet(coords)
    if not coords then return 'Unknown' end
    local street, _ = GetStreetNameAtCoord(coords.x, coords.y, coords.z, 0, 0)
    return GetStreetNameFromHashKey(street) or 'Unknown'
end

function FLBridge.dispatch.Alert(coords, jobs, data)
    if not coords or not data then return end
    jobs = jobs or {}
    
    TriggerServerEvent('rcore_dispatch:server:sendAlert', {
        code = data.code or '10-90',
        default_priority = 'high',
        coords = coords,
        job = jobs,
        text = data.message or 'Activity',
        type = 'alerts',
        blip_time = 5,
        blip = {sprite = data.blipSprite or 431, colour = data.blipColor or 3, scale = data.blipScale or 1.2, text = data.blipText or 'Alert', flashes = false, radius = 0}
    })
end
