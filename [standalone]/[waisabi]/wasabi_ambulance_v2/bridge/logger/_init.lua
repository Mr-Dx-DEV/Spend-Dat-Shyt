local config = Modules.require('config')

local noop = function() end

---@type WasabiAmbulanceLoggerModule
local logger = {
    init = noop,
    log = noop,
    logEvent = noop,
    logDeath = noop,
    logRevive = noop,
    logRespawn = noop,
    logTreatment = noop,
    logDuty = noop,
    logAction = noop,
}

if not config.logger or not config.logger.enabled then
    Modules.register('logger', logger)
    return
end

local loggerType = config.logger.type

if loggerType == 'discord' or loggerType == 'ox' then
    -- The specific logger module (discord.lua or ox.lua) will register itself
    return
end

lib.print.warn(('[Logger] Unknown logger type: %s, falling back to noop stubs'):format(tostring(loggerType)))
Modules.register('logger', logger)
