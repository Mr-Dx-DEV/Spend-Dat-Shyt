Controls.Disable = function(controls)
    exports[Bridge.Name].Controls(nil, 'Disable', controls)
end

Controls.DisableAll = function()
    exports[Bridge.Name].Controls(nil, 'DisableAll')
end

Controls.Enable = function(controls)
    exports[Bridge.Name].Controls(nil, 'Enable', controls)
end

Controls.EnableAll = function()
    exports[Bridge.Name].Controls(nil, 'EnableAll')
end

Controls.Disable = function(controls)
    exports[Bridge.Name].Controls(nil, 'Disable', controls)
end

Controls.DisableFrontend = function()
    exports[Bridge.Name].Controls(nil, 'DisableFrontend')
end

Controls.EnableFrontend = function()
    exports[Bridge.Name].Controls(nil, 'EnableFrontend')
end
