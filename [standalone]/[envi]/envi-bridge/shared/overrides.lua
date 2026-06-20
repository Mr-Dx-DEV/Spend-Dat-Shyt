if IsDuplicityVersion() then
    Framework.PlayerOverrides = {}

    Framework.Override = function(name, cb, scope)
        if scope == "player" then
            Framework.PlayerOverrides[name] = cb
            return
        end

        Framework[name] = cb
    end
else
    Framework.Override = function(name, cb)
        Framework[name] = cb
    end
end