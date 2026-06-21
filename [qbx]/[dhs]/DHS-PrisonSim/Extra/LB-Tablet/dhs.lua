if Config.JailScript ~= "DHS-PrisonSim" then
    return
end

---@param identifier string
---@param time integer The jail time in seconds
---@param reason string
---@param officerSource number
---@return boolean success
function JailPlayer(identifier, time, reason, officerSource)
    local minutes = math.floor(time / 60)
    print("Officer Source: " .. officerSource)
    exports["DHS-PrisonSim"]:OpenConvoyMenu(officerSource)
    return true
end

---@param identifier string
---@return boolean success
function UnjailPlayer(identifier)
    print("UnjailPlayer: " .. identifier)
    local source = GetSourceFromIdentifier(identifier)
    exports["DHS-PrisonSim"]:ReleaseFromPrison(source)
    return true
end

---@param identifier string
---@return integer remainingTime seconds
function GetRemainingPrisonSentence(identifier)
    local source = GetSourceFromIdentifier(identifier)
    local remainingTime = exports["DHS-PrisonSim"]:GetRemainingPrisonTime(source)
    print("Remaining Time: " .. remainingTime)
    return remainingTime * 60
end
