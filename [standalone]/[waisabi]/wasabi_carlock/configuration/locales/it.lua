-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
if not Config.Language then Config.Language = 'en' end
if Config.Language ~= 'it' then return end

Strings = {

    no_wsb = '^0[^3ATTENZIONE^0] wasabi_bridge NON è stato avviato DOPO il framework e/o PRIMA della risorsa: %s',
    warning_disabling_metadata =
    '[^3ATTENZIONE^0] Nessun sistema inventario trovato, disabilitazione delle chiavi dei metadati.',

    manage_keys = 'Gestisci Chiavi',
    manage_key = 'Gestisci Chiave - %s',
    give_key = 'Dare Chiave',
    remove_key = 'Rimuovere Chiave',
    are_you_sure = 'Sei sicuro?',
    are_you_sure_desc = 'Sei sicuro di voler rimuovere le chiavi per la targa %s?',

    -- Menu
    player_id = 'ID del Giocatore: ',

    -- Notification
    too_far = 'Troppo Lontano',
    too_far_desc = 'Sei troppo lontano per fare questo!',

    no_vehicle_found = 'Nessun Veicolo Trovato',
    no_vehicle_found_desc = 'Non ci sono veicoli nelle vicinanze di cui hai le chiavi!',
    no_vehicle_found_keys_desc = 'Non ci sono veicoli nelle vicinanze di cui hai le chiavi!',
    no_vehicle_found_lockpick_desc = 'Non ci sono veicoli nelle vicinanze da scassinare!',

    no_keys_found = 'Nessuna Chiave Trovata',
    no_keys_found_desc = 'Non hai chiavi per nessun veicolo!',

    vehicle_not_locked = 'Veicolo Sbloccato',
    vehicle_not_locked_desc = 'Questo veicolo non sembra essere bloccato',

    vehicle_cant_lockpick = 'Non Puoi Scassinare',
    vehicle_cant_lockpick_desc = 'Non puoi scassinare questo veicolo!',

    success = 'Successo',
    failed = 'Fallito',
    success_lockpick_desc = 'Hai scassinato con successo il veicolo',
    fail_lockpick_desc = 'Non sei riuscito a scassinare il veicolo',
    lockpick_broke = 'Scasso Rotto',
    lockpick_broke_desc = 'Hai rotto lo strumento di scasso',

    cancelled_action = 'Azione Annullata',
    cancelled_action_desc = 'La tua azione è stata annullata!',

    search_nothing_found = 'Niente Trovato',
    search_nothing_found_desc = 'Non hai trovato nulla di utile',
    search_keys_found = 'Chiavi Trovate',
    search_keys_found_desc = 'Hai trovato le chiavi del veicolo',
    search_item_found = 'Oggetto Trovato',
    search_item_found_desc = 'Hai trovato %sx %s!',
    search_money_found = 'Soldi Trovati',
    search_money_found_desc = 'Hai trovato $%s',

    handed_keys = 'Chiavi Consegnate',
    handed_keys_desc = 'Ti sono state consegnate le chiavi del veicolo!',
    keys_received = 'Chiavi Ricevute',
    keys_received_desc = 'Hai ricevuto le chiavi per la targa: %s',
    keys_removed = 'Chiavi Rimosse',
    keys_removed_desc = 'Le chiavi sono state rimosse per la targa: %s',

    vehicle_unlocked = 'Sbloccato',
    vehicle_unlocked_desc = 'Hai sbloccato il tuo veicolo',

    vehicle_locked = 'Bloccato',
    vehicle_locked_desc = 'Hai bloccato il tuo veicolo',

    already_in_vehicle = 'Nel veicolo',
    already_in_vehicle_desc = 'Sei già in un veicolo',

    no_one_nearby = 'Nessuno nei Dintorni',
    no_one_nearby_desc = 'Non c\'è nessuno nei dintorni a cui dare le chiavi',

    notify_police_notified = 'Polizia Notificata',
    notify_police_notified_desc = 'La polizia è stata informata delle tue azioni.',

    notify_police_notification = 'Dispositivo',
    notify_police_notification_desc = 'Un cittadino ha segnalato un %s nell\'area, controlla la mappa.',

    vehicle_stopped = 'Motore Spento',
    vehicle_stopped_desc = 'Hai spento il motore.',

    vehicle_started = 'Motore Avviato',
    vehicle_started_desc = 'Hai avviato il motore.',

    -- Keymapping
    toggle_keymap_desc = 'Attiva/Disattiva il blocco dell\'auto',

    -- Blip strings
    blip_hotwire = 'Veicolo Rubato',
    blip_lockpick = 'Veicolo Scassinato',
    blip_robPed = 'Furto Armato',

    -- Crimes
    crime_hotwire = 'Furto di Veicolo',
    crime_lockpick = 'Scassinamento Auto',
    crime_robPed = 'Furto Armato',

    -- Metadata
    vehicle_plate = 'Targa Veicolo',
}
