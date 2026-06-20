Config = {}

Config.Debug = true

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
    AGGRESSIVE_ANIMAL = 'aggressive_animal',
    STRAY_CAPTURE     = 'stray_capture',
    WILDLIFE_REMOVAL  = 'wildlife_removal',
    DECEASED_PICKUP   = 'deceased_pickup',
}

-- Job type labels for display
JobTypeLabels = {
    [JobType.AGGRESSIVE_ANIMAL] = 'job_type.aggressive_animal',
    [JobType.STRAY_CAPTURE]     = 'job_type.stray_capture',
    [JobType.WILDLIFE_REMOVAL]  = 'job_type.wildlife_removal',
    [JobType.DECEASED_PICKUP]   = 'job_type.deceased_pickup',
}
