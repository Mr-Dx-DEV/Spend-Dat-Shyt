-- MIT License
-- fs-doj Framework Loader
-- Automatically detects and loads the appropriate framework adapter

Framework = {}
FrameworkName = nil

function Framework.Detect()
    if Config.Framework ~= 'auto' then
        FrameworkName = Config.Framework
        print("^3[fs-doj] Framework manually set to: " .. FrameworkName .. "^0")
        return FrameworkName
    end

    -- Auto-detect framework
    if GetResourceState('es_extended') == 'started' or GetResourceState('es_extended') == 'starting' then
        FrameworkName = 'esx'
    elseif GetResourceState('qbx_core') == 'started' or GetResourceState('qbx_core') == 'starting' then
        FrameworkName = 'qbox'
    elseif GetResourceState('qb-core') == 'started' or GetResourceState('qb-core') == 'starting' then
        FrameworkName = 'qb'
    else
        print("^1[fs-doj] ERROR: No supported framework detected!^0")
        print("^1[fs-doj] Please install ESX, QBCore, or QBox^0")
        return nil
    end

    print("^2[fs-doj] Framework auto-detected: " .. FrameworkName .. "^0")
    return FrameworkName
end

-- Map framework names to adapter filenames
local adapterFileMap = {
    ['qb'] = 'qbcore',
    ['esx'] = 'esx',
    ['qbox'] = 'qbox'
}

function Framework.Load()
    local fw = Framework.Detect()
    if not fw then
        return false
    end

    if IsDuplicityVersion() then
        -- Server-side
        local adapterFile = adapterFileMap[fw] or fw
        local adapterPath = ('adapters/framework/%s.lua'):format(adapterFile)
        local adapter = LoadResourceFile(GetCurrentResourceName(), adapterPath)
        if adapter then
            local func, err = load(adapter)
            if func then
                Framework = func()
                print("^2[fs-doj] Framework adapter loaded: " .. fw .. "^0")
                return true
            else
                print("^1[fs-doj] Error loading framework adapter: " .. err .. "^0")
                return false
            end
        else
            print("^1[fs-doj] Framework adapter file not found: " .. adapterPath .. "^0")
            return false
        end
    end

    return true
end

return Framework
