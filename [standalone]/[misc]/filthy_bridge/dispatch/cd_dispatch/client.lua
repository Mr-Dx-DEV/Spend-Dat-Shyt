
if GetResourceState('cd_dispatch') ~= 'started' then return end

function FLBridge.dispatch.getStreet(coords)
    if not coords then return 'Unknown' end
    local street, _ = GetStreetNameAtCoord(coords.x, coords.y, coords.z, 0, 0)
    return GetStreetNameFromHashKey(street) or 'Unknown'
end

function FLBridge.dispatch.Alert(coords, jobs, data)
    if not coords or not data then return end
    jobs = jobs or {}
    
    local info = exports['cd_dispatch']:GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = jobs,
        coords = coords,
        title = (data.code or '10-90') .. ' - ' .. (data.title or 'Alert'),
        message = (info.sex or 'Unknown') .. ' ' .. (data.message or 'Activity') .. ' at ' .. (info.street or FLBridge.dispatch.getStreet(coords)),
        flash = 0,
        unique_id = info.unique_id,
        sound = 1,
        blip = {sprite = data.blipSprite or 431, scale = data.blipScale or 1.2, colour = data.blipColor or 3, flashes = false, text = data.blipText or 'Alert', time = 5, radius = 0}
    })
end
