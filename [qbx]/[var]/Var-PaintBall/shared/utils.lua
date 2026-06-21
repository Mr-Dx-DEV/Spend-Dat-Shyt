--[[
    Var-PaintBall — Shared Utilities
    Supports multi-arena configuration via Config.Arenas
]]

Utils = Utils or {}

local Config = Config or {}
local sqrt = math.sqrt

if not vec3 then function vec3(x, y, z) return vector3(x, y, z) end end
if not vec4 then function vec4(x, y, z, w) return vector4(x, y, z, w) end end

-- ─── Arena helpers ──────────────────────────────────────────────────────────

local function getArena(arenaKey)
    arenaKey = arenaKey or Config.DefaultArena or "default"
    if Config.Arenas and Config.Arenas[arenaKey] then
        return Config.Arenas[arenaKey]
    end
    return nil
end

local function getSpawns(arenaKey, team)
    local arena = getArena(arenaKey)
    if not arena then return {} end
    local spawns = arena.spawns or {}
    if spawns[team] and #spawns[team] > 0 then
        return spawns[team]
    end
    if team == "FFA" then
        local combined = {}
        for _, list in pairs(spawns) do
            for _, spawn in ipairs(list) do
                combined[#combined + 1] = spawn
            end
        end
        return combined
    end
    return {}
end

-- ─── Distance ───────────────────────────────────────────────────────────────

local function distance(a, b)
    local dx = a.x - b.x
    local dy = a.y - b.y
    local dz = (a.z or 0) - (b.z or 0)
    return sqrt(dx * dx + dy * dy + dz * dz)
end

-- ─── Ground snap ────────────────────────────────────────────────────────────

local function snapGround(point, maxDrop)
    maxDrop = maxDrop or 40.0
    local z = point.z
    if GetGroundZFor_3dCoord then
        local success, groundZ = GetGroundZFor_3dCoord(point.x, point.y, point.z + 10.0, false)
        if success then z = groundZ end
    elseif StartShapeTestRay and GetShapeTestResult then
        local handle = StartShapeTestRay(point.x, point.y, point.z + 20.0, point.x, point.y, point.z - maxDrop, -1, 0, 7)
        local _, hit, hitPos = GetShapeTestResult(handle)
        if hit == 1 and hitPos then z = hitPos.z end
    end
    return vec3(point.x, point.y, z)
end

local function isWater(coords)
    if TestVerticalProbeAgainstAllWater then
        local hit = TestVerticalProbeAgainstAllWater(coords.x, coords.y, coords.z + 8.0, coords.z - 12.0)
        return hit == 1
    elseif GetWaterHeight then
        local ok = GetWaterHeight(coords.x, coords.y, coords.z, 0.0)
        return ok
    end
    return false
end

-- ─── Public API ─────────────────────────────────────────────────────────────

function Utils.getArena(arenaKey)
    return getArena(arenaKey)
end

function Utils.getMapConfig()
    return getArena(Config.DefaultArena)
end

function Utils.getArenaList()
    local globalMax = Config.Gameplay and Config.Gameplay.MaxTeamSize or 6
    local list = {}
    if Config.Arenas then
        for key, arena in pairs(Config.Arenas) do
            list[#list + 1] = {
                key         = key,
                name        = arena.name or key,
                description = arena.description or "",
                image       = arena.image or key,
                maxTeamSize = arena.maxTeamSize or globalMax,
            }
        end
    end
    table.sort(list, function(a, b) return a.name < b.name end)
    return list
end

-- Spawn rotation state per team (round-robin with shuffle)
local spawnRotation = {}

local function shuffleTable(tbl)
    local n = #tbl
    for i = n, 2, -1 do
        local j = math.random(i)
        tbl[i], tbl[j] = tbl[j], tbl[i]
    end
    return tbl
end

function Utils.randomTeamSpawn(team, opts)
    opts = opts or {}
    local arenaKey = opts.arena or Config.DefaultArena
    local arena = getArena(arenaKey)
    local lookup = team or "FFA"
    local spawns = getSpawns(arenaKey, lookup)
    if #spawns == 0 then
        return nil, nil
    end

    -- Round-robin rotation: cycle through shuffled spawn list
    local rotKey = (arenaKey or "default") .. ":" .. lookup
    if not spawnRotation[rotKey] or spawnRotation[rotKey].index >= #spawns then
        -- Build shuffled index list
        local indices = {}
        for i = 1, #spawns do indices[i] = i end
        shuffleTable(indices)
        spawnRotation[rotKey] = { order = indices, index = 0 }
    end
    local rot = spawnRotation[rotKey]
    rot.index = rot.index + 1
    local choice = spawns[rot.order[rot.index]]

    local point = vec3(choice.x, choice.y, choice.z)
    if arena and arena.radius then
        -- inside arena, trust config Z
    else
        point = snapGround(point)
    end
    if isWater(point) then
        point = snapGround(point)
    end
    return vec4(point.x, point.y, point.z - 0.5, choice.w or 0.0), point
end

function Utils.resetSpawnRotation()
    spawnRotation = {}
end

local spawnZoneCache = {}

local function buildSpawnZone(team, arenaKey)
    local spawns = getSpawns(arenaKey, team)
    if #spawns == 0 then return nil end
    local sumX, sumY, sumZ = 0.0, 0.0, 0.0
    for _, spawn in ipairs(spawns) do
        sumX = sumX + spawn.x
        sumY = sumY + spawn.y
        sumZ = sumZ + spawn.z
    end
    local count = #spawns
    local arena = getArena(arenaKey)
    local radius = 6.0
    if arena and arena.spawnZones and arena.spawnZones[team] then
        radius = arena.spawnZones[team].radius or radius
    end
    local zone = {
        center = vec3(sumX / count, sumY / count, sumZ / count),
        radius = radius,
    }
    local cacheKey = (arenaKey or "default") .. ":" .. team
    spawnZoneCache[cacheKey] = zone
    return zone
end

function Utils.getTeamSpawnZone(team, arenaKey)
    if not team then return nil end
    local cacheKey = (arenaKey or Config.DefaultArena or "default") .. ":" .. team
    if not spawnZoneCache[cacheKey] then
        spawnZoneCache[cacheKey] = buildSpawnZone(team, arenaKey)
    end
    return spawnZoneCache[cacheKey]
end

function Utils.clearSpawnZoneCache()
    spawnZoneCache = {}
end

function Utils.clamp(val, minVal, maxVal)
    return math.max(minVal, math.min(maxVal, val))
end

function Utils.getFramework()
    if GetResourceState then
        if GetResourceState("es_extended") == "started" then return "ESX" end
        if GetResourceState("qb-core") == "started" then return "QBCore" end
        if GetResourceState("vrp") == "started" then return "vRP" end
    end
    return "Standalone"
end

return Utils
