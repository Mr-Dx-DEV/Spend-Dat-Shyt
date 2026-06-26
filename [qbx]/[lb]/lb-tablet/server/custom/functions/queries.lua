---@param check MDTProfileEntityFieldsCheck
---@param value any
---@param params any[]
---@param where string[]
---@param mdt string
local function GenerateCheckQuery(check, value, params, where, mdt)
    if check.tabType == "reports" then
        if check.id and check.type == "field" and check.field and check.value then
            local checkWhere = {}

            params[#params+1] = check.field
            params[#params+1] = check.value
            params[#params+1] = mdt
            params[#params+1] = check.id

            if check.involvement then
                checkWhere[#checkWhere+1] = "involved.involvement = ?"
                params[#params+1] = check.involvement
            end

            where[#where+1] = FormatString([[
                {EXISTS} EXISTS (
                    SELECT 1
                    FROM lbtablet_mdt_reports_involved involved

                    INNER JOIN lbtablet_mdt_reports report
                        ON report.id = involved.report_id

                    INNER JOIN lbtablet_mdt_reports_fields report_field
                        ON report_field.report_id = report.id
                        AND report_field.field_id = ?
                        AND report_field.field_value = ?

                    WHERE
                        involved.involved = {IDENTIFIER}
                        AND involved.department = ?
                        AND report.tab_id = ?
                        AND involved.profile_type = 'player'
                        {WHERE}
                )
            ]], {
                EXISTS = not value and "NOT" or "",
                IDENTIFIER = Queries.Users.Select.identifier,
                WHERE = #checkWhere > 0 and "AND " .. table.concat(checkWhere, " AND ") or ""
            })
        end
    end
end

---@class UserSearchFilter
---@field search? string
---@field jobs? string[]
---@field excludeJailed? boolean
---@field tags? number[]
---@field licenses? string[]
---@field gender? "f" | "m"
---@field entityFields? { [string]: any }

---@param filter UserSearchFilter
---@param mdt string
---@param profileTab? MDTUsersTab
---@param page? number
---@return table[]
function SearchUsers(filter, mdt, profileTab, page)
    ---@type any[]
    local params = {}
    ---@type string[]
    local join = {}
    ---@type string[]
    local where = {}
    ---@type string[]
    local select = {
        Queries.Users.Select.identifier .. " AS id",
        Queries.Users.Select.name .. " AS `name`",
        Queries.Users.Select.dob .. " AS dob",
        Queries.Users.Select.isMale .. " AS isMale"
    }

    page = page or 0

    if mdt then
        select[#select+1] = "profile.avatar"
        select[#select+1] = "profile.id AS profileId"
        join[#join+1] = "LEFT JOIN lbtablet_mdt_profiles profile ON profile.profile_id = {IDENTIFIER} {USERS_COLLATE} AND profile.profile_type = 'player' AND profile.department = ?"
        params[#params+1] = mdt
    end

    local search = filter and filter.search or nil

    if search and #search > 0 then
        local wildcardSearch = "%" .. search .. "%"

        if IsStringOnlyNumbers(search) and Config.LBPhone then
            local phoneConfig = GetPhoneConfig()

            if phoneConfig?.Item.Unique then
                where[#where+1] = "phone.phone_number LIKE ?"
                join[#join+1] = "LEFT JOIN phone_last_phone phone ON {IDENTIFIER} {USERS_COLLATE} = phone.id"
            else
                where[#where+1] = "phone.phone_number LIKE ?"
                join[#join+1] = "LEFT JOIN phone_phones phone ON {IDENTIFIER} {USERS_COLLATE} = phone.id"
            end

            params[#params+1] = wildcardSearch
        end

        where[#where+1] = FormatString([[
            (
                {NAME} LIKE ?
                OR {DOB} LIKE ?
                {FINGERPRINT}
            )
        ]], {
            NAME = Queries.Users.Select.name,
            DOB = Queries.Users.Select.dob,
            FINGERPRINT = Queries.Users.Select.fingerprint and "OR " .. Queries.Users.Select.fingerprint .. " LIKE ?" or ""
        })

        if Queries.Users.Select.fingerprint then
            params[#params+1] = wildcardSearch
        end

        params[#params+1] = wildcardSearch
        params[#params+1] = wildcardSearch
    end

    if filter then
        if filter.jobs then
            where[#where+1] = Queries.Users.Filter.Jobs
            params[#params+1] = filter.jobs
        end

        if filter.tags then
            for i = 1, #filter.tags do
                where[#where+1] = "EXISTS (SELECT 1 FROM lbtablet_mdt_applied_tags applied_tag WHERE applied_tag.applied_id = profile.id AND applied_tag.tag_id = ?)"
                params[#params+1] = filter.tags[i]
            end
        end

        if filter.excludeJailed then
            where[#where+1] = Queries.Users.Filter.ExcludeJailed
        end

        if filter.gender then
            where[#where+1] = Queries.Users.Filter.Gender
            params[#params+1] = filter.gender
        end

        if filter.licenses then
            for i = 1, #filter.licenses do
                where[#where+1] = Queries.Users.Filter.License
                params[#params+1] = filter.licenses[i]
            end
        end

        if filter.entityFields then
            ---@type MDTUsersEntityFieldField[]
            local entityFields = profileTab and (GetFieldByType(profileTab, "entity") or {}).entityFields or {}

            for fieldId, value in pairs(filter.entityFields) do
                ---@type MDTProfileEntityFieldsCheck
                local check

                for i = 1, #entityFields do
                    local entityField = entityFields[i]

                    if entityField.id == fieldId and entityField.check then
                        check = entityField.check
                        break
                    end
                end

                if check then
                    GenerateCheckQuery(check, value, params, where, mdt)
                end
            end
        end
    end

    local searchQuery = [[
        SELECT
            {SELECT}
        FROM {USERS_TABLE} user
        {JOIN}
        {WHERE}
        LIMIT ?, ?
    ]]

    searchQuery = searchQuery
        :gsub("{SELECT}", table.concat(select, ",\n    "))
        :gsub("{USERS_TABLE}", Queries.Users.Table)
        :gsub("{JOIN}", table.concat(join, "\n"))
        :gsub("{WHERE}", #where > 0 and "WHERE " .. table.concat(where, " AND ") or "")
        :gsub("{IDENTIFIER}", Queries.Users.Select.identifier)
        :gsub("{USERS_COLLATE}", UsersCollate)

    params[#params+1] = (page or 0) * 10
    params[#params+1] = 10

    return MySQL.query.await(searchQuery, params)
end

---@class VehicleSearchFilter
---@field search? string
---@field warrant? boolean
---@field tags? number[]

---@param filter? VehicleSearchFilter
---@param mdt? string
---@param page? number
---@return table[]
function SearchVehicles(filter, mdt, page)
    filter = filter or {}

    ---@type any[]
    local params = {}
    ---@type string[]
    local join = {}
    ---@type string[]
    local where = {}
    ---@type string[]
    local select = {
        Queries.Users.Select.name .. " AS `name`",
    }

    for name, value in pairs(Queries.Vehicles.Select) do
        select[#select+1] = value .. " AS " .. name
    end

    join[#join+1] = FormatString(
        "LEFT JOIN {USERS_TABLE} user ON {IDENTIFIER_COLUMN} {USERS_COLLATE} = {OWNER} {VEHICLES_COLLATE}",
        {
            USERS_TABLE = Queries.Users.Table,
            IDENTIFIER_COLUMN = Queries.Users.Select.identifier,
            USERS_COLLATE = UsersCollate,
            OWNER = Queries.Vehicles.Select.owner,
            VEHICLES_COLLATE = VehiclesCollate
        }
    )

    if mdt then
        select[#select+1] = "profile.avatar"
        select[#select+1] = "profile.id AS profileId"
        join[#join+1] = "LEFT JOIN lbtablet_mdt_profiles profile ON profile.profile_id = {PLATE} {VEHICLES_COLLATE} AND profile.profile_type = 'vehicle' AND profile.department = ?"
        params[#params+1] = mdt
    end

    if filter.search and #filter.search > 0 then
        where[#where+1] = "{PLATE} LIKE ?"
        params[#params+1] = "%" .. filter.search .. "%"
    end

    if filter.tags then
        for i = 1, #filter.tags do
            where[#where+1] = "EXISTS (SELECT 1 FROM lbtablet_mdt_applied_tags applied_tag WHERE applied_tag.applied_id = profile.id AND applied_tag.tag_id = ?)"
            params[#params+1] = filter.tags[i]
        end
    end

    -- TODO: add warrant filter

    local searchQuery = "SELECT\n    {SELECT}\nFROM {VEHICLES_TABLE} vehicle\n{JOIN}\n{WHERE}\nLIMIT ?, ?"

    searchQuery = searchQuery
        :gsub("{SELECT}", table.concat(select, ",\n    "))
        :gsub("{VEHICLES_TABLE}", Queries.Vehicles.Table)
        :gsub("{JOIN}", table.concat(join, "\n"))
        :gsub("{WHERE}", #where > 0 and "WHERE " .. table.concat(where, " AND ") or "")
        :gsub("{PLATE}", Queries.Vehicles.Select.plate)
        :gsub("{VEHICLES_COLLATE}", VehiclesCollate)

    params[#params+1] = (page or 0) * 10
    params[#params+1] = 10

    return MySQL.query.await(searchQuery, params)
end

---@param plate string
---@param mdt? string
---@return table?
function FetchVehicle(plate, mdt)
    ---@type any[]
    local params = {}
    ---@type string[]
    local join = {}
    ---@type string[]
    local where = {}
    ---@type string[]
    local select = {
        Queries.Users.Select.name .. " AS `name`",
    }

    for name, value in pairs(Queries.Vehicles.Select) do
        select[#select+1] = value .. " AS `" .. name .. "`"
    end

    if mdt then
        select[#select+1] = "profile.avatar"
        select[#select+1] = "profile.id AS profileId"
        join[#join+1] = "LEFT JOIN lbtablet_mdt_profiles profile ON profile.profile_id = {PLATE} {VEHICLES_COLLATE} AND profile.profile_type = 'vehicle' AND profile.department = ?"
        params[#params+1] = mdt
    end

    join[#join+1] = FormatString(
        "LEFT JOIN {USERS_TABLE} user ON {IDENTIFIER_COLUMN} {USERS_COLLATE} = {OWNER} {VEHICLES_COLLATE}",
        {
            USERS_TABLE = Queries.Users.Table,
            IDENTIFIER_COLUMN = Queries.Users.Select.identifier,
            USERS_COLLATE = UsersCollate,
            OWNER = Queries.Vehicles.Select.owner,
            VEHICLES_COLLATE = VehiclesCollate
        }
    )

    where[#where+1] = "{PLATE} = ?"
    params[#params+1] = plate

    local fetchQuery = "SELECT\n    {SELECT}\nFROM {VEHICLES_TABLE} vehicle\n{JOIN}\n{WHERE}"

    fetchQuery = fetchQuery
        :gsub("{SELECT}", table.concat(select, ",\n    "))
        :gsub("{VEHICLES_TABLE}", Queries.Vehicles.Table)
        :gsub("{JOIN}", table.concat(join, "\n"))
        :gsub("{WHERE}", #where > 0 and "WHERE " .. table.concat(where, " AND ") or "")
        :gsub("{PLATE}", Queries.Vehicles.Select.plate)
        :gsub("{VEHICLES_COLLATE}", VehiclesCollate)

    return MySQL.single.await(fetchQuery, params)
end
