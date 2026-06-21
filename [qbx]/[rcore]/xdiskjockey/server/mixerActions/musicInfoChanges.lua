RegisterNetEvent("xdiskjockey:saveMusic", function(mixer, data)
    local source = source
    if IsPlayerAllowedToUseMixer(source, mixer.identifier) then
        local player = SharedObject.GetPlayerFromId(source)

        if not CacheMixersMusic[mixer.identifier] then
            CacheMixersMusic[mixer.identifier] = {}
        end

        if data.time == 0 then
            data.time = nil
        end

        data.category = data.category == "false" and "null" or data.category

        table.insert(CacheMixersMusic[mixer.identifier], {
            ['Volume'] = 1.0,
            ['url'] = data.inputSrc,
            ['added_by'] = player.identifier,
            ['mixer_identifier'] = mixer.identifier,
            ['name'] = data.inputName,
            ['real_name'] = data.name,
            ['time'] = data.time or 999999999,
            ['category'] = data.category,
            ['Loop'] = false,
            ['created_at'] = os.time() * 1000,
            ['Active'] = true
        })

        MySQL.Async.execute("INSERT INTO playlist_mixer (time, real_name, url, name, mixer_identifier, added_by, category) VALUES (@time, @real_name, @url, @name, @mixer_identifier, @added_by, @category)",
                {
                    ['@time'] = data.time or 999999999,
                    ['@real_name'] = data.name,
                    ['@url'] = data.inputSrc,
                    ['@name'] = data.inputName,
                    ['@mixer_identifier'] = mixer.identifier,
                    ['@added_by'] = player.identifier,
                    ["@category"] = data.category,
                })

        OpenMixerForPlayer(source, mixer.identifier)
    end
end)

RegisterNetEvent("xdiskjockey:editMusic", function(mixer, data)
    local source = source
    if IsPlayerAllowedToUseMixer(source, mixer.identifier) then
        if CacheMixersMusic[mixer.identifier] then

            if data.category then
                if data.category == "false" or data.category == "null" then
                    data.category = "null"
                end
            end

            if data.time == 0 then
                data.time = nil
            end

            UpdateCacheMixersMusicValues(mixer.identifier, data.OldName, data.OldURL, {
                url = data.NewURL,
                name = data.NewName,

                category = data.category,

                time = data.time or 999999999,
                real_name = data.RealName,
            })

            MySQL.Async.execute("UPDATE playlist_mixer set url = @newUrl, category = @category, name = @newName, real_name = @real_name, time = @time WHERE url = @oldUrl AND name = @oldName AND mixer_identifier = @mixer_identifier",
                    {
                        ['@newUrl'] = data.NewURL,
                        ['@newName'] = data.NewName,

                        ['@oldUrl'] = data.OldURL,
                        ['@oldName'] = data.OldName,

                        ['@category'] = data.category,

                        ['@mixer_identifier'] = mixer.identifier,

                        ['@time'] = data.time or 999999999,
                        ['@real_name'] = data.RealName,
                    })

            OpenMixerForPlayer(source, mixer.identifier)
        end
    end
end)

RegisterNetEvent("xdiskjockey:deleteMusic", function(mixer, data)
    local source = source
    data = data.modalData
    if IsPlayerAllowedToUseMixer(source, mixer.identifier) then
        local player = SharedObject.GetPlayerFromId(source)
        if CacheMixersMusic[mixer.identifier] then
            WipeCacheMixersMusicValues(mixer.identifier, data.Name, data.URL)

            MySQL.Async.execute("DELETE FROM playlist_mixer WHERE url = @url AND name = @name AND mixer_identifier = @mixer_identifier LIMIT 1",
                    {
                        ["@mixer_identifier"] = mixer.identifier,
                        ["@name"] = data.Name,
                        ["@url"] = data.URL,
                    })
            OpenMixerForPlayer(source, mixer.identifier)
        end
    end
end)