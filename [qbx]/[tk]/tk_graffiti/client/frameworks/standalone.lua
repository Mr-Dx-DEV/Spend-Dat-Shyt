if Config.Framework and Config.Framework ~= 'standalone' then return end

local requestId = 0
local requests = {}

function TriggerCallback(eventName, callback, ...)
	requests[requestId] = callback

	TriggerServerEvent('tk_graffiti:triggerServerCallback', eventName, requestId, GetInvokingResource() or 'unknown', ...)

	requestId += 1
end

RegisterNetEvent('tk_graffiti:serverCallback', function(id, invoker, ...)
	if not requests[id] then
		return error('Server Callback with requestId %s called by %s does not exist'):format(id, invoker)
	end

	requests[id](...)
	requests[id] = nil
end)

CreateThread(function()
    frameworkLoaded = true
end)