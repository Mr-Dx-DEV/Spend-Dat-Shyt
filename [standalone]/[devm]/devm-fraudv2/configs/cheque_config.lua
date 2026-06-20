chequeConfig = {}

chequeConfig.fullz = {
    { name="Aaron Patel", bankType="fleeca", accountNumber="731492805", transit="482915", bankBalance=354, price=0.0018 },
    { name="Jasmine Nguyen", bankType="maze", accountNumber="902174638", transit="661204", bankBalance=1200, price=0.0012 },
    { name="Tyler Morrison", bankType="fleeca", accountNumber="558203941", transit="310778", bankBalance=742, price=0.0032 },
    { name="Leila Haddad", bankType="maze", accountNumber="114982376", transit="905441", bankBalance=960, price=0.0009 },
    { name="Brandon Cole", bankType="fleeca", accountNumber="667340912", transit="224819", bankBalance=1200, price=0.0024 },
    { name="Natalia Petrova", bankType="maze", accountNumber="390118742", transit="771305", bankBalance=1200, price=0.0056 },
    { name="Omar Khalil", bankType="fleeca", accountNumber="845920163", transit="119402", bankBalance=1200, price=0.0013 },
    { name="Kevin O'Shea", bankType="maze", accountNumber="273849501", transit="680994", bankBalance=1200, price=0.0021 },
    { name="Priya Desai", bankType="fleeca", accountNumber="598771204", transit="347820", bankBalance=865, price=0.0008 },
    { name="Lucas Romero", bankType="maze", accountNumber="901246583", transit="552188", bankBalance=1200, price=0.0030 },

    { name="Ethan Brooks", bankType="fleeca", accountNumber="440928173", transit="209441", bankBalance=1200, price=0.0010 },
    { name="Sofia Alvarez", bankType="maze", accountNumber="783401955", transit="882104", bankBalance=1200, price=0.0026 },
    { name="Daniel Cho", bankType="fleeca", accountNumber="219573844", transit="441220", bankBalance=975, price=0.0009 },
    { name="Maya Singh", bankType="maze", accountNumber="662198305", transit="730981", bankBalance=1200, price=0.0037 },
    { name="Jordan Wells", bankType="fleeca", accountNumber="904771266", transit="118374", bankBalance=1200, price=0.0016 },
    { name="Hassan Mahmoud", bankType="maze", accountNumber="381640927", transit="902115", bankBalance=1200, price=0.0052 },
    { name="Nicole Bennett", bankType="fleeca", accountNumber="550219384", transit="339002", bankBalance=1745, price=0.0011 },
    { name="Andre Dupont", bankType="maze", accountNumber="798401266", transit="441987", bankBalance=1200, price=0.0023 },
    { name="Yusuf Rahman", bankType="fleeca", accountNumber="640928551", transit="770144", bankBalance=1200, price=0.0017 },
    { name="Isabella Conti", bankType="maze", accountNumber="221804976", transit="665930", bankBalance=1200, price=0.0040 },

    { name="Marcus Reed", bankType="fleeca", accountNumber="492810673", transit="118900", bankBalance=1200, price=0.0020 },
    { name="Hannah Klein", bankType="maze", accountNumber="875492301", transit="550881", bankBalance=1200, price=0.0046 },
    { name="Diego Morales", bankType="fleeca", accountNumber="306598172", transit="229874", bankBalance=1200, price=0.0012 },
    { name="Aisha Noor", bankType="maze", accountNumber="914607283", transit="778311", bankBalance=1200, price=0.0031 },
    { name="Ryan McAllister", bankType="fleeca", accountNumber="581902466", transit="440102", bankBalance=1200, price=0.0014 },
    { name="Elena Kovacs", bankType="maze", accountNumber="720449815", transit="911304", bankBalance=1200, price=0.0051 },
    { name="Noah Feldman", bankType="fleeca", accountNumber="833017492", transit="665441", bankBalance=1200, price=0.0010 },
    { name="Camila Rojas", bankType="maze", accountNumber="291674803", transit="338907", bankBalance=1200, price=0.0033 },
    { name="Samir Aziz", bankType="fleeca", accountNumber="460998271", transit="210556", bankBalance=1200, price=0.0013 },
    { name="Connor Blake", bankType="maze", accountNumber="904662118", transit="779420", bankBalance=1200, price=0.0038 },

    { name="Lena Fischer", bankType="fleeca", accountNumber="318590774", transit="551903", bankBalance=1120, price=0.0009 },
    { name="Adrian Popescu", bankType="maze", accountNumber="772401958", transit="900144", bankBalance=1200, price=0.0059 },
    { name="Tariq Suleiman", bankType="fleeca", accountNumber="609442813", transit="441677", bankBalance=1200, price=0.0016 },
    { name="Vanessa Cruz", bankType="maze", accountNumber="845920664", transit="227810", bankBalance=1200, price=0.0042 },
    { name="Julian Park", bankType="fleeca", accountNumber="552908174", transit="118330", bankBalance=1200, price=0.0011 },
    { name="Monique Laurent", bankType="maze", accountNumber="391772048", transit="660291", bankBalance=1200, price=0.0048 },
    { name="Ibrahim Saleh", bankType="fleeca", accountNumber="804219673", transit="339441", bankBalance=1200, price=0.0022 },
    { name="Trevor Knight", bankType="maze", accountNumber="260998471", transit="772990", bankBalance=1200, price=0.0019 },
    { name="Nina Volkov", bankType="fleeca", accountNumber="714830299", transit="441550", bankBalance=1200, price=0.0041 },
    { name="Paul Henderson", bankType="maze", accountNumber="998420173", transit="880104", bankBalance=1200, price=0.0065 }
}

-- 🏦 Bank Teller Locations for Cheque Cashing
chequeConfig.bankLocations = {
    -- Fleeca Banks
    {
        label = "Fleeca Bank - Downtown",
        bankType = "fleeca",
        coords = vector4(312.3408, -279.9170, 53.1647, 338.6078),
        model = "a_m_m_business_01"
    },
    {
        label = "Fleeca Bank - Legion Square",
        bankType = "fleeca",
        coords = vector4(147.8850, -1041.5505, 28.3679, 341.1291),
        model = "a_m_m_business_01"
    },
    {
        label = "Fleeca Bank - Rockford Hills",
        bankType = "fleeca",
        coords = vector4(-1213.4393, -332.7651, 37.7808 - 1, 28.1900 ),
        model = "a_m_m_business_01"
    },

    {
        label = "Fleeca Bank - Great Ocean Highway",
        bankType = "fleeca",
        coords = vector4(-2961.1624, 481.2957, 15.6969 - 1, 88.7032),
        model = "a_m_m_business_01"
    },
    {
        label = "Fleeca Bank - Burton",
        bankType = "fleeca",
        coords = vector4(-352.8862, -50.8130, 49.0364 - 1, 346.3839 ),
        model = "a_m_m_business_01"
    },

    {
        label = "Fleeca Bank - G.S Desert",
        bankType = "fleeca",
        coords = vector4(1176.6268, 2708.2554, 37.0879, 184.9043),
        model = "a_m_m_business_01"
    },

        -- Maze Banks
    {
        label = "Maze Bank - Vinewood",
        bankType = "maze",
        coords = vector4(252.2225, 223.1465, 105.2868, 159.0535),
        model = "a_m_m_business_01"
    }
}

-- Cheque bounce chance (0-100, where 100 = always bounce)
chequeConfig.chequeBouncechance = 75
