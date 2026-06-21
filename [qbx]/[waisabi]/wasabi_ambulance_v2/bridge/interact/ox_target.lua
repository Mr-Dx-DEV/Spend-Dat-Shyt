local config = Modules.require('config')
if string.lower(config.interact) ~= 'ox_target' then return end

local interact = {}
local activeTargets = {}

function interact.init()
    config = Modules.require('config')

    if config.interact ~= "ox_target" then return end

    if not GetResourceState('ox_target'):find("start") then
        if GetResourceState('qb-target'):find("start") then
            lib.print.error('[wasabi_ambulance_v2] ox_target is not started but qb-target detected - change config.interact to "qb-target"')
            config.interact = "qb-target"
        else
            lib.print.error('[wasabi_ambulance_v2] ox_target is not started - change config.interact to "drawText"')
            config.interact = "drawText"
        end
    end
end

function interact.addLocalEntity(entity, options)
    exports.ox_target:addLocalEntity(entity, options)
end

function interact.addEntity(entity, options)
    interact.addLocalEntity(entity, options)
end

function interact.addModel(model, options)
    exports.ox_target:addModel(model, options)
end

function interact.addCoords(coords, options)
    local zoneId = exports.ox_target:addBoxZone({
        coords = coords,
        size = vec3(1, 1, 1),
        options = options
    })
    activeTargets[zoneId] = true
    return zoneId
end

function interact.removeLocalEntity(entity, names)
    exports.ox_target:removeLocalEntity(entity, names)
end

function interact.removeEntity(entity, names)
    interact.removeLocalEntity(entity, names)
end

function interact.removeCoords(zoneId)
    if zoneId then
        exports.ox_target:removeZone(zoneId)
    end
end

function interact.addGlobalPlayer(options)
    exports.ox_target:addGlobalPlayer(options)
end

function interact.addGlobalVehicle(options)
    exports.ox_target:addGlobalVehicle(options)
end

function interact.removeGlobalVehicle(options)
    local names = {}
    for _, option in ipairs(options) do
        names[#names + 1] = option.name
    end
    exports.ox_target:removeGlobalVehicle(names)
end

function interact.removeGlobalPlayer(options)
    local names = {}
    for _, option in ipairs(options) do
        names[#names + 1] = option.name
    end
    exports.ox_target:removeGlobalPlayer(names)
end

function interact.removeZone(zoneId)
    exports.ox_target:removeZone(zoneId)
end

function interact.setDisabled(state)
    exports.ox_target:disableTargeting(state)
end

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        for zoneId in pairs(activeTargets) do
            interact.removeZone(zoneId)
        end
        activeTargets = {}
    end
end)

Modules.register('interact', interact, {
    dependencies = { 'config' }
})
