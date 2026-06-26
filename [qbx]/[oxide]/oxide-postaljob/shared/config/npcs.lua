Config.NpcModel = 's_m_m_postal_01'
Config.NpcScenario = 'WORLD_HUMAN_CLIPBOARD'

Config.Blip = {
    sprite = 478,
    color = 5,
    scale = 0.5,
    label = 'blip.gopostal_office',
}

Config.CustomerPeds = {
    'a_m_y_hipster_01',
    'a_m_y_hipster_02',
    'a_m_y_hipster_03',
    'a_f_y_hipster_01',
    'a_f_y_hipster_02',
    'a_f_y_hipster_03',
    'a_m_m_business_01',
    'a_f_y_business_01',
    's_m_m_postal_02',
    'a_m_y_business_02',
}

Config.CustomerReactions = {
    good = {
        walkSpeed = 1.0,
        reactionDict = 'mp_common',
        reactionAnim = 'givetake1_a',
        message = nil,
    },
    poor = {
        walkSpeed = 0.8,
        reactionDict = 'gestures@m@standing@casual',
        reactionAnim = 'gesture_no_way',
        message = 'notify.customer_took_long',
    },
}
