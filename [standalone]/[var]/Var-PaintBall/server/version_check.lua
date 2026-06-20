--[[
    Var Update Checker
    Checks for new versions on resource start.
    Do not modify this file.
]]

local function CompareVersions(current, latest)
    local function parse(v)
        local parts = {}
        for num in tostring(v):gmatch("(%d+)") do
            parts[#parts + 1] = tonumber(num)
        end
        while #parts < 3 do
            parts[#parts + 1] = 0
        end
        return parts
    end

    local c = parse(current)
    local l = parse(latest)

    for i = 1, 3 do
        if c[i] > l[i] then return true end
        if c[i] < l[i] then return false end
    end

    return true
end

CreateThread(function()
    Wait(2000)

    local resourceName = GetCurrentResourceName()
    local currentVersion = GetResourceMetadata(resourceName, 'version', 0)

    if not currentVersion or currentVersion == "" then
        print(("^3[%s]^0 ^1Version not set in fxmanifest.lua — cannot check for updates.^0"):format(resourceName))
        return
    end

    local url = "https://raw.githubusercontent.com/Skafir/Var-Update/main/versions.json"

    PerformHttpRequest(url, function(statusCode, response, headers)
        if not statusCode or statusCode ~= 200 then
            print(("^3[%s]^0 ^1Unable to check for updates (HTTP %s).^0"):format(resourceName, tostring(statusCode or "nil")))
            return
        end

        local ok, versions = pcall(json.decode, response)
        if not ok or type(versions) ~= "table" then
            print(("^3[%s]^0 ^1Failed to parse version data.^0"):format(resourceName))
            return
        end

        local latestVersion = versions[resourceName]
        if not latestVersion then
            return
        end

        if CompareVersions(currentVersion, latestVersion) then
            print(("^3[%s]^2 is up to date ^0(v%s)"):format(resourceName, currentVersion))
        else
            print(("^3[%s]^1 UPDATE AVAILABLE! ^0Current: ^1v%s^0 | Latest: ^2v%s^0"):format(resourceName, currentVersion, latestVersion))
            print(("^3[%s]^0 Download the latest version at ^5https://var-fivem.com/^0"):format(resourceName))
        end
    end, "GET", "", { ["Content-Type"] = "application/json" })
end)
