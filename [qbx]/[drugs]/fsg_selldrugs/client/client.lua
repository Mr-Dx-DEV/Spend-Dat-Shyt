if GetResourceState('qbx_core') ~= 'started' then return end

npc = {}
cooldown = false
blips = {}

-- ==================== HELPER FUNCTIONS ====================
local function Draw3DText(coords, text, scale)
    local onScreen, _x, _y = World3dToScreen2d(coords.x, coords.y, coords.z)
    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

local function PlayAnim(dict, anim, speed, time, flag)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do Wait(0) end
    TaskPlayAnim(PlayerPedId(), dict, anim, speed, speed, time, flag, 1, false, false, false)
end

local function PlayAnimOnPed(ped, dict, anim, speed, time, flag)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do Wait(0) end
    TaskPlayAnim(ped, dict, anim, speed, speed, time, flag, 1, false, false, false)
end

local function MakeEntityFaceEntity(entity1, entity2)
    local p1 = GetEntityCoords(entity1, true)
    local p2 = GetEntityCoords(entity2, true)
    local dx = p2.x - p1.x
    local dy = p2.y - p1.y
    local heading = GetHeadingFromVector_2d(dx, dy)
    SetEntityHeading(entity1, heading)
end

-- ==================== MAIN SELL FUNCTION ====================
local function next_ped(drugToSell)
	if cooldown then
		lib.notify({
			title = Config.notify.title,
			description = Config.notify.cooldown,
			position = 'center-right',
			duration = 8000,
			icon = 'pills'
		})
		return
	end

	cooldown = true

	if Config.cityPoint ~= false and GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.cityPoint, true) > 1500.0 then
		lib.notify({
			title = Config.notify.title,
			description = Config.notify.toofar,
			position = 'center-right',
			duration = 8000,
			icon = 'pills'
		})
		cooldown = false
		return
	end

	if npc.ped then
		SetPedAsNoLongerNeeded(npc.ped)
	end

	local cops = 0
	lib.callback('fsg_selldrugs:getPoliceCount', false, function(_cops)
		cops = _cops
	end)

	Wait(500)

	if cops < Config.requiredCops then
		lib.notify({
			title = Config.notify.title,
			description = Config.notify.cops,
			position = 'center-right',
			duration = 8000,
			icon = 'pills'
		})
		cooldown = false
		return
	end

	-- Price multiplier based on cops
	if cops == 3 then
		drugToSell.price = math.floor(drugToSell.price * 1.05)
	elseif cops == 4 then
		drugToSell.price = math.floor(drugToSell.price * 1.07)
	elseif cops == 5 then
		drugToSell.price = math.floor(drugToSell.price * 1.10)
	elseif cops == 6 then
		drugToSell.price = math.floor(drugToSell.price * 1.15)
	elseif cops >= 7 then
		drugToSell.price = math.floor(drugToSell.price * 1.20)
	end

	TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_MOBILE", 0, true)
	setInvBusy(true)

	lib.notify({
		title = Config.notify.title,
		description = Config.notify.searching .. drugToSell.label,
		position = 'center-right',
		duration = 8000,
		icon = 'pills'
	})

	Wait(math.random(5000, 10000))
	ClearPedTasks(PlayerPedId())

	npc.hash = GetHashKey(Config.pedlist[math.random(1, #Config.pedlist)])
	lib.requestModel(npc.hash)

	npc.coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 50.0, 5.0)
	local retval, z = GetGroundZFor_3dCoord(npc.coords.x, npc.coords.y, npc.coords.z, false)

	if not retval then
		cooldown = false
		lib.notify({
			title = Config.notify.title,
			description = Config.notify.abort,
			position = 'center-right',
			duration = 8000,
			icon = 'pills'
		})
		setInvBusy(false)
		return
	end

	npc.coords = vector3(npc.coords.x, npc.coords.y, z)
	npc.zone = GetLabelText(GetNameOfZone(npc.coords))
	drugToSell.zone = npc.zone

	npc.ped = CreatePed(5, npc.hash, npc.coords.x, npc.coords.y, npc.coords.z, 0.0, true, true)
	PlaceObjectOnGroundProperly(npc.ped)
	SetEntityAsMissionEntity(npc.ped)

	if GetResourceState('ps-dispatch') == 'started' then
		local pCoords = GetEntityCoords(PlayerPedId())
		local zone    = GetLabelText(GetNameOfZone(pCoords.x, pCoords.y, pCoords.z))
		local street  = GetStreetNameFromHashKey(GetStreetNameAtCoord(pCoords.x, pCoords.y, pCoords.z))
		TriggerServerEvent('ps-dispatch:server:notify', {
			message  = 'Drug Deal in Progress',
			codeName = 'fsg_selldrugs',
			code     = '10-13',
			icon     = 'fas fa-pills',
			priority = 2,
			coords   = pCoords,
			street   = street .. ', ' .. zone,
			jobs     = { 'leo' },
		})
	end

	if IsEntityDead(npc.ped) or GetEntityCoords(npc.ped) == vector3(0.0, 0.0, 0.0) then
		lib.notify({
			title = Config.notify.title,
			description = Config.notify.notfound,
			position = 'center-right',
			duration = 8000,
			icon = 'pills'
		})
		setInvBusy(false)
		return
	end

	lib.notify({
		title = Config.notify.title,
		description = Config.notify.approach .. '\n' .. Config.notify.found .. npc.zone,
		position = 'center-right',
		duration = 8000,
		icon = 'pills'
	})

	TaskGoToEntity(npc.ped, PlayerPedId(), 60000, 4.0, 2.0, 0, 0)

	CreateThread(function()
		local canSell = true
		while npc.ped and npc.ped ~= 0 and not IsEntityDead(npc.ped) do
			Wait(0)
			local npcCoords = GetEntityCoords(npc.ped)

			Draw3DText(npcCoords, (Config.notify.client):format(drugToSell.count, drugToSell.label), 0.5)

			local distance = Vdist2(GetEntityCoords(PlayerPedId()), npcCoords)

			if distance >= 2.5 then
				if (IsControlJustPressed(0, 49) or IsControlJustPressed(0, 73)) and canSell then
					canSell = false
					lib.hideTextUI()
					lib.notify({
						title = Config.notify.title,
						description = Config.notify.cancelsell,
						position = 'center-right',
						duration = 8000,
						icon = 'pills',
						iconColor = '#EE4B2B'
					})
					setInvBusy(false)
					SetPedAsNoLongerNeeded(npc.ped)
					npc = {}
					return
				end
			end

			if distance < 2.0 then
				lib.showTextUI('[E] - Sell Drugs to Local', {
					position = "right-center",
					icon = 'pills',
				})

				if (IsControlJustPressed(0, 49) or IsControlJustPressed(0, 73)) and canSell then
					canSell = false
					lib.hideTextUI()
					lib.notify({
						title = Config.notify.title,
						description = Config.notify.cancelsell,
						position = 'center-right',
						duration = 8000,
						icon = 'pills',
						iconColor = '#EE4B2B'
					})
					setInvBusy(false)
					SetPedAsNoLongerNeeded(npc.ped)
					npc = {}
					return
				elseif IsControlJustPressed(0, 38) and canSell then
					canSell = false
					lib.hideTextUI()
					setInvBusy(false)

					local reject = math.random(1, 6)
					if reject <= 3 then
						lib.notify({
							title = Config.notify.title,
							description = Config.notify.reject,
							position = 'center-right',
							duration = 8000,
							icon = 'pills',
							iconColor = '#EE4B2B'
						})
						PlayAmbientSpeech1(npc.ped, 'GENERIC_HI', 'SPEECH_PARAMS_STANDARD')
						drugToSell.coords = GetEntityCoords(PlayerPedId())
						TriggerServerEvent('stasiek_selldrugsv2:notifycops', drugToSell)
						if Config.npcFightOnReject then
							TaskCombatPed(npc.ped, PlayerPedId(), 0, 16)
						end
						SetPedAsNoLongerNeeded(npc.ped)
						npc = {}
						return
					end

					if IsPedInAnyVehicle(PlayerPedId(), false) then
						lib.notify({
							title = Config.notify.title,
							description = Config.notify.vehicle,
							position = 'center-right',
							duration = 8000,
							icon = 'pills'
						})
						return
					end

					MakeEntityFaceEntity(PlayerPedId(), npc.ped)
					MakeEntityFaceEntity(npc.ped, PlayerPedId())
					SetPedTalk(npc.ped)
					PlayAmbientSpeech1(npc.ped, 'GENERIC_HI', 'SPEECH_PARAMS_STANDARD')

					local obj = CreateObject(GetHashKey('prop_weed_bottle'), 0, 0, 0, true)
					local obj2 = CreateObject(GetHashKey('hei_prop_heist_cash_pile'), 0, 0, 0, true)

					AttachEntityToEntity(obj, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.13, 0.02, 0.0, -90.0, 0, 0, 1, 1, 0, 1, 0, 1)
					AttachEntityToEntity(obj2, npc.ped, GetPedBoneIndex(npc.ped, 57005), 0.13, 0.02, 0.0, -90.0, 0, 0, 1, 1, 0, 1, 0, 1)

					PlayAnim('mp_common', 'givetake1_a', 8.0, -1, 0)
					PlayAnimOnPed(npc.ped, 'mp_common', 'givetake1_a', 8.0, -1, 0)

					Wait(1000)

					AttachEntityToEntity(obj2, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.13, 0.02, 0.0, -90.0, 0, 0, 1, 1, 0, 1, 0, 1)
					AttachEntityToEntity(obj, npc.ped, GetPedBoneIndex(npc.ped, 57005), 0.13, 0.02, 0.0, -90.0, 0, 0, 1, 1, 0, 1, 0, 1)

					Wait(1000)

					DeleteEntity(obj)
					DeleteEntity(obj2)

					PlayAmbientSpeech1(npc.ped, 'GENERIC_THANKS', 'SPEECH_PARAMS_STANDARD')
					SetPedAsNoLongerNeeded(npc.ped)

					TriggerServerEvent('stasiek_selldrugsv2:pay', drugToSell)

					lib.notify({
						title = Config.notify.title,
						description = (Config.notify.sold):format(drugToSell.count, drugToSell.label, drugToSell.price),
						position = 'center-right',
						duration = 8000,
						icon = 'pills'
					})

					npc = {}
					break
				end
			end
		end
	end)
end

-- Cooldown reset thread
CreateThread(function()
	while true do
		Wait(20000)
		if cooldown then
			cooldown = false
		end
	end
end)

RegisterNetEvent('stasiek_selldrugsv2:findClient')
AddEventHandler('stasiek_selldrugsv2:findClient', next_ped)

RegisterNetEvent('stasiek_selldrugsv2:notifyPolice')
AddEventHandler('stasiek_selldrugsv2:notifyPolice', function(coords)
	if GetPlayerData().job and GetPlayerData().job.name == 'police' then
		local street = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
		local street2 = GetStreetNameFromHashKey(street)
		lib.notify({
			title = Config.notify.police_notify_title,
			description = Config.notify.police_notify_subtitle .. ' on ' .. street2,
			duration = 8000,
			icon = 'pills'
		})
		PlaySoundFrontend(-1, "Bomb_Disarmed", "GTAO_Speed_Convoy_Soundset", 0)

		local blip = AddBlipForCoord(coords)
		SetBlipSprite(blip, 403)
		SetBlipColour(blip, 1)
		SetBlipAlpha(blip, 250)
		SetBlipScale(blip, 0.5)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('# Selling Drugs')
		EndTextCommandSetBlipName(blip)
		table.insert(blips, blip)

		Wait(50000)
		for i in pairs(blips) do
			RemoveBlip(blips[i])
			blips[i] = nil
		end
	end
end)
