local config = require 'config.shared'

-- reduce hunger and thirst after sleep
function ReduceHungerAndThirstSleep()
    if not config.sos.decreasehungerandthirstsleep then return end

    if config.framework == 'esx' then
        TriggerEvent('esx_status:remove', 'hunger', 100)
        TriggerEvent('esx_status:remove', 'thirst', 100)
    elseif config.framework == 'qb' then
        local PlayerData = QBCore.Functions.GetPlayerData()
        TriggerServerEvent('consumables:server:addHunger', PlayerData.metadata.hunger + config.sos.hungervaluesleep)
        TriggerServerEvent('consumables:server:addThirst', PlayerData.metadata.thirst + config.sos.thirstvaluesleep)
        
        --TriggerEvent('esx_status:remove', 'hunger', 100)
        --TriggerEvent('esx_status:remove', 'thirst', 100)
    elseif config.framework == 'custom' then
        -- Your custom hunger here
    end
	ShowNotification(locale('wakeup'))
end

-- reduce hunger and thirst after sex
function ReduceHungerAndThirstSex()
    if not config.sos.decreasehungerandthirstsex then return end

    if config.framework == 'esx' then
        TriggerEvent('esx_status:remove', 'hunger', 100)
        TriggerEvent('esx_status:remove', 'thirst', 100)
    elseif config.framework == 'qb' then
        local PlayerData = QBCore.Functions.GetPlayerData()
        TriggerServerEvent('consumables:server:addHunger', PlayerData.metadata.hunger + config.sos.hungervaluesex)
        TriggerServerEvent('consumables:server:addThirst', PlayerData.metadata.thirst + config.sos.thirstvaluesex)
        
        --TriggerEvent('esx_status:remove', 'hunger', 100)
        --TriggerEvent('esx_status:remove', 'thirst', 100)
    elseif config.framework == 'custom' then
        -- Your custom hunger here
    end
	ShowNotification(locale('wakeup'))
end

-- reduce stress after sleep
function ReduceStressSleep()
    if not config.sos.decreasestresssleep then return end

    if config.framework == 'esx' then
        TriggerServerEvent('stress:remove', config.sos.stressvaluesleep)
    elseif config.framework == 'qb' then
        TriggerServerEvent('hud:server:RelieveStress', config.sos.stressvaluesleep)
    elseif config.framework == 'custom' then
        -- Your custom hunger here
    end
end

-- reduce stress after sex
function ReduceStressSex()
    if not config.sos.decreasestresssex then return end

    if config.framework == 'esx' then
        TriggerServerEvent('stress:remove', config.sos.stressvaluesex)
    elseif config.framework == 'qb' then
        TriggerServerEvent('hud:server:RelieveStress', config.sos.stressvaluesex)
    elseif config.framework == 'custom' then
        -- Your custom hunger here
    end
end

-- change pregnant outfit, read https://docs.fivem.net/natives/?_0x262B14F48D29DE80
function StandaloneFemalePregnantPeds()
    local mymodel = GetEntityModel(cache.ped)
    if mymodel == `` then --custom ped female
        SetPedComponentVariation(cache.ped, 3, 7, 0, 0)--arms
		SetPedComponentVariation(cache.ped, 4, 60, 1, 0)--pants
		SetPedComponentVariation(cache.ped, 6, 16, 0, 0)--shoes
		SetPedComponentVariation(cache.ped, 11, 109, 1, 0)--torso
		SetPedComponentVariation(cache.ped, 8, 14, 0, 0)--tshirt
    elseif mymodel == `` then --custom ped female
        SetPedComponentVariation(cache.ped, 3, 7, 0, 0)--arms
		SetPedComponentVariation(cache.ped, 4, 60, 1, 0)--pants
		SetPedComponentVariation(cache.ped, 6, 16, 0, 0)--shoes
		SetPedComponentVariation(cache.ped, 11, 109, 1, 0)--torso
		SetPedComponentVariation(cache.ped, 8, 14, 0, 0)--tshirt
    else --not custom ped female
        SetPedComponentVariation(cache.ped, 3, 7, 0, 0)--arms
		SetPedComponentVariation(cache.ped, 4, 60, 1, 0)--pants
		SetPedComponentVariation(cache.ped, 6, 16, 0, 0)--shoes
		SetPedComponentVariation(cache.ped, 11, 109, 1, 0)--torso
		SetPedComponentVariation(cache.ped, 8, 14, 0, 0)--tshirt

		-- or your custom exports
    end
