ENDA_RESOURCE_NAME = GetCurrentResourceName()

function ParseSemanticVersion(versionString)
    if versionString == nil or versionString == "" then
        return nil
    end

    versionString = versionString:gsub("^v", "")
    local major, minor, patch = versionString:match("^(%d+)%.(%d+)%.(%d+)$")

    if major == nil then
        return nil
    end

    return {
        major = tonumber(major),
        minor = tonumber(minor),
        patch = tonumber(patch),
        raw = versionString,
    }
end

function CompareSemanticVersions(leftVersion, rightVersion)
    if leftVersion.major ~= rightVersion.major then
        return leftVersion.major - rightVersion.major
    end

    if leftVersion.minor ~= rightVersion.minor then
        return leftVersion.minor - rightVersion.minor
    end

    return leftVersion.patch - rightVersion.patch
end

function PrintENDADependencyStatus(dependencyResource, label)
    local dependencyState = GetResourceState(dependencyResource)

    if dependencyState ~= "started" then
        print(("^3[%s]^7 %s (%s) state: ^1%s^7"):format(
            ENDA_RESOURCE_NAME,
            label,
            dependencyResource,
            dependencyState
        ))
        return false
    end

    return true
end

function RunENDAStartupVersionCheck()
    local installedVersion = GetResourceMetadata(ENDA_RESOURCE_NAME, "version", 0) or "unknown"

    print(("^2[%s]^7 Enhanced Native Driveby Animations v%s"):format(ENDA_RESOURCE_NAME, installedVersion))

    PrintENDADependencyStatus("DD_UI_Aimstyle", "Aimstyle UI")
    PrintENDADependencyStatus("ENDA_01", "Animation pack 01")

    local deaVersion = GetResourceMetadata("DD_UI_Aimstyle", "version", 0)
    local parsedEndaVersion = ParseSemanticVersion(installedVersion)
    local parsedDeaVersion = ParseSemanticVersion(deaVersion)

    if parsedEndaVersion ~= nil and parsedDeaVersion ~= nil then
        if CompareSemanticVersions(parsedDeaVersion, parsedEndaVersion) > 0 then
            print(("^3[%s]^7 DD_UI_Aimstyle v%s is newer than ENDA v%s. Update ENDA if you notice UI issues."):format(
                ENDA_RESOURCE_NAME,
                deaVersion,
                installedVersion
            ))
        end
    end
end

CreateThread(function()
    Wait(1000)
    RunENDAStartupVersionCheck()
end)
