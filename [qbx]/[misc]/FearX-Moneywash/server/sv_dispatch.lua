AddEventHandler('fearx-moneywash:police:alert', function(coords, locationId)
    if GetResourceState('ps-dispatch') ~= 'started' then return end
    local players = GetPlayers()
    if not players or #players == 0 then return end
    TriggerClientEvent('fearx-moneywash:client:psDispatch', tonumber(players[1]), coords, locationId)
end)
