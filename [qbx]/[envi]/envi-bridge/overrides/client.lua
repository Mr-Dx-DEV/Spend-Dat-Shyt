module 'shared/resource'

-- Wasabi Ambulance
local wasabi_ambulance_v1 = not resource.missing("wasabi_ambulance")
local wasabi_ambulance_v2 = not resource.missing("wasabi_ambulance_v2")

if wasabi_ambulance_v2 or wasabi_ambulance_v1 then
    local wasabi_ambulance = wasabi_ambulance_v2 and "wasabi_ambulance_v2" or "wasabi_ambulance"
    Bridge.Debug('Overrides', 'Wasabi Ambulance', resource.version(wasabi_ambulance))
    
    Framework.Override("IsPlayerDead", function()
        return exports[wasabi_ambulance]:isPlayerDead()
    end)
end