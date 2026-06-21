function GetCurrentJob()
    return exports["SDC_Core"]:GetCurrentJob()
end

function GiveKeysToVehicle(veh)
    exports["SDC_Core"]:GiveKeysToVehicle(veh)
end

function RemoveKeysFromVehicle(veh)
    exports["SDC_Core"]:RemoveKeysFromVehicle(veh)
end

function AddTargetToManager(ped, eventtotrigger)
    if SDC.Target == "qb-target" then
        exports['qb-target']:AddTargetEntity(ped, { 
            options = {  
                  {  
                    type = "client",  
                    event = eventtotrigger,   
                    icon = 'fas fa-comments',   
                    label = SDC.Lang.Manager,  
                  }
            },
            distance = 1.5, 
          })
    elseif  SDC.Target == "ox_target" then
        exports.ox_target:addLocalEntity(ped, {
            {  
                label = SDC.Lang.Manager, 
                icon = 'fa-comments', 
                distance = 1.5,
                event = eventtotrigger, 
            }
        })
    end
end

function AddTargetToScrapBuyer(ped, eventtotrigger)
    if SDC.Target == "qb-target" then
        exports['qb-target']:AddTargetEntity(ped, { 
            options = {  
                  {  
                    type = "client",  
                    event = eventtotrigger,   
                    icon = 'fas fa-comments',   
                    label = SDC.Lang.ScrapBuyer2,  
                  }
            },
            distance = 1.5, 
          })
    elseif  SDC.Target == "ox_target" then
        exports.ox_target:addLocalEntity(ped, {
            {  
                label = SDC.Lang.ScrapBuyer2, 
                icon = 'fa-comments', 
                distance = 1.5,
                event = eventtotrigger, 
            }
        })
    end
end

function DoProgressbar(time, label)
    return exports["SDC_Core"]:ProgressBar(time, label)
end


RegisterNetEvent("SDCCJ:Client:Notification")
AddEventHandler("SDCCJ:Client:Notification", function(msg, extra)
    exports["SDC_Core"]:ShowNotification(msg, extra)
end)