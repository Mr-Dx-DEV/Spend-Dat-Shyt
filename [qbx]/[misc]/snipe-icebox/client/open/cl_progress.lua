

function DoProgress(cb, label, time , dict, anim)
    if Config.Progress == "ox" then
        if lib.progressCircle({
            label = label,
            duration = time,
            position = 'bottom',
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
            },
            anim = {
                dict = dict,
                clip = anim,
            }
        }) then 
            cb(true)
        else 
            cb(false)
        end
    elseif Config.Progress == "qb" then
        QBCore.Functions.Progressbar("icebox", label, time, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict =  dict,
            anim = anim,
            flags = 49,
        }, {}, {}, function() -- Done
            cb(true)
        end, function()
            cb(false)
        end)
    end
end