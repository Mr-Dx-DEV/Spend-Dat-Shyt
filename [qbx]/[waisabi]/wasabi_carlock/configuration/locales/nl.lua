-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
if not Config.Language then Config.Language = 'en' end
if Config.Language ~= 'nl' then return end

Strings = {

    no_wsb = '^0[^3WAARSCHUWING^0] wasabi_bridge werd NIET gestart NA het framework en/of VOOR de bron: %s',
    warning_disabling_metadata = '[^3WAARSCHUWING^0] Geen inventarissysteem gevonden, metadata sleutels uitgeschakeld.',

    manage_keys = 'Beheer Sleutels',
    manage_key = 'Beheer Sleutel - %s',
    give_key = 'Geef Sleutel',
    remove_key = 'Verwijder Sleutel',
    are_you_sure = 'Weet je het zeker?',
    are_you_sure_desc = 'Weet je zeker dat je de sleutels voor nummerplaat %s wilt verwijderen?',

    -- Menu
    player_id = 'Speler ID: ',

    -- Notification
    too_far = 'Te Ver Weg',
    too_far_desc = 'Je bent te ver weg om dit te doen!',

    no_vehicle_found = 'Geen Voertuig Gevonden',
    no_vehicle_found_desc = 'Er zijn geen voertuigen in de buurt waarvoor je sleutels hebt!',
    no_vehicle_found_keys_desc = 'Er zijn geen voertuigen in de buurt waarvoor je sleutels hebt!',
    no_vehicle_found_lockpick_desc = 'Er zijn geen voertuigen in de buurt om open te breken!',

    no_keys_found = 'Geen Sleutels Gevonden',
    no_keys_found_desc = 'Je hebt geen sleutels voor voertuigen!',

    vehicle_not_locked = 'Voertuig Ontgrendeld',
    vehicle_not_locked_desc = 'Dit voertuig lijkt niet vergrendeld te zijn',

    vehicle_cant_lockpick = 'Kan Niet Openbreken',
    vehicle_cant_lockpick_desc = 'Je kunt dit voertuig niet openbreken!',

    success = 'Succes',
    failed = 'Mislukt',
    success_lockpick_desc = 'Je hebt het voertuig succesvol opengebroken',
    fail_lockpick_desc = 'Je bent niet in staat het voertuig open te breken',
    lockpick_broke = 'Lockpick Gebroken',
    lockpick_broke_desc = 'Je hebt de lockpick gebroken',

    cancelled_action = 'Actie Geannuleerd',
    cancelled_action_desc = 'Je actie is geannuleerd!',

    search_nothing_found = 'Niets Gevonden',
    search_nothing_found_desc = 'Je hebt niets nuttigs gevonden',
    search_keys_found = 'Sleutels Gevonden',
    search_keys_found_desc = 'Je hebt de sleutels van het voertuig gevonden',
    search_item_found = 'Iets Gevonden',
    search_item_found_desc = 'Je hebt %sx %s gevonden!',
    search_money_found = 'Geld Gevonden',
    search_money_found_desc = 'Je hebt $%s gevonden',

    handed_keys = 'Sleutels Overhandigd',
    handed_keys_desc = 'Je hebt de sleutels van het voertuig ontvangen!',
    keys_received = 'Sleutels Ontvangen',
    keys_received_desc = 'Je hebt de sleutels ontvangen voor nummerplaat: %s',
    keys_removed = 'Sleutels Verwijderd',
    keys_removed_desc = 'Sleutels voor nummerplaat: %s zijn verwijderd',

    vehicle_unlocked = 'Ontgrendeld',
    vehicle_unlocked_desc = 'Je hebt je voertuig ontgrendeld',

    vehicle_locked = 'Vergrendeld',
    vehicle_locked_desc = 'Je hebt je voertuig vergrendeld',

    already_in_vehicle = 'In Voertuig',
    already_in_vehicle_desc = 'Je zit al in een voertuig',

    no_one_nearby = 'Niemand In De Buurt',
    no_one_nearby_desc = 'Er is niemand in de buurt om sleutels aan te geven',

    notify_police_notified = 'Politie Geïnformeerd',
    notify_police_notified_desc = 'De politie is geïnformeerd over je acties.',

    notify_police_notification = 'Dispatched',
    notify_police_notification_desc = 'Een burger heeft een %s gemeld in de buurt, controleer de kaart.',

    vehicle_stopped = 'Motor Gestopt',
    vehicle_stopped_desc = 'Je hebt de motor uitgezet.',

    vehicle_started = 'Motor Gestart',
    vehicle_started_desc = 'Je hebt de motor gestart.',

    -- Keymapping
    toggle_keymap_desc = 'Auto Lock Wisselen',

    -- Blip strings
    blip_hotwire = 'Gestolen Voertuig',
    blip_lockpick = 'Opengebroken Voertuig',
    blip_robPed = 'Gewapende Diefstal',

    -- Crimes
    crime_hotwire = 'Voertuig Diefstal',
    crime_lockpick = 'Auto Inbraak',
    crime_robPed = 'Gewapende Diefstal',

    -- Metadata
    vehicle_plate = 'Voertuig Nummerplaat',
}
