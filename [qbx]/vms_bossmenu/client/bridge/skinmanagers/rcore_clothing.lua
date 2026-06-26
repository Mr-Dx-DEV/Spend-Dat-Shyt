if Config.SkinManager ~= 'rcore_clothing' then
    return
end

function LoadDefaultClothing()
    TriggerServerEvent('rcore_clothing:reloadSkin')
end
