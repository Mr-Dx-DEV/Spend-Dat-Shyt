local prevHour, prevMinute, prevSecond = nil, nil, nil
local prevWeather = nil

function SyncWeather()
	local syncweather = false
	if Config.WeatherSystem == "cd_easytime" then
		syncweather = false
	end
	return syncweather
end

function EnterPropertySettings(properytype)
	if properytype == "SHELL" then
		if Config.WeatherSystem == "cd_easytime" then
			TriggerEvent('cd_easytime:PauseSync', true, 2)
		elseif Config.WeatherSystem == "vSync" then
			TriggerEvent('vSync:toggle', true)
			TriggerEvent('vSync:updateWeather', 'EXTRASUNNY', false)
		elseif Config.WeatherSystem == "qb-weathersync" then
			TriggerEvent('qb-weathersync:client:DisableSync')
		elseif Config.WeatherSystem == "cs_weather" then
			TriggerEvent("cs:weather:client:DisableSync")			
		elseif Config.WeatherSystem == "dbn_weather" then
			exports['eternity_tiempo']:enableWeatherSystem(false)				
		elseif Config.WeatherSystem == "renewed" then
			TriggerEvent('Renewed:client:DisableSync')	
			Citizen.Wait(50)
			TriggerEvent('Renewed:client:ForceWeather', {
				weather = 'EXTRASUNNY',
				time = { hour = 2, minute = 0 },
				dynamic = false
			})
		elseif Config.WeatherSystem == "night_natural_disasters" then
			exports.night_natural_disasters:PauseSynchronization(true)		
		elseif Config.WeatherSystem == "av_weather" then
			TriggerEvent('av_weather:freeze', true, 2, 0, 'EXTRASUNNY')		
		end
		Citizen.Wait(250)
		prevHour   = GetClockHours()
		prevMinute = GetClockMinutes()
		prevSecond = GetClockSeconds()		
		NetworkOverrideClockTime(2, 0, 0)
		ClearOverrideWeather()
		ClearWeatherTypePersist()
		SetWeatherTypeNow("EXTRASUNNY")
		SetWeatherTypeNowPersist("EXTRASUNNY")
		SetWeatherTypePersist("EXTRASUNNY")
		SetReducePedModelBudget(true)
		SetReduceVehicleModelBudget(true)
		SetWindSpeed(0.0)
		SetCloudHatOpacity(0.0)
	elseif properytype == "IPL" then
		SetReducePedModelBudget(true)
		SetReduceVehicleModelBudget(true)
	end
end

function ExitPropertySettings(properytype)
	if properytype == "SHELL" then
		if Config.WeatherSystem == "cd_easytime" then
			TriggerEvent('cd_easytime:PauseSync', false)
		elseif Config.WeatherSystem == "vSync" then
			TriggerEvent('vSync:toggle', false)
			TriggerServerEvent('vSync:requestSync')
		elseif Config.WeatherSystem == "qb-weathersync" then
			TriggerEvent('qb-weathersync:client:EnableSync')
			TriggerServerEvent('qb-weathersync:server:RequestStateSync')
		elseif Config.WeatherSystem == "renewed" then
			TriggerEvent('Renewed:client:EnableSync')
			Citizen.Wait(50)
			TriggerEvent('Renewed:client:ForceWeather', false)
		elseif Config.WeatherSystem == "av_weather" then
			TriggerEvent('av_weather:freeze', false)	
		elseif Config.WeatherSystem == "cs_weather" then
			TriggerEvent('cs:weather:client:EnableSync')	
		elseif Config.WeatherSystem == "dbn_weather" then
			exports['eternity_tiempo']:enableWeatherSystem(true)
		elseif Config.WeatherSystem == "night_natural_disasters" then
			exports.night_natural_disasters:PauseSynchronization(false)					
		end		
		if prevHour ~= nil and prevMinute ~= nil then
			NetworkOverrideClockTime(prevHour, prevMinute, prevSecond or 0)
		end
		Citizen.Wait(250)
		SetArtificialLightsState(false)
		SetWindSpeed(1.0) 
		SetCloudHatOpacity(1.0)
	elseif properytype == "IPL" then
		SetForceVehicleTrails(false)
		SetReducePedModelBudget(true)
		SetReduceVehicleModelBudget(true)
		SetArtificialLightsState(false)
	end
end

function ActionAllowed() -- You can add a check here, for example, if a player is handcuffed or being carried by someone else, so that they cannot interact with the property.
	local allowed = true
	return allowed
end

local function IsPointInCircle(pointCoords, zoneCoords, radius)
    return #(pointCoords - zoneCoords) <= radius
