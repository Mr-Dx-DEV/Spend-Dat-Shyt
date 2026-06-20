imagewebhook = "https://discord.com/api/webhooks/1452830099358351512/zjx3alsatTm39ydVk4oY7VlQMC3LmYN1DuK04ZWiZD18Vo0mpyMMJfaJ5zDrceLUx8GG"

local webhookurl = "https://discord.com/api/webhooks/1448436346011258972/GHLzbhgMlJiYsmp_dwFgc6uftsDUr5baAHV2yHuE-4zwePeebkgGC9l0HTfy-eBEXyUS" --write webhookurl here
local iconurl = "https://i.imgur.com/3snGmGq.png" -- put your icon for webhok here
local titletext = "House Log"

function AddLog(playersource, propertyid, action)
	if Config.WebHooks == true then
		local houselocationhandler = housinglocations[tostring(propertyid)]
		local textdata = ""
		if action == "purchased" then
			textdata = "Player purchased property id "..propertyid..""
		elseif action == "rented" then
			textdata = "Player rented property id "..propertyid..""		
		elseif action == "lockpicked" then
			textdata = "Player lockpicked property id "..propertyid..""	
		elseif action == "raid" then
			textdata = "Player raided property id "..propertyid..""	
		elseif action == "propertysold" then
			textdata = "Player sold property id "..propertyid..""		
		elseif action == "propertytransfered" then
			textdata = "Player transfered property id "..propertyid.." to "..houselocationhandler.owner..""			
		elseif action == "robbery" then
			textdata = "Player started robbing property with id ."..propertyid..""		
		elseif action == "propertytermintaed" then
			textdata = "Property with id ."..propertyid.." was confiscated"		
		elseif action == "propertyrentstop" then
			textdata = "Player Cancelled property rental property id "..propertyid..""					
		end
		local identifier = "no info" 
		local license   = "no info"
		local liveid    = "no info"
		local xblid     = "no info"
		local discord   = "no info"
		local playerip = "no info"        
		if playersource == nil then
			local logtextdata = "\n\n**" ..tostring(textdata).. "**"
			local embed = {
				{
					["title"] = titletext,
					["type"] = "rich",
					["description"] = logtextdata,
					["color"] = 16738047,
					["footer"] = {["text"] = "Made by Kanikuly#7253 Provided by RTX Development discord.gg/P6KdaDpgAk | " ..os.date("%x (%X %p)"), ["icon_url"] = iconurl},
				}
			}
			PerformHttpRequest(webhookurl, function(err, text, headers) end, "POST", json.encode({username = name, embeds = embed}), { ["Content-Type"] = "application/json" })			
		else
			local sourceplayername = GetPlayerName(playersource)
			for k,v in ipairs(GetPlayerIdentifiers(playersource))do
				if string.sub(v, 1, string.len("steam:")) == "steam:" then
					identifier = v
				elseif string.sub(v, 1, string.len("license:")) == "license:" then
					license = v
				elseif string.sub(v, 1, string.len("live:")) == "live:" then
					liveid = v
				elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
					xblid  = v
				elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
					discord = v
				elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
					playerip = v
				end
			end		
			local logtextdata = "**Player:** " ..tostring(sourceplayername).. "\n**Identifier:** " ..tostring(identifier).. "\n**License:** " ..tostring(license).. "\n**LiveID:** " ..tostring(liveid).. "\n**XboxID:** " ..tostring(xblid).. "\n**Discord:** " ..tostring(discord).. "\n**IP:** " ..tostring(playerip).. "\n\n**" ..tostring(textdata).. "**"
			local embed = {
				{
					["title"] = titletext,
					["type"] = "rich",
					["description"] = logtextdata,
					["color"] = 16738047,
					["footer"] = {["text"] = "Made by Kanikuly#7253 Provided by RTX Development discord.gg/P6KdaDpgAk | " ..os.date("%x (%X %p)"), ["icon_url"] = iconurl},
				}
			}
			PerformHttpRequest(webhookurl, function(err, text, headers) end, "POST", json.encode({username = name, embeds = embed}), { ["Content-Type"] = "application/json" })		
		end
	end
end

AddEventHandler("rtx_housing:Global:AddLog", function(playersource, propertyid, action)
    AddLog(playersource, propertyid, action)
end)

function GetPlayerPermissionsCreator(playersource)
	local playerallowed = false
	local actions = {create = false, delete = false, removeownership = false, edit = false, tp = false}
	if Config.PropertyCreatorPermissions.acepermissionsforusecontrolmenu.enable == true then
		if IsPlayerAceAllowed(playersource, Config.PropertyCreatorPermissions.acepermissionsforusecontrolmenu.permission) then 
			playerallowed = true
			actions =  Config.PropertyCreatorPermissions.acepermissionsforusecontrolmenu.actions
		end
	end
	if Config.PropertyCreatorPermissions.jobpermissionsforusecontrolmenu.enable == true then
		if Config.Framework == "esx" then
			local xPlayer = ESX.GetPlayerFromId(playersource)
			if xPlayer then
				if xPlayer.job.name == Config.PropertyCreatorPermissions.jobpermissionsforusecontrolmenu.jobname then
					playerallowed = true
					actions =  Config.PropertyCreatorPermissions.jobpermissionsforusecontrolmenu.actions
				end
			end
		elseif Config.Framework == "qbcore" then
			local xPlayer = QBCore.Functions.GetPlayer(playersource)
			if xPlayer then	
				if xPlayer.PlayerData.job.name == Config.PropertyCreatorPermissions.jobpermissionsforusecontrolmenu.jobname then
					playerallowed = true
					actions =  Config.PropertyCreatorPermissions.jobpermissionsforusecontrolmenu.actions
				end
			end
		elseif Config.Framework == "standalone" then
			-- add here your job check function
		end
	end	
	if Config.PropertyCreatorPermissions.identifierspermissionsforcontrolmenu == true then
		local licensedata = "unknown"
		local steamdata = "unknown"
		local xboxdata = "unknown"
		local livedata = "unknown"
		local discorddata = "unknown"
		local ipdata = "unknown"
		for i, licensehandler in ipairs(GetPlayerIdentifiers(playersource)) do
			if string.sub(licensehandler, 1,string.len("steam:")) == "steam:" then
				steamdata = tostring(licensehandler)
			elseif string.sub(licensehandler, 1,string.len("license:")) == "license:" then
				licensedata = tostring(licensehandler)
			elseif string.sub(licensehandler, 1,string.len("live:")) == "live:" then
				livedata = tostring(licensehandler)
			elseif string.sub(licensehandler, 1,string.len("xbl:")) == "xbl:" then
				xboxdata = tostring(licensehandler)
			elseif string.sub(licensehandler, 1,string.len("discord:")) == "discord:" then
				discorddata = tostring(licensehandler)
			elseif string.sub(licensehandler, 1,string.len("ip:")) == "ip:" then
				ipdata = tostring(licensehandler)
			end
		end			
		for i, permissionhandler in ipairs(Config.PropertyCreatorPermissions.permissionsviaidentifiers) do
			if permissionhandler.permissiontype == "license" then
				if permissionhandler.permisisondata == licensedata then
					playerallowed = true
					actions = permissionhandler.actions
					break
				end
			end
			if permissionhandler.permissiontype == "steam" then
				if permissionhandler.permisisondata == steamdata then
					playerallowed = true
					actions = permissionhandler.actions
					break
				end
			end	
			if permissionhandler.permissiontype == "xbox" then
				if permissionhandler.permisisondata == xboxdata then
					playerallowed = true
					actions = permissionhandler.actions
					break
				end
			end	
			if permissionhandler.permissiontype == "live" then
				if permissionhandler.permisisondata == livedata then
					playerallowed = true
					actions = permissionhandler.actions
					break
				end
			end	
			if permissionhandler.permissiontype == "discord" then
				if permissionhandler.permisisondata == discorddata then
					playerallowed = true
					actions = permissionhandler.actions
					break
				end
			end		
			if permissionhandler.permissiontype == "ip" then
				if permissionhandler.permisisondata == ipdata then
					playerallowed = true
					actions = permissionhandler.actions
					break
				end
			end							
		end
	end		
	return playerallowed, actions
