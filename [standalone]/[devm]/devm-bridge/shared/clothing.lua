Clothing = nil
if GetResourceState('qb-clothing') == 'started' then
    Clothing = 'native'
elseif GetResourceState('illenium-appearance') == 'started' then
    Clothing = 'illenium'
elseif GetResourceState('skinchanger') == 'started' then
    Clothing = 'skinchanger'
end

