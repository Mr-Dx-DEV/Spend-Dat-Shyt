
if GetResourceState('qs-dispatch') ~= 'started' then return end

function FLBridge.dispatch.getStreet(coords)
    if not coords then return 'Unknown' end
    local street, _ = GetStreetNameAtCoord(coords.x, coords.y, coords.z, 0, 0)
    return GetStreetNameFromHashKey(street) or 'Unknown'
end

function FLBridge.dispatch.Alert(coords, jobs, data)
    if not coords or not data then return end
    jobs = jobs or {}
    
    local info = exports['qs-dispatch']:GetPlayerInfo()
    TriggerServerEvent('qs-dispatch:server:CreateDispatchCall', {
        job = jobs,
        callLocation = coords,
        callCode = {code = data.code or '10-90', snippet = data.title or 'Alert'},
        message = (data.message or 'Activity') .. ' Street: ' .. (info.street_1 or '') .. ' ' .. (info.street_2 or ''),
        flashes = false,
        image = nil,
        blip = {sprite = data.blipSprite or 431, scale = data.blipScale or 1.2, colour = data.blipColor or 3, flashes = false, text = data.blipText or 'Alert', time = (5 * 60000)}
    })
end
