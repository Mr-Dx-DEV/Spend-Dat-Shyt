---@class Framework
---@field name "qb" | "qbx" | "esx" | "ox" | "vrp" |  "custom"
---@field object table<string, any>

local prom = promise.new()

if GetResourceState('qbx_core') == 'started' then -- QBOX
    local obj = exports["qb-core"]:GetCoreObject()
    TABLE_USERS = "players"
    COLUMN_CHAR_ID = "citizenid"
    prom:resolve({
        name = 'qbx',
        object = obj,
    })
elseif GetResourceState('qb-core') == 'started' then -- QBCore
    local obj = exports['qb-core']:GetCoreObject()
    TABLE_USERS = "players"
    COLUMN_CHAR_ID = "citizenid"
    prom:resolve({
        name = 'qb',
        object = obj,
    })
elseif GetResourceState('es_extended') == 'started' then -- ESX
    TABLE_USERS = "users"
    COLUMN_CHAR_ID = "identifier"
    if HasExports('es_extended', 'getSharedObject') then
        prom:resolve({
            name = 'esx',
            object = exports['es_extended']:getSharedObject(),
        })
    else
        TriggerEvent('esx:getSharedObject', function(obj)
            prom:resolve({
                name = 'esx',
                object = obj,
            })
        end)
    end
elseif GetResourceState('ox_core') == 'started' then -- OX
    TABLE_USERS = "players"
    COLUMN_CHAR_ID = "charId"
    require '@ox_core.lib.init'
    prom:resolve({
        name = 'ox',
        object = Ox,
    })
elseif GetResourceState('vrp') == 'started' then -- VRP
    if type(module) ~= "function" then
        local utils = LoadResourceFile("vrp", "lib/utils.lua")
        if not utils then
            Luxu.print.error("vRP detected, but vrp/lib/utils.lua could not be loaded")
            Luxu.print.error("LuxU Admin vRP support targets official vRP 2 only")
            prom:reject()
            return Citizen.Await(prom)
        end

        local chunk, err = load(utils, "@vrp/lib/utils.lua")
        if not chunk then
            Luxu.print.error(("Failed to parse vRP utils: %s"):format(err))
            prom:reject()
            return Citizen.Await(prom)
        end

        chunk()
    end

    ---@diagnostic disable-next-line
    local Tunnel = module("vrp", "lib/Tunnel")
    ---@diagnostic disable-next-line
    local Proxy = module("vrp", "lib/Proxy")
    ---@diagnostic disable-next-line
    local vRP = Proxy.getInterface("vRP")

    if type(vRP.loadScript) ~= "function" then
        Luxu.print.error("Legacy vRP detected. LuxU Admin vRP support targets official vRP 2 only.")
        prom:reject()
        return Citizen.Await(prom)
    end

    vRP.loadScript(GetCurrentResourceName(), "bridge/vrp2/server")
    local vRP2 = Proxy.getInterface("luxu_admin_vrp2", GetCurrentResourceName())

    if vRP2.ping() ~= true then
        Luxu.print.error("Failed to initialize the LuxU Admin vRP 2 bridge")
        prom:reject()
        return Citizen.Await(prom)
    end

    prom:resolve({
        name = 'vrp',
        object = {
            proxy = vRP,
            adapter = vRP2,
            Tunnel = Tunnel,
            Proxy = Proxy,
        },
    })
else
    Luxu.print.error("Framework not detected")
    Luxu.print.warning("Make sure luxu_admin is the last resource to load")
    Luxu.print.error("If your framework is custom, please edit bridge/framework.lua")
    prom:reject()
end

return Citizen.Await(prom) --[[ @as Framework ]]
