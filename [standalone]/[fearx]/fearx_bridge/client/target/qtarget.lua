if GetResourceState('qtarget') ~= 'started' then return end

Bridge.TargetQ = {}

local function normalizeOptions(options)
    if not options then return {} end
    local normalized = {}
    for _, opt in pairs(options) do
        local newOpt = {}
        for k, v in pairs(opt) do
            newOpt[k] = v
        end
        if newOpt.onSelect and not newOpt.action and not newOpt.event and not newOpt.serverEvent then
            newOpt.action = newOpt.onSelect
            newOpt.onSelect = nil
        end
        if not newOpt.action and not newOpt.event and not newOpt.serverEvent and not newOpt.type then
            newOpt.action = function() end
        end
        normalized[#normalized + 1] = newOpt
    end
    return normalized
end

function Bridge.TargetQ.AddTargetEntity(entity, options)
    exports.qtarget:AddTargetEntity(entity, {
        options = normalizeOptions(options),
        distance = 2.5
    })
end

function Bridge.TargetQ.RemoveTargetEntity(entity)
    exports.qtarget:RemoveTargetEntity(entity)
end

function Bridge.TargetQ.AddTargetModel(models, options)
    exports.qtarget:AddTargetModel(models, {
        options = normalizeOptions(options),
        distance = 2.5
    })
end

function Bridge.TargetQ.RemoveTargetModel(models)
    exports.qtarget:RemoveTargetModel(models)
end

function Bridge.TargetQ.AddBoxZone(name, coords, length, width, options, targetOptions)
    exports.qtarget:AddBoxZone(name, coords, length, width, {
        name = name,
        heading = options.heading or 0,
        minZ = options.minZ or (coords.z - 1.0),
        maxZ = options.maxZ or (coords.z + 2.0),
        debugPoly = options.debug or false
    }, {
        options = normalizeOptions(targetOptions),
        distance = options.distance or 2.5
    })
end

function Bridge.TargetQ.AddCircleZone(name, coords, radius, options, targetOptions)
    exports.qtarget:AddCircleZone(name, coords, radius, {
        name = name,
        useZ = options.useZ or true,
        debugPoly = options.debug or false
    }, {
        options = normalizeOptions(targetOptions),
        distance = options.distance or 2.5
    })
end

function Bridge.TargetQ.AddSphereZone(name, coords, radius, options, targetOptions)
    Bridge.TargetQ.AddCircleZone(name, coords, radius, options, targetOptions)
end

function Bridge.TargetQ.RemoveZone(name)
    exports.qtarget:RemoveZone(name)
end

function Bridge.TargetQ.AddGlobalPlayer(options)
    exports.qtarget:AddGlobalPlayer({
        options = normalizeOptions(options),
        distance = 2.5
    })
end

function Bridge.TargetQ.RemoveGlobalPlayer(optionNames)
    exports.qtarget:RemoveGlobalPlayer(optionNames)
end

function Bridge.TargetQ.AddGlobalVehicle(options)
    exports.qtarget:AddGlobalVehicle({
        options = normalizeOptions(options),
        distance = 2.5
    })
end

function Bridge.TargetQ.RemoveGlobalVehicle(optionNames)
    exports.qtarget:RemoveGlobalVehicle(optionNames)
end

function Bridge.TargetQ.AddGlobalObject(options)
    exports.qtarget:AddGlobalObject({
        options = normalizeOptions(options),
        distance = 2.5
    })
end

function Bridge.TargetQ.RemoveGlobalObject(optionNames)
    exports.qtarget:RemoveGlobalObject(optionNames)
end

function Bridge.TargetQ.AddGlobalPed(options)
    exports.qtarget:AddGlobalPed({
        options = normalizeOptions(options),
        distance = 2.5
    })
end

function Bridge.TargetQ.RemoveGlobalPed(optionNames)
    exports.qtarget:RemoveGlobalPed(optionNames)
end

function Bridge.TargetQ.DisableTargeting(state)
    LocalPlayer.state:set('isTargetDisabled', state, false)
end
