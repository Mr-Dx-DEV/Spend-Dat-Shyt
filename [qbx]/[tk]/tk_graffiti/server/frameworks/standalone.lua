if Config.Framework and Config.Framework ~= 'standalone' then return end

local callbacks = {}

function GetIdentifier(playerId)
    return GetPlayerIdentifierByType(playerId, 'license')
end

function RegisterCallback(eventName, callback)
	callbacks[eventName] = callback
end

RegisterNetEvent('tk_graffiti:triggerServerCallback', function(eventName, requestId, invoker, ...)
	if not callbacks[eventName] then
		error('Server callback %s invoked by %s not registered'):format(eventName, invoker)
	end

	local source = source

	callbacks[eventName](source, function(...)
		TriggerClientEvent('tk_graffiti:serverCallback', source, requestId, invoker, ...)
	end, ...)
end)

CreateThread(function()
    frameworkLoaded = true
end)