AddEventHandler('esx_society:openBossMenu', function(society, close, options)
    local society = string.gsub(society, "society_", "")
    local jobSettings = Config.JobMenusSettings[society]
	openBossMenu(society, jobSettings?.type)
end)