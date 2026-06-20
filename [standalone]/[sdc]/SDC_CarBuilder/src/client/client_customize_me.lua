function GetCurrentJob()
    return exports["SDC_Core"]:GetCurrentJob()
end

function GiveKeysToVehicle(veh)
    exports["SDC_Core"]:GiveKeysToVehicle(veh)
end

function SetVehicleProperties(veh, props)
    exports["SDC_Core"]:SetVehicleProperties(veh, props)
end

function GetVehicleProperties(veh)
    return exports["SDC_Core"]:GetVehicleProperties(veh)
end

function DoProgressbar(time, label)
    return exports["SDC_Core"]:ProgressBar(time, label)
end



function AddTargetToPBPed(ped, eventtotrigger)
    if SDC.Target == "qb-target" then
        exports['qb-target']:AddTargetEntity(ped, { 
            options = {  
                  {  
                    type = "client",  
                    event = eventtotrigger,   
                    icon = 'fas fa-store',   
                    label = SDC.Lang.PBPed
                  }
            },
            distance = 2.5, 
          })
    elseif  SDC.Target == "ox_target" then
        exports.ox_target:addLocalEntity(ped, {
            {  
                label = SDC.Lang.PBPed, 
                icon = 'fa-store', 
                distance = 2.5,
                event = eventtotrigger
            }
        })
    end
end

function AddTargetToTSPed(ped, eventtotrigger)
    if SDC.Target == "qb-target" then
        exports['qb-target']:AddTargetEntity(ped, { 
            options = {  
                  {  
                    type = "client",  
                    event = eventtotrigger,   
                    icon = 'fas fa-truck',   
                    label = SDC.Lang.TSPed
                  }
            },
            distance = 1.5, 
          })
    elseif  SDC.Target == "ox_target" then
        exports.ox_target:addLocalEntity(ped, {
            {  
                label = SDC.Lang.TSPed, 
                icon = 'fa-truck', 
                distance = 1.5,
                event = eventtotrigger
            }
        })
    end
end

function AddTargetToStorePed(ped, eventtotrigger, store, labels)
    if SDC.Target == "qb-target" then
        exports['qb-target']:AddTargetEntity(ped, { 
            options = {  
                  {  
                    type = "client",  
                    event = eventtotrigger,   
                    icon = 'fas fa-shop',   
                    label = labels,
                    storeid = store
                  }
            },
            distance = 1.5, 
          })
    elseif  SDC.Target == "ox_target" then
        exports.ox_target:addLocalEntity(ped, {
            {  
                label = labels, 
                icon = 'fa-shop', 
                distance = 1.5,
                event = eventtotrigger,
                storeid = store
            }
        })
    end
end


RegisterNetEvent("SDCB:Client:Notification")
AddEventHandler("SDCB:Client:Notification", function(msg, extra)
    exports["SDC_Core"]:ShowNotification(msg, extra)
end)