end

-- change pajama outfit for female, read https://docs.fivem.net/natives/?_0x262B14F48D29DE80
function StandaloneFemalePeds()
	local mymodel = GetEntityModel(cache.ped)
    if mymodel == `` then --custom ped female
        SetPedComponentVariation(cache.ped, 3, 7, 0, 0)--arms
		SetPedComponentVariation(cache.ped, 4, 60, 1, 0)--pants
		SetPedComponentVariation(cache.ped, 6, 16, 0, 0)--shoes
		SetPedComponentVariation(cache.ped, 11, 109, 1, 0)--torso
		SetPedComponentVariation(cache.ped, 8, 14, 0, 0)--tshirt
    elseif mymodel == `` then --custom ped female
        SetPedComponentVariation(cache.ped, 3, 7, 0, 0)--arms
		SetPedComponentVariation(cache.ped, 4, 60, 1, 0)--pants
		SetPedComponentVariation(cache.ped, 6, 16, 0, 0)--shoes
		SetPedComponentVariation(cache.ped, 11, 109, 1, 0)--torso
		SetPedComponentVariation(cache.ped, 8, 14, 0, 0)--tshirt
    else --not custom ped female
        SetPedComponentVariation(cache.ped, 3, 7, 0, 0)--arms
		SetPedComponentVariation(cache.ped, 4, 60, 1, 0)--pants
		SetPedComponentVariation(cache.ped, 6, 16, 0, 0)--shoes
		SetPedComponentVariation(cache.ped, 11, 109, 1, 0)--torso
		SetPedComponentVariation(cache.ped, 8, 14, 0, 0)--tshirt

		-- or your custom exports
    end
end

-- change pajama outfit for male, read https://docs.fivem.net/natives/?_0x262B14F48D29DE80
function StandaloneMalePeds()
	local mymodel = GetEntityModel(cache.ped)
    if mymodel == `` then --custom ped male
        SetPedComponentVariation(cache.ped, 3, 6, 0, 0)--arms
		SetPedComponentVariation(cache.ped, 4, 58, 1, 0)--pants
		SetPedComponentVariation(cache.ped, 6, 5, 2, 0)--shoes
		SetPedComponentVariation(cache.ped, 11, 117, 1, 0)--torso
		SetPedComponentVariation(cache.ped, 8, 15, 0, 0)--tshirt
    elseif mymodel == `` then --custom ped male
        SetPedComponentVariation(cache.ped, 3, 6, 0, 0)--arms
		SetPedComponentVariation(cache.ped, 4, 58, 1, 0)--pants
		SetPedComponentVariation(cache.ped, 6, 5, 2, 0)--shoes
		SetPedComponentVariation(cache.ped, 11, 117, 1, 0)--torso
		SetPedComponentVariation(cache.ped, 8, 15, 0, 0)--tshirt
    else --not custom ped male
		SetPedComponentVariation(cache.ped, 3, 6, 0, 0)--arms
		SetPedComponentVariation(cache.ped, 4, 58, 1, 0)--pants
		SetPedComponentVariation(cache.ped, 6, 5, 2, 0)--shoes
		SetPedComponentVariation(cache.ped, 11, 117, 1, 0)--torso
		SetPedComponentVariation(cache.ped, 8, 15, 0, 0)--tshirt

		-- or your custom exports
    end
end

-- change naked outfit for female, read https://docs.fivem.net/natives/?_0x262B14F48D29DE80
function StandaloneNakedFemalePeds()
	local mymodel = GetEntityModel(cache.ped)
    if mymodel == `` then --custom ped female
        SetPedComponentVariation(cache.ped, 3, 15, 0, 0)--arms
		SetPedComponentVariation(cache.ped, 4, 15, 0, 0)--pants
		SetPedComponentVariation(cache.ped, 6, 35, 0, 0)--shoes
		SetPedComponentVariation(cache.ped, 11, 15, 1, 0)--torso
		SetPedComponentVariation(cache.ped, 8, 15, 0, 0)--tshirt
    elseif mymodel == `` then --custom ped female
        SetPedComponentVariation(cache.ped, 3, 15, 0, 0)--arms
		SetPedComponentVariation(cache.ped, 4, 15, 0, 0)--pants
		SetPedComponentVariation(cache.ped, 6, 35, 0, 0)--shoes
		SetPedComponentVariation(cache.ped, 11, 15, 1, 0)--torso
		SetPedComponentVariation(cache.ped, 8, 15, 0, 0)--tshirt
    else --not custom ped female
        SetPedComponentVariation(cache.ped, 3, 15, 0, 0)--arms
		SetPedComponentVariation(cache.ped, 4, 15, 0, 0)--pants
		SetPedComponentVariation(cache.ped, 6, 35, 0, 0)--shoes
		SetPedComponentVariation(cache.ped, 11, 15, 1, 0)--torso
		SetPedComponentVariation(cache.ped, 8, 15, 0, 0)--tshirt

		-- or your custom exports
    end
