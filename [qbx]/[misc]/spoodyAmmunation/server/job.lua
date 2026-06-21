---@class job
local _job = {
    translations = {
        ['rifle'] = 'Rifle',
        ['pistol'] = 'Pistol',
        ['smg'] = 'SMG',
        ['shotgun'] = 'Shotgun',
        ['melee'] = 'Melee',
    }
}

---@param shopId string
---@return boolean | table
function _job.getStorePackage(shopId)
    local data = Configuration.Gunstores[shopId]
    local fetch = MySQL.single.await("SELECT * FROM `spoody_gunstores` WHERE `storeid` = ?", { shopId })

    if not fetch then
        return false
    end

    if not data then
        return false
    end

    return {
        name = data.name or 'Unknown',
        revenue = fetch.revenue or 0,
        sales = fetch.cash or 0,
        dateCreated = data.dateCreated or 00000000,
        stock = (type(fetch.stock) == "string" and json.decode(fetch.stock) or fetch.stock) or {},
        recentPurchases = (type(fetch.sales_history) == "string" and json.decode(fetch.sales_history) or fetch.sales_history) or {},
    }
end

lib.callback.register("spoodyAmmunation:reqPackage", function(source, shopId)
    return _job.getStorePackage(shopId)
end)

lib.callback.register("spoodyAmmunation:getEmployeePackage", function(source, shopId)
    local qPlayer = QBCore.Functions.GetPlayer(source)
    local job = qPlayer.PlayerData.job.name

    if job == shopId then
        local fetch = MySQL.scalar.await("SELECT `employees` FROM `spoody_gunstores` WHERE `storeid` = ?", {
            shopId
        })

        return (type(fetch) == "string" and json.decode(fetch) or fetch)
    end
end)

lib.callback.register("spoodyAmmunation:getWeaponsStock", function(source, shopId)
    local qPlayer = QBCore.Functions.GetPlayer(source)
    local job = qPlayer.PlayerData.job.name

    if job == shopId then
        local fetch = MySQL.scalar.await("SELECT `stock` FROM `spoody_gunstores` WHERE `storeid` = ?", {
            shopId
        })

        return (type(fetch) == "string" and json.decode(fetch) or fetch)
    end
end)

lib.callback.register("spoodyAmmunation:removeProduct", function(source, shopId, weapon, category)
    local qPlayer = QBCore.Functions.GetPlayer(source)
    local job = qPlayer.PlayerData.job.name

    if not weapon and category then
        return false, "Invalid weapon data provided."
    end

    if job == shopId then
        local fetch = MySQL.scalar.await("SELECT `stock` FROM `spoody_gunstores` WHERE `storeid` = ?", {
            shopId
        })

        local data = (type(fetch) == "string" and json.decode(fetch) or fetch)

        if data[category] then
            for i = #data[category], 1, -1 do
                if data[category][i].hash == weapon then
                    table.remove(data[category], i)
                    break
                end
            end
        end

        local success = MySQL.update.await("UPDATE `spoody_gunstores` SET `stock` = ? WHERE `storeid` = ?", { json.encode(data), shopId })

        if success then
            return true
        end
    end

    return false, "Failed to remove product."
end)

lib.callback.register('spoodyAmmunation:updateProductPrice', function(source, shopId, weapon, category, price)
    local qPlayer = QBCore.Functions.GetPlayer(source)
    local job = qPlayer.PlayerData.job.name
    local minPrice = Configuration.Weapons[category][weapon].minimumPrice

    if price < minPrice then
        return false, Locales['Notification']['NOTIFICATION_PRICE_BELOW_MIN']
    end

    if job == shopId then
        local fetch = MySQL.scalar.await("SELECT `stock` FROM `spoody_gunstores` WHERE `storeid` = ?", {
            shopId
        })

        local data = (type(fetch) == "string" and json.decode(fetch) or fetch)

        if data[category] then
            for _, product in ipairs(data[category]) do
                if product.hash == weapon then
                    if product.price == price then
                        return false, Locales['Notification']['NOTIFICATION_PRICE_SAME']
                    end

                    product.price = price
                    break
                end
            end
        end

        local success = MySQL.update.await("UPDATE `spoody_gunstores` SET `stock` = ? WHERE `storeid` = ?", { json.encode(data), shopId })

        if success then
            return true
        end
    end

    return false, Locales['Notification']['NOTIFICATION_PRICE_UPDATE_FAIL']
end)

