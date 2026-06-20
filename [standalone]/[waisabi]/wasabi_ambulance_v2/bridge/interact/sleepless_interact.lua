local config = Modules.require('config')

if string.lower(config.interact) ~= 'sleepless_interact' then return end

local interact = {}

function interact.init()
    config = Modules.require('config')

    if config.interact ~= "sleepless_interact" then return end

    if not GetResourceState('sleepless_interact'):find("start") then
        lib.print.error('[wasabi_ambulance_v2] sleepless_interact resource is not started')
    end
end

function interact.addLocalEntity(entity, options)
    if IsEntityAPed(entity) then
        for i = 1, #options do
            options[i].offsetAbsolute = vec3(0.0, 0.0, 0.3)
        end
    end
    exports.sleepless_interact:addLocalEntity(entity, options)
end

function interact.addEntity(entity, options)
    interact.addLocalEntity(entity, options)
end

function interact.addModel(model, options)
    exports.sleepless_interact:addModel(model, options)
end

function interact.addCoords(coords, options)
    return exports.sleepless_interact:addCoords(coords, options)
end

function interact.removeLocalEntity(entity)
    exports.sleepless_interact:removeLocalEntity(entity)
end

function interact.removeEntity(entity)
    interact.removeLocalEntity(entity)
end

function interact.removeCoords(zoneId)
    if zoneId then
        exports.sleepless_interact:removeCoords(zoneId)
    end
end

function interact.addGlobalPlayer(options)
    exports.sleepless_interact:addGlobalPlayer(options)
end

function interact.setDisabled(state)
    exports.sleepless_interact:disableInteract(state)
end

Modules.register('interact', interact, {
    dependencies = { 'config' }
})
