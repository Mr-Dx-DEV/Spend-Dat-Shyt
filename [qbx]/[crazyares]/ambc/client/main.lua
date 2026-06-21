local isUnpacking = false

RegisterNetEvent('donk-ammobox:client:useBox', function(boxName)
    local boxConfig = Config.AmmoBoxes[boxName]
    if not boxConfig then return end
    if isUnpacking then return end
    if Config.Animation.disableInCar and IsPedInAnyVehicle(cache.ped, false) then
        lib.notify({
            title = _L('error_title'),
            description = _L('error_disabled'),
            type = 'error',
            position = Config.Notifications.position,
            duration = Config.Notifications.duration,
        })
        TriggerServerEvent('donk-ammobox:server:finishUnpack', boxName, false)
        return
    end

    isUnpacking = true
    local propModel = joaat(Config.Animation.prop.model)
    lib.requestModel(propModel)

    local prop = CreateObject(propModel, 0.0, 0.0, 0.0, true, true, true)
    local boneIndex = GetPedBoneIndex(cache.ped, Config.Animation.prop.bone)

    AttachEntityToEntity(
        prop, cache.ped, boneIndex,
        Config.Animation.prop.pos.x, Config.Animation.prop.pos.y, Config.Animation.prop.pos.z,
        Config.Animation.prop.rot.x, Config.Animation.prop.rot.y, Config.Animation.prop.rot.z,
        true, true, false, true, 1, true
    )

    SetModelAsNoLongerNeeded(propModel)

    local success = lib.progressCircle({
        duration = Config.Animation.duration,
        label = _L('unpack_progress'),
        position = 'bottom',
        useWhileDead = false,
        canCancel = Config.Animation.canCancel,
        disable = {
            car = true,
            move = true,
            combat = true,
        },
        anim = {
            dict = Config.Animation.dict,
            clip = Config.Animation.clip,
            flag = Config.Animation.flag,
        },
    })

    if DoesEntityExist(prop) then
        DeleteEntity(prop)
    end

    StopAnimTask(cache.ped, Config.Animation.dict, Config.Animation.clip, 1.0)
    isUnpacking = false
    TriggerServerEvent('donk-ammobox:server:finishUnpack', boxName, success)
end)
