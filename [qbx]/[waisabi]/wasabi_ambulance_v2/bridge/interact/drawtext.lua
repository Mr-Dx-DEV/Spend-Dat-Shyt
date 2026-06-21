local inventory, bridge, drawText

local config = Modules.require('config')

if string.lower(config.interact) ~= 'drawtext' then return end

local interact = {}

local entityInteractions = {}    -- Local entity interactions (by entity handle)
local netEntityInteractions = {} -- Networked entity interactions (by netId)
local modelInteractions = {}     -- Model-based interactions (by model hash)
local coordInteractions = {}     -- Coordinate-based interactions (by id)
local coordIdCounter = 0         -- Counter for generating coord IDs
local globalPedOptions = {}
local globalVehicleOptions = {}
local globalObjectOptions = {}
local globalPlayerOptions = {}

local bones = {
    peds = {},
    vehicles = {},
    objects = {},
    players = {},
    models = {},
    entities = {},
    localEntities = {}
}

local offsets = {
    peds = {},
    vehicles = {},
    objects = {},
    players = {},
    models = {},
    entities = {},
    localEntities = {}
}

local nearbyinteractions = {}

local MAX_DISTANCE = config?.drawText?.maxDistance or 8.0
local MAX_DISTANCE_SQ = MAX_DISTANCE * MAX_DISTANCE
local INTERACT_DISTANCE = config?.drawText?.defaultInteractDistance or 2.0
local SPRITE = config?.drawText?.useSprite and config?.drawText?.sprite or {
    dict = "shared",
    texture = "emptydot_32",
    color = { 28, 100, 184, 255 }
}

local drawRunning = false
local disabled = false

local currentState = {
    entity = nil,
    coordsId = nil,
    coords = nil,
    distance = nil
}

local modelCache = {}
local netIdCache = {}
local GetEntityCoords = GetEntityCoords
local GetEntityModel = GetEntityModel
local GetModelDimensions = GetModelDimensions
local GetOffsetFromEntityInWorldCoords = GetOffsetFromEntityInWorldCoords
local GetScreenCoordFromWorldCoord = GetScreenCoordFromWorldCoord
local DisableControlAction = DisableControlAction
local IsDisabledControlJustReleased = IsDisabledControlJustReleased
local SetDrawOrigin = SetDrawOrigin
local DrawSprite = DrawSprite
local ClearDrawOrigin = ClearDrawOrigin
local GetActivePlayers = GetActivePlayers
local GetPlayerPed = GetPlayerPed
local PlayerId = PlayerId
local GetAspectRatio = GetAspectRatio
local IsNuiFocused = IsNuiFocused
local IsPedAPlayer = IsPedAPlayer
local NetworkGetEntityIsNetworked = NetworkGetEntityIsNetworked
local NetworkGetNetworkIdFromEntity = NetworkGetNetworkIdFromEntity
local NetworkDoesNetworkIdExist = NetworkDoesNetworkIdExist
local NetworkGetEntityFromNetworkId = NetworkGetEntityFromNetworkId
local DoesEntityExist = DoesEntityExist
local Wait = Wait
local tableSort = table.sort
local tableInsert = table.insert
local tableRemove = table.remove
local mathSqrt = math.sqrt
local mathFloor = math.floor
local libGetNearbyObjects = lib.getNearbyObjects
local libGetNearbyVehicles = lib.getNearbyVehicles
local libGetNearbyPeds = lib.getNearbyPeds
local libGetNearbyPlayers = lib.getNearbyPlayers
local GetEntityBoneIndexByName = GetEntityBoneIndexByName
local GetEntityBonePosition_2 = GetEntityBonePosition_2

-----------------------------------------------------------
-- Helper Functions
-----------------------------------------------------------

local function generateCoordId(coords)
    coordIdCounter = coordIdCounter + 1
    return string.format("coord_%d_%.2f_%.2f_%.2f", coordIdCounter, coords.x, coords.y, coords.z)
end

local function cachedEntityInfo(entity)
    if modelCache[entity] then
        return modelCache[entity], netIdCache[entity]
    end

    local model = GetEntityModel(entity)
    local netId = NetworkGetEntityIsNetworked(entity) and NetworkGetNetworkIdFromEntity(entity) or nil
    modelCache[entity] = model
    netIdCache[entity] = netId
    return model, netId
end

local function clearEntityCache()
    modelCache = {}
    netIdCache = {}
end

local function makeOffsetIdFromCoords(offset, offsetType)
    local x = mathFloor(offset.x * 1000)
    local y = mathFloor(offset.y * 1000)
    local z = mathFloor(offset.z * 1000)
    return string.format("%d_%d_%d_%s", x, y, z, offsetType)
end

local function getCoordsAndTypeFromOffsetId(id)
    local x, y, z, offsetType = id:match("(%-?%d+)_(%-?%d+)_(%-?%d+)_(%w+)")
    if x and y and z then
        return tonumber(x) / 1000, tonumber(y) / 1000, tonumber(z) / 1000, offsetType
    end
    return nil, nil, nil, nil