end

local function GetServiceRateZoneByCoords(coords)
    if not coords then
        return nil
    end

    for zoneName, zoneData in pairs(Config.ServiceRateZones or {}) do
        if zoneData.coords and zoneData.radius then
            if IsPointInCircle(coords, zoneData.coords, zoneData.radius) then
                return zoneName, zoneData
            end
        end
    end

    return nil
end

function PropertyServicesRate(coords)
    local settings = {}

    for key, value in pairs(Config.ServicesSettings) do
        if type(value) == "table" then
            settings[key] = {}

            for subKey, subValue in pairs(value) do
                settings[key][subKey] = subValue
            end
        else
            settings[key] = value
        end
    end

    local _, zoneData = GetServiceRateZoneByCoords(coords)
    if not zoneData or not zoneData.services then
        return settings
    end

    for serviceName, zoneRate in pairs(zoneData.services) do
        if settings[serviceName] then
            settings[serviceName].ratedefault = zoneRate
        end
    end

    return settings
end

function CreateHouseGarage(propertyid)
	local houselocationhandler = housinglocations[tostring(propertyid)]
	if Config.GarageSystem  == "qb-garages" then
		local garagedata = {
			takeVehicle = {x = houselocationhandler.garage.coords.x, y = houselocationhandler.garage.coords.y, z = houselocationhandler.garage.coords.z, w = houselocationhandler.garage.heading}, 
			label = houselocationhandler.propertyname,
		}		
		TriggerEvent('qb-garages:client:addHouseGarage', tostring(propertyid), garagedata)
	end
end

function RemoveHouseGarage(propertyid)
	if Config.GarageSystem  == "qb-garages" then

	end
end

function UpdateHouseGarage(propertyid, handlergarage)
	if Config.GarageSystem  == "qb-garages" then
		TriggerEvent('qb-garages:client:setHouseGarage', tostring(propertyid), propertyid)
	end
end

function StoreVehicleToGarage(propertyid)
	local houselocationhandler = housinglocations[tostring(propertyid)]
	if Config.GarageSystem  == "okokGarage" then
		TriggerEvent('okokGarage:StoreVehiclePrivate')
	elseif Config.GarageSystem  == "cd_garage" then
		TriggerEvent('cd_garage:StoreVehicle_Main', 1, false, false)	
	elseif Config.GarageSystem  == "codem-garage" then
		TriggerEvent('codem-garage:openHouseGarage', 'House Garage')		
	elseif Config.GarageSystem  == "jg-advancedgarages" then
		local garageName = string.format("property-%s-garage", propertyid)
		TriggerEvent('jg-advancedgarages:client:store-vehicle', garageName, "car")
	elseif Config.GarageSystem  == "RxGarages" then
		exports['RxGarages']:ParkVehicle('House Garage ('..propertyid..')', 'garage', 'car')
	elseif Config.GarageSystem  == "vms_garagesv2" then
		exports['vms_garagesv2']:enterHouseGarage()
	elseif Config.GarageSystem  == "zerio-garage" then
		TriggerEvent('zerio-garage:client:PutBackHouseVehicle', tostring(propertyid), 'rtx_housing')		
	end

end

function OpenGarageMenu(propertyid)
	local houselocationhandler = housinglocations[tostring(propertyid)]
	if Config.GarageSystem  == "okokGarage" then
		TriggerEvent('okokGarage:OpenPrivateGarageMenu', houselocationhandler.garage.coords, houselocationhandler.garage.heading)
	elseif Config.GarageSystem  == "cd_garage" then
		TriggerEvent('cd_garage:PropertyGarage', 'quick', nil)
	elseif Config.GarageSystem  == "codem-garage" then
		TriggerEvent('codem-garage:storeVehicle', 'House Garage')	
	elseif Config.GarageSystem  == "jg-advancedgarages" then
		local garageName = string.format("property-%s-garage", propertyid)
		TriggerEvent('jg-advancedgarages:client:open-garage', garageName, "car", vec4(houselocationhandler.garage.coords.x, houselocationhandler.garage.coords.y, houselocationhandler.garage.coords.z, houselocationhandler.garage.heading))	
	elseif Config.GarageSystem  == "RxGarages" then
		exports['RxGarages']:OpenGarage('House Garage ('..propertyid..')', 'garage', 'car', houselocationhandler.garage.coords)		
	elseif Config.GarageSystem  == "vms_garagesv2" then
		exports['vms_garagesv2']:enterHouseGarage()	
	elseif Config.GarageSystem  == "zerio-garage" then
		TriggerEvent('zerio-garage:client:OpenHousingGarage', tostring(propertyid), 'rtx_housing')				
	end
