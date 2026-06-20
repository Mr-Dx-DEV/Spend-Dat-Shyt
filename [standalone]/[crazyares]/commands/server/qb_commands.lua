local QBCore = exports['qb-core']:GetCoreObject()
local savedCoords = {}

function BanPlayer(src) end

QBCore.Commands.Add('bring', 'Bring a player to you (Admin only)', { { name = 'id', help = 'Player ID' }, }, true, function(source, args)
    local src = source
    if args[1] then
        local admin = GetPlayerPed(src)
        local coords = GetEntityCoords(admin)
        local target = GetPlayerPed(tonumber(args[1]))
        SetEntityCoords(target, coords)
        savedCoords[tonumber(args[1])]= GetEntityCoords(target)
    end
end, 'mod')

QBCore.Commands.Add('bringback', 'Bring back a player (Admin only)', { { name = 'id', help = 'Player ID' }, }, true, function(source, args)
    local src = source
    if args[1] then
        local coords = savedCoords[tonumber(args[1])]
        local target = GetPlayerPed(tonumber(args[1]))
        SetEntityCoords(target, coords)
    end
end, 'mod')

QBCore.Commands.Add('goto', 'Teleport yourself to the player (Admin only)', { { name = 'id/x', help = 'ID of player or X position' }, { name = 'y', help = 'Y position' }, { name = 'z', help = 'Z position' } }, false, function(source, args)
    local src = source
    if args[1] and not args[2] and not args[3] then
        local target = GetPlayerPed(tonumber(args[1]))
        if target ~= 0 then
            local coords = GetEntityCoords(target)
            TriggerClientEvent('QBCore:Command:TeleportToPlayer', source, coords)
            TriggerEvent('qb-log:server:CreateLog', 'tpd', 'Player TPD', 'yellow', GetPlayerName(src).." Teleported To "..GetPlayerName(tonumber(args[1])))
        else
            TriggerClientEvent('QBCore:Notify', source, "This player is not online", 'error')
        end
    else
        if args[1] and args[2] and args[3] then
            local x = tonumber((args[1]:gsub(",",""))) + .0
            local y = tonumber((args[2]:gsub(",",""))) + .0
            local z = tonumber((args[3]:gsub(",",""))) + .0
            if x ~= 0 and y ~= 0 and z ~= 0 then
                TriggerClientEvent('QBCore:Command:TeleportToCoords', source, x, y, z)
                TriggerEvent('qb-log:server:CreateLog', 'tpd', 'Player TPD', 'yellow', GetPlayerName(src).." Went To Coords:  "..args[1].." "..args[2].." "..args[3])
            else
                TriggerClientEvent('QBCore:Notify', source, "Wrong format.", 'error')
            end
        else
            TriggerClientEvent('QBCore:Notify', source, "Missing args", 'error')
        end
    end
end, 'mod')

QBCore.Commands.Add('setmodel', "Change Ped Model (Admin Only)", {{name='model', help='Name of the model'}, {name='id', help='Id of the Player (empty for yourself)'}}, false, function(source, args)
    local model = args[1]
    local target = tonumber(args[2])
    if model ~= nil or model ~= '' then
        if target == nil then
            TriggerClientEvent('qb-admin:client:SetModel', source, tostring(model))
        else
            local Trgt = QBCore.Functions.GetPlayer(target)
            if Trgt ~= nil then
                TriggerClientEvent('qb-admin:client:SetModel', target, tostring(model))
            else
                TriggerClientEvent('QBCore:Notify', source, "Player not online", 'error')
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', source, "Failed to set model", 'error')
    end
end, 'god')

QBCore.Commands.Add('setammo', "Set Your Ammo Amount (Admin Only)", {{name='amount', help='Amount of bullets, for example: 20'}, {name='reason', help='Reason for ammo?'}}, false, function(source, args)
    local src = source
    local amount = tonumber(args[1])
    local reason = args[2]
    if args[2] then
        TriggerClientEvent('qb-weapons:client:SetWeaponAmmoManual', src, amount, reason)
    else
        TriggerClientEvent('QBCore:Notify', src, 'Provide a reason for setting ammo.', "error")
    end
end, 'god')

