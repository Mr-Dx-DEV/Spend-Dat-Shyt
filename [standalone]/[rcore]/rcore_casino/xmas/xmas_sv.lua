XMAS_TREES = {}

for k, v in pairs(Config.ActiveMaps) do
    if k == 1 then
        -- Add christmas trees for DlcIplLoader/Unclejust map
        table.insert(XMAS_TREES, {
            map = k,
            position = vector3(922.34417, 39.01713, 71.1567),
            heading = -45.0,
            rewardMin = 100, -- min. amount
            rewardMax = 1000, -- max amount
            rewardChooseFrom = {Config.ChipsInventoryItem}, -- choose reward randomly from these inventory items
            cooldown = (60 * 60 * 24) -- 24 hours
        })
        table.insert(XMAS_TREES, {
            map = k,
            position = vector3(967.36065, 48.62191, 69.686),
            heading = 140.0,
            rewardMin = 100, -- min. amount
            rewardMax = 1000, -- max amount
            rewardChooseFrom = {Config.ChipsInventoryItem}, -- choose reward randomly from these inventory items
            cooldown = (60 * 60 * 24) -- 24 hours
        })
    elseif k == 2 or k == 3 then
        -- Add christmas trees for Gabz map
        table.insert(XMAS_TREES, {
            map = k,
            position = vector3(958.52392, 35.96862, 70.84322),
            heading = -45.0,
            rewardMin = 100, -- min. amount
            rewardMax = 1000, -- max amount
            rewardChooseFrom = {Config.ChipsInventoryItem}, -- choose reward randomly from these inventory items
            cooldown = (60 * 60 * 24) -- 24 hours
        })
        table.insert(XMAS_TREES, {
            map = k,
            position = vector3(1008.65563, 46.41557, 69.3734),
            heading = 160.0,
            rewardMin = 100, -- min. amount
            rewardMax = 1000, -- max amount
            rewardChooseFrom = {Config.ChipsInventoryItem}, -- choose reward randomly from these inventory items
            cooldown = (60 * 60 * 24) -- 24 hours
        })
    elseif k == 4 then
        -- Add christmas trees for k4mb1 casino
        table.insert(XMAS_TREES, {
            map = k,
            position = vector3(944.8862, 48.21997, 79.9),
            heading = 40.0,
            rewardMin = 100, -- min. amount
            rewardMax = 1000, -- max amount
            rewardChooseFrom = {Config.ChipsInventoryItem}, -- choose reward randomly from these inventory items
            cooldown = (60 * 60 * 24) -- 24 hours
        })
        table.insert(XMAS_TREES, {
            map = k,
            position = vector3(968.13952, 50.96340, 80.45),
            heading = 240.0,
            rewardMin = 100, -- min. amount
            rewardMax = 1000, -- max amount
            rewardChooseFrom = {Config.ChipsInventoryItem}, -- choose reward randomly from these inventory items
            cooldown = (60 * 60 * 24) -- 24 hours
        })
    elseif k == 5 then
        -- Add christmas trees for GTA:O Interior (rcore_casino_interior)
        table.insert(XMAS_TREES, {
            map = k,
            position = vector3(2466.7766, -286.4762, -59.5143),
            heading = -45.0,
            rewardMin = 100, -- min. amount
            rewardMax = 1000, -- max amount
            rewardChooseFrom = {Config.ChipsInventoryItem}, -- choose reward randomly from these inventory items
            cooldown = (60 * 60 * 24) -- 24 hours
        })
        table.insert(XMAS_TREES, {
            map = k,
            position = vector3(2503.8876, -251.5882, -60.8853),
            heading = 160.0,
            rewardMin = 100, -- min. amount
            rewardMax = 1000, -- max amount
            rewardChooseFrom = {Config.ChipsInventoryItem}, -- choose reward randomly from these inventory items
            cooldown = (60 * 60 * 24) -- 24 hours
        })
    end
end

-- load xmas trees for player
RegisterNetEvent("rcore_casino:LoadXmas")
AddEventHandler("rcore_casino:LoadXmas", function(mapType)
    local playerId = source
    local identifier = GetPlayerIdentifier(playerId)
    local cache = Cache:GetNow(identifier)
    local cooldowns = cache and json.decode(cache.xmasCooldowns) or {}
    local trees = {}

    -- load player cooldowns for trees
    for k, v in pairs(XMAS_TREES) do
        if v.map == mapType then
            local x = {
                position = v.position,
                heading = v.heading,
                id = k
            }
            if cooldowns[k] then
                x.cooldownUntil = cooldowns[k]
            end
            trees[k] = x
        end
    end

    TriggerClientEvent("rcore_casino:LoadXmas", playerId, trees)
end)

-- use xmas tree
RegisterNetEvent("rcore_casino:XmasUseTree")
AddEventHandler("rcore_casino:XmasUseTree", function(treeId)
    local playerId = source

    if not Config.Xmas then
        return
    end

    -- tree doesn't exist
    local tree = XMAS_TREES[treeId]
    if not tree then
        return
    end

    -- load player
    local identifier = GetPlayerIdentifier(playerId)
    local cache = Cache:GetNow(identifier)
    local cooldowns = json.decode(cache.xmasCooldowns) or {}

    -- in cooldown
    if cooldowns and cooldowns[treeId] and GetServerTime() < cooldowns[treeId] then
        return
    end

    -- save cooldown
    local cooldown = GetServerTime() + tree.cooldown
    cooldowns[treeId] = cooldown
    cache.xmasCooldowns = json.encode(cooldowns)

    -- send reward
    local randomItem = GetRandomItem(tree.rewardChooseFrom)
    local randomAmount = math.ceil(RandomNumber(tree.rewardMin, tree.rewardMax))
    TriggerClientEvent("rcore_casino:XmasUseTree", playerId, treeId, randomItem, randomAmount, cooldown)
    Wait(3000)
    AddCasinoItem(playerId, randomItem, randomAmount)
end)