end

function GarageCheck()
	local garageinteraction = true
	if Config.GarageSystem  == "ZSX_Garages" then
		garageinteraction = false
	elseif Config.GarageSystem == "qb-garages" then
		garageinteraction = false		
	end
	return garageinteraction
end
function LockPickProperty(lockpicktype, houselocationid, doordata, difficultylock)
	local playerhandler = PlayerPedId()	
	local animdict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
	while not HasAnimDictLoaded(animdict) do
		RequestAnimDict(animdict)
		Citizen.Wait(5)
	end
	TaskPlayAnim(playerhandler, animdict, "machinic_loop_mechandplayer", 8.0, 8.0, -1, 49, 0, 0, 0, 0)
    local success = StartLockPickMinigame(difficultylock, true)

    if success then
		lockpickinprogress = false
		if lockpicktype == "mlo" then
			TriggerServerEvent("rtx_housing:Global:LockPickFinishedMlo", houselocationid, doordata, true)
		else
			TriggerServerEvent("rtx_housing:Global:LockPickFinished", houselocationid, true)
		end
		PlaySoundEffect("sounds/lockpick.mp3")
    else
        lockpickinprogress = false
		if lockpicktype == "mlo" then
			TriggerServerEvent("rtx_housing:Global:LockPickFinishedMlo", houselocationid, false)
		else
			TriggerServerEvent("rtx_housing:Global:LockPickFinished", houselocationid, false)
		end
    end
	ClearPedTasks(playerhandler)
end

function IsDoorByName(objectName)
    if not objectName then return false end

    objectName = string.lower(objectName)

    return string.find(objectName, "door", 1, true) ~= nil
end

ramhandler = nil

function RaidProperty(raidtype, houselocationid, doordata, difficultylock)
	local houselocationhandler = housinglocations[tostring(houselocationid)]
	local playerhandler = PlayerPedId()
	local playercoords = GetEntityCoords(playerhandler)			
	local ramobject = GetHashKey("rtx_djn_pd_ram")
	RequestModel(ramobject)
	while not HasModelLoaded(ramobject) do
		RequestModel(ramobject)
		Citizen.Wait(5)
	end	 	
	if DoesEntityExist(ramhandler) then
		DeleteEntity(ramhandler)
	end
	local exitcoords = houselocationhandler.enter.coords
	local exitheading = houselocationhandler.enter.heading
	if houselocationhandler.partofcomplex.enabled == true then
		local apartmentcomplexhandler = housinglocations[tostring(houselocationhandler.partofcomplex.complexid)]
		exitcoords = apartmentcomplexhandler.enter.coords	
		exitheading = apartmentcomplexhandler.enter.heading	
	end
	FreezeEntityPosition(playerhandler, true)
	SetEntityHeading(playerhandler, exitheading)		
	ramhandler = CreateObjectNoOffset(ramobject, playercoords.x, playercoords.y, playercoords.z, false, true, true)
	FreezeEntityPosition(ramhandler, true)			
	NetworkAllowLocalEntityAttachment(ramhandler, true)	
	local boneIndex = GetPedBoneIndex(playerhandler, 57005)
	AttachEntityToEntity(ramhandler, playerhandler, boneIndex, 0.0, 0.0, -0.061614, -90.0, -90.0, -7.0, false, false, false, false, 5, true)	
	local animdict = "rtx_housing_breach"
	local animname = "rtx_housing_breach_idle"
	local animname2 = "rtx_housing_breach"
	while not HasAnimDictLoaded(animdict) do
		RequestAnimDict(animdict)
		Citizen.Wait(5)
	end				
	TaskPlayAnim(playerhandler, animdict, animname, 8.0, 8.0, -1, 1, 0, 0, 0, 0)
    local success = StartLockPickMinigame(difficultylock, false)

    if success then
		raidinprogress = false
		if raidtype == "mlo" then
			TriggerServerEvent("rtx_housing:Global:RaidFinishedMlo", houselocationid, doordata, true)
		else
			TriggerServerEvent("rtx_housing:Global:RaidFinished", houselocationid, true)
		end
		TaskPlayAnim(playerhandler, animdict, animname2, 8.0, 8.0, -1, 1, 0, 0, 0, 0)		
		Citizen.Wait(1500)			
		PlaySoundEffect("sounds/raid.mp3")
		Citizen.Wait(600)
		ClearPedTasks(playerhandler)		
		if DoesEntityExist(ramhandler) then
			DetachEntity(ramhandler)
			DeleteEntity(ramhandler)
		end		
		FreezeEntityPosition(playerhandler, false)
    else
        raidinprogress = false
		if raidtype == "mlo" then
			TriggerServerEvent("rtx_housing:Global:RaidFinishedMlo", houselocationid, doordata, false)
		else		
			TriggerServerEvent("rtx_housing:Global:RaidFinished", houselocationid, false)
		end
		ClearPedTasks(playerhandler)		
		if DoesEntityExist(ramhandler) then
			DetachEntity(ramhandler)
			DeleteEntity(ramhandler)
		end				
		FreezeEntityPosition(playerhandler, false)
    end
