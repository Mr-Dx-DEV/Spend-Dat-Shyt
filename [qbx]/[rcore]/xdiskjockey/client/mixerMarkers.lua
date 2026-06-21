local closestMarkerIndex = {}
local lastPos = vector3(0, 0, 0)

local closeToIntreactWithMixer = 2

CreateThread(function()
    lastPos = GetEntityCoords(PlayerPedId())
    while true do
        Wait(200)
        lastPos = GetEntityCoords(PlayerPedId())
    end
end,"Updating player cached position")

CreateThread(function()
    lastPos = GetEntityCoords(PlayerPedId())
    while true do
        Wait(200)
        closestMarkerIndex = {}
        for identifier, v in pairs(Config.MixerList) do
            for key, val in pairs(v.mixer) do
                if key == "jobs" then
                    print(identifier, "has wrong placement of `jobs` it has to be somewhere else. Please look at the unedited config.lua where to put it!")
                else
                    if not val.isPlayerMixer then
                        local inJob = true
                        val.identifier = identifier

                        if #(val.pos - lastPos) < val.distance then
                            if v.jobs then
                                inJob = false
                                if IsPlayerAtJob(v.jobs) then
                                    inJob = true
                                    table.insert(closestMarkerIndex, val)
                                end
                            else
                                inJob = true
                                table.insert(closestMarkerIndex, val)
                            end
                        end

                        if inJob then
                            if #(val.pos - lastPos) < closeToIntreactWithMixer then
                                if not val.entered then
                                    val.entered = true
                                    ShowHelpNotification(_U("mixer_enter"))
                                end
                            else
                                if val.entered then
                                    if ActiveMixer then
                                        HideDiskjockeyUI()
                                    end
                                    val.entered = false
                                end
                            end
                        end
                    else
                        if #(val.pos - lastPos) < val.distance then
                            if not val.entity then
                                val.entity = CreateLocalObject(Config.MixerPlaceObject, val.pos)
                                PlaceObjectOnGroundProperly(val.entity)
                                FreezeEntityPosition(val.entity, true)
                                SetEntityHeading(val.entity, val.heading)

                                val.markerPos = GetOffsetFromEntityInWorldCoords(val.entity, Config.MarkerOffsetForObject)

                                val.teleportPlayer = {
                                    pos = GetOffsetFromEntityInWorldCoords(val.entity, Config.MixerObjectOffsetTeleport),
                                    heading = val.heading - Config.OffsetHeadingForObjectTeleport,

                                    animDict = Config.AnimDictMixerIdle,
                                    animClip = Config.AnimClipMixerIdle,
                                }
                            end
                            val.identifier = identifier

                            table.insert(closestMarkerIndex, val)
                        else
                            if val.entity then
                                DeleteEntity(val.entity)
                                val.entity = nil
                            end
                        end

                        if #(val.pos - lastPos) < closeToIntreactWithMixer then
                            if not val.entered then
                                val.entered = true
                                ShowHelpNotification(_U("mixer_enter_user"))
                            end
                        else
                            if val.entered then
                                if ActiveMixer then
                                    HideDiskjockeyUI()
                                end
                                val.entered = false
                            end
                        end
                    end
                end
            end
        end
    end
end,"Checking nearby mixers if he is close + he got job ")

CreateThread(function()
    while true do
        Wait(0)
        if #closestMarkerIndex == 0 then
            Wait(1000)
        end

        for k, v in pairs(closestMarkerIndex) do
            if not v.isPlayerMixer then
                DrawMarker(31, v.pos.x, v.pos.y, v.pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 100, false, true, 2, false, false, false, false)
                DrawMarker(20, v.pos.x, v.pos.y, v.pos.z - 0.3, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 100, false, true, 2, true, false, false, false)
                DrawMarker(25, v.pos.x, v.pos.y, v.pos.z - 0.9, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 100, false, true, 2, false, false, false, false)
            else
                DrawMarker(24, v.markerPos.x, v.markerPos.y, v.markerPos.z + 0.2, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.2, 255, 125, 125, 255, false, false, 2, true, false, false, false)
            end
        end
    end
end, "Rendering markers for mixer")

RegisterKey(function()
    if #closestMarkerIndex == 0 then
        return
    end
    local data = closestMarkerIndex[1]
    if data then
        if #(data.pos - lastPos) < closeToIntreactWithMixer then
            ActiveMixer = data
            OpenDiskjockeyUI()
        end
    end
end, "opendiskjockeyui", "Will open xdj UI", "E")

local blockMe = false
RegisterKey(function()
    if #closestMarkerIndex == 0 then
        return
    end
    if blockMe then
        return
    end
    blockMe = true
    CreateThread(function()
        Wait(5000)
        blockMe = false
    end, "blockMe setting false thread")

    for k, data in pairs(closestMarkerIndex) do
        if data then
            if #(data.pos - lastPos) < closeToIntreactWithMixer and data.isPlayerMixer then
                PlayPickupAnim()
                Wait(800)
                TriggerServerEvent("xdiskjockey:pickupMixer", data)
                return
            end
        end
    end

end, "takemixerwithyou", "Will pick the mixer from ground", "G")