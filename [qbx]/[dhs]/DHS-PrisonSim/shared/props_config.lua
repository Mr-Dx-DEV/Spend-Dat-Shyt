PropsConfig = {}

if Config.MLOSelection == 'prompt-prison' then
    PropsConfig.GateControlPanel = {
        coords = vector3(1826.31, 2573.75, 44.67),
        size = vec3(40, 40, 4.0),
        rotation = 90.0,
        model = "tr_prop_tr_elecbox_01a", -- DO NOT CHANGE THIS MODEL
    }
elseif Config.MLOSelection == 'molo-alcatraz' then

elseif Config.MLOSelection == 'gabz-prison' then
    PropsConfig.GateControlPanel = {
        coords = vector3(1826.31, 2573.75, 44.67),
        size = vec3(40, 40, 4.0),
        rotation = 90.0,
        model = "tr_prop_tr_elecbox_01a", -- DO NOT CHANGE THIS MODEL
    }
elseif Config.MLOSelection == 'custom' then
    -- Open a Ticket So I can help you with your custom prison
end