end

progressPromise = nil

RegisterNUICallback("rtxProgressStart", function(_, cb)
    
    cb({})
end)

RegisterNUICallback("rtxProgressDone", function(data, cb)
    if progressPromise then
        progressPromise:resolve(true)
        progressPromise = nil
    end
    cb({})
end)

RegisterNUICallback("rtxProgressCancel", function(_, cb)
    if progressPromise then
        progressPromise:resolve(false)
        progressPromise = nil
    end
    cb({})
end)

function StartPropertyProgress(opts)
    if progressPromise then return false end

    progressPromise = promise.new()

    SendNUIMessage({
        message   = "RTX_PROGRESS_START",
        title     = opts.title or "Progress",
        label     = opts.label or "",
        icon      = opts.icon or "fa-solid fa-spinner",
        timeMs    = opts.time or 5000,
        canCancel = opts.canCancel ~= false
    })

    return Citizen.Await(progressPromise)
end


RegisterNetEvent("rtx_housing:Global:EnterFreecam")
AddEventHandler("rtx_housing:Global:EnterFreecam", function()
	-- add here your bypass for anticheat
end)

RegisterNetEvent("rtx_housing:Global:ExitFreecam")
AddEventHandler("rtx_housing:Global:ExitFreecam", function()
	-- add here your bypass for anticheat
end)

RegisterNetEvent("rtx_housing:Global:EnterProperty")
AddEventHandler("rtx_housing:Global:EnterProperty", function()
	-- add here your bypass for anticheat
end)

RegisterNetEvent("rtx_housing:Global:ExitProperty")
AddEventHandler("rtx_housing:Global:ExitProperty", function()
	-- add here your bypass for anticheat
end)

function ShowGtaClassicInteraction(textdata)
	AddTextEntry("gtavclassicinteractionrtxhouse", textdata)
	BeginTextCommandDisplayHelp("gtavclassicinteractionrtxhouse")
	EndTextCommandDisplayHelp(0, false, true, -1)
end

function ShowInteraction(textdata, coordsdata)
	if Config.HousingInteractionSystem == 1 then
		SendNUIMessage({
			message = "infonotifyshow",
			infonotifytext = Language[Config.Language][textdata.."-normal"]
		})	
	elseif Config.HousingInteractionSystem == 2 then
		DrawText3D(coordsdata.x, coordsdata.y, coordsdata.z, Language[Config.Language][textdata.."-3d"])	
	elseif Config.HousingInteractionSystem == 3 then	
		ShowGtaClassicInteraction(Language[Config.Language][textdata.."-classic"])
	end
end

function HideInteraction()
	if Config.HousingInteractionSystem == 1 then
		SendNUIMessage({ message = "hidenotify" })
	end
end

function OpenStorage(houselocationid, storageiddata)
	local houselocationhandler = housinglocations[tostring(houselocationid)]
	local slotsdata = houselocationhandler.storage and houselocationhandler.storage.slots or 50
	local weightdata = houselocationhandler.storage and houselocationhandler.storage.weight or 100000					
	if Config.InventorySystem == "oxinventory" then
		exports.ox_inventory:openInventory('stash', 'property-'..houselocationid..'-storage-'..storageiddata..'')
	elseif Config.InventorySystem == "qbcoreinventory" then		
		TriggerServerEvent("rtx_housing:Global:OpenStorageQB", "property-"..houselocationid.."-storage-"..storageiddata.."")
	elseif Config.InventorySystem == "codeminventory" then		
		local name = "property-"..houselocationid.."-storage-"..storageiddata..""
		TriggerServerEvent('codem-inventory:server:openstash', name, weightdata, 'Property Storage - '..storageiddata..'')		
	elseif Config.InventorySystem == "coreinventory" then		
		local name = "property-"..houselocationid.."-storage-"..storageiddata..""
		TriggerServerEvent('core_inventory:server:openInventory', name, 'stash', nil, nil)
	elseif Config.InventorySystem == "psinventory" then						
		local name = "property-"..houselocationid.."-storage-"..storageiddata..""
		local stashdata = {
			maxweight = weightdata,
			slots = slotsdata,		
		}
		TriggerServerEvent('ps-inventory:server:OpenInventory', 'stash', name, stashdata)
		TriggerEvent('ps-inventory:client:SetCurrentStash', name)
	elseif Config.InventorySystem == "chezza" then			
		local name = "property-"..houselocationid.."-storage-"..storageiddata..""
		TriggerEvent('inventory:openInventory', { type = 'stash', id = name, title = 'Stash_' .. name, weight = weightdata, delay = 100, save = true })
	elseif Config.InventorySystem == "jaksam_inventory" then		
		local name = "property-"..houselocationid.."-storage-"..storageiddata..""
		exports['jaksam_inventory']:openInventory(name)	
	elseif Config.InventorySystem == "tgiann-inventory" then		
		local name = "property-"..houselocationid.."-storage-"..storageiddata..""
		exports["tgiann-inventory"]:OpenInventory("stash", name, { maxweight = weightdata, slots = slotsdata })		
	end
