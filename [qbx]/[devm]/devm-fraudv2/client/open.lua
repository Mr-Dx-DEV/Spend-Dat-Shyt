function Notify(title, description, type, time)
    lib.notify({
        title = title,
        description = description,
        type = type,
        duration = time
    })
end

RegisterNUICallback('devm-fraud:notify', function(data, cb)
    Notify(data.title or Locales['default_title'], data.description, data.type, data.time)
    cb(true)
end)
RegisterNetEvent('devm-fraud:dispatchPolice')
AddEventHandler('devm-fraud:dispatchPolice', function()
    print("^3[devm-fraud] ^7Dispatch event received. Dispatch type: " .. tostring(Config.Dispatch))
    
    if Config.Dispatch == 'cd' then
        print("^5[devm-fraud] ^7Using CD Dispatch")
        local data = exports['cd_dispatch']:GetPlayerInfo()
        TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table = {'police', }, 
            coords = data.coords,
            title = 'Credit Card Fraud',
            message = 'A '..data.sex..' using a blank card at '..data.street, 
            flash = 0,
            unique_id = data.unique_id,
            sound = 1,
            blip = {
                sprite = 431, 
                scale = 0.5,
                colour = 3,
                flashes = false, 
                text = 'Credit Card Fraud',
                time = 5,
                radius = 0,
            }
        })
    elseif Config.Dispatch == 'rcore' then
        print("^5[devm-fraud] ^7Using RCORE Dispatch")
        local data = exports['rcore_dispatch']:GetPlayerData()
        TriggerServerEvent('rcore_dispatch:server:sendAlert', {
            code = '10-46',
            default_priority = 'medium', 
            coords = data.coords, 
            job = 'police', 
            text = 'A ' .. data.sex .. ' using a blank card at ' ..data.street,
            type = 'alerts', 
            blip_time = 5,
            blip = {
                sprite = 431, 
                colour = 3, 
                scale = 0.5,
                text = 'Credit Card Fraud', 
                flashes = false, 
                radius = 0, 
            }
        })
    elseif Config.Dispatch == 'ps' then
        print("^5[devm-fraud] ^7Using PS-Dispatch")
        exports["ps-dispatch"]:CustomAlert({
            coords = vector3(GetEntityCoords(PlayerPedId())),
            message = "Criminal Activity",
            dispatchCode = "10-46 - Bank Fraud",
            description = "Credit Card Fraud",
            radius = 0,
            sprite = 431,
            color = 3,
            scale = 0.5,
            length = 3,
        })
        
    elseif Config.Dispatch == 'custom' then
        print("^5[devm-fraud] ^7Using Custom Dispatch - No implementation set")
        -- Enter Police Dispatch Logic Here
    elseif Config.Dispatch == 'none' then 
        print("^3[devm-fraud] ^7Dispatch disabled in config")
    else
        print("^1[devm-fraud] ^7Unknown dispatch type: " .. tostring(Config.Dispatch))
    end
end)

RegisterNetEvent('devm-fraud:notify')
AddEventHandler('devm-fraud:notify', function(title, desc, type, time)
    Notify(title, desc, type, time)
end)
