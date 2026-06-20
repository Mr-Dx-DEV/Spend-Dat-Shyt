local config = require 'config.shared'

lib.callback.register('SOS:checkdisease', function(source)
    local identifier = GetIdentifierPlayer(source)

    if identifier then
        if config.framework == 'esx' then
            local result = MySQL.single.await('SELECT `diseasesex` FROM `users` WHERE `identifier` = ? LIMIT 1', {
                identifier
            })

            if result then
                return result.diseasesex
            end
        elseif config.framework == 'qb' then
            local result = MySQL.single.await('SELECT `diseasesex` FROM `players` WHERE `citizenid` = ? LIMIT 1', {
                identifier
            })

            if result then
                return result.diseasesex
            end
        else
            -- your custom framework here
            return false
        end    
    end

    return false
end)

lib.callback.register('SOS:checkdiseasetarget', function(source, target)
    local identifier = GetIdentifierPlayer(target)

    if identifier then
        if config.framework == 'esx' then
            local result = MySQL.single.await('SELECT `diseasesex` FROM `users` WHERE `identifier` = ? LIMIT 1', {
                identifier
            })

            if result then
                return result.diseasesex
            end
        elseif config.framework == 'qb' then
            local result = MySQL.single.await('SELECT `diseasesex` FROM `players` WHERE `citizenid` = ? LIMIT 1', {
                identifier
            })

            if result then
                return result.diseasesex
            end
        else
            -- your custom framework here
            return false
        end    
    end

    return false
end)

lib.callback.register('SOS:getpartnersex', function(source, target)
    local identifier = GetIdentifierPlayer(source)
    local targetidentifier = GetIdentifierPlayer(target)

    if identifier then
        if config.framework == 'esx' then
            local result = MySQL.single.await('SELECT `mypartnersex` FROM `users` WHERE `identifier` = ? LIMIT 1', {
                identifier
            })

            if result then
                return result.mypartnersex, targetidentifier
            end
        elseif config.framework == 'qb' then
            local result = MySQL.single.await('SELECT `mypartnersex` FROM `players` WHERE `citizenid` = ? LIMIT 1', {
                identifier
            })

            if result then
                return result.mypartnersex, targetidentifier
            end
        else
            -- your custom framework here
            return false
        end    
    end

    return false
end)

lib.callback.register('SOS:updatedisease', function(source, diseasesex)
    local identifier = GetIdentifierPlayer(source)

    if identifier then
        if config.framework == 'esx' then
            local result = MySQL.single.await('UPDATE `users` SET `diseasesex` = ? WHERE `identifier` = ? LIMIT 1', {
                diseasesex, identifier
            })
            return true
        elseif config.framework == 'qb' then
            local result = MySQL.single.await('UPDATE `players` SET `diseasesex` = ? WHERE `citizenid` = ? LIMIT 1', {
                diseasesex, identifier
            })
            return true
        else
            -- your custom framework here
            return false
        end   
    end

    return false
end)

lib.callback.register('SOS:updatepartner', function(source, target)
    local identifier = GetIdentifierPlayer(source)
	local targetidentifier = GetIdentifierPlayer(target)

    if identifier then
        if config.framework == 'esx' then
            local result = MySQL.single.await('UPDATE `users` SET `mypartnersex` = ? WHERE `identifier` = ? LIMIT 1', {
                targetidentifier, identifier
            })
            return true
        elseif config.framework == 'qb' then
            local result = MySQL.single.await('UPDATE `players` SET `mypartnersex` = ? WHERE `citizenid` = ? LIMIT 1', {
                targetidentifier, identifier
            })
            return true
        else
            -- your custom framework here
            return false
        end   
    end

    return false
end)

lib.callback.register('SOS:checkbodycount', function(source)
    local identifier = GetIdentifierPlayer(source)

    if identifier then
        if config.framework == 'esx' then
            local result = MySQL.single.await('SELECT `bodycount` FROM `users` WHERE `identifier` = ? LIMIT 1', {
                identifier
            })

            if result then
                return result.bodycount
            end
        elseif config.framework == 'qb' then
            local result = MySQL.single.await('SELECT `bodycount` FROM `players` WHERE `citizenid` = ? LIMIT 1', {
                identifier
            })

            if result then
                return result.bodycount
            end
        else
            -- your custom framework here
            return false
        end    
    end

    return false
end)

lib.callback.register('SOS:updatebodycount', function(source, totalbodycount)
    local identifier = GetIdentifierPlayer(source)

    if identifier then
        if config.framework == 'esx' then
            local result = MySQL.single.await('UPDATE `users` SET `bodycount` = ? WHERE `identifier` = ? LIMIT 1', {
                totalbodycount, identifier
            })
            return true
        elseif config.framework == 'qb' then
            local result = MySQL.single.await('UPDATE `players` SET `bodycount` = ? WHERE `citizenid` = ? LIMIT 1', {
                totalbodycount, identifier
            })
            return true
        else
            -- your custom framework here
            return false
        end   
    end

    return false
end)

RegisterUsableItem(config.disease.hepatitisitem, function(source)
    if not HasItem(source, config.disease.hepatitisitem) then return end
	TriggerClientEvent('SOS:hepatitis_cured', source, config.disease.hepatitisitem)
end)

RegisterUsableItem(config.disease.hivitem, function(source)
    if not HasItem(source, config.disease.hivitem) then return end
	TriggerClientEvent('SOS:hiv_cured', source, config.disease.hivitem)
end)

RegisterUsableItem(config.disease.monkeypoxitem, function(source)
    if not HasItem(source, config.disease.monkeypoxitem) then return end
	TriggerClientEvent('SOS:monkeypox_cured', source, config.disease.monkeypoxitem)
end)

RegisterUsableItem(config.disease.monkeypoxitem, function(source)
    if not HasItem(source, config.disease.monkeypoxitem) then return end
	TriggerClientEvent('SOS:monkeypox_cured', source, config.disease.monkeypoxitem)
end)