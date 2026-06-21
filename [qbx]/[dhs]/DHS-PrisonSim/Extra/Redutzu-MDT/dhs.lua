if Config.Prison ~= 'DHS-PrisonSim' then
    return
end

function JailOfflinePlayer(identifier, amount)
    -- Implement your own code
end

function JailPlayer(identifier, amount, sender, reason)
    exports["DHS-PrisonSim"]:OpenConvoyMenu(sender)
end