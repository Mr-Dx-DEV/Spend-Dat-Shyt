--[[ =============================================================================

		Project: "Enhanced Native Driveby Animations (ENDA)" v2.1.5
		Copyright � 2020-2025 Delta District (DeltaDistrict.com)

]]-- =============================================================================

-- FRAMEWORK BRIDGE FOR CHECKING & UPDATING PLAYER JOB
if CONFIG.framework == 'esx' then 
	-- ESX FRAMEWORK
	local ESX = exports['es_extended']:getSharedObject()
	Citizen.CreateThread(function()
		while not ESX do ESX = exports['es_extended']:getSharedObject() Citizen.Wait(250) end
	end)
	local playerData = ESX.GetPlayerData() 
	if playerData.job~=nil and playerData.job.name~=nil then TriggerEvent("ENDA:UpdateJob", playerData.job.name) end
	
	RegisterNetEvent('esx:setJob')
	AddEventHandler('esx:setJob', function(job)
		TriggerEvent("ENDA:UpdateJob", job.name)
	end)
	
elseif CONFIG.framework == 'qbcore' or CONFIG.framework == 'qbox' then 
	-- QBCORE & QBOX FRAMEWORK
	local QBCore = exports['qb-core']:GetCoreObject()
	Citizen.CreateThread(function()
		while not QBCore do QBCore = exports['qb-core']:GetCoreObject() Citizen.Wait(250) end
	end)
	local playerData = QBCore.Functions.GetPlayerData()
	if playerData.job~=nil and playerData.job.name~=nil then TriggerEvent("ENDA:UpdateJob", playerData.job.name) end
	
	RegisterNetEvent('QBCore:Client:OnJobUpdate')
	AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
		TriggerEvent("ENDA:UpdateJob", job.name)
	end)
  
elseif CONFIG.framework == 'vrp' then 
	-- vRP FRAMEWORK
	local Tunnel = module('vrp','lib/Tunnel')
	local Proxy  = module('vrp','lib/Proxy')
	local vRP    = Proxy.getInterface('vRP')
	Citizen.CreateThread(function()
		local user_id, job, previousJob = nil, nil, nil
		while true do
			user_id = vRP.getUserId({PlayerPedId()})
			job = vRP.getUserGroupByType({user_id, "job"})
			if job~=nil and job~=previousJob then
				TriggerEvent("ENDA:UpdateJob", job) previousJob=job
			end
			Citizen.Wait(5000) -- Checks every 5 seconds (Adjust to preference)
		end
	end)

elseif CONFIG.framework == 'custom' then
	-- Add you own custom code to get player job name
	TriggerEvent("ENDA:UpdateJob", 'job_name')
end



-- BRIDGE FOR DEFAULT & CUSTOM NOTIFICATIONS
function DisplayNotification(text)
	if CONFIG.useDefaultTipForNotifications then -- DEFAULT GTA TIP (UPPER LEFT CORNER)
		BeginTextCommandDisplayHelp("STRING")
		AddTextComponentSubstringPlayerName(text)
		EndTextCommandDisplayHelp(false, false, true, -1)
	else
		-- ADD YOUR NOTIFICATION CODE HERE
		
		-- OX_LIB EXAMPLE
		-- lib.notify({ title = 'Enhanced Driveby', description = text, type = 'inform' })
	end
end