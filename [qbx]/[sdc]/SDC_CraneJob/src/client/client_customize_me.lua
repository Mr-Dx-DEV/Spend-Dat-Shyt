
function GetCurrentJob()
    return exports["SDC_Core"]:GetCurrentJob()
end

function AddTargetToSiteManagerPed(ped, eventtotrigger)
    if SDC.Target == "qb-target" then
        exports['qb-target']:AddTargetEntity(ped, { 
            options = {  
                  {  
                    type = "client",  
                    event = eventtotrigger,   
                    icon = 'fas fa-truck',   
                    label = SDC.Lang.SiteMangerLabel,  
                  }
            },
            distance = 1.5, 
          })
    elseif  SDC.Target == "ox_target" then
        exports.ox_target:addLocalEntity(ped, {
            {  
                label = SDC.Lang.SiteMangerLabel, 
                icon = 'fa-truck', 
                distance = 1.5,
                event = eventtotrigger, 
            }
        })
    end
end


local OxTargetTable = {}
function AddTargetToCrane(coords, eventtotrigger, ID, lang, iconn)
    if SDC.Target == "qb-target" then
        exports['qb-target']:AddBoxZone("sdcj:crane:"..ID, vector3(coords.x, coords.y, coords.z), 1.5, 1.5, {  
            name = "sdcj:crane:"..ID,  
            heading = 0.0, 
            debugPoly = false,  
            minZ = coords.z - 1, 
            maxZ = coords.z + 1,  
        }, {
            options = { 
                {  
                    num = 1,
                    label = lang, 
                    type = "client",  
                    event = eventtotrigger, 
                    icon = "fas fa-"..iconn,
                }
            },
            distance = 1.5, 
        })
    elseif SDC.Target == "ox_target" then
        local zoneID = nil
        zoneID = exports.ox_target:addBoxZone({
            coords = coords,
            debug = false,
            size = vec3(1, 1, 1),
            options = {  
                label = lang, 
                icon = iconn, 
                distance = 1.5,
                event = eventtotrigger, 
            }
        })
        OxTargetTable[ID] = zoneID
    end
end
function RemoveTargetFromCrane(ID)
    if SDC.Target == "qb-target" then
        exports['qb-target']:RemoveZone("sdcj:crane:"..ID)
    elseif SDC.Target == "ox_target" then
        if OxTargetTable[ID] then
            exports.ox_target:removeZone(OxTargetTable[ID])
            OxTargetTable[ID] = nil
        end
    end
end


function DoProgressbar(time, label)
    return exports["SDC_Core"]:ProgressBar(time, label)
end


RegisterNetEvent("SDCJ:Client:Notification")
AddEventHandler("SDCJ:Client:Notification", function(msg, extra)
    exports["SDC_Core"]:ShowNotification(msg, extra)
end)