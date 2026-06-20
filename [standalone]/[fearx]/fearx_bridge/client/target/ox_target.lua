if GetResourceState('ox_target') ~= 'started' then return end

Bridge.TargetOx = {}

function Bridge.TargetOx.AddTargetEntity(entity, options)
    exports.ox_target:addLocalEntity(entity, options)
end

function Bridge.TargetOx.RemoveTargetEntity(entity)
    exports.ox_target:removeLocalEntity(entity)
end

function Bridge.TargetOx.AddTargetModel(models, options)
    exports.ox_target:addModel(models, options)
end

function Bridge.TargetOx.RemoveTargetModel(models)
    exports.ox_target:removeModel(models)
end

function Bridge.TargetOx.AddBoxZone(name, coords, length, width, options, targetOptions)
    exports.ox_target:addBoxZone({
        name = name,
        coords = coords,
        size = vec3(length, width, options.maxZ and (options.maxZ - options.minZ) or 2.0),
        rotation = options.heading or 0,
        debug = options.debug or false,
        options = targetOptions
    })
end

function Bridge.TargetOx.AddSphereZone(name, coords, radius, options, targetOptions)
    exports.ox_target:addSphereZone({
        name = name,
        coords = coords,
        radius = radius,
        debug = options.debug or false,
        options = targetOptions
    })
end

function Bridge.TargetOx.RemoveZone(name)
    exports.ox_target:removeZone(name)
end

function Bridge.TargetOx.AddGlobalPlayer(options)
    exports.ox_target:addGlobalPlayer(options)
end

function Bridge.TargetOx.RemoveGlobalPlayer(optionNames)
    exports.ox_target:removeGlobalPlayer(optionNames)
end

function Bridge.TargetOx.AddGlobalVehicle(options)
    exports.ox_target:addGlobalVehicle(options)
end

function Bridge.TargetOx.RemoveGlobalVehicle(optionNames)
    exports.ox_target:removeGlobalVehicle(optionNames)
end

function Bridge.TargetOx.AddGlobalObject(options)
    exports.ox_target:addGlobalObject(options)
end

function Bridge.TargetOx.RemoveGlobalObject(optionNames)
    exports.ox_target:removeGlobalObject(optionNames)
end

function Bridge.TargetOx.AddGlobalPed(options)
    exports.ox_target:addGlobalPed(options)
end

function Bridge.TargetOx.RemoveGlobalPed(optionNames)
    exports.ox_target:removeGlobalPed(optionNames)
end

function Bridge.TargetOx.DisableTargeting(state)
    exports.ox_target:disableTargeting(state)
end
