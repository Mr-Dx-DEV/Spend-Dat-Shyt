local modelNaming = {}
function StartRemovingChainsAndWatchThread()
    for k, v in pairs(Config.Chains) do
        if v.drawable then
            for model, chainData in pairs(v.clothing) do
                if not modelNaming[GetHashKey(model)] then
                    modelNaming[GetHashKey(model)] = model
                end
                local model = GetHashKey(model)
                
                if not blacklistedChains[model] then
                    blacklistedChains[model] = {}
                end
                blacklistedChains[model][#blacklistedChains[model]+1] = {
                    drawable = chainData.drawable,
                    texture = chainData.texture,
                    componentId = v.componentId or 7,
                    name = k,
                }
            end
        end
    end
    for k, v in pairs(Config.Watches) do
        if v.drawable then
            for model, watchData in pairs(v.clothing) do
                local model = GetHashKey(model)
                if not blackListedWatches[model] then
                    blackListedWatches[model] = {}
                end
                blackListedWatches[model][#blackListedWatches[model]+1] = {
                    drawable = watchData.drawable,
                    texture = watchData.texture,
                    propId = v.propId or 6,
                    name = k,
                }
            end
        end
    end

    CreateThread(function()
        while true do
            Wait(1000) -- every 10 seconds it will check if you are wearing a chain or watch clothing and if it is blacklisted, it will remove it.
            if not testingChain then
                for k, v in pairs(blacklistedChains) do
                    if k == GetEntityModel(cache.ped) then
                        for _, data in pairs(v) do
                            local isValidChain = false
                            local drawable = GetPedDrawableVariation(cache.ped, data.componentId)
                            local texture = GetPedTextureVariation(cache.ped, data.componentId)
                            if data.drawable == drawable and data.texture == texture then
                                for _, wearingChainData in pairs(wearingChain) do
                                    if wearingChainData.type == "drawable" and Config.Chains[wearingChainData.name]["clothing"][modelNaming[GetEntityModel(cache.ped)]].drawable == drawable and Config.Chains[wearingChainData.name]["clothing"][modelNaming[GetEntityModel(cache.ped)]].texture == texture then
                                        isValidChain = true
                                    end
                                end
                                if not isValidChain then
                                    SetPedComponentVariation(cache.ped, data.componentId, 0, 0, 0)
                                end
                            end
                        end
                    end
                end
            end

            for k, v in pairs(wearingChain) do
                if v.type == "drawable" then
                    local modelHash = GetEntityModel(cache.ped)
                    local chainComponentId = Config.Chains[v.name].componentId or 7
                    local chainDrawable = Config.Chains[v.name]["clothing"][modelNaming[modelHash]].drawable
                    local chainTexture = Config.Chains[v.name]["clothing"][modelNaming[modelHash]].texture or 0
                    local drawable = GetPedDrawableVariation(cache.ped, chainComponentId)
                    local texture = GetPedTextureVariation(cache.ped, chainComponentId)
                    if drawable ~= chainDrawable or texture ~= chainTexture then
                        SetPedComponentVariation(cache.ped, chainComponentId, chainDrawable, chainTexture, 0)
                    end
                end
            end


            if not testingWatch then
                for k, v in pairs(blackListedWatches) do
                    if k == GetEntityModel(cache.ped) then
                        for _, data in pairs(v) do
                            local isValidWatch = false
                            local drawable = GetPedPropIndex(cache.ped, data.propId)
                            local texture = GetPedPropTextureIndex(cache.ped, data.propId)
                            if data.drawable == drawable and data.texture == texture then
                                for _, wearingWatchData in pairs(wearingWatch) do
                                    if wearingWatchData.type == "drawable" and Config.Watches[wearingWatchData.name]["clothing"][modelNaming[GetEntityModel(cache.ped)]].drawable == drawable and Config.Watches[wearingWatchData.name]["clothing"][modelNaming[GetEntityModel(cache.ped)]].texture == texture then
                                        isValidWatch = true
                                    end
                                end
                                if not isValidWatch then
                                    ClearPedProp(cache.ped, data.propId)
                                end
                            end
                        end
                    end
                end
            end

            for k, v in pairs(wearingWatch) do
                if v.type == "drawable" then
                    local modelHash = GetEntityModel(cache.ped)
                    local watchPropId = Config.Watches[v.name].propId or 6
                    local watchDrawable = Config.Watches[v.name]["clothing"][modelNaming[modelHash]].drawable
                    local watchTexture = Config.Watches[v.name]["clothing"][modelNaming[modelHash]].texture or 0
                    local drawable = GetPedPropIndex(cache.ped, watchPropId)
                    local texture = GetPedPropTextureIndex(cache.ped, watchPropId)
                    if drawable ~= watchDrawable or texture ~= watchTexture then
                        SetPedPropIndex(cache.ped, watchPropId, watchDrawable, watchTexture, 0)
                    end
                end
            end
        end
    end)
end