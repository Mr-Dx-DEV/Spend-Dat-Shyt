if Config.SkinManager ~= 'qb-clothing' then
    return
end

function LoadDefaultClothing()
    TriggerServerEvent('qb-clothes:loadPlayerSkin')
end
