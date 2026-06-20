local resource = GetCurrentResourceName()
local version = GetResourceMetadata(resource, 'version', 0)
Config.VersionNumber = version
print("Pug Robbery Creator "..tostring(version))
local soundId = GetSoundId()
---------- [Functions] ----------

function Notify(msg, type, length)
    if Config and Config.T then
        msg = Config.T(msg)
    end
	if Framework == "ESX" then
		FWork.ShowNotification(tostring(msg))
	elseif Framework == "QBCore" then
    	FWork.Functions.Notify(tostring(msg), type, length)
	end
end

function DrawTextOption(text)
	if Framework == "QBCore" then
		exports[Config.CoreName]:DrawText(text, 'left')
	else
		FWork.TextUI(text, "error")
	end
end
function HideTextOption()
	if Framework == "QBCore" then
		exports[Config.CoreName]:HideText()
		Wait(1000)
	else
		FWork.HideUI()
	end
end

local function NormalizeAlertCoords(coords)
    if type(coords) ~= "table" and type(coords) ~= "vector3" and type(coords) ~= "vector4" then
        return nil
    end

    local x = tonumber(coords.x or coords[1])
    local y = tonumber(coords.y or coords[2])
    local z = tonumber(coords.z or coords[3])
    if not x or not y or not z then
        return nil
    end

    return vector3(x, y, z)
end

local function GetAlertCoords(settings)
    local coords = NormalizeAlertCoords(settings and (settings.alertCoords or settings.dispatchCoords or settings.coords))
    return coords or GetEntityCoords(PlayerPedId())
end

