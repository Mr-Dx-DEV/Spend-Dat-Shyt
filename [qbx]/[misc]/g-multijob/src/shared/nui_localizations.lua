function Localization()
    local translations = {
        no_multi_jobs_available = LAN("no_multi_jobs_available"),
        no_jobs_assigned = LAN("no_jobs_assigned"),
        active = LAN("active"),
        inactive = LAN("inactive"),
        on_duty = LAN("on_duty"),
        off_duty = LAN("off_duty"),
        switching = LAN("switching"),
        switch = LAN("switch"),
        updating = LAN("updating"),
        go_off_duty = LAN("go_off_duty"),
        go_to_duty = LAN("go_to_duty"),
        job_selection = LAN("job_selection"),
        switch_between_your_active_jobs = LAN("switch_between_your_active_jobs"),
        job_cannot_be_removed = LAN("job_cannot_be_removed"),
        cannot_remove_active_job = LAN("cannot_remove_active_job"),
    }
    SendNUIMessage({
        action = "justgroot:g-multijob:localizations",
        data = translations,
    })
end
