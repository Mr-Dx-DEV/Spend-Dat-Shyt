UniqersInvest = {}
UniqersInvest.DatabaseSelect = "oxmysql" --change your mysql service oxmysql or mysql-async or ghmattimysql
UniqersInvest.Framework = "qbcore" -- "qbcore" or "esx" or "qbus" or "oldesx" - if you need custom framework contact us  https://discord.gg/MyrGhbf9tM
UniqersInvest.CoreName = "QBCore" -- for qbcore = "QBCore", for qbus = "QBCore", for esx = "ESX", forold esx = "ESX", for qbcore or esx variation like ASDCore, Blabla core = "BLABLACore",
UniqersInvest.CoreName2 = "qb-core" -- for qbcore = "qb-core", for qbus = "QBCore:GetObject", for esx = "es_extended", forold esx = "esx:getSharedObject", for qbcore or esx variation like ASDCore, Blabla core = "blabla-core",
UniqersInvest.DayTimeInvest = 1 -- Day time investment day 1
UniqersInvest.LongTimeInvest = 38 -- Long time investment day 38
UniqersInvest.IngameComandName = "investments" -- open menu command
UniqersInvest.Showminihud = "showinvest" -- showing invest mini hud command
UniqersInvest.Offminihud = "offinvest" -- off invest mini hud command
UniqersInvest.EditUiCommand = "edituiinvest" -- hide mini hud
UniqersInvest.ResetUiCommand = "resetuiinvest" -- hide mini hud
UniqersInvest.Adversting = false -- for adversting investment for server players true or false -- AVAIBLE AT NEXT UPDATE DO NOT CHANGE!
UniqersInvest.AdverstingHours = 1 -- hours for adversting investment for server players
UniqersInvest.PayAcoountType = "bank" -- effected functions - addmoney - removemoney - getmoney - This means that when you complete your investment, which account should the payment be made to? "bank" or "cash" or "black_money" etc. Write whatever your own framework supports or whatever you want, for example, those using the qs-inventory item can write "money".

UniqersInvest.Translate = {
    done = "DONE",
	editmodeon = "EDIT MODE ACTIVE!",
	keybindsrotate = "Press UP - DOWN- LEFT- RIGHT key for change position ui wedding.",
	saveposition = "Press ENTER key for save position ui wedding.",
	defaultposition = "/resetuiinvest command for reset ui wedding position",
    againstart = "START THE GAME",
	againoffer = "THE OFFER IS VALID 182 HOURS",
	againtext = "PLAY BACK NOW",
	againreceive = "and receive",
    free1 = "FREE",
	daytime = "DAYTIME",
	longtime = "LONG-TERM",
    cancelinvest = "CANCEL",
	nocancelinvest = "NO",
	acceptbutton = "ACCEPT",
    duration = "DURATION",
	remaining = "REMAINING",
	profitleft = "To get profit left:",
    investpaid = "INVEST PAID.",
    error = "You don't have money to pay investment coast.",
	lockednotify = "Cancel other invest first",
	cancelled = "Invest has been cancelled",
	invested = "You have invested successfully.",
    cost = "COST",
    profit = "PROFIT",	
	invest = "INVEST",
    lock = "INVEST",
    investcost = "INVEST COST PRICE",
    payinvest = "PAY INVEST",
	beforereceive = "BEFORE RECEIVING",
	back1 = "To the choice of investments",
	onetext = "INVEST",
	twotext = "MENTS",
	from1 = "FROM 1 DAY TO 100 DAYS",
	starttheinvesttext = "This is the cost required to invest <div class='paymuch'>$10000</div> When you fill the period, you will receive the investment <div class='investmuch'>$10000</div>",
	investmentstext = "INVESTMENTS",
	cancelsuretext = "Do you really want to cancel this investments? All your current progress wil be reset.",
	hourstext = "HOURS",
	hours = "", -- If you leave it blank it looks like this. 03:25 If you fill it looks like this. > the text you filled out Let's say you wrote hours and minutes > 03hour:23:minutes. or you wrote h and m. > 03h:23:m
	minutes = "", -- -- If you leave it blank it looks like this. 03:25 If you fill it looks like this. > the text you filled out Let's say you wrote hours and minutes > 03hour:23:minutes. or you wrote h and m. > 03h:23:m
}

