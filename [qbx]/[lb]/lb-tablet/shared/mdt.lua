---@alias MDTPermission boolean | number | number[]
---@alias MDTPermissionKey "view" | "create" | "edit" | "delete" | "stash" | "fine" | "pin" | "kick" | "invite" | "private" | "triangulate" | "unlock" | "callHistory" | "createWiretap" | "listenWiretap" | "messageWiretap" | "removeWiretap"

---@alias MDTTabType "home" | "bulletin" | "dispatch" | "users" | "vehicles" | "reports" | "phone" | "properties" | "weapons" | "logs" | "chat" | "catalog"

---@class MDTBaseTab
---@field id? string
---@field permissions? { [string]: { [MDTPermissionKey]: MDTPermission? } }
---@field type MDTTabType
---@field icon string
---@field label string

---@class MDTHomeTab : MDTBaseTab
---@field type "home"
---@field content string[]

---@class MDTUnitsTab
---@field type "units"
---@field default { status: string, units: { name: string, status: string }[] }
---@field statuses { [string]: { label: string, color: string } }

---@class MDTBaseUsersField
---@field id string
---@field type string
---@field label string
---@field editable? boolean

---@class MDTProfileEntityFieldsCheck
---@field tabType "reports"
---@field id string
---@field type "field"
---@field field? string
---@field value string
---@field involvement? string

---@class MDTUsersEntityFieldField
---@field id string
---@field label string
---@field value? string
---@field copyable? string
---@field type? string
---@field check? MDTProfileEntityFieldsCheck

---@class MDTUsersEntityField : MDTBaseUsersField
---@field type "entity"
---@field entityType "profile"
---@field entityFields MDTUsersEntityFieldField[]

---@class MDTUsersTab : MDTBaseTab
---@field type "users"
---@field fields (MDTBaseUsersField | MDTUsersEntityField)[]

---@class MDTBaseReportField
---@field id string
---@field label string

---@class MDTReportInvolvedField : MDTBaseReportField
---@field type "person" | "vehicle" | "weapon" | "employee" | "property"
---@field multiple boolean
---@field catalog? boolean

---@class MDTReportTargetField : MDTBaseReportField
---@field type "target"
---@field vehicle boolean
---@field person boolean

---@class MDTReportPhotoField : MDTBaseReportField
---@field type "photo"
---@field multiple boolean

---@class MDTReportLinkedField : MDTBaseReportField
---@field type "linked"
---@field linkType "reports"
---@field linkId? string
---@field multiple boolean

---@class MDTReportTextField : MDTBaseReportField
---@field type "text"
---@field template? string

---@class MDTDropdownField : MDTBaseReportField
---@field type "dropdown"
---@field showInList? boolean
---@field options (string | { id: string, label: string, color?: string })[]

---@class MDTReportsTab : MDTBaseTab
---@field type "reports"
---@field name? string
---@field shared? boolean
---@field mdt? string
---@field fields (MDTReportInvolvedField | MDTReportPhotoField | MDTReportLinkedField  | MDTReportTextField  | MDTDropdownField | MDTReportTargetField)[]

---@class MDTTriangulationOptions
---@field requireCall boolean
---@field cellTowerTime number
---@field successRate number
---@field rangeMultiplier number

---@class MDTUnlockOptions
---@field time? [number, number]
---@field chance? number
---@field attempts? number

---@class MDTWiretapOptions
---@field minCallDuration? number

---@class MDTPhoneTab : MDTBaseTab
---@field type "phone"
---@field triangulation? MDTTriangulationOptions
---@field unlock? MDTUnlockOptions
---@field wiretap? MDTWiretapOptions

---@alias MDTTab MDTBaseTab | MDTHomeTab | MDTUnitsTab | MDTUsersTab | MDTReportsTab | MDTPhoneTab

---@class MDTCallsignConfig
---@field enabled boolean
---@field format? string
---@field requireTemplate? boolean
---@field allowChange? boolean
---@field autoGenerate? boolean

---@class MDTOptions
---@field dutyBlips boolean

---@class MDT
---@field copy? string
---@field disabledTabs? string[]
---@field name string
---@field department string
---@field deviceName string
---@field appicon string
---@field icon string
---@field colorTheme string
---@field options MDTOptions
---@field callsign? MDTCallsignConfig
---@field defaultPermissions { [string]: { [MDTPermissionKey]: MDTPermission? } }
---@field tabs MDTTab[]
---@field jobsArray string[]

---@alias MDTField MDTReportInvolvedField | MDTReportPhotoField | MDTReportLinkedField  | MDTReportTextField  | MDTDropdownField | MDTReportTargetField | MDTBaseUsersField | MDTUsersEntityField

