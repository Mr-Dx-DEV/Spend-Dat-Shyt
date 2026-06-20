function InspectPlayerChain(entity)
    local hasItem, isRealItem = lib.callback.await("snipe-icebox:hasItem", false)
    if not Config.AllowItemToInspectPlayerChain.enabled then 
        hasItem = true
        isRealItem = true
    end

    if not hasItem then ShowNotification("error", Locales["no_item_to_inspect"]) return end
    local playerId = GetPlayerByEntityID(entity)
    local serverID = GetPlayerServerId(playerId)
    local chainData = lib.callback.await("snipe-icebox:getPlayerChainInfo", false, serverID)
    if not chainData then
        ShowNotification("error", Locales["not_wearing_chain"])
    else
        
        local options = {}
        for k, v in pairs(Config.InfuseItems) do
            table.insert(options, {
                title = v.label,
                description = tostring(0),
                disabled = true,
            })
        end
        if isRealItem and not next(chainData.metadata) then
            ShowNotification("error", Locales["not_infused_player_chain"])
            return
        end

        if isRealItem then
            for k, v in pairs(chainData.metadata) do
                if Config.InfuseItems[k] then
                    for _, data in pairs(options) do
                        if data.title == Config.InfuseItems[k].label then
                            data.description = tostring(v)
                        end
                    end
                end
            end
        else
            options = {}
            for k, v in pairs(Config.InfuseItems) do
                local randNum = math.random(1, 2)
                table.insert(options, {
                    title = v.label,
                    description = tostring(randNum),
                    disabled = true,
                })
            end
        end
        local title = string.format(Locales["chain_information_player"], chainData.playerName)
        lib.registerContext({
            id = "snipe-icebox:InspectPlayerChain",
            title = title,
            options = options,
        })

        lib.showContext("snipe-icebox:InspectPlayerChain")
    end
end
