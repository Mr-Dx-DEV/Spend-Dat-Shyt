-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
if not Config.Language then Config.Language = 'en' end
if Config.Language ~= 'da' then return end

Strings = {

    no_wsb = '^0[^3ADVARSEL^0] wasabi_bridge blev IKKE startet EFTER framework og/eller FØR ressource: %s',
    warning_disabling_metadata = '[^3ADVARSEL^0] Ingen inventory system fundet, deaktiverer metadata nøgler.',

    manage_keys = 'Håndter Nøgler',
    manage_key = 'Håndter Nøgle - %s',
    give_key = 'Giv Nøgle',
    remove_key = 'Fjern Nøgle',
    are_you_sure = 'Er du sikker?',
    are_you_sure_desc = 'Er du sikker på, at du vil fjerne nøglerne for plade %s?',

    -- Menu
    player_id = 'Spiller ID: ',

    -- Notification
    too_far = 'For Langt Væk',
    too_far_desc = 'Du er for langt væk til at gøre dette!',

    no_vehicle_found = 'Ingen Køretøj Fundet',
    no_vehicle_found_desc = 'Der er ingen køretøjer i nærheden, som du har nøgler til!',
    no_vehicle_found_keys_desc = 'Der er ingen køretøjer i nærheden, som du har nøgler til!',
    no_vehicle_found_lockpick_desc = 'Der er ingen køretøjer i nærheden til at låse op!',

    no_keys_found = 'Ingen Nøgler Fundet',
    no_keys_found_desc = 'Du har ingen nøgler til køretøjer!',

    vehicle_not_locked = 'Køretøj Ulåst',
    vehicle_not_locked_desc = 'Dette køretøj virker ikke som om det er låst',

    vehicle_cant_lockpick = 'Kan Ikke Låse Op',
    vehicle_cant_lockpick_desc = 'Du kan ikke låse op for dette køretøj!',

    success = 'Succes',
    failed = 'Fejl',
    success_lockpick_desc = 'Du har med succes låst køretøjet op',
    fail_lockpick_desc = 'Du mislykkedes med at låse køretøjet op',
    lockpick_broke = 'Låseværktøj Brækket',
    lockpick_broke_desc = 'Du har brækket låseværktøjet',

    cancelled_action = 'Handling Afbrudt',
    cancelled_action_desc = 'Din handling blev afbrudt!',

    search_nothing_found = 'Intet Fundet',
    search_nothing_found_desc = 'Du fandt intet nyttigt',
    search_keys_found = 'Fundet Nøgler',
    search_keys_found_desc = 'Du fandt nøglerne til køretøjet',
    search_item_found = 'Fundet Genstand',
    search_item_found_desc = 'Du fandt %sx %s!',
    search_money_found = 'Penge Fundet',
    search_money_found_desc = 'Du fandt $%s',

    handed_keys = 'Nøgler Givet',
    handed_keys_desc = 'Du har fået nøglerne til køretøjet!',
    keys_received = 'Nøgler Modtaget',
    keys_received_desc = 'Du har modtaget nøgler for plade: %s',
    keys_removed = 'Nøgler Fjernet',
    keys_removed_desc = 'Nøglerne er blevet fjernet for plade: %s',

    vehicle_unlocked = 'Odlåst',
    vehicle_unlocked_desc = 'Du har oplåst dit køretøj',

    vehicle_locked = 'Låst',
    vehicle_locked_desc = 'Du har låst dit køretøj',

    already_in_vehicle = 'I Køretøj',
    already_in_vehicle_desc = 'Du er allerede i et køretøj',

    no_one_nearby = 'Ingen I Nærheden',
    no_one_nearby_desc = 'Der er ingen i nærheden til at give nøglerne til',

    notify_police_notified = 'Politi Notificeret',
    notify_police_notified_desc = 'Politiet er blevet underrettet om dine handlinger.',

    notify_police_notification = 'Udkald',
    notify_police_notification_desc = 'En borger har rapporteret en %s i området, tjek kortet.',

    vehicle_stopped = 'Motor Stoppet',
    vehicle_stopped_desc = 'Du har slukket motoren.',

    vehicle_started = 'Motor Startet',
    vehicle_started_desc = 'Du har startet motoren.',

    -- Keymapping
    toggle_keymap_desc = 'Skift Køretøjs Lås',

    -- Blip strings
    blip_hotwire = 'Stjålet Køretøj',
    blip_lockpick = 'Oplevet Køretøj',
    blip_robPed = 'Bevæbnet Tyveri',

    -- Crimes
    crime_hotwire = 'Køretøj Tyveri',
    crime_lockpick = 'Køretøj Indbrud',
    crime_robPed = 'Bevæbnet Tyveri',

    -- Metadata
    vehicle_plate = 'Køretøj Plade',
}
