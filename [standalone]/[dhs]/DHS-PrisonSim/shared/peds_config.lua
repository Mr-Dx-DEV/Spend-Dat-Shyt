Config.Peds = {}

if Config.MLOSelection == 'prompt-prison' then
    Config.Peds.PrisonPeds = {
        -- Doctor
        {
            model = "s_m_m_doctor_01",
            coords = vector4(1759.58, 2573.75, 45.0, 270.19),
            type = "doctor"
        },
        -- Prisoner Release
        {
            model = "s_m_m_prisguard_01",
            coords = vector4(1780.8, 2554.76, 44.78, 180.05),
            type = "prisonerRelease"
        },

        {
            model = "s_m_m_prisguard_01",
            coords = vector4(1687.38, 2588.26, 44.92, 267.48),
            type = "prisonerRegistry"
        }
    }
elseif Config.MLOSelection == 'molo-alcatraz' then
    Config.Peds.PrisonPeds = {
        -- Doctor
        {
            model = "s_m_m_doctor_01",
            coords = vector4(4032.24, -8.95, 17.79, 358.15),
            type = "doctor"
        },
        -- Prisoner Release
        {
            model = "s_m_m_prisguard_01",
            coords = vector4(3926.43, -15.7, 9.74, 358.03),
            type = "prisonerRelease"
        },

        {
            model = "s_m_m_prisguard_01",
            coords = vector4(3865.28, -18.49, 5.71, 183.39),
            type = "prisonerRegistry"
        }
    }

elseif Config.MLOSelection == 'gabz-prison' then
    Config.Peds.PrisonPeds = {
        -- Doctor
        {
            model = "s_m_m_doctor_01",
            coords = vector4(1769.85, 2571.78, 44.73, 131.42),
            type = "doctor"
        },
        -- Prisoner Release
        {
            model = "s_m_m_prisguard_01",
            coords = vector4(1830.98, 2595.71, 45.01, 85.1),
            type = "prisonerRelease"
        },

        {
            model = "s_m_m_prisguard_01",
            coords = vector4(1839.49, 2595.61, 45.01, 178.13),
            type = "prisonerRegistry"
        }
    }
elseif Config.MLOSelection == 'custom' then
    -- Open a Ticket So I can help you with your custom prison
end
