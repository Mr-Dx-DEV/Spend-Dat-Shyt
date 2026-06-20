
if GetResourceState('linden_outlawalert') ~= 'started' then return end

function FLBridge.dispatch.getStreet(coords)
    if not coords then return 'Unknown' end
    local street, _ = GetStreetNameAtCoord(coords.x, coords.y, coords.z, 0, 0)
    return GetStreetNameFromHashKey(street) or 'Unknown'
end

function FLBridge.dispatch.Alert(coords, jobs, data)
    if not coords or not data then return end
    jobs = jobs or {}
    
    TriggerServerEvent('wf-alerts:svNotify', {
        dispatchData = {
            displayCode = data.code or '10-90',
            description = data.message or 'Activity',
            isImportant = 0,
            recipientList = jobs,
            length = '10000',
            infoM = data.icon,
            info = coords,
        },
        caller = 'Alarm',
        coords = coords,
    })
end
