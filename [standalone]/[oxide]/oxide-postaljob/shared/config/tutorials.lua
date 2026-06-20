-- Positions: top-right, top-left, bottom-right, bottom-left, center-top, center, center-bottom
-- Overlap map:
--   top-center: timer overlay + progress bar (during deliveries)
--   top-right: default tutorial position (clear in all states)

Config.Tutorials = {
    first_clockin = {
        icon = 'fa-solid fa-circle-play',
        title = 'tutorial.first_clockin.title',
        body = 'tutorial.first_clockin.body',
    },
    first_loading = {
        icon = 'fa-solid fa-boxes-stacked',
        title = 'tutorial.first_loading.title',
        body = 'tutorial.first_loading.body',
    },
    first_delivery_start = {
        icon = 'fa-solid fa-route',
        title = 'tutorial.first_delivery_start.title',
        body = 'tutorial.first_delivery_start.body',
    },
    first_delivery_complete = {
        icon = 'fa-solid fa-circle-check',
        title = 'tutorial.first_delivery_complete.title',
        body = 'tutorial.first_delivery_complete.body',
    },
    first_timer_expired = {
        icon = 'fa-solid fa-clock',
        title = 'tutorial.first_timer_expired.title',
        body = 'tutorial.first_timer_expired.body',
    },
    first_vehicle_damage = {
        icon = 'fa-solid fa-car-burst',
        title = 'tutorial.first_vehicle_damage.title',
        body = 'tutorial.first_vehicle_damage.body',
        position = 'center-top',
        duration = 12,
    },
    first_level_up = {
        icon = 'fa-solid fa-arrow-up',
        title = 'tutorial.first_level_up.title',
        body = 'tutorial.first_level_up.body',
    },
    first_batch_complete = {
        icon = 'fa-solid fa-clipboard-check',
        title = 'tutorial.first_batch_complete.title',
        body = 'tutorial.first_batch_complete.body',
    },
    first_crew = {
        icon = 'fa-solid fa-users',
        title = 'tutorial.first_crew.title',
        body = 'tutorial.first_crew.body',
    },
}
