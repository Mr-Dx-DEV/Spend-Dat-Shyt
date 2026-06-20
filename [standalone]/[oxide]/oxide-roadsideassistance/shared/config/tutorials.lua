-- Positions: top-right, top-left, bottom-right, bottom-left, center-top, center, center-bottom
-- Center positions render wider (40vh vs 30vh) since they have more horizontal space.
--
-- Overlap map (what occupies each zone during gameplay):
--   top-center:  timer overlay + hint text (during active jobs)
--   top-right:   CallNotification (during incoming calls)
--
-- Default position is top-right. Override only when something else occupies that zone.

Config.Tutorials = {
    -- Clock in — nothing else on screen
    first_clockin = {
        icon = 'fa-solid fa-circle-play',
        title = 'tutorial.first_clockin.title',
        body = 'tutorial.first_clockin.body',
    },

    -- Incoming call — CallNotification occupies top-right, so use bottom-right
    first_incoming_call = {
        icon = 'fa-solid fa-phone-flip',
        title = 'tutorial.first_incoming_call.title',
        body = 'tutorial.first_incoming_call.body',
        position = 'bottom-right',
    },

    -- Call declined — call notification already dismissed
    first_call_decline = {
        icon = 'fa-solid fa-phone-slash',
        title = 'tutorial.first_call_decline.title',
        body = 'tutorial.first_call_decline.body',
    },

    -- Job type tutorials — timer is at top-center, top-right is clear
    first_fuel_job = {
        icon = 'fa-solid fa-gas-pump',
        title = 'tutorial.first_fuel_job.title',
        body = 'tutorial.first_fuel_job.body',
        duration = 12,
    },
    first_wheel_job = {
        icon = 'fa-solid fa-circle-notch',
        title = 'tutorial.first_wheel_job.title',
        body = 'tutorial.first_wheel_job.body',
        duration = 12,
    },
    first_battery_job = {
        icon = 'fa-solid fa-car-battery',
        title = 'tutorial.first_battery_job.title',
        body = 'tutorial.first_battery_job.body',
        duration = 12,
    },
    first_towing_job = {
        icon = 'fa-solid fa-truck-pickup',
        title = 'tutorial.first_towing_job.title',
        body = 'tutorial.first_towing_job.body',
        duration = 12,
    },

    -- Cones — timer at top-center, hint at top-center, top-right is clear
    first_cone = {
        icon = 'fa-solid fa-triangle-exclamation',
        title = 'tutorial.first_cone.title',
        body = 'tutorial.first_cone.body',
    },

    -- Timer expired — timer shows LATE at top-center, top-right is clear
    first_timer_expired = {
        icon = 'fa-solid fa-clock',
        title = 'tutorial.first_timer_expired.title',
        body = 'tutorial.first_timer_expired.body',
    },

    -- Vehicle destroyed — prominent center warning
    first_vehicle_damage = {
        icon = 'fa-solid fa-car-burst',
        title = 'tutorial.first_vehicle_damage.title',
        body = 'tutorial.first_vehicle_damage.body',
        position = 'center-top',
        duration = 12,
    },

    -- Job complete — timer hidden, nothing on screen
    first_job_complete = {
        icon = 'fa-solid fa-circle-check',
        title = 'tutorial.first_job_complete.title',
        body = 'tutorial.first_job_complete.body',
    },

    -- Crew partner joined
    first_crew = {
        icon = 'fa-solid fa-users',
        title = 'tutorial.first_crew.title',
        body = 'tutorial.first_crew.body',
    },

    -- Level up — comes after job complete tooltip in queue
    first_level_up = {
        icon = 'fa-solid fa-arrow-up',
        title = 'tutorial.first_level_up.title',
        body = 'tutorial.first_level_up.body',
    },
}
