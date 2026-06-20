function GetPlayerRealName(playerId)
    local p = ESX.GetPlayerFromId(playerId)
    local name = nil
   
    if p then
        name = p.getName()
    end

    if not name then
        name = GetPlayerName(playerId)
    end

    return name
end

function AppendLineInFile(fileName, line)
    local res = GetCurrentResourceName()
    local base = GetResourcePath(res)
    local path = ("%s/%s"):format(base, fileName)

    local f, err = io.open(path, "a")
    if not f then
        print(("Casino Log: can't open %s: %s"):format(path, err or "unknown"))
        return false
    end

    f:write(line, "\n")
    f:close()
    return true
end