UniqersInvest.DayTime = {
    {
        investid = 1,
		investtype = "daytime",
        name = "Investment #1",
        description = "This investment will bring you $10,000 net profit in 1 hour within 1 day.",
        reward = 10000,
        investcosts = 0,
        reqplaytime = 60, -- MINUTES
        image = "./images/avatar0.png",
    },
    {
        investid = 2,
		investtype = "daytime",		
        name = "Investment #2",
        description = "This investment will bring you $25,000 net profit in 2 hour within 1 day.",
        reward = 25000,
        investcosts = 0,
        reqplaytime = 120, -- MINUTES
        image = "./images/avatar1.png",
    },
    {
        investid = 3,
		investtype = "daytime",		
        name = "Investment #3",
        description = "This investment will bring you $40,000 net profit in 3 hour within 1 day.",
        reward = 40000,
        investcosts = 0,
        reqplaytime = 180, -- MINUTES
        image = "./images/avatar2.png",
    },
    {
        investid = 4,
		investtype = "daytime",		
        name = "Investment #4",
        description = "This investment will bring you $55,000 net profit in 4 hour within 1 day.",
        reward = 55000,
        investcosts = 0,
        reqplaytime = 240, -- MINUTES
        image = "./images/avatar3.png",
    },
    {
        investid = 5,
		investtype = "daytime",		
        name = "Investment #5",
        description = "This investment will bring you $60,000 net profit in 5 hour within 1 day.",
        reward = 60000,
        investcosts = 0,
        reqplaytime = 300, -- MINUTES
        image = "./images/avatar4.png",
    },
    {
        investid = 6,
		investtype = "daytime",		
        name = "Investment #6",
        description = "This investment will bring you $70,000 net profit in 6 hour within 1 day.",
        reward = 70000,
        investcosts = 0,
        reqplaytime = 360, -- MINUTES
        image = "./images/avatar6.png",
    },
    {
        investid = 7,
		investtype = "daytime",		
        name = "Investment #7",
        description = "This investment will bring you $80,000 net profit in 7 hour within 1 day.",
        reward = 80000,
        investcosts = 0,
        reqplaytime = 420, -- MINUTES
        image = "./images/avatar7.png",
    },
    {
        investid = 8,
		investtype = "daytime",		
        name = "Investment #8",
        description = "This investment will bring you $90,000 net profit in 8 hour within 1 day.",
        reward = 90000,
        investcosts = 0,
        reqplaytime = 480, -- MINUTES
        image = "./images/avatar8.png",
    },
    {
        investid = 9,
		investtype = "daytime",		
        name = "Investment #9",
        description = "This investment will bring you $100,000 net profit in 9 hour within 1 day.",
        reward = 100000,
        investcosts = 0,
        reqplaytime = 540, -- MINUTES
        image = "./images/avatar9.png",
    },
}

UniqersInvest.LongTime = {
    {
        investid = 10,
		investtype = "longtime",		
        name = "Investment #1",
        description = "You invest $100,000 and in 100 hours you get your money back and an additional $100,000",
        reward = 200000,
        investcosts = 100000,
        reqplaytime = 6000, -- MINUTES
        image = "./images/avatar9.png",
    },
    {
        investid = 11,
		investtype = "longtime",		
        name = "Investment #2",
        description = "You invest $250,000 and in 200 hours you get your money back and an additional $200,000.",
        reward = 450000,
        investcosts = 200000,
        reqplaytime = 12000, -- MINUTES
        image = "./images/avatar10.png",
    },
    {
        investid = 12,
		investtype = "longtime",		
        name = "Investment #3",
        description = "You invest $300,000 and in 300 hours you get your money back and an additional $300,000.",
        reward = 600000,
        investcosts = 300000,
        reqplaytime = 18000, -- MINUTES
        image = "./images/avatar11.png",
    },
    {
        investid = 13,
		investtype = "longtime",		
        name = "Investment #4",
        description = "You invest $400,000 and in 400 hours you get your money back and an additional $400,000.",
        reward = 800000,
        investcosts = 400000,
        reqplaytime = 24000, -- MINUTES
        image = "./images/avatar12.png",
    },
    {
        investid = 14,
		investtype = "longtime",		
        name = "Investment #5",
        description = "You invest $500,000 and in 300 hours you get your money back and an additional $500,000.",
        reward = 1000000,
        investcosts = 500000,
        reqplaytime = 30000, -- MINUTES
        image = "./images/avatar13.png",
    },
    {
        investid = 15,
		investtype = "longtime",		
        name = "Investment #6",
        description = "You invest $600,000 and in 600 hours you get your money back and an additional $600,000.",
        reward = 1200000,
        investcosts = 600000,
        reqplaytime = 36000, -- MINUTES
        image = "./images/avatar14.png",
    },
    {
        investid = 16,
		investtype = "longtime",		
        name = "Investment #7",
        description = "You invest $700,000 and in 700 hours you get your money back and an additional $700,000.",
        reward = 1400000,
        investcosts = 700000,
        reqplaytime = 42000, -- MINUTES
        image = "./images/avatar15.png",
    },
    {
        investid = 17,
		investtype = "longtime",		
        name = "Investment #8",
        description = "You invest $800,000 and in 800 hours you get your money back and an additional $800,000.",
        reward = 1600000,
        investcosts = 800000,
        reqplaytime = 48000, -- MINUTES
        image = "./images/avatar16.png",
    },
    {
        investid = 18,
		investtype = "longtime",		
        name = "Investment #9",
        description = "You invest $900,000 and in 900 hours you get your money back and an additional $1,100.000",
        reward = 2000000,
        investcosts = 900000,
        reqplaytime = 54000, -- MINUTES
        image = "./images/avatar17.png",
    },
}


UniqersInvest.Database = function(plugin,type,query,var)
    local wait = promise.new()
    if type == 'fetchAll' and plugin == 'mysql-async' then
        MySQL.Async.fetchAll(query, var, function(result)
            wait:resolve(result)
        end)
    end
    if type == 'execute' and plugin == 'mysql-async' then
        MySQL.Async.execute(query, var, function(result)
            wait:resolve(result)
        end)
    end
    if type == 'execute' and plugin == 'ghmattimysql' then
        exports['ghmattimysql']:execute(query, var, function(result)
            wait:resolve(result)
        end)
    end
    if type == 'fetchAll' and plugin == 'ghmattimysql' then
        exports.ghmattimysql:execute(query, var, function(result)
            wait:resolve(result)
        end)
    end
    if type == 'execute' and plugin == 'oxmysql' then
        exports.oxmysql:query(query, var, function(result)
            wait:resolve(result)
        end)
    end
    if type == 'fetchAll' and plugin == 'oxmysql' then
        exports.oxmysql:query(query, var, function(result)
            wait:resolve(result)
        end)
    end
    return Citizen.Await(wait)
end