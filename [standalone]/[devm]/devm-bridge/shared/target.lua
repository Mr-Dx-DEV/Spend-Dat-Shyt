Target = nil

if GetResourceState('ox_target') == 'started' then
    Target = 'ox_target'
elseif GetResourceState('qb-target') == 'started' then
    Target = 'qb-target'
end

