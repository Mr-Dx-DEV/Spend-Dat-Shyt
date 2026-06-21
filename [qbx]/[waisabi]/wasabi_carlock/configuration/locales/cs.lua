-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
if not Config.Language then Config.Language = 'en' end
if Config.Language ~= 'cs' then return end

Strings = {

    no_wsb = '^0[^3VAROVÁNÍ^0] wasabi_bridge NENÍ spuštěn PO spuštění rámce a/nebo PŘED spuštěním zdroje: %s',
    warning_disabling_metadata = '[^3VAROVÁNÍ^0] Nebyl nalezen inventární systém, zakázání metadata klíčů.',

    manage_keys = 'Spravovat Klíče',
    manage_key = 'Spravovat Klíč - %s',
    give_key = 'Dát Klíč',
    remove_key = 'Odstranit Klíč',
    are_you_sure = 'Jste si jistí?',
    are_you_sure_desc = 'Jste si jisti, že chcete odstranit klíče pro SPZ %s?',

    -- Menu
    player_id = 'ID hráče: ',

    -- Notification
    too_far = 'Příliš Daleko',
    too_far_desc = 'Jste příliš daleko na to, abyste to udělali!',

    no_vehicle_found = 'Žádné Vozidlo Nalezeno',
    no_vehicle_found_desc = 'V okolí nejsou žádná vozidla, ke kterým máte klíče!',
    no_vehicle_found_keys_desc = 'Není v okolí žádné vozidlo, ke kterému máte klíče!',
    no_vehicle_found_lockpick_desc = 'Není v okolí žádné vozidlo k otevření!',

    no_keys_found = 'Žádné Klíče Nalezeny',
    no_keys_found_desc = 'Nemáte žádné klíče k vozidlům!',

    vehicle_not_locked = 'Vozidlo Odemčeno',
    vehicle_not_locked_desc = 'Toto vozidlo se nezdá být zamčené',

    vehicle_cant_lockpick = 'Nelze Otevřít',
    vehicle_cant_lockpick_desc = 'Toto vozidlo nemůžete otevřít!',

    success = 'Úspěch',
    failed = 'Neúspěch',
    success_lockpick_desc = 'Úspěšně jste otevřeli vozidlo',
    fail_lockpick_desc = 'Nepodařilo se vám otevřít vozidlo',
    lockpick_broke = 'Zámek Zlomený',
    lockpick_broke_desc = 'Zámek se zlomil',

    cancelled_action = 'Akce Zrušena',
    cancelled_action_desc = 'Vaše akce byla zrušena!',

    search_nothing_found = 'Nic Nalezeno',
    search_nothing_found_desc = 'Nenašli jste nic užitečného',
    search_keys_found = 'Nalezeny Klíče',
    search_keys_found_desc = 'Našli jste klíče k vozidlu',
    search_item_found = 'Nalezeny Předměty',
    search_item_found_desc = 'Našli jste %sx %s!',
    search_money_found = 'Nalezeny Peníze',
    search_money_found_desc = 'Našli jste $%s',

    handed_keys = 'Klíče Předány',
    handed_keys_desc = 'Byly vám předány klíče k vozidlu!',
    keys_received = 'Klíče Přijaty',
    keys_received_desc = 'Přijali jste klíče pro SPZ: %s',
    keys_removed = 'Klíče Odstraněny',
    keys_removed_desc = 'Klíče byly odstraněny pro SPZ: %s',

    vehicle_unlocked = 'Odemčeno',
    vehicle_unlocked_desc = 'Odemkli jste své vozidlo',

    vehicle_locked = 'Zamčeno',
    vehicle_locked_desc = 'Zamkli jste své vozidlo',

    already_in_vehicle = 'Vozidlo',
    already_in_vehicle_desc = 'Jste již v vozidle',

    no_one_nearby = 'Nikdo v okolí',
    no_one_nearby_desc = 'V okolí není nikdo, komu byste mohli dát klíče',

    notify_police_notified = 'Policie Upozorněna',
    notify_police_notified_desc = 'Policie byla informována o vašich akcích.',

    notify_police_notification = 'Dispečink',
    notify_police_notification_desc = 'Občan nahlásil %s v této oblasti, zkontrolujte mapu.',

    vehicle_stopped = 'Motor Vypnut',
    vehicle_stopped_desc = 'Vypnuli jste motor.',

    vehicle_started = 'Motor Zapnut',
    vehicle_started_desc = 'Zapnuli jste motor.',

    -- Keymapping
    toggle_keymap_desc = 'Přepnout Zámek Vozidla',

    -- Blip strings
    blip_hotwire = 'Kradené Vozidlo',
    blip_lockpick = 'Otevřené Vozidlo',
    blip_robPed = 'Ozbrojená Krádež',

    -- Crimes
    crime_hotwire = 'Krádež Vozidla',
    crime_lockpick = 'Pachání zločinu',
    crime_robPed = 'Ozbrojená Krádež',

    -- Metadata
    vehicle_plate = 'SPZ Vozidla',
}