function AlertPolice(settings)
    settings = settings or {}
    -- Police Alert Headers and Messages
    local messageHeader = settings.policeAlertHeader or Config.T("PoliceAlertHeader")
    local mainMessage = settings.policeAlert or Config.T("PoliceAlertMessage")
    -- Police Jobs to be Alerted
    local policeJobs = settings.policeJobs or {}
    -- Alert Code
    local alertCode = settings.alertCode or '10-90'
    -- Alert Icon
    local alertIcon = settings.alertIcon or 'fas fa-question'
    -- Alert Priority (1 = Red, 2 = Default, 3 = Low)
    local alertPriority = tonumber(settings.alertPriority) or 2
    -- Camera ID for Heists (can be nil if not applicable)
	local alertCamId = settings.alertCamId or nil

    -- Blip Settings
    local blipSprite = tonumber(settings.blipSprite) or 58
    local blipColor = tonumber(settings.blipColor) or 1
	local blipScale = tonumber(settings.blipScale) or 1.0
	blipScale = string.format("%.1f", blipScale)
	blipScale = tonumber(blipScale)
	-- local blipLength = tonumber(settings.blipLength) or 2
	local alertSound1 = settings.alertSound1 or "Lose_1st"
	local alertSound2

	if alertSound1 == "Lose_1st" then
		alertSound2 = "GTAO_FM_Events_Soundset"
	end

	-- Blip Effects
    local blipFlash = settings.blipFlash or false
    local alertCoords = GetAlertCoords(settings)
	
	-- DATA FOR ALL ROBBERY SCRIPTS
    local data = {
        coords = alertCoords, -- Alert coordinates, defaults to the player's current position
        job = policeJobs, -- Jobs to be alerted
        -- Police Alert Details
        message = mainMessage, -- Main message of the alert
        header = messageHeader, -- Header/title of the alert
        -- Police Alert Settings
        code = alertCode, -- Code displayed before the title
        icon = alertIcon, -- Icon displayed after the title
        priority = alertPriority, -- Priority affecting alert color (1 = red, 2 = default)
		camId = alertCamId, -- Camera ID (for heists), can be nil
		sound = alertSound1, -- Primary alert sound
		sound2 = alertSound2, -- Secondary alert sound
        -- Blip Settings
        sprite = blipSprite, -- Sprite type of the blip
        color = blipColor, -- Color of the blip
        scale = blipScale, -- Scale of the blip
        -- length = blipLength, -- Duration the blip stays on the map
		-- Blip Effects
        flash = false, -- Blip flash (boolean)
	}

    if GetResourceState("tk_dispatch") == 'started' then
        exports.tk_dispatch:addCall({
            title = data.header,
            code = data.code,
            message = data.message,
            priority = 'Priority 3',
            coords = data.coords,
            showLocation = true,
            showGender = true,
            playSound = true,
            blip = {
                color = data.color,
                sprite = data.sprite,
                scale = 1.0,
            },
            jobs = data.job
        })
    elseif GetResourceState("cd_dispatch3d") == 'started' then
        local data2 = exports['cd_dispatch3d']:GetPlayerInfo()
        TriggerServerEvent('cd_dispatch:AddNotification3d', {
         job_table = data.job,
         coords = data.coords,
         title = data.code.." "..data.header,
         message = data.message, 
         flash = data.flash,
         sound = data.priority,
            blip = {
                sprite = data.sprite, 
                scale = data.scale, 
                colour = data.color,
                flashes = data.flash, 
                text = data.code.." "..data.header,
                time = 5,
                radius = 0,
            }
        })
	elseif GetResourceState("ps-dispatch") == 'started' then
        data.length = 3 -- This is how many minutes the blip will stay on the police map when the call is initiated.
		exports["ps-dispatch"]:CustomAlert(data)
	elseif GetResourceState("qs-dispatch") == 'started' then
		local playerData = exports['qs-dispatch']:GetPlayerInfo()
		if (not playerData) then
			print('Error getting player data')
			return
		end
		exports['qs-dispatch']:getSSURL(function(image)
			TriggerServerEvent('qs-dispatch:server:CreateDispatchCall', {
				job = data.job,
				callLocation = data.coords,
				callCode = { code = data.code },
				message = data.message,
				flashes = data.flash,
				image = image or nil,
				blip = {
					sprite = data.sprite,
					scale = data.scale,
					colour = data.color,
					flashes = data.flash,
					text = data.code,
					time = (20 * 1000), --20 secs
				}
			})
		end)
	elseif GetResourceState("cd_dispatch") == 'started' then
		local data2 = exports['cd_dispatch']:GetPlayerInfo()
		TriggerServerEvent('cd_dispatch:AddNotification', {
			job_table = data.job, 
			coords = data.coords,
			title = data.code.." "..data.header,
			message = data.message, 
			flash = data.flash,
			unique_id = data2.unique_id,
			sound = data.priority,
			blip = {
				sprite = data.sprite, 
				scale = data.scale, 
				colour = data.color,
				flashes = data.flash, 
				text = data.code.." "..data.header,
				time = 5,
				radius = 0,
			}
		})
	elseif GetResourceState("core_dispatch") == 'started' then
		local playerPos = data.coords
		local gender = IsPedMale(PlayerPedId()) and 'male' or 'female'
		TriggerServerEvent("core_dispatch:addCall", 
			data.code, --- @code string code of the call (like 10-19)
			data.header, --- @message string message in the notification
			{
				{icon = data.icon, info = gender} --- @info table of type {icon= string, info= string }
			},
			{ playerPos.x, playerPos.y, playerPos.z }, --- @coords number,number,number coords where the notification is trigger
			'police', --- @job string job who will receive the notification (one at a time)
			5000, --- @time number time duration of the notification in ms
			data.sprite, --- @spritenumber Sprite that will be use on the minimap to
			data.color, --- @colornumber color use for the blip
			true --- @priority boolean define if the call is priority or not
		)
	elseif GetResourceState("rcore_dispatch") == 'started' then
		if tonumber(data.priority) == 1 then
			data.priority = "high"
		elseif tonumber(data.priority) == 2 then
			data.priority = "medium"
		else
			data.priority = "low"
		end
		local player_data = exports['rcore_dispatch']:GetPlayerData()
        local rcoreCoords = data.coords or (player_data and player_data.coords) or GetEntityCoords(PlayerPedId())
		local data = {
			code = data.code.." "..data.header, -- string -> The alert code, can be for example '10-64' or a little bit longer sentence like '10-64 - Shop robbery'
			default_priority = data.priority, -- 'low' | 'medium' | 'high' -> The alert priority
			coords = rcoreCoords, -- vector3 -> The coords of the alert
			job = data.job, -- string | table -> The job, for example 'police' or a table {'police', 'ambulance'}
			text = data.message, -- string -> The alert text
			type = 'bank_robbery', -- alerts | shop_robbery | car_robbery | bank_robbery -> The alert type to track stats
			blip_time = 5, -- number (optional) -> The time until the blip fades
			image = false,
			custom_sound = false, -- string (optional) -> The url to the sound to play with the alert
			blip = { -- Blip table (optional)
				sprite = data.sprite, -- number -> The blip sprite: Find them here (https://docs.fivem.net/docs/game-references/blips/#blips)
				colour = data.color, -- number -> The blip colour: Find them here (https://docs.fivem.net/docs/game-references/blips/#blip-colors)
				scale = data.scale, -- number -> The blip scale
				text = data.message, -- number (optional) -> The blip text
				flashes = data.flash, -- boolean (optional) -> Make the blip flash
				radius = 0, -- number (optional) -> Create a radius blip instead of a normal one
			}
		}
		TriggerServerEvent('rcore_dispatch:server:sendAlert', data)
	elseif GetResourceState("origen_police") == 'started' then
		TriggerServerEvent("SendAlert:police", {
			coords = data.coords,
			title = data.code.." "..data.header,
			type = 'GENERAL',
			message = data.message,
			job = 'police',
		})
    elseif GetResourceState("codem-dispatch") == 'started' then
        local Data = {
            type = 'Robbery',
            header = data.header,
            text = data.message,
            code = data.code,
            coords = data.coords,
        }
        exports['codem-dispatch']:CustomDispatch(Data)
    elseif GetResourceState("enyo-policebackup") == 'started' then
        exports["enyo-policebackup"]:SetPlayerWanted(4, 10, 5000)
    elseif GetResourceState("lb-tablet") == 'started' then
        local dispatchData = {
            priority    = data.priority == 1 and 'high' or data.priority == 2 and 'medium' or 'low',
            code        = data.code,
            title       = data.header,
            description = data.message,
            location    = { label = data.header, coords = { x = data.coords.x, y = data.coords.y } },
            time        = 30,
            image       = nil,
            job         = 'police',
            sound       = data.sound or false,
            fields      = { { icon = data.icon, label = data.message } },
            blip        = {
                sprite     = data.sprite,
                color      = data.color,
                size       = data.scale,
                shortRange = true,
                label      = data.code,
            },
        }
        TriggerServerEvent("Pug:server:SendLBTabletDispatch", dispatchData)
    elseif GetResourceState("kartik-mdt") == 'started' then
        exports['kartik-mdt']:CustomAlert({
            title = data.header,
            code = data.code,
            description = data.message,
            type = "Alert",
            sound = false,
            coords = data.coords,
            person = {},
            weapon = {},
            blip = {
                radius = 0.0,
                sprite = data.sprite,
                color = data.color,
                scale = data.scale,
                length = 30
            },
            jobs = {
                police = true,
                bcso = true,
                sheriff = true,
                state = true,
                highway = true,
                rangers = true,
                ranger = true,
                trooper = true,
                troopers = true,
            }
        })
    elseif GetResourceState("wasabi_mdt") == 'started' then
        exports.wasabi_mdt:CreateDispatch({
            type = 'robbery',
            title = data.header,
            description = data.message,
            location = data.header,
            coords = {x = data.coords.x, y = data.coords.y, z = data.coords.z},
            priority = data.priority,
            departments = data.job
        })
    elseif GetResourceState("u_dispatch") == 'started' then
        exports['u_dispatch']:SendDispatchAlert('police', {
            title = data.header,
            description = data.message,
            icon = data.icon or "fas fa-mask",
            color = "#e74c3c",
            coords = data.coords,
            author = "Système"
        })
	else
		PrintDebug("^1 YOU NEED TO ADD A POLICE CALL NOTIFICATION TO THE CallPoliceForCarJack() FUNCTION IN THE OPEN.LUA")
	end
end

function SendBankTruckAlert()
    local settings = {
        -- Custom settings for the bank truck call
        policeAlertHeader = "Bank Truck Being Robbed", -- Title/header for the alert
        policeAlert = "Armed bank truck robbery.", -- Main message of the alert
        policeJobs = Config.DefualPoliceJobs, -- Jobs to receive the alert, you can add more if needed
        alertCode = '10-90', -- Code for robbery call (commonly used 10-31)
        alertIcon = 'fas fa-user-secret', -- Icon for robbery
        alertPriority = 1, -- Set as high priority (1 = Red)

        -- Blip Settings
        blipSprite = 67, -- Blip sprite (58 = red marker)
        blipColor = 2, -- Blip color (2 = green)
        blipScale = 1.0, -- Blip size/scale
        blipFlash = false, -- Enable blip flashing
        alertSound1 = "Lose_1st", -- Sound for alert
    }

    -- Call the police alert function
    AlertPolice(settings)
end

function SendAtmRobberyAlert()
    local settings = {
        -- Custom settings for the bank truck call
        policeAlertHeader = "Atm Being Robbed", -- Title/header for the alert
        policeAlert = "Atm Being Robbed", -- Main message of the alert
        policeJobs = Config.DefualPoliceJobs, -- Jobs to receive the alert, you can add more if needed
        alertCode = '10-90', -- Code for robbery call (commonly used 10-31)
        alertIcon = 'fas fa-user-secret', -- Icon for robbery
        alertPriority = 2, -- Set as high priority (1 = Red)

        -- Blip Settings
        blipSprite = 500, -- Blip sprite (58 = red marker)
        blipColor = 2, -- Blip color (2 = green)
        blipScale = 1.0, -- Blip size/scale
        blipFlash = false, -- Enable blip flashing
        alertSound1 = "Lose_1st", -- Sound for alert
    }

    -- Call the police alert function
    AlertPolice(settings)
end

function SendSuspiciousActivityCallToPolice()
    local settings = {
        -- Custom settings for the suspicious activity call
        policeAlertHeader = "Suspicious Activity", -- Title/header for the alert
        policeAlert = "A suspicious person has been reported in the area.", -- Main message of the alert
        policeJobs = Config.DefualPoliceJobs, -- Jobs to receive the alert, you can add more if needed
        alertCode = '10-31', -- Code for suspicious person call (commonly used 10-31)
        alertIcon = 'fas fa-user-secret', -- Icon for suspicious activity
        alertPriority = 3, -- Set as high priority (1 = Red)
        alertCamId = nil, -- No camera for this type of alert

        -- Blip Settings
        blipSprite = 58, -- Blip sprite (58 = red marker)
        blipColor = 1, -- Blip color (1 = red)
        blipScale = 1.0, -- Blip size/scale
        blipFlash = true, -- Enable blip flashing
        alertSound1 = "Lose_1st", -- Sound for alert
    }

    -- Call the police alert function
    AlertPolice(settings)
end

function GetPlayerItemCount(itemName)
	itemName = tostring(string.lower(itemName))
    local count = 0
    
    -- Check which inventory system is active and get the item count
    if GetResourceState("qs-inventory") == 'started' then
        count = exports['qs-inventory']:Search(itemName) or 0
    -- elseif GetResourceState("ps-inventory") == 'started' then
    --     local hasItem = exports['ps-inventory']:HasItem(itemName)
    --     count = hasItem and hasItem.amount or 0

    elseif GetResourceState("ox_inventory") == 'started' then
        count = exports.ox_inventory:GetItemCount(itemName) or 0

    elseif GetResourceState("core_inventory") == 'started' then
        if Framework == "QBCore" then
            local citizenid = FWork.Functions.GetPlayerData().citizenid
            local primaryCount = exports['core_inventory']:getItems('primary-' .. citizenid, itemName) or 0
            local secondaryCount = exports['core_inventory']:getItems('secondry-' .. citizenid, itemName) or 0
            count = primaryCount + secondaryCount
        end
    elseif Framework == "QBCore" then
        -- Fallback logic to manually count items from player data in QBCore
        local items = FWork.Functions.GetPlayerData().items
        for _, v in pairs(items) do
            if v.name ~= nil and tostring(string.lower(v.name)) == tostring(itemName) then
                count = count + (v.amount or 1)
            end
        end
    end

    return count
end


function HasItem(items, amount)
    if Config.InventoryType == "tgiann-inventory" then
        if Framework == "QBCore" then
            local playerData = FWork.Functions.GetPlayerData()
            if not playerData or not playerData.items then
                return false
            end

            for _, item in pairs(playerData.items) do
                if item.name and item.name == items and item.amount >= amount then
                    return true
                end
            end
            return false
        else
            local DoesHasItem = exports['tgiann-inventory']:HasItem(items, amount)
            return DoesHasItem or false
        end
    else
        local DoesHasItem = "nothing"

        if Framework == "QBCore" then
            Config.FrameworkFunctions.TriggerCallback("Pug:server:GetItemQBCoreRobberyCreator", function(HasItem)
                DoesHasItem = HasItem and true or false
            end, items, amount)
        else
            Config.FrameworkFunctions.TriggerCallback("Pug:serverESX:GetItemESXRobberyCreator", function(HasItem)
                DoesHasItem = HasItem and true or false
            end, items, amount)
        end

        while DoesHasItem == "nothing" do Wait(1) end
        return DoesHasItem
    end
end

function GetItemsInformation(I, Bool)
	if Framework == "QBCore" then
		if FWork.Shared.Items[I] then
			if Bool then
				if FWork.Shared.Items[I].image ~= nil then
					return FWork.Shared.Items[I].image
				else
					return I
				end
			else
				return FWork.Shared.Items[I].label
			end
		else
			if Config.InventoryType == "ox_inventory" then
				local Exist
				for item, data in pairs(exports.ox_inventory:Items()) do
					if tostring(string.lower(item)) == tostring(string.lower(I)) then
						if Bool then
							return tostring(tostring(item..".png"))
						else
							Exist = true
							return tostring(data.label)
						end
					end
				end
				if not Exist then
					return I
				end
			else
				return I
			end
		end
	else
		if Config.InventoryType == "ox_inventory" then
			for item, data in pairs(exports.ox_inventory:Items()) do
				if tostring(string.lower(item)) == tostring(string.lower(I)) then
					if Bool then
						return tostring(tostring(item..".png"))
					else
						return tostring(data.label)
					end
				end
			end
		end
		return I
	end
end


function AddPropToPlayer(prop1, bone, off1, off2, off3, rot1, rot2, rot3, Entity, Bool)
	local Player = Entity
	local x,y,z = table.unpack(GetEntityCoords(Player))
  
    LoadModel(prop1)
  
	prop = CreateObject(GetHashKey(prop1), x, y, z + 0.2, true, true)
	local startTime = GetGameTimer()
	while not DoesEntityExist(prop) do Wait(100) if GetGameTimer() - startTime > 3000 then break end end
    if not Bool then
	    AttachEntityToEntity(prop, Player, GetPedBoneIndex(Player, bone), off1, off2, off3, rot1, rot2, rot3, true, true, false, true, 1, true)
    end
	table.insert(PlayerProps, prop)
	SetModelAsNoLongerNeeded(prop1)
	-- Wait(50) -- Someone was crashing if this Wait(100) did not exist but only one person out of 20+
end

function HandleVehicleKeys(Vehicle, Plate)
	TriggerEvent(Config.VehilceKeysGivenToPlayerEvent, Plate)
end

function OpenBankDoor(heist, stepNumber, DoorCoords)
    for _, v in pairs(Config.BankDoorModels) do
        local object = GetClosestObjectOfType(DoorCoords.x, DoorCoords.y, DoorCoords.z, 1.5, GetHashKey(v), false, false, false)
        if object ~= 0 then
            TriggerServerEvent("Pug:server:OpenBanDoorForEveryone", DoorCoords, heist, stepNumber)
            break
        end
    end
end
------------------------------

---------- [Door Locks] ----------
RegisterNUICallback('RequestDoors', function(data, cb)
    local doors = {}
    for prop, doorData in pairs(AllDoorData) do
        if doorData and doorData.Coords then
            table.insert(doors, {
                id = doorData.Name,
                name = doorData.Name or "Un Named Door",
                coords = {
                    x = doorData.Coords.x,
                    y = doorData.Coords.y,
                    z = doorData.Coords.z
                }
            })
        end
    end
    if GetResourceState("ox_doorlock") == 'started' then
        local DoorLocks = nil
        Config.FrameworkFunctions.TriggerCallback('Pug:callback:GetOxDoorLocks', function(doorLocks)
            DoorLocks = doorLocks
            for i, door in ipairs(DoorLocks) do
                if door and door.coords then
                    table.insert(doors, {
                        id = door.id,
                        label = door.name,
                        coords = {
                            x = door.coords.x,
                            y = door.coords.y,
                            z = door.coords.z
                        }
                    })
                else
                    if Config.Debug then
                        PrintDebug('Invalid door data:', json.encode(door))
                    end
                end
            end
            cb(doors)
        end)
    elseif GetResourceState("qb-doorlock") == 'started' then
        Config.FrameworkFunctions.TriggerCallback('qb-doorlock:server:setupDoors', function(DoorList)
            DoorList = DoorList or {}
            for i, door in ipairs(DoorList) do
                if door then
                    -- Check if we have a double door
                    if door.doorType == 'double' and door.doors then
                        for j, subdoor in ipairs(door.doors) do
                            if subdoor and subdoor.objCoords then
                                PrintDebug(subdoor.objCoords, "subdoor.objCoords")
                                table.insert(doors, {
                                    id = i,  
                                    name = door.Name or subdoor.objName,
                                    coords = {
                                        x = subdoor.objCoords.x,
                                        y = subdoor.objCoords.y,
                                        z = subdoor.objCoords.z
                                    }
                                })
                            else
                                PrintDebug("Invalid subdoor data:", json.encode(subdoor))
                            end
                        end
                    elseif door.objCoords then
                        -- Single door
                        PrintDebug(door.objCoords, "door.objCoords")
                        table.insert(doors, {
                            id = i,
                            name = door.Name or door.objName,
                            coords = {
                                x = door.objCoords.x,
                                y = door.objCoords.y,
                                z = door.objCoords.z
                            }
                        })
                    else
                        PrintDebug("Invalid door data:", json.encode(door))
                    end
                end
            end
            cb(doors)
        end)
    elseif GetResourceState("rcore_doorlock") == 'started' then
        local createdBy = 'admin'  
        local doorsFromRcore = exports.rcore_doorlock:getDoorsCreatedBy(createdBy)

        for _, door in pairs(doorsFromRcore) do
            if door and door.coords then
                local doorCoords = vector3(door.coords.x, door.coords.y, door.coords.z)
                table.insert(doors, {
                    id = door.id,
                    label = door.label or "Unnamed Door",
                    coords = {
                        x = door.coords.x,
                        y = door.coords.y,
                        z = door.coords.z
                    }
                })
            end
        end
        cb(doors)
    elseif GetResourceState("cd_doorlock") == 'started' then
        local cdDoors = exports['cd_doorlock']:GetAllDoors() or {}
        for _, door in pairs(cdDoors) do
            if door then
                local coords = door.coords or door.door_coords or door.objCoords or door.object_coords

                if not coords and door.doors then
                    for _, subdoor in pairs(door.doors) do
                        coords = subdoor.coords or subdoor.door_coords or subdoor.objCoords or subdoor.object_coords
                        if coords then break end
                    end
                end

                if coords then
                    table.insert(doors, {
                        id = door.unique_id,
                        name = door.door_name or door.name or door.label or "Unnamed Door",
                        label = door.door_name or door.name or door.label or "Unnamed Door",
                        coords = {
                            x = coords.x,
                            y = coords.y,
                            z = coords.z
                        },
                        locationGroup = door.location_group
                    })
                elseif Config.Debug then
                    PrintDebug("Invalid cd_doorlock door data:", json.encode(door))
                end
            end
        end
        cb(doors)
    else
        PrintDebug('^2NO SUPPORTED DOOR LOCK SCRIPT WAS FOUND. PLEASE USE EITHER qb-doorlock, ox_doorlock, OR rcore_doorlock')
        cb({})
    end
end)
RegisterNUICallback('GetClosestDoor', function(data, cb)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local closestDoor = nil
    local closestDistance = nil
    local RanCheck = false
    if GetResourceState("ox_doorlock") == 'started' then
        Config.FrameworkFunctions.TriggerCallback('Pug:callback:GetOxDoorLocks', function(DoorLocks)
            DoorLocks = DoorLocks or {}
            for i, door in ipairs(DoorLocks) do
                if door and door.coords then
                    local doorCoords = vector3(door.coords.x, door.coords.y, door.coords.z)
                    local distance = #(playerCoords - doorCoords)
                    if not closestDistance or distance < closestDistance then
                        closestDistance = distance
                        closestDoor = {
                            id = door.id,
                            name = door.name,
                            coords = {
                                x = door.coords.x,
                                y = door.coords.y,
                                z = door.coords.z
                            }
                        }
                    end
                end
            end
            RanCheck = true
        end)
        
    elseif GetResourceState("qb-doorlock") == 'started' then
        Config.FrameworkFunctions.TriggerCallback('qb-doorlock:server:setupDoors', function(DoorList)
            DoorList = DoorList or {}
            for i, door in ipairs(DoorList) do
                if door then
                    -- If this is a double door, loop over its two sub-doors
                    if door.doorType == 'double' and door.doors then
                        for j, subdoor in ipairs(door.doors) do
                            if subdoor.objCoords then
                                local subdoorCoords = vector3(
                                    subdoor.objCoords.x, 
                                    subdoor.objCoords.y, 
                                    subdoor.objCoords.z
                                )
                                local distance = #(playerCoords - subdoorCoords)
                                if not closestDistance or distance < closestDistance then
                                    closestDistance = distance
                                    closestDoor = {
                                        id = i, 
                                        name = door.Name or subdoor.objName,
                                        coords = {
                                            x = subdoor.objCoords.x,
                                            y = subdoor.objCoords.y,
                                            z = subdoor.objCoords.z
                                        }
                                    }
                                end
                            end
                        end
                    -- Otherwise, treat it as a single door
                    elseif door.objCoords then
                        local doorCoords = vector3(
                            door.objCoords.x,
                            door.objCoords.y,
                            door.objCoords.z
                        )
                        local distance = #(playerCoords - doorCoords)
                        if not closestDistance or distance < closestDistance then
                            closestDistance = distance
                            closestDoor = {
                                id = i,
                                name = door.Name or door.objName,
                                coords = {
                                    x = door.objCoords.x,
                                    y = door.objCoords.y,
                                    z = door.objCoords.z
                                }
                            }
                        end
                    end
                end
            end
            RanCheck = true
        end)
    elseif GetResourceState("rcore_doorlock") == 'started' then
        print("rcore_doorlock started")
        local createdBy = 'admin'  
        local doorsFromRcore = exports.rcore_doorlock:getDoorsCreatedBy(createdBy)

        for _, door in pairs(doorsFromRcore) do
            if door and door.coords then
                local doorCoords = vector3(door.coords.x, door.coords.y, door.coords.z)
                local distance = #(playerCoords - doorCoords)
                if not closestDistance or distance < closestDistance then
                    closestDistance = distance
                    closestDoor = {
                        id = door.id,
                        name = door.label or "Unnamed Door",
                        coords = {
                            x = door.coords.x,
                            y = door.coords.y,
                            z = door.coords.z
                        }
                    }
                end
            end
        end
        RanCheck = true
    elseif GetResourceState("cd_doorlock") == 'started' then
        local door = exports['cd_doorlock']:GetDoorDataFull_closest()

        if door then
            local coords = door.coords or door.door_coords or door.objCoords or door.object_coords

            if not coords and door.doors then
                for _, subdoor in pairs(door.doors) do
                    coords = subdoor.coords or subdoor.door_coords or subdoor.objCoords or subdoor.object_coords
                    if coords then break end
                end
            end

            if coords then
                closestDoor = {
                    id = door.unique_id,
                    name = door.door_name or door.name or door.label or "Unnamed Door",
                    coords = {
                        x = coords.x,
                        y = coords.y,
                        z = coords.z
                    },
                    locationGroup = door.location_group
                }

                closestDistance = #(playerCoords - vector3(coords.x, coords.y, coords.z))
            elseif Config.Debug then
                PrintDebug("Invalid closest cd_doorlock door data:", json.encode(door))
            end
        end

        RanCheck = true
    else
        PrintDebug('^2NO SUPPORTED DOOR LOCK SCRIPT WAS FOUND. PLEASE USE EITHER qb-doorlock, ox_doorlock, OR rcore_doorlock')
        RanCheck = true
    end
    local timeoutAt = GetGameTimer() + 5000
    while not RanCheck do
        Wait(50)
        if GetGameTimer() > timeoutAt then
            PrintDebug('^1GetClosestDoor timed out waiting for doorlock callback^0')
            RanCheck = true
        end
    end
    for prop, doorData in pairs(AllDoorData) do
        if doorData and doorData.Coords then
            local doorCoords = vector3(doorData.Coords.x, doorData.Coords.y, doorData.Coords.z)
            local distance = #(playerCoords - doorCoords)
            if not closestDistance or distance < closestDistance then
                closestDistance = distance
                closestDoor = {
                    id = doorData.Name,
                    name = doorData.Name or "Un Named Door",
                    coords = {
                        x = doorData.Coords.x,
                        y = doorData.Coords.y,
                        z = doorData.Coords.z
                    }
                }
            end
        end
    end
    -- If using qb-doorlock, immediately send the closest door back
    cb(closestDoor or {})
end)
------------------------------

RegisterNetEvent("Pug:client:ShowHeistNotify", function(msg, type, length)
    Notify(msg, type, length)
end)