---@type { [string]: MDT }
MDTs = json.decode(LoadResourceFile(GetCurrentResourceName(), "config/mdts.json") or "[]")

MDTs["$schema"] = nil

---@param permissionData { [string]: { [string]: MDTPermission? } }
---@param jobName string
---@param jobGrade number
---@param onDuty boolean
---@return { [string]: boolean } | false
local function GetPermissions(permissionData, jobName, jobGrade, onDuty)
    local permissions = {}
    local jobPermissions = permissionData[jobName]

    if not jobPermissions then
        return false
    end

    for permissionName, permissionValue in pairs(jobPermissions) do
        local permissionValuesType = type(permissionValue)
        local hasPermission = false

        if permissionValuesType == "number" then
            hasPermission = jobGrade >= permissionValue
        elseif permissionValuesType == "boolean" then
            hasPermission = permissionValue
        else
            hasPermission = table.contains(permissionValue, jobGrade)
        end

        if not permissions[permissionName] then
            permissions[permissionName] = hasPermission
        end
    end

    return permissions
end

---@param mdtName string
---@param source? number # The source, if checking on the server
---@return boolean
function IsEmployeeOfMDT(mdtName, source)
    local mdt = MDTs[mdtName]

    if not mdt then
        error("IsEmployeeOfMDT: invalid MDT '" .. tostring(mdtName) .. "'")
    end

    ---@type string?, number?, boolean?
    local jobName, jobGrade, onDuty

    if source then
        local jobData = GetJob(source)

        jobName = jobData.name
        jobGrade = jobData.grade

        onDuty = IsOnDuty(source)
    else
        jobName = GetJob()
        jobGrade = GetJobGrade()
        onDuty = IsOnDuty()
    end

    if not jobName or not jobGrade then
        return false
    end

    if Config.MDT.RequireDuty and not onDuty then
        return false
    end

    return table.contains(mdt.jobsArray, jobName)
end

---@param mdtName string
---@param source? number
---@return { [string]: { [string]: boolean } } | false
function GetMDTPermissions(mdtName, source)
    if IsDuplicityVersion() and not source then
        error("GetMDTPermissions: source must be provided when called from the server")
    end

    local mdt = MDTs[mdtName]

    if not mdt then
        error("GetMDTPermissions: invalid MDT '" .. tostring(mdtName) .. "'")
    end

    ---@type string?, number?, boolean?
    local jobName, jobGrade, onDuty

    if source then
        local jobData = GetJob(source)

        jobName = jobData.name
        jobGrade = jobData.grade

        onDuty = IsOnDuty(source)
    else
        jobName = GetJob()
        jobGrade = GetJobGrade()
        onDuty = IsOnDuty()
    end

    if not jobName or not jobGrade then
        return false
    end

    if Config.MDT.RequireDuty and not onDuty then
        return false
    end

    local defaultPermissions = GetPermissions(mdt.defaultPermissions, jobName, jobGrade, onDuty)

    if not defaultPermissions then
        return false
    end

    local permissions = {
        default = defaultPermissions
    }

    for _, tab in pairs(mdt.tabs) do
        local tabId = tab.id or tab.type

        if tab.permissions then
            local tabPermissions = GetPermissions(tab.permissions, jobName, jobGrade, onDuty)

            if tabPermissions then
                permissions[tabId] = table.combine(table.clone(defaultPermissions), tabPermissions)
            end
        else
            permissions[tabId] = defaultPermissions
        end
    end

    permissions["tag"] = defaultPermissions

    return permissions
end

---@param source number?
function GetAllMDTPermissions(source)
    if IsDuplicityVersion() and not source then
        error("GetAllMDTPermissions: source must be provided when called from the server")
    end

    local permissions = {}

    for mdtName in pairs(MDTs) do
        permissions[mdtName] = GetMDTPermissions(mdtName, source)
    end

    return permissions
end

---@param mdtName string
---@param tabId string
---@param permissionKey MDTPermissionKey
---@param source number?
---@return boolean
function HasMDTPermission(mdtName, tabId, permissionKey, source)
    local permissions = GetMDTPermissions(mdtName, source)

    if not permissions then
        return false
    end

    if not permissions[tabId] then
        return false
    end

    return permissions[tabId][permissionKey] == true
end

---@param mdt string | MDT
---@param tab MDTTabType | string
---@param tabId? string
---@return MDTTab?
function GetMDTTab(mdt, tab, tabId)
    local mdtData = type(mdt) == "table" and mdt or MDTs[mdt]

    if not mdtData then
        return
    end

    for _, mdtTab in pairs(mdtData.tabs) do
        if mdtTab.type == tab then
            if not tabId or mdtTab.id == tabId then
                return mdtTab
            end
        end
    end
