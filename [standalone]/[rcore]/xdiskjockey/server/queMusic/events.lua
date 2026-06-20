RegisterNetEvent("xdiskjockey:playQue", function(mixer, data)
    local source = source
    if IsPlayerAllowedToUseMixer(source, mixer.identifier) then
        CacheQueStatusMixersMusic[mixer.identifier] = data.playingQue

        if not data.playingQue then
            QueMusicKey[mixer.identifier] = generate_unique_string(20)
            TriggerClientEvent("xdiskjockey:stopAllQueMusic", -1, mixer.identifier)

            CurrentlyPlayingQueMusic[mixer.identifier] = {}
            for k, v in pairs(GetUsersInMixer(mixer.identifier)) do
                TriggerClientEvent("xdiskjockey:currentQueueMusic", v, CurrentlyPlayingQueMusic[mixer.identifier] or {})
            end
            return
        end

        if CacheMixersMusic[mixer.identifier] then
            QueMusicKey[mixer.identifier] = generate_unique_string(20)
            QuePlayListData[mixer.identifier] = {}
            TriggerClientEvent("xdiskjockey:stopAllQueMusic", -1, mixer.identifier)

            for k, v in pairs(CacheMixersMusic[mixer.identifier]) do
                if v.Que then
                    table.insert(QuePlayListData[mixer.identifier], v)
                end
            end
            PlayQueListMusic(mixer.identifier, QueMusicKey[mixer.identifier])
        end
    end
end)

RegisterNetEvent("xdiskjockey:ShufflePlayList", function(mixer)
    local source = source
    if IsPlayerAllowedToUseMixer(source, mixer.identifier) then

        if CacheMixersMusic[mixer.identifier] then
            CacheMixersMusic[mixer.identifier] = Shuffle(CacheMixersMusic[mixer.identifier])
        end

        OpenMixerForPlayer(source, mixer.identifier)
    end
end)

RegisterNetEvent("xdiskjockey:deleteQueList", function(mixer)
    local source = source
    if IsPlayerAllowedToUseMixer(source, mixer.identifier) then
        local isInQue = false
        if CacheMixersMusic[mixer.identifier] then
            for k, v in pairs(CacheMixersMusic[mixer.identifier]) do
                if CacheMixersMusic[mixer.identifier][k].Que then
                    isInQue = true
                end
                CacheMixersMusic[mixer.identifier][k].Que = false
            end

            if isInQue then
                CachePlayingMusic[mixer.identifier] = {}
                QueMusicKey[mixer.identifier] = generate_unique_string(20)
                TriggerClientEvent("xdiskjockey:stopAllQueMusic", -1, mixer.identifier)

                QuePlayListData[mixer.identifier] = {}

                MySQL.Async.execute("UPDATE playlist_mixer set que = @que WHERE mixer_identifier = @mixer_identifier",
                        {
                            ['@que'] = false,
                            ['@mixer_identifier'] = mixer.identifier,
                        })
            end
        end
    end
end)

RegisterNetEvent("xdiskjockey:skipQue", function(mixer, data)
    local source = source
    if IsPlayerAllowedToUseMixer(source, mixer.identifier) then
        data = data.musicInfo
        for k, v in pairs(QuePlayListData[mixer.identifier]) do
            if v.name == data.Name and v.url == data.URL then
                if QuePlayListData[mixer.identifier] then
                    if QuePlayListData[mixer.identifier][k] then
                        QuePlayListData[mixer.identifier][k].SkipQue = true
                    end
                end
            end
        end
    end
end)

