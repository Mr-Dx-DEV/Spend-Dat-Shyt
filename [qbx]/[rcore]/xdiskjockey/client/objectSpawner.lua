CreateThread(function()
    while true do
        Wait(500)
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)

        for k, v in pairs(Config.SpawnMixerTable) do
            if #(pos - v.pos) < v.renderDistance then
                if not v.entity then
                    local entity = CreateLocalObject(v.model, v.pos)
                    FreezeEntityPosition(entity, true)
                    SetEntityHeading(entity, v.heading)

                    if v.rotation then
                        SetEntityRotation(entity, v.rotation)
                    end

                    v.entity = entity
                end
            else
                if v.entity then
                    DeleteEntity(v.entity)
                    v.entity = nil
                end
            end
        end
    end
end,"Entity spawner from config")

AddEventHandler("onResourceStop", function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    for k, v in pairs(Config.SpawnMixerTable) do
        if DoesEntityExist(v.entity) then
            DeleteEntity(v.entity)
        end
    end

    for identifier, v in pairs(Config.MixerList) do
        for key, val in pairs(v.mixer) do
            if val.entity then
                DeleteEntity(val.entity)
            end
        end
    end
end)
