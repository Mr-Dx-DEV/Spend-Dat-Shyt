-- MIT License
-- fs-doj Shared Utilities

Utils = {}

-- Debug print
function Utils.Debug(...)
    if Config.Debug then
        print('^3[fs-doj DEBUG]^0', ...)
    end
end

-- Table utilities
function Utils.TableContains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

function Utils.TableCopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[Utils.TableCopy(orig_key)] = Utils.TableCopy(orig_value)
        end
        setmetatable(copy, Utils.TableCopy(getmetatable(orig)))
    else
        copy = orig
    end
    return copy
end

function Utils.TableMerge(t1, t2)
    for k, v in pairs(t2) do
        if type(v) == "table" then
            if type(t1[k] or false) == "table" then
                Utils.TableMerge(t1[k] or {}, t2[k] or {})
            else
                t1[k] = v
            end
        else
            t1[k] = v
        end
    end
    return t1
end

-- String utilities
function Utils.Trim(s)
    return s:match("^%s*(.-)%s*$")
end

function Utils.Split(str, delimiter)
    local result = {}
    local from = 1
    local delim_from, delim_to = string.find(str, delimiter, from)
    while delim_from do
        table.insert(result, string.sub(str, from, delim_from - 1))
        from = delim_to + 1
        delim_from, delim_to = string.find(str, delimiter, from)
    end
    table.insert(result, string.sub(str, from))
    return result
end

-- Format currency
function Utils.FormatCurrency(amount)
    local formatted = amount
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if k == 0 then
            break
        end
    end
    return '$' .. formatted
end

-- Format date/time (SERVER SIDE ONLY - uses os.date)
function Utils.FormatDateTime(timestamp)
    if not timestamp then return 'N/A' end
    -- Only works on server side
    if IsDuplicityVersion() then
        return os.date('%Y-%m-%d %H:%M:%S', timestamp)
    else
        -- Client side fallback
        return tostring(timestamp)
    end
end

function Utils.FormatDate(timestamp)
    if not timestamp then return 'N/A' end
    -- Only works on server side
    if IsDuplicityVersion() then
        return os.date('%Y-%m-%d', timestamp)
    else
        -- Client side fallback
        return tostring(timestamp)
    end
end

function Utils.FormatTime(timestamp)
    if not timestamp then return 'N/A' end
    -- Only works on server side
    if IsDuplicityVersion() then
        return os.date('%H:%M:%S', timestamp)
    else
        -- Client side fallback
        return tostring(timestamp)
    end
end