end	

function OpenSafeStorage(houselocationid, storageiddata)
	local houselocationhandler = housinglocations[tostring(houselocationid)]
	if Config.InventorySystem == "oxinventory" then
		exports.ox_inventory:openInventory('stash', 'property-'..houselocationid..'-storage-'..storageiddata..'')
	elseif Config.InventorySystem == "qbcoreinventory" then		
		TriggerServerEvent("rtx_housing:Global:OpenStorageQB", "property-"..houselocationid.."-storage-"..storageiddata.."")
	elseif Config.InventorySystem == "codeminventory" then		
		local name = "property-"..houselocationid.."-storage-"..storageiddata..""
		TriggerServerEvent('codem-inventory:server:openstash', name, Config.SafeSettings.slots,Config.SafeSettings.weight, 'Property Safe - '..storageiddata..'')	
	elseif Config.InventorySystem == "coreinventory" then		
		local name = "property-"..houselocationid.."-storage-"..storageiddata..""
		TriggerServerEvent('core_inventory:server:openInventory', name, 'stash', nil, nil)
	elseif Config.InventorySystem == "psinventory" then		
		local name = "property-"..houselocationid.."-storage-"..storageiddata..""
		local stashdata = {
			maxweight = Config.SafeSettings.weight,
			slots = Config.SafeSettings.slots,		
		}
		TriggerServerEvent('ps-inventory:server:OpenInventory', 'stash', name, stashdata)
		TriggerEvent('ps-inventory:client:SetCurrentStash', name)
	elseif Config.InventorySystem == "chezza" then		
		local name = "property-"..houselocationid.."-storage-"..storageiddata..""
		TriggerEvent('inventory:openInventory', { type = 'stash', id = name, title = 'Stash_' .. name, weight = Config.SafeSettings.weight, delay = 100, save = true })
	elseif Config.InventorySystem == "jaksam_inventory" then		
		local name = "property-"..houselocationid.."-storage-"..storageiddata..""
		exports['jaksam_inventory']:openInventory(name)
	elseif Config.InventorySystem == "tgiann-inventory" then		
		local name = "property-"..houselocationid.."-storage-"..storageiddata..""
		exports["tgiann-inventory"]:OpenInventory("stash", name, { maxweight = Config.SafeSettings.weight, slots = Config.SafeSettings.slots })
	end
end	


function OpenWardrobe(houselocationid)
	if Config.WardrobeSystem == "default" then
	elseif Config.WardrobeSystem == "esx" then
		  ESX.TriggerServerCallback('esx_property:getPlayerDressing', function(dressing)
			local elements = {{unselectable = true, icon = "fas fa-tshirt", title = "Wardrobe"}, {unselectable = false, icon = "", title = "Outfit 1"}, {unselectable = false, icon = "", title = "Outfit 2"}}

			for i=1, #dressing, 1 do
				elements[#elements + 1] = {
					title = dressing[i],
					value = i
				}
			end
			
			ESX.OpenContext("right", elements, function(menu, element)
				TriggerEvent('skinchanger:getSkin', function(skin)
					ESX.TriggerServerCallback('esx_property:getPlayerOutfit', function(clothes)
						TriggerEvent('skinchanger:loadClothes', skin, clothes)
						TriggerEvent('esx_skin:setLastSkin', skin)

						TriggerEvent('skinchanger:getSkin', function(skin)
							TriggerServerEvent('esx_skin:save', skin)
						end)
					end, element.value)
				end)
			end)
		end)
	elseif Config.WardrobeSystem == "qbcore" then
		TriggerEvent('qb-clothing:client:openOutfitMenu')
	elseif Config.WardrobeSystem == "codem" then
		TriggerEvent('codem-apperance:OpenWardrobe')
	elseif Config.WardrobeSystem == "fivemappearance" then
		exports['fivem-appearance']:openWardrobe()
	elseif Config.WardrobeSystem == "illeniumappearance" then
		 TriggerEvent('illenium-appearance:client:openOutfitMenu')
	 elseif Config.WardrobeSystem == "rcore" then
		TriggerEvent('rcore_clothing:openChangingRoom')
	end
