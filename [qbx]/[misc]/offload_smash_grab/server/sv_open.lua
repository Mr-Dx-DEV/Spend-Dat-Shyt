
local Bridge = exports['community_bridge']:Bridge()

function giveLoot(_src, _lootIdx, _lootDef)
    if not _lootDef or not _lootDef.rewards then
        return
    end

    for i = 1, #_lootDef.rewards do
        local reward = _lootDef.rewards[i]
        if math.random(100) <= reward.chance then
            local count = math.random(reward.min, reward.max)
            if count > 0 then
                Bridge.Inventory.AddItem(_src, reward.item, count, nil, nil)
            end
        end
    end
end