end

-- change naked outfit for male, read https://docs.fivem.net/natives/?_0x262B14F48D29DE80
function StandaloneNakedMalePeds()
	local mymodel = GetEntityModel(cache.ped)
    if mymodel == `` then --custom ped male
        SetPedComponentVariation(cache.ped, 3, 15, 0, 0)--arms
		SetPedComponentVariation(cache.ped, 4, 61, 0, 0)--pants
		SetPedComponentVariation(cache.ped, 6, 34, 2, 0)--shoes
		SetPedComponentVariation(cache.ped, 11, 15, 1, 0)--torso
		SetPedComponentVariation(cache.ped, 8, 15, 0, 0)--tshirt
    elseif mymodel == `` then --custom ped male
        SetPedComponentVariation(cache.ped, 3, 15, 0, 0)--arms
		SetPedComponentVariation(cache.ped, 4, 61, 0, 0)--pants
		SetPedComponentVariation(cache.ped, 6, 34, 2, 0)--shoes
		SetPedComponentVariation(cache.ped, 11, 15, 1, 0)--torso
		SetPedComponentVariation(cache.ped, 8, 15, 0, 0)--tshirt
    else --not custom ped male
        SetPedComponentVariation(cache.ped, 3, 15, 0, 0)--arms
		SetPedComponentVariation(cache.ped, 4, 61, 0, 0)--pants
		SetPedComponentVariation(cache.ped, 6, 34, 2, 0)--shoes
		SetPedComponentVariation(cache.ped, 11, 15, 1, 0)--torso
		SetPedComponentVariation(cache.ped, 8, 15, 0, 0)--tshirt

		-- or your custom exports
    end
end

function ResetMalePeds()
	if config.appearance.script == 'skinchanger' then
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        	TriggerEvent('skinchanger:loadSkin', skin)
        end)
    else
        ExecuteCommand('reloadskin')

		-- or your custom exports
    end
end

function ResetFemalePeds()
    if config.appearance.script == 'skinchanger' then
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        	TriggerEvent('skinchanger:loadSkin', skin)
        end)
    else
        ExecuteCommand('reloadskin')

		-- or your custom exports
    end
end

-- chance logic
function PregnantChance()
    return math.random(1, 100) < 10
end

function ChildBirthChance()
    return math.random(1, 100) < 2
end

function HepatitisChance()
    return math.random(1, 100) < 10
end

function HivChance()
    return math.random(1, 100) < 40
end

function MonkeyPoxChance()
    return math.random(1, 100) < 60
end

-- disease effect
RegisterNetEvent('SOS:diseasefirsteffect')
AddEventHandler('SOS:diseasefirsteffect', function()
	CreateThread(function()
		local playerPed = cache.ped
		lib.requestAnimSet('anim_group_move_ballistic')
      	SetPedMovementClipset(playerPed, 'anim_group_move_ballistic', true)
	  	Wait(500)
	  	ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 3.0)
	  	DoScreenFadeIn(500)
	  	Wait(500)
	  	Wait(500)
	  	ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 3.0)
	  	DoScreenFadeIn(500)
	  	Wait(500)
	  	SetTimecycleModifier('StuntSlowDark')
      	SetPedMotionBlur(playerPed, true)
      	SetPedIsDrunk(playerPed, true)
        Wait(10000)
        RemoveAnimSet('anim_group_move_ballistic')
        ClearTimecycleModifier()
        ResetScenarioTypesEnabled()
        ResetPedMovementClipset(playerPed, 0)
        SetPedIsDrunk(playerPed, false)
        SetPedMotionBlur(playerPed, false)
	end)
end)