-- Format date string from database to human readable (WORKS ON BOTH CLIENT AND SERVER)
function Utils.FormatReadableDate(dateStr, includeTime)
    -- Handle nil, empty, or invalid values
    if not dateStr then
        return 'N/A'
    end

    -- Convert to string first if it's not already
    if type(dateStr) ~= 'string' and type(dateStr) ~= 'number' then
        return 'N/A'
    end

    -- Check for invalid string values
    if type(dateStr) == 'string' and (dateStr == 'N/A' or dateStr == 'Not set' or dateStr == '' or dateStr == 'null' or dateStr == 'nil') then
        return 'N/A'
    end

    -- Handle numeric timestamps
    if type(dateStr) == 'number' then
        -- Convert milliseconds to seconds if needed (timestamps > 10 digits are in milliseconds)
        if dateStr > 10000000000 then
            dateStr = math.floor(dateStr / 1000)
        end

        -- Validate timestamp range (reject garbage values)
        -- After conversion, check if it's in a reasonable range
        if dateStr < 946684800 or dateStr > 2147483647 or dateStr < 0 then
            return 'N/A'
        end

        -- Server side: use os.date
        if IsDuplicityVersion() then
            dateStr = os.date('%Y-%m-%d %H:%M:%S', dateStr)
        else
            -- Client side: manual conversion
            local function UnixToDate(timestamp)
                local days = math.floor(timestamp / 86400)
                local remaining = timestamp % 86400
                local hour = math.floor(remaining / 3600)
                local min = math.floor((remaining % 3600) / 60)

                local year = 1970
                local daysInYear
                while true do
                    daysInYear = (year % 4 == 0 and (year % 100 ~= 0 or year % 400 == 0)) and 366 or 365
                    if days >= daysInYear then
                        days = days - daysInYear
                        year = year + 1
                    else
                        break
                    end
                end

                local daysInMonth = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
                if year % 4 == 0 and (year % 100 ~= 0 or year % 400 == 0) then
                    daysInMonth[2] = 29
                end

                local month = 1
                for i = 1, 12 do
                    if days >= daysInMonth[i] then
                        days = days - daysInMonth[i]
                        month = month + 1
                    else
                        break
                    end
                end

                return {year = year, month = month, day = days + 1, hour = hour, min = min}
            end

            local dt = UnixToDate(dateStr)
            local months = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"}

            if includeTime then
                local h = dt.hour
                local ampm = h >= 12 and "PM" or "AM"
                h = h % 12
                if h == 0 then h = 12 end
                return string.format("%s %d, %d at %d:%02d %s", months[dt.month], dt.day, dt.year, h, dt.min, ampm)
            else
                return string.format("%s %d, %d", months[dt.month], dt.day, dt.year)
            end
        end
    end

    -- Convert to string if not already (for non-numeric values)
    if type(dateStr) ~= 'string' then
        dateStr = tostring(dateStr)
    end

    -- Handle MySQL formatted dates (e.g., "Nov 26, 2025 at 14:30")
    local monthStr, day, year, hour, min = dateStr:match("(%a+)%s+(%d+),%s+(%d+)%s+at%s+(%d+):(%d+)")
    if monthStr and day and year and hour and min then
        -- Already in the format we want, just need to convert to 12-hour format
        local d, y, h, mi = tonumber(day), tonumber(year), tonumber(hour), tonumber(min)

        if y >= 1970 and y <= 2100 and d >= 1 and d <= 31 and h >= 0 and h <= 23 and mi >= 0 and mi <= 59 then
            if includeTime == nil or includeTime then
                local ampm = h >= 12 and "PM" or "AM"
                h = h % 12
                if h == 0 then h = 12 end
                return string.format("%s %d, %d at %d:%02d %s", monthStr, d, y, h, mi, ampm)
            else
                return string.format("%s %d, %d", monthStr, d, y)
            end
        end
    end

    -- Handle short date format (e.g., "Nov 26, 2025")
    monthStr, day, year = dateStr:match("(%a+)%s+(%d+),%s+(%d+)")
    if monthStr and day and year then
        local d, y = tonumber(day), tonumber(year)
        if y >= 1970 and y <= 2100 and d >= 1 and d <= 31 then
            return string.format("%s %d, %d", monthStr, d, y)
        end
    end

    -- Handle MySQL datetime format (YYYY-MM-DD HH:MM:SS)
    year, month, day, hour, min, sec = dateStr:match("(%d+)-(%d+)-(%d+)%s*(%d*):?(%d*):?(%d*)")

    if year and month and day then
        local y, m, d = tonumber(year), tonumber(month), tonumber(day)

        -- Validate date components
        if not (y >= 1970 and y <= 2100 and m >= 1 and m <= 12 and d >= 1 and d <= 31) then
            return 'N/A'
        end

        local months = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"}
        local monthName = months[m] or month

        -- If time components exist and includeTime is true, include them
        if (includeTime == nil or includeTime) and hour and hour ~= "" and min and min ~= "" then
            local h = tonumber(hour)
            local mi = tonumber(min)

            if h >= 0 and h <= 23 and mi >= 0 and mi <= 59 then
                local ampm = h >= 12 and "PM" or "AM"
                h = h % 12
                if h == 0 then h = 12 end
                return string.format("%s %d, %d at %d:%02d %s", monthName, d, y, h, mi, ampm)
            end
        end

        -- Date only
        return string.format("%s %d, %d", monthName, d, y)
    end

    -- If parsing failed, return N/A
    return 'N/A'
end

-- Format date string from database to short readable format (WORKS ON BOTH CLIENT AND SERVER)
function Utils.FormatShortDate(dateStr)
    return Utils.FormatReadableDate(dateStr, false)
end

-- Distance calculation
function Utils.GetDistance(coords1, coords2)
    if not coords1 or not coords2 then return 0 end
    local dx = coords1.x - coords2.x
    local dy = coords1.y - coords2.y
    local dz = coords1.z - coords2.z
    return math.sqrt(dx * dx + dy * dy + dz * dz)
end

-- Round number
function Utils.Round(num, numDecimalPlaces)
    local mult = 10 ^ (numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

-- Generate random string
function Utils.GenerateID(length)
    local charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local result = ""
    for i = 1, length do
        local rand = math.random(1, #charset)
        result = result .. string.sub(charset, rand, rand)
    end
    return result
end

-- Sanitize input
function Utils.Sanitize(str)
    if not str then return "" end
    return str:gsub("[<>\"']", "")
end

-- Parse JSON safely
function Utils.ParseJSON(str)
    local success, result = pcall(json.decode, str)
    if success then
        return result
    else
        return nil
    end
end

-- Encode JSON safely
function Utils.EncodeJSON(data)
    local success, result = pcall(json.encode, data)
    if success then
        return result
    else
        return "{}"
    end
end

return Utils