end

function AddMoneyRTX(playersource, moneydata)
	if not playersource or not moneydata then
		DebugMode("[RTX HOUSING] AddMoneyRTX invalid params | src: " .. tostring(playersource) .. " | money: " .. tostring(moneydata))
		return false
	end

	if Config.Framework == "esx" then
		local xPlayer = ESX.GetPlayerFromId(playersource)
		if not xPlayer then
			DebugMode("[RTX HOUSING] AddMoneyRTX ESX xPlayer nil | src: " .. tostring(playersource))
			return false
		end

		local ok = false

		if Config.PaymentMethod == "cash" then
			ok = xpcall(function()
				xPlayer.addMoney(moneydata)
			end, function(err)
				DebugMode("[RTX HOUSING] AddMoneyRTX ESX cash error | src: " .. tostring(playersource) .. " | error: " .. tostring(err))
			end)

		elseif Config.PaymentMethod == "bank" then
			ok = xpcall(function()
				xPlayer.addAccountMoney('bank', moneydata)
			end, function(err)
				DebugMode("[RTX HOUSING] AddMoneyRTX ESX bank error | src: " .. tostring(playersource) .. " | error: " .. tostring(err))
			end)

		else
			ok = xpcall(function()
				xPlayer.addMoney(moneydata)
			end, function(err)
				DebugMode("[RTX HOUSING] AddMoneyRTX ESX default error | src: " .. tostring(playersource) .. " | error: " .. tostring(err))
			end)
		end

		return ok

	elseif Config.Framework == "qbcore" then
		local xPlayer = QBCore.Functions.GetPlayer(playersource)
		if not xPlayer then
			DebugMode("[RTX HOUSING] AddMoneyRTX QBCore xPlayer nil | src: " .. tostring(playersource))
			return false
		end

		local paymentType = "cash"
		if Config.PaymentMethod == "bank" then
			paymentType = "bank"
		end

		local ok = xpcall(function()
			xPlayer.Functions.AddMoney(paymentType, moneydata, "rtx_housing")
		end, function(err)
			DebugMode("[RTX HOUSING] AddMoneyRTX QBCore error | src: " .. tostring(playersource) .. " | error: " .. tostring(err))
		end)

		return ok

	elseif Config.Framework == "standalone" then
		return true
	end

	return false
end

function RemoveMoneyRTX(playersource, moneydata)
	if not playersource or not moneydata then
		DebugMode("[RTX HOUSING] RemoveMoneyRTX invalid params | src: " .. tostring(playersource) .. " | money: " .. tostring(moneydata))
		return false
	end

	if Config.Framework == "esx" then
		local xPlayer = ESX.GetPlayerFromId(playersource)
		if not xPlayer then
			DebugMode("[RTX HOUSING] RemoveMoneyRTX ESX xPlayer nil | src: " .. tostring(playersource))
			return false
		end

		local ok = false

		if Config.PaymentMethod == "cash" then
			ok = xpcall(function()
				xPlayer.removeMoney(moneydata)
			end, function(err)
				DebugMode("[RTX HOUSING] RemoveMoneyRTX ESX cash error | src: " .. tostring(playersource) .. " | error: " .. tostring(err))
			end)

		elseif Config.PaymentMethod == "bank" then
			local bankAccount = xPlayer.getAccount and xPlayer.getAccount('bank') or nil
			local bankMoney = bankAccount and bankAccount.money or 0

			if tonumber(bankMoney) < tonumber(moneydata) then
				DebugMode("[RTX HOUSING] RemoveMoneyRTX ESX insufficient bank money | src: " .. tostring(playersource))
				return false
			end

			ok = xpcall(function()
				xPlayer.removeAccountMoney('bank', moneydata)
			end, function(err)
				DebugMode("[RTX HOUSING] RemoveMoneyRTX ESX bank error | src: " .. tostring(playersource) .. " | error: " .. tostring(err))
			end)

		elseif Config.PaymentMethod == "both" then
			local moneycash = tonumber(xPlayer.getMoney and xPlayer.getMoney() or 0) or 0
			local bankAccount = xPlayer.getAccount and xPlayer.getAccount('bank') or nil
			local moneybank = tonumber(bankAccount and bankAccount.money or 0) or 0

			DebugMode("[RTX HOUSING] RemoveMoneyRTX ESX both | src: " .. tostring(playersource) .. " | cash: " .. tostring(moneycash) .. " | bank: " .. tostring(moneybank))

			if moneycash >= moneydata then
				ok = xpcall(function()
					xPlayer.removeMoney(moneydata)
				end, function(err)
					DebugMode("[RTX HOUSING] RemoveMoneyRTX ESX both-cash error | src: " .. tostring(playersource) .. " | error: " .. tostring(err))
				end)
			elseif moneybank >= moneydata then
				ok = xpcall(function()
					xPlayer.removeAccountMoney('bank', moneydata)
				end, function(err)
					DebugMode("[RTX HOUSING] RemoveMoneyRTX ESX both-bank error | src: " .. tostring(playersource) .. " | error: " .. tostring(err))
				end)
			else
				DebugMode("[RTX HOUSING] RemoveMoneyRTX ESX both failed insufficient funds | src: " .. tostring(playersource))
				return false
			end
		end

		return ok

	elseif Config.Framework == "qbcore" then
		local xPlayer = QBCore.Functions.GetPlayer(playersource)
		if not xPlayer then
			DebugMode("[RTX HOUSING] RemoveMoneyRTX QBCore xPlayer nil | src: " .. tostring(playersource))
			return false
		end

		local ok = false

		if Config.PaymentMethod == "cash" then
			ok = xpcall(function()
				xPlayer.Functions.RemoveMoney('cash', moneydata, "rtx_housing")
			end, function(err)
				DebugMode("[RTX HOUSING] RemoveMoneyRTX QBCore cash error | src: " .. tostring(playersource) .. " | error: " .. tostring(err))
			end)

		elseif Config.PaymentMethod == "bank" then
			ok = xpcall(function()
				xPlayer.Functions.RemoveMoney('bank', moneydata, "rtx_housing")
			end, function(err)
				DebugMode("[RTX HOUSING] RemoveMoneyRTX QBCore bank error | src: " .. tostring(playersource) .. " | error: " .. tostring(err))
			end)

		elseif Config.PaymentMethod == "both" then
			local moneycash = tonumber(xPlayer.Functions.GetMoney('cash')) or 0
			local moneybank = tonumber(xPlayer.Functions.GetMoney('bank')) or 0

			DebugMode("[RTX HOUSING] RemoveMoneyRTX QBCore both | src: " .. tostring(playersource) .. " | cash: " .. tostring(moneycash) .. " | bank: " .. tostring(moneybank))

			if moneycash >= moneydata then
				ok = xpcall(function()
					xPlayer.Functions.RemoveMoney('cash', moneydata, "rtx_housing")
				end, function(err)
					DebugMode("[RTX HOUSING] RemoveMoneyRTX QBCore both-cash error | src: " .. tostring(playersource) .. " | error: " .. tostring(err))
				end)
			elseif moneybank >= moneydata then
				ok = xpcall(function()
					xPlayer.Functions.RemoveMoney('bank', moneydata, "rtx_housing")
				end, function(err)
					DebugMode("[RTX HOUSING] RemoveMoneyRTX QBCore both-bank error | src: " .. tostring(playersource) .. " | error: " .. tostring(err))
				end)
			else
				DebugMode("[RTX HOUSING] RemoveMoneyRTX QBCore both failed insufficient funds | src: " .. tostring(playersource))
				return false
			end
		end

		return ok

	elseif Config.Framework == "standalone" then
		return true
	end

	return false
end