-- disease medicine
RegisterNetEvent('SOS:hepatitis_cured')
AddEventHandler('SOS:hepatitis_cured', function(itemName)
  	local playerPed  = cache.ped
	lib.requestAnimDict('mp_suicide')
  	lib.playAnim(playerPed, 'mp_suicide', 'pill_fp', 8.0, 8.0, -1, 50, 0, false, false, false)
  	Wait(3000)
	RemoveAnimDict('mp_suicide')
  	ClearPedTasks(playerPed)
	TriggerServerEvent('SOS:server:removeitem', itemName)
  	if LocalPlayer.state.diseasesex ~= 'hepatitis' then
        -- do something bad like this
	  	local maxHealth = GetEntityMaxHealth(playerPed)
	  	local health = GetEntityHealth(playerPed)
	  	local newHealth = math.min(maxHealth , math.floor(health - 5))
        SetEntityHealth(playerPed, newHealth)
    else
		local updatedisease = lib.callback.await('SOS:updatedisease', false, 'cured')
		if updatedisease then
       		LocalPlayer.state:set('diseasesex', false)
		end
    end
end)

RegisterNetEvent('SOS:hiv_cured')
AddEventHandler('SOS:hiv_cured', function(itemName)
  	local playerPed  = cache.ped
	lib.requestAnimDict('mp_suicide')
  	lib.playAnim(playerPed, 'mp_suicide', 'pill_fp', 8.0, 8.0, -1, 50, 0, false, false, false)
  	Wait(3000)
	RemoveAnimDict('mp_suicide')
	TriggerServerEvent('SOS:server:removeitem', itemName)
  	ClearPedTasks(playerPed)
    if LocalPlayer.state.diseasesex ~= 'hiv' then
        -- do something bad like this
	  	local maxHealth = GetEntityMaxHealth(playerPed)
	  	local health = GetEntityHealth(playerPed)
	  	local newHealth = math.min(maxHealth , math.floor(health - 5))
        SetEntityHealth(playerPed, newHealth)
    else
        local updatedisease = lib.callback.await('SOS:updatedisease', false, 'cured')
		if updatedisease then
			LocalPlayer.state:set('diseasesex', false)
	 	end
    end
end)

RegisterNetEvent('SOS:monkeypox_cured')
AddEventHandler('SOS:monkeypox_cured', function(itemName)
  	local playerPed  = cache.ped
	lib.requestAnimDict('mp_suicide')
  	lib.playAnim(playerPed, 'mp_suicide', 'pill_fp', 8.0, 8.0, -1, 50, 0, false, false, false)
  	Wait(3000)
	RemoveAnimDict('mp_suicide')
	TriggerServerEvent('SOS:server:removeitem', itemName)
  	ClearPedTasks(playerPed)
    if LocalPlayer.state.diseasesex ~= 'monkeypox' then
        -- do something bad like this
	  	local maxHealth = GetEntityMaxHealth(playerPed)
	  	local health = GetEntityHealth(playerPed)
	  	local newHealth = math.min(maxHealth , math.floor(health - 5))
        SetEntityHealth(playerPed, newHealth)
    else
        local updatedisease = lib.callback.await('SOS:updatedisease', false, 'cured')
        if updatedisease then
			LocalPlayer.state:set('diseasesex', false)
	 	end
    end
end)

-- disease thread
CreateThread(function()
	while true do
		local secondsBetweenAnim = math.random(50000, 100000)

	  	Wait(secondsBetweenAnim)
		
	  	if not isDead() and not IsPedSwimming(cache.ped) and not IsPedSwimmingUnderWater(cache.ped) and not IsPedInAnyVehicle(cache.ped, true) and LocalPlayer.state.diseasesex then
			DebugMode('Playing HIV Animation')
			lib.requestAnimDict('oddjobs@taxi@tie')
			lib.playAnim(cache.ped, 'oddjobs@taxi@tie', 'vomit_outside', 8.0, 8.0, -1, 50, 0, false, false, false)
			Wait(7000)
			RemoveAnimDict('oddjobs@taxi@tie')
			ClearPedTasks(cache.ped)
			--Some Effect after animation
			local maxHealth = GetEntityMaxHealth(cache.ped)
			local health = GetEntityHealth(cache.ped)
			local newHealth = math.min(maxHealth, math.floor(health - 5))
			SetEntityHealth(cache.ped, newHealth)
			ShowNotification(locale('get_disease'))
	  	end
	end
end)

