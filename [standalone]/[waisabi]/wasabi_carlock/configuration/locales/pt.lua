-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
if not Config.Language then Config.Language = 'en' end
if Config.Language ~= 'pt' then return end

Strings = {

    no_wsb = '^0[^3AVISO^0] wasabi_bridge NÃO foi iniciado APÓS o framework e/ou ANTES do recurso: %s',
    warning_disabling_metadata =
    '[^3AVISO^0] Nenhum sistema de inventário encontrado, desabilitando chaves de metadados.',

    manage_keys = 'Gerenciar Chaves',
    manage_key = 'Gerenciar Chave - %s',
    give_key = 'Dar Chave',
    remove_key = 'Remover Chave',
    are_you_sure = 'Você tem certeza?',
    are_you_sure_desc = 'Você tem certeza que deseja remover as chaves da placa %s?',

    -- Menu
    player_id = 'ID do Jogador: ',

    -- Notification
    too_far = 'Muito Longe',
    too_far_desc = 'Você está muito longe para fazer isso!',

    no_vehicle_found = 'Nenhum Veículo Encontrado',
    no_vehicle_found_desc = 'Não há veículos próximos para os quais você tenha as chaves!',
    no_vehicle_found_keys_desc = 'Não há veículos próximos que você tenha as chaves!',
    no_vehicle_found_lockpick_desc = 'Não há veículos próximos para arrombar!',

    no_keys_found = 'Nenhuma Chave Encontrada',
    no_keys_found_desc = 'Você não tem chaves para nenhum veículo!',

    vehicle_not_locked = 'Veículo Desbloqueado',
    vehicle_not_locked_desc = 'Este veículo não parece estar trancado',

    vehicle_cant_lockpick = 'Não Pode Arrombar',
    vehicle_cant_lockpick_desc = 'Você não pode arrombar este veículo!',

    success = 'Sucesso',
    failed = 'Falhou',
    success_lockpick_desc = 'Você arrombou o veículo com sucesso',
    fail_lockpick_desc = 'Você falhou em arrombar o veículo',
    lockpick_broke = 'Arrombador Quebrado',
    lockpick_broke_desc = 'Você quebrou o arrombador',

    cancelled_action = 'Ação Cancelada',
    cancelled_action_desc = 'Sua ação foi cancelada!',

    search_nothing_found = 'Nada Encontrado',
    search_nothing_found_desc = 'Você não encontrou nada útil',
    search_keys_found = 'Chaves Encontradas',
    search_keys_found_desc = 'Você encontrou as chaves do veículo',
    search_item_found = 'Item Encontrado',
    search_item_found_desc = 'Você encontrou %sx %s!',
    search_money_found = 'Dinheiro Encontrado',
    search_money_found_desc = 'Você encontrou $%s',

    handed_keys = 'Chaves Entregues',
    handed_keys_desc = 'Você recebeu as chaves do veículo!',
    keys_received = 'Chaves Recebidas',
    keys_received_desc = 'Você recebeu as chaves para a placa: %s',
    keys_removed = 'Chaves Removidas',
    keys_removed_desc = 'As chaves para a placa: %s foram removidas',

    vehicle_unlocked = 'Desbloqueado',
    vehicle_unlocked_desc = 'Você desbloqueou seu veículo',

    vehicle_locked = 'Trancado',
    vehicle_locked_desc = 'Você trancou seu veículo',

    already_in_vehicle = 'No Veículo',
    already_in_vehicle_desc = 'Você já está em um veículo',

    no_one_nearby = 'Ninguém Por Perto',
    no_one_nearby_desc = 'Não há ninguém por perto para dar as chaves',

    notify_police_notified = 'Polícia Notificada',
    notify_police_notified_desc = 'A polícia foi notificada sobre suas ações.',

    notify_police_notification = 'Despatch',
    notify_police_notification_desc = 'Um cidadão relatou um %s na área, verifique o mapa.',

    vehicle_stopped = 'Motor Parado',
    vehicle_stopped_desc = 'Você desligou o motor.',

    vehicle_started = 'Motor Ligado',
    vehicle_started_desc = 'Você ligou o motor.',

    -- Keymapping
    toggle_keymap_desc = 'Alternar Bloqueio de Carro',

    -- Blip strings
    blip_hotwire = 'Veículo Roubado',
    blip_lockpick = 'Veículo Arrombado',
    blip_robPed = 'Roubo Armado',

    -- Crimes
    crime_hotwire = 'Roubo de Veículo',
    crime_lockpick = 'Arrombamento de Carro',
    crime_robPed = 'Roubo Armado',

    -- Metadata
    vehicle_plate = 'Placa do Veículo',
}
