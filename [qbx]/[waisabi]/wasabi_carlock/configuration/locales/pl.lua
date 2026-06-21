-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
if not Config.Language then Config.Language = 'en' end
if Config.Language ~= 'pl' then return end

Strings = {

    no_wsb = '^0[^3OSTRZEŻENIE^0] wasabi_bridge NIE został uruchomiony PO frameworku i/lub PRZED zasobem: %s',
    warning_disabling_metadata = '[^3OSTRZEŻENIE^0] Nie znaleziono systemu inwentarza, wyłączanie kluczy metadanych.',

    manage_keys = 'Zarządzaj Kluczami',
    manage_key = 'Zarządzaj Kluczem - %s',
    give_key = 'Daj Klucz',
    remove_key = 'Usuń Klucz',
    are_you_sure = 'Jesteś pewny?',
    are_you_sure_desc = 'Czy na pewno chcesz usunąć klucze dla tablicy %s?',

    -- Menu
    player_id = 'ID Gracza: ',

    -- Notification
    too_far = 'Za Daleko',
    too_far_desc = 'Jesteś za daleko, aby to zrobić!',

    no_vehicle_found = 'Nie Znaleziono Pojazdu',
    no_vehicle_found_desc = 'Nie ma żadnych pojazdów w pobliżu, do których masz klucze!',
    no_vehicle_found_keys_desc = 'Nie ma pojazdów w pobliżu, do których masz klucze!',
    no_vehicle_found_lockpick_desc = 'Nie ma pojazdów w pobliżu, które możesz otworzyć!',

    no_keys_found = 'Nie Znaleziono Kluczy',
    no_keys_found_desc = 'Nie masz kluczy do żadnych pojazdów!',

    vehicle_not_locked = 'Pojazd Otwarty',
    vehicle_not_locked_desc = 'Ten pojazd nie wydaje się być zamknięty',

    vehicle_cant_lockpick = 'Nie Można Otwarte',
    vehicle_cant_lockpick_desc = 'Nie możesz otworzyć tego pojazdu!',

    success = 'Sukces',
    failed = 'Niepowodzenie',
    success_lockpick_desc = 'Pomyślnie otworzyłeś pojazd',
    fail_lockpick_desc = 'Nie udało się otworzyć pojazdu',
    lockpick_broke = 'Lockpick Złamany',
    lockpick_broke_desc = 'Złamałeś lockpicka',

    cancelled_action = 'Akcja Anulowana',
    cancelled_action_desc = 'Twoja akcja została anulowana!',

    search_nothing_found = 'Nic Nie Znaleziono',
    search_nothing_found_desc = 'Nie znalazłeś niczego przydatnego',
    search_keys_found = 'Znaleziono Klucze',
    search_keys_found_desc = 'Znalazłeś klucze do pojazdu',
    search_item_found = 'Znaleziono Przedmiot',
    search_item_found_desc = 'Znalazłeś %sx %s!',
    search_money_found = 'Znaleziono Pieniądze',
    search_money_found_desc = 'Znalazłeś $%s',

    handed_keys = 'Klucze Przekazane',
    handed_keys_desc = 'Otrzymałeś klucze do pojazdu!',
    keys_received = 'Otrzymane Klucze',
    keys_received_desc = 'Otrzymałeś klucze do tablicy: %s',
    keys_removed = 'Klucze Usunięte',
    keys_removed_desc = 'Klucze zostały usunięte dla tablicy: %s',

    vehicle_unlocked = 'Odblokowane',
    vehicle_unlocked_desc = 'Odblokowałeś swój pojazd',

    vehicle_locked = 'Zablokowane',
    vehicle_locked_desc = 'Zablokowałeś swój pojazd',

    already_in_vehicle = 'W Pojazdu',
    already_in_vehicle_desc = 'Już jesteś w pojeździe',

    no_one_nearby = 'Brak Osób W Pobliżu',
    no_one_nearby_desc = 'Nie ma nikogo w pobliżu, komu można by dać klucze',

    notify_police_notified = 'Policja Powiadomiona',
    notify_police_notified_desc = 'Policja została powiadomiona o twoich działaniach.',

    notify_police_notification = 'Dyspozytor',
    notify_police_notification_desc = 'Obywatel zgłosił %s w tej okolicy, sprawdź mapę.',

    vehicle_stopped = 'Silnik Zatrzymany',
    vehicle_stopped_desc = 'Wyłączyłeś silnik.',

    vehicle_started = 'Silnik Uruchomiony',
    vehicle_started_desc = 'Uruchomiłeś silnik.',

    -- Keymapping
    toggle_keymap_desc = 'Przełącz Zamek Pojazdu',

    -- Blip strings
    blip_hotwire = 'Sk stolen Vehicle',
    blip_lockpick = 'Lockpicked Vehicle',
    blip_robPed = 'Armed Theft',
}
