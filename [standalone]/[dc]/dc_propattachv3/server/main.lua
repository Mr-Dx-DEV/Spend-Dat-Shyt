local Config = PropAttachConfig
RegisterNetEvent('dc_propattach:server:checkAdmin', function()
    local src = source
    local hasPerms = false

    if not Config.OnlyAdmins then
        hasPerms = true
    else
        hasPerms = IsPlayerAceAllowed(src, 'command.props')
    end

    TriggerClientEvent('dc_propattach:client:admincheck', src, hasPerms)
end)