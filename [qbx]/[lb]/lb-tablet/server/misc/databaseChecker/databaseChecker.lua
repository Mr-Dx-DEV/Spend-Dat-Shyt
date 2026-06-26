local shouldGenerateTables = false

MySQL.ready.await()

if not Config.DatabaseChecker?.Enabled and not shouldGenerateTables then
    debugprint("Database checker is disabled")
    DatabaseCheckerFinished = true
    return
end

local database = MySQL.scalar.await("SELECT DATABASE()")

if not database then
    infoprint("error", "Database checker: Failed to get database name. The script will still work, but database changes will not apply automatically. To disable this warning, set Config.DatabaseChecker.Enabled to false")
    DatabaseCheckerFinished = true
    return
end

local databaseVersion = MySQL.scalar.await("SELECT VERSION()") or ""

if not databaseVersion:find("MariaDB") then
    infoprint("error", "Database checker: Your database is not MariaDB. The script may not work as expected, and database changes will not apply automatically. To disable this warning, set Config.DatabaseChecker.Enabled to false")
    DatabaseCheckerFinished = true
    return
end

local major, minor, patch = databaseVersion:match("(%d+)%.(%d+)%.(%d+)")

major = major and tonumber(major)
minor = minor and tonumber(minor)
patch = patch and tonumber(patch)

if not major or not minor or not patch then
    infoprint("error", "Database checker: Failed to get database version. The script will still work, but database changes will not apply automatically. To disable this warning, set Config.DatabaseChecker.Enabled to false")
    DatabaseCheckerFinished = true
    return
end

if major < 10 or (major == 10 and minor < 11) then
    infoprint("error", "Database checker: Your database version is outdated. Please update to MariaDB 10.11 or newer. The script may not work as expected, and database changes will not apply automatically. To disable this warning, set Config.DatabaseChecker.Enabled to false")
    DatabaseCheckerFinished = true
    return
end

local defaultTables = GetDefaultDatabaseTables()
local tables = {}

local function FetchTables()
    table.wipe(tables)

    local rows = MySQL.query.await("SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE, COLLATION_NAME, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE, COLUMN_DEFAULT, COLUMN_KEY FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = ? AND TABLE_NAME LIKE ?", {
        shouldGenerateTables and "generate_lb" or database, "lbtablet_%"
    })

    for i = 1, #rows do
        local row = rows[i]
        local tableName = row.TABLE_NAME
        local columnName = row.COLUMN_NAME
        local dataType = row.DATA_TYPE
        local collationName = row.COLLATION_NAME
        local characterMaximumLength = row.CHARACTER_MAXIMUM_LENGTH
        local isNullable = row.IS_NULLABLE
        local default = row.COLUMN_DEFAULT
        local isKey = #row.COLUMN_KEY > 0

        if not tables[tableName] then
            tables[tableName] = {}
        end

        tables[tableName][columnName] = {
            type = dataType:upper(),
            collation = collationName,
            allowNull = isNullable == "YES",
            default = default,
            length = characterMaximumLength,
            isKey = isKey,
            keyType = row.COLUMN_KEY:upper()
        }
    end

    return tables
end

FetchTables()

