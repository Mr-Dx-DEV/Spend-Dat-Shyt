if Config.Framework ~= "esx" then
    return
end

while not ESX do
    Wait(500)
end

---@type { label: string, type: string, pointsLimit?: number | false }[]
local licenses
---@type { [string]: { label: string, type: string, pointsLimit?: number | false } }
local licenseLookup = {}

MySQL.ready(function()
    licenses = MySQL.query.await("SELECT `type`, label FROM licenses")

    for i = 1, #licenses do
        local license = licenses[i]
        local maxPoints = Config.MDT.MaxLicensePoints[license.type]

        if maxPoints == nil then
            maxPoints = Config.MDT.DefaultMaxLicensePoints
        end

        license.pointsLimit = maxPoints
        licenseLookup[license.type] = license
    end
end)

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
    if not DoesLicenseExist(licenseType) then
        return false
    end

    return MySQL.update.await("DELETE FROM user_licenses WHERE owner = ? AND `type` = ?", { identifier, licenseType }) > 0
end

---@param identifier string
---@param licenseType string
---@return boolean
function AddLicense(identifier, licenseType)
    if not DoesLicenseExist(licenseType) then
        return false
    end

    return MySQL.update.await("INSERT INTO user_licenses (owner, `type`) VALUES (?, ?)", { identifier, licenseType }) > 0
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
    local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
    local playerLicenses = MySQL.query.await("SELECT `type` FROM user_licenses WHERE owner = ?", { identifier })
    ---@type { [string]: any }?
    local metadata = xPlayer?.metadata

    if not xPlayer then
        local encodedMetadata = MySQL.scalar.await("SELECT metadata FROM users WHERE identifier = ?", { identifier })

        if encodedMetadata then
            metadata = json.decode(encodedMetadata)
        end
    end

    for i = 1, #playerLicenses do
        local license = playerLicenses[i]
        local licenseData = licenseLookup[license.type]

        license.label = licenseData?.label or license.type
        license.points = metadata and metadata[license.type .. "_points"] or (licenseData?.pointsLimit and 0 or nil)
        license.pointsLimit = licenseData.pointsLimit
    end

    return playerLicenses
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
        local xPlayer = ESX.GetPlayerFromIdentifier(identifier)

        if xPlayer then
            identifierToMetadata[identifier] = xPlayer.metadata
        else
            identifiersToFetch[#identifiersToFetch+1] = identifier
        end
    end

    if #identifiersToFetch > 0 then
        ---@type { identifier: string, metadata: string }[]
        local encodedMetadata = MySQL.query.await(
            "SELECT identifier, metadata FROM users WHERE identifier IN (?)",
            { identifiersToFetch }
        )

        for i = 1, #encodedMetadata do
            local row = encodedMetadata[i]

            identifierToMetadata[row.identifier] = json.decode(row.metadata)
        end
    end

    ---@type { owner: string, type: string }[]
    local playerLicenses = MySQL.query.await(
        "SELECT owner, `type` FROM user_licenses WHERE owner IN (?)",
        { identifiers }
    )

    for i = 1, #playerLicenses do
        local row = playerLicenses[i]
        local metadata = identifierToMetadata[row.owner]
        local licenseData = licenseLookup[row.type]

        identifierToLicense[row.owner] = identifierToLicense[row.owner] or {}

        table.insert(identifierToLicense[row.owner], {
            type = row.type,
            label = licenseData?.label or row.type,
            points = metadata and metadata[row.type .. "_points"] or (licenseData?.pointsLimit and 0 or nil),
            pointsLimit = licenseData?.pointsLimit
        })
    end

    return identifierToLicense
end

---@param identifier string
---@param license string
---@param points number
---@return boolean
function SetPlayerLicensePoints(identifier, license, points)
    local metadataKey = license .. "_points"
    local xPlayer = ESX.GetPlayerFromIdentifier(identifier)

    if xPlayer then
        xPlayer.setMeta(metadataKey, points)

        return true
    end

    local encodedMetadata = MySQL.scalar.await("SELECT metadata FROM users WHERE identifier = ?", { identifier })

    if not encodedMetadata then
        return false
    end

    local metadata = json.decode(encodedMetadata)

    metadata[metadataKey] = points

    return MySQL.update.await("UPDATE users SET metadata = ? WHERE identifier = ?", { json.encode(metadata), identifier }) > 0
end