end	

function InSomeMenu()
	local noinmenu = true
	if LocalPlayer.state.invOpen == true then
		noinmenu = false
	end
	return noinmenu
end	

function AlarmBlip(houselocationid, alarmcoords)
	local houselocationhandler = housinglocations[tostring(houselocationid)]
	local alarmblip = AddBlipForCoord(alarmcoords.x, alarmcoords.y,alarmcoords.z)

	SetBlipSprite(alarmblip, Config.BlipSettings.alarm.blipiconid)
	SetBlipDisplay(alarmblip, Config.BlipSettings.alarm.blipdisplay)
	SetBlipScale(alarmblip, 0.5)
	SetBlipColour(alarmblip, Config.BlipSettings.alarm.blipcolor)
	SetBlipAsShortRange(alarmblip, Config.BlipSettings.alarm.blipshortrange)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName(Config.BlipSettings.alarm.bliptext)
	EndTextCommandSetBlipName(alarmblip)	
	PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
	CreateThread(function()
		Wait(60000)
		if DoesBlipExist(alarmblip) then
			RemoveBlip(alarmblip)
		end
	end)	
end

function DrawText3D(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords()) 
	if onScreen then
		SetTextScale(0.35, 0.35)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 255)
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 240
		DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 255, 102, 255, 150)
	end
end

function DrawDoorBadgeWithTooltip(x, y, z, locked, canLock)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    if not onScreen then return end

    local label = locked and "Locked" or "Unlocked"

    local accentR, accentG, accentB
    if locked then
        accentR, accentG, accentB = 230, 70, 90 
    else
        accentR, accentG, accentB = 120, 230, 170 
    end

    local textLen = string.len(label)
    local width = 0.018 + (textLen * 0.005)

    DrawRect(_x, _y + 0.016, width + 0.010, 0.038, 0, 0, 0, 0)
    DrawRect(_x, _y + 0.014, width, 0.032, 5, 5, 5, 200)
    DrawRect(_x, _y + 0.002, width, 0.006, accentR, accentG, accentB, 230)

    SetTextScale(0.30, 0.30)
    SetTextFont(4)
    SetTextCentre(1)
    SetTextColour(255, 255, 255, 255) 
    SetTextEntry("STRING")
    AddTextComponentString(label)
    DrawText(_x, _y + 0.006)


    local tooltip = ""
    if canLock then
		if Config.Target == false then
			tooltip = "["..Config.Keys.doorlock.."] Lock/Unlock    ["..Config.Keys.propertymenu.."] Property Menu"
		else
			tooltip = "["..Config.Keys.doorlock.."] Lock/Unlock"
		end
    else
        if Config.Target == false then
			tooltip = "["..Config.Keys.propertymenu.."] Property Menu"
		end
    end

    SetTextScale(0.26, 0.26)
    SetTextFont(4)
    SetTextCentre(1)
    SetTextColour(255, 255, 255, 240)
    SetTextEntry("STRING")
    AddTextComponentString(tooltip)

    DrawText(_x, _y + 0.050)
end

zonescreated = {} 

