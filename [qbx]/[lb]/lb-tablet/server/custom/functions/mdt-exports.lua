local tablet = exports["lb-tablet"]

local tagTypes = {
    profile = "users",
    vehicle = "vehicles",
    property = "property",
    weapon = "weapons",
    report = "reports",
    warrant = "warrants",
    incident = "cases"
}

---@param exportName string
---@param cb fun(...): ...
local function RegisterLegacyExport(exportName, cb, newExport)
    exports(exportName, function(...)
        local resource = GetInvokingResource() or "??"

        infoprint(
            "warning",
            FormatString("^5{resource}^7 called the export ^5{exportName}^7 which is deprecated and may be removed in a future update. Switch to the equivalent ^5lb-tablet^7 MDT export.", {
                resource = resource,
                exportName = exportName
            })
        )

        return cb(...)
    end)
end

-- Ambulance

RegisterLegacyExport("GetAmbulanceCallsign", function(identifier)
    return tablet:GetMDTCallsign("Ambulance", identifier)
end)

RegisterLegacyExport("SetAmbulanceCallsign", function(identifier, callsign, ignoreCheck)
    return tablet:SetMDTCallsign("Ambulance", identifier, callsign, ignoreCheck)
end)

RegisterLegacyExport("GetAmbulanceAvatar", function(identifier)
    return tablet:GetMDTAvatar("Ambulance", identifier)
end)

RegisterLegacyExport("CreateAmbulanceTag", function(title, color, tagType)
    local newTagType = tagTypes[tagType] or tagType

    return tablet:CreateMDTTag("Ambulance", title, color, newTagType)
end)

RegisterLegacyExport("DeleteAmbulanceTag", function(tagId)
    return tablet:DeleteMDTTag("Ambulance", tagId)
end)

RegisterLegacyExport("AddTagToAmbulanceProfile", function(identifier, tagId)
    local tag = GetTag("Ambulance", tagId)

    if not tag or tag.type ~= "profile" then
        debugprint("Invalid tag or tag type", tagId, tag)
        return false
    end

    local profileId = MySQL.scalar.await(
        "SELECT id FROM lbtablet_mdt_profiles WHERE profile_id = ? AND department = ?",
        { identifier, "Ambulance" }
    )

    if not profileId then
        debugprint("Profile not found for identifier", identifier)
        return false
    end

    MySQL.update.await(
        "INSERT INTO lbtablet_mdt_applied_tags (tag_id, applied_id, applied_type) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE tag_id = VALUES(tag_id)",
        { tagId, profileId, "profile" }
    )

    return true
end)

RegisterLegacyExport("RemoveTagFromAmbulanceProfile", function(identifier, tagId)
    local tag = GetTag("Ambulance", tagId)

    if not tag or tag.type ~= "profile" then
        debugprint("Invalid tag or tag type", tagId, tag)
        return false
    end

    local profileId = MySQL.scalar.await(
        "SELECT id FROM lbtablet_mdt_profiles WHERE profile_id = ? AND department = ?",
        { identifier, "Ambulance" }
    )

    if not profileId then
        debugprint("Profile not found for identifier", identifier)
        return false
    end

    return MySQL.update.await(
        "DELETE FROM lbtablet_mdt_applied_tags WHERE tag_id = ? AND applied_id = ? AND applied_type = ?",
        { tagId, profileId, "profile" }
    ) > 0
end)

-- Police

RegisterLegacyExport("GetPoliceCallsign", function(identifier)
    return tablet:GetMDTCallsign("Police", identifier)
end)

RegisterLegacyExport("SetPoliceCallsign", function(identifier, callsign, ignoreCheck)
    return tablet:SetMDTCallsign("Police", identifier, callsign, ignoreCheck)
end)

RegisterLegacyExport("GetPoliceAvatar", function(identifier)
    return tablet:GetMDTAvatar("Police", identifier)
end)

RegisterLegacyExport("CreatePoliceTag", function(title, color, tagType)
    local newTagType = tagTypes[tagType] or tagType

    return tablet:CreateMDTTag("Police", title, color, newTagType)
end)

