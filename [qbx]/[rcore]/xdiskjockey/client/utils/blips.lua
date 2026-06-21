if Config.EnableBlipsOnMap then
    -- Will create blips on the map
    CreateThread(function()
        for k, v in pairs(Config.BlipList) do
            createBlip(v.Options.name, v.Sprite, v.Position, v.Options)
        end
    end,"Creating all blips on map")
end

function createBlip(name, blip, coords, options)
    local x, y, z = table.unpack(coords)
    local ourBlip = AddBlipForCoord(x, y, z)
    SetBlipSprite(ourBlip, blip)
    if options.type then
        SetBlipDisplay(ourBlip, options.type)
    end
    if options.scale then
        SetBlipScale(ourBlip, options.scale)
    end
    if options.color then
        SetBlipColour(ourBlip, options.color)
    end
    if options.shortRange then
        SetBlipAsShortRange(ourBlip, options.shortRange)
    end
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(name)
    EndTextCommandSetBlipName(ourBlip)
    return ourBlip
end