lib.callback.register("spoodyAmmunation:createPoint", function (source, shopId, pointType, coords)
    local qPlayer = QBCore.Functions.GetPlayer(source)
    local job = qPlayer.PlayerData.job.name

    if job == shopId then
        local fetch = MySQL.scalar.await("SELECT `points` FROM `spoody_gunstores` WHERE `storeid` = ?", {
            shopId
        })

        local data = (type(fetch) == "string" and json.decode(fetch) or fetch)

        if data then
            table.insert(data, { type = pointType, coords = coords, label = ('Point %s'):format(#data + 1) })
        end

        local success = MySQL.update.await("UPDATE `spoody_gunstores` SET `points` = ? WHERE `storeid` = ?", { json.encode(data), shopId })

        if success then
            return true, db:loadPoints(true)
        end
    end

    return false, Locales['Notification']['NOTIFICATION_POINT_CREATE_FAIL']
end)

lib.callback.register("spoodyAmmunation:deletePoint", function (source, shopId, point)
    local qPlayer = QBCore.Functions.GetPlayer(source)
    local job = qPlayer.PlayerData.job.name

    if job == shopId then
        local fetch = MySQL.scalar.await("SELECT `points` FROM `spoody_gunstores` WHERE `storeid` = ?", {
            shopId
        })

        local data = (type(fetch) == "string" and json.decode(fetch) or fetch)

        if data then
            for i = #data, 1, -1 do
                if data[i].label == point then
                    table.remove(data, i)
                    break
                end
            end
        end

        local success = MySQL.update.await("UPDATE `spoody_gunstores` SET `points` = ? WHERE `storeid` = ?", { json.encode(data), shopId })

        if success then
            return true, db:loadPoints(true)
        end

        return false, Locales['Notification']['NOTIFICATION_POINT_DELETE_FAIL']
    end

    return false, Locales['Notification']['NOTIFICATION_POINT_DELETE_FAIL']
end)

lib.callback.register("spoodyAmmunation:getPoints", function (source, shopId)
    local qPlayer = QBCore.Functions.GetPlayer(source)
    local job = qPlayer.PlayerData.job.name

    if job == shopId then
        local fetch = MySQL.scalar.await("SELECT `points` FROM `spoody_gunstores` WHERE `storeid` = ?", {
            shopId
        })

        return (type(fetch) == "string" and json.decode(fetch) or fetch)
    end
end)

lib.callback.register("spoodyAmmunation:getWeaponStock", function(source, shopId, weapon, category)
    local qPlayer = QBCore.Functions.GetPlayer(source)
    local job = qPlayer.PlayerData.job.name

    if job == shopId then
        local fetch = MySQL.scalar.await("SELECT `stock` FROM `spoody_gunstores` WHERE `storeid` = ?", {
            shopId
        })

        local data = (type(fetch) == "string" and json.decode(fetch) or fetch)

        if data[category] then
            for _, product in ipairs(data[category]) do
                if product.hash == weapon then
                    return product.stock, product.price
                end
            end
        end
    end
end)

lib.callback.register("spoodyAmmunation:getMunitions", function (source, shopId)
    return db:getMunitions(shopId)
end)

lib.callback.register("spoodyAmmunation:attemptOrderMunitions", function(source, shopId, amount)
    local qPlayer = QBCore.Functions.GetPlayer(source)
    local job = qPlayer.PlayerData.job.name

    if job == shopId then
        local finances = db:getShopFinance(shopId)
        local munitions = db:getMunitions(shopId)

        if finances.cash < amount * Configuration.Settings.Munitions.PricePerMunition then
            return false, Locales['Notification']['NOTIFICATION_VAULT_INSUFFICIENT']
        end

        if munitions + amount > Configuration.Settings.Munitions.Max then
            return false, Locales['Notification']['NOTIFICATION_STORAGE_INSUFFICIENT']
        end

        local updated = db:addMunitions(shopId, amount)

        if updated then
            return db:withdrawCash(shopId, amount * Configuration.Settings.Munitions.PricePerMunition)
        end
    end
end)

lib.callback.register("spoodyAmmunation:attemptRemoveMunitions", function(source, shopId, amount)
    local qPlayer = QBCore.Functions.GetPlayer(source)
    if not qPlayer then return false, "Failed to fetch player." end

    local job = qPlayer.PlayerData.job.name

    if job ~= shopId then
        return false, Locales['Notification']['NOTIFICATION_AUTHORIZED']
    end

    local status, response = db:removeMunitions(shopId, amount)

    if not status then
        return false, response
    end

    return true
end)

lib.callback.register("spoodyAmmunation:attemptAddWeapon", function(source, shopId, weapon, category, amount)
    local qPlayer = QBCore.Functions.GetPlayer(source)
    if not qPlayer then return false, "Failed to fetch player." end

    local job = qPlayer.PlayerData.job.name

    if job ~= shopId then
        return false, Locales['Notification']['NOTIFICATION_AUTHORIZED']
    end

    local status, response = db:increaseStock(shopId, category, weapon, amount)

    if not status then
        return false, response
    end

    return true
end)

lib.callback.register("spoodyAmmunation:addProduct", function(source, shopId, category, hash, price, label)
    local qPlayer = QBCore.Functions.GetPlayer(source)
    local job = qPlayer.PlayerData.job.name

    local licensePrice = Configuration.Weapons[category][hash].licensedPrice
    local minPrice = Configuration.Weapons[category][hash].minimumPrice
    local shopFinance = db:getShopFinance(shopId)

    ---@alias ProductArray { [string]: { label: string, stock: number, price: number, hash: string} }

    if job == shopId then
        if not hash or not category then
            return server.notify(source, Locales['Titles']['TITLE_ERROR'], Locales['Notification']['NOTIFICATION_WEAPON_INVALID_DATA'], 'error')
        end

        if not shopFinance then
            return server.notify(source, Locales['Titles']['TITLE_ERROR'], Locales['Notification']['NOTIFICATION_SHOP_FINANCE_FAILED'], 'error')
        end

        if shopFinance.cash < licensePrice then
            return server.notify(source, Locales['Titles']['TITLE_ERROR'], Locales['Notification']['NOTIFICATION_SHOP_VAULT_INSUFFICIENT'], 'error')
        end

        if price < minPrice then
            return server.notify(source, Locales['Titles']['TITLE_ERROR'], Locales['Notification']['NOTIFICATION_PRICE_BELOW_MIN'], 'error')
        end

        local currentStock = MySQL.scalar.await('SELECT `stock` FROM `spoody_gunstores` WHERE `storeid` = ?', { shopId })
        local stockTable = currentStock and json.decode(currentStock) or {}

        if stockTable[category] then
            for _, product in ipairs(stockTable[category]) do
                if product.hash == hash then
                    return server.notify(source, Locales['Titles']['TITLE_ERROR'], (Locales['Notification']['NOTIFICATION_WEAPON_ALREADY_EXISTS']):format(category), 'error')
                end
            end
        else
            stockTable[category] = {}
        end

        table.insert(stockTable[category], { label = label, stock = 0, price = price, hash = hash })

        local success = MySQL.update.await('UPDATE spoody_gunstores SET stock = ? WHERE `storeid` = ?', { json.encode(stockTable), shopId })

        db:withdrawCash(shopId, licensePrice)

        if success then
            server.notify(source, Locales['Titles']['TITLE_SUCCESS'], (Locales['Notification']['NOTIFICATION_WEAPON_ADDED_SUCCESS']):format(category), 'success')
        else
            server.notify(source, Locales['Titles']['TITLE_ERROR'], 'Failed to add weapon to database.', 'error')
        end
    end
end)

---@alias types
---| 'success' # The hire was successful
---| 'fail' # The hire failed
---@param type types
---@return nil, nil
RegisterNetEvent("spoodyAmmunation:hire", function(type, data)
    local source = source
    local qPlayer = QBCore.Functions.GetPlayer(source)

    if type ~= 'success' and type ~= 'fail' then
        return DropPlayer(source, "Attempted to exploit event")
    end

    local name = ('%s %s'):format(qPlayer.PlayerData.charinfo.firstname, qPlayer.PlayerData.charinfo.lastname)

    if type == 'success' then
        server.notify(data.source, Locales['Titles']['TITLE_MANAGER_EMPLOYEE'], (Locales['Notification']['NOTIFICATION_PROMPT_ACCEPTED']):format(name, data.position_label), 'success')
        server.notify(source, Locales['Titles']['TITLE_MANAGER_EMPLOYEE'], (Locales['Notification']['NOTIFICATION_PROMP_HIRED']):format(data.name, data.position_label))

        return qPlayer.Functions.SetJob(data.shopId, data.position)
    elseif type == 'fail' then
        return server.notify(data.source, Locales['Titles']['TITLE_MANAGER_EMPLOYEE'], (Locales['Notification']['NOTIFICATION_PROMPT_REJECTED']):format(name), 'warning')
    end
end)

---@param data { name: string, identifier: string, grade: string, position: string }
lib.callback.register("spoodyAmmunation:promote", function(source, data, newPosition, shopId)
    local qPlayer = QBCore.Functions.GetPlayer(source)
    local qTarget = QBCore.Functions.GetPlayerByCitizenId(data.identifier)

    if qPlayer.PlayerData.job.name == shopId then
        local table = MySQL.scalar.await("SELECT `employees` FROM `spoody_gunstores` WHERE `storeid` = ?", { shopId })
        local index = json.decode(table)
        local job_data = Configuration.Settings.Grades[newPosition]

        if index[data.name] then
            index[data.name].grade = newPosition
            index[data.name].label = job_data.label
        end

        local updated = MySQL.update.await("UPDATE `spoody_gunstores` SET `employees` = ? WHERE `storeid` = ?", { json.encode(index), shopId })

        if updated then
            if qTarget ~= nil then
                local playerSource = QBCore.Functions.GetSource(data.identifier)

                qTarget.Functions.SetJob(shopId, newPosition)
                server.notify(playerSource, Locales['Titles']['TITLE_MANAGER_EMPLOYEE'], (Locales['Notification']['NOTIFICATION_JOB_POS_CHANGED']):format(job_data.label))
            else
                MySQL.update.await("UPDATE `users` SET `job_grade` = ? WHERE `identifier` = ?", { newPosition, data.identifier })
            end

            return server.notify(source, Locales['Titles']['TITLE_MANAGER_EMPLOYEE'], (Locales['Notification']['NOTIFICATION_JOB_SET_PLAYER']):format(data.name, newPosition), 'success')
        end
    end

    return false
end)

---@param data { name: string, identifier: string, grade: string, position: string }
lib.callback.register("spoodyAmmunation:firePlayer", function(source, data, shopId)
    local qPlayer = QBCore.Functions.GetPlayer(source)
    local qTarget = QBCore.Functions.GetPlayerByCitizenId(data.identifier)

    if qPlayer.PlayerData.job.name == shopId then
        local table = MySQL.scalar.await("SELECT `employees` FROM `spoody_gunstores` WHERE `storeid` = ?", { shopId })
        local index = json.decode(table)

        if index[data.name] then
            index[data.name] = nil
        end

        local updated = MySQL.update.await("UPDATE `spoody_gunstores` SET `employees` = ? WHERE `storeid` = ?", { json.encode(index), shopId })

        if updated then
            if qTarget ~= nil then
                qTarget.Functions.SetJob(Configuration.Settings.Player.UnemployedJob, Configuration.Settings.Player.UnemployedGrade)
            else
                MySQL.update.await("UPDATE `users` SET `job` = ?, `job_grade` = ? WHERE `identifier` = ?", { Configuration.Settings.Player.UnemployedJob, Configuration.Settings.Player.UnemployedGrade })
            end

            return server.notify(source, Locales['Titles']['TITLE_MANAGER_EMPLOYEE'], (Locales['Notification']['NOTIFICATION_JOB_FIRED']):format(data.name), 'success')
        end
    end
end)

lib.callback.register("spoodyAmmunation:hirePlayer", function(source, shopId, target, position)
    local qPlayer = QBCore.Functions.GetPlayer(source)
    local job = qPlayer.PlayerData.job.name
    local index = Configuration.Gunstores[shopId]

    if job == shopId then
        local exists = DoesPlayerExist(target)
        local offered = Configuration.Settings.Grades[position]

        if not exists then
            return false, server.notify(source, Locales['Titles']['TITLE_MANAGER_EMPLOYEE'], (Locales['Notification']['NOTIFICATION_PLAYER_NOT_EXISTS']), 'error')
        end

        local qTarget = QBCore.Functions.GetPlayer(target)
        local retval = { position_label = offered.label, shopId = shopId, position = position, pay = offered.base_salary, source = source, name = index.name }

        if qTarget.PlayerData.job.name ~= shopId then
            return true, TriggerClientEvent("spoodyAmmunation:promptPlayer", target, retval)
        end

        return false, server.notify(source, Locales['Titles']['TITLE_MANAGER_EMPLOYEE'], Locales['Notification']['NOTIFICATION_PLAYER_ALREADY_HIRED'], 'warning')
    end

    return false, server.notify(source, Locales['Titles']['TITLE_MANAGER_EMPLOYEE'], Locales['Notification']['NOTIFICATION_AUTHORIZED'], 'error')
end)

lib.callback.register("spoodyAmmunation:deposit", function(source, shopId, amount)
    local qPlayer = QBCore.Functions.GetPlayer(source)
    local job = qPlayer.PlayerData.job.name

    if job ~= shopId then return false end

    if type(amount) ~= "number" or amount <= 0 then
        return false, server.notify(source, Locales['Titles']['TITLE_FINANCE_MANAGER'], Locales['Notification']['NOTIFICATION_INVALID_NUMBER'], 'error')
    end

    local cash = qPlayer.PlayerData.money.cash

    if amount > cash then
        return false, server.notify(source, Locales['Titles']['TITLE_FINANCE_MANAGER'], Locales['Notification']['NOTIFICATION_BALANCE_WITHDRAW_FAILED'], 'error')
    end

    local success = db:depositCash(shopId, amount)

    if success then
        qPlayer.Functions.RemoveMoney('cash', amount)
        return true, server.notify(source, Locales['Titles']['TITLE_FINANCE_MANAGER'], (Locales['Notification']['NOTIFICATION_BALANCE_DEPO_SUCCESS']):format(GroupDigits(tonumber(amount))), 'success')
    end

    return false
end)

lib.callback.register("spoodyAmmunation:withdraw", function(source, shopId, amount)
    local qPlayer = QBCore.Functions.GetPlayer(source)
    local job = qPlayer.PlayerData.job.name

    if job ~= shopId then return false end

    if type(amount) ~= "number" or amount <= 0 then
        return false, server.notify(source, Locales['Titles']['TITLE_FINANCE_MANAGER'], Locales['Notification']['NOTIFICATION_INVALID_NUMBER'], 'error')
    end

    local finances = db:getShopFinance(shopId) --[[@as FinanceRetval]]

    if not finances or type(finances.cash) ~= "number" then
        return false, server.notify(source, Locales['Titles']['TITLE_FINANCE_MANAGER'], Locales['Notification']['NOTIFICATION_WITHDRAW_FAILED_FETCH'], 'error')
    end

    if amount > finances.cash then
        return false, server.notify(source, Locales['Titles']['TITLE_FINANCE_MANAGER'], Locales['Notification']['NOTIFICATION_BALANCE_WITHDRAW_FAILED'], 'error')
    end

    local success = db:withdrawCash(shopId, amount)

    if success then
        qPlayer.Functions.AddMoney('cash', amount)
        return true, server.notify(source, Locales['Titles']['TITLE_FINANCE_MANAGER'], (Locales['Notification']['NOTIFICATION_WITHDRAW_SUCCESS']):format(GroupDigits(tonumber(amount))), 'success')
    end

    return false, server.notify(source, Locales['Titles']['TITLE_FINANCE_MANAGER'], Locales['Notification']['NOTIFICATION_WITHDRAW_FAILED_FETCH'], 'error')
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(player, job, previousJob)
    local qPlayer = QBCore.Functions.GetPlayer(source)
    if not qPlayer then return end

    local identifier = qPlayer.PlayerData.citizenid
    local name = ('%s %s'):format(qPlayer.PlayerData.charinfo.firstname, qPlayer.PlayerData.charinfo.lastname)

    local new_store = Configuration.Gunstores[job.name] ~= nil
    local old_store = Configuration.Gunstores[previousJob.name] ~= nil

    if new_store then
        local query = MySQL.scalar.await("SELECT `employees` FROM `spoody_gunstores` WHERE `storeid` = ?", {
            job.name
        })

        local payload = query and json.decode(query) or {}

        payload[name] = {
            identifier = identifier,
            name = name,
            grade = job.grade,
            label = job.grade_label
        }

        MySQL.update.await("UPDATE `spoody_gunstores` SET `employees` = ? WHERE `storeid` = ?", {
            json.encode(payload), job.name
        })
    end

    if old_store and previousJob.name ~= job.name then
        local query = MySQL.scalar.await("SELECT `employees` FROM `spoody_gunstores` WHERE `storeid` = ?", {
            previousJob.name
        })

        if query then
            local payload = json.decode(query)
            payload[name] = nil

            MySQL.update.await("UPDATE `spoody_gunstores` SET `employees` = ? WHERE `storeid` = ?", {
                json.encode(payload), previousJob.name
            })
        end
    end
end)