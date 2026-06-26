RegisterNetEvent('qb-bossmenu:client:OpenMenu', function()
    local jobName = CL.GetPlayerJob('name')
    if not jobName then
        return
    end
    
    local jobSettings = Config.JobMenusSettings[jobName]
    if not jobSettings then
        return
    end

	openBossMenu(jobName, jobSettings?.type)
end)

RegisterNetEvent('qb-gangmenu:client:OpenMenu', function()
    local jobName = CL.GetPlayerJob('name')
    if not jobName then
        return
    end
    
    local jobSettings = Config.JobMenusSettings[jobName]
    if not jobSettings then
        return
    end

	openBossMenu(jobName, jobSettings?.type)
end)


RegisterNetEvent('qb-bossmenu:client:Wardrobe', function()
    local jobName = CL.GetPlayerJob('name')
    if not jobName then
        return
    end
    
    local jobSettings = Config.JobMenusSettings[jobName]
    if not jobSettings then
        return
    end

    openDressingRoom(jobName, jobSettings?.type)
end)
