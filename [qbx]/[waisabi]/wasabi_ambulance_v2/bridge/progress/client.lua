local config

local progress = {}

local progressSystem = "ox_lib"

local progressPriority = {
    "wasabi_uikit",
    "lation_ui",
    "ox_lib",
}

local progressSystems = {
    ["wasabi_uikit"] = function(params)
        if not params then
            return exports.wasabi_uikit:ProgressBar({
                duration = 1000,
                label = locale("cancelled"),
                useWhileDead = true,
                canCancel = false,
                color = 'red',
                disable = { move = true, car = true, combat = true },
            }, config.progress)
        end

        params.type = params.type or config.progress or 'bar'
        return exports.wasabi_uikit:ProgressBar(params, params.type) or false
    end,

    ['lation_ui'] = function(params)
        if not params then return exports.lation_ui:cancelProgress() end
        return exports.lation_ui:progressBar(params) or false
    end,

    ["ox_lib"] = function(params)
        if not params then
            if lib.progressActive() then
                lib.cancelProgress()
                return true
            end
            return false
        end

        local progressType = params.type or config.progress or 'bar'
        progressType = progressType == 'circle' and 'progressCircle' or 'progressBar'
        return lib[progressType]({
            duration = params.duration,
            label = params.label,
            useWhileDead = params.useWhileDead,
            disable = params.disable,
            anim = params.anim,
            prop = params.prop,
            canCancel = params.canCancel,
        }) or false
    end,
}

function progress.init()
    config = Modules.require('config')

    for _, resourceName in ipairs(progressPriority) do
        if GetResourceState(resourceName):find('start') then
            lib.print.debug('[progress] Using progress bar system:', resourceName)
            progressSystem = resourceName
            break
        end
    end
end

setmetatable(progress, {
    __call = function(_, data)
        if not progressSystems[progressSystem] then
            progressSystem = 'ox_lib'
        end
        return progressSystems[progressSystem](data)
    end
})

lib.callback.register('wasabi_ambulance:Progress', function(source, data)
    return progress(data)
end)

Modules.register('progress', progress, {
    dependencies = { 'config' }
})
