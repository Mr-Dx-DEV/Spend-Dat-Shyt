local config = require 'config.shared'
PlayerLoaded, firstime = nil, false

function DebugMode(...) -- dont touch
    if config.debug.enable then
        print(...)
    end
end

-- Get framework
if config.framework == 'esx' then
    ESX = exports['es_extended']:getSharedObject()
    --old shit esx
    --[[
    ESX = nil
    CreateThread(function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Wait(1)
        end
    end)
    ]]

    RegisterNetEvent('esx:playerLoaded', function(xPlayer)
        --[[ -- some old shit
        while not ESX.PlayerLoaded do
            Wait(1000)
        end
        ]]
        Wait(5000) -- wait time just in case player not loading

        PlayerLoaded = true
           
        if not firsttime then -- make sure run only 1x time cuz esx trigger playerloaded for revive
            UpdateData()
            firsttime = true
        end
    end)

    RegisterNetEvent('esx:onPlayerLogout', function()
        PlayerLoaded = false
    end)

    AddEventHandler('onResourceStart', function(resourceName)
        if GetCurrentResourceName() ~= resourceName or not ESX.PlayerLoaded then
            return
        end
        PlayerLoaded = true
        UpdateData()
    end)

elseif config.framework == 'qb' then
    QBCore = exports['qb-core']:GetCoreObject()
    --PlayerData = QBCore.Functions.GetPlayerData()

    RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
        Wait(5000) -- wait time just in case player not loading
        PlayerLoaded = true
        UpdateData()
    end)

    -- qb
    RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
        PlayerLoaded = false
    end)

    -- qbox not available at the moment
    --RegisterNetEvent('qbx_core:client:playerLoggedOut', function() 
    --    PlayerLoaded = false
    --end)

    AddEventHandler('onResourceStart', function(resourceName)
        if GetCurrentResourceName() ~= resourceName or not LocalPlayer.state.isLoggedIn then
            return
        end
        PlayerLoaded = true
        UpdateData()
    end)
elseif config.framework == 'custom' then
    -- Your custom framework here
    return
end

-- return dead function 
--qb
function isDead()
	if LocalPlayer.state.isDead then
		return true
	elseif IsPlayerDead(PlayerId()) then
		return true
	elseif exports.wasabi_ambulance_v2:isPlayerDead() then
		return true
	end
	return false
end

--esx
--[[
local IsDead = false

AddEventHandler('esx:onPlayerDeath', function(data)
    IsDead = true
end)

AddEventHandler('esx:playerLoaded', function(spawn)
    IsDead = false
end)

function isDead()
	return IsDead
end
]]

-- return target function 
function Target()
    if config.target == 'qtarget' then
        exports['qtarget']:AddTargetModel(config.bed, {
            options =
            {
                {
                    event = 'SOS:sleeping',
                    icon = config.sos.icontargetsleep,
                    label = locale('uisleep'),
                },
                {
                    event = 'SOS:havesex',
                    icon = config.sos.icontargetsex,
                    label = locale('uisex'),
                },
            },
            distance = config.sos.distancebed
        })
    elseif config.target == 'qb-target' then
        exports['qtarget']:AddTargetModel(config.bed, {
            options = 
            {
                {
                    event = 'SOS:sleeping',
                    icon = config.sos.icontargetsleep,
                    label = locale('uisleep'),
                },
                {
                    event = 'SOS:havesex',
                    icon = config.sos.icontargetsex,
                    label = locale('uisex'),
                },
            },
            distance = config.sos.distancebed
        })
    elseif config.target == 'ox_target' then
        exports.ox_target:addModel(config.bed, {
            {
                distance = config.sos.distancebed,
                event = 'SOS:sleeping',
                icon = config.sos.icontargetsleep,
                label = locale('uisleep'),
            },
            {
                distance = config.sos.distancebed,
                event = 'SOS:havesex',
                icon = config.sos.icontargetsex,
                label = locale('uisex'),
            },
        })
    else
        -- Your custom target here
        return
    end
end

-- return show text ui
function ShowTextUI(message)
    return lib.showTextUI(message)
end

-- return hide text ui
function HideTextUI()
    return lib.hideTextUI()
end

-- show notification
function ShowNotification(message)
    if config.notification == 'esx' then
        ESX.ShowNotification(message)
    elseif config.notification == 'qb' then
        QBCore.Functions.Notify(message)
    elseif config.notification == 'ox' then
        lib.notify({
            title = 'Bed',
            description = message,
            --icon = '',
            type = 'info',
            --position = ''
        })
    elseif config.notification == 'custom' then
        -- your custom notification here
    end
end

-- return minigame
function MinigameCum()
    local success = lib.skillCheck({'easy', 'easy', 'medium'})
    return success
end

function HelpText(text, sound) -- dont touch
    AddTextEntry(GetCurrentResourceName(), text)
    BeginTextCommandDisplayHelp(GetCurrentResourceName())
    EndTextCommandDisplayHelp(0, 0, (sound == true), -1)
end

-- Trigger notification from server to client
AddEventHandler('SOS:ShowNotification', function(text)
    ShowNotification(text)
end)