end

local function getDistanceSquared(coords1, coords2)
    local dx = coords1.x - coords2.x
    local dy = coords1.y - coords2.y
    local dz = coords1.z - coords2.z
    return dx * dx + dy * dy + dz * dz
end

local function captureStateSnapshot(entity, coordId, coords, dist)
    return {
        entity = entity or 0,
        coordsId = coordId,
        coords = coords,
        distance = dist and mathSqrt(dist) or 0,
        label = nil,
        name = nil,
        resource = GetCurrentResourceName(),
        offset = nil,
        offsetAbsolute = nil,
        bones = nil
    }
end

local function getResponse(option, stateSnapshot)
    return {
        entity = stateSnapshot.entity or 0,
        coordsId = stateSnapshot.coordsId,
        coords = stateSnapshot.coords,
        distance = stateSnapshot.distance,
        label = option.label,
        name = option.name,
        resource = stateSnapshot.resource,
        offset = option.offset,
        offsetAbsolute = option.offsetAbsolute,
        bones = option.bones
    }
end

local function sortByScreenDistance(a, b)
    return a.screenDistance < b.screenDistance
end

local function getCoordsFromOptions(entity, options)
    if not options or #options == 0 then
        return GetEntityCoords(entity)
    end

    local option = options[1]

    if option.offset then
        local model = GetEntityModel(entity)
        local min, max = GetModelDimensions(model)
        local adjustedOffset = (max - min) * option.offset + min
        return GetOffsetFromEntityInWorldCoords(entity, adjustedOffset.x, adjustedOffset.y, adjustedOffset.z)
    end

    if option.offsetAbsolute then
        return GetOffsetFromEntityInWorldCoords(entity, option.offsetAbsolute.x, option.offsetAbsolute.y,
            option.offsetAbsolute.z)
    end

    return GetEntityCoords(entity)
end

local function getBoneCoords(entity, boneId)
    local boneIndex = GetEntityBoneIndexByName(entity, boneId)
    if boneIndex == -1 then return nil end
    return GetEntityBonePosition_2(entity, boneIndex)
end

local function getOffsetCoords(entity, offsetStr)
    local x, y, z, offsetType = getCoordsAndTypeFromOffsetId(offsetStr)
    if not x or not y or not z then return nil end

    local offset = vec3(x, y, z)

    if offsetType == "offset" then
        local model = GetEntityModel(entity)
        local min, max = GetModelDimensions(model)
        offset = (max - min) * offset + min
    end

    return GetOffsetFromEntityInWorldCoords(entity, offset.x, offset.y, offset.z)
end

local function getBoneOptionsForEntity(entity, model, netId, globalType)
    local boneOptions = {}
    local hasOptions = false

    local globalBones = bones[globalType]
    if globalBones then
        for boneId, options in pairs(globalBones) do
            if #options > 0 then
                boneOptions[boneId] = boneOptions[boneId] or {}
                for i = 1, #options do
                    tableInsert(boneOptions[boneId], options[i])
                end
                hasOptions = true
            end
        end
    end

    if model and bones.models[model] then
        for boneId, options in pairs(bones.models[model]) do
            if #options > 0 then
                boneOptions[boneId] = boneOptions[boneId] or {}
                for i = 1, #options do
                    tableInsert(boneOptions[boneId], options[i])
                end
                hasOptions = true
            end
        end
    end

    if netId and bones.entities[netId] then
        for boneId, options in pairs(bones.entities[netId]) do
            if #options > 0 then
                boneOptions[boneId] = boneOptions[boneId] or {}
                for i = 1, #options do
                    tableInsert(boneOptions[boneId], options[i])
                end
                hasOptions = true
            end
        end
    end

    if bones.localEntities[entity] then
        for boneId, options in pairs(bones.localEntities[entity]) do
            if #options > 0 then
                boneOptions[boneId] = boneOptions[boneId] or {}
                for i = 1, #options do
                    tableInsert(boneOptions[boneId], options[i])
                end
                hasOptions = true
            end
        end
    end

    return hasOptions and boneOptions or nil
end

