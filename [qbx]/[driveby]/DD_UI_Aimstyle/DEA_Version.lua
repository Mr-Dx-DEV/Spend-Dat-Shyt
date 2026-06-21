DEA_RESOURCE_NAME = GetCurrentResourceName()

function PrintDEAStartupBanner()
    local installedVersion = GetResourceMetadata(DEA_RESOURCE_NAME, "version", 0) or "unknown"

    print(("^2[%s]^7 Delta Enhanced Aimstyles UI v%s"):format(DEA_RESOURCE_NAME, installedVersion))
end

function ValidateDEADependencies()
    local endaState = GetResourceState("ENDA")

    if endaState ~= "started" then
        print(("^3[%s]^7 ENDA is not started (state: ^1%s^7). Driveby style changes will not apply until ENDA is running."):format(
            DEA_RESOURCE_NAME,
            endaState
        ))
        return
    end

    local endaVersion = GetResourceMetadata("ENDA", "version", 0) or "unknown"
    print(("^2[%s]^7 Linked to ENDA v%s"):format(DEA_RESOURCE_NAME, endaVersion))
end

CreateThread(function()
    Wait(1000)
    PrintDEAStartupBanner()
    ValidateDEADependencies()
end)
