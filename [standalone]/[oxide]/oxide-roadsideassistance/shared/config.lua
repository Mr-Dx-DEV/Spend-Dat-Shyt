Config = {}

Config.Debug = false

Config.usePhone = false  -- Send SMS via phone instead of toast notifications

Config.shiftSummary = 'text' -- 'nui' for popup summary, 'text' for SMS summary
Config.menuStyle = 'nui' -- 'nui' for Vue shift menu, 'menu' for olink.menu context menu

Config.MaxSlotsPerLocation = 3

-- Shift states (defined here so config/*.lua can reference them)
ShiftState = {
    IDLE    = 'idle',
    WAITING = 'waiting',
    ON_CALL = 'on_call',
    WORKING = 'working',
}

-- Job types (defined here so config/*.lua can reference them)
JobType = {
    FUEL_HELP      = 'fuel_help',
    CHANGE_WHEEL   = 'change_wheel',
    TOWING         = 'towing',
    BATTERY_CHANGE = 'battery_change',
}

-- Job type labels for display
JobTypeLabels = {
    [JobType.FUEL_HELP]      = 'job_type.refuelling',
    [JobType.CHANGE_WHEEL]   = 'job_type.wheel_change',
    [JobType.TOWING]         = 'job_type.towing',
    [JobType.BATTERY_CHANGE] = 'job_type.battery_change',
}
