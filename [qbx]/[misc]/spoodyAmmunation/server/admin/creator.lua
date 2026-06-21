---@class creator
---@field openMenu fun(self: creator, source: any)
creator = {}

--- OPEN SOURCE
--- You are free to edit the permission checks of this resource, whether you want to utilize your own admin menu exports or Discord API, you are free to do so!

lib.callback.register("spoodyAmmunation:creator:fetchShops", function(source)
    local permission = Configuration.Settings.Admin.Permission

    if not IsPlayerAceAllowed(source, permission) then
        return DropPlayer(source, "You have been kicked for an attempted exploit")
    end

    local fetch = db:loadShops() --[[@as databaseQuery]]

    if not fetch or table.type(fetch) == 'empty' then
        return false, Locales['Notification']['NOTIFICATION_SHOP_DOESNT_EXIST']
    end

    return type(fetch) == "string" and json.decode(fetch) or fetch
end)

---@param shopId string
---@param data { type: string, coords: vector3 }
lib.callback.register("spoodyAmmunation:creator:updateLocation", function(source, shopId, data)
    local permission = Configuration.Settings.Admin.Permission

    if not IsPlayerAceAllowed(source, permission) then
        return DropPlayer(source, "You have been kicked for an attempted exploit")
    end

    local _, status, response = db:editGunstoreLocation(shopId, data.type, data.coords)

    if not status then
        return false, server.notify(source, Locales['Titles']['TITLE_GUNSHOP_CREATOR'], response, 'error')
    end

    return true, server.notify(source, Locales['Titles']['TITLE_GUNSHOP_CREATOR'], Locales['Notification']['NOTIFICATION_STORE_LOCATION_UPDATE'], 'success')
end)

lib.callback.register("spoodyAmmunation:creator:deleteShop", function(source, storeId)
    local permission = Configuration.Settings.Admin.Permission

    if not IsPlayerAceAllowed(source, permission) then
        return DropPlayer(source, "You have been kicked for an attempted exploit")
    end

    local status = db:deleteShop(storeId)

    if status then
        return true, server.notify(source, Locales['Titles']['TITLE_GUNSHOP_CREATOR'], Locales['Notification']['NOTIFICATION_STORE_DELETED'], 'success')
    end

    return false, server.notify(source, Locales['Titles']['TITLE_GUNSHOP_CREATOR'], Locales['Notification']['NOTIFICATION_STORE_DELETED_FAIL'], 'error')
end)

---@param data { id: string, name: string, blipColor: string, points: { management: vector3, gunsmith: vector3, gunsmith_clockin: vector3 }}
lib.callback.register('spoodyAmmunation:createShop', function(source, data)
    local permission = Configuration.Settings.Admin.Permission

    if not IsPlayerAceAllowed(source, permission) then
        return DropPlayer(source, "You have been kicked for an attempted exploit")
    end

    local id = data.id
    local name = data.name

    if id and name then
        local response, message = db:createShopInternal({
            id = id,
            name = name,
            blipColor = 2,

            jobName = id,
            locations = {},
            dateCreated = os.time(),

            points = {
                management = data.points.management,
                gunsmith = data.points.gunsmith,
                gunsmith_clockin = data.points.gunsmith_clockin,
            },
        })

        if not response then
            return false, message
        end

        local created <const> = db:createShop(id, name)

        if not created then
            return false, "Failed to save gunstore to the SQL, please inform a developer."
        end

        return true
    end
end)

---@param data { name: string, id: string }
lib.callback.register('spoodyAmmunation:creator:sanitize', function(source, data)
    if not data then
        return false, "Failed to pass data to server."
    end

    if not data.id:match("^[A-Za-z_]+$") then
        return false, Locales['Notification']['NOTIFICATION_SHOPID_INVALID']
    end

    local exists <const> = db:exists(data.id, data.name)

    if exists then
        return false, Locales['Notification']['NOTIFICATION_SHOPID_EXISTS']
    end

    return true
end)

function creator:openMenu(source)
    local permission = Configuration.Settings.Admin.Permission

    if not IsPlayerAceAllowed(source, permission) then
        return server.notify(source, Locales['Titles']['TITLE_GUNSHOP_CREATOR'], Locales['Notification']['NOTIFICATION_AUTHORIZED'], 'error')
    end

    return TriggerClientEvent('spoodyAmmunation:openMenu', source)
end

function creator:setup()
    local enabled = Configuration.Settings.Admin.Enabled

    if not enabled then return end

    if Configuration.Settings.Admin.Permission == '' then
        return server.debugPrint("Failed to create admin command. [No ace permission submitted]")
    end

    RegisterCommand(Configuration.Settings.Admin.Command, function(source)
        creator:openMenu(source)
    end, false)

    RegisterCommand(Configuration.Settings.Commands.Delete, function(source, args)
        local storeid = args[1]

        if source == 0 then
            if not storeid then
                return server.debugPrint("Invalid store id given.")
            end

            return db:deleteShop(storeid)
        end
    end, false)
end

CreateThread(creator.setup)