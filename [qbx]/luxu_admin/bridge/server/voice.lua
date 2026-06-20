local existingCalls = {}

RegisterNetEvent("luxu_admin:server:setCallChannel", function(channel)
    local source = source
    existingCalls[source] = channel
    exports['saltychat']:AddPlayerToCall(channel, source)
end)

RegisterNetEvent("luxu_admin:server:leaveCall", function(channel)
    if existingCalls[source] then
        exports['saltychat']:RemovePlayerFromCall(existingCalls[source], source)
        existingCalls[source] = nil
    end
end)


AddEventHandler("onPlayerDropped", function(source)
    if existingCalls[source] then
        existingCalls[source] = nil
    end
end)
