local found = GetResourceState('ox_target')
local qbFound = GetResourceState('qb-target')
if found ~= 'started' and found ~= 'starting' then return end
if qbFound == 'started' or qbFound == 'starting' then return end

FLBridge.targetSystem = 'ox_target'

FLBridge.target = FLBridge.target or {}
ActiveTargets = {}

local function generateTargetIdentifier(targetType, invokingResource)
    return string.format("%s_%s_%s", targetType, invokingResource, math.random(1000, 9999))
end

local function convertOptions(options, identifier, targetType)
    local newOptions = {}
    for _, option in ipairs(options) do
        newOptions[#newOptions + 1] = {
            name = targetType .. '_' .. identifier,
            groups = option.groups or option.job or false,
            distance = option.distance,
        }
        for optionName, optionValue in pairs(option) do
            newOptions[#newOptions][optionName] = optionValue
        end
        if option.action and not option.onSelect then
            newOptions[#newOptions].onSelect = option.action
            newOptions[#newOptions].action = nil
        end
    end
    return newOptions
end
local function saveTargetOptions(targetType, invokingResource, identifier, targetOptions, extraData)
    if not ActiveTargets[targetType] then ActiveTargets[targetType] = {} end
    if not ActiveTargets[targetType][invokingResource] then ActiveTargets[targetType][invokingResource] = {} end
    ActiveTargets[targetType][invokingResource][#ActiveTargets[targetType][invokingResource] + 1] = {
        identifier = identifier,
        options = targetOptions,
        extraData = extraData
    }
end

function FLBridge.target.addBoxZone(coords, heading, size, distance, options, compatibilityIdentifier)
    local invokingResource = GetInvokingResource()
    if not invokingResource then return end

    local identifier
    if compatibilityIdentifier then
        exports.ox_target:addBoxZone({
            name = compatibilityIdentifier,
            coords = coords,
            size = size,
            rotation = heading,
            options = options
        })
        identifier = compatibilityIdentifier
    else
        identifier = exports.ox_target:addBoxZone({
            coords = coords,
            size = size,
            rotation = heading,
            options = options
        })
    end
    saveTargetOptions('boxZone', invokingResource, identifier, options)

    return identifier
end

function FLBridge.target.addSphereZone(coords, radius, options)
    local invokingResource = GetInvokingResource()
    if not invokingResource then return end

    local identifier = generateTargetIdentifier('sphere', invokingResource)
    local currentOptions = convertOptions(options, identifier, 'sphere')

    saveTargetOptions('sphere', invokingResource, identifier, currentOptions)

    exports.ox_target:addSphereZone({
        coords = coords,
        radius = radius,
        debug = false,
        drawDistance = radius,
        options = currentOptions
    })
    return identifier
end

function FLBridge.target.player(data)
    local invokingResource = GetInvokingResource()
    if not invokingResource then return end
    local identifier = generateTargetIdentifier('player', invokingResource)
    local currentOptions = convertOptions(data.options, identifier, 'player')
    saveTargetOptions('player', invokingResource, identifier, currentOptions)
    
    exports.ox_target:addPlayer({
        options = currentOptions,
        distance = data.distance
    })
    return 'player_' .. identifier
end

function FLBridge.target.vehicle(data)
    local invokingResource = GetInvokingResource()
    if not invokingResource then return end
    local identifier = generateTargetIdentifier('vehicle', invokingResource)
    local currentOptions = convertOptions(data.options, identifier, 'vehicle')
    saveTargetOptions('vehicle', invokingResource, identifier, currentOptions)
    
    exports.ox_target:addVehicle({
        options = currentOptions,
        distance = data.distance
    })
    return 'vehicle_' .. identifier
end

function FLBridge.target.model(models, data)
    local invokingResource = GetInvokingResource()
    if not invokingResource then return end
    local identifier = generateTargetIdentifier('model', invokingResource)
    local currentOptions = convertOptions(data.options, identifier, 'model')
    saveTargetOptions('model', invokingResource, identifier, currentOptions, { models = models })
    
    exports.ox_target:addModel(models, {
        distance = data.distance,
        options = currentOptions
    })
    return 'model_' .. identifier
end

function FLBridge.target.bone(bones, data)
    local invokingResource = GetInvokingResource()
    if not invokingResource then return end
    local identifier = generateTargetIdentifier('bone', invokingResource)
    local currentOptions = convertOptions(data.options, identifier, 'bone')
    saveTargetOptions('bone', invokingResource, identifier, currentOptions, { bones = bones })
    
    exports.ox_target:addBone(bones, {
        distance = data.distance,
        options = currentOptions
    })
    return 'bone_' .. identifier
end

function FLBridge.target.AddTargetEntity(entity, data)
    local options = {}
    for _, option in ipairs(data.options) do
        local opt = {}
        for k, v in pairs(option) do opt[k] = v end
        if opt.action and not opt.onSelect then
            opt.onSelect = opt.action
            opt.action = nil
        end
        options[#options + 1] = opt
    end

    if NetworkGetEntityIsNetworked(entity) then
        local netId = NetworkGetNetworkIdFromEntity(entity)
        exports.ox_target:addEntity(netId, options)
    else
        exports.ox_target:addLocalEntity(entity, options)
    end
end

function FLBridge.target.RemoveTargetEntity(entity, labels)
    if NetworkGetEntityIsNetworked(entity) then
        local netId = NetworkGetNetworkIdFromEntity(entity)
        exports.ox_target:removeEntity(netId, labels)
    else
        exports.ox_target:removeLocalEntity(entity, labels)
    end
end
function FLBridge.target.removeZone(id)
    if not id then return end
    exports.ox_target:removeZone(id)
end

function FLBridge.target.disable(bool)
   
end

function FLBridge.disableTarget(bool)
    
end

local function resourceStopped(resource)
    for targetType, targets in pairs(ActiveTargets) do
        for resourceName, targetData in pairs(targets) do
            if resourceName == resource then
                for _, target in ipairs(targetData) do
                    if exports.ox_target:zoneExists(target.identifier) then
                        exports.ox_target:removeZone(target.identifier, true)
                    end
                end
            end
            ActiveTargets[targetType][resourceName] = nil
        end
    end
end

AddEventHandler('onResourceStop', function(resource) resourceStopped(resource) end)