RegisterNetEvent("xdiskjockey:addtoque", function(mixer, data)
    local source = source
    if IsPlayerAllowedToUseMixer(source, mixer.identifier) then

        if data.category then
            MySQL.Async.execute("UPDATE playlist_mixer set que = @que WHERE category = @category AND mixer_identifier = @mixer_identifier",
                    {
                        ['@que'] = data.status,
                        ['@category'] = data.category,
                        ['@mixer_identifier'] = mixer.identifier,
                    })

            for k, v in pairs(CacheMixersMusic[mixer.identifier]) do
                if data.category == v.category then
                    CacheMixersMusic[mixer.identifier][k].Que = true
                    if QuePlayListData[mixer.identifier] then
                        if QuePlayListData[mixer.identifier][k] then
                            QuePlayListData[mixer.identifier][k].Que = data.status
                        end
                    end
                end
            end

            if CacheQueStatusMixersMusic[mixer.identifier] then
                local quePlayingData = CurrentlyPlayingQueMusic[mixer.identifier]
                if not data.status then
                    for k, v in pairs(QuePlayListData[mixer.identifier]) do
                        if v.url == quePlayingData.url and v.name == quePlayingData.name then
                            TriggerClientEvent("xdiskjockey:stopAllQueMusic", -1, mixer.identifier)

                            QuePlayListData[mixer.identifier][k] = nil
                            QueMusicKey[mixer.identifier] = generate_unique_string(20)
                            PlayQueListMusic(mixer.identifier, QueMusicKey[mixer.identifier])
                            break
                        end
                    end
                else
                    data.mixer_identifier = mixer.identifier

                    for k, v in pairs(QuePlayListData[mixer.identifier]) do
                        if v.url == quePlayingData.url and v.name == quePlayingData.name then
                            table.insert(QuePlayListData[mixer.identifier], {
                                name = v.Name,
                                ['Active'] = v.Active,
                                ['time'] = v.time,
                                ['mixer_identifier'] = mixer.identifier,
                                ['url'] = v.URL,
                                Que = true,
                            })
                        end
                    end
                end
            end

            return
        end

        data = data.musicInfo

        if not CachePlayingMusic[mixer.identifier] then
            CachePlayingMusic[mixer.identifier] = {}
        end

        for k, v in pairs(CacheMixersMusic[mixer.identifier]) do
            if data.URL == v.url and data.Name == v.name then
                CacheMixersMusic[mixer.identifier][k].Que = data.Que

                MySQL.Async.execute("UPDATE playlist_mixer set que = @que WHERE url = @url AND name = @name AND mixer_identifier = @mixer_identifier",
                        {
                            ['@que'] = data.Que,

                            ['@url'] = data.URL,
                            ['@name'] = data.Name,

                            ['@mixer_identifier'] = mixer.identifier,
                        })

                if QuePlayListData[mixer.identifier] then
                    if QuePlayListData[mixer.identifier][k] then
                        QuePlayListData[mixer.identifier][k].Que = data.Que
                    end
                end
                break
            end
        end

        if CacheQueStatusMixersMusic[mixer.identifier] then
            local quePlayingData = CurrentlyPlayingQueMusic[mixer.identifier]
            if not data.Que then
                for k, v in pairs(QuePlayListData[mixer.identifier]) do
                    if v.url == quePlayingData.url and v.name == quePlayingData.name then
                        TriggerClientEvent("xdiskjockey:stopAllQueMusic", -1, mixer.identifier)

                        QuePlayListData[mixer.identifier][k] = nil
                        QueMusicKey[mixer.identifier] = generate_unique_string(20)
                        PlayQueListMusic(mixer.identifier, QueMusicKey[mixer.identifier])
                        break
                    end
                end
            else
                data.mixer_identifier = mixer.identifier

                if not QuePlayListData[mixer.identifier] then
                    QuePlayListData[mixer.identifier] = {}
                end

                table.insert(QuePlayListData[mixer.identifier], {
                    name = data.Name,
                    ['Active'] = data.Active,
                    ['time'] = data.time,
                    ['mixer_identifier'] = mixer.identifier,
                    ['url'] = data.URL,
                    Que = true,
                })
            end
        end

        TriggerClientEvent("xdiskjockey:sendMusicStatus", -1, "que", {
            Name = data.Name,
            Identifier = mixer.identifier,
            Que = data.Que,
        })
    end
end)

RegisterNetEvent("xdiskjockey:isQuePlaying", function(identifier)
    TriggerClientEvent("xdiskjockey:isQuePlaying", source, CacheQueStatusMixersMusic[identifier] or false)
end)
