local INTERFACE_NAME = "luxu_admin_vrp2"

local api = {}

local function toNumber(value)
    local number = tonumber(value)
    return number
end

local function shallowCopy(value)
    if type(value) ~= "table" then return value end
    local copy = {}
    for k, v in pairs(value) do
        if type(v) ~= "function" and type(v) ~= "userdata" and type(v) ~= "thread" then
            if type(v) == "table" then
                local nested = {}
                for nk, nv in pairs(v) do
                    if type(nv) ~= "function" and type(nv) ~= "userdata" and type(nv) ~= "thread" and type(nv) ~= "table" then
                        nested[nk] = nv
                    end
                end
                copy[k] = nested
            else
                copy[k] = v
            end
        end
    end
    return copy
end

local function getUserBySource(source)
    return vRP.users_by_source[toNumber(source)]
end

local function getUserByCid(cid)
    return vRP.users_by_cid[toNumber(cid)]
end

local function isReady(user)
    return user and user.isReady and user:isReady()
end

local function getIdentity(cid)
    cid = toNumber(cid)
    if not cid then return nil end

    if vRP.EXT.Identity and vRP.EXT.Identity.getIdentity then
        local ok, identity = pcall(vRP.EXT.Identity.getIdentity, vRP.EXT.Identity, cid)
        if ok then return identity end
    end

    return nil
end

local function getIdentityName(identity)
    if not identity then return "Unknown" end
    local firstname = identity.firstname or ""
    local lastname = identity.name or ""
    local fullName = (firstname .. " " .. lastname):gsub("^%s+", ""):gsub("%s+$", "")
    return fullName ~= "" and fullName or "Unknown"
end

local function decodeData(blob)
    if type(blob) ~= "string" or string.len(blob) == 0 then return {} end
    local ok, data = pcall(msgpack.unpack, blob)
    if ok and type(data) == "table" then return data end
    return {}
end

local function encodeData(data)
    return msgpack.pack(type(data) == "table" and data or {})
end

local function getDatatable(cid)
    cid = toNumber(cid)
    if not cid then return {} end

    local user = getUserByCid(cid)
    if isReady(user) then
        user.cdata = user.cdata or {}
        return user.cdata, user
    end

    return decodeData(vRP:getCData(cid, "vRP:datatable"))
end

local function setDatatable(cid, data)
    cid = toNumber(cid)
    if not cid then return false end

    local user = getUserByCid(cid)
    if isReady(user) then
        user.cdata = type(data) == "table" and data or {}
        user:save()
        return true
    end

    vRP:setCData(cid, "vRP:datatable", encodeData(data))
    return true
end

local function ensureDatatableSection(data, section)
    if type(data[section]) ~= "table" then data[section] = {} end
    return data[section]
end

local function computeItem(fullid)
    if not vRP.EXT.Inventory or not vRP.EXT.Inventory.computeItem then return nil end
    local ok, citem = pcall(vRP.EXT.Inventory.computeItem, vRP.EXT.Inventory, fullid)
    if ok then return citem end
end

local function formatInventory(inventory)
    local formatted = {}
    local slot = 1

    for fullid, amount in pairs(inventory or {}) do
        amount = tonumber(amount) or 0
        if amount > 0 then
            local citem = computeItem(fullid)
            formatted[#formatted + 1] = {
                name = fullid,
                label = (citem and citem.name) or fullid,
                amount = amount,
                count = amount,
                slot = slot,
            }
            slot = slot + 1
        end
    end

    return formatted
end

local function arrayToInventory(items)
    local inventory = {}

    if type(items) ~= "table" then return inventory end
    for _, item in pairs(items) do
        if type(item) == "table" and item.name then
            local amount = tonumber(item.amount or item.count) or 0
            if amount > 0 then
                inventory[item.name] = (inventory[item.name] or 0) + amount
            end
        end
    end

    return inventory
end

local function getGroupConfig(name)
    local groupExt = vRP.EXT.Group
    return groupExt and groupExt.cfg and groupExt.cfg.groups and groupExt.cfg.groups[name]
end

local function getGroupTitle(name)
    local groupExt = vRP.EXT.Group
    if groupExt and groupExt.getGroupTitle then
        local ok, title = pcall(groupExt.getGroupTitle, groupExt, name)
        if ok and title then return title end
    end

    local cfg = getGroupConfig(name)
    return cfg and cfg._config and cfg._config.title or name
end

local function getGroupType(name)
    local cfg = getGroupConfig(name)
    return cfg and cfg._config and cfg._config.gtype
end

local function getGroupByTypeFromMap(groups, gtype)
    for name in pairs(groups or {}) do
        if getGroupType(name) == gtype then return name end
    end
