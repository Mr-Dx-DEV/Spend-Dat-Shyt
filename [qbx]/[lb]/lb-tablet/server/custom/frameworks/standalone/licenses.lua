if Config.Framework ~= "standalone" then
    return
end

---@type { type: string, label: string, pointsLimit: (number | false)? }[]
local licenses = {
    { type = "driver", label = "Driver's License" },
    { type = "weapon", label = "Weapon License" },
}

---@type { [string]: { label: string, type: string, pointsLimit: (number | false)? } }
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

---@param licenseType string
---@return string
function GetLicenseLabel(licenseType)
    return licenseLookup[licenseType]?.label or licenseType
end

---@param identifier string
---@param licenseType string
---@return boolean
function RevokeLicense(identifier, licenseType)
    if not DoesLicenseExist(licenseType) then
        return false
    end

    local label = GetLicenseLabel(licenseType)

    MySQL.update.await("DELETE FROM lbtablet_registration_licenses WHERE character_id = ? AND license IN (?, ?)", { identifier, licenseType, label })

    return true
end

---@param identifier string
---@param licenseType string
---@return boolean
function AddLicense(identifier, licenseType)
    if not DoesLicenseExist(licenseType) then
        return false
    end

    MySQL.update.await(
        "INSERT IGNORE INTO lbtablet_registration_licenses (character_id, license) VALUES (?, ?)",
        { identifier, GetLicenseLabel(licenseType) }
    )

    return true
end

---@return { label: string, type: string, pointsLimit?: number | false }[]
function GetAllLicenses()
    return licenses
end

local function GetLicenseFromLabel(label)
    for i = 1, #licenses do
        if licenses[i].label == label or licenses[i].type == label then
            return licenses[i]
        end
    end
end

---@param identifier string
---@return { type: string, label: string, points?: number, pointsLimit?: number }[]
function GetPlayerLicenses(identifier)
    local playerLicenses = MySQL.query.await("SELECT license FROM lbtablet_registration_licenses WHERE character_id = ?", { identifier })
    local formattedLicenses = {}

    for i = 1, #playerLicenses do
        local license = GetLicenseFromLabel(playerLicenses[i].license)

        if license then
            formattedLicenses[#formattedLicenses+1] = {
                type = license.type,
                label = license.label,
                points = license.pointsLimit and 0 or nil,
                pointsLimit = license.pointsLimit
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

    local playerLicenses = MySQL.query.await(
        "SELECT character_id, license FROM lbtablet_registration_licenses WHERE character_id IN (?)",
        { identifiers }
    )
    ---@type { [string]: { type: string, label: string, points?: number, pointsLimit?: number }[] }
    local identifierToLicense = {}

    for i = 1, #playerLicenses do
        local row = playerLicenses[i]
        local license = GetLicenseFromLabel(row.license)

        if license then
            local licensesForIdentifier = identifierToLicense[row.character_id] or {}

            identifierToLicense[row.character_id] = licensesForIdentifier
            licensesForIdentifier[#licensesForIdentifier+1] = {
                type = license.type,
                label = license.label,
                points = license.pointsLimit and 0 or nil,
                pointsLimit = license.pointsLimit
            }
        end
    end

    return identifierToLicense
end

---@param identifier string
---@param license string
---@param points number
---@return boolean
function SetPlayerLicensePoints(identifier, license, points)
    return DoesLicenseExist(license)
end
