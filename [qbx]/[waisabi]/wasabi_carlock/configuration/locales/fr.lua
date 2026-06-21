-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
if not Config.Language then Config.Language = 'en' end
if Config.Language ~= 'fr' then return end

Strings = {

    no_wsb = '^0[^3AVERTISSEMENT^0] wasabi_bridge N\'a PAS été démarré APRÈS le framework et/ou AVANT la ressource : %s',
    warning_disabling_metadata =
    '[^3AVERTISSEMENT^0] Aucun système d\'inventaire trouvé, désactivation des clés de métadonnées.',

    manage_keys = 'Gérer les Clés',
    manage_key = 'Gérer la Clé - %s',
    give_key = 'Donner la Clé',
    remove_key = 'Retirer la Clé',
    are_you_sure = 'Êtes-vous sûr ?',
    are_you_sure_desc = 'Êtes-vous sûr de vouloir retirer les clés pour la plaque %s ?',

    -- Menu
    player_id = 'ID du Joueur: ',

    -- Notification
    too_far = 'Trop Loin',
    too_far_desc = 'Vous êtes trop loin pour faire ça !',

    no_vehicle_found = 'Aucun Véhicule Trouvé',
    no_vehicle_found_desc = 'Aucun véhicule à proximité pour lequel vous avez les clés !',
    no_vehicle_found_keys_desc = 'Il n\'y a pas de véhicule à proximité pour lequel vous avez les clés !',
    no_vehicle_found_lockpick_desc = 'Aucun véhicule à proximité à crocheter !',

    no_keys_found = 'Aucune Clé Trouvée',
    no_keys_found_desc = 'Vous n\'avez aucune clé pour les véhicules !',

    vehicle_not_locked = 'Véhicule Déverrouillé',
    vehicle_not_locked_desc = 'Ce véhicule ne semble pas être verrouillé',

    vehicle_cant_lockpick = 'Impossible de Crocheter',
    vehicle_cant_lockpick_desc = 'Vous ne pouvez pas crocheter ce véhicule !',

    success = 'Succès',
    failed = 'Échec',
    success_lockpick_desc = 'Vous avez crocheté le véhicule avec succès',
    fail_lockpick_desc = 'Vous avez échoué à crocheter le véhicule',
    lockpick_broke = 'Outil de Crochetage Cassé',
    lockpick_broke_desc = 'Vous avez cassé l\'outil de crochetage',

    cancelled_action = 'Action Annulée',
    cancelled_action_desc = 'Votre action a été annulée !',

    search_nothing_found = 'Rien Trouvé',
    search_nothing_found_desc = 'Vous n\'avez rien trouvé d\'utile',
    search_keys_found = 'Clés Trouvées',
    search_keys_found_desc = 'Vous avez trouvé les clés du véhicule',
    search_item_found = 'Objet Trouvé',
    search_item_found_desc = 'Vous avez trouvé %sx %s !',
    search_money_found = 'Argent Trouvé',
    search_money_found_desc = 'Vous avez trouvé $%s',

    handed_keys = 'Clés Remises',
    handed_keys_desc = 'Les clés du véhicule vous ont été remises !',
    keys_received = 'Clés Reçues',
    keys_received_desc = 'Vous avez reçu les clés pour la plaque : %s',
    keys_removed = 'Clés Retirées',
    keys_removed_desc = 'Les clés pour la plaque : %s ont été retirées',

    vehicle_unlocked = 'Déverrouillé',
    vehicle_unlocked_desc = 'Vous avez déverrouillé votre véhicule',

    vehicle_locked = 'Verrouillé',
    vehicle_locked_desc = 'Vous avez verrouillé votre véhicule',

    already_in_vehicle = 'Dans un véhicule',
    already_in_vehicle_desc = 'Vous êtes déjà dans un véhicule',

    no_one_nearby = 'Personne à Proximité',
    no_one_nearby_desc = 'Il n\'y a personne à proximité pour donner des clés',

    notify_police_notified = 'Police Notifiée',
    notify_police_notified_desc = 'La police a été informée de vos actions.',

    notify_police_notification = 'Dispatch',
    notify_police_notification_desc = 'Un citoyen a signalé un %s dans la zone, vérifiez la carte.',

    vehicle_stopped = 'Moteur Arrêté',
    vehicle_stopped_desc = 'Vous avez éteint le moteur.',

    vehicle_started = 'Moteur Démarré',
    vehicle_started_desc = 'Vous avez démarré le moteur.',

    -- Keymapping
    toggle_keymap_desc = 'Basculer le verrouillage du véhicule',

    -- Blip strings
    blip_hotwire = 'Véhicule Volé',
    blip_lockpick = 'Véhicule Crocheté',
    blip_robPed = 'Vol Armé',

    -- Crimes
    crime_hotwire = 'Vol de Véhicule',
    crime_lockpick = 'Car-jacking',
    crime_robPed = 'Vol Armé',

    -- Metadata
    vehicle_plate = 'Plaque du Véhicule',
}
