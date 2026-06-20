local progress = {}

setmetatable(progress, {
    __call = function(_, src, data)
        return lib.callback.await('wasabi_ambulance:Progress', src, data)
    end
})

Modules.register('progress', progress)
