local config = Modules.require('config')
if string.lower(config.interact) ~= 'qb-target' then return end

local interact = {}

---@type table<string, boolean> Zone registry for tracking created zones
local zoneRegistry = {}

---@type number Counter for generating unique zone names
local zoneCounter = 0

--- Generates a unique zone name
---@return string
local function generateZoneName()
    zoneCounter = zoneCounter + 1
    return ("wasabi_ambulance_zone_%d"):format(zoneCounter)
end

---@param groups string|table|nil
---@return string|table|nil
local function convertGroups(groups)
    if not groups or type(groups) ~= 'table' then return groups end
    if not groups[1] then return groups end

    local converted = {}
    for _, jobName in ipairs(groups) do
        if type(jobName) == 'string' then
            converted[jobName] = 0
        end
    end
    return converted
end

--- Converts our option format to qb-target format
---@param options table|table[] Our interaction options
---@return table qbOptions qb-target formatted options
local function convertOptions(options)
    if type(options) == 'table' and options.label then
        options = { options }
    end

    local qbOptions = {}

    for i, opt in ipairs(options) do
        local qbOpt = {
            num = i,
            icon = opt.icon,
            label = opt.label,
            item = opt.item,
            job = convertGroups(opt.groups) or opt.job,
            gang = opt.gang,
            canInteract = opt.canInteract,
        }

        if opt.onSelect or opt.action then
            qbOpt.action = function(entity)
                local fn = opt.onSelect or opt.action
                if fn then
                    fn({
                        entity = entity,
                        coords = GetEntityCoords(entity),
                        name = opt.name,
                        distance = opt.distance
                    })
                end
            end
        end

        if opt.event then
            qbOpt.type = opt.serverEvent and "server" or "client"
            qbOpt.event = opt.event
        end

        qbOptions[#qbOptions + 1] = qbOpt
    end

    return qbOptions
end

function interact.init()
    config = Modules.require('config')

    if config.interact ~= "qb-target" then return end

    if not GetResourceState('qb-target'):find("start") then
        lib.print.error('[wasabi_ambulance_v2] qb-target is not started - change config.interact to "ox_target"')
    end
end

function interact.addLocalEntity(entity, options)
    local qbOptions = convertOptions(options)
    local distance = options.distance or (options[1] and options[1].distance) or 2.5

    exports['qb-target']:AddTargetEntity(entity, {
        options = qbOptions,
        distance = distance
    })
end

function interact.addEntity(entity, options)
    interact.addLocalEntity(entity, options)
end

function interact.addModel(model, options)
    local qbOptions = convertOptions(options)
    local distance = options.distance or (options[1] and options[1].distance) or 2.5

    exports['qb-target']:AddTargetModel(model, {
        options = qbOptions,
        distance = distance
    })
end

function interact.addCoords(coords, options)
    local qbOptions = convertOptions(options)
    local distance = options.distance or (options[1] and options[1].distance) or 2.5

    if type(coords) == 'vector4' then
        coords = vector3(coords.x, coords.y, coords.z)
    elseif type(coords) == 'table' and coords.x then
        coords = vector3(coords.x, coords.y, coords.z)
    end

    local zoneName = generateZoneName()

    exports['qb-target']:AddBoxZone(zoneName, coords, 1.0, 1.0, {
        name = zoneName,
        heading = 0.0,
        debugPoly = false,
        minZ = coords.z - 1.0,
        maxZ = coords.z + 1.5,
    }, {
        options = qbOptions,
        distance = distance
    })

    zoneRegistry[zoneName] = true
    return zoneName
end

function interact.removeLocalEntity(entity, optionNames)
    exports['qb-target']:RemoveTargetEntity(entity, optionNames)
end

function interact.removeEntity(entity, optionNames)
    interact.removeLocalEntity(entity, optionNames)
end

function interact.removeCoords(zoneId)
    if zoneId then
        exports['qb-target']:RemoveZone(zoneId)
        zoneRegistry[zoneId] = nil
    end
end

function interact.removeZone(zoneId)
    interact.removeCoords(zoneId)
end

function interact.addGlobalPlayer(options)
    local qbOptions = convertOptions(options)
    local distance = options.distance or (options[1] and options[1].distance) or 2.5

    exports['qb-target']:AddGlobalPlayer({
        options = qbOptions,
        distance = distance
    })
end

function interact.addGlobalVehicle(options)
    local qbOptions = convertOptions(options)
    local distance = options.distance or (options[1] and options[1].distance) or 2.5

    exports['qb-target']:AddGlobalVehicle({
        options = qbOptions,
        distance = distance
    })
end

function interact.removeGlobalVehicle(optionNames)
    exports['qb-target']:RemoveGlobalVehicle(optionNames)
end

function interact.removeGlobalPlayer(optionNames)
    exports['qb-target']:RemoveGlobalPlayer(optionNames)
end

function interact.setDisabled(state)
    exports['qb-target']:AllowTargeting(not state)
end

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        for zoneId in pairs(zoneRegistry) do
            interact.removeZone(zoneId)
        end
        zoneRegistry = {}
        zoneCounter = 0
    end
end)

Modules.register('interact', interact, {
    dependencies = { 'config' }
})
