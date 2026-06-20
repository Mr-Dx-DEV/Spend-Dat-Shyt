-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
if not Config.Language then Config.Language = 'en' end
if Config.Language ~= 'de' then return end

Strings = {

    no_wsb = '^0[^3WARNUNG^0] wasabi_bridge wurde NICHT nach dem Framework und/oder vor der Ressource gestartet: %s',
    warning_disabling_metadata = '[^3WARNUNG^0] Kein Inventarsystem gefunden, deaktiviere Metadaten-Schlüssel.',

    manage_keys = 'Schlüssel Verwalten',
    manage_key = 'Schlüssel Verwalten - %s',
    give_key = 'Schlüssel Geben',
    remove_key = 'Schlüssel Entfernen',
    are_you_sure = 'Bist du sicher?',
    are_you_sure_desc = 'Bist du sicher, dass du die Schlüssel für das Nummernschild %s entfernen möchtest?',

    -- Menu
    player_id = 'Spieler ID: ',

    -- Notification
    too_far = 'Zu Weit Entfernt',
    too_far_desc = 'Du bist zu weit entfernt, um dies zu tun!',

    no_vehicle_found = 'Kein Fahrzeug Gefunden',
    no_vehicle_found_desc = 'Es gibt keine Fahrzeuge in der Nähe, für die du Schlüssel hast!',
    no_vehicle_found_keys_desc = 'Es gibt kein Fahrzeug in der Nähe, für das du Schlüssel hast!',
    no_vehicle_found_lockpick_desc = 'Kein Fahrzeug in der Nähe zum Aufbrechen!',

    no_keys_found = 'Keine Schlüssel Gefunden',
    no_keys_found_desc = 'Du hast keine Schlüssel für Fahrzeuge!',

    vehicle_not_locked = 'Fahrzeug Entsperrt',
    vehicle_not_locked_desc = 'Dieses Fahrzeug scheint nicht abgeschlossen zu sein',

    vehicle_cant_lockpick = 'Kann Nicht Aufgebrochen Werden',
    vehicle_cant_lockpick_desc = 'Du kannst dieses Fahrzeug nicht aufbrechen!',

    success = 'Erfolg',
    failed = 'Fehlgeschlagen',
    success_lockpick_desc = 'Du hast das Fahrzeug erfolgreich aufgebrochen',
    fail_lockpick_desc = 'Du bist gescheitert, das Fahrzeug aufzubrechen',
    lockpick_broke = 'Aufhebelwerkzeug Gebrochen',
    lockpick_broke_desc = 'Du hast das Aufhebelwerkzeug gebrochen',

    cancelled_action = 'Aktion Abgebrochen',
    cancelled_action_desc = 'Deine Aktion wurde abgebrochen!',

    search_nothing_found = 'Nichts Gefunden',
    search_nothing_found_desc = 'Du hast nichts Nützliches gefunden',
    search_keys_found = 'Schlüssel Gefunden',
    search_keys_found_desc = 'Du hast die Schlüssel für das Fahrzeug gefunden',
    search_item_found = 'Etwas Gefunden',
    search_item_found_desc = 'Du hast %sx %s gefunden!',
    search_money_found = 'Geld Gefunden',
    search_money_found_desc = 'Du hast $%s gefunden',

    handed_keys = 'Schlüssel Übergeben',
    handed_keys_desc = 'Dir wurden die Schlüssel zum Fahrzeug übergeben!',
    keys_received = 'Schlüssel Empfangen',
    keys_received_desc = 'Du hast die Schlüssel für das Nummernschild: %s erhalten',
    keys_removed = 'Schlüssel Entfernt',
    keys_removed_desc = 'Die Schlüssel für das Nummernschild: %s wurden entfernt',

    vehicle_unlocked = 'Entsperrt',
    vehicle_unlocked_desc = 'Du hast dein Fahrzeug entsperrt',

    vehicle_locked = 'Abgeschlossen',
    vehicle_locked_desc = 'Du hast dein Fahrzeug abgeschlossen',

    already_in_vehicle = 'Im Fahrzeug',
    already_in_vehicle_desc = 'Du bist bereits in einem Fahrzeug',

    no_one_nearby = 'Niemand in der Nähe',
    no_one_nearby_desc = 'Niemand ist in der Nähe, dem du Schlüssel geben kannst',

    notify_police_notified = 'Polizei Benachrichtigt',
    notify_police_notified_desc = 'Die Polizei wurde über deine Aktionen benachrichtigt.',

    notify_police_notification = 'Disponent',
    notify_police_notification_desc = 'Ein Bürger hat ein %s in der Nähe gemeldet, überprüfe die Karte.',

    vehicle_stopped = 'Motor Gestoppt',
    vehicle_stopped_desc = 'Du hast den Motor ausgeschaltet.',

    vehicle_started = 'Motor Gestartet',
    vehicle_started_desc = 'Du hast den Motor gestartet.',

    -- Keymapping
    toggle_keymap_desc = 'Kfz-Schloss umschalten',

    -- Blip strings
    blip_hotwire = 'Gestohlenes Fahrzeug',
    blip_lockpick = 'Aufgebrochenes Fahrzeug',
    blip_robPed = 'Bewaffneter Raub',

    -- Crimes
    crime_hotwire = 'Fahrzeugdiebstahl',
    crime_lockpick = 'Autoprovieren',
    crime_robPed = 'Bewaffneter Raub',

    -- Metadata
    vehicle_plate = 'Fahrzeug Kennzeichen',
}
