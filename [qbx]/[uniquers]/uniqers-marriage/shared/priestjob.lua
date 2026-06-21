UniqersMarriage = UniqersMarriage or {}

UniqersMarriage.LastLevel = 10
UniqersMarriage.LastXP = 1000
UniqersMarriage.Levels = {
    [1] = {
        text = "1 Level",
        level = 1,
        xp = 100,
        money = 100
    },
    [2] = {
        text = "2 Level",
        level = 2,
        xp = 200,
        money = 200
    },
    [3] = {
        text = "3 Level",
        level = 3,
        xp = 300,
        money = 300
    },
    [4] = {
        text = "4 Level",
        level = 4,
        xp = 400,
        money = 400
    },
    [5] = {
        text = "5 Level",
        level = 5,
        xp = 500,
        money = 500
    },
    [6] = {
        text = "6 Level",
        level = 6,
        xp = 600,
        money = 600
    },
    [7] = {
        text = "7 Level",
        level = 7,
        xp = 700,
        money = 700
    },
    [8] = {
        text = "8 Level",
        level = 8,
        xp = 800,
        money = 800
    },
    [9] = {
        text = "9 Level",
        level = 9,
        xp = 900,
        money = 900
    },
    [10] = {
        text = "10 Level",
        level = 10,
        xp = 1000,
        money = 1000
    },
}
UniqersMarriage.JobsNames = { -- write job name send announce
    "police",
	"priest",
	-- "others", -- add more	
}
UniqersMarriage.JobsRequest = "no" -- If you set it to yes, the marriage request accepted by priest job. if "no" npc doing everything.
UniqersMarriage.CommandsJobs = "yes" -- priest jobs can use divorce and marriage command

UniqersMarriage.PermsVehicle = { -- Grade is key, don't add same vehicle in multiple grades. Higher rank can see lower
    [0] = {
        ['romero'] = 'Standart'
    }
}