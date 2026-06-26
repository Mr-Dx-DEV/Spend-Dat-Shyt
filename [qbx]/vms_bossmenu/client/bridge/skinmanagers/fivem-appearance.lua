if Config.SkinManager ~= 'fivem-appearance' then
    return
end

function LoadDefaultClothing()
    library.Callback("fivem-appearance:server:getAppearance", function(appearance)
        if not appearance then
            return
        end
    
        exports['fivem-appearance']:setPlayerAppearance(appearance)

        if GetResourceState('vms_tattooshop') == 'started' then
            Citizen.Wait(500)
            exports['vms_tattooshop']:reloadPlayerTattoos()
        end
    end)
end