end

local function formatTypedGroup(groups, gtype)
    local name = getGroupByTypeFromMap(groups, gtype)
    if not name then return nil end
    local label = getGroupTitle(name)

    if gtype == "gang" then
        return {
            name = name,
            label = label,
            grade = { name = label, level = 0, isboss = false },
        }
    end

    return {
        name = name,
        label = label,
        grade = 0,
        gradeName = label,
        duty = true,
    }
end

local function setGroupByTypeInMap(groups, gtype, newGroup)
    if type(groups) ~= "table" then groups = {} end

    for name in pairs(shallowCopy(groups)) do
        if getGroupType(name) == gtype then groups[name] = nil end
    end

    if newGroup and newGroup ~= "" and getGroupConfig(newGroup) then
        groups[newGroup] = true
    end

    return groups
end

local function formatVehicle(model, state)
    local label = model

    local garageExt = vRP.EXT.Garage
    local garageTypes = garageExt and garageExt.cfg and garageExt.cfg.garage_types
    if garageTypes then
        for _, garage in pairs(garageTypes) do
            local info = type(garage) == "table" and garage[model]
            if type(info) == "table" then
                label = info[1] or model
                break
            end
        end
    end

    return {
        model = model,
        name = model,
        label = label,
        plate = model,
        stored = state ~= 0,
    }
end

local function normalizeVehicleModel(model)
    if model == nil then return nil end

    model = tostring(model)
    model = model:gsub("^%s+", ""):gsub("%s+$", "")
    if model == "" then return nil end

    return model
end

local function getGarageVehicleInfo(model)
    model = normalizeVehicleModel(model)
    if not model then return nil end

    local garageExt = vRP.EXT.Garage
    local garageTypes = garageExt and garageExt.cfg and garageExt.cfg.garage_types
    if not garageTypes then return model, nil end

    local loweredModel = string.lower(model)
    for _, garage in pairs(garageTypes) do
        if type(garage) == "table" then
            local exactInfo = garage[model]
            if type(exactInfo) == "table" then return model, exactInfo end

            for configuredModel, info in pairs(garage) do
                if type(configuredModel) == "string" and configuredModel ~= "_config" and type(info) == "table" then
                    if string.lower(configuredModel) == loweredModel then
                        return configuredModel, info
                    end
                end
            end
        end
    end

    return nil
end