function GetMoneyRTX(playersource)
	if not playersource then
		DebugMode("[RTX HOUSING] GetMoneyRTX invalid source")
		return 0
	end

	local moneydata = 0

	if Config.Framework == "esx" then
		local xPlayer = ESX.GetPlayerFromId(playersource)
		if not xPlayer then
			DebugMode("[RTX HOUSING] GetMoneyRTX ESX xPlayer nil | src: " .. tostring(playersource))
			return 0
		end

		local cash = tonumber(xPlayer.getMoney and xPlayer.getMoney() or 0) or 0
		local bankAccount = xPlayer.getAccount and xPlayer.getAccount('bank') or nil
		local bank = tonumber(bankAccount and bankAccount.money or 0) or 0

		if Config.PaymentMethod == "cash" then
			moneydata = cash
		elseif Config.PaymentMethod == "bank" then
			moneydata = bank
		elseif Config.PaymentMethod == "both" then
			moneydata = math.max(cash, bank)
		else
			moneydata = cash
		end

	elseif Config.Framework == "qbcore" then
		local xPlayer = QBCore.Functions.GetPlayer(playersource)
		if not xPlayer then
			DebugMode("[RTX HOUSING] GetMoneyRTX QBCore xPlayer nil | src: " .. tostring(playersource))
			return 0
		end

		local cash = tonumber(xPlayer.Functions.GetMoney('cash')) or 0
		local bank = tonumber(xPlayer.Functions.GetMoney('bank')) or 0

		if Config.PaymentMethod == "cash" then
			moneydata = cash
		elseif Config.PaymentMethod == "bank" then
			moneydata = bank
		elseif Config.PaymentMethod == "both" then
			moneydata = math.max(cash, bank)
		else
			moneydata = cash
		end

	elseif Config.Framework == "standalone" then
		moneydata = 99999999999
	end

	return tonumber(moneydata) or 0
end

function GetPlayerIdentifierRTX(playersource)
	if not playersource then
		DebugMode("[RTX HOUSING] GetPlayerIdentifierRTX invalid source")
		return ""
	end

	local playeridentifierdata = ""

	if Config.Framework == "esx" then
		local xPlayer = ESX.GetPlayerFromId(playersource)
		if xPlayer and xPlayer.identifier then
			playeridentifierdata = tostring(xPlayer.identifier)
		else
			local ids = GetPlayerIdentifiers(playersource)
			playeridentifierdata = ids and ids[1] or ""
			DebugMode("[RTX HOUSING] GetPlayerIdentifierRTX ESX fallback used | src: " .. tostring(playersource))
		end

	elseif Config.Framework == "qbcore" then
		local xPlayer = QBCore.Functions.GetPlayer(playersource)
		if xPlayer and xPlayer.PlayerData and xPlayer.PlayerData.citizenid then
			playeridentifierdata = tostring(xPlayer.PlayerData.citizenid)
		else
			local ids = GetPlayerIdentifiers(playersource)
			playeridentifierdata = ids and ids[1] or ""
			DebugMode("[RTX HOUSING] GetPlayerIdentifierRTX QBCore fallback used | src: " .. tostring(playersource))
		end

	elseif Config.Framework == "standalone" then
		local ids = GetPlayerIdentifiers(playersource)
		playeridentifierdata = ids and ids[1] or ""
	end

	return playeridentifierdata or ""
end

function GetPlayerNameRTX(playersource)
	if not playersource then
		DebugMode("[RTX HOUSING] GetPlayerNameRTX invalid source")
		return "Unknown"
	end

	local playername = GetPlayerName(playersource) or "Unknown"

	if Config.Framework == "esx" then
		local xPlayer = ESX.GetPlayerFromId(playersource)
		if xPlayer and xPlayer.getName then
			local esxName = xPlayer.getName()
			if esxName and esxName ~= "" then
				playername = tostring(esxName)
			end
		end

	elseif Config.Framework == "qbcore" then
		local xPlayer = QBCore.Functions.GetPlayer(playersource)
		if xPlayer and xPlayer.PlayerData and xPlayer.PlayerData.charinfo then
			local firstname = xPlayer.PlayerData.charinfo.firstname
			local lastname = xPlayer.PlayerData.charinfo.lastname

			if firstname and lastname then
				playername = tostring(firstname) .. " " .. tostring(lastname)
			elseif firstname then
				playername = tostring(firstname)
			elseif lastname then
				playername = tostring(lastname)
			end
		else
			DebugMode("[RTX HOUSING] GetPlayerNameRTX QBCore charinfo missing | src: " .. tostring(playersource))
		end
	end

	return playername
end

function CanPlayerPurchaseThisProperty(playersource, houselocationid)
	local houselocationhandler = housinglocations[tostring(houselocationid)]
    -- Purchase permission check placeholder
    -- Always allow for now, customize later (VIP, jobs, restrictions, etc.)
    return true
end


function GiveItemRTX(playersource, itemname, itemcount)
	if Config.Framework == "esx" then
		if Config.OxInventory == true then
			exports.ox_inventory:AddItem(playersource, itemname, itemcount)
		else						
			local xPlayer = ESX.GetPlayerFromId(playersource)
			if xPlayer then
				xPlayer.addInventoryItem(itemname, itemcount)			
			end	
		end
	end
	if Config.Framework == "qbcore" then
		if Config.OxInventory == true then
			exports.ox_inventory:AddItem(playersource, itemname, itemcount)
		else						
			local xPlayer = QBCore.Functions.GetPlayer(playersource)
			if xPlayer then	
				if Config.QBCoreNewInventoryVersion == true then
					exports['qb-inventory']:AddItem(playersource, itemname, itemcount, false, false, '')
				else
					xPlayer.Functions.AddItem(itemname, itemcount, false, {})
				end
			end		
		end
	end		
	if Config.Framework == "standalone" then
		if Config.OxInventory == true then
			exports.ox_inventory:AddItem(playersource, itemname, itemcount)
		end							
	end
end

function GiveItemKey(playersource, keyidentifier)
	if Config.InventorySystem == "oxinventory" then
		exports.ox_inventory:AddItem(playersource, "house_key", 1, {keyid = keyidentifier})
    elseif Config.InventorySystem == "qbcoreinventory" then

        local Player = QBCore.Functions.GetPlayer(playersource)
        if Player then
            Player.Functions.AddItem("house_key", 1, false, {
                keyid = keyidentifier
            })
            TriggerClientEvent('inventory:client:ItemBox', playersource, QBCore.Shared.Items["house_key"], "add")
        end

    elseif Config.InventorySystem == "codeminventory" then

		exports['codem-inventory']:AddItem(
			playersource,
			"house_key",
			1, 
			nil,
			{
				keyid = keyidentifier
			} 
		)

    elseif Config.InventorySystem == "coreinventory" then

		local inventory = playersource 
		local inventoryType = "player"

		local metadata = {
			keyid = keyidentifier
		}

		local itemsAdd = exports.core_inventory:addItem(
			inventory,
			"house_key",
			1,
			metadata,
			inventoryType
		)


    elseif Config.InventorySystem == "psinventory" then

        local Player = QBCore.Functions.GetPlayer(playersource)
        if Player then
            Player.Functions.AddItem("house_key", 1, false, {
                keyid = keyidentifier
            })
            TriggerClientEvent('inventory:client:ItemBox', playersource, QBCore.Shared.Items["house_key"], "add")
        end

    elseif Config.InventorySystem == "jaksam_inventory" then

		local success, result = exports['jaksam_inventory']:addItem(
			playersource,
			'house_key',
			1,
			{
				keyid = keyidentifier
			}
		)


    elseif Config.InventorySystem == "tgiann-inventory" then

		local metadata = {
			keyid = keyidentifier
		}

		local success = exports["tgiann-inventory"]:AddItem(
			playersource,
			"house_key",
			1,  
			nil,
			metadata,
			false 
		)

		if success then
		end
    end
end

