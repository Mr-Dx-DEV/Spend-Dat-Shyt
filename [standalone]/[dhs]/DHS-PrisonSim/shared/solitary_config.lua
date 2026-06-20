SolitaryConfig = {}

if Config.MLOSelection == 'prompt-prison' then
    SolitaryConfig.SolitaryFreedomCoords = vector4(1636.37, 2565.56, 45.56, 184.62)

    SolitaryConfig.PunishmentTimes = {
        ["TriggeringLockdown"] = 10,
    }

    SolitaryConfig.SolitaryCells = {
        {coords = vector4(1638.83, 2579.24, 45.61, 179.37), taken = false},
        {coords = vector4(1641.45, 2578.75, 45.61, 179.97), taken = false},
        {coords = vector4(1641.45, 2578.75, 45.61, 179.97), taken = false},
        {coords = vector4(1645.8, 2579.0, 45.61, 175.48), taken = false},
        {coords = vector4(1648.44, 2579.01, 45.61, 176.82), taken = false},
        {coords = vector4(1651.05, 2579.14, 45.61, 180.27), taken = false},
        {coords = vector4(1653.43, 2578.86, 45.61, 175.24), taken = false},
        {coords = vector4(1656.07, 2579.0, 45.61, 175.89), taken = false}
    }

    SolitaryConfig.SolitaryYards = {
        vector4(1650.87, 2573.98, 45.56, 178.5),
        vector4(1638.99, 2571.47, 45.56, 267.54),
        vector4(1632.98, 2571.37, 45.56, 87.81)
    }
elseif Config.MLOSelection == 'molo-alcatraz' then
    SolitaryConfig.SolitaryFreedomCoords = vector4(3910.12, 25.51, 23.89, 79.44)

    SolitaryConfig.PunishmentTimes = {
        ["TriggeringLockdown"] = 10,
    }

    SolitaryConfig.SolitaryCells = {
        {model = 'djs_cellblock_01', coords = vector4(4071.57, 16.3, 17.76, 226.35), taken = false},
        {model = 'djs_cellblock_01', coords = vector4(4074.57, 19.25, 17.76, 226.35), taken = false},
        {model = 'djs_cellblock_01', coords = vector4(4077.13, 21.93, 17.76, 222.43), taken = false},
        {model = 'djs_cellblock_01', coords = vector4(4080.18, 24.9, 17.76, 223.47), taken = false},
        {model = 'djs_cellblock_01', coords = vector4(4083.04, 27.99, 17.76, 223.47), taken = false},
    }
elseif Config.MLOSelection == 'gabz-prison' then
    SolitaryConfig.SolitaryFreedomCoords = vector4(1699.58, 2546.06, 45.56, 271.62)

    SolitaryConfig.PunishmentTimes = {
        ["TriggeringLockdown"] = 10,
    }

    SolitaryConfig.SolitaryCells = {
        {model = 'djs_cellblock_01', coords = vector4(1689.46, 2542.62, 44.56, 87.04), taken = false},
        {model = 'djs_cellblock_01', coords = vector4(1689.70, 2545.95, 44.56, 87.04), taken = false},
        {model = 'djs_cellblock_01', coords = vector4(1694.5, 2554.71, 44.56, 358.27), taken = false},
    }
elseif Config.MLOSelection == 'custom' then
    -- Open a Ticket So I can help you with your custom prison
end