local function getOffsetOptionsForEntity(entity, model, netId, globalType)
    local offsetOptions = {}
    local hasOptions = false

    local globalOffsets = offsets[globalType]
    if globalOffsets then
        for offsetStr, options in pairs(globalOffsets) do
            if #options > 0 then
                offsetOptions[offsetStr] = offsetOptions[offsetStr] or {}
                for i = 1, #options do
                    tableInsert(offsetOptions[offsetStr], options[i])
                end
                hasOptions = true
            end
        end
    end

    if model and offsets.models[model] then
        for offsetStr, options in pairs(offsets.models[model]) do
            if #options > 0 then
                offsetOptions[offsetStr] = offsetOptions[offsetStr] or {}
                for i = 1, #options do
                    tableInsert(offsetOptions[offsetStr], options[i])
                end
                hasOptions = true
            end
        end
    end

    if netId and offsets.entities[netId] then
        for offsetStr, options in pairs(offsets.entities[netId]) do
            if #options > 0 then
                offsetOptions[offsetStr] = offsetOptions[offsetStr] or {}
                for i = 1, #options do
                    tableInsert(offsetOptions[offsetStr], options[i])
                end
                hasOptions = true
            end
        end
    end

    if offsets.localEntities[entity] then
        for offsetStr, options in pairs(offsets.localEntities[entity]) do
            if #options > 0 then
                offsetOptions[offsetStr] = offsetOptions[offsetStr] or {}
                for i = 1, #options do
                    tableInsert(offsetOptions[offsetStr], options[i])
                end
                hasOptions = true
            end
        end
    end

    return hasOptions and offsetOptions or nil
end

local function addOptionsWithBonesAndOffsets(target, options, bonesTarget, offsetsTarget)
    if not options then return end

    for i = #options, 1, -1 do
        local option = options[i]

        if option.offset or option.offsetAbsolute then
            local offsetKey = option.offset and 'offset' or 'offsetAbsolute'
            local offset = option[offsetKey]

            if type(offset) == 'table' and offset.x and offset.y and offset.z then
                offset = vec3(offset.x, offset.y, offset.z)
            end

            if offset then
                local offsetStr = makeOffsetIdFromCoords(offset, offsetKey)
                if offsetsTarget and offsetStr then
                    offsetsTarget[offsetStr] = offsetsTarget[offsetStr] or {}
                    tableInsert(offsetsTarget[offsetStr], tableRemove(options, i))
                end
            end
        elseif option.bones and bonesTarget then
            local boneList = option.bones
            if type(boneList) ~= 'table' then
                boneList = { boneList }
            end

            local boneOption = tableRemove(options, i)
            for j = 1, #boneList do
                local boneId = boneList[j]
                bonesTarget[boneId] = bonesTarget[boneId] or {}
                tableInsert(bonesTarget[boneId], boneOption)
            end
        end
    end

    for i = 1, #options do
        tableInsert(target, options[i])
    end
end

local function isOptionValid(option, entity, dist, coords)
    if dist then
        local optDist = option.distance or INTERACT_DISTANCE
        if cache.vehicle then
            optDist = optDist + 4.0
        end
        if dist > optDist then return false end
    end

    if not option.allowInVehicle and cache.vehicle then
        return false
    end

    if option.canInteract then
        local success, resp = pcall(option.canInteract, entity or 0, dist or 0, coords, option.name)
        if not success or not resp then return false end
    end

    if option.items and inventory and not inventory.hasItems(option.items, option.anyItem) then
        return false
    end

    if option.groups and bridge and not bridge.hasGroup(option.groups) then
        return false
    end

    return true
end

local function hasAnyValidOptions(options, entity, dist, coords)
    if not options then return false end
    for i = 1, #options do
        if isOptionValid(options[i], entity, dist, coords) then
            return true
        end
    end
    return false
end

local function getValidOptions(options, entity, dist, coords)
    local validOptions = {}
    local count = 0
    if not options then return validOptions end
    for i = 1, #options do
        if isOptionValid(options[i], entity, dist, coords) then
            count = count + 1
            validOptions[count] = options[i]
        end
    end
    return validOptions
end

local function getValidMenuOptions(options, stateSnapshot)
    local validOptions = {}
    local count = 0

    for i = 1, #options do
        local option = options[i]

        if not isOptionValid(option, stateSnapshot.entity, stateSnapshot.distance, stateSnapshot.coords) then
            goto continue
        end

        count = count + 1
        validOptions[count] = {
            title = option.label,
            icon = option.icon,
            onSelect = function()
                if option.canInteract and not option.canInteract(stateSnapshot.entity, stateSnapshot.distance, stateSnapshot.coords, option.name) then
                    return
                end
                CreateThread(function()
                    if option.onSelect then
                        pcall(option.onSelect, getResponse(option, stateSnapshot))
                    elseif option.event then
                        TriggerEvent(option.event, getResponse(option, stateSnapshot))
                    elseif option.serverEvent then
                        TriggerServerEvent(option.serverEvent, getResponse(option, stateSnapshot))
                    elseif option.command then
                        ExecuteCommand(option.command)
                    elseif option.export then
                        local resource, exportName = option.export:match("([^:]+):(.+)")
                        if resource and exportName then
                            exports[resource][exportName](getResponse(option, stateSnapshot))
                        end
                    end
                end)
            end,
        }

        ::continue::
    end

    return validOptions
end

local function openOptionsMenu(options, menuTitle, stateSnapshot)
    lib.registerContext({
        id = 'interact_options_menu',
        title = menuTitle or 'Interact',
        options = getValidMenuOptions(options, stateSnapshot)
    })
    lib.showContext('interact_options_menu')
