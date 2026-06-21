-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
if not Config.Language then Config.Language = 'en' end
if Config.Language ~= 'es' then return end

Strings = {

    no_wsb = '^0[^3ADVERTENCIA^0] wasabi_bridge NO se inició DESPUÉS del framework y/o ANTES del recurso: %s',
    warning_disabling_metadata =
    '[^3ADVERTENCIA^0] No se encontró sistema de inventario, desactivando claves de metadatos.',

    manage_keys = 'Gestionar Llaves',
    manage_key = 'Gestionar Llave - %s',
    give_key = 'Dar Llave',
    remove_key = 'Eliminar Llave',
    are_you_sure = '¿Estás seguro?',
    are_you_sure_desc = '¿Estás seguro de que quieres eliminar las llaves para la matrícula %s?',

    -- Menu
    player_id = 'ID del Jugador: ',

    -- Notification
    too_far = 'Demasiado Lejos',
    too_far_desc = '¡Estás demasiado lejos para hacer esto!',

    no_vehicle_found = 'Vehículo No Encontrado',
    no_vehicle_found_desc = '¡No hay vehículos cercanos para los que tengas llaves!',
    no_vehicle_found_keys_desc = '¡No hay vehículos cercanos que tengas llaves!',
    no_vehicle_found_lockpick_desc = '¡No hay vehículos cercanos para abrir!',

    no_keys_found = 'No Se Encontraron Llaves',
    no_keys_found_desc = '¡No tienes llaves para ningún vehículo!',

    vehicle_not_locked = 'Vehículo Desbloqueado',
    vehicle_not_locked_desc = 'Este vehículo no parece estar bloqueado',

    vehicle_cant_lockpick = 'No se Puede Abrir',
    vehicle_cant_lockpick_desc = '¡No puedes abrir este vehículo!',

    success = 'Éxito',
    failed = 'Fallido',
    success_lockpick_desc = 'Has abierto el vehículo con éxito',
    fail_lockpick_desc = 'No pudiste abrir el vehículo',
    lockpick_broke = 'Herramienta de Apertura Doblada',
    lockpick_broke_desc = 'Has doblado la herramienta de apertura',

    cancelled_action = 'Acción Cancelada',
    cancelled_action_desc = '¡Tu acción ha sido cancelada!',

    search_nothing_found = 'Nada Encontrado',
    search_nothing_found_desc = 'No encontraste nada útil',
    search_keys_found = 'Llaves Encontradas',
    search_keys_found_desc = 'Encontraste las llaves del vehículo',
    search_item_found = 'Algo Encontrado',
    search_item_found_desc = '¡Encontraste %sx %s!',
    search_money_found = 'Dinero Encontrado',
    search_money_found_desc = 'Encontraste $%s',

    handed_keys = 'Llaves Entregadas',
    handed_keys_desc = '¡Te han entregado las llaves del vehículo!',
    keys_received = 'Llaves Recibidas',
    keys_received_desc = 'Recibiste las llaves para la matrícula: %s',
    keys_removed = 'Llaves Eliminadas',
    keys_removed_desc = 'Se han eliminado las llaves para la matrícula: %s',

    vehicle_unlocked = 'Desbloqueado',
    vehicle_unlocked_desc = 'Has desbloqueado tu vehículo',

    vehicle_locked = 'Bloqueado',
    vehicle_locked_desc = 'Has bloqueado tu vehículo',

    already_in_vehicle = 'En el vehículo',
    already_in_vehicle_desc = 'Ya estás en un vehículo',

    no_one_nearby = 'Nadie Cerca',
    no_one_nearby_desc = 'No hay nadie cerca a quien dar las llaves',

    notify_police_notified = 'Policía Notificada',
    notify_police_notified_desc = 'La policía ha sido notificada de tus acciones.',

    notify_police_notification = 'Despacho',
    notify_police_notification_desc = 'Un ciudadano ha reportado un %s en el área, revisa el mapa.',

    vehicle_stopped = 'Motor Detenido',
    vehicle_stopped_desc = 'Has apagado el motor.',

    vehicle_started = 'Motor Iniciado',
    vehicle_started_desc = 'Has encendido el motor.',

    -- Keymapping
    toggle_keymap_desc = 'Alternar bloqueo de coche',

    -- Blip strings
    blip_hotwire = 'Vehículo Robado',
    blip_lockpick = 'Vehículo Abierto',
    blip_robPed = 'Robo Armado',

    -- Crimes
    crime_hotwire = 'Robo de Vehículo',
    crime_lockpick = 'Robo de Auto',
    crime_robPed = 'Robo Armado',

    -- Metadata
    vehicle_plate = 'Placa de Vehículo',
}
