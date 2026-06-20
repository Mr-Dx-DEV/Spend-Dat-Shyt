module 'shared/resource'

-- Wasabi Ambulance
local wasabi_ambulance_v1 = not resource.missing("wasabi_ambulance")
local wasabi_ambulance_v2 = not resource.missing("wasabi_ambulance_v2")

if wasabi_ambulance_v2 or wasabi_ambulance_v1 then
    local wasabi_ambulance = wasabi_ambulance_v2 and "wasabi_ambulance_v2" or "wasabi_ambulance"
    Bridge.Debug('Overrides', 'Wasabi Ambulance', resource.version(wasabi_ambulance))
    
    Framework.Override("IsPlayerDead", function(source)
        if wasabi_ambulance_v2 then 
            local state = Player(source).state.isDead
            return state and state > 0 or false
        end
        if wasabi_ambulance_v1 then 
            return Player(source).state.dead and true or false 
        end
    end)
end