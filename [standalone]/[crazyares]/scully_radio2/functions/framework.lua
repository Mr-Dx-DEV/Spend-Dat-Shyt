Scully.Functions = {}

local function hasResource(name)
    local state = GetResourceState(name)

    return state ~= 'missing' and state ~= 'unknown'
end

local ox_inventory = hasResource('ox_inventory') and exports.ox_inventory
local qb_inventory = hasResource('qb-inventory') and exports['qb-inventory']
local ps_inventory = hasResource('ps-inventory') and exports['ps-inventory']
local qs_inventory = hasResource('qs-inventory') and exports['qs-inventory']
local codem_inventory = hasResource('codem-inventory') and exports['codem-inventory']
local QBCore, ESX = hasResource('qb-core'), hasResource('es_extended')

if IsDuplicityVersion() then
    if QBCore then
        local fw = exports['qb-core']:GetCoreObject()

        function Scully.Functions.GetPlayerName(source)
            local player = fw.Functions.GetPlayer(source)
            local metadata = player.PlayerData.metadata

            local charinfo = player.PlayerData.charinfo
            local name = string.sub(charinfo.firstname, 1, 1) .. '. ' .. charinfo.lastname

            if metadata.callsign == 'NO CALLSIGN' then
                return '', name
            else
                return metadata.callsign .. ' | ', name
            end
        end

        if Scully.UseItem and (qb_inventory or ps_inventory or qs_inventory or codem_inventory) then
            fw.Functions.CreateUseableItem('radio', function(source, item)
                TriggerClientEvent('scully_radio:openRadio', source, Scully.RadioColour)
            end)

            if Scully.AllowColours and Scully.UseItemColours then
                for i = 1, #Scully.RadioColours do
                    local color = Scully.RadioColours[i]

                    if color ~= 'default' then
                        fw.Functions.CreateUseableItem('radio_' .. color, function(source, item)
                            TriggerClientEvent('scully_radio:openRadio', source, color)
                        end)
                    end
                end
            end
        end
    elseif ESX then
        local fw = exports.es_extended:getSharedObject()

        function Scully.Functions.GetPlayerName(source)
            local player = fw.GetPlayerFromId(source)

            if player then
                local firstname = player.get('firstName')

                if firstname then
                    return '', string.sub(firstname, 1, 1) .. '. ' .. player.get('lastName')
                else
                    return '', GetPlayerName(source)
                end
            end
        end

        if Scully.UseItem and (qs_inventory or codem_inventory) then
            fw.RegisterUsableItem('radio', function(source)
                TriggerClientEvent('scully_radio:openRadio', source, Scully.RadioColour)
            end)

            if Scully.AllowColours and Scully.UseItemColours then
                for i = 1, #Scully.RadioColours do
                    local color = Scully.RadioColours[i]

                    if color ~= 'default' then
                        fw.RegisterUsableItem('radio_' .. color, function(source)
                            TriggerClientEvent('scully_radio:openRadio', source, color)
                        end)
                    end
                end
            end
        end
    else
        Scully.Functions = {
            GetPlayerName = function(source)
                return '', GetPlayerName(source)
            end,
        }

        RegisterNetEvent('scully_radio:getPermissions', function()
            local src = source
            local permissions = {}

            for i = 1, #Scully.AcePerms do
                local ace = Scully.AcePerms[i]

                if IsPlayerAceAllowed(src, 'radio.' .. ace) then
                    permissions[ace] = true
                end
            end

            TriggerClientEvent('scully_radio:sendPermissions', src, permissions)
        end)
    end
