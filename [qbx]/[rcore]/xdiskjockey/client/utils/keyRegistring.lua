--- Will register key action
--- @param fc function
--- @param uniqid string
--- @param description string
--- @param key string
--- @param inputDevice string
function RegisterKey(fc, uniqid, description, key, inputDevice)
    if inputDevice == nil then
        inputDevice = "keyboard"
    end
    RegisterCommand(uniqid .. key, fc, false)
    RegisterKeyMapping(uniqid .. key, description, inputDevice, key)
end