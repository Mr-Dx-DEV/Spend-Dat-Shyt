-- filthy_bridge built-in dispatch fallback client
-- Only activate if no external dispatch system is available
if GetResourceState('ps-dispatch') == 'started' then return end
if GetResourceState('cd_dispatch') == 'started' then return end
if GetResourceState('qs-dispatch') == 'started' then return end
if GetResourceState('rcore_dispatch') == 'started' then return end
if GetResourceState('core_dispatch') == 'started' then return end
if GetResourceState('aty_dispatch') == 'started' then return end
if GetResourceState('linden_outlawalert') == 'started' then return end

function FLBridge.dispatch.getStreet(coords)
    if not coords then return 'Unknown' end
    local street, _ = GetStreetNameAtCoord(coords.x, coords.y, coords.z, 0, 0)
    return GetStreetNameFromHashKey(street) or 'Unknown'
end

function FLBridge.dispatch.Alert(coords, jobs, data)
    if not coords or not data then return end
    jobs = jobs or {}
    TriggerServerEvent('filthy_bridge:dispatch:notifyPolice', coords, jobs, data)
end
