local notify = {}

setmetatable(notify, {
    __call = function(_, source, params)
        TriggerClientEvent('wasabi_ambulance:Client:notify', source, params)
    end
})

Modules.register('notify', notify)
