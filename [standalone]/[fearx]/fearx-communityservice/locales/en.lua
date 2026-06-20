Locales = Locales or {}

function L(key, ...)
    local locale = Config.Locale or 'en'
    local str = Locales[locale] and Locales[locale][key] or Locales['en'][key] or key
    if ... then
        return string.format(str, ...)
    end
    return str
end

function GetUILocale()
    local locale = Config.Locale or 'en'
    local ui = Locales[locale] and Locales[locale].ui or Locales['en'].ui
    return ui or {}
end

Locales['en'] = {
    service_completed       = 'Community service completed! You are free to go.',
    sent_to_location        = 'You have been sent to %s for %d tasks',
    service_restored        = 'Community service restored at %s: %d tasks remaining',
    service_ended_by_admin  = 'Your community service has been ended by an admin',
    tasks_updated           = 'Your task count has been updated to %d',
    escape_penalty          = 'You tried to escape! +%d tasks added',
    sweeping                = 'Sweeping...',
    prompt_sweep            = '[E] Sweep',
    weapons_not_allowed     = 'Weapons are not allowed in this area',
    revived_in_zone         = 'You were revived in the community service zone',
    no_permission           = 'You do not have permission to use this command',
    usage_comserv           = 'Usage: /comserv [playerid/name] [amount] [reason]',
    usage_endcomserv        = 'Usage: /endcomserv [playerid/name]',
    invalid_amount          = 'Invalid amount',

    sv_no_permission        = 'You do not have permission to use this',
    player_not_found        = 'Player not found',
    player_sent             = 'Player sent to community service',
    player_released         = 'Player released from community service',
    invalid_location        = 'Invalid location',
    invalid_task_amount     = 'Invalid task amount',
    tasks_updated_admin     = 'Task amount updated successfully',
    player_not_in_service   = 'Player is not in community service',

    ui = {
        hud_title               = 'Community Service',
        hud_admin               = 'Admin:',
        hud_tasks               = 'Tasks:',
        hud_reason              = 'Reason:',
        na                      = 'N/A',
        title                   = 'Community Service',
        tab_members             = 'Members',
        tab_admin_log           = 'Admin Log',
        members_title           = 'Members',
        members_desc            = 'View and manage all members assigned to community service.',
        search_placeholder      = 'Search by name or ID...',
        btn_refresh             = 'Refresh',
        btn_refreshing          = 'Refreshing...',
        btn_punish              = 'Punish Player',
        th_member               = 'Member',
        th_id                   = 'ID',
        th_reason               = 'Reason',
        th_tasks                = 'Tasks',
        no_members              = 'No members in community service',
        no_logs                 = 'No admin logs available',
        no_reason               = 'No reason provided',
        log_title               = 'Admin Log',
        log_desc                = 'A log of all administrative actions taken in this panel.',
        page_info               = 'Page %s of %s',
        btn_previous            = 'Previous',
        btn_next                = 'Next',
        modal_title             = 'Punish Player',
        lbl_player              = 'Player Name or ID',
        ph_player               = 'Enter player name or ID...',
        lbl_location            = 'Select Location',
        lbl_tasks               = 'Number of Tasks',
        ph_tasks                = 'e.g., 10',
        lbl_reason              = 'Reason for Punishment',
        ph_reason               = 'e.g., Vandalism, Reckless Driving...',
        btn_cancel              = 'Cancel',
        btn_submit              = 'Submit Punishment',
        btn_processing          = 'Processing...',
        btn_success             = 'Success!',
        details_title           = 'Player Details',
        lbl_server_id           = 'Server ID: %s',
        lbl_admin               = 'Admin',
        lbl_edit_tasks          = 'Edit Task Amount',
        ph_new_tasks            = 'New task amount',
        btn_release             = 'Release Player',
        btn_close               = 'Close',
        time_just_now           = 'Just now',
        time_minutes_ago        = '%s minutes ago',
        time_hours_ago          = '%s hours ago',
        time_days_ago           = '%s days ago',
        log_sent                = '%s sent %s to %s for %s tasks',
        log_released            = '%s released %s from community service',
        log_edited              = '%s edited tasks for %s',
        log_penalty             = '%s received penalty: +%s tasks',
        log_system              = 'System action',
        log_action_by           = 'Action performed by %s',
        log_reason              = 'Reason: %s',
        view_details            = 'View Details',
        release_player          = 'Release Player',
    },
}
