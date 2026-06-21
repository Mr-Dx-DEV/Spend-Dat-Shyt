-- -
--  CLIENT MAIN  - Grim Development | Love Menu v2.2.0
-- -

PlayerState    = { loggedIn = false, data = {} }
CurrentPartner = nil   -- server ID of selected partner
RegisteredPartners = RegisteredPartners or {}

local ItemNames = Config.Items or {}

local function ItemName(key, fallback)
    return ItemNames[key] or fallback
end

local function ItemEventNames(key, fallback)
    local itemName = ItemName(key, fallback)
    local seen = {}
    local names = {}
    local candidates = {
        ('grim_lovemenu:item:%s'):format(itemName),
        ('grims_lovemenu:item:%s'):format(itemName),
        ('%s:item:%s'):format(GetCurrentResourceName(), itemName),
    }

    for _, eventName in ipairs(candidates) do
        if eventName and not seen[eventName] then
            seen[eventName] = true
            names[#names + 1] = eventName
        end
    end

    return names
end

local function BindItemEvent(key, fallback, handler)
    for _, eventName in ipairs(ItemEventNames(key, fallback)) do
        AddEventHandler(eventName, handler)
    end
end
local function UseServerItem(key, fallback)
    TriggerServerEvent('grim_lovemenu:sv:useItem', ItemName(key, fallback))
end

local function OpenDNATablet()
    TriggerEvent('grim_lovemenu:openTablet')
    SetTimeout(500, function()
        SendNUIMessage({ action = 'gotoPage', page = 'dna' })
    end)
end

-- - lifecycle -

Bridge.OnLoaded(function()
    PlayerState.loggedIn = true
    PlayerState.data     = Bridge.GetPlayerData()
end)

Bridge.OnUnloaded(function()
    PlayerState.loggedIn = false
    PlayerState.data     = {}
    CurrentPartner       = nil
end)

AddEventHandler('onResourceStart', function(res)
    if res == GetCurrentResourceName() then
        Wait(300)
        PlayerState.data     = Bridge.GetPlayerData()
        PlayerState.loggedIn = Bridge.IsLoggedIn()
    end
end)

-- - utility -

function IsActionAllowed()
    if Bridge.GetMeta('ishandcuffed') then
        Bridge.Notify(Config.Strings.NoHandcuffs, 'error')
        return false
    end
    if Bridge.GetMeta('inlaststand') then
        Bridge.Notify(Config.Strings.NoLaststand, 'error')
        return false
    end
    if Bridge.GetMeta('isdead') then
        Bridge.Notify(Config.Strings.NoDead, 'error')
        return false
    end
    return true
end

function GetNearbyPlayers(maxDist)
    maxDist = maxDist or 50.0
    local result  = {}
    local myPed   = PlayerPedId()
    local myNetID = GetPlayerServerId(PlayerId())
    local myPos   = GetEntityCoords(myPed)

    for _, p in pairs(GetActivePlayers()) do
        local ped = GetPlayerPed(p)
        if DoesEntityExist(ped) then
            local netID = GetPlayerServerId(p)
            if netID ~= myNetID then
                local dist = #(myPos - GetEntityCoords(ped))
                if dist <= maxDist then
                    result[#result+1] = {
                        player   = p,
                        serverId = netID,
                        name     = GetPlayerName(p),
                        dist     = dist,
                    }
                end
            end
        end
    end

    table.sort(result, function(a, b) return a.dist < b.dist end)
    return result
end

-- - love_tablet item -

BindItemEvent('LoveTablet', 'love_tablet', function()
    TriggerEvent('grim_lovemenu:openTablet')
end)

AddEventHandler('grim_lovemenu:openTablet', function()
    if not IsActionAllowed() then return end
    TriggerEvent('grim_lovemenu:tablet:open')
end)

RegisterCommand('lovemenu', function()
    TriggerEvent('grim_lovemenu:openTablet')
end, false)

-- - INVENTORY ITEM USE HANDLERS -
-- ox_inventory fires item use as a TriggerClientEvent (net event).
-- RegisterNetEvent is required for each item so FiveM doesn't silently drop them.
RegisterNetEvent('grim_lovemenu:item:love_tablet')
RegisterNetEvent('grim_lovemenu:item:pregnancy_test')
RegisterNetEvent('grim_lovemenu:item:prenatal_vitamins')
RegisterNetEvent('grim_lovemenu:item:contraception')
RegisterNetEvent('grim_lovemenu:item:condoms')
RegisterNetEvent('grim_lovemenu:item:std_test_kit')
RegisterNetEvent('grim_lovemenu:item:prescription_meds')
RegisterNetEvent('grim_lovemenu:item:plan_c')
RegisterNetEvent('grim_lovemenu:item:dna_test')
RegisterNetEvent('grim_lovemenu:item:dna_result')
RegisterNetEvent('grim_lovemenu:item:birth_cert_boy')
RegisterNetEvent('grim_lovemenu:item:birth_cert_girl')
RegisterNetEvent('grim_lovemenu:item:ultrasound_report')
RegisterNetEvent('grim_lovemenu:item:rhino_pill')
RegisterNetEvent('grim_lovemenu:item:lubricant')

BindItemEvent('PregnancyTest', 'pregnancy_test', function() UseServerItem('PregnancyTest', 'pregnancy_test') end)
BindItemEvent('PrenatalVitamins', 'prenatal_vitamins', function() UseServerItem('PrenatalVitamins', 'prenatal_vitamins') end)
BindItemEvent('Contraception', 'contraception', function() UseServerItem('Contraception', 'contraception') end)
BindItemEvent('Condoms', 'condoms', function() UseServerItem('Condoms', 'condoms') end)
BindItemEvent('STDTestKit', 'std_test_kit', function() UseServerItem('STDTestKit', 'std_test_kit') end)
BindItemEvent('PrescriptionMeds', 'prescription_meds', function() UseServerItem('PrescriptionMeds', 'prescription_meds') end)
BindItemEvent('PlanC', 'plan_c', function() UseServerItem('PlanC', 'plan_c') end)
BindItemEvent('RhinoPill', 'rhino_pill', function() UseServerItem('RhinoPill', 'rhino_pill') end)
BindItemEvent('Lubricant', 'lubricant', function() UseServerItem('Lubricant', 'lubricant') end)

BindItemEvent('DNATest', 'dna_test', function() OpenDNATablet() end)

BindItemEvent('DNAResult', 'dna_result', function() UseServerItem('DNAResult', 'dna_result') end)
BindItemEvent('BirthCertBoy', 'birth_cert_boy', function() UseServerItem('BirthCertBoy', 'birth_cert_boy') end)
BindItemEvent('BirthCertGirl', 'birth_cert_girl', function() UseServerItem('BirthCertGirl', 'birth_cert_girl') end)
BindItemEvent('UltrasoundReport', 'ultrasound_report', function() TriggerServerEvent('grim_lovemenu:sv:viewUltrasound') end)

-- - EXPORTS -
-- These are called by ox_inventory when a player uses an item (export= in item definition)

exports('useLoveTablet',       function() TriggerEvent('grim_lovemenu:openTablet') end)
exports('usePregnancyTest',    function() UseServerItem('PregnancyTest', 'pregnancy_test') end)
exports('usePrenatalVitamins', function() UseServerItem('PrenatalVitamins', 'prenatal_vitamins') end)
exports('useContraception',    function() UseServerItem('Contraception', 'contraception') end)
exports('useCondoms',          function() UseServerItem('Condoms', 'condoms') end)
exports('useSTDTest',          function() UseServerItem('STDTestKit', 'std_test_kit') end)
exports('usePrescriptionMeds', function() UseServerItem('PrescriptionMeds', 'prescription_meds') end)
exports('usePlanC',            function() UseServerItem('PlanC', 'plan_c') end)
exports('useDNATest',          function() OpenDNATablet() end)
exports('useDNAResult',        function() UseServerItem('DNAResult', 'dna_result') end)
exports('useBirthCertBoy',     function() UseServerItem('BirthCertBoy', 'birth_cert_boy') end)
exports('useBirthCertGirl',    function() UseServerItem('BirthCertGirl', 'birth_cert_girl') end)
exports('useUltrasoundReport', function() TriggerServerEvent('grim_lovemenu:sv:viewUltrasound') end)
exports('useRhinoPill',        function() UseServerItem('RhinoPill', 'rhino_pill') end)
exports('useLubricant',        function() UseServerItem('Lubricant', 'lubricant') end)
