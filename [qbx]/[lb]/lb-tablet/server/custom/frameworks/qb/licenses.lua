if Config.Framework ~= "qb" then
    return
end

while not QB do
    Wait(0)
end

---@type { type: string, label: string, pointsLimit?: number | false }[]
local licenses = {
    { label = "Driver's License", type = "driver" },
    { label = "Weapon License", type = "weapon" }
}

---@type { [string]: { label: string, type: string, pointsLimit?: number | false } }
local licenseLookup = {}

for i = 1, #licenses do
    local license = licenses[i]
    local maxPoints = Config.MDT.MaxLicensePoints[license.type]

    if maxPoints == nil then
        maxPoints = Config.MDT.DefaultMaxLicensePoints
    end

    license.pointsLimit = maxPoints
    licenseLookup[license.type] = license
end

---@param licenseType string
---@return boolean
local function DoesLicenseExist(licenseType)
    for i = 1, #licenses do
        if licenses[i].type == licenseType then
            return true
        end
    end

    return false
end

---@param identifier string
---@param licenseType string
---@return boolean
function RevokeLicense(identifier, licenseType)
    local qPlayer = QB.Functions.GetPlayerByCitizenId(identifier)

    if qPlayer then
        qPlayer.PlayerData.metadata.licences[licenseType] = false
        qPlayer.Functions.SetMetaData("licences", qPlayer.PlayerData.metadata.licences)

        return true
    end

    local metadata = MySQL.scalar.await("SELECT metadata FROM players WHERE citizenid = ?", { identifier })

    if not metadata then
        debugprint("RevokeLicense: no metadata")
        return false
    end

    metadata = json.decode(metadata)
    metadata.licences = metadata.licences or {}
    metadata.licences[licenseType] = false

    return MySQL.update.await("UPDATE players SET metadata = ? WHERE citizenid = ?", { json.encode(metadata), identifier }) > 0
end

---@param identifier string
---@param licenseType string
---@return boolean
function AddLicense(identifier, licenseType)
    if not DoesLicenseExist(licenseType) then
        return false
    end

    local qPlayer = QB.Functions.GetPlayerByCitizenId(identifier)

    if qPlayer then
        qPlayer.PlayerData.metadata.licences[licenseType] = true
        qPlayer.Functions.SetMetaData("licences", qPlayer.PlayerData.metadata.licences)
        return true
    end

    local metadata = MySQL.scalar.await("SELECT metadata FROM players WHERE citizenid = ?", { identifier })

    if not metadata then
        return false
    end

    metadata = json.decode(metadata)
    metadata.licences = metadata.licences or {}
    metadata.licences[licenseType] = true

    return MySQL.update.await("UPDATE players SET metadata = ? WHERE citizenid = ?", { json.encode(metadata), identifier }) > 0
end

---@param licenseType string
---@return string
function GetLicenseLabel(licenseType)
    return licenseLookup[licenseType]?.label or licenseType
end

---@return { label: string, type: string, pointsLimit?: number | false }[]
function GetAllLicenses()
    return licenses
end

---@param identifier string
---@return { type: string, label: string, points?: number, pointsLimit?: number }[]
function GetPlayerLicenses(identifier)
    local qPlayer = QB.Functions.GetPlayerByCitizenId(identifier)
    local formattedLicenses = {}
    ---@type { [string]: any }?
    local metadata

    if qPlayer then
        metadata = qPlayer.PlayerData.metadata
    else
        local encodedMetadata = MySQL.scalar.await("SELECT metadata FROM players WHERE citizenid = ?", { identifier })

        if not encodedMetadata then
            return formattedLicenses
        end

        metadata = json.decode(encodedMetadata)
    end

    if not metadata.licences then
        return formattedLicenses
    end

    for licenseType, hasLicense in pairs(metadata.licences) do
        if hasLicense then
            local licenseData = licenseLookup[licenseType]

            formattedLicenses[#formattedLicenses+1] = {
                type = licenseType,
                label = licenseData?.label or licenseType,
                points = metadata[licenseType .. "_points"] or (licenseData?.pointsLimit and 0 or nil),
                pointsLimit = licenseData?.pointsLimit
            }
        end
    end

    return formattedLicenses
end

---@param identifiers string[]
---@return { [string]: { type: string, label: string, points?: number, pointsLimit?: number }[] }
function GetMultiplePlayersLicenses(identifiers)
    if #identifiers == 0 then
        return {}
    end

    ---@type { [string]: { type: string, label: string, points?: number, pointsLimit?: number }[] }
    local identifierToLicense = {}
    ---@type string[]
    local identifiersToFetch = {}
    ---@type { [string]: { [string]: any }? }
    local identifierToMetadata = {}

    for i = 1, #identifiers do
        local identifier = identifiers[i]
        local qPlayer = QB.Functions.GetPlayerByCitizenId(identifier)

        if qPlayer then
            identifierToMetadata[identifier] = qPlayer.PlayerData.metadata
        else
            identifiersToFetch[#identifiersToFetch+1] = identifier
        end
    end

    if #identifiersToFetch > 0 then
        ---@type { citizenid: string, metadata: string }[]
        local encodedMetadata = MySQL.query.await(
            "SELECT citizenid, metadata FROM players WHERE citizenid IN (?)",
            { identifiersToFetch }
        )

        for i = 1, #encodedMetadata do
            local row = encodedMetadata[i]

            identifierToMetadata[row.citizenid] = json.decode(row.metadata)
        end
    end

    for identifier, metadata in pairs(identifierToMetadata) do
        local playerLicenses = {}

        if not metadata.licences then
            goto continue
        end

        for licenseType, hasLicense in pairs(metadata.licences) do
            if hasLicense then
                local licenseData = licenseLookup[licenseType]

                playerLicenses[#playerLicenses+1] = {
                    type = licenseType,
                    label = licenseData?.label or licenseType,
                    points = metadata[licenseType .. "_points"] or (licenseData?.pointsLimit and 0 or nil),
                    pointsLimit = licenseData?.pointsLimit
                }
            end
        end

        identifierToLicense[identifier] = playerLicenses
        ::continue::
    end

    return identifierToLicense
end

---@param identifier string
---@param license string
---@param points number
---@return boolean
function SetPlayerLicensePoints(identifier, license, points)
    local qPlayer = QB.Functions.GetPlayerByCitizenId(identifier)
    local metadataKey = license .. "_points"

    if qPlayer then
        qPlayer.Functions.SetMetaData(metadataKey, points)

        return true
    end

    local encodedMetadata = MySQL.scalar.await("SELECT metadata FROM players WHERE citizenid = ?", { identifier })

    if not encodedMetadata then
        return false
    end

    local metadata = json.decode(encodedMetadata)

    metadata[metadataKey] = points

    return MySQL.update.await("UPDATE players SET metadata = ? WHERE citizenid = ?", { json.encode(metadata), identifier }) > 0
end
