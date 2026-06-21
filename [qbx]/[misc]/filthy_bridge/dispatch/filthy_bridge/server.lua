
RegisterNetEvent('filthy_bridge:dispatch:notifyPolice')
AddEventHandler('filthy_bridge:dispatch:notifyPolice', function(coords, jobs, data)
    local src = source
    jobs = jobs or {}

    local jobSet = {}
    for _, j in ipairs(jobs) do jobSet[j] = true end

    for _, playerId in ipairs(GetPlayers()) do
        local pid = tonumber(playerId)
        local job = flb and flb.getJobData(pid)
        if job and jobSet[job.name] then
            flb.client.Notify(pid,
                (data.code or '') .. ' - ' .. (data.message or 'Alert'),
                'error',
                10000,
                data.title or 'Dispatch'
            )
            TriggerClientEvent('filthy_bridge:dispatch:policeBlip', pid, coords, data)
        end
    end
end)

RegisterNetEvent('filthy_bridge:dispatch:policeBlip')
AddEventHandler('filthy_bridge:dispatch:policeBlip', function(coords, data)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, data.blipSprite or 431)
    SetBlipColour(blip, data.blipColor or 1)
    SetBlipScale(blip, data.blipScale or 1.0)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(data.blipText or 'Dispatch Alert')
    EndTextCommandSetBlipName(blip)
    Citizen.SetTimeout(5000, function()
        RemoveBlip(blip)
    end)
end)
