if Config.EnableTeleportMarker then
    CreateThread(function()
        for k, v in pairs(Config.TeleportMarker) do
            for key, val in pairs(v) do
                local marker = createMarker()

                marker.setRenderDistance(10)
                marker.setPosition(val.markerPosition)

                marker.setRotation(val.markerStyle.rotation)
                marker.setType(val.markerStyle.style)
                marker.setColor(val.markerStyle.color)
                marker.setFaceCamera(val.markerStyle.faceCamera)

                marker.setScale(val.markerStyle.scale)

                marker.setInRadius(2.5)

                marker.setKeys(val.markerStyle.keysToOpen)

                marker.on("enter", function()
                    ShowHelpNotification(_U(key), false, true, 5000)
                end)

                marker.on("key", function()
                    -- must be in async thread so the "nearMarkrs" in "markers.lua" wont get broken because of missing key
                    CreateThread(function()
                        local ped = PlayerPedId()
                        DoScreenFadeOut(1000)
                        Wait(1000)

                        SetEntityCoordsNoOffset(ped, val.destination.x, val.destination.y, val.destination.z)
                        SetEntityHeading(ped, val.heading)
                        Wait(200)
                        DoScreenFadeIn(1000)
                    end, "thread in event 'onKey' for teleport from marker")
                end)
            end
        end
    end, "Teleport marker")
end