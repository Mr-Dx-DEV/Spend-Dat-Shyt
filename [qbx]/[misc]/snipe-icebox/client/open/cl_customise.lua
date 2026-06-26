function RemoveChains()

    for k, v in pairs(wearingChain) do
        if v.type == "prop" then
            DeleteEntity(v.chain)
            DeleteObject(v.chain)
        elseif v.type == "drawable" then
            SetPedComponentVariation(cache.ped, Config.Chains[v.name].componentId or 7 or 7, 0, 0, 0)
        end
        wearingChain[k] = nil
    end

    for k, v in pairs(wearingWatch) do
        if v.type == "prop" then
            DeleteEntity(v.watch)
            DeleteObject(v.watch)
        elseif v.type == "drawable" then
            ClearPedProp(cache.ped, Config.Watches[v.name].propId or 6)
        end
        wearingWatch[k] = nil
    end
end
exports("RemoveChains", RemoveChains)

function ShowNotification(type, msg, ...)
    local message = string.format(msg, ...)
    if Config.Notification == "ox" then
        lib.notify({description = message, type = type})
    elseif Config.Notification == "qb" then
        QBCore.Functions.Notify(message, type)
    elseif Config.Notification == "esx" then
        ESX.ShowNotification(message)
    end
end

CreateThread(function()
    for k, v in pairs(Config.Blips) do
        if v.enabled then
            local blip = AddBlipForCoord(v.coords)
            SetBlipSprite(blip, v.sprite)
            SetBlipDisplay(blip, v.display)
            SetBlipScale(blip, 0.5)
            SetBlipColour(blip, v.color)
            SetBlipAsShortRange(blip, v.shortRange)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v.label)
            EndTextCommandSetBlipName(blip)
        end
    end
end)