QBCore.Commands.Add('clothing', "- Government (Mod Only)", {{name="id", help="Player ID "}}, false, function(source, args)
    local src = source
    if args[1] then
        local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
        if Player then
            TriggerClientEvent('qb-clothing:client:openMenu', Player.PlayerData.source)
        else
            TriggerClientEvent('QBCore:Notify', ('Player Not Online'), "error")
        end
    else
        TriggerClientEvent('qb-clothing:client:openMenu', src)
    end
end, 'mod')

QBCore.Commands.Add('pullstash', "- Government (Admin Only)", {}, false, function(source, args)
    local src = source
    local nameofplayer = GetPlayerName(src)
    local Player = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('admin:commands:pullstash', src, nameofplayer, Player)
end, 'admin')

QBCore.Commands.Add('openinv', "- Government (Admin Only)", {{name= "inventoryid", help= "Player ID"}}, false, function(source, args)
    local src = source
    if args[1] then local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
        if Player then 
            if QBCore.Functions.HasPermission(src, "admin") then
                TriggerClientEvent('admin:commands:inventory', src, Player.PlayerData.source)
            else
                BanPlayer(src)
            end
        else 
            TriggerClientEvent('QBCore:Notify', source, 'Player Not Online', "error") 
        end
    end
end, 'admin')

QBCore.Commands.Add('godcuff', "- Government (God Only)", {}, false, function(source)
    local src = source
    TriggerClientEvent("admin:commands:godcuff", src, Player) 
end, 'god')

QBCore.Commands.Add('warp', "- Government (Mod Only)", {}, false, function(source)
    local src = source
    if QBCore.Functions.HasPermission(src, "mod") then
        TriggerClientEvent("admin:commands:warpinvehicle", src) 
    else
        BanPlayer(src)
    end
end, 'mod')

local frozen = false
QBCore.Commands.Add("freeze", "- Government (Mod Only)", {{name = "id", help = "ID"}}, true, function(source, args)
    local src = source
    local playerId = tonumber(args[1])
    local Trgt = QBCore.Functions.GetPlayer(playerId)
    if QBCore.Functions.HasPermission(src, "admin") then
        if Trgt ~= nil then
            if not frozen then
                frozen = true
                FreezeEntityPosition(playerId, true)
            else
                frozen = false
                FreezeEntityPosition(playerId, false)
            end
        else
            TriggerClientEvent('QBCore:Notify', source, "Player not online", 'error')
        end
    else
        BanPlayer(src)
    end
end, 'admin')

QBCore.Commands.Add('maxmods', "- Government (god Only) (Max Vehicle Mods)", {}, false, function(source)
    local src = source
    if QBCore.Functions.HasPermission(src, "god") then
        TriggerClientEvent('admin:commands:maxmodVehicle', src)
    else
        BanPlayer(src)
    end
end, 'god')

QBCore.Commands.Add('wipestash', "- Government (God Only)", {}, false, function(source, args)
    local src = source
    if QBCore.Functions.HasPermission(src, "admin") then
        TriggerClientEvent('admin:commands:wipestash', src)
    else
        BanPlayer(src)
    end
end, 'admin')