RegisterLegacyExport("DeletePoliceTag", function(tagId)
    return tablet:DeleteMDTTag("Police", tagId)
end)

RegisterLegacyExport("AddTagToPoliceProfile", function(identifier, tagId)
    local tag = GetTag("Police", tagId)

    if not tag then
        debugprint("Invalid tag id", tagId)
        return false
    end

    local profileId = MySQL.scalar.await(
        "SELECT id FROM lbtablet_mdt_profiles WHERE profile_id = ? AND department = ?",
        { identifier, "Police" }
    )

    if not profileId then
        debugprint("Profile not found for identifier", identifier)
        return false
    end

    MySQL.update.await(
        "INSERT INTO lbtablet_mdt_applied_tags (tag_id, applied_id, applied_type) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE tag_id = VALUES(tag_id)",
        { tagId, profileId, tag.type }
    )

    return true
end)

RegisterLegacyExport("RemoveTagFromPoliceProfile", function(identifier, tagId)
    local tag = GetTag("Police", tagId)

    if not tag then
        debugprint("Invalid tag id", tagId)
        return false
    end

    local profileId = MySQL.scalar.await(
        "SELECT id FROM lbtablet_mdt_profiles WHERE profile_id = ? AND department = ?",
        { identifier, "Police" }
    )

    if not profileId then
        debugprint("Profile not found for identifier", identifier)
        return false
    end

    return MySQL.update.await(
        "DELETE FROM lbtablet_mdt_applied_tags WHERE tag_id = ? AND applied_id = ? AND applied_type = ?",
        { tagId, profileId, tag.type }
    ) > 0
end)

RegisterLegacyExport("RegisterWeapon", function(serialNumber, data)
    return RegisterWeapon("Police", serialNumber, data)
end)

RegisterLegacyExport("LogJailed", function(prisoner, jailedBy, reason, jailTime, relatedCase)
    return LogJailed("Police", prisoner, jailedBy, reason, jailTime, relatedCase)
end)

-- Helper functions for legacy report / warrant / case exports

---@param source number | string
---@return string?
local function GetCreatorId(source)
    if type(source) == "number" then
        return GetEquippedTablet(source)
    end
    return tostring(source)
end