end

---@param tab MDTTab
---@param field string
function GetFieldById(tab, field)
    for i = 1, #tab.fields do
        if tab.fields[i].id == field then
            return tab.fields[i]
        end
    end
end

---@param tab MDTTab
---@param field string
---@return MDTField?, number?
function GetFieldByType(tab, field)
    for i = 1, #tab.fields do
        if tab.fields[i].type == field then
            return tab.fields[i], i
        end
    end
end

---@param tab MDTTab
---@param field string
function GetFieldsByType(tab, field)
    ---@type MDTField[]
    local fields = {}

    for i = 1, #tab.fields do
        if tab.fields[i].type == field then
            fields[#fields+1] = tab.fields[i]
        end
    end

    return fields
end

---@param job string
---@return string[]
function GetMDTsFromJob(job)
    local mdts = {}

    for mdtName, mdt in pairs(MDTs) do
        if table.contains(mdt.jobsArray, job) then
            mdts[#mdts+1] = mdtName
        end
    end

    return mdts
end

---@param from MDT
---@param to MDT
local function CopyMDT(from, to)
    if not from then
        return infoprint("error", "CopyMDT: 'from' MDT does not exist")
    end

    if from == to then
        return infoprint("error", "CopyMDT: 'from' and 'to' MDTs are the same", from, to)
    end

    if from.options and not to.options then
        to.options = table.deep_clone(from.options)
    end

    if to.tabs then
        for i = 1, #from.tabs do
            local tab = from.tabs[i]
            local tabId = tab.id or tab.type

            if to.disabledTabs and table.contains(to.disabledTabs, tabId) then
                debugprint("Not copying tab", tab.type, tab.id, "from MDT", from.name, "to MDT", to.name, "because it's disabled")
                goto continue
            end

            if not GetMDTTab(to, tab.type, tab.id) then
                debugprint("Copying tab", tab.type, tab.id, "from MDT", from.name, "to MDT", to.name)
                to.tabs[#to.tabs+1] = table.deep_clone(from.tabs[i])
            end

            ::continue::
        end
    end

    for key, value in pairs(from) do
        if to[key] == nil then
            to[key] = type(value) == "table" and table.deep_clone(value) or value
        end
    end
end

for mdtName, mdt in pairs(MDTs) do
    if mdt.copy then
        local mdtToCopy = MDTs[mdt.copy]

        CopyMDT(mdtToCopy, mdt)
    end

    for i = #mdt.tabs, 1, -1 do
        local tab = mdt.tabs[i]

        if not Config.HousingScript then
            if tab.type == "properties" then
                table.remove(mdt.tabs, i)

                debugprint("Removed properties tab from MDT", mdtName, "because no housing script is configured")
            elseif tab.type == "users" then
                local _, index = GetFieldByType(tab, "properties")

                if index then
                    table.remove(tab.fields, index)

                    debugprint("Removed properties field from users tab in MDT", mdtName, "because no housing script is configured")
                end
            end
        end

        if tab.type == "reports" and tab.shared and tab.mdt then
            local mdtToCopyFrom = MDTs[tab.mdt]
            local tabToCopyFrom = GetMDTTab(mdtToCopyFrom, "reports", tab.id)

            if tabToCopyFrom then
                tab.fields = table.deep_clone(tabToCopyFrom.fields)
            else
                infoprint("warning", "Shared reports tab", tab.id, "in MDT", mdtName, "is set to copy from MDT", tab.mdt, "but no matching tab was found")
            end
        end

        if tab.type == "phone" then
            Citizen.CreateThreadNow(function()
                if not Config.LBPhone then
                    table.remove(mdt.tabs, i)

                    debugprint("Removed phone tab from MDT", mdtName, "because LBPhone is not enabled")
                elseif not GetPhoneConfig()?.Item?.Unique then
                    tab.unlock = nil
                end
            end)
        end
    end

    local jobsArray = {}

    for job in pairs(mdt.defaultPermissions) do
        jobsArray[#jobsArray+1] = job
    end

    mdt.jobsArray = jobsArray
end

---@return { [string]: MDT }
exports("GetMDTs", function()
    return MDTs
end)

---@param mdtName string
---@return MDT?
exports("GetMDT", function(mdtName)
    assert(type(mdtName) == "string", "Expected string for mdtName")

    return MDTs[mdtName]
end)

exports("IsEmployeeOfMDT", IsEmployeeOfMDT)
exports("GetMDTPermissions", GetMDTPermissions)
