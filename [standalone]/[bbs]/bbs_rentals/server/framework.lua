Server.Functions.GetPlayerFromId = function (id)
   if Settings?.Framework == "ESX" then
      return Framework?.GetPlayerFromId(id)
   elseif Settings?.Framework == "QBCore" then
      return Framework?.Functions?.GetPlayer(id)
   elseif Settings?.Framework == "Qbox" then
      return Framework:GetPlayer(id)
   else
      return print("[RENT] Settings | ensure framework in server/framework.lua!!!")
   end
end

Server.Functions.GetPlayerIdentifier = function (Player)
   if Settings?.Framework == "ESX" then
      return Player?.identifier
   elseif Settings?.Framework == "QBCore" or Settings?.Framework == "Qbox" then
      return Player?.PlayerData?.citizenid
   else
      return print("[RENT] Settings | ensure framework in server/framework.lua!!!")
   end
end

Server.Functions.GetPlayerAccount = function (Player, Account) 
   if Settings?.Framework == "ESX" then
      return Player?.getAccount(Account)?.money
   elseif Settings?.Framework == "QBCore" then
      local Account = (Account == "money" and "cash") or (Account == "bank" and "bank")
      return Player?.PlayerData?.money?[Account]
   elseif Settings?.Framework == "Qbox" then
      local Account = (Account == "money" and "cash") or (Account == "bank" and "bank")
      return Player?.PlayerData?.money?[Account]
   else
      return print("[RENT] Settings | ensure framework in server/framework.lua!!!")
   end
end

Server.Functions.GetName = function (Player)
   if Settings?.Framework == "ESX" then
      return Player?.getName()
   elseif Settings?.Framework == "QBCore" or Settings?.Framework == "Qbox" then
      return Player?.PlayerData?.charinfo?.firstname .. " " .. Player?.PlayerData?.charinfo?.lastname
   else
      return print("[RENT] Settings | ensure framework in server/framework.lua!!!")
   end
end

Server.Functions.RemoveAccountMoney = function (Player, Account, amount)
   if Settings?.Framework == "ESX" then
      Player?.removeAccountMoney(Account, amount)
   elseif Settings?.Framework == "QBCore" or Settings?.Framework == "Qbox" then
      local Account = (Account == "money" and "cash") or (Account == "bank" and "bank")
      Player?.Functions?.RemoveMoney(Account, amount)
   else
      return print("[RENT] Settings | ensure framework in server/framework.lua!!!")
   end
end

Server.Functions.RegisterUsableItem = function(itemName, ...)
   if Settings?.Framework == "ESX" then
      Framework?.RegisterUsableItem(itemName, ...)
   elseif Settings?.Framework == "QBCore" then
      Framework?.Functions?.CreateUseableItem(itemName, ...)
   elseif Settings?.Framework == "Qbox" then
      Framework:CreateUseableItem(itemName, ...)
   else
      return print("[RENT] Settings | ensure framework in server/framework.lua!!!")
   end
end

Server.Functions.GiveItem = function(source, count, item, metadata)
   Inventory?.GiveItem(source, count, item, metadata)
end

Server.Functions.HasRentalItem = function(source, plate, Player)
   if Settings.Inventory == "ox_inventory" then
      local playerItems = exports.ox_inventory:GetInventoryItems(source)
      if not playerItems or type(playerItems) ~= "table" then return false end
      
      for _, item in pairs(playerItems) do
         if item and item?.name == Settings.ReceiptItem then
               local metadata = item?.metadata
               if metadata then
                  local rentPlate = tostring(metadata?.RentPlate or ""):upper():gsub("%s+", "")
                  local givenPlate = tostring(plate):upper():gsub("%s+", "")

                  if rentPlate == givenPlate then
                     local removed = exports.ox_inventory:RemoveItem(source, Settings.ReceiptItem, 1, metadata)
                     if removed then
                           debbugPrint("Player " .. source .. " returned vehicle with plate: " .. plate)
                           return true
                     end
                  end
               end
         end
      end
   elseif Settings.Inventory == "qb-inventory" then
      local inventory = Player?.PlayerData?.items
      if not inventory or type(inventory) ~= "table" then return false end
      
      for _, item in pairs(inventory) do
         if item and item?.name == Settings.ReceiptItem then
               local metadata = item?.info
               if metadata then
                  local rentPlate = tostring(metadata?.RentPlate or ""):upper():gsub("%s+", "")
                  local givenPlate = tostring(plate):upper():gsub("%s+", "")

                  if rentPlate == givenPlate then
                     if Player?.Functions?.RemoveItem(Settings.ReceiptItem, 1, item?.slot) then
                           debbugPrint("Player " .. source .. " returned vehicle with plate: " .. plate)
                           return true
                     end
                  end
               end
         end
      end
   end
   
   return false
end

if Settings.Inventory == "ox_inventory" then
   exports("useReceipt", function(event, item, inventory, slot, data)
      if event == 'usingItem' and inventory?.type == 'player' then
         local slot = Inventory.GetSlot(inventory.player.source, slot)
         local metadata = slot?.metadata
         if not metadata?.RentPlate then return false end
         TriggerClientEvent("bbsRental:client:inventoryReceipt", inventory?.player?.source, metadata?.RentPlate, metadata?.RenterName)
         return
      end
   end)
elseif Settings.Inventory == "qb-inventory" then
   Server.Functions.RegisterUsableItem(Settings.ReceiptItem, function(source, item)
      if not item?.info or not item?.info?.RentPlate or not item?.info?.RenterName then return end
      TriggerClientEvent("bbsRental:client:inventoryReceipt", source, item?.info?.RentPlate, item?.info?.RenterName)
   end)
end