QBCore.Commands.Add("kick", "- Government (Mod Only)", {{name = "id", help = "ID"}, {name = "reason", help = "Reason"}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local playerId = tonumber(args[1])
    local xPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
    if QBCore.Functions.HasPermission(src, "mod") then
        if xPlayer then
            if args[2] then
                DropPlayer(playerId, args[2])
                TriggerEvent('qb-log:server:CreateLog', 'kicked', 'Player Kicked', 'green', GetPlayerName(tonumber(args[1])).." was kicked by "..GetPlayerName(src).." Reason: "..args[2])
            else
                TriggerClientEvent('QBCore:Notify', "Provide a reason", "error")
            end
        else
            TriggerClientEvent('QBCore:Notify', "Player Not Online", "error")
        end
    else
        BanPlayer(src)
    end
end, 'mod')

QBCore.Commands.Add('vmute', "- Government (Mod Only)", {{name="id", help="Player ID "}}, false, function(source, args)
    local src = source
    if args[1] then
        local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
        if Player then
            TriggerClientEvent('okokChat:client:muteplayersVoice', Player.PlayerData.source)
        else
            TriggerClientEvent('QBCore:Notify', ('Player Not Online'), "error")
        end
    end
end, 'god')

QBCore.Commands.Add('vunmute', "- Government (Mod Only)", {{name="id", help="Player ID "}}, false, function(source, args)
    local src = source
    if args[1] then
        local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
        if Player then
            TriggerClientEvent('okokChat:client:unmuteplayersVoice', Player.PlayerData.source)
        else
            TriggerClientEvent('QBCore:Notify', ('Player Not Online'), "error")
        end
    end
end, 'god')

QBCore.Functions.CreateCallback('commands:server:getPlayersAdminRank', function(source, cb)
    if QBCore.Functions.HasPermission(source, 'god') or QBCore.Functions.HasPermission(source, 'admin') or QBCore.Functions.HasPermission(source, 'mod') then
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Commands.Add("wclearprop", "- Government (Admin Only)", {}, true, function(source)
    local src = source
    TriggerClientEvent("wclear:client:wclearprop", -1)
    TriggerEvent('qb-log:server:CreateLog', 'clearworld', 'Player Cleared World For Props', 'pink', GetPlayerName(src))
end, 'admin')

QBCore.Commands.Add("wclearpeds", "- Government (Admin Only)", {}, true, function(source)
    local src = source
    TriggerClientEvent("wclear:client:wclearpeds", -1)
    TriggerEvent('qb-log:server:CreateLog', 'clearworld', 'Player Cleared World For Peds', 'pink', GetPlayerName(src))
end, 'admin')


QBCore.Commands.Add("wclearcars", "- Government (Admin Only)", {}, true, function(source)
    local src = source
    TriggerClientEvent("wclear:client:wclearcars", -1)
    TriggerEvent('qb-log:server:CreateLog', 'clearworld', 'Player Cleared World For Cars', 'pink', GetPlayerName(src))
end, 'admin')

QBCore.Commands.Add('deletemoney', "Burn My Money", {}, false, function(source)
    local src = source
    TriggerClientEvent("admin:commands:deleteMyMoney", src)
end, 'user')

QBCore.Commands.Add('wipeplayer', "Use this command for F8's- Government (Admin Only)", {{name="id", help="Player ID "}}, false, function(source, args)
    local src = source
    if args[1] then
        local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
        local cash = Player.PlayerData.money['cash']
        local bank = Player.PlayerData.money['bank']
        if Player then
            Player.Functions.ClearInventory()
            Player.Functions.SetMoney("cash", 0)
            Player.Functions.SetMoney("bank", 0)
        else
            TriggerClientEvent('QBCore:Notify', ('Player Not Online'), "error")
        end
    end
end, 'admin')

QBCore.Commands.Add('clearprops', 'Clear Props', {}, false, function(source, args)
    if #GetAllObjects() > 0 then
        for mmm, pol in pairs(GetAllObjects()) do
            DeleteEntity(pol)
        end
    end
end, 'god')

QBCore.Commands.Add('rr', 'Revive all players in a range', {{ name = 'Range', help = 'Radius to revive'}}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    local range = tonumber(args[1] or 25.0)
    local players = QBCore.Functions.GetQBPlayers()
    for id, ply in pairs(players) do
        local coords = GetEntityCoords(GetPlayerPed(source))
        local target = GetEntityCoords(GetPlayerPed(id))
        if #(coords - target) <= range then
            TriggerClientEvent('hospital:client:Revive', id)
        end
    end
    QBCore.Functions.Notify(source, 'You\'ve successfully revived everyone within ' .. range .. ' meters.', 'success', 5000)
end, 'god')