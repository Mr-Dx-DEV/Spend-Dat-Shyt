RegisterNetEvent("xdiskjockey:stopAllMusic", function(mixer, data)
    local source = source
    if source == nil or IsPlayerAllowedToUseMixer(source, mixer.identifier) then
        if CacheMixersMusic[mixer.identifier] then
            for k, v in pairs(CacheMixersMusic[mixer.identifier]) do
                v.Active = true
            end
        end

        CachePlayingMusic[mixer.identifier] = {}
        CurrentlyPlayingQueMusic[mixer.identifier] = {}
        QueMusicKey[mixer.identifier] = generate_unique_string(20)
        TriggerClientEvent("xdiskjockey:stopAllMusic", -1, mixer.identifier)

        CacheQueStatusMixersMusic[mixer.identifier] = false

        if source then
            OpenMixerForPlayer(source, mixer.identifier)
        end
    end
end)

RegisterNetEvent("xdiskjockey:playEffect", function(mixer, data)
    local source = source
    if IsPlayerAllowedToUseMixer(source, mixer.identifier) then
        if not IsMusicWhitelisted(data.URL) then
            return
        end
        data.Volume = CachedVolumeMixer[mixer.identifier] or Config.DefaultMixerVolume
        TriggerClientEvent("xdiskjockey:playEffect", -1, mixer, data)
    end
end)

RegisterNetEvent("xdiskjockey:sendActionCategory", function(mixer, data)
    local source = source
    if IsPlayerAllowedToUseMixer(source, mixer.identifier) then
        if not CacheMixersCategories[mixer.identifier] then
            CacheMixersCategories[mixer.identifier] = {}
        end

        if data.selectedCategory then
            if data.selectedCategory == "null" or data.selectedCategory == "false" then
                return
            end
        end

        if data.type == "create" then
            if string.len(data.inputCategory) <= 3 then
                TriggerClientEvent("xdiskjockey:notify", source, _U("category_minimum_letters"), "danger")
                return
            end

            if not DoesCategoryExists(mixer.identifier, data.inputCategory) then
                local player = SharedObject.GetPlayerFromId(source)

                CreateNewCategory(mixer.identifier, data.inputCategory)
                MySQL.Async.execute("INSERT INTO categories_mixer (identifier, category_name, added_by) VALUES (@identifier, @category_name, @added_by)",
                        {
                            ['@identifier'] = mixer.identifier,
                            ['@category_name'] = data.inputCategory,
                            ['@added_by'] = player.identifier,
                        })
            end
        end

        if data.type == "remove" then
            if DoesCategoryExists(mixer.identifier, data.selectedCategory) then
                MySQL.Async.execute("DELETE FROM categories_mixer WHERE category_name = @category_name AND identifier = @identifier",
                        {
                            ['@identifier'] = mixer.identifier,
                            ['@category_name'] = data.selectedCategory,
                        })

                RemoveCategoryByName(mixer.identifier, data.selectedCategory)

                if CacheMixersMusic[mixer.identifier] then
                    for k, v in pairs(CacheMixersMusic[mixer.identifier]) do
                        if v.category == data.selectedCategory then
                            v.category = "null"
                        end
                    end
                end

                MySQL.Async.execute("UPDATE playlist_mixer set category = @category_name WHERE category = @oldCat AND mixer_identifier = @mixer_identifier",
                        {
                            ['@mixer_identifier'] = mixer.identifier,
                            ['@category_name'] = "null",
                            ['@oldCat'] = data.selectedCategory,
                        })
            end
        end

        if data.type == "edit" then
            if string.len(data.inputCategory) <= 3 then
                if DoesCategoryExists(mixer.identifier, data.selectedCategory) then
                    EditCategoryNameByName(mixer.identifier, data.selectedCategory, data.inputCategory)

                    MySQL.Async.execute("UPDATE categories_mixer set category_name = @category_name WHERE category_name = @oldCatName AND identifier = @identifier",
                            {
                                ['@identifier'] = mixer.identifier,
                                ['@category_name'] = data.inputCategory,
                                ['@oldCatName'] = data.selectedCategory,
                            })

                    if CacheMixersMusic[mixer.identifier] then
                        for k, v in pairs(CacheMixersMusic[mixer.identifier]) do
                            if v.category == data.selectedCategory then
                                v.category = data.inputCategory
                            end
                        end
                    end

                    MySQL.Async.execute("UPDATE playlist_mixer set category = @category_name WHERE category = @oldCat AND mixer_identifier = @mixer_identifier",
                            {
                                ['@mixer_identifier'] = mixer.identifier,
                                ['@category_name'] = data.inputCategory,
                                ['@oldCat'] = data.selectedCategory,
                            })
                end
            else
                TriggerClientEvent("xdiskjockey:notify", source, _U("category_minimum_letters"), "danger")
            end
        end

        OpenMixerForPlayer(source, mixer.identifier)
    end
end)

RegisterNetEvent("xdiskjockey:fetchMixerPlayListCache", function(identifier)
    OpenMixerForPlayer(source, identifier)
end)