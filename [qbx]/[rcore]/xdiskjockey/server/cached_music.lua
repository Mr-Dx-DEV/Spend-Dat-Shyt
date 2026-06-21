CreateThread(function()
    while true do
        Wait(1000)
        for k, v in pairs(CachePlayingMusic) do
            for key, value in pairs(v) do
                if not value.Time then
                    value.Time = 0
                end
                if not value.MaxTime then
                    value.MaxTime = 1
                end

                value.Time = value.Time + 1
                if value.Time >= value.MaxTime then
                    if value.Loop then
                        value.Time = 0
                    else
                        for index, val in pairs(CacheMixersMusic[k]) do
                            if val.url == value.URL and val.name == value.Name then
                                TriggerClientEvent("xdiskjockey:updateStatusPlayList", -1, "playButton", true, val.url, value.Name, k)
                                TriggerClientEvent("xdiskjockey:removeFromActiveMusic", -1, val.url, value.Name, k)
                                CacheMixersMusic[k][index].Active = true
                                break
                            end
                        end

                        CachePlayingMusic[k][key] = nil
                    end
                end
            end
        end
    end
end, "Adding seconds to cached playing music")

RegisterNetEvent("xdiskjockey:fetchMusicCacheToPlay", function()
    local source = source
    TriggerClientEvent("xdiskjockey:fetchMusicCacheToPlay", source, CachePlayingMusic, CachedVolumeMixer)
end)