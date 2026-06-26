if Config.HousingScript ~= "rtx_housing" then
    return
end

local resourceName = "rtx_housing"

while GetResourceState(resourceName) ~= "started" do
    debugprint("Waiting for rtx_housing to start...")
    Wait(1000)
end

local selectPropertyQuery = [[
    SELECT
        h.owneridentifier AS owner,
        h.houseid AS propertyid,
        h.ownername AS owner_name,
        property_profile.id AS profile_id,
        property_profile.avatar
    FROM houses h
    LEFT JOIN lbtablet_mdt_profiles property_profile
        ON property_profile.profile_id = CONCAT('owner:', h.owneridentifier, ',id:', h.houseid)
        AND property_profile.department = ?
        AND property_profile.profile_type = 'property'
]]

local function EncodePropertyId(owner, id)
    return "owner:" .. tostring(owner) .. ",id:" .. tostring(id)
end

---@param id string
---@return string?, number?
local function DecodePropertyId(id)
    local owner, propertyId = string.match(id, "owner:(.+),id:([^,]+)$")
    return owner, propertyId and tonumber(propertyId)
end

local function FormatProperty(property)
    local propertyData =  exports["rtx_housing"]:GetPropertyData(property.propertyid)

    property.label = (propertyData and propertyData.propertyname) or tostring(property.propertyid)
    property.id = EncodePropertyId(property.owner, property.propertyid)

    property.owner = {
        name = property.owner_name or (propertyData and propertyData.ownername) or "Unknown",
        identifier = property.owner
    }

    property.owner_name = nil

    if propertyData then
        local housecoords = propertyData.enter and propertyData.enter.coords

        if propertyData.partofcomplex and propertyData.partofcomplex.enabled == true then
            local complexData =  exports["rtx_housing"]:GetPropertyData(propertyData.partofcomplex.complexid)
            if complexData and complexData.enter and complexData.enter.coords then
                housecoords = complexData.enter.coords
            end
        end

        if housecoords then
            property.location = {
                x = housecoords.x,
                y = housecoords.y,
            }
        end
    end

    property.propertyid = nil

    return property
end

---@param id string
---@return string?
function GetPropertyLabel(id)
    local _, propertyId = DecodePropertyId(id)

    if not propertyId then
        debugprint("Failed to decode property id", id)
        return
    end

    local propertyData =  exports["rtx_housing"]:GetPropertyData(propertyId)
    return (propertyData and propertyData.propertyname) or tostring(propertyId)
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

    filter = filter or {}

    if filter.tags and #filter.tags > 0 then
        for i = 1, #filter.tags do
            where[#where + 1] = [[
                EXISTS (
                    SELECT 1
                    FROM lbtablet_mdt_applied_tags
                    WHERE tag_id = ?
                    AND applied_id = property_profile.id
                    AND applied_type = 'property'
                )
            ]]
            params[#params + 1] = filter.tags[i]
        end
    end

    if search and search ~= "" then
        where[#where + 1] = [[
            (
                CAST(h.houseid AS CHAR) LIKE ?
                OR h.ownername LIKE ?
            )
        ]]

        local searchParam = "%" .. search .. "%"
        params[#params + 1] = searchParam
        params[#params + 1] = searchParam
    end

    params[#params + 1] = (page or 0) * 10
    params[#params + 1] = 10

    local searchQuery = ([[
        %s
        %s
        LIMIT ?, ?
    ]]):format(
        selectPropertyQuery,
        #where > 0 and ("WHERE " .. table.concat(where, " AND ")) or ""
    )

    local properties = MySQL.query.await(searchQuery, params) or {}

    for i = 1, #properties do
        properties[i] = FormatProperty(properties[i])
    end

    return properties
end

---@param mdt string
---@param id string
function GetProperty(mdt, id)
    local owner, propertyId = DecodePropertyId(id)

    if not propertyId then
        debugprint("Failed to decode property id", id)
        return
    end

    local property

    if owner and owner ~= "" then
        property = MySQL.single.await(
            selectPropertyQuery .. " WHERE h.owneridentifier = ? AND h.houseid = ?",
            { mdt, owner, propertyId }
        )
    else
        property = MySQL.single.await(
            selectPropertyQuery .. " WHERE h.houseid = ?",
            { mdt, propertyId }
        )
    end

    if not property then
        return
    end

    return FormatProperty(property)
end

---@param identifier string
---@return { id: string, label: string }[]
function GetPlayerProperties(identifier)
    local ownedProperties =  exports["rtx_housing"]:GetPlayerOwnedProperties(identifier)
    local formattedProperties = {}

    local index = 0
    for _, propertyData in pairs(ownedProperties or {}) do
        index = index + 1
        formattedProperties[index] = {
            id = EncodePropertyId(propertyData.owner or identifier, propertyData.houseid),
            label = propertyData.propertyname or tostring(propertyData.houseid)
        }
    end

    return formattedProperties
end
