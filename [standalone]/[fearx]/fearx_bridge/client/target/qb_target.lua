if GetResourceState('qb-target') ~= 'started' then return end

Bridge.TargetQb = {}

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

function Bridge.TargetQb.AddTargetEntity(entity, options)
    exports['qb-target']:AddTargetEntity(entity, {
        options = normalizeOptions(options),
        distance = 2.5
    })
end

function Bridge.TargetQb.RemoveTargetEntity(entity)
    exports['qb-target']:RemoveTargetEntity(entity)
end

function Bridge.TargetQb.AddTargetModel(models, options)
    exports['qb-target']:AddTargetModel(models, {
        options = normalizeOptions(options),
        distance = 2.5
    })
end

function Bridge.TargetQb.RemoveTargetModel(models)
    exports['qb-target']:RemoveTargetModel(models)
end

function Bridge.TargetQb.AddBoxZone(name, coords, length, width, options, targetOptions)
    exports['qb-target']:AddBoxZone(name, coords, length, width, {
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

function Bridge.TargetQb.AddCircleZone(name, coords, radius, options, targetOptions)
    exports['qb-target']:AddCircleZone(name, coords, radius, {
        name = name,
        useZ = options.useZ or true,
        debugPoly = options.debug or false
    }, {
        options = normalizeOptions(targetOptions),
        distance = options.distance or 2.5
    })
end

function Bridge.TargetQb.AddSphereZone(name, coords, radius, options, targetOptions)
    Bridge.TargetQb.AddCircleZone(name, coords, radius, options, targetOptions)
end

function Bridge.TargetQb.RemoveZone(name)
    exports['qb-target']:RemoveZone(name)
end

function Bridge.TargetQb.AddGlobalPlayer(options)
    exports['qb-target']:AddGlobalPlayer({
        options = normalizeOptions(options),
        distance = 2.5
    })
end

function Bridge.TargetQb.RemoveGlobalPlayer(optionNames)
    exports['qb-target']:RemoveGlobalPlayer(optionNames)
end

function Bridge.TargetQb.AddGlobalVehicle(options)
    exports['qb-target']:AddGlobalVehicle({
        options = normalizeOptions(options),
        distance = 2.5
    })
end

function Bridge.TargetQb.RemoveGlobalVehicle(optionNames)
    exports['qb-target']:RemoveGlobalVehicle(optionNames)
end

function Bridge.TargetQb.AddGlobalObject(options)
    exports['qb-target']:AddGlobalObject({
        options = normalizeOptions(options),
        distance = 2.5
    })
end

function Bridge.TargetQb.RemoveGlobalObject(optionNames)
    exports['qb-target']:RemoveGlobalObject(optionNames)
end

function Bridge.TargetQb.AddGlobalPed(options)
    exports['qb-target']:AddGlobalPed({
        options = normalizeOptions(options),
        distance = 2.5
    })
end

function Bridge.TargetQb.RemoveGlobalPed(optionNames)
    exports['qb-target']:RemoveGlobalPed(optionNames)
end

function Bridge.TargetQb.DisableTargeting(state)
    LocalPlayer.state:set('isTargetDisabled', state, false)
end
