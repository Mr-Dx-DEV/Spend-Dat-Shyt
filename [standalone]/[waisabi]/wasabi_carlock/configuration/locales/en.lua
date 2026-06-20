-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
if not Config.Language then Config.Language = 'en' end
if Config.Language ~= 'en' then return end

Strings = {

    no_wsb = '^0[^3WARNING^0] wasabi_bridge was NOT started AFTER framework and/or BEFORE resource: %s',
    warning_disabling_metadata = '[^3WARNING^0] No inventory system found, disabling metadata keys.',

    manage_keys = 'Manage Keys',
    manage_key = 'Manage Key - %s',
    give_key = 'Give Key',
    remove_key = 'Remove Key',
    are_you_sure = 'Are you sure?',
    are_you_sure_desc = 'Are you sure you want to remove the keys for plate %s?',

    -- Menu
    player_id = 'Player ID: ',

    --Notification
    too_far = 'Too Far',
    too_far_desc = 'You are too far away to do this!',

    no_vehicle_found = 'No Vehicle Found',
    no_vehicle_found_desc = 'No vehicles nearby that you have keys to!',
    no_vehicle_found_keys_desc = 'There is no vehicle nearby that you have keys to!',
    no_vehicle_found_lockpick_desc = 'There is no vehicle nearby to lockpick!',

    no_keys_found = 'No Keys Found',
    no_keys_found_desc = 'You do not have keys for any vehicles!',

    vehicle_not_locked = 'Vehicle Unlocked',
    vehicle_not_locked_desc = 'This vehicle does not seem to be locked',

    vehicle_cant_lockpick = 'Can\'t Lockpick',
    vehicle_cant_lockpick_desc = 'You can\'t lockpick this vehicle!',

    success = 'Success',
    failed = 'Failed',
    success_lockpick_desc = 'You successfully lockpicked the vehicle',
    fail_lockpick_desc = 'You failed to lockpick the vehicle',
    lockpick_broke = 'Lockpick Bent',
    lockpick_broke_desc = 'You bent the lockpick',

    cancelled_action = 'Action Cancelled',
    cancelled_action_desc = 'Your action was cancelled!',

    search_nothing_found = 'Nothing Found',
    search_nothing_found_desc = 'You found nothing useful',
    search_keys_found = 'Found Keys',
    search_keys_found_desc = 'You found the keys to the vehicle',
    search_item_found = 'Something Found',
    search_item_found_desc = 'You found %sx %s!',
    search_money_found = 'Money Found',
    search_money_found_desc = 'You found $%s',

    handed_keys = 'Handed Keys',
    handed_keys_desc = 'You have been handed the keys to the vehicle!',
    keys_received = 'Keys Received',
    keys_received_desc = 'You recieved keys for plate: %s',
    keys_removed = 'Keys Removed',
    keys_removed_desc = 'Keys have been removed for plate: %s',

    vehicle_unlocked = 'Unlocked',
    vehicle_unlocked_desc = 'You have unlocked your vehicle',

    vehicle_locked = 'Locked',
    vehicle_locked_desc = 'You have locked your vehicle',

    already_in_vehicle = 'In vehicle',
    already_in_vehicle_desc = 'You are already in a vehicle',

    no_one_nearby = 'No One Found',
    no_one_nearby_desc = 'Nobody is around to give keys to',

    notify_police_notified = 'Police Notified',
    notify_police_notified_desc = 'The police have been notified of your actions.',

    notify_police_notification = 'Dispatch',
    notify_police_notification_desc = 'A citizen has reported a %s in the area check the map.',

    vehicle_stopped = 'Engine Stopped',
    vehicle_stopped_desc = 'You have turned off the engine.',

    vehicle_started = 'Engine Started',
    vehicle_started_desc = 'You have started the engine.',

    -- Keymapping
    toggle_keymap_desc = 'Toggle Car Lock',

    -- Blip strings
    blip_hotwire = 'Stolen Vehicle',
    blip_lockpick = 'Lockpicked Vehicle',
    blip_robPed = 'Armed Theft',

    -- Crimes
    crime_hotwire = 'vehicle theft',
    crime_lockpick = 'car prowling',
    crime_robPed = 'armed theft',

    -- Metadata
    vehicle_plate = 'Vehicle Plate',
}
