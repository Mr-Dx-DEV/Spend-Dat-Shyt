local found = GetResourceState('qb-target')
local oxFound = GetResourceState('ox_target')
if Config.Debug then
    print("[FILTHY BRIDGE] qb-target state: " .. found .. ", ox_target state: " .. oxFound)
end
if found ~= 'started' and found ~= 'starting' then if Config.Debug then print("[FILTHY BRIDGE] qb-target not found, returning"); end return end
if oxFound == 'started' or oxFound == 'starting' then if Config.Debug then print("[FILTHY BRIDGE] ox_target found, skipping qb-target"); end return end

FLBridge.targetSystem = 'qb-target'
if Config.Debug then
    print("[FILTHY BRIDGE] qb-target loaded, setting target functions")
end

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
            job = option.groups or option.job or false,
            distance = option.distance,
        }
        for optionName, optionValue in pairs(option) do
            newOptions[#newOptions][optionName] = optionValue
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

    local identifier = compatibilityIdentifier or generateTargetIdentifier('boxZone', invokingResource)
    local currentOptions = convertOptions(options, identifier, 'boxZone')

    saveTargetOptions('boxZone', invokingResource, identifier, currentOptions)

    if type(identifier) == 'number' then
        identifier = 'boxZone_' .. identifier
    end

    exports['qb-target']:AddBoxZone(identifier, coords, size.x, size.y, {
        name = identifier,
        heading = heading,
        debugPoly = false,
        minZ = coords.z - size.z,
        maxZ = coords.z + size.z,
        useZ = true,
    }, {
        options = currentOptions,
        distance = distance
    })
    return identifier
end

function FLBridge.target.addSphereZone(coords, radius, options)
    local invokingResource = GetInvokingResource()
    if not invokingResource then return end

    local identifier = generateTargetIdentifier('sphere', invokingResource)
    local currentOptions = convertOptions(options, identifier, 'sphere')

    saveTargetOptions('sphere', invokingResource, identifier, currentOptions)

    exports['qb-target']:AddCircleZone(identifier, coords, radius, {
        name = identifier,
        debugPoly = false,
    }, {
        options = currentOptions,
        distance = radius
    })
    return identifier
end

function FLBridge.target.player(data)
    local invokingResource = GetInvokingResource()
    if not invokingResource then return end
    local identifier = generateTargetIdentifier('player', invokingResource)
    local currentOptions = convertOptions(data.options, identifier, 'player')
    saveTargetOptions('player', invokingResource, identifier, currentOptions)
    exports['qb-target']:AddGlobalPlayer({ options = currentOptions, distance = data.distance })
    return 'player_' .. identifier
end

function FLBridge.target.vehicle(data)
    local invokingResource = GetInvokingResource()
    if not invokingResource then return end
    local identifier = generateTargetIdentifier('vehicle', invokingResource)
    local currentOptions = convertOptions(data.options, identifier, 'vehicle')
    saveTargetOptions('vehicle', invokingResource, identifier, currentOptions)
    exports['qb-target']:AddGlobalVehicle({ options = currentOptions, distance = data.distance })
    return 'vehicle_' .. identifier
end

function FLBridge.target.model(models, data)
    local invokingResource = GetInvokingResource()
    if not invokingResource then return end
    local identifier = generateTargetIdentifier('model', invokingResource)
    local currentOptions = convertOptions(data.options, identifier, 'model')
    saveTargetOptions('model', invokingResource, identifier, currentOptions, { models = models })
    exports['qb-target']:AddTargetModel(models, {
        distance = data.distance,
        job = data.groups or data.job or 'all',
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
    exports['qb-target']:AddTargetBone(bones, {
        distance = data.distance,
        job = data.groups or data.job or 'all',
        options = currentOptions
    })
    return 'bone_' .. identifier
end

function FLBridge.target.AddTargetEntity(entity, data)
    exports['qb-target']:AddTargetEntity(entity, data)
end

function FLBridge.target.RemoveTargetEntity(entity, labels)
    exports['qb-target']:RemoveTargetEntity(entity, labels)
end

function FLBridge.target.removeZone(id)
    if not id then return end
    exports['qb-target']:RemoveZone(id)
end

function FLBridge.target.disable(bool)
    return exports['qb-target']:AllowTargeting(not bool)
end

function FLBridge.disableTarget(bool)
    return exports['qb-target']:AllowTargeting(not bool)
end

local function resourceStopped(resource)
    for targetType, targets in pairs(ActiveTargets) do
        for resourceName, targetData in pairs(targets) do
            if resourceName == resource then
                local names = {}
                for _, target in ipairs(targetData) do
                    for _, option in ipairs(target.options) do
                        names[#names + 1] = option.label
                    end
                    if targetType == 'player' then
                        exports['qb-target']:RemoveGlobalPlayer(names)
                    elseif targetType == 'vehicle' then
                        exports['qb-target']:RemoveGlobalVehicle(names)
                    elseif targetType == 'model' then
                        exports['qb-target']:RemoveTargetModel(target.extraData and target.extraData.model, names)
                    elseif targetType == 'bone' then
                        exports['qb-target']:RemoveTargetBone(target.extraData and target.extraData.bones, names)
                    else
                        if type(target.identifier) == 'number' then
                            exports['qb-target']:RemoveZone('boxZone_' .. target.identifier)
                        else
                            exports['qb-target']:RemoveZone(target.identifier)
                        end
                    end
                end
            end
            ActiveTargets[targetType][resourceName] = nil
        end
    end
end

AddEventHandler('onResourceStop', function(resource) resourceStopped(resource) end)