local function getGarageVehicleModelList()
    local garageExt = vRP.EXT.Garage
    local garageTypes = garageExt and garageExt.cfg and garageExt.cfg.garage_types
    local models = {}
    local seen = {}

    if not garageTypes then return models end

    for _, garage in pairs(garageTypes) do
        if type(garage) == "table" then
            for model, info in pairs(garage) do
                if type(model) == "string" and model ~= "_config" and type(info) == "table" and not seen[model] then
                    seen[model] = true
                    models[#models + 1] = model
                end
            end
        end
    end

    table.sort(models, function(a, b)
        return string.lower(a) < string.lower(b)
    end)

    return models
end

local function getVehicleMap(cid)
    local user = getUserByCid(cid)
    if isReady(user) and user.getVehicles then
        return user:getVehicles(), user
    end

    local data = getDatatable(cid)
    return ensureDatatableSection(data, "vehicles"), nil, data
end

local function saveVehicleMap(cid, user, data)
    if user and user.save then
        user:save()
        return true
    end

    return setDatatable(cid, data)
end

local function getAccountsFromData(data)
    local wallet = tonumber(data.wallet) or 0
    local bank = tonumber(data.bank) or 0
    return { bank = bank, wallet = wallet }
end

function api.ping()
    return true
end

function api.getUser(source)
    local user = getUserBySource(source)
    if not isReady(user) then return nil end

    local identity = getIdentity(user.cid)
    local groups = user.getGroups and user:getGroups() or user.cdata and user.cdata.groups or {}

    return {
        source = user.source,
        id = tostring(user.id),
        user_id = tostring(user.id),
        cid = tostring(user.cid),
        name = user.name,
        identity = shallowCopy(identity),
        groups = shallowCopy(groups),
    }
end

function api.getCharacterData(source)
    local user = getUserBySource(source)
    if not isReady(user) then return nil end

    local identity = getIdentity(user.cid)
    local groups = user.getGroups and user:getGroups() or user.cdata and user.cdata.groups or {}

    return {
        id = tostring(user.cid),
        name = getIdentityName(identity),
        birthday = identity and identity.age and tostring(identity.age) or nil,
        phoneNumber = identity and identity.phone or nil,
        job = formatTypedGroup(groups, "job"),
        gang = formatTypedGroup(groups, "gang"),
    }
end

function api.getMoneyAccounts(source)
    local user = getUserBySource(source)
    if not isReady(user) then return {} end

    if user.getBank and user.getWallet then
        local wallet = tonumber(user:getWallet()) or 0
        local bank = tonumber(user:getBank()) or 0
        return { bank = bank, wallet = wallet }
    end

    return getAccountsFromData(user.cdata or {})
end

function api.setAccountMoney(source, account, amount)
    local user = getUserBySource(source)
    if not isReady(user) then return false end

    amount = tonumber(amount) or 0
    if account == "bank" then
        if user.setBank then user:setBank(amount) else user.cdata.bank = amount end
    else
        if user.setWallet then user:setWallet(amount) else user.cdata.wallet = amount end
    end

    if user.save then user:save() end
    return true
end

function api.revive(source)
    source = toNumber(source)
    if not source then return false end

    if vRP.EXT.Survival and vRP.EXT.Survival.remote and vRP.EXT.Survival.remote._varyHealth then
        vRP.EXT.Survival.remote._varyHealth(source, 100)
        return true
    end

    if vRP.EXT.PlayerState and vRP.EXT.PlayerState.remote and vRP.EXT.PlayerState.remote._setHealth then
        vRP.EXT.PlayerState.remote._setHealth(source, 200)
        return true
    end

    return false
end

function api.getInventory(source)
    local user = getUserBySource(source)
    if not isReady(user) then return {} end

    local inventory = user.getInventory and user:getInventory() or user.cdata and user.cdata.inventory or {}
    return formatInventory(inventory)
end

function api.canCarryItem(source, item, amount)
    local user = getUserBySource(source)
    if not isReady(user) or not user.tryGiveItem then return false end
    return user:tryGiveItem(item, tonumber(amount) or 0, true, true) == true
end

function api.giveItem(source, item, amount)
    local user = getUserBySource(source)
    if not isReady(user) or not user.tryGiveItem then return false end
    return user:tryGiveItem(item, tonumber(amount) or 0, false, true) == true
end

function api.takeItem(source, item, amount)
    local user = getUserBySource(source)
    if not isReady(user) or not user.tryTakeItem then return false end
    return user:tryTakeItem(item, tonumber(amount) or 0, false, true) == true
end

function api.getItemCount(source, item)
    local user = getUserBySource(source)
    if not isReady(user) then return 0 end

    if user.getItemAmount then return tonumber(user:getItemAmount(item)) or 0 end
    local inventory = user.cdata and user.cdata.inventory or {}
    return tonumber(inventory[item]) or 0
end

function api.getItems()
    if not vRP.EXT.Inventory or not vRP.EXT.Inventory.items then return {} end

    local list = {}
    for id in pairs(vRP.EXT.Inventory.items) do
        local citem = computeItem(id)
        list[#list + 1] = {
            name = id,
            label = (citem and citem.name) or id,
        }
    end

    return list
end

function api.getAllPlayersInventory()
    local result = {}
    for _, user in pairs(vRP.users or {}) do
        if isReady(user) then
            local identity = getIdentity(user.cid)
            local inventory = user.getInventory and user:getInventory() or user.cdata and user.cdata.inventory or {}
            result[#result + 1] = {
                charId = tostring(user.cid),
                name = getIdentityName(identity),
                inventory = formatInventory(inventory),
            }
        end
    end

    return result
end

function api.getJob(source)
    local user = getUserBySource(source)
    if not isReady(user) then return nil end
    local groups = user.getGroups and user:getGroups() or user.cdata and user.cdata.groups or {}
    return formatTypedGroup(groups, "job")
end

function api.getGang(source)
    local user = getUserBySource(source)
    if not isReady(user) then return nil end
    local groups = user.getGroups and user:getGroups() or user.cdata and user.cdata.groups or {}
    return formatTypedGroup(groups, "gang")
end

function api.setGroupByType(source, gtype, group)
    local user = getUserBySource(source)
    if not isReady(user) then return false end

    if user.addGroup and user.removeGroup then
        local currentGroup = user.getGroupByType and user:getGroupByType(gtype)
        if currentGroup and (not group or group == "" or currentGroup ~= group) then
            user:removeGroup(currentGroup)
        end

        if group and group ~= "" then user:addGroup(group) end
        if user.save then user:save() end
        return true
    end

    user.cdata.groups = setGroupByTypeInMap(user.cdata.groups or {}, gtype, group)
    if user.save then user:save() end
    return true
end

function api.getGroupsByType(gtype)
    local groupExt = vRP.EXT.Group
    local groups = groupExt and groupExt.cfg and groupExt.cfg.groups or {}
    local result = {}

    for name, cfg in pairs(groups) do
        if cfg and cfg._config and cfg._config.gtype == gtype then
            local label = getGroupTitle(name)
            result[#result + 1] = {
                name = name,
                label = label,
                grades = {
                    { name = label, label = label, grade = 0, isBoss = false, payment = 0 },
                },
            }
        end
    end

    return result
end

function api.getDatatable(cid)
    return getDatatable(cid)
end

function api.setDatatable(cid, data)
    return setDatatable(cid, data)
end

function api.getOfflineAccounts(cid)
    local data = getDatatable(cid)
    return getAccountsFromData(data)
end

function api.setOfflineAccount(cid, account, amount)
    local data = getDatatable(cid)
    amount = tonumber(amount) or 0

    if account == "bank" then
        data.bank = amount
    else
        data.wallet = amount
    end

    return setDatatable(cid, data)
end

function api.setOfflineAccounts(cid, accounts)
    local data = getDatatable(cid)
    accounts = type(accounts) == "table" and accounts or {}
    data.bank = tonumber(accounts.bank) or 0
    data.wallet = tonumber(accounts.wallet or accounts.money or accounts.cash) or 0
    return setDatatable(cid, data)
end

function api.getOfflineInventory(cid)
    local data = getDatatable(cid)
    return formatInventory(data.inventory or {})
end

function api.setOfflineInventory(cid, items)
    local data = getDatatable(cid)
    data.inventory = arrayToInventory(items)
    return setDatatable(cid, data)
end

function api.getOfflineCharacterDetails(cid)
    local data = getDatatable(cid)
    local identity = getIdentity(cid)
    local groups = data.groups or {}

    return {
        accounts = getAccountsFromData(data),
        identity = shallowCopy(identity),
        job = formatTypedGroup(groups, "job"),
        gang = formatTypedGroup(groups, "gang"),
        position = data.state and data.state.position or nil,
        customization = data.state and data.state.customization or nil,
    }
end

function api.setOfflineGroupByType(cid, gtype, group)
    local user = getUserByCid(cid)
    if isReady(user) then
        return api.setGroupByType(user.source, gtype, group)
    end

    local data = getDatatable(cid)
    data.groups = setGroupByTypeInMap(data.groups or {}, gtype, group)
    return setDatatable(cid, data)
end

function api.getOwnedVehicles(cid)
    cid = toNumber(cid)
    if not cid then return {} end

    local vehicles = getVehicleMap(cid)
    local result = {}
    for model, state in pairs(vehicles or {}) do
        result[#result + 1] = formatVehicle(model, state)
    end

    return result
end

function api.giveVehicle(cid, model)
    cid = toNumber(cid)
    if not cid or not model then return false end

    model = getGarageVehicleInfo(model)
    if not model then return false end

    local vehicles, user, data = getVehicleMap(cid)
    vehicles[model] = 1
    return saveVehicleMap(cid, user, data)
end

function api.deleteVehicle(cid, model)
    cid = toNumber(cid)
    if not cid or not model then return false end

    local vehicles, user, data = getVehicleMap(cid)
    if not vehicles[model] then return false end

    vehicles[model] = nil
    return saveVehicleMap(cid, user, data)
end

function api.setVehicleStored(cid, model)
    cid = toNumber(cid)
    if not cid or not model then return false end

    local vehicles, user, data = getVehicleMap(cid)
    if not vehicles[model] then return false end

    vehicles[model] = 1
    return saveVehicleMap(cid, user, data)
end

function api.changeVehicleOwner(oldCid, newCid, model)
    oldCid = toNumber(oldCid)
    newCid = toNumber(newCid)
    if not oldCid or not newCid or not model then return false end

    local oldVehicles, oldUser, oldData = getVehicleMap(oldCid)
    if not oldVehicles[model] then return false end

    oldVehicles[model] = nil
    if not saveVehicleMap(oldCid, oldUser, oldData) then return false end

    local newVehicles, newUser, newData = getVehicleMap(newCid)
    newVehicles[model] = 1
    return saveVehicleMap(newCid, newUser, newData)
end

function api.getGarageVehicleModels()
    return getGarageVehicleModelList()
end

local LuxuAdmin = class("LuxuAdmin", vRP.Extension)
LuxuAdmin.event = {}

function LuxuAdmin.event:characterLoad(user)
    TriggerEvent("luxu_admin:server:playerLoaded", tonumber(user.source))
end

if not vRP.EXT.LuxuAdmin then
    vRP:registerExtension(LuxuAdmin)
end

Proxy.addInterface(INTERFACE_NAME, api)
