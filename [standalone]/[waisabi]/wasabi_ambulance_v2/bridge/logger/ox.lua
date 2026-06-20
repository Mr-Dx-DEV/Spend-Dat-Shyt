local config = Modules.require('config')

if not config.logger or not config.logger.enabled or config.logger.type ~= 'ox' then return end

local logger = {}

function logger.init() end

function logger.log(source, event, message, ...)
    lib.logger(source, event, message, ...)
end

function logger.logEvent(source, eventType, data)
    local message = json.encode(data or {})
    lib.logger(source, 'wasabi_ambulance:' .. eventType, message, 'ambulance', eventType)
end

function logger.logDeath(source, deathData)
    logger.logEvent(source, 'death', deathData)
end

function logger.logRevive(source, reviveData)
    logger.logEvent(source, 'revive', reviveData)
end

function logger.logRespawn(source, respawnData)
    logger.logEvent(source, 'respawn', respawnData)
end

function logger.logTreatment(source, targetSource, treatmentData)
    local data = treatmentData or {}
    data.medic = source
    data.patient = targetSource
    logger.logEvent(source, 'treatment', data)
end

function logger.logDuty(source, onDuty)
    logger.logEvent(source, 'duty', { onDuty = onDuty })
end

function logger.logAction(source, action, data)
    logger.logEvent(source, action, data)
end

Modules.register('logger', logger, {
    dependencies = { 'config' }
})