function AddTargetZone(targettype, targetnamedata, targettypedata, targetheading, targetdistance, targetlabel, targeticon, targetevent)
	if Config.Target == true and zonescreated[targetnamedata] == nil then
		if Config.Targettype == "qtarget" then
			if targettype == "coords" then
				local targetcoordsdata = vector3(targettypedata.x, targettypedata.y, targettypedata.z+0.5)
				exports[Config.TargetSystemsNames.qtarget]:AddBoxZone(targetnamedata, targetcoordsdata, 2.5, 2.5, {
					name = targetnamedata,
					heading = targetheading,
					debugPoly = false,
					minZ = targetcoordsdata.z-1.5,
					maxZ = targetcoordsdata.z+1.5,
					}, {
						options = {
							{
								event = targetevent,
								icon = targeticon,
								label = targetlabel
							},
						},
						distance = targetdistance
				})	
			else
				zonescreated[targetnamedata] = "model"
				exports[Config.TargetSystemsNames.qtarget]:AddTargetModel({GetHashKey(targettypedata)}, {
					options = {
						{
							name = targetnamedata,
							event = targetevent,
							icon = targeticon,
							label = targetlabel,
						},
					},
					distance = targetdistance
				})		
			end
		elseif Config.Targettype == "qbtarget" then
			if targettype == "coords" then
				local targetcoordsdata = vector3(targettypedata.x, targettypedata.y, targettypedata.z+0.5)
				exports[Config.TargetSystemsNames.qbtarget]:AddBoxZone(targetnamedata, targetcoordsdata, 2.5, 2.5, {
					name = targetnamedata,
					heading = targetheading,
					debugPoly = false,
					minZ = targetcoordsdata.z-1.5,
					maxZ = targetcoordsdata.z+1.5,
				}, {
					options = {
						{
						  type = "client",
						  action = function(entity) 
							TriggerEvent(targetevent)
						  end,
						  icon = targeticon,
							  label = targetlabel,
							},
						},
					distance = targetdistance
				})	
			else
				zonescreated[targetnamedata] = "model"
				exports[Config.TargetSystemsNames.qbtarget]:AddTargetModel({GetHashKey(targettypedata)}, {
					options = {
						{
							name = targetnamedata,
							event = targetevent,
							icon = targeticon,
							label = targetlabel,
						},
					},
					distance = targetdistance
				})				
			end
		elseif Config.Targettype == "oxtarget" then								
			if targettype == "coords" then
				local targetcoordsdata = vector3(targettypedata.x, targettypedata.y, targettypedata.z+0.5)
				zonescreated[targetnamedata] = exports[Config.TargetSystemsNames.oxtarget]:addBoxZone({
					name = targetnamedata,
					coords = targetcoordsdata,
					size = vec3(2, 2, 2),
					rotation = targetheading,
					options = {
						{
							name = targetnamedata,
							event = targetevent,
							icon = targeticon,
							distance = targetdistance,
							label = targetlabel,
							canInteract = function(entity, distance, coords, name)
								return true
							end
						}
					}
				})	
			else
				zonescreated[targetnamedata] = "model"
				exports[Config.TargetSystemsNames.oxtarget]:addModel(GetHashKey(targettypedata), {
					{
						name = targetnamedata,
						event = targetevent,
						icon = targeticon,
						label = targetlabel,
					}						
				})				
			end
		end
	end
end

function RemoveTargetZone(targetnamedata, modelnamedata)
    if not Config.Target then return end
    if not targetnamedata or targetnamedata == "" then return end
    if not zonescreated[targetnamedata] then return end
	
    if Config.Targettype == "qtarget" then
        ok, err = pcall(function()
            if zonescreated[targetnamedata] == "model" then
				exports[Config.TargetSystemsNames.qtarget]:RemoveTargetModel(GetHashKey(modelnamedata))
			else
				exports[Config.TargetSystemsNames.qtarget]:RemoveZone(targetnamedata)
			end
        end)

    elseif Config.Targettype == "qbtarget" then
        ok, err = pcall(function()
			if zonescreated[targetnamedata] == "model" then
				exports[Config.TargetSystemsNames.qbtarget]:RemoveTargetModel(GetHashKey(modelnamedata))    
			else
				exports[Config.TargetSystemsNames.qbtarget]:RemoveZone(targetnamedata)
			end
        end)

    elseif Config.Targettype == "oxtarget" then
        ok, err = pcall(function()
            if zonescreated[targetnamedata] == "model" then
				exports[Config.TargetSystemsNames.oxtarget]:removeModel(GetHashKey(modelnamedata))
			else
				exports[Config.TargetSystemsNames.oxtarget]:removeZone(zonescreated[targetnamedata])
			end
        end)
    end
    if not ok then
        print(("[HOUSING] RemoveTargetZone failed (%s): %s"):format(tostring(targetnamedata), tostring(err)))
    end
	zonescreated[targetnamedata] = nil
end


local HelpNotify = {}

function HelpNotify.Show(opts)
    opts = opts or {}

    SendNUIMessage({
        message    = "HelpNotifyShow",
        title      = opts.title or "Help",
        text       = opts.text or "",
        tagline    = opts.tagline or nil,
        icon       = opts.icon or "fa-circle-info",
        keys       = opts.keys or nil,
        autoHideMs = opts.autoHideMs or 0
    })
end

function HelpNotify.Hide()
    SendNUIMessage({
        message = "HelpNotifyHide"
    })
end

exports("ShowHelpNotify", HelpNotify.Show)
exports("HideHelpNotify", HelpNotify.Hide)


local Notify = {}
local notifyIdCounter = 0

