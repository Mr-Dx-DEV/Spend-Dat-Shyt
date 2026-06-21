return {
    debug = false,

    isPlayerInPrion = function(source)
        if GetResourceState('rcore_prison') == 'started' then
            return exports.rcore_prison:IsPrisoner(source)
        elseif GetResourceState('DHS-PrisonSim') == 'started' then
            local remainingTime = exports['DHS-PrisonSim']:GetRemainingPrisonTime(source)
            return remainingTime ~= nil and remainingTime > 0

        elseif GetResourceState('dynyx_prison') == 'started' then 
            return exports.dynyx_prison:IsActivePrisoner(source)
        end

        return true
    end
}