---Returns the tag IDs to add and remove when replacing a report's tags with `newTags`.
---@param reportId number
---@param tabId string Applied type used when tags were stored (e.g. "reports", "cases", "warrants")
---@param newTags? number[]
---@return number[] added, number[] removed
local function GetReportTagDiff(reportId, tabId, newTags)
    newTags = newTags or {}

    local currentTagRows = MySQL.query.await(
        "SELECT tag_id FROM lbtablet_mdt_applied_tags WHERE applied_id = ? AND applied_type = ?",
        { reportId, tabId }
    )

    local currentSet = {}
    for i = 1, #currentTagRows do
        currentSet[currentTagRows[i].tag_id] = true
    end

    local newSet = {}
    for i = 1, #newTags do
        newSet[newTags[i]] = true
    end

    local added, removed = {}, {}

    for i = 1, #newTags do
        if not currentSet[newTags[i]] then
            added[#added+1] = newTags[i]
        end
    end

    for tagId in pairs(currentSet) do
        if not newSet[tagId] then
            removed[#removed+1] = tagId
        end
    end

    return added, removed
end

---Returns new-but-not-current entries as `added` and current-but-not-new as `removed`
---for a single involved field, so callers can pass the result directly to InsertInvolved.
---@param reportId number
---@param fieldId string
---@param newList? (string | { id: string })[]
---@return any[] added, string[] removed
local function GetInvolvedDiff(reportId, fieldId, newList)
    newList = newList or {}

    local currentRows = MySQL.query.await(
        "SELECT involved FROM lbtablet_mdt_reports_involved WHERE report_id = ? AND involvement = ?",
        { reportId, fieldId }
    )

    local currentSet = {}

    for i = 1, #currentRows do
        currentSet[currentRows[i].involved] = true
    end

    local newSet = {}

    for i = 1, #newList do
        local id = type(newList[i]) == "table" and newList[i].id or newList[i]

        newSet[id] = true
    end

    local added, removed = {}, {}

    for i = 1, #newList do
        local item = newList[i]
        local id = type(item) == "table" and item.id or item

        if not currentSet[id] then
            added[#added+1] = item
        end
    end

    for id in pairs(currentSet) do
        if not newSet[id] then
            removed[#removed+1] = id
        end
    end

    return added, removed
end

-- Mappers: new MDT GetReport result → old structure

--- Old ambulance/police report `gallery` field was an array of row objects:
--- { { attachment = "url" } }. The new system returns plain URL strings.
---@param urls? string[]
---@return { attachment: string }[]
local function MapGalleryToObjects(urls)
    if not urls then
        return {}
    end

    local out = {}

    for i = 1, #urls do
        out[i] = { attachment = urls[i] }
    end

    return out
end

--- Old linked-reports arrays used `label` instead of `title`.
---@param items? { id: number, title: string }[]
---@return { id: number, label: string }[]
local function MapLinkedToLabel(items)
    if not items then
        return {}
    end

    local out = {}

    for i = 1, #items do
        out[i] = { id = items[i].id, label = items[i].title }
    end

    return out
end

local function MapAmbulanceReport(report)
    if not report then
        return report
    end

    local f = report.fields or {}

    local doctorsInvolved = {}
    for i = 1, #(f.doctors or {}) do
        doctorsInvolved[i] = { id = f.doctors[i].id, name = f.doctors[i].name }
    end

    return {
        id = report.id,
        title = report.title,
        type = f.type,
        description = f.description,
        created = report.created,
        lastUpdated = report.lastUpdated,
        createdBy = report.createdBy,
        author = report.author,
        avatar = report.avatar,
        patient = f.target and f.target.id,
        patient_name = f.target and f.target.name,
        patient_dob = f.target and f.target.dob,
        patient_avatar = f.target and f.target.avatar,
        gallery = MapGalleryToObjects(f.gallery),
        tags = report.tags,
        injuries = f.injuries_conditions,
        doctorsInvolved = doctorsInvolved,
    }
end

local function MapPoliceReport(report)
    if not report then
        return report
    end

    local f = report.fields or {}

    local involved = {}
    local involvementMap = { officers = "officer", civilians = "civilian", suspects = "suspect" }

    for fieldId, involvement in pairs(involvementMap) do
        for _, item in ipairs(f[fieldId] or {}) do
            involved[#involved+1] = { involved = item.id, involvement = involvement, name = item.name }
        end
    end

    local weaponsInvolved = {}

    for i, item in ipairs(f.weapons or {}) do
        weaponsInvolved[i] = { id = "weapon:" .. item.id, serialNumber = item.id, model = item.model }
    end

    return {
        id = report.id,
        title = report.title,
        type = f.type,
        description = f.description,
        created = report.created,
        lastUpdated = report.lastUpdated,
        createdBy = report.createdBy,
        author = report.author,
        avatar = report.avatar,
        gallery = MapGalleryToObjects(f.gallery),
        tags = report.tags,
        involved = involved,
        weaponsInvolved = weaponsInvolved,
    }
end

local function MapPoliceWarrant(warrant)
    if not warrant then
        return warrant
    end

    local f = warrant.fields or {}
    local target = nil

    if f.target then
        local t = f.target
        -- Old type was "profile" for players; new is "player"
        target = { id = t.id, type = t.type == "player" and "profile" or t.type, avatar = t.avatar }

        if t.type == "player" then
            target.name = t.name
            target.dob  = t.dob
        else
            target.vehicle = { model = t.vehicleModel }
        end
    end

    return {
        id = warrant.id,
        title = warrant.title,
        description = f.description,
        type = f.type,
        status = f.status,
        priority = f.priority,
        createdBy = warrant.createdBy,
        timestamp = warrant.created,    -- old alias was `timestamp`, not `created`
        lastUpdated = warrant.lastUpdated,
        author = warrant.author,
        target = target,
        gallery = f.gallery or {},    -- old warrant gallery was already string[]
        tags = warrant.tags,
        reports = MapLinkedToLabel(f.linked_reports),
    }
end

local function MapPoliceCase(case)
    if not case then
        return case
    end

    local f = case.fields or {}

    local involved = {}

    for _, item in ipairs(f.officers  or {}) do
        involved[#involved+1] = { involved = item.id, involvement = "officer",  name = item.name }
    end

    for _, item in ipairs(f.civilians or {}) do
        involved[#involved+1] = { involved = item.id, involvement = "civilian", name = item.name }
    end

    for _, item in ipairs(f.vehicles  or {}) do
        involved[#involved+1] = { involved = item.id, involvement = "vehicle",  name = item.name }
    end

    local vehicleModels = {}

    for i, item in ipairs(f.vehicles or {}) do
        vehicleModels[i] = { plate = item.id, model = item.vehicleModel }
    end

    local weaponsInvolved = {}

    for i, item in ipairs(f.weapons or {}) do
        weaponsInvolved[i] = { id = "weapon:" .. item.id, serialNumber = item.id, model = item.model }
    end

    local criminalsInvolved = {}

    for i, item in ipairs(f.criminals or {}) do
        criminalsInvolved[i] = {
            id = item.id,
            name = item.name,
            fine = item.fine,
            jail_time = item.jailTime,   -- old used snake_case
            hasFined = item.fined,
            hasJailed = item.jailed,
            charges = item.charges or {},
        }
    end

    return {
        id = case.id,
        title = case.title,
        description = f.description,
        createdBy = case.createdBy,
        created = case.created,
        lastUpdated = case.lastUpdated,
        author = case.author,
        involved = involved,
        evidence = MapGalleryToObjects(f.evidence),
        tags = case.tags,
        vehicleModels = vehicleModels,
        weaponsInvolved = weaponsInvolved,
        criminalsInvolved = criminalsInvolved,
        reports = MapLinkedToLabel(f.reports),
    }
end

-- Ambulance Reports

RegisterLegacyExport("CreateAmbulanceReport", function(source, data)
    local creator = GetCreatorId(source)

    if not creator then
        return false, "no_tablet"
    end

    return tablet:CreateMDTReport("Ambulance", "reports", creator, {
        title = data.title,
        fields = {
            description = data.description,
            type = data.type,
            target = data.patient and { id = data.patient, type = "person" } or nil,
            gallery = data.gallery,
            doctors = data.doctors and { added = data.doctors } or nil,
            injuries_conditions = data.injuries,
        },
        addedTags = data.tags,
    })
end)

RegisterLegacyExport("GetAmbulanceReport", function(reportId)
    return MapAmbulanceReport(tablet:GetMDTReport("Ambulance", "reports", reportId))
end)

RegisterLegacyExport("UpdateAmbulanceReport", function(source, data)
    local creator = GetCreatorId(source)

    if not creator then
        return false, "no_tablet"
    end

    if not data?.id then
        return false, "no_id"
    end

    local reportId = data.id
    local addedTags, removedTags = GetReportTagDiff(reportId, "reports", data.tags)
    local addedDoctors, removedDoctors = GetInvolvedDiff(reportId, "doctors", data.doctors)

    return tablet:UpdateMDTReport("Ambulance", "reports", creator, {
        id = reportId,
        title = data.title,
        fields = {
            description = data.description,
            type = data.type,
            target = data.patient and { id = data.patient, type = "person" } or nil,
            gallery = data.gallery,
            doctors = { added = addedDoctors, removed = removedDoctors },
            injuries_conditions = data.injuries,
        },
        addedTags = addedTags,
        removedTags = removedTags,
    })
end)

RegisterLegacyExport("DeleteAmbulanceReport", function(id)
    return tablet:DeleteMDTReport(id)
end)

-- Police Reports

RegisterLegacyExport("CreatePoliceReport", function(source, data)
    local creator = GetCreatorId(source)

    if not creator then
        return false, "no_tablet"
    end

    return tablet:CreateMDTReport("Police", "reports", creator, {
        title = data.title,
        fields = {
            description = data.description,
            type = data.type,
            gallery = data.gallery,
            officers = data.officers and { added = data.officers } or nil,
            civilians = data.civilians and { added = data.civilians } or nil,
            suspects = data.suspects and { added = data.suspects } or nil,
            weapons = data.weapons and { added = data.weapons } or nil,
        },
        addedTags = data.tags,
    })
end)

RegisterLegacyExport("GetPoliceReport", function(reportId)
    return MapPoliceReport(tablet:GetMDTReport("Police", "reports", reportId))
end)

RegisterLegacyExport("UpdatePoliceReport", function(source, data)
    local creator = GetCreatorId(source)

    if not creator then
        return false, "no_tablet"
    end

    if not data?.id then
        return false, "no_id"
    end

    local reportId = data.id
    local addedTags, removedTags = GetReportTagDiff(reportId, "reports", data.tags)
    local addedOfficers, removedOfficers = GetInvolvedDiff(reportId, "officers", data.officers)
    local addedCivilians, removedCivilians = GetInvolvedDiff(reportId, "civilians", data.civilians)
    local addedSuspects, removedSuspects = GetInvolvedDiff(reportId, "suspects", data.suspects)
    local addedWeapons, removedWeapons = GetInvolvedDiff(reportId, "weapons", data.weapons)

    return tablet:UpdateMDTReport("Police", "reports", creator, {
        id = reportId,
        title = data.title,
        fields = {
            description = data.description,
            type = data.type,
            gallery = data.gallery,
            officers = { added = addedOfficers, removed = removedOfficers },
            civilians = { added = addedCivilians, removed = removedCivilians },
            suspects = { added = addedSuspects, removed = removedSuspects },
            weapons = { added = addedWeapons, removed = removedWeapons },
        },
        addedTags = addedTags,
        removedTags = removedTags,
    })
end)

RegisterLegacyExport("DeletePoliceReport", function(id)
    return tablet:DeleteMDTReport(id)
end)

-- Police Warrants

RegisterLegacyExport("CreatePoliceWarrant", function(source, data)
    local creator = GetCreatorId(source)

    if not creator then
        return false, "no_tablet"
    end

    -- Old target type "profile" maps to new "person"
    local target = data.target

    if target and target.type == "profile" then
        target = { id = target.id, type = "person" }
    end

    return tablet:CreateMDTReport("Police", "warrants", creator, {
        title = data.title,
        fields = {
            description = data.description,
            type = data.type,
            status = data.status,
            priority = data.priority,
            target = target,
            gallery = data.gallery,
            linked_reports = data.reports,
        },
        addedTags = data.tags,
    })
end)

RegisterLegacyExport("GetPoliceWarrant", function(warrantId)
    return MapPoliceWarrant(tablet:GetMDTReport("Police", "warrants", warrantId))
end)

RegisterLegacyExport("UpdatePoliceWarrant", function(source, data)
    local creator = GetCreatorId(source)

    if not creator then
        return false, "no_tablet"
    end

    if not data?.id then
        return false, "no_id"
    end

    local reportId = data.id
    local addedTags, removedTags = GetReportTagDiff(reportId, "warrants", data.tags)
    local target = data.target

    if target and target.type == "profile" then
        target = { id = target.id, type = "person" }
    end

    return tablet:UpdateMDTReport("Police", "warrants", creator, {
        id = reportId,
        title = data.title,
        fields = {
            description = data.description,
            type = data.type,
            status = data.status,
            priority = data.priority,
            target = target,
            gallery = data.gallery,
            linked_reports = data.reports,
        },
        addedTags = addedTags,
        removedTags = removedTags,
    })
end)

RegisterLegacyExport("DeletePoliceWarrant", function(id)
    return tablet:DeleteMDTReport(id)
end)

-- Police Player Charges

RegisterLegacyExport("GetPolicePlayerCharges", function(identifier)
    assert(type(identifier) == "string", "GetPolicePlayerCharges: identifier must be a string")

    return MySQL.query.await([[
        SELECT
            c.charge_id AS id,
            CAST(SUM(c.charges) AS INT) AS charges

        FROM lbtablet_mdt_reports_involved_charges c

        INNER JOIN lbtablet_mdt_reports_involved i
            ON i.id = c.involved_id

        WHERE
            c.involved = ?
            AND c.department = ?
            AND i.profile_type = ?

        GROUP BY
            c.charge_id
    ]], { identifier, "Police", "player" })
end)

-- Police Cases

---Converts the old Criminal[] format into the `added` and `charges` tables
---expected by InsertInvolved.
---@param criminals { id: string, charges?: { id: number, charges: number }[], fine?: number, jailTime?: number }[]
---@return table[] added, table[] charges
local function FormatCriminals(criminals)
    local added, charges = {}, {}

    for i = 1, #criminals do
        local criminal = criminals[i]

        added[#added+1] = {
            id = criminal.id,
            fine = criminal.fine,
            jailTime = criminal.jailTime,
        }

        for j = 1, #(criminal.charges or {}) do
            local charge = criminal.charges[j]

            charges[#charges+1] = {
                identifier = criminal.id,
                id = charge.id,
                charges = charge.charges,
            }
        end
    end

    return added, charges
end

RegisterLegacyExport("CreatePoliceCase", function(source, data)
    local creator = GetCreatorId(source)

    if not creator then
        return false, "no_tablet"
    end

    local criminalsAdded, charges = FormatCriminals(data.criminals or {})

    return tablet:CreateMDTReport("Police", "cases", creator, {
        title = data.title,
        fields = {
            description = data.description,
            evidence = data.evidence,
            reports = data.reports,
            officers = data.officers and { added = data.officers } or nil,
            civilians = data.civilians and { added = data.civilians } or nil,
            criminals = { added = criminalsAdded, charges = charges },
            vehicles = data.vehicles and { added = data.vehicles } or nil,
            weapons = data.weapons and { added = data.weapons } or nil,
        },
        addedTags = data.tags,
    })
end)

RegisterLegacyExport("GetPoliceCase", function(caseId)
    return MapPoliceCase(tablet:GetMDTReport("Police", "cases", caseId))
end)

RegisterLegacyExport("UpdatePoliceCase", function(source, data)
    local creator = GetCreatorId(source)

    if not creator then
        return false, "no_tablet"
    end

    if not data?.id then
        return false, "no_id"
    end

    local caseId = data.id
    local addedTags, removedTags = GetReportTagDiff(caseId, "cases", data.tags)
    local addedOfficers, removedOfficers = GetInvolvedDiff(caseId, "officers", data.officers)
    local addedCivilians, removedCivilians = GetInvolvedDiff(caseId, "civilians", data.civilians)
    local addedVehicles, removedVehicles = GetInvolvedDiff(caseId, "vehicles", data.vehicles)
    local addedWeapons, removedWeapons = GetInvolvedDiff(caseId, "weapons", data.weapons)

    -- Criminals are fully replaced on every update so that fine/jailTime changes
    -- on existing entries are reflected (InsertInvolved does not upsert those columns).
    local existingCriminals = MySQL.query.await(
        "SELECT involved FROM lbtablet_mdt_reports_involved WHERE report_id = ? AND involvement = ?",
        { caseId, "criminals" }
    )

    local criminalsRemoved = {}
    for i = 1, #existingCriminals do
        criminalsRemoved[#criminalsRemoved+1] = existingCriminals[i].involved
    end

    local criminalsAdded, charges = FormatCriminals(data.criminals or {})

    return tablet:UpdateMDTReport("Police", "cases", creator, {
        id = caseId,
        title = data.title,
        fields = {
            description = data.description,
            evidence = data.evidence,
            reports = data.reports,
            officers = { added = addedOfficers, removed = removedOfficers },
            civilians = { added = addedCivilians, removed = removedCivilians },
            criminals = { added = criminalsAdded, removed = criminalsRemoved, charges = charges },
            vehicles = { added = addedVehicles, removed = removedVehicles },
            weapons = { added = addedWeapons, removed = removedWeapons },
        },
        addedTags = addedTags,
        removedTags = removedTags,
    })
end)

RegisterLegacyExport("DeletePoliceCase", function(id)
    return tablet:DeleteMDTReport(id)
end)