function RemoveItemRTX(playersource, itemname, itemcount)
	local removed = false
	if Config.Framework == "esx" then
		if Config.OxInventory == true then
			local success = exports.ox_inventory:RemoveItem(playersource, itemname, itemcount)
			if success then 
				removed = true 
			end		
		else			
			local xPlayer = ESX.GetPlayerFromId(playersource)
			if xPlayer then
				local itemdata = xPlayer.getInventoryItem(itemname)
				if itemdata and itemdata.count >= itemcount then				
					xPlayer.removeInventoryItem(itemname, itemcount)	
					removed = true
				end
			end		
		end
	end
	if Config.Framework == "qbcore" then
		if Config.OxInventory == true then
			local success = exports.ox_inventory:RemoveItem(playersource, itemname, itemcount)
			if success then 
				removed = true 
			end		
		else				
			local xPlayer = QBCore.Functions.GetPlayer(playersource)
			if xPlayer then	
				if Config.QBCoreNewInventoryVersion == true then
					local hasItem = exports['qb-inventory']:HasItem(playersource, itemname, itemcount)
					if hasItem then			
						exports['qb-inventory']:RemoveItem(playersource, itemname, itemcount, false, 'qb-inventory:testRemove')
						removed = true
					end				
				else
					local itemdata = xPlayer.Functions.GetItemByName(itemname)
					if itemdata and itemdata.amount >= itemcount then					
						xPlayer.Functions.RemoveItem(itemname, itemcount, false, {})
						removed = true
					end
				end
			end		
		end
	end		
	if Config.Framework == "standalone" then
		if Config.OxInventory == true then
			local success = exports.ox_inventory:RemoveItem(playersource, itemname, itemcount)
			if success then 
				removed = true 
			end		
		else				
			removed = true
		end
	end
	return removed
end


function GetItemRTX(playersource, itemname, itemcount)
	local removed = false
	if Config.Framework == "esx" then
		if Config.OxInventory == true then
			local count = exports.ox_inventory:Search(playersource, 'count', itemname)
			if count and  count >= itemcount then	
				removed = true
			end
		else
			local xPlayer = ESX.GetPlayerFromId(playersource)
			if xPlayer then
				local itemdata = xPlayer.getInventoryItem(itemname)
				if itemdata and itemdata.count >= itemcount then		
					removed = true
				end
			end	
		end
	end
	if Config.Framework == "qbcore" then
		if Config.OxInventory == true then
			local count = exports.ox_inventory:Search(playersource, 'count', itemname)
			if count and count >= itemcount then	
				removed = true
			end
		else		
			local xPlayer = QBCore.Functions.GetPlayer(playersource)
			if xPlayer then	
				if Config.QBCoreNewInventoryVersion == true then
					local hasItem = exports['qb-inventory']:HasItem(playersource, itemname, itemcount)
					if hasItem then			
						removed = true
					end				
				else
					local itemdata = xPlayer.Functions.GetItemByName(itemname)
					if itemdata and itemdata.amount >= itemcount then
						removed = true
					end
				end
			end		
		end
	end		
	if Config.Framework == "standalone" then
		if Config.OxInventory == true then
			local count = exports.ox_inventory:Search(playersource, 'count', itemname)
			if count and count >= itemcount then	
				removed = true
			end
		else	
			removed = true
		end
	end
	return removed
end

function CheckHouseCreatorPermission(playersource)
	local permission = false
	local actions = {create = false, delete = false, removeownership = false, edit = false, tp = false}
	if Config.Framework == "esx" then
		local xPlayer = ESX.GetPlayerFromId(playersource)
		local playergroup = xPlayer.getGroup()
		if playergroup == "admin" or playergroup == "superadmin" then
			permission = true
			actions = {create = true, delete = true, removeownership = true, edit = true, tp = true}
		end
	elseif Config.Framework == "qbcore" then
		if QBCore.Functions.HasPermission(playersource, 'admin') or QBCore.Functions.HasPermission(playersource, 'god') then
			permission = true
			actions = {create = true, delete = true, removeownership = true, edit = true, tp = true}
		end
	elseif Config.Framework == "standalone" then
		permission = true
		actions = {create = true, delete = true, removeownership = true, edit = true, tp = true}
	end	
	if permission == false then
		local permissiondata, actionsdata = GetPlayerPermissionsCreator(playersource)
		permission = permissiondata
		actions = actionsdata
	end
	return permission, actions
end


function GetPlayerJobName(src)
    if Config.Framework == "esx" and ESX then
        local xPlayer = ESX.GetPlayerFromId(src)
        if xPlayer and xPlayer.job and xPlayer.job.name then
            return xPlayer.job.name
        end
    elseif Config.Framework == "qbcore" then
        local xPlayer = QBCore.Functions.GetPlayer(src)
        if xPlayer and xPlayer.PlayerData and xPlayer.PlayerData.job and xPlayer.PlayerData.job.name then
            return xPlayer.PlayerData.job.name
        end
    end
    return nil
end

function GetJobSources(jobsTable)
    local sources = {}

    if not jobsTable then
        return sources
    end

    if Config.Framework == "ESX" and ESX then
        for jobName, enabled in pairs(jobsTable) do
            if enabled then
                local xPlayers = ESX.GetExtendedPlayers('job', jobName)
                if xPlayers then
                    for _, xPlayer in ipairs(xPlayers) do
                        if xPlayer and xPlayer.source then
                            table.insert(sources, xPlayer.source)
                        end
                    end
                end
            end
        end

    elseif Config.Framework == "qbcore" and QBCore then
        for jobName, enabled in pairs(jobsTable) do
            if enabled then
                local players, count = QBCore.Functions.GetPlayersOnDuty(jobName)
                if players then
                    for _, v in pairs(players) do
                        local src = v

                        if type(v) ~= "number" then
                            if v.PlayerData and v.PlayerData.source then
                                src = v.PlayerData.source
                            else
                                src = nil
                            end
                        end

                        if src then
                            table.insert(sources, src)
                        end
                    end
                end
            end
        end
    end

    return sources
end