-- shower
if config.shower.enable then
	RegisterCommand(config.shower.command, function(source, args, raw)
		local playerPed = cache.ped
		local coords = GetEntityCoords(playerPed)
		if config.appearance.enable then
            if config.appearance.script == 'skinchanger' then
				TriggerEvent('skinchanger:getSkin', function(skin)
					if skin.sex == 0 then
						TriggerEvent('skinchanger:loadClothes', skin, config.appearance.skinchanger.pajama.male)
					else
						TriggerEvent('skinchanger:loadClothes', skin, config.appearance.skinchanger.pajama.female)
					end
				end)
			else
				if IsPlayerFemale() then
					StandaloneNakedFemalePeds()
				else
					StandaloneNakedMalePeds()
				end
			end
		end

		shower = true
		FreezeEntityPosition(playerPed, true)
		if not HasNamedPtfxAssetLoaded('core') then
			RequestNamedPtfxAsset('core')
			while not HasNamedPtfxAssetLoaded('core') do
				Wait(1)
			end
		end

		lib.requestAnimDict('mp_safehouseshower@male@')
		lib.playAnim(playerPed, 'mp_safehouseshower@male@', 'male_shower_idle_a', 1.0, 4.0, -1, 0, 0, false, false, false)
		RemoveAnimDict('mp_safehouseshower@male@')
		UseParticleFxAssetNextCall('core')
		particles = StartNetworkedParticleFxNonLoopedAtCoord('ent_sht_water', coords.x, coords.y, coords.z +1.4, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
		UseParticleFxAssetNextCall('core')
		Wait(3000)
		particles2 = StartNetworkedParticleFxNonLoopedAtCoord('ent_sht_water', coords.x, coords.y, coords.z +1.4, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
		UseParticleFxAssetNextCall('core')
		Wait(3000)
		particles3 = StartNetworkedParticleFxNonLoopedAtCoord('ent_sht_water', coords.x, coords.y, coords.z +1.4, 0.0, 0.0, 0.0, 1.0, false, false, false, false) 
		UseParticleFxAssetNextCall('core')
		Wait(3000)
		lib.playAnim(playerPed, 'mp_safehouseshower@male@', 'male_shower_idle_a', 1.0, 4.0, -1, 0, 0, false, false, false)
		particles4 = StartNetworkedParticleFxNonLoopedAtCoord('ent_sht_water', coords.x, coords.y, coords.z +1.4, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
		UseParticleFxAssetNextCall('core')
		Wait(3000)
		particles5 = StartNetworkedParticleFxNonLoopedAtCoord('ent_sht_water', coords.x, coords.y, coords.z +1.4, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
		timer = 8
		activeshower = true

		CreateThread(function()
			while activeshower do
				Wait(1000)
				if(timer > 0)then
					timer = timer - 1
				elseif (timer == 0) then
					shower = false
					FreezeEntityPosition(playerPed, false)
					ShowNotification(locale('shower_done'))
					if config.shower.health then
						local health = GetEntityHealth(playerPed)
						local maxHealth = GetEntityMaxHealth(playerPed)
						local newHealth = math.min(maxHealth, math.floor(health + config.shower.healthvalue))
						SetEntityHealth(playerPed, newHealth)
					end
					if config.shower.armor then
						AddArmourToPed(playerPed, config.shower.armorvalue)
					end
					ClearPedTasks(playerPed)
					ClearPedBloodDamage(playerPed)
					if config.appearance.enable then
						lib.requestAnimDict('clothingtrousers')
						lib.playAnim(playerPed, 'clothingtrousers', 'try_trousers_neutral_c', 8.0, -8.0, -1, 0, 0.0, false, false, false)
						Wait(3000)
						RemoveAnimDict('clothingtrousers')
						if config.appearance.script == 'skinchanger' then
							ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
								TriggerEvent('skinchanger:loadSkin', skin)
							end)
						else
							if IsPlayerFemale() then
								ResetFemalePeds()
							else
								ResetMalePeds()
							end
						end
					end
					StopParticleFxLooped(particles, 0)
					StopParticleFxLooped(particles2, 0)
					StopParticleFxLooped(particles3, 0)
					StopParticleFxLooped(particles4, 0)
					activeshower = false
				end
			end
		end)
	end, false)
end