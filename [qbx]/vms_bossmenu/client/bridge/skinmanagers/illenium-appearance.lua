if Config.SkinManager ~= 'illenium-appearance' then
    return
end

local import = LoadResourceFile('ox_lib', 'init.lua')
local chunk = assert(load(import, '@@ox_lib/init.lua'))
chunk()

function LoadDefaultClothing()
    lib.callback("illenium-appearance:server:getAppearance", false, function(appearance)
        if not appearance then
            return
        end

        exports['illenium-appearance']:setPlayerAppearance(appearance)
        
        if GetResourceState('vms_tattooshop') == 'started' then
            Citizen.Wait(500)
            exports['vms_tattooshop']:reloadPlayerTattoos()
        end
    end)
end