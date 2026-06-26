if Config.HousingScript ~= "loaf_housing" then
    return
end

local resourceName = "loaf_housing"

while GetResourceState(resourceName) ~= "started" do
    debugprint("Waiting for loaf_housing to start...")
    Wait(1000)
end

while not Queries do
    debugprint("Waiting for framework queries to load...")
    Wait(1000)
end

local selectPropertyQuery = FormatString([[
    SELECT
        property.owner,
        property.propertyid,
        {SELECT_NAME} AS owner_name,
        property_profile.id AS profile_id,
        property_profile.avatar

    FROM loaf_properties property

    LEFT JOIN {USER_TABLE} user
        ON {USER_IDENTIFIER} = property.owner

    LEFT JOIN lbtablet_mdt_profiles property_profile
        ON property_profile.profile_id = CONCAT('owner:', property.owner, ',id:', property.propertyid)
        AND property_profile.department = ?
        AND property_profile.profile_type = 'property'
]], {
    SELECT_NAME = Queries.Users.Select.name,
    USER_TABLE = Queries.Users.Table,
    USER_IDENTIFIER = Queries.Users.Select.identifier
})

local loaf = exports[resourceName]

local function EncodePropertyId(owner, id)
    return "owner:" .. owner .. ",id:" .. id
end

---@param id string
---@return string, number?
local function DecodePropertyId(id)
    local owner, propertyId = string.match(id, "owner:(.+),id:([^,]+)$")

    return owner, propertyId and tonumber(propertyId)
end

local function FormatProperty(property)
    local propertyData = loaf:GetHouse(property.propertyid)

    property.label = propertyData?.label or property.propertyid
    property.id = EncodePropertyId(property.owner, property.propertyid)

    property.owner = {
        name = property.owner_name,
        identifier = property.owner
    }

    property.owner_name = nil
    property.propertyid = nil

    if propertyData?.entrance then
        property.location = {
            x = propertyData.entrance.x,
            y = propertyData.entrance.y,
        }
    end

    return property
end

---@param id string
---@return string?
function GetPropertyLabel(id)
    local owner, propertyId = DecodePropertyId(id)

    if not owner or not propertyId then
        debugprint("Failed to decode property id", id)
        return
    end

    local propertyData = loaf:GetHouse(propertyId)

    return propertyData?.label or tostring(propertyId)
end

---@param mdt string
---@param search? string
---@param page? number
---@param filter { tags?: number[] }
---@return table[]
function SearchProperties(mdt, search, page, filter)
    ---@type any[]
    local params = { mdt }
    local where = {}

    if filter.tags then
        for i = 1, #filter.tags do
            where[#where+1] = "EXISTS (SELECT 1 FROM lbtablet_mdt_applied_tags WHERE tag_id = ? AND applied_id = property_profile.id AND applied_type = 'property')"
            params[#params+1] = filter.tags[i]
        end
    end

    if search then
        where[#where+1] = FormatString(
            "(property.propertyid LIKE ? OR property.id LIKE ? OR {NAME} LIKE ?)",
            { NAME = Queries.Users.Select.name }
        )

        local searchParam = "%" .. search .. "%"

        params[#params+1] = searchParam
        params[#params+1] = searchParam
        params[#params+1] = searchParam
    end

    params[#params+1] = (page or 0) * 10
    params[#params+1] = 10

    local searchQuery = FormatString([[
        {SELECT_PROPERTY}
        {WHERE_FILTER}
        LIMIT ?, ?
    ]], {
        SELECT_PROPERTY = selectPropertyQuery,
        WHERE_FILTER = #where > 0 and ("WHERE " .. table.concat(where, " AND ")) or "",
    })

    local properties = MySQL.query.await(searchQuery, params)

    for i = 1, #properties do
        properties[i] = FormatProperty(properties[i])
    end

    return properties
end

---@param mdt string
---@param id string
function GetProperty(mdt, id)
    local owner, propertyId = DecodePropertyId(id)

    if not owner or not propertyId then
        debugprint("Failed to decode property id", id)
        return
    end

    local selectQuery = selectPropertyQuery .. " WHERE property.owner = ? AND property.propertyid = ?"
    local property = MySQL.single.await(selectQuery, { mdt, owner, propertyId })

    if not property then
        return
    end

    return FormatProperty(property)
end

---@param identifier string
---@return { id: string, label: string }[]
function GetPlayerProperties(identifier)
    local ownedProperties = MySQL.query.await([[
        SELECT
            propertyid AS id

        FROM loaf_properties
        WHERE owner = ?
    ]], { identifier })

    for i = 1, #ownedProperties do
        local property = ownedProperties[i]
        local propertyData = loaf:GetHouse(property.id)

        ownedProperties[i] = {
            id = EncodePropertyId(identifier, property.id),
            label = propertyData?.label or property.id
        }
    end

    return ownedProperties
end
