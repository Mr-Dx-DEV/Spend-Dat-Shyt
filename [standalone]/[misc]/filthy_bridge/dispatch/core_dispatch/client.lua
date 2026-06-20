
if GetResourceState('core_dispatch') ~= 'started' then return end

function FLBridge.dispatch.getStreet(coords)
    if not coords then return 'Unknown' end
    local street, _ = GetStreetNameAtCoord(coords.x, coords.y, coords.z, 0, 0)
    return GetStreetNameFromHashKey(street) or 'Unknown'
end

function FLBridge.dispatch.Alert(coords, jobs, data)
    if not coords or not data then return end
    jobs = jobs or {}
    
    exports['core_dispatch']:addCall(
        data.code or '10-90',
        data.message or 'Activity',
        {{icon = data.icon or 'fas fa-exclamation-triangle', info = 'Suspicious Activity'}},
        {coords.x, coords.y, coords.z},
        jobs[1] or 'police',
        5000,
        data.blipSprite or 431,
        data.blipColor or 3
    )
end
