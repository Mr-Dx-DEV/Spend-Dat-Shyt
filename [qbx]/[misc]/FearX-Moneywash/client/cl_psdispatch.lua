RegisterNetEvent('fearx-moneywash:client:psDispatch')
AddEventHandler('fearx-moneywash:client:psDispatch', function(coords, locationId)
    if GetResourceState('ps-dispatch') ~= 'started' then return end
    local zone   = GetLabelText(GetNameOfZone(coords.x, coords.y, coords.z))
    local street = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z))
    TriggerServerEvent('ps-dispatch:server:notify', {
        message   = 'Suspicious Money Laundering',
        codeName  = 'fearx_moneywash',
        code      = '10-90',
        icon      = 'fas fa-money-bill-transfer',
        priority  = 2,
        coords    = coords,
        street    = street .. ', ' .. zone,
        jobs      = { 'leo' },
    })
end)
