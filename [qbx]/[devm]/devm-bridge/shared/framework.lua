Framework = nil

if GetResourceState(Config.Framework.esxName) == 'started' then
    Framework = 'es_extended'
elseif GetResourceState(Config.Framework.qbxName) == 'started' then
    Framework = 'qbx_core'
elseif GetResourceState(Config.Framework.qbName) == 'started' and Framework == nil then
    Framework = 'qb-core'
end