---@param content string
---@return string[]
local function ExtractQueriesFromFile(content)
    local queries = {}

    -- split queries by semicolon
    for query in content:gmatch("[^;]+") do
        -- remove comments
        query = query:gsub("%-%-[^\n]*", ""):gsub("/%*.-%*/", ""):gsub("^%s+", ""):gsub("%s+$", "")
        -- remove semicolon
        query = query:sub(1, -1)

        if #query > 0 then
            queries[#queries+1] = query
        end
    end

    return queries
end

local function RunTabletSQL()
    local file = LoadResourceFile(GetCurrentResourceName(), "tablet.sql")

    if not file then
        DatabaseCheckerFinished = true

        error("Database checker: Failed to load tablet.sql")
    end

    local queries = ExtractQueriesFromFile(file)

    if not MySQL.transaction.await(queries) then
        DatabaseCheckerFinished = true

        error("Database checker: Failed to create tables, please run tablet.sql manually using HeidiSQL")
    else
        infoprint("success", "Database checker: Created tables successfully")
    end
end

---@param fileName string
local function RunOptionalSQL(fileName)
    local filePath = "Optional SQL/" .. fileName .. ".sql"
    local content = LoadResourceFile(GetCurrentResourceName(), filePath)

    if not content then
        infoprint("warning", ("Database checker: Failed to load ^5%s^7, skipping"):format(filePath))
    end

    local queries = ExtractQueriesFromFile(content)

    if not MySQL.transaction.await(queries) then
        infoprint("warning", ("Database checker: Failed to run ^5%s^7, skipping"):format(filePath))
    else
        infoprint("success", ("Database checker: Ran ^5%s^7 successfully"):format(filePath))
    end
end

if shouldGenerateTables then
    local luaTable = "local defaultTables = {\n"

    for tableName, columns in pairs(tables) do
        luaTable = ("%s\t%s = {\n"):format(luaTable, tableName)

        for columnName, column in pairs(columns) do
            luaTable = luaTable .. ("\t\t{\n\t\t\tcolumn = \"%s\",\n"):format(columnName)
            luaTable = luaTable .. ("\t\t\ttype = \"%s\",\n"):format(column.type)
            luaTable = luaTable .. ("\t\t\tallowNull = %s,\n"):format(column.allowNull and "true" or "false")
            luaTable = luaTable .. ("\t\t\tisKey = %s,\n"):format(column.isKey and "true" or "false")

            if column.default then
                luaTable = luaTable .. ("\t\t\tdefault = \"%s\",\n"):format(column.default)
            end

            if column.collation then
                luaTable = luaTable .. ("\t\t\tcollation = \"%s\",\n"):format(column.collation)
            end

            if column.length and column.type ~= "LONGTEXT" and column.type ~= "TEXT" then
                luaTable = luaTable .. ("\t\t\tlength = %s,\n"):format(math.floor(column.length))
            end

            luaTable = luaTable .. "\t\t},\n"
        end

        luaTable = luaTable .. "\t},\n"
    end

    luaTable = luaTable .. "}"

    SaveResourceFile(GetCurrentResourceName(), "defaultdb.lua", luaTable, -1)

    DatabaseCheckerFinished = true
    return
end

if not tables.lbtablet_tablets then
    if not Config.DatabaseChecker.AutoFix then
        DatabaseCheckerFinished = true
        return error("Database checker: Missing table lbtablet_tablets. Please run tablet.sql manually using HeidiSQL")
    end

    RunTabletSQL()
    RunOptionalSQL("mdt-conditions")
    RunOptionalSQL("mdt-offences")
    FetchTables()
end

local fixQueries = {}
local missingTables = {}
local madeChanges = false

local function ValidateMDTRewrite()
    if tables.lbtablet_mdt_employees then
        return
    end

    infoprint("info", "Database checker: Detected old MDT structure, converting MDT data...")

    RunTabletSQL()
    ConvertMDTData(database)

    infoprint("success", "Database checker: All old MDT data has been converted to the new format")

    madeChanges = true
end

local function MigrateReportsInvolvedUniqueKey()
    local result = MySQL.scalar.await([[
        SELECT COUNT(*) FROM INFORMATION_SCHEMA.STATISTICS
            WHERE TABLE_SCHEMA = DATABASE()
            AND TABLE_NAME = 'lbtablet_mdt_reports_involved'
            AND INDEX_NAME != 'PRIMARY'
            AND SEQ_IN_INDEX = 2
            AND COLUMN_NAME = 'involved'
            AND (
                SELECT COUNT(*) FROM INFORMATION_SCHEMA.STATISTICS s2
                WHERE s2.TABLE_SCHEMA = DATABASE()
                AND s2.TABLE_NAME = 'lbtablet_mdt_reports_involved'
                AND s2.INDEX_NAME = STATISTICS.INDEX_NAME
            ) = 2
    ]])

    if not result or result == 0 then
        return
    end

    local indexName = MySQL.scalar.await([[
        SELECT INDEX_NAME FROM INFORMATION_SCHEMA.STATISTICS
        WHERE TABLE_SCHEMA = DATABASE()
            AND TABLE_NAME = 'lbtablet_mdt_reports_involved'
            AND INDEX_NAME != 'PRIMARY'
            AND SEQ_IN_INDEX = 2
            AND COLUMN_NAME = 'involved'
        LIMIT 1
    ]])

    if indexName then
        infoprint("info", "Database checker: Migrating lbtablet_mdt_reports_involved unique key...")

        MySQL.query.await(("ALTER TABLE lbtablet_mdt_reports_involved DROP INDEX `%s`, ADD UNIQUE KEY (report_id, involved, involvement)"):format(indexName))

        infoprint("success", "Database checker: Migrated lbtablet_mdt_reports_involved unique key")
    end
end

if Config.DatabaseChecker.AutoFix then
    ValidateMDTRewrite()
    MigrateReportsInvolvedUniqueKey()
end

if madeChanges then
    FetchTables()
end

local function GetLastArg(column)
    local lastArg = column.type

    if column.length and column.type ~= "LONGTEXT" and column.type ~= "TEXT" then
        lastArg = lastArg .. ("(%s)"):format(column.length)
    end

    if not column.allowNull then
        lastArg = lastArg .. " NOT NULL"
    end

    if column.default then
        lastArg = lastArg .. (" DEFAULT %s"):format(column.default)
    end

    return lastArg
end

for tableName, columns in pairs(defaultTables) do
    if not tables[tableName] then
        infoprint("warning", ("The table ^5%s^7 is missing in the database. Automatically running the sql file."):format(tableName))
        RunTabletSQL()
        FetchTables()

        break
    end
end

for tableName, columns in pairs(defaultTables) do
    local checkTable = tables[tableName]

    if not checkTable then
        infoprint("error", ("Missing table ^5%s^7 in the database. Please re-run the tablet.sql file."):format(tableName))

        missingTables[#missingTables+1] = tableName

        goto continue
    end

    for i = 1, #columns do
        local defaultColumn = columns[i]
        local column = checkTable[defaultColumn.column]

        if not checkTable[defaultColumn.column] then
            infoprint("warning", ("Missing column ^5%s^7 in the table ^5%s^7."):format(defaultColumn.column, tableName))

            if not defaultColumn.isKey then
                fixQueries[#fixQueries+1] = ("ALTER TABLE `%s` ADD COLUMN `%s` %s"):format(tableName, defaultColumn.column, GetLastArg(defaultColumn))
            else
                infoprint("error", ("Column ^5%s^7 in the table ^5%s^7 is a key and cannot be added automatically. Check the #updates channel for a query to run, or ask in #customer-support"):format(defaultColumn.column, tableName))
            end

            goto continueColumns
        end

        if defaultColumn.type ~= column.type then
            infoprint("warning", ("Column ^5%s^7 in the table ^5%s^7 has the wrong data type."):format(defaultColumn.column, tableName))

            if not defaultColumn.isKey and not column.isKey then
                fixQueries[#fixQueries+1] = ("ALTER TABLE `%s` MODIFY COLUMN `%s` %s"):format(tableName, defaultColumn.column, GetLastArg(defaultColumn))
            else
                infoprint("error", ("Column ^5%s^7 in the table ^5%s^7 is a key and cannot be modified automatically. Check the #updates channel for a query to run, or ask in #customer-support"):format(defaultColumn.column, tableName))
            end

            goto continueColumns
        end

        if defaultColumn.length and defaultColumn.length > column.length then
            infoprint("warning", ("Column ^5%s^7 in the table ^5%s^7 has the wrong length."):format(defaultColumn.column, tableName))

            if not defaultColumn.isKey and not column.isKey then
                fixQueries[#fixQueries+1] = ("ALTER TABLE `%s` MODIFY COLUMN `%s` %s"):format(tableName, defaultColumn.column, GetLastArg(defaultColumn))
            else
                infoprint("error", ("Column ^5%s^7 in the table ^5%s^7 is a key and cannot be modified automatically. Check the #updates channel for a query to run, or ask in #customer-support"):format(defaultColumn.column, tableName))
            end

            goto continueColumns
        end

        if defaultColumn.collation and defaultColumn.collation ~= column.collation then
            infoprint("warning", ("Column ^5%s^7 in the table ^5%s^7 has the wrong collation."):format(defaultColumn.column, tableName))
        end

        ::continueColumns::
    end

    ::continue::
end

local changes = #fixQueries
local missingAnyTables = #missingTables > 0

if changes > 0 then
    if Config.DatabaseChecker.AutoFix then
        infoprint("info", ("Fixing database, applying %i changes..."):format(changes))

        local success = MySQL.transaction.await(fixQueries)

        if success then
            infoprint("success", "Database has been fixed.")
        else
            infoprint("error", "Failed to fix the database.")
        end
    else
        local fixQuery = ""

        for i = 1, #fixQueries do
            fixQuery = fixQuery .. fixQueries[i] .. ";\n"
        end

        SaveResourceFile(GetCurrentResourceName(), "fix.sql", fixQuery, -1)
        infoprint("warning", ("Database has %i changes that need to be fixed. Try running lb-tablet/fix.sql"):format(changes))
    end
end

DatabaseCheckerFinished = true

while (changes > 0 and not Config.DatabaseChecker.AutoFix) or missingAnyTables do
    if changes > 0 and not Config.DatabaseChecker.AutoFix then
        infoprint("warning", ("Database has %i changes that need to be fixed. Try running lb-tablet/fix.sql"):format(changes))
    end

    if missingAnyTables then
        infoprint("error", "The database is missing the table" .. (missingAnyTables == 1 and "s^5 " or "^5 ") ..  table.concat(missingTables, "^7,^5 ") .. "^7. Please re-run the tablet.sql file.")
    end

    Wait(5000)
end