else
    local playerState = LocalPlayer.state
    local playerData = {}

    if QBCore then
        local fw = exports['qb-core']:GetCoreObject()

        playerData = fw.Functions.GetPlayerData()

        RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
            playerData = fw.Functions.GetPlayerData()

            local callsign = GetResourceKvpString(playerData.citizenid .. ':callsign:' .. Scully.KVPHandle)
            local radioName = GetResourceKvpString(playerData.citizenid .. ':name:' .. Scully.KVPHandle)

            if callsign then
                TriggerServerEvent('scully_radio:updateRadioInfo', 'callsign', callsign)
            end

            if radioName then
                TriggerServerEvent('scully_radio:updateRadioInfo', 'name', radioName)
            end
        end)

        RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
            playerData = {}

            TriggerEvent('scully_radio:leaveChannel', true)
        end)

        RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
            playerData.job = job
        end)

        CreateThread(function()
            while true do
                if playerState.radioChannel and (playerState.radioChannel > 0) then
                    Scully.Functions.HasItem(function(hasItem)
                        if not hasItem then
                            TriggerEvent('scully_radio:leaveChannel', true)
                        end
                    end)
                end

                Wait(2500)
            end
        end)

        Scully.Functions.ShowNotification = fw.Functions.Notify

        function Scully.Functions.UpdateInfo(data)
            Scully.Radio[data.type] = data.value

            SetResourceKvp(playerData.citizenid .. ':' .. data.type .. ':' .. Scully.KVPHandle, data.value)
            TriggerServerEvent('scully_radio:updateRadioInfo', data.type, data.value)
            Scully.Functions.ShowNotification(Scully.Language.UpdatedYour .. ' ' .. data.type .. ' ' .. Scully.Language.To .. ' ' .. data.value .. '!')
        end
    elseif ESX then
        local fw = exports.es_extended:getSharedObject()

        playerData = fw.GetPlayerData()

        RegisterNetEvent('esx:playerLoaded', function(data)
            Wait(1000)

            playerState.isLoggedIn = true
            playerData = data

            local callsign = GetResourceKvpString(playerData.identifier .. ':callsign:' .. Scully.KVPHandle)
            local radioName = GetResourceKvpString(playerData.identifier .. ':name:' .. Scully.KVPHandle)

            if callsign then
                TriggerServerEvent('scully_radio:updateRadioInfo', 'callsign', callsign)
            end

            if radioName then
                TriggerServerEvent('scully_radio:updateRadioInfo', 'name', radioName)
            end
        end)

        RegisterNetEvent('esx:onPlayerLogout', function()
            playerState.isLoggedIn = false
            playerData = {}

            TriggerEvent('scully_radio:leaveChannel', true)
        end)

        RegisterNetEvent('esx:setJob', function(job)
            playerData.job = job
        end)

        Scully.Functions.ShowNotification = fw.ShowNotification

        function Scully.Functions.UpdateInfo(data)
            Scully.Radio[data.type] = data.value

            SetResourceKvp(playerData.identifier .. ':' .. data.type .. ':' .. Scully.KVPHandle, data.value)
            TriggerServerEvent('scully_radio:updateRadioInfo', data.type, data.value)
            Scully.Functions.ShowNotification(Scully.Language.UpdatedYour .. ' ' .. data.type .. ' ' .. Scully.Language.To .. ' ' .. data.value .. '!')
        end
    else
        CreateThread(function()
            Wait(500)
            TriggerServerEvent('scully_radio:getPermissions')
        end)

        RegisterNetEvent('scully_radio:sendPermissions', function(permissions)
            playerData.permissions = permissions
        end)

        RegisterNetEvent('playerSpawned', function()
            playerState:set('isLoggedIn', true, false)

            local callsign = GetResourceKvpString('radio:callsign:' .. Scully.KVPHandle)
            local radioName = GetResourceKvpString('radio:name:' .. Scully.KVPHandle)

            if callsign then
                TriggerServerEvent('scully_radio:updateRadioInfo', 'callsign', callsign)
            end

            if radioName then
                TriggerServerEvent('scully_radio:updateRadioInfo', 'name', radioName)
            end
        end)

        function Scully.Functions.ShowNotification(text)
            BeginTextCommandThefeedPost('STRING')
            AddTextComponentSubstringPlayerName(text)
            EndTextCommandThefeedPostTicker(true, true)
        end

        function Scully.Functions.UpdateInfo(data)
            Scully.Radio[data.type] = data.value

            SetResourceKvp('radio:' .. data.type .. ':' .. Scully.KVPHandle, data.value)
            TriggerServerEvent('scully_radio:updateRadioInfo', data.type, data.value)
            Scully.Functions.ShowNotification(Scully.Language.UpdatedYour .. ' ' .. data.type .. ' ' .. Scully.Language.To .. ' ' .. data.value .. '!')
        end
    end

    function Scully.Functions.HasAccess(channel)
        if not QBCore and not ESX then
            local isAllowed = false

            for permission, _ in pairs(Scully.WhitelistedAccess[channel]) do
                if playerData.permissions[permission] then
                    isAllowed = true
                end
            end

            return isAllowed
        end

        return Scully.WhitelistedAccess[channel][playerData.job.name]
    end

    function Scully.Functions.HasItem(cb)
        local hasRadioItem = false
        local checkItems = {'radio'}

        for i = 1, #Scully.RadioColours do
            local color = Scully.RadioColours[i]

            if color ~= 'default' then
                checkItems[#checkItems + 1] = 'radio_' .. color
            end
        end

        if ox_inventory then
            for i = 1, #checkItems do
                local count = ox_inventory:Search('count', checkItems[i])

                if count >= 1 then
                    hasRadioItem = true
                    break
                end
            end
        elseif qs_inventory then
            for i = 1, #checkItems do
                local count = qs_inventory:Search(checkItems[i])

                if count >= 1 then
                    hasRadioItem = true
                    break
                end
            end
        elseif qb_inventory then
            for i = 1, #checkItems do
                local hasItem = qb_inventory:HasItem(checkItems[i], 1)

                if hasItem then
                    hasRadioItem = true
                    break
                end
            end
        elseif ps_inventory then
            for i = 1, #checkItems do
                local hasItem = ps_inventory:HasItem(checkItems[i], 1)

                if hasItem then
                    hasRadioItem = true
                    break
                end
            end
        elseif codem_inventory then
            for i = 1, #checkItems do
                local hasItem = codem_inventory:HasItem(checkItems[i], 1)

                if hasItem then
                    hasRadioItem = true
                    break
                end
            end
        end

        if not Scully.UseItem then hasRadioItem = true end

        cb(hasRadioItem)
    end

    if Scully.UseItem and ox_inventory then
        exports('radio', function(data, slot)
            ox_inventory:useItem(data, function(data)
                if data then
                    TriggerEvent('scully_radio:openRadio', Scully.RadioColour)
                end
            end)
        end)

        if Scully.AllowColours and Scully.UseItemColours then
            for i = 1, #Scully.RadioColours do
                local color = Scully.RadioColours[i]

                if color ~= 'default' then
                    exports('radio_' .. color, function(data, slot)
                        ox_inventory:useItem(data, function(data)
                            if data then
                                TriggerEvent('scully_radio:openRadio', color)
                            end
                        end)
                    end)
                end
            end
        end
    end
end