Config = {}

Config.Debug = false
Config.PhoneItem = 'date_phone'
Config.UseTarget = true
Config.BlackoutDuration = 10000
Config.BookingDuration = 5000
Config.MinDistanceToNpc = 2.0
Config.CooldownSeconds = 180

Config.Access = {
    enabled = true,
    allowedSex = 'female', -- 'female', 'male', 'any'
    deniedMessage = 'Only female players can use this phone.',
    detection = 'auto' -- 'auto', 'statebag', 'qbx', 'qb', 'esx', 'ped'
}

Config.DirtyMoneyItem = 'pink_dirty_money'
Config.DirtyMoneyLabel = 'pink dirty money'
Config.CleanMoneyItem = 'money'
Config.CleanMoneyLabel = 'cash'

Config.Payout = {
    min = 500,
    max = 5500
}

Config.Pickups = {
    vec4(-562.4595, 294.5630, 87.2586, 340.4418),
    vec4(-552.3176, 500.6799, 103.8770, 74.3091),
    vec4(-745.1307, 817.5646, 213.1473, 253.4161),
    vec4(-1044.2864, 204.4288, 62.2865, 191.0495),
    vec4(-936.6697, 124.6010, 56.5607, 55.4841),
    vec4(-116.6356, -373.3667, 37.6708, 53.0173)
}

Config.Contacts = {
    {
        id = 'mason',
        label = 'Mason',
        description = 'Hills meetup',
        model = 'a_m_y_business_01',
        pickup = 1
    },
    {
        id = 'jordan',
        label = 'Jordan',
        description = 'Vinewood meetup',
        model = 'a_m_y_business_02',
        pickup = 2
    },
    {
        id = 'tyler',
        label = 'Tyler',
        description = 'Estate meetup',
        model = 'a_m_m_business_01',
        pickup = 3
    },
    {
        id = 'dylan',
        label = 'Dylan',
        description = 'Westside meetup',
        model = 'a_m_y_beachvesp_01',
        pickup = 4
    },
    {
        id = 'blake',
        label = 'Blake',
        description = 'Morningwood meetup',
        model = 'a_m_y_genstreet_01',
        pickup = 5
    },
    {
        id = 'logan',
        label = 'Logan',
        description = 'Downtown meetup',
        model = 'a_m_y_ktown_01',
        pickup = 6
    }
}

Config.TargetIcon = 'fa-solid fa-heart'
Config.TargetLabel = 'Start booked date'

Config.Wash = {
    enabled = true,
    ped = {
        model = 'g_m_m_armboss_01',
        coords = vec4(462.3789, -1701.3434, 29.0734, 303.5310),
        scenario = 'WORLD_HUMAN_CLIPBOARD'
    },
    target = {
        icon = 'fa-solid fa-money-bill-transfer',
        label = 'Wash pink dirty money',
        radius = 2.0
    },
    durationPerUnit = 2,
    minAmount = 100,
    maxAmount = 1000000,
    rate = 0.70
}
