return {
    debug = false,

    isPlayerInPrion = function(source)
        if GetResourceState('rcore_prison') == 'started' then
            return exports.rcore_prison:IsPrisoner(source)
        elseif GetResourceState('DHS-PrisonSim') == 'started' then
            return exports['DHS-PrisonSim']:IsPrisoner(source)

        elseif GetResourceState('dynyx_prison') == 'started' then 
            return exports.dynyx_prison:IsActivePrisoner(source)
        end

        return true
    end
}