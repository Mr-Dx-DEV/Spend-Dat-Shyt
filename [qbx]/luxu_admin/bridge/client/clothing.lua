local clothing = {}

function clothing.loadPlayerSkin()
    if GetResourceState("rcore_clothing") == "started" or GetResourceState("qs-appearance") == "started" or GetResourceState("ak47_clothing") == "started" or GetResourceState("ak47_qb_clothing") == "started" then
        ExecuteCommand("reloadskin")
    elseif GetResourceState("illenium-appearance") == "started" then
        local result = lib.callback.await("illenium-appearance:server:getAppearance")
        exports["illenium-appearance"]:setPlayerAppearance(result)
    elseif GetResourceState("qb-clothing") == "started" then
        TriggerServerEvent("qb-clothes:loadPlayerSkin")
    elseif GetResourceState("skinchanger") == "started" and GetResourceState("esx_skin") == "started" then
        Framework.object.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
            TriggerEvent('skinchanger:loadSkin', skin)
        end)
    else
        ExecuteCommand("reloadskin")
    end
end

return clothing