function GetTotalJobsOnline(jobsTable)
    local total = 0

    for jobName, enabled in pairs(jobsTable) do
        if enabled then

            if Config.Framework == "ESX" then
                total = total + (#ESX.GetExtendedPlayers('job', jobName) or 0)

            elseif Config.Framework == "qbcore" then
                local players, count = QBCore.Functions.GetPlayersOnDuty(jobName)
                total = total + (count or 0)
            end

        end
    end

    return total
end

function HasPlayerLockPick(playersource)
	local lockpick = false
	if Config.LockPickRaidSettings.LockPick.enabled == true then
		if Config.LockPickRaidSettings.LockPick.itemrequired == true then
			 local hasItem = GetItemRTX(playersource, Config.LockPickRaidSettings.LockPick.itemname, Config.LockPickRaidSettings.LockPick.itemcount)
			 if hasItem then
				lockpick = true
			end
		else
			lockpick = true
		end
	end
	return lockpick
end

function IsPlayerPolice(playersource)
	local police = false
	if Config.LockPickRaidSettings.Raid.enabled == true then
		if Config.LockPickRaidSettings.Raid.jobs[GetPlayerJobName(playersource)] then
			police = true
		end
	end
	return police
end

function HasPlayerRobberyItem(playersource)
	local robberyitem = true
	if Config.RobberySettings.itemrequired == true then
		 local hasItem = GetItemRTX(playersource, Config.RobberySettings.itemname, Config.RobberySettings.itemcount)
		 if hasItem then
			robberyitem = true
		else
			robberyitem = false
		end
	end
	return robberyitem
end

function CheckPropertyKeys(playersource, houselocationid)
	local houselocationhandler = housinglocations[tostring(houselocationid)]
	local havekeys = false
	for i, keyhandler in ipairs(houselocationhandler.keys) do
		if Config.InventorySystem == "oxinventory" then
			local count = exports.ox_inventory:Search(playersource, 'count', "house_key", {keyid = keyhandler.identifier})
			if count and count >= 1 then
				havekeys = true
			end
		elseif Config.InventorySystem == "qbcoreinventory" then
			local Player = QBCore.Functions.GetPlayer(playersource)
			if Player then
				local items = Player.Functions.GetItemsByName("house_key")

				if items then
					for _, item in pairs(items) do
						if item.info and item.info.keyid == keyhandler.identifier then
							havekeys = true
						end
					end
				end
			end		
		elseif Config.InventorySystem == "codeminventory" then

			local items = exports['codem-inventory']:GetInventory(playersource)
			if items then
				for _, item in pairs(items) do
					if item.name == "house_key"
					and item.metadata
					and item.metadata.keyid == keyhandler.identifier then
						havekeys = true
					end
				end
			end

		elseif Config.InventorySystem == "coreinventory" then

			local items = exports.core_inventory:GetInventory(playersource)
			if items then
				for _, item in pairs(items) do
					if item.name == "house_key"
					and item.metadata
					and item.metadata.keyid == keyhandler.identifier then
						havekeys = true
					end
				end
			end

		elseif Config.InventorySystem == "psinventory" then

			local Player = QBCore.Functions.GetPlayer(playersource)
			if Player then
				local items = Player.PlayerData.items
				if items then
					for _, item in pairs(items) do
						if item.name == "house_key"
						and item.info
						and item.info.keyid == keyhandler.identifier then
							havekeys = true
						end
					end
				end
			end

		elseif Config.InventorySystem == "chezza" then

			local items = exports['chezza_inventory']:GetPlayerInventory(playersource)
			if items then
				for _, item in pairs(items) do
					if item.name == "house_key"
					and item.metadata
					and item.metadata.keyid == keyhandler.identifier then
						havekeys = true
					end
				end
			end

		elseif Config.InventorySystem == "jaksam_inventory" then

			local items = exports['jaksam_inventory']:GetInventory(playersource)
			if items then
				for _, item in pairs(items) do
					if item.name == "house_key"
					and item.metadata
					and item.metadata.keyid == keyhandler.identifier then
						havekeys = true
					end
				end
			end

		elseif Config.InventorySystem == "tgiann-inventory" then

			local items = exports['tgiann-inventory']:GetPlayerItems(playersource)
			if items then
				for _, item in pairs(items) do
					if item.name == "house_key"
					and item.metadata
					and item.metadata.keyid == keyhandler.identifier then
						havekeys = true
					end
				end
			end
		end
	end
	return havekeys
end

function GetPropertyPermissions(playersource, houselocationid)
	local playeridentifier = GetPlayerIdentifierRTX(playersource)
	local perms = {}
	if housinglocations[tostring(houselocationid)].permissions[tostring(playeridentifier)] ~= nil or housinglocations[tostring(houselocationid)].tenants[tostring(playeridentifier)] ~= nil or housinglocations[tostring(houselocationid)].owner == tostring(playeridentifier) then
		if housinglocations[tostring(houselocationid)].tenants[tostring(playeridentifier)] ~= nil then
			perms = {
				["furnitureMenu"] = false,
				["unlocking"]     = false,
				["wardrobe"]      = false,
				["storage"]       = false,
				["manageKeys"]    = false,
				["upgrades"]      = false,
				["payBills"]      = false,
				["garage"]        = false,
				["orderServices"] = false,
				["tenants"]       = false,
				["clean"]         = false,
				["doorbell"]      = false,
				["cameras"]       = false,		
				["services"]       = false,	
				["positions"]       = false,
			}
			for perm, enabled in pairs(Config.TenantPropertyPermissions or {}) do
				if enabled == true and perms[perm] ~= nil then
					perms[perm] = true
				end
			end	
		elseif housinglocations[tostring(houselocationid)].owner == tostring(playeridentifier) then
			perms = {
				["furnitureMenu"] = true,
				["unlocking"]     = true,
				["wardrobe"]      = true,
				["storage"]       = true,
				["manageKeys"]    = true,
				["upgrades"]      = true,
				["payBills"]      = true,
				["garage"]        = true,
				["orderServices"] = true,
				["tenants"]       = true,
				["clean"]         = true,
				["doorbell"]      = true,
				["cameras"]       = true,		
				["services"]       = true,	
				["positions"]       = true,
			}			
		else
			perms = housinglocations[tostring(houselocationid)].permissions[tostring(playeridentifier)].permissions
		end
			
	else
		perms = {
			["furnitureMenu"] = false,
			["unlocking"]     = false,
			["wardrobe"]      = false,
			["storage"]       = false,
			["manageKeys"]    = false,
			["upgrades"]      = false,
			["payBills"]      = false,
			["garage"]        = false,
			["orderServices"] = false,
			["tenants"]       = false,
			["clean"]         = false,
			["doorbell"]      = false,
			["cameras"]       = false,		
			["services"]       = false,	
			["positions"]       = false,
		}
	end
	return perms
end

function GetPropertyPermission(playersource, houselocationid, permtypedata)
	local playeridentifier = GetPlayerIdentifierRTX(playersource)
	local perms = {}
	if housinglocations[tostring(houselocationid)].permissions[tostring(playeridentifier)] ~= nil or housinglocations[tostring(houselocationid)].tenants[tostring(playeridentifier)] ~= nil or housinglocations[tostring(houselocationid)].owner == tostring(playeridentifier) then
		if housinglocations[tostring(houselocationid)].tenants[tostring(playeridentifier)] ~= nil then
			perms = {
				["furnitureMenu"] = false,
				["unlocking"]     = false,
				["wardrobe"]      = false,
				["storage"]       = false,
				["manageKeys"]    = false,
				["upgrades"]      = false,
				["payBills"]      = false,
				["garage"]        = false,
				["orderServices"] = false,
				["tenants"]       = false,
				["clean"]         = false,
				["doorbell"]      = false,
				["cameras"]       = false,		
				["services"]       = false,	
				["positions"]       = false,
			}
			for perm, enabled in pairs(Config.TenantPropertyPermissions or {}) do
				if enabled == true and perms[perm] ~= nil then
					perms[perm] = true
				end
			end	
		elseif housinglocations[tostring(houselocationid)].owner == tostring(playeridentifier) then
			perms = {
				["furnitureMenu"] = true,
				["unlocking"]     = true,
				["wardrobe"]      = true,
				["storage"]       = true,
				["manageKeys"]    = true,
				["upgrades"]      = true,
				["payBills"]      = true,
				["garage"]        = true,
				["orderServices"] = true,
				["tenants"]       = true,
				["clean"]         = true,
				["doorbell"]      = true,
				["cameras"]       = true,		
				["services"]       = true,	
				["positions"]       = true,
			}			
		else
			perms = housinglocations[tostring(houselocationid)].permissions[tostring(playeridentifier)].permissions
		end
			
	else
		perms = {
			["furnitureMenu"] = false,
			["unlocking"]     = false,
			["wardrobe"]      = false,
			["storage"]       = false,
			["manageKeys"]    = false,
			["upgrades"]      = false,
			["payBills"]      = false,
			["garage"]        = false,
			["orderServices"] = false,
			["tenants"]       = false,
			["clean"]         = false,
			["doorbell"]      = false,
			["cameras"]       = false,		
			["services"]       = false,	
			["positions"]       = false,
		}
	end
	return perms[permtypedata]
end

function HasPlayerAnyPropertyPermissions(playersource, houselocationid)
	local playeridentifier = GetPlayerIdentifierRTX(playersource)
	local someperm = false
	if housinglocations[tostring(houselocationid)].permissions[tostring(playeridentifier)] ~= nil or housinglocations[tostring(houselocationid)].tenants[tostring(playeridentifier)] ~= nil or housinglocations[tostring(houselocationid)].owner == tostring(playeridentifier) then
		someperm = true
	else
		someperm = false
	end
	return someperm
end

function NearbyProperty(playersource, houselocationid)
	local nearby = true
	return nearby
end

function ActionCheck(playersource, houselocationid, actiontype)
    local actionpossible = true

    if actiontype == "lock" then
        local now = GetGameTimer()  
        local last = latestLockAction[houselocationid] or 0
        local diff = now - last

        if diff < Config.ActionCooldown then
            actionpossible = false
        else
            
            latestLockAction[houselocationid] = now
            actionpossible = true
        end
    elseif actiontype == "light" then
        local now = GetGameTimer()  
        local last = latestLightAction[houselocationid] or 0
        local diff = now - last

        if diff < Config.ActionCooldown then
            actionpossible = false
        else
            
            latestLightAction[houselocationid] = now
            actionpossible = true
        end		
    elseif actiontype == "bell" then
        local now = GetGameTimer()  
        local last = latestBellAction[houselocationid] or 0
        local diff = now - last

        if diff < Config.ActionCooldown then
            actionpossible = false
        else
            
            latestBellAction[houselocationid] = now
            actionpossible = true
        end	
    elseif actiontype == "service" then
        local now = GetGameTimer()  
        local last = latestServiceAction[houselocationid] or 0
        local diff = now - last

        if diff < Config.ActionCooldown then
            actionpossible = false
        else
            
            latestServiceAction[houselocationid] = now
            actionpossible = true
        end		
    elseif actiontype == "changedoorbell" then
        local now = GetGameTimer()  
        local last = latestChangeDoorbellAction[houselocationid] or 0
        local diff = now - last

        if diff < Config.ActionCooldown then
            actionpossible = false
        else
            
            latestChangeDoorbellAction[houselocationid] = now
            actionpossible = true
        end			
    elseif actiontype == "changedance" then
        local now = GetGameTimer()  
        local last = latestChangeDanceAction[houselocationid] or 0
        local diff = now - last

        if diff < Config.ActionCooldown then
            actionpossible = false
        else
            
            latestChangeDanceAction[houselocationid] = now
            actionpossible = true
        end		
    elseif actiontype == "motiondetect" then
        local now = GetGameTimer()  
        local last = latestMotionDetectAction[houselocationid] or 0
        local diff = now - last

        if diff < Config.MotionDetectorSettings.motionalertcooldown then
            actionpossible = false
        else
            
            latestMotionDetectAction[houselocationid] = now
            actionpossible = true
        end		
    elseif actiontype == "motiondetectinside" then
        local now = GetGameTimer()  
        local last = latestMotionDetectInsideAction[houselocationid] or 0
        local diff = now - last

        if diff < Config.MotionDetectorSettings.motionalertcooldown then
            actionpossible = false
        else
            
            latestMotionDetectInsideAction[houselocationid] = now
            actionpossible = true
        end	
    elseif actiontype == "pinchange" then
        local now = GetGameTimer()  
        local last = latestPinChangeAction[houselocationid] or 0
        local diff = now - last

        if diff < Config.ActionCooldown then
            actionpossible = false
        else
            
            latestPinChangeAction[houselocationid] = now
            actionpossible = true
        end		
    elseif actiontype == "list" then
        local now = GetGameTimer()  
        local last = latestListAction[houselocationid] or 0
        local diff = now - last

        if diff < Config.ActionCooldown then
            actionpossible = false
        else
            
            latestListAction[houselocationid] = now
            actionpossible = true
        end	
    elseif actiontype == "vacuum" then
        local now = GetGameTimer()  
        local last = latestVacuumAction[houselocationid] or 0
        local diff = now - last

        if diff < Config.ActionCooldown then
            actionpossible = false
        else
            
            latestVacuumAction[houselocationid] = now
            actionpossible = true
        end	
    elseif actiontype == "deliveriesbox" then
        local now = GetGameTimer()  
        local last = latestDeliveriesAction[houselocationid] or 0
        local diff = now - last

        if diff < Config.ActionCooldown then
            actionpossible = false
        else
            
            latestDeliveriesAction[houselocationid] = now
            actionpossible = true
        end					
    end

    return actionpossible
end

function FurnitureInteraction(furnituretype)
	if furnituretype == "sink" then
		-- add hygiene
	elseif furnituretype == "shower" then
		-- add hygiene
	end
		
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

local registeredStorageIds = {}
local registeredSafeIds = {}
local registeredGarageIds = {}

local function SafeNumber(value, fallback)
	local n = tonumber(value)
	if n == nil then
		return fallback
	end
	return n
end

local function SafeTable(value)
	if type(value) == "table" then
		return value
	end
	return {}
end

local function SafeVector4FromGarage(garageData)
	if not garageData or not garageData.coords then
		return nil
	end

	local coords = garageData.coords
	local heading = SafeNumber(garageData.heading, 0.0)

	if coords.x and coords.y and coords.z then
		return vector4(coords.x, coords.y, coords.z - 2.0, heading)
	end

	if coords[1] and coords[2] and coords[3] then
		return vector4(coords[1], coords[2], coords[3] - 2.0, heading)
	end

	return nil
end

local function SafeCall(label, fn)
	local ok, err = xpcall(fn, function(e)
		return debug.traceback(tostring(e), 2)
	end)

	if not ok then
		DebugMode("[RTX HOUSING] ERROR in " .. tostring(label) .. " | " .. tostring(err))
	end

	return ok
end

function RegisterStorages(houseiddata, storageid)
	if not houseiddata or not storageid then
		DebugMode("[RTX HOUSING] RegisterStorages aborted | invalid params | house: " .. tostring(houseiddata) .. " | storage: " .. tostring(storageid))
		return false
	end

	local houseKey = tostring(houseiddata)
	local storageKey = tostring(storageid)
	local houselocationhandler = housinglocations[houseKey]

	if not houselocationhandler then
		DebugMode("[RTX HOUSING] RegisterStorages aborted | house not found | house: " .. tostring(houseKey))
		return false
	end

	local storageData = SafeTable(houselocationhandler.storage)
	local slotsdata = SafeNumber(storageData.slots, 50)
	local weightdata = SafeNumber(storageData.weight, 100000)
	local stashId = "property-" .. houseKey .. "-storage-" .. storageKey

	DebugMode("[RTX HOUSING] RegisterStorages start | house: " .. tostring(houseKey) .. " | storage: " .. tostring(storageKey) .. " | system: " .. tostring(Config.InventorySystem))

	if Config.InventorySystem == "oxinventory" then
		if registeredStorageIds[stashId] then
			DebugMode("[RTX HOUSING] RegisterStorages skipped, already registered | stash: " .. tostring(stashId))
			return true
		end

		local ok = SafeCall("RegisterStorages oxinventory " .. stashId, function()
			exports.ox_inventory:RegisterStash(
				stashId,
				"Property Storage - " .. storageKey,
				slotsdata,
				weightdata,
				false
			)
		end)

		if ok then
			registeredStorageIds[stashId] = true
			DebugMode("[RTX HOUSING] RegisterStorages oxinventory done | stash: " .. tostring(stashId))
		end

		return ok

	elseif Config.InventorySystem == "qbcoreinventory" then
		DebugMode("[RTX HOUSING] RegisterStorages qbcoreinventory uses OpenStorageQB handler only | stash: " .. tostring(stashId))
		return true

	elseif Config.InventorySystem == "jaksam_inventory" then
		if registeredStorageIds[stashId] then
			DebugMode("[RTX HOUSING] RegisterStorages skipped, already registered | stash: " .. tostring(stashId))
			return true
		end

		local ok = SafeCall("RegisterStorages jaksam_inventory " .. stashId, function()
			exports['jaksam_inventory']:registerStash({
				id = stashId,
				label = "Property Storage - " .. storageKey,
				maxWeight = weightdata,
				maxSlots = slotsdata,
				isPrivate = false,
			})
		end)

		if ok then
			registeredStorageIds[stashId] = true
			DebugMode("[RTX HOUSING] RegisterStorages jaksam_inventory done | stash: " .. tostring(stashId))
		end

		return ok
	end

	DebugMode("[RTX HOUSING] RegisterStorages unknown inventory system | system: " .. tostring(Config.InventorySystem))
	return false
end

function RegisterSafe(houseiddata, storageid)
	if not houseiddata or not storageid then
		DebugMode("[RTX HOUSING] RegisterSafe aborted | invalid params | house: " .. tostring(houseiddata) .. " | storage: " .. tostring(storageid))
		return false
	end

	local houseKey = tostring(houseiddata)
	local storageKey = tostring(storageid)
	local houselocationhandler = housinglocations[houseKey]

	if not houselocationhandler then
		DebugMode("[RTX HOUSING] RegisterSafe aborted | house not found | house: " .. tostring(houseKey))
		return false
	end

	local safeSlots = SafeNumber(Config.SafeSettings and Config.SafeSettings.slots, 25)
	local safeWeight = SafeNumber(Config.SafeSettings and Config.SafeSettings.weight, 50000)
	local stashId = "property-" .. houseKey .. "-storage-" .. storageKey

	DebugMode("[RTX HOUSING] RegisterSafe start | house: " .. tostring(houseKey) .. " | storage: " .. tostring(storageKey) .. " | system: " .. tostring(Config.InventorySystem))

	if Config.InventorySystem == "oxinventory" then
		if registeredSafeIds[stashId] then
			DebugMode("[RTX HOUSING] RegisterSafe skipped, already registered | stash: " .. tostring(stashId))
			return true
		end

		local ok = SafeCall("RegisterSafe oxinventory " .. stashId, function()
			exports.ox_inventory:RegisterStash(
				stashId,
				"Property Safe - " .. storageKey,
				safeSlots,
				safeWeight,
				false
			)
		end)

		if ok then
			registeredSafeIds[stashId] = true
			DebugMode("[RTX HOUSING] RegisterSafe oxinventory done | stash: " .. tostring(stashId))
		end

		return ok

	elseif Config.InventorySystem == "qbcoreinventory" then
		DebugMode("[RTX HOUSING] RegisterSafe qbcoreinventory uses OpenStorageQB handler only | stash: " .. tostring(stashId))
		return true

	elseif Config.InventorySystem == "jaksam_inventory" then
		if registeredSafeIds[stashId] then
			DebugMode("[RTX HOUSING] RegisterSafe skipped, already registered | stash: " .. tostring(stashId))
			return true
		end

		local ok = SafeCall("RegisterSafe jaksam_inventory " .. stashId, function()
			exports['jaksam_inventory']:registerStash({
				id = stashId,
				label = "Property Safe - " .. storageKey,
				maxWeight = safeWeight,
				maxSlots = safeSlots,
				isPrivate = false,
			})
		end)

		if ok then
			registeredSafeIds[stashId] = true
			DebugMode("[RTX HOUSING] RegisterSafe jaksam_inventory done | stash: " .. tostring(stashId))
		end

		return ok
	end

	DebugMode("[RTX HOUSING] RegisterSafe unknown inventory system | system: " .. tostring(Config.InventorySystem))
	return false
end

function RegisterGarage(houseiddata)
	if not houseiddata then
		DebugMode("[RTX HOUSING] RegisterGarage aborted | houseid nil")
		return false
	end

	local houseKey = tostring(houseiddata)
	local garageId = "rtx-housing-" .. houseKey
	local houselocationhandler = housinglocations[houseKey]

	if not houselocationhandler then
		DebugMode("[RTX HOUSING] RegisterGarage aborted | house not found | house: " .. tostring(houseKey))
		return false
	end

	if not houselocationhandler.garage or houselocationhandler.garage.enabled ~= true then
		DebugMode("[RTX HOUSING] RegisterGarage skipped | garage missing or disabled | house: " .. tostring(houseKey))
		return false
	end

	if registeredGarageIds[garageId] then
		DebugMode("[RTX HOUSING] RegisterGarage skipped, already registered | garage: " .. tostring(garageId))
		return true
	end

	local garageCoords = SafeVector4FromGarage(houselocationhandler.garage)
	if not garageCoords then
		DebugMode("[RTX HOUSING] RegisterGarage aborted | invalid coords | house: " .. tostring(houseKey))
		return false
	end

	local propertyName = tostring(houselocationhandler.propertyname or ("Property " .. houseKey))
	local ownerIdentifier = tostring(houselocationhandler.owner or "")

	DebugMode("[RTX HOUSING] RegisterGarage start | house: " .. tostring(houseKey) .. " | system: " .. tostring(Config.GarageSystem))

	if Config.GarageSystem == "ZSX_Garages" then
		if ownerIdentifier == "" then
			DebugMode("[RTX HOUSING] RegisterGarage aborted | empty owner for ZSX_Garages | house: " .. tostring(houseKey))
			return false
		end

		local ok = SafeCall("RegisterGarage ZSX_Garages " .. garageId, function()
			local players = { ownerIdentifier }
			local coordinates = { garageCoords }

			exports['ZSX_Garages']:AddTempGarage(
				"temp_property" .. houseKey,
				propertyName,
				true,
				'player',
				players,
				coordinates
			)
		end)

		if ok then
			registeredGarageIds[garageId] = true
			DebugMode("[RTX HOUSING] RegisterGarage ZSX_Garages done | house: " .. tostring(houseKey))
		end

		return ok

	elseif Config.GarageSystem == "vms_garagesv2" then
		local ok = SafeCall("RegisterGarage vms_garagesv2 " .. garageId, function()
			exports["vms_garagesv2"]:registerHousingGarage(
				garageId,
				"Garage",
				houseKey,
				garageCoords,
				1
			)
		end)

		if ok then
			registeredGarageIds[garageId] = true
			DebugMode("[RTX HOUSING] RegisterGarage vms_garagesv2 done | house: " .. tostring(houseKey))
		end

		return ok
	end

	DebugMode("[RTX HOUSING] RegisterGarage unknown garage system | system: " .. tostring(Config.GarageSystem))
	return false
end

function UpdateGarage(houseiddata)
	local houselocationhandler = housinglocations[tostring(houseiddata)]
	if Config.GarageSystem == "ZSX_Garages" then
		table.insert(players, property.owner)
		exports['ZSX_Garages']:UpdateTempGaragePlayerList("temp_property"..houseiddata, players)
	end	
end

function RemoveGarage(houseiddata)
	local houselocationhandler = housinglocations[tostring(houseiddata)]
	if Config.GarageSystem == "ZSX_Garages" then
		exports['ZSX_Garages']:RemoveTempGarage("temp_property"..houseiddata)
	end	
end

function GetStarterApartmentName(playersource)
	local startername = ""
	local playername = GetPlayerNameRTX(playersource)
	if Language[Config.Language]["notallowed"] ~= nil then
		startername = LanguageFile("starterapartment", playername)
	else
		startername = playername.." Apartment"
	end
	return startername
end

function GetCurrentDate()
    local now = os.time()
    local dt = os.date("*t", now)

    local months = {
        [1]  = "January",
        [2]  = "February",
        [3]  = "March",
        [4]  = "April",
        [5]  = "May",
        [6]  = "June",
        [7]  = "July",
        [8]  = "August",
        [9]  = "September",
        [10] = "October",
        [11] = "November",
        [12] = "December"
    }

    local monthName = months[dt.month] or "Unknown"

    return string.format("%s %d, %d", monthName, dt.day, dt.year)
end

function IsIdentifierOnline(identifier)
    if not identifier then 
        return false, nil 
    end

    identifier = tostring(identifier)

    if Config.Framework == "esx" then
        local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
        if xPlayer then
            return true, xPlayer.source
        end
        return false, nil
    end

    if Config.Framework == "qbcore" then
        local player = QBCore.Functions.GetPlayerByCitizenId(identifier)
        if player then
            return true, player.PlayerData.source
        end
        return false, nil
    end

    if Config.Framework == "standalone" then
        for _, src in ipairs(GetPlayers()) do
            local ids = GetPlayerIdentifiers(src)
            for _, id in ipairs(ids) do
                if id == identifier then
                    return true, tonumber(src)
                end
            end
        end
        return false, nil
    end

    print("[WARNING] Unknown framework in Config.Framework:", Config.Framework)
    return false, nil
end

function AlarmAlert(propertyid, alarmside)
	local houselocationhandler = housinglocations[tostring(propertyid)]
	local alarmcoords = houselocationhandler.enter.coords
	if houselocationhandler.propertytype == "MLO" then
		alarmcoords = houselocationhandler.managment.coords
	end	
	if alarmside == "owner" then
		local online, serverId = IsIdentifierOnline(houselocationhandler.owner)
		if online then		
			if Config.AlertSystem == "default" then
				TriggerClientEvent("rtx_housing:Notify", serverId, "warning", Language[Config.Language]["alarm2"], LanguageFile("alarm", houselocationhandler.propertyname, houselocationhandler.adress))	
				TriggerClientEvent("rtx_housing:Global:AlarmBlip",serverId, propertyid, alarmcoords)
			end
		end
	elseif alarmside == "police" then
		if Config.AlertSystem == "default" then
			local alertSources = GetJobSources(Config.AlarmSettings.Police.jobs)
			for i, policesrc in ipairs(alertSources) do
				TriggerClientEvent("rtx_housing:Notify", policesrc, "warning", Language[Config.Language]["alarm2"], LanguageFile("alarm", houselocationhandler.propertyname, houselocationhandler.adress))	
				TriggerClientEvent("rtx_housing:Global:AlarmBlip",policesrc, propertyid, alarmcoords)					
			end
		elseif Config.AlertSystem == "cd_dispatch" then	
			TriggerEvent('cd_dispatch:AddNotification', {
				  job_table = {'police', },
				  coords = alarmcoords,
				  title = '10-15 - Property Alarm',
				  message = LanguageFile("alarm", houselocationhandler.propertyname, houselocationhandler.adress),
				  flash = 0,
				  sound = 1,
				  blip = {
					  sprite = 431,
					  scale = 1.2,
					  colour = 3,
					  flashes = false,
					  text = '911 - Property Alarm',
					  time = 5,
					  radius = 0,
				  }
			  })		
		end
	end
end

function RobberyAlert(propertyid, robberyside)
	local houselocationhandler = housinglocations[tostring(propertyid)]
	local alarmcoords = houselocationhandler.enter.coords
	if houselocationhandler.propertytype == "MLO" then
		alarmcoords = houselocationhandler.managment.coords
	end	
	if robberyside == "owner" then
		local online, serverId = IsIdentifierOnline(houselocationhandler.owner)
		if online then		
			if Config.AlertSystem == "default" then
				TriggerClientEvent("rtx_housing:Notify", serverId, "warning", Language[Config.Language]["robbery"], LanguageFile("robberyalert", houselocationhandler.propertyname, houselocationhandler.adress))	
				TriggerClientEvent("rtx_housing:Global:AlarmBlip",serverId, propertyid, alarmcoords)
			end
		end
	elseif robberyside == "police" then
		if Config.AlertSystem == "default" then
			local alertSources = GetJobSources(Config.AlarmSettings.Police.jobs)
			for i, policesrc in ipairs(alertSources) do
				TriggerClientEvent("rtx_housing:Notify", policesrc, "warning", Language[Config.Language]["robbery"], LanguageFile("robberyalert", houselocationhandler.propertyname, houselocationhandler.adress))	
				TriggerClientEvent("rtx_housing:Global:AlarmBlip",policesrc, propertyid, alarmcoords)		
			end
		elseif Config.AlertSystem == "cd_dispatch" then	
			TriggerEvent('cd_dispatch:AddNotification', {
				  job_table = {'police', },
				  coords = alarmcoords,
				  title = '10-15 - Property Robbery',
				  message = LanguageFile("robberyalert", houselocationhandler.propertyname, houselocationhandler.adress),
				  flash = 0,
				  sound = 1,
				  blip = {
					  sprite = 431,
					  scale = 1.2,
					  colour = 3,
					  flashes = false,
					  text = '911 - Property Robbery',
					  time = 5,
					  radius = 0,
				  }
			  })				
		end
	end
end

if Config.FurnitureSystem.screenshot == true then
	local RESOURCE_NAME = GetCurrentResourceName()
	local IMAGE_FOLDER = "images"
	local BASE64_CHARS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

	local function Base64Decode(data)
		data = string.gsub(data or "", "[^A-Za-z0-9+/=]", "")

		return (data:gsub(".", function(x)
			if x == "=" then
				return ""
			end

			local r, f = "", BASE64_CHARS:find(x, 1, true) - 1

			for i = 6, 1, -1 do
				r = r .. (f % 2^i - f % 2^(i - 1) > 0 and "1" or "0")
			end

			return r
		end):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(x)
			if #x ~= 8 then
				return ""
			end

			local c = 0
			for i = 1, 8 do
				c = c + (x:sub(i, i) == "1" and 2^(8 - i) or 0)
			end

			return string.char(c)
		end))
	end

	local function ExtractBase64FromDataUrl(imageData)
		if type(imageData) ~= "string" then
			return nil, nil
		end

		local mimeType, base64Data = imageData:match("^data:(image/[%w%-%+%.]+);base64,(.+)$")
		if mimeType and base64Data then
			return mimeType, base64Data
		end

		return nil, imageData
	end

	local function NormalizeImageExtension(imgType, mimeType)
		if type(imgType) == "string" and imgType ~= "" then
			imgType = string.lower(imgType)

			if imgType == "jpg" then
				return "jpg"
			elseif imgType == "jpeg" then
				return "jpeg"
			elseif imgType == "png" then
				return "png"
			elseif imgType == "webp" then
				return "webp"
			end
		end

		if mimeType == "image/png" then
			return "png"
		elseif mimeType == "image/jpeg" then
			return "jpeg"
		elseif mimeType == "image/jpg" then
			return "jpg"
		elseif mimeType == "image/webp" then
			return "webp"
		end

		return "webp"
	end

	local function SaveFurnitureImage(filename, imgType, dataUri)
		if type(filename) ~= "string" or filename == "" then
			return nil, "Invalid filename"
		end

		local mimeType, base64Data = ExtractBase64FromDataUrl(dataUri)
		if not base64Data or base64Data == "" then
			return nil, "Invalid image data"
		end

		local binaryData = Base64Decode(base64Data)
		if not binaryData or #binaryData == 0 then
			return nil, "Failed to decode base64 image data"
		end

		local extension = NormalizeImageExtension(imgType, mimeType)

		local safeFilename = filename:gsub("[^%w%-%._]", "_")

		local relativePath = ("%s/%s.%s"):format(IMAGE_FOLDER, safeFilename, extension)
		local success = SaveResourceFile(RESOURCE_NAME, relativePath, binaryData, #binaryData)

		if not success then
			return nil, "Failed to save image file"
		end

		return relativePath, nil
	end

	RegisterNetEvent("rtx_housing:saveScreenshot")
	AddEventHandler("rtx_housing:saveScreenshot", function(filename, imgType, dataUri)
		local savedPath, err = SaveFurnitureImage(filename, imgType, dataUri)

		if not savedPath then
			print(("[rtx_housing] Failed to save furniture image '%s': %s"):format(tostring(filename), err or "unknown"))
			return
		end

		print(("[rtx_housing] Saved furniture image: %s"):format(savedPath))
	end)
end

function AddRealEstatePercentage(houseid, amount)
    if not amount or amount <= 0 then 
        DebugMode("[RTX HOUSING] AddRealEstatePercentage aborted | invalid amount")
        return 
    end

    local percentage = Config.RealEstateSettings and Config.RealEstateSettings.realestatepercentage or 0
    if percentage <= 0 then 
        return 
    end

    local commission = math.floor(amount * (percentage / 100))

    DebugMode("[RTX HOUSING] AddRealEstatePercentage | house: " .. tostring(houseid) .. " | sale: " .. tostring(amount) .. " | commission: " .. tostring(commission))

    if Config.Framework == "esx" then
        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_realestateagent', function(account)
            if account then
                account.addMoney(commission)
                DebugMode("[RTX HOUSING] ESX commission added to society_realestateagent | $" .. tostring(commission))
            end
        end)

    elseif Config.Framework == "qbcore" then
        -- Renewed Banking Support (your setup)
        local success = false

        -- Try with society_ prefix first (most common)
        local ok, err = pcall(function()
            success = exports['Renewed-Banking']:addAccountMoney('society_realestateagent', commission)
        end)

        if ok and success then
            DebugMode("[RTX HOUSING] Renewed Banking commission added | $" .. tostring(commission))
            return
        end

        -- Fallback without society_ prefix
        local ok2, err2 = pcall(function()
            success = exports['Renewed-Banking']:addAccountMoney('realestateagent', commission)
        end)

        if ok2 and success then
            DebugMode("[RTX HOUSING] Renewed Banking commission added (fallback) | $" .. tostring(commission))
        else
            DebugMode("[RTX HOUSING] Renewed Banking addAccountMoney failed | error: " .. tostring(err or err2))
        end

    elseif Config.Framework == "standalone" then
        DebugMode("[RTX HOUSING] Standalone | commission skipped")
    end
end