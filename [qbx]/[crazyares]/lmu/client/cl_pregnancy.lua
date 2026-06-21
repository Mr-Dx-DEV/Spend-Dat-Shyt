-- CLIENT PREGNANCY  -  birth notification + vitamin reminder
-- Server controls all notification timing/dedup.
-- Client just shows the notification once per event received.

-- Birth ready: fired by server (max once per 10 min, server-side deduped)
RegisterNetEvent('grim_lovemenu:cl:birthReady', function()
    Bridge.Notify(Config.Strings.BirthAlert, 'success')
    PlaySoundFrontend(-1, 'APPOINTMENT_REMINDER', 'DLC_HEIST_PLANNING_BOARD_AMBIENT', true)
    -- Also push toast into tablet NUI if it is open
    SendNUIMessage({ action = 'toast', message = Config.Strings.BirthAlert, ntype = 'success' })
end)

-- Kept for compatibility - no-op now since server controls reminder timing
RegisterNetEvent('grim_lovemenu:cl:birthReminderStop', function() end)

-- Vitamin reminder: server fires every VitaminReminderHours if pregnant + vitamins worn off
RegisterNetEvent('grim_lovemenu:cl:vitaminReminder', function()
    Bridge.Notify('- Time for your prenatal vitamins! Open the Pregnancy tab.', 'primary')
    PlaySoundFrontend(-1, 'APPOINTMENT_REMINDER', 'DLC_HEIST_PLANNING_BOARD_AMBIENT', true)
    SendNUIMessage({ action = 'vitaminReminder' })
end)
