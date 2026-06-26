if Config.SkinManager ~= 'esx_skin' then
    return
end

function LoadDefaultClothing()
    library.Callback('esx_skin:getPlayerSkin', function(skin)
        TriggerEvent('skinchanger:loadSkin', skin)
    end)
end
