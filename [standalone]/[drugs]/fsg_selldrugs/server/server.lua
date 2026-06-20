if GetResourceState('qbx_core') ~= 'started' then return end

print("^2[fsg_selldrugs]^7 server.lua loaded - black_money as ITEM")

RegisterCommand('dealer', function(source, args, rawcommand)
    local drugToSell = {
        type = '',
        label = '',
        count = 0,
        price = 0,
    }

    for k, v in pairs(Config.drugs) do
        local itemLabel = GetItemLabel(source, k)
        
        if itemLabel ~= 0 then
            local count = GetItemCount(source, k)
            
            if count > 0 then
                drugToSell.type = k
                drugToSell.label = itemLabel
                
                -- FIXED: Safe random count (works even if player has < 5)
                if count >= 5 then
                    drugToSell.count = math.random(5, math.min(20, count))
                else
                    drugToSell.count = math.random(1, count)
                end
                
                drugToSell.price = drugToSell.count * v + math.random(100, 400)

                TriggerClientEvent('stasiek_selldrugsv2:findClient', source, drugToSell)
                print("^2[DRUG DEALER]^7 " .. GetPlayerName(source) .. " started selling " .. drugToSell.count .. "x " .. drugToSell.type)
                return
            end
        end
    end

    TriggerClientEvent('ox_lib:notify', source, {
        title = Config.notify.title,
        description = Config.notify.nodrugs,
        duration = 8000,
        position = 'center-right',
        icon = 'pills'
    })
end, false)

RegisterNetEvent('stasiek_selldrugsv2:pay')
AddEventHandler('stasiek_selldrugsv2:pay', function(drugToSell)
    local src = source
    print("^3[DRUG PAY]^7 Pay event triggered for " .. GetPlayerName(src) .. " | Amount: $" .. drugToSell.price)

    local count = GetItemCount(src, drugToSell.type)

    if count >= drugToSell.count then
        RemoveItem(src, drugToSell.type, drugToSell.count)
        print("^2[DRUG PAY]^7 Items removed successfully")

        -- ✅ Adds black_money as ITEM (exactly what you want)
        local Player = GetPlayerFromId(src)
        if Player then
            Player.Functions.AddItem('black_money', drugToSell.price)
            print("^2[DRUG PAY]^7 ✅ SUCCESS - Added " .. drugToSell.price .. "x black_money item to " .. GetPlayerName(src))
        else
            print("^1[DRUG PAY]^7 ERROR - Player not found")
        end
    else
        print("^1[DRUG PAY]^7 ERROR - Not enough items")
        TriggerClientEvent('ox_lib:notify', src, {
            title = Config.notify.title,
            description = Config.notify.nodrugs,
            duration = 8000,
            position = 'center-right',
            icon = 'pills'
        })
    end
end)

RegisterNetEvent('stasiek_selldrugsv2:notifycops')
AddEventHandler('stasiek_selldrugsv2:notifycops', function(drugToSell)
    TriggerClientEvent('stasiek_selldrugsv2:notifyPolice', -1, drugToSell.coords)
end)