end

local function executeOption(option, stateSnapshot)
    if option.onSelect then
        pcall(option.onSelect, getResponse(option, stateSnapshot))
    elseif option.event then
        TriggerEvent(option.event, getResponse(option, stateSnapshot))
    elseif option.serverEvent then
        TriggerServerEvent(option.serverEvent, getResponse(option, stateSnapshot))
    elseif option.command then
        ExecuteCommand(option.command)
    elseif option.export then
        local resource, exportName = option.export:match("([^:]+):(.+)")
        if resource and exportName then
            exports[resource][exportName](getResponse(option, stateSnapshot))
        end
    end
end

-----------------------------------------------------------
-- Draw Loop
-----------------------------------------------------------

local function drawLoop()
    if drawRunning then return end
    drawRunning = true

    local aspectRatio = GetAspectRatio(true)
    local spriteWidth = 0.015 / aspectRatio
    local spriteHeight = 0.015

    if SPRITE.dict and SPRITE.texture then
        if not HasStreamedTextureDictLoaded(SPRITE.dict) then
            RequestStreamedTextureDict(SPRITE.dict, true)
            while not HasStreamedTextureDictLoaded(SPRITE.dict) do Wait(0) end
        end
    end

    CreateThread(function()
        while #nearbyinteractions > 0 and not disabled do
            local ped = cache.ped
            local pedCoords = GetEntityCoords(ped)

            DisableControlAction(0, 38, true) -- E key

            local closestValidOptions = nil
            local closestEntity = nil
            local closestCoords = nil
            local closestDist = nil
            local closestCoordId = nil

            for i = 1, #nearbyinteractions do
                local interaction = nearbyinteractions[i]
                if not interaction then goto continue end

                local coords = interaction.coords
                local entity = interaction.entity
                local distSq = getDistanceSquared(pedCoords, coords)
                local dist = mathSqrt(distSq)

                if i == 1 then
                    currentState.entity = entity
                    currentState.coordsId = interaction.coordId
                    currentState.coords = coords
                    currentState.distance = dist
                end

                SetDrawOrigin(coords.x, coords.y, coords.z, 0)

                local alpha = 255
                if dist > 1.0 then
                    alpha = math.max(50, math.floor(255 * (1 - (dist / MAX_DISTANCE))))
                end

                DrawSprite(SPRITE.dict, SPRITE.texture, 0.0, 0.0, spriteWidth, spriteHeight, 0.0,
                    SPRITE.color[1], SPRITE.color[2], SPRITE.color[3], alpha)

                ClearDrawOrigin()

                if i == 1 then
                    local validOptions = getValidOptions(interaction.options, entity, dist, coords)
                    if #validOptions > 0 then
                        closestValidOptions = validOptions
                        closestEntity = entity
                        closestCoords = coords
                        closestDist = dist
                        closestCoordId = interaction.coordId
                    end
                end

                ::continue::
            end

            if closestValidOptions and #closestValidOptions > 0 and closestCoords then
                local textLines = {}
                local maxLabelsToShow = 3 -- Limit how many labels we show

                for i = 1, math.min(#closestValidOptions, maxLabelsToShow) do
                    local opt = closestValidOptions[i]
                    local label = opt.label or opt.name or "Interact"
                    textLines[#textLines + 1] = label
                end

                if #closestValidOptions > maxLabelsToShow then
                    textLines[#textLines + 1] = "+" .. (#closestValidOptions - maxLabelsToShow) .. " more..."
                end

                local displayText = "~b~[E]~w~ " .. table.concat(textLines, " | ")

                drawText(vector3(closestCoords.x, closestCoords.y, closestCoords.z + 0.15), displayText, false)
            end

            if closestValidOptions and #closestValidOptions > 0 and IsDisabledControlJustReleased(0, 38) then
                local stateSnapshot = captureStateSnapshot(closestEntity, closestCoordId, closestCoords,
                    closestDist * closestDist)

                if #closestValidOptions == 1 then
                    executeOption(closestValidOptions[1], stateSnapshot)
                elseif #closestValidOptions > 1 then
                    openOptionsMenu(closestValidOptions, 'Interact', stateSnapshot)
                end
            end

            Wait(0)
        end

        drawRunning = false
    end)
end

-----------------------------------------------------------
-- Nearby Loop
-----------------------------------------------------------

local function addNearbyInteraction(newNearby, nearbyCount, interactionType, id, coords, options, entity, coordId)
    local onScreen, x, y = GetScreenCoordFromWorldCoord(coords.x, coords.y, coords.z)
    if onScreen then
        local screenDx, screenDy = x - 0.5, y - 0.5
        nearbyCount = nearbyCount + 1
        newNearby[nearbyCount] = {
            screenDistance = screenDx * screenDx + screenDy * screenDy,
            type = interactionType,
            id = id,
            coords = coords,
            options = options,
            entity = entity,
            coordId = coordId
        }
    end
    return nearbyCount
end

local function getOptionsForEntity(entity, model, netId, globalOptions)
    local allOptions = {}
    local count = 0

    if entityInteractions[entity] then
        for i = 1, #entityInteractions[entity] do
            count = count + 1
            allOptions[count] = entityInteractions[entity][i]
        end
    end

    if netId and netEntityInteractions[netId] then
        for i = 1, #netEntityInteractions[netId] do
            count = count + 1
            allOptions[count] = netEntityInteractions[netId][i]
        end
    end

    if model and modelInteractions[model] then
        for i = 1, #modelInteractions[model] do
            count = count + 1
            allOptions[count] = modelInteractions[model][i]
        end
    end

    if globalOptions and #globalOptions > 0 then
        for i = 1, #globalOptions do
            count = count + 1
            allOptions[count] = globalOptions[i]
        end
    end

    return count > 0 and allOptions or nil
end

local function processEntityInteractions(newNearby, nearbyCount, entity, model, netId, globalType, globalOptions,
                                         pedCoords, px, py, pz)
    local options = getOptionsForEntity(entity, model, netId, globalOptions)
    if options then
        local coords = getCoordsFromOptions(entity, options)
        local dx, dy, dz = px - coords.x, py - coords.y, pz - coords.z
        local distSq = dx * dx + dy * dy + dz * dz
        local dist = mathSqrt(distSq)

        if distSq <= MAX_DISTANCE_SQ and hasAnyValidOptions(options, entity, dist, coords) then
            nearbyCount = addNearbyInteraction(newNearby, nearbyCount, globalType, entity, coords, options, entity, nil)
        end
    end

    local boneOptions = getBoneOptionsForEntity(entity, model, netId, globalType)
    if boneOptions then
        for boneId, boneOpts in pairs(boneOptions) do
            local boneCoords = getBoneCoords(entity, boneId)
            if boneCoords then
                local dx, dy, dz = px - boneCoords.x, py - boneCoords.y, pz - boneCoords.z
                local distSq = dx * dx + dy * dy + dz * dz
                local dist = mathSqrt(distSq)

                if distSq <= MAX_DISTANCE_SQ and hasAnyValidOptions(boneOpts, entity, dist, boneCoords) then
                    nearbyCount = addNearbyInteraction(newNearby, nearbyCount, globalType .. "_bone", boneId, boneCoords,
                        boneOpts, entity, nil)
                end
            end
        end
    end

    local offsetOptions = getOffsetOptionsForEntity(entity, model, netId, globalType)
    if offsetOptions then
        for offsetStr, offsetOpts in pairs(offsetOptions) do
            local offsetCoords = getOffsetCoords(entity, offsetStr)
            if offsetCoords then
                local dx, dy, dz = px - offsetCoords.x, py - offsetCoords.y, pz - offsetCoords.z
                local distSq = dx * dx + dy * dy + dz * dz
                local dist = mathSqrt(distSq)

                if distSq <= MAX_DISTANCE_SQ and hasAnyValidOptions(offsetOpts, entity, dist, offsetCoords) then
                    nearbyCount = addNearbyInteraction(newNearby, nearbyCount, globalType .. "_offset", offsetStr,
                        offsetCoords, offsetOpts, entity, nil)
                end
            end
        end
    end

    return nearbyCount
end

local function nearbyLoop()
    while true do
        local newNearby = {}
        local nearbyCount = 0
        local ped = cache.ped
        local pedCoords = GetEntityCoords(ped)
        local px, py, pz = pedCoords.x, pedCoords.y, pedCoords.z

        if not IsNuiFocused() and not disabled then
            clearEntityCache()

            local objects = libGetNearbyObjects(pedCoords, MAX_DISTANCE)
            for i = 1, #objects do
                local obj = objects[i]
                local entity = obj.object
                local model, netId = cachedEntityInfo(entity)
                nearbyCount = processEntityInteractions(newNearby, nearbyCount, entity, model, netId, "objects",
                    globalObjectOptions, pedCoords, px, py, pz)
            end

            local vehicles = libGetNearbyVehicles(pedCoords, MAX_DISTANCE, true)
            for i = 1, #vehicles do
                local veh = vehicles[i]
                local entity = veh.vehicle
                local model, netId = cachedEntityInfo(entity)
                nearbyCount = processEntityInteractions(newNearby, nearbyCount, entity, model, netId, "vehicles",
                    globalVehicleOptions, pedCoords, px, py, pz)
            end

            local peds = libGetNearbyPeds(pedCoords, MAX_DISTANCE)
            for i = 1, #peds do
                local p = peds[i]
                local entity = p.ped
                if entity ~= ped and not IsPedAPlayer(entity) then
                    local model, netId = cachedEntityInfo(entity)
                    nearbyCount = processEntityInteractions(newNearby, nearbyCount, entity, model, netId, "peds",
                        globalPedOptions, pedCoords, px, py, pz)
                end
            end

            if #globalPlayerOptions > 0 then
                local players = libGetNearbyPlayers(pedCoords, MAX_DISTANCE, false)
                for i = 1, #players do
                    local p = players[i]
                    local entity = p.ped
                    local model, netId = cachedEntityInfo(entity)
                    nearbyCount = processEntityInteractions(newNearby, nearbyCount, entity, model, netId, "players",
                        globalPlayerOptions, pedCoords, px, py, pz)
                end
            end

            for id, interaction in pairs(coordInteractions) do
                local coords = interaction.coords
                local dx, dy, dz = px - coords.x, py - coords.y, pz - coords.z
                local distSq = dx * dx + dy * dy + dz * dz
                local dist = mathSqrt(distSq)

                if distSq <= MAX_DISTANCE_SQ and hasAnyValidOptions(interaction.options, nil, dist, coords) then
                    nearbyCount = addNearbyInteraction(newNearby, nearbyCount, "coord", id, coords, interaction.options,
                        nil, id)
                end
            end
        end

        if nearbyCount > 1 then
            tableSort(newNearby, sortByScreenDistance)
        end

        nearbyinteractions = newNearby

        if nearbyCount > 0 and not drawRunning then
            drawLoop()
        end

        Wait(100)
    end
end

-----------------------------------------------------------
-- PUBLIC API
-----------------------------------------------------------

function interact.init()
    config = Modules.require('config')
    inventory = Modules.get('inventory')
    bridge = Modules.require('bridge')
    drawText = Modules.require('drawText')

    if config.interact:lower() ~= "drawtext" then
        local originalInteract = config.interact
        local deadline = GetGameTimer() + 1000
        while config.interact:lower() ~= "drawtext" and not Modules.isLoaded('interact') and GetGameTimer() < deadline do
            Wait(50)
        end
        if Modules.isLoaded('interact') then return end
        lib.print.warn('[wasabi_ambulance_v2] Configured interact "' .. tostring(originalInteract) .. '" failed to start - using drawText as fallback')
        config.interact = "drawText"
    end
end

--- Adds interaction options to a local entity (by entity handle)
---@param entity number|number[] Entity handle or array of entity handles
---@param options table|table[] Interaction options
function interact.addLocalEntity(entity, options)
    if type(options) == 'table' and options.label then
        options = { options }
    end

    if type(entity) == 'table' then
        for i = 1, #entity do
            local ent = entity[i]
            if DoesEntityExist(ent) then
                entityInteractions[ent] = entityInteractions[ent] or {}
                bones.localEntities[ent] = bones.localEntities[ent] or {}
                offsets.localEntities[ent] = offsets.localEntities[ent] or {}
                local opts = table.clone(options)
                addOptionsWithBonesAndOffsets(entityInteractions[ent], opts, bones.localEntities[ent],
                    offsets.localEntities[ent])
            end
        end
    else
        if DoesEntityExist(entity) then
            entityInteractions[entity] = entityInteractions[entity] or {}
            bones.localEntities[entity] = bones.localEntities[entity] or {}
            offsets.localEntities[entity] = offsets.localEntities[entity] or {}
            local opts = table.clone(options)
            addOptionsWithBonesAndOffsets(entityInteractions[entity], opts, bones.localEntities[entity],
                offsets.localEntities[entity])
        end
    end
end

--- Removes interaction options from a local entity
---@param entity number|number[] Entity handle or array of entity handles
---@param optionNames? string|string[] Optional specific option names to remove
function interact.removeLocalEntity(entity, optionNames)
    if type(entity) == 'table' then
        for i = 1, #entity do
            local ent = entity[i]
            entityInteractions[ent] = nil
            bones.localEntities[ent] = nil
            offsets.localEntities[ent] = nil
        end
    else
        entityInteractions[entity] = nil
        bones.localEntities[entity] = nil
        offsets.localEntities[entity] = nil
    end
end

--- Alias for addLocalEntity (sleepless_interact compatibility)
---@param entity number|number[] Entity handle or array of entity handles
---@param options table|table[] Interaction options
function interact.addEntity(entity, options)
    interact.addLocalEntity(entity, options)
end

--- Alias for removeLocalEntity (sleepless_interact compatibility)
---@param entity number|number[] Entity handle or array of entity handles
---@param optionNames? string|string[] Optional specific option names to remove
function interact.removeEntity(entity, optionNames)
    interact.removeLocalEntity(entity, optionNames)
end

--- Adds interaction options to a networked entity (by network ID)
---@param netId number|number[] Network ID or array of network IDs
---@param options table|table[] Interaction options
function interact.addNetEntity(netId, options)
    if type(options) == 'table' and options.label then
        options = { options }
    end

    if type(netId) == 'table' then
        for i = 1, #netId do
            local nid = netId[i]
            if NetworkDoesNetworkIdExist(nid) then
                netEntityInteractions[nid] = netEntityInteractions[nid] or {}
                bones.entities[nid] = bones.entities[nid] or {}
                offsets.entities[nid] = offsets.entities[nid] or {}
                local opts = table.clone(options)
                addOptionsWithBonesAndOffsets(netEntityInteractions[nid], opts, bones.entities[nid],
                    offsets.entities[nid])
            end
        end
    else
        if NetworkDoesNetworkIdExist(netId) then
            netEntityInteractions[netId] = netEntityInteractions[netId] or {}
            bones.entities[netId] = bones.entities[netId] or {}
            offsets.entities[netId] = offsets.entities[netId] or {}
            local opts = table.clone(options)
            addOptionsWithBonesAndOffsets(netEntityInteractions[netId], opts, bones.entities[netId],
                offsets.entities[netId])
        end
    end
end

--- Removes interaction options from a networked entity
---@param netId number|number[] Network ID or array of network IDs
---@param optionNames? string|string[] Optional specific option names to remove
function interact.removeNetEntity(netId, optionNames)
    if type(netId) == 'table' then
        for i = 1, #netId do
            local nid = netId[i]
            netEntityInteractions[nid] = nil
            bones.entities[nid] = nil
            offsets.entities[nid] = nil
        end
    else
        netEntityInteractions[netId] = nil
        bones.entities[netId] = nil
        offsets.entities[netId] = nil
    end
end

--- Adds interaction options to all entities of a specific model
---@param model number|string|table Model hash, name, or array of models
---@param options table|table[] Interaction options
function interact.addModel(model, options)
    if type(options) == 'table' and options.label then
        options = { options }
    end

    if type(model) == 'table' then
        for i = 1, #model do
            local m = model[i]
            m = type(m) == 'string' and joaat(m) or m
            modelInteractions[m] = modelInteractions[m] or {}
            bones.models[m] = bones.models[m] or {}
            offsets.models[m] = offsets.models[m] or {}
            local opts = table.clone(options)
            addOptionsWithBonesAndOffsets(modelInteractions[m], opts, bones.models[m], offsets.models[m])
        end
    else
        model = type(model) == 'string' and joaat(model) or model
        modelInteractions[model] = modelInteractions[model] or {}
        bones.models[model] = bones.models[model] or {}
        offsets.models[model] = offsets.models[model] or {}
        local opts = table.clone(options)
        addOptionsWithBonesAndOffsets(modelInteractions[model], opts, bones.models[model], offsets.models[model])
    end
end

--- Removes interaction options from a model
---@param model number|string|table Model hash, name, or array of models
---@param optionNames? string|string[] Optional specific option names to remove
function interact.removeModel(model, optionNames)
    if type(model) == 'table' then
        for i = 1, #model do
            local m = model[i]
            m = type(m) == 'string' and joaat(m) or m
            modelInteractions[m] = nil
        end
    else
        model = type(model) == 'string' and joaat(model) or model
        modelInteractions[model] = nil
    end
end

--- Adds interaction options at specific coordinates
---@param coords vector3|vector4|table Coordinates or array of coordinates
---@param options table|table[] Interaction options
---@return string|string[] id The ID(s) of the created interaction(s)
function interact.addCoords(coords, options)
    if type(options) == 'table' and options.label then
        options = { options }
    end

    -- Handle table with x,y,z keys
    if type(coords) == 'table' and coords.x and coords.y and coords.z then
        coords = vector3(coords.x, coords.y, coords.z)
    end

    -- Handle vector4
    if type(coords) == 'vector4' then
        coords = vector3(coords.x, coords.y, coords.z)
    end

    -- Handle array of coordinates
    if type(coords) == 'table' and not coords.x then
        local ids = {}
        for i = 1, #coords do
            local c = coords[i]
            if type(c) == 'vector4' then
                c = vector3(c.x, c.y, c.z)
            elseif type(c) == 'table' and c.x then
                c = vector3(c.x, c.y, c.z)
            end
            local id = generateCoordId(c)
            coordInteractions[id] = { coords = c, options = options }
            ids[i] = id
        end
        return #ids == 1 and ids[1] or ids
    end

    local id = generateCoordId(coords)
    coordInteractions[id] = { coords = coords, options = options }
    return id
end

--- Removes interaction options from coordinates
---@param id string|string[] Coordinate ID or array of IDs
---@param optionNames? string|string[] Optional specific option names to remove
function interact.removeCoords(id, optionNames)
    if type(id) == 'table' then
        for i = 1, #id do
            coordInteractions[id[i]] = nil
        end
    else
        coordInteractions[id] = nil
    end
end

function interact.removeZone(zoneId)
    if not zoneId then return end
    interact.removeCoords(zoneId)
end

--- Adds global interaction options for all peds
---@param options table|table[] Interaction options
function interact.addGlobalPed(options)
    if type(options) == 'table' and options.label then
        options = { options }
    end
    options = table.clone(options)
    addOptionsWithBonesAndOffsets(globalPedOptions, options, bones.peds, offsets.peds)
end

--- Removes global interaction options from peds
---@param optionNames? string|string[] Optional specific option names to remove
function interact.removeGlobalPed(optionNames)
    if not optionNames then
        globalPedOptions = {}
        return
    end

    if type(optionNames) ~= 'table' then
        optionNames = { optionNames }
    end

    for i = #globalPedOptions, 1, -1 do
        for j = 1, #optionNames do
            if globalPedOptions[i].name == optionNames[j] then
                tableRemove(globalPedOptions, i)
                break
            end
        end
    end
end

--- Adds global interaction options for all vehicles
---@param options table|table[] Interaction options
function interact.addGlobalVehicle(options)
    if type(options) == 'table' and options.label then
        options = { options }
    end
    options = table.clone(options)
    addOptionsWithBonesAndOffsets(globalVehicleOptions, options, bones.vehicles, offsets.vehicles)
end

--- Removes global interaction options from vehicles
---@param optionNames? string|string[] Optional specific option names to remove
function interact.removeGlobalVehicle(optionNames)
    if not optionNames then
        globalVehicleOptions = {}
        return
    end

    if type(optionNames) ~= 'table' then
        optionNames = { optionNames }
    end

    for i = #globalVehicleOptions, 1, -1 do
        for j = 1, #optionNames do
            if globalVehicleOptions[i].name == optionNames[j] then
                tableRemove(globalVehicleOptions, i)
                break
            end
        end
    end
end

--- Adds global interaction options for all objects
---@param options table|table[] Interaction options
function interact.addGlobalObject(options)
    if type(options) == 'table' and options.label then
        options = { options }
    end
    options = table.clone(options)
    addOptionsWithBonesAndOffsets(globalObjectOptions, options, bones.objects, offsets.objects)
end

--- Removes global interaction options from objects
---@param optionNames? string|string[] Optional specific option names to remove
function interact.removeGlobalObject(optionNames)
    if not optionNames then
        globalObjectOptions = {}
        return
    end

    if type(optionNames) ~= 'table' then
        optionNames = { optionNames }
    end

    for i = #globalObjectOptions, 1, -1 do
        for j = 1, #optionNames do
            if globalObjectOptions[i].name == optionNames[j] then
                tableRemove(globalObjectOptions, i)
                break
            end
        end
    end
end

--- Adds global interaction options for all players
---@param options table|table[] Interaction options
function interact.addGlobalPlayer(options)
    if type(options) == 'table' and options.label then
        options = { options }
    end
    options = table.clone(options)
    addOptionsWithBonesAndOffsets(globalPlayerOptions, options, bones.players, offsets.players)
end

--- Removes global interaction options from players
---@param optionNames? string|string[] Optional specific option names to remove
function interact.removeGlobalPlayer(optionNames)
    if not optionNames then
        globalPlayerOptions = {}
        return
    end

    if type(optionNames) ~= 'table' then
        optionNames = { optionNames }
    end

    for i = #globalPlayerOptions, 1, -1 do
        for j = 1, #optionNames do
            if globalPlayerOptions[i].name == optionNames[j] then
                tableRemove(globalPlayerOptions, i)
                break
            end
        end
    end
end

--- Disables or enables the interaction system
---@param state boolean Whether to disable (true) or enable (false)
function interact.setDisabled(state)
    disabled = state
    if state then
        nearbyinteractions = {}
        currentState = {
            entity = nil,
            coordsId = nil,
            coords = nil,
            distance = nil
        }
    end
end

--- Alternative name for setDisabled (for sleepless_interact compatibility)
---@param state boolean Whether to disable (true) or enable (false)
function interact.disableInteract(state)
    interact.setDisabled(state)
end

--- Returns whether the interact system is currently disabled
---@return boolean
function interact.isDisabled()
    return disabled
end

-- Start the nearby loop
CreateThread(nearbyLoop)

-- Cleanup thread for stale entity cache entries
CreateThread(function()
    while true do
        Wait(30000)
        -- Cleanup local entity interactions for entities that no longer exist
        for entity in pairs(entityInteractions) do
            if not DoesEntityExist(entity) then
                entityInteractions[entity] = nil
                bones.localEntities[entity] = nil
                offsets.localEntities[entity] = nil
            end
        end

        -- Cleanup net entity interactions for network IDs that no longer exist
        for netId in pairs(netEntityInteractions) do
            if not NetworkDoesNetworkIdExist(netId) then
                netEntityInteractions[netId] = nil
                bones.entities[netId] = nil
                offsets.entities[netId] = nil
            end
        end
    end
end)

Modules.register('interact', interact, {
    dependencies = { 'config', 'bridge', 'drawText', 'inventory' }
})