function Notify.Show(opts)
    opts = opts or {}
    notifyIdCounter = notifyIdCounter + 1
    local id = notifyIdCounter

    SendNUIMessage({
        message = "NotifyShow",
        id      = id,
        title   = opts.title or "Notification",
        text    = opts.text or "",
        type    = opts.type or "info",
        timeout = opts.timeout or 5000,
        icon    = opts.icon or nil
    })
	PlaySoundEffect("sounds/soundnotify.mp3")
end

function Notify.Hide(id)
    if not id then return end

    SendNUIMessage({
        message = "NotifyHide",
        id      = id
    })
end

function Notify.HideAll()
    SendNUIMessage({
        message = "NotifyHide"
    })
end
exports("ShowNotify",     Notify.Show)
exports("HideNotify",     Notify.Hide)
exports("HideAllNotify",  Notify.HideAll)


function FurnitureInteraction(furnituretype, action)
	local playerhandler = PlayerPedId()
	if action == "started" then
		if furnituretype == "sink" then
			-- add hygiene
		elseif furnituretype == "shower" then
			 SetPedWetnessHeight(playerhandler, 1.0)
		elseif furnituretype == "bathtub" then
			 SetPedWetnessHeight(playerhandler, 1.0)			 
		end
	elseif action == "finished" then
		if furnituretype == "sink" then
			ClearPedBloodDamageByZone(playerhandler, 2)
		elseif furnituretype == "shower" then
			ClearPedBloodDamage(playerhandler)
			ClearPedBloodDamageByZone(playerhandler, 0)
			ResetPedVisibleDamage(playerhandler)
			ClearPedLastDamageBone(playerhandler)

			ClearPedEnvDirt(playerhandler)
			SetPedWetnessHeight(playerhandler, 0.0)
		elseif furnituretype == "bathtub" then
			ClearPedBloodDamage(playerhandler)
			ClearPedBloodDamageByZone(playerhandler, 0)
			ResetPedVisibleDamage(playerhandler)
			ClearPedLastDamageBone(playerhandler)

			ClearPedEnvDirt(playerhandler)
			SetPedWetnessHeight(playerhandler, 0.0)			
		end	
	end	
end

function DisplayHud(handler)
	DisplayRadar(handler)
end

-- Public helper: uploads a screenshot via screenshot-basic and returns the first attachment URL.
-- Developers can provide their own webhook URL and custom options (encoding, quality, field)
-- instead of using the webhook or settings passed from the calling function.
-- Returns: cb(url, err) where url is a string or nil, and err is a string or nil.

function RequestScreenshotUrl(webhook, cb, opts)
    if type(cb) ~= "function" then return end
    if type(webhook) ~= "string" or webhook == "" then
        return cb(nil, "missing_webhook")
    end

    opts = opts or {}
    local encoding = opts.encoding or "webp"
    local quality  = opts.quality or 90
    local field    = opts.field or "files[]"

    if GetResourceState("screenshot-basic") ~= "started" then
        return cb(nil, "screenshot_basic_not_started")
    end

    exports["screenshot-basic"]:requestScreenshotUpload(
        webhook,
        field,
        { encoding = encoding, quality = quality },
        function(body)
            local ok, resp = pcall(function()
                return json.decode(body or "{}")
            end)

            if not ok or type(resp) ~= "table" then
                return cb(nil, "invalid_response")
            end

            local url = resp
                and resp.attachments
                and resp.attachments[1]
                and resp.attachments[1].url

            if type(url) ~= "string" or url == "" then
                return cb(nil, "missing_url")
            end

            cb(url, nil)
        end
    )
end

function TakeScreenshot(filename, imgType, cb)
	exports['screenshot-basic']:requestScreenshot({
		encoding = 'webp', 
		quality  = 1.0
	}, function(data)
		if not data then
			if cb then cb(false) end
			return
		end

		SendNUIMessage({
			message  = "screenshot",
			image    = data,
			filename = filename,
			imgType  = imgType
		})

		CurrentScreenshotCallback = cb
	end)
end


-- ===============================
-- ANGEL FEATURE TEMPLATE
-- ===============================

-- 1) Add to Config.Assistant.Commands:

-- {
--     name = "Feature Name",
--     keywords = { "keyword1", "keyword2" },
--     examples = { "example phrase", "another phrase" },
--     tts = "Optional immediate reply.",
--     action = function()
--         MyCustomFeature()
--     end
-- },

-- 2) Implement function:

function MyCustomFeature()
    if not angelenabled then return end

    SendNUIMessage({
        type = "ANGEL_TTS",
        text = "Testing text